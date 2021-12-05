EMAIL = "to.karwowski@gmail.com"

# resolve localhost to 0.0.0.0
sudo echo "0.0.0.0 localhost" > /etc/hosts

# Update mirrors list to be faster
sudo pacman-mirrors --fasttrack && sudo pacman -Syyu

# Install development tools
sudo pacman -S base-devel

# Necessities
sudo pacman -S tmux neovim xclip cmake tldr

# Oh-my-zsh setup
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Nvim setup
## download vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Remember to run :PlugInstall in your next neovim session"


# Generate ssh key
ssh-keygen -o -t rsa -b 4096 -C "$EMAIL"

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup target add wasm32-wasi

# Rust programms
cargo install cargo-edit
cargo install du-dust ripgrep fd-find

# Rust speedup with better linker
sudo pacman -S lld
cargo install -f cargo-binutils
rustup component add llvm-tools-preview

# Depenedencies for game dev (Bevy to be precise)
sudo pacman -S libx11 pkgconf alsa-lib

# nvm - node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node

# yay - AUR helper
cd ~
mkdir Programs
cd Programs
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

# install Chromium
pacman -S chromium

# install Docker
sudo pacman -S docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo groupadd docker
sudo usermod -aG docker $USER
su - $USER # refresh groups

