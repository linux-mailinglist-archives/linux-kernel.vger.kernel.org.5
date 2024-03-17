Return-Path: <linux-kernel+bounces-105525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F787DFB5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B91281709
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5B200A0;
	Sun, 17 Mar 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGeX8yTJ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632A1F94C;
	Sun, 17 Mar 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704293; cv=none; b=M7/2YdIeKOQ+7DbzXxaOF8SrI5TfQkAcK4tLiE492IKkSRbddkZEN5NS1dEsHGprYm5FqMcnveBRRYNDrjiOumz7ewMpmes8u+N8HiCelhWuN98h5dF1i8Pi1g10Wa8qD/g8ea4YlOAf3fY8yk+KdkKQp1xDZSBMu3lJwMYgN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704293; c=relaxed/simple;
	bh=NepZd0V4JR54PtTOjVgHeyw+ssv5u+8D6uhP/rktb+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbYn6TJkOA8tSFLzWWDzKi2XYypNNJUHSg/MUuyrj7Kr508IaffLTcxQhv1EyfMb/hyaYIxrPRTGVQyxOjLqXMLNcz8z9k11hjarxeyOkZHvPUsdAeSAYNr1F+UbsRclqJZwlFmZXlCDt4hMTU07PTgPvxI0iX1lMRLPw89InmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGeX8yTJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso83161a91.3;
        Sun, 17 Mar 2024 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704291; x=1711309091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAFdZ643wkelI8hZPnf28UKtzzWxeqJSxohoYBvzlpg=;
        b=MGeX8yTJdLZMq1orLf85u120H1uTOPHNU/dKakwaX/Wp7GABbPDA8fK03Q7KlGco+A
         +pb/yei3jnMAG9+OJ1IW3/TCxwGmN7927Qx1PU05UpTPC/MlTih3Ft9VGlDpueoPYHsc
         IsbQ+TA7H6OTsBuayvtUxnnwWu3r3abd/eRsZQYbUY9VNBl/lJx5ZtQV0fajiZIL3nU5
         5h1WQlCAEHcBQrsWzYi5ucWnhnaWQNsSbkHRBl5GXKLIalstQVGGBxSdf6aaSQnDOah6
         mReyma8XtyUUzlkHkz2Tk04XYSh7EJDOjd5pJhd7LC94VOm6TWOk6tka8C7D5JFFNCok
         lJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704291; x=1711309091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAFdZ643wkelI8hZPnf28UKtzzWxeqJSxohoYBvzlpg=;
        b=dlGUUFRkvhI5sKippqDoQ+O0nolI9XC7J9F4ES8pvo6KsMMCs+ntQLb/JETL5LciE2
         5cEwjorgaTjzxJ8oCPkiowyG1yzKGC1nraSViAGO6yuwfhO4awPiYnEQ+otUgACuRULj
         3IXrGLv37Bqer448T555U+ZnK7wo8OIdmFkqapLCno1R/wRm0Rb37kMHYhRZQWV23mzk
         sLLjheArDXJBp21R23cMIRkEiK9hPKBBFIlggqjUvA5EV4HdiqLX9Mim+YsQNdvnpWzB
         2juALRQk/c3ZvYp5fnnaV2Aq3LVF4JEjSPzK6gEmmqImj1o5nfLqxGvUta02s8pDUJOI
         EJyg==
X-Forwarded-Encrypted: i=1; AJvYcCUXYbS0iJHv0v1x9q0cMW5jONQfjbhWlGzX6j75BXoq20GSaRp+80Sqivl/7tyNYWROwSQ6rR0gKPyNANRkBb10Zd2QVA6VvubiaQiNMILOY5uI+fvak9EuXhUbiDyNZ6FP4CQ3LQ==
X-Gm-Message-State: AOJu0Yx4w4eJ6skXBTYzpMwodFs6xA60pCrP8zRbivUYPQKzhTjs/nxl
	64ejfE6OYaWVdAylY0SVar2jYl5gUPvtJfHJZxsaTMZHSd4zV6SKUDygAnq8pK+kRg==
X-Google-Smtp-Source: AGHT+IGIMfDbF9VDPxpzPhgHWGmVrvu7kV7iVi2cPqw22K30WUzkmMxnJYuAGqmR7ul921En552HNg==
X-Received: by 2002:a17:90a:88d:b0:29d:e70f:7240 with SMTP id v13-20020a17090a088d00b0029de70f7240mr6358733pjc.11.1710704290554;
        Sun, 17 Mar 2024 12:38:10 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6125995pjb.44.2024.03.17.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:38:10 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org (open list)
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Date: Mon, 18 Mar 2024 01:07:09 +0530
Message-ID: <20240317193714.403132-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317193714.403132-1-ayushdevel1325@gmail.com>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings for mikroBUS interface. MikroBUS is an open standard
developed by MikroElektronika for connecting add-on boards to
microcontrollers or microprocessors.

mikroBUS is a connector and does not have a controller. Instead the
software is responsible for identification of board and setting up /
registering uart, spi, i2c, pwm and other buses. Thus it needs a way to
get uart, spi, i2c, pwm and gpio controllers / adapters.

A mikroBUS addon board is free to leave some of the pins unused which
are marked as NC or Not Connected.

