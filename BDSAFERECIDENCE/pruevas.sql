
-- Elimina la base de datos si existe y luego crea una nueva
DROP DATABASE IF EXISTS pruevas;
CREATE DATABASE pruevas;
USE pruevas;

-- Crear tabla usuarios
CREATE TABLE usuarios (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    cedula VARCHAR(150) NOT NULL,
    perfil ENUM('Propietario', 'Administrador', 'Guarda') NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Crear tabla apartamento
CREATE TABLE apartamento (
    apartamento_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    propietario_id INT UNSIGNED NOT NULL,
    numero VARCHAR(150) NOT NULL,
    FOREIGN KEY (propietario_id) REFERENCES usuarios(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Crear tabla autorizacion
CREATE TABLE autorizacion (
    autorizacion_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    propietario_id INT UNSIGNED NOT NULL,
    nombre_visitante VARCHAR(100) NOT NULL,
    apellidos_visitante VARCHAR(100) NOT NULL,
    cedula_visitante VARCHAR(20) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (propietario_id) REFERENCES usuarios(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Crear tabla parqueadero
CREATE TABLE parqueadero (
    parqueadero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    disponible BOOLEAN NOT NULL
);

-- Crear tabla ingreso
CREATE TABLE ingreso (
    ingreso_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    guarda_id INT UNSIGNED NOT NULL,
    usuario_id INT UNSIGNED NOT NULL,
    tipo_usuario ENUM('Propietario', 'Visitante') NOT NULL,
    parqueadero_id INT UNSIGNED,
    vehiculo BOOLEAN NOT NULL,
    fecha_hora_ingreso DATETIME NOT NULL,
    FOREIGN KEY (guarda_id) REFERENCES usuarios(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (parqueadero_id) REFERENCES parqueadero(parqueadero_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Crear tabla salida
CREATE TABLE salida (
    salida_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ingreso_id INT UNSIGNED NOT NULL,
    fecha_hora_salida DATETIME NOT NULL,
    guarda_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (ingreso_id) REFERENCES ingreso(ingreso_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (guarda_id) REFERENCES usuarios(user_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);