Some of the pins might need to be configured as GPIOs deviating from their
reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.

For some add-on boards the driver may not take care of some additional
signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
(RST pin on the mikrobus port) needs to be pulled high.

Here's the list of pins in mikroBUS connector:
Analog - AN
Reset - RST
SPI Chip Select - CS
SPI Clock - SCK
SPI Master Input Slave Output - MISO
SPI Master Output Slave Input - MOSI
VCC-3.3V power - +3.3V
Reference Ground - GND
PWM - PWM output
INT - Hardware Interrupt
RX - UART Receive
TX - UART Transmit
SCL - I2C Clock
SDA - I2C Data
+5V - VCC-5V power
GND - Reference Ground

Additionally, some new mikroBUS boards contain 1-wire EEPROM that contains
a manifest to describe the addon board to provide plug and play
capabilities.

Link: https://www.mikroe.com/mikrobus
Link:
https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
mikroBUS specification
Link: https://www.mikroe.com/sht1x-click SHT15 Click
Link: https://www.mikroe.com/eth-click ENC28J60 Click
Link: https://www.mikroe.com/clickid ClickID

Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 .../connector/mikrobus-connector.yaml         | 113 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/mikrobus-connector.yaml

diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
new file mode 100644
index 000000000000..ee3736add41c
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: mikroBUS add-on board socket
+
+maintainers:
+  - Ayush Singh <ayushdevel1325@gmail.com>
+
+properties:
+  compatible:
+    const: mikrobus-connector
+
+  pinctrl-0: true
+  pinctrl-1: true
+  pinctrl-2: true
+  pinctrl-3: true
+  pinctrl-4: true
+  pinctrl-5: true
+  pinctrl-6: true
+  pinctrl-7: true
+  pinctrl-8: true
+
+  pinctrl-names:
+    items:
+      - const: default
+      - const: pwm_default
+      - const: pwm_gpio
+      - const: uart_default
+      - const: uart_gpio
+      - const: i2c_default
+      - const: i2c_gpio
+      - const: spi_default
+      - const: spi_gpio
+
+  mikrobus-gpios:
+    minItems: 11
+    maxItems: 12
+
+  i2c-adapter:
+    description: i2c adapter attached to the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  spi-controller:
+    description: spi bus number of the spi-master attached to the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  uart:
+    description: uart port attached to the mikrobus socket
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  pwms:
+    description: the pwm-controller corresponding to the mikroBUS PWM pin.
+    maxItems: 1
+
+  spi-cs:
+    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: chip select corresponding to CS pin
+      - description: chip select corresponding to RST pin
+
+required:
+  - compatible
+  - pinctrl-0
+  - pinctrl-1
+  - pinctrl-2
+  - pinctrl-3
+  - pinctrl-4
+  - pinctrl-5
+  - pinctrl-6
+  - pinctrl-7
+  - pinctrl-8
+  - i2c-adapter
+  - spi-controller
+  - spi-cs
+  - uart
+  - pwms
+  - mikrobus-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mikrobus {
+      compatible = "mikrobus-connector";
+      pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
+                      "i2c_gpio", "spi_default", "spi_gpio";
+      pinctrl-0 = <&P2_03_gpio_input_pin &P1_04_gpio_pin &P1_02_gpio_pin>;
+      pinctrl-1 = <&P2_01_pwm_pin>;
+      pinctrl-2 = <&P2_01_gpio_pin>;
+      pinctrl-3 = <&P2_05_uart_pin &P2_07_uart_pin>;
+      pinctrl-4 = <&P2_05_gpio_pin &P2_07_gpio_pin>;
+      pinctrl-5 = <&P2_09_i2c_pin &P2_11_i2c_pin>;
+      pinctrl-6 = <&P2_09_gpio_pin &P2_11_gpio_pin>;
+      pinctrl-7 = <&P1_12_spi_pin &P1_10_spi_pin &P1_08_spi_sclk_pin &P1_06_spi_cs_pin>;
+      pinctrl-8 = <&P1_12_gpio_pin &P1_10_gpio_pin &P1_08_gpio_pin &P1_06_gpio_pin>;
+      pwms = <&ehrpwm1 0 500000 0>;
+      i2c-adapter = <&i2c1>;
+      spi-controller = <&spi1>;
+      spi-cs = <0 1>;
+      uart = <&uart1>;
+      mikrobus-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>, <&gpio0 23 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 30 GPIO_ACTIVE_HIGH>, <&gpio0 31 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 15 GPIO_ACTIVE_HIGH>, <&gpio0 14 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 4 GPIO_ACTIVE_HIGH>, <&gpio0 3 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 2 GPIO_ACTIVE_HIGH>, <&gpio0 5 GPIO_ACTIVE_HIGH>,
+                       <&gpio2 25 GPIO_ACTIVE_HIGH>, <&gpio2 3 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 375d34363777..69418a058c6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14767,6 +14767,12 @@ M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
 F:	drivers/usb/image/microtek.*
 
+MIKROBUS
+M:	Ayush Singh <ayushdevel1325@gmail.com>
+M:	Vaishnav M A <vaishnav@beagleboard.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
+
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
-- 
2.44.0


