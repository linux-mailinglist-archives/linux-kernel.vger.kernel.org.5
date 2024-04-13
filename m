Return-Path: <linux-kernel+bounces-143911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32A8A3F74
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C782E281F4E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249F58107;
	Sat, 13 Apr 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UdyID+f+"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2157322
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713046490; cv=none; b=fp0rsYEBBSopeMTW/ZH7cWdFQHPFqX9rn7WN/11Wz5qT6Y95GGf2pxN7/6HM3wUD3U8NLdmHCot+dKjxMl9SMoK7NJ1ZfRbnNGso3x9A/DM5PPNTS0LB2PRt0HpX7LrOwlJu6o7V1U31Go0atD3aw8EI8ApSuW0pJt6ofiGANGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713046490; c=relaxed/simple;
	bh=TwmkElDV8KFXSCe7JjPQIKC5Y9hJ21zERHUFeGxm4oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPnZEKvPTgs7sGS07t38VRnMyHscXDIjtQ5RP1F5AAZyES2JukpkXrRN4ELCkLedzTElmqb2kiqFf+3qNtDl0kV+WmVwkTg5Lr37aOFguCo0td9GaPvBtP//WRlgRDuWiJLDXObCuFK8Z3q8GnjY9Zn4OJ5YlBQcNfBg7jnSE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UdyID+f+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d4d80d00so2623081e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713046485; x=1713651285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sypLtcdaDywQwxaJJkOhX4Bb6LzpNg38CY+8OZ5anlA=;
        b=UdyID+f+bZNKXushZgdD2mVF+H+G2XVSTEMhRpNXBKlyniNhI2Bf59JSbUoc4Uqabd
         HHww8UF0pOZgibkWv/0rR+AM1eVqH3uXXNxPkh1VVJxyz+P7zXUq8NznbWFiu7ScyO1R
         N0yuRorir80wx+9XKH8eU2qVdBKaZvnxu4OuZGuD/jXIt8oBj1D2g+6UKqFQQyVyevgo
         bjGp2+RufTIXKT00tdH0Y8kuA1b5wigysciUy34jxA5zCTAYMQ4WgzCMxgnTw2AHI730
         bqJkflmu4B69Fb/lVpvRr/6/XiBZIGncPvo6b8CXj0KrSaqXj5H0qymWQ5q7LaCGpMdo
         liPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713046485; x=1713651285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sypLtcdaDywQwxaJJkOhX4Bb6LzpNg38CY+8OZ5anlA=;
        b=SNUvrgYIV/mtD/k3pla+op/W7frya/IKd1fpr67TQHOflJIhf6NSsa7QwTXfgn+o73
         q2J3gSRpeG3Em09BScAl0APsrV4k8IqYRaMbubA9exfzeqh9q1uFnswAQH2CDM1bH+/6
         YYpl/tMYadkf7kz3a4yPB4FyotZLaf7c1aSvxLAiwWKyu+Q1gW6Lu8cVRKQFvFqPjNay
         ob9lys3dto4nUwnZxM2ROrDoq7tk58TMh7adLRTjJ7py8lP+3BwmsOdDuPcO4p9gGXD/
         GG1eLfbWqpzFQ5TCTK3JP0hadDfSfwerWqJsRO46iEv74AcZYiPuYjVHYHUGI3Zn06kB
         FubQ==
X-Forwarded-Encrypted: i=1; AJvYcCUenv/cL1BkMbPWReEGI4JLO23rUxqa32YuW3T1CJvxXcesR5RvtHcFHkfxz43fkHelyzeUndiA9Pt9mOJBfmJGNiOv4Gbcx3vlcux9
X-Gm-Message-State: AOJu0YzduQWc6T04u2NzXymU4toYcHEERa43UnQharN3ab7ZRdgwzSTG
	qpBU0zMyjhBhkMQav56G43rtu76M/fZs3PDijwH2ewWinofsCEWaoRhVKJFtqeQ=
X-Google-Smtp-Source: AGHT+IGMXnXRNFYZboNwcpPhCbjZpakla1CGSk+ncjrTMrer37Spa7qsvSOrYRROsfiNHMrBS71K8A==
X-Received: by 2002:a2e:83ce:0:b0:2d6:fd9c:6af6 with SMTP id s14-20020a2e83ce000000b002d6fd9c6af6mr3879283ljh.28.1713046484692;
        Sat, 13 Apr 2024 15:14:44 -0700 (PDT)
Received: from localhost (host-87-4-160-102.retail.telecomitalia.it. [87.4.160.102])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7c0cd000000b005701d49ab7esm402625edp.53.2024.04.13.15.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:14:44 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	della Porta <andrea.porta@suse.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 3/6] arm64: dts: broadcom: Add support for BCM2712
Date: Sun, 14 Apr 2024 00:14:25 +0200
Message-ID: <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713036964.git.andrea.porta@suse.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     | 313 +++++++
 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi |  81 ++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 841 ++++++++++++++++++
 4 files changed, 1236 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 8b4591ddd27c..92565e9781ad 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -6,6 +6,7 @@ DTC_FLAGS := -@
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2711-rpi-4-b.dtb \
 			      bcm2711-rpi-cm4-io.dtb \
+			      bcm2712-rpi-5-b.dtb \
 			      bcm2837-rpi-3-a-plus.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
new file mode 100644
index 000000000000..2ce180a54e5b
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
+
+#define spi0 _spi0
+#define uart0 _uart0
+
+#include "bcm2712.dtsi"
+
+#undef spi0
+#undef uart0
+
+/ {
+	compatible = "raspberrypi,5-model-b", "brcm,bcm2712";
+	model = "Raspberry Pi 5";
+
+	/* Will be filled by the bootloader */
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0 0x28000000>;
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		led_act: led-act {
+			label = "ACT";
+			gpios = <&gio_aon 9 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+			linux,default-trigger = "mmc0";
+		};
+	};
+
+	sd_io_1v8_reg: sd_io_1v8_reg {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-sd-io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-settling-time-us = <5000>;
+		gpios = <&gio_aon 3 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		status = "okay";
+	};
+
+	sd_vcc_reg: sd_vcc_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpios = <&gio_aon 4 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	wl_on_reg: wl_on_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "wl-on-regulator";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-0 = <&wl_on_pins>;
+		pinctrl-names = "default";
+
+		gpio = <&gio 28 GPIO_ACTIVE_HIGH>;
+
+		startup-delay-us = <150000>;
+		enable-active-high;
+	};
+
+	clocks: clocks {
+	};
+};
+
+// Add some labels to 2712 device
+
+// The system UART
+uart10: &_uart0 { status = "okay"; };
+
+// The system SPI for the bootloader EEPROM
+spi10: &_spi0 { status = "okay"; };
+
+#include "bcm2712-rpi.dtsi"
+
+/* SDIO1 is used to drive the SD card */
+&sdio1 {
+	pinctrl-0 = <&emmc_sd_pulls>, <&emmc_aon_cd_pins>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	vmmc-supply = <&sd_vcc_reg>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	sd-uhs-sdr104;
+	cd-gpios = <&gio_aon 5 GPIO_ACTIVE_LOW>;
+	//no-1-8-v;
+	status = "okay";
+};
+
+&pinctrl_aon {
+	emmc_aon_cd_pins: emmc_aon_cd_pins {
+		function = "sd_card_g";
+		pins = "aon_gpio5";
+		bias-pull-up;
+	};
+
+	/* Slight hack - only one PWM pin (status LED) is usable */
+	aon_pwm_1pin: aon_pwm_1pin {
+		function = "aon_pwm";
+		pins = "aon_gpio9";
+	};
+};
+
+&pinctrl {
+	pwr_button_pins: pwr_button_pins {
+		function = "gpio";
+		pins = "gpio20";
+		bias-pull-up;
+	};
+
+	wl_on_pins: wl_on_pins {
+		function = "gpio";
+		pins = "gpio28";
+	};
+
+	bt_shutdown_pins: bt_shutdown_pins {
+		function = "gpio";
+		pins = "gpio29";
+	};
+
+	emmc_sd_pulls: emmc_sd_pulls {
+		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
+		bias-pull-up;
+	};
+};
+
+/ {
+	chosen: chosen {
+		bootargs = "reboot=w coherent_pool=1M 8250.nr_uarts=1 pci=pcie_bus_safe snd_bcm2835.enable_compat_alsa=0 snd_bcm2835.enable_hdmi=1";
+		stdout-path = "serial10:115200n8";
+	};
+
+	pwr_button {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_button_pins>;
+		status = "okay";
+
+		pwr_key: pwr {
+			label = "pwr_button";
+			// linux,code = <205>; // KEY_SUSPEND
+			linux,code = <116>; // KEY_POWER
+			gpios = <&gio 20 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>; // ms
+		};
+	};
+};
+
+&pinctrl {
+	spi10_gpio2: spi10_gpio2 {
+		function = "vc_spi0";
+		pins = "gpio2", "gpio3", "gpio4";
+		bias-disable;
+	};
+
+	spi10_cs_gpio1: spi10_cs_gpio1 {
+		function = "gpio";
+		pins = "gpio1";
+		bias-pull-up;
+	};
+};
+
+spi10_pins: &spi10_gpio2 {};
+spi10_cs_pins: &spi10_cs_gpio1 {};
+
+&spi10 {
+	pinctrl-names = "default";
+	cs-gpios = <&gio 1 1>;
+	pinctrl-0 = <&spi10_pins &spi10_cs_pins>;
+
+	spidev10: spidev@0 {
+		compatible = "spidev";
+		reg = <0>;	/* CE0 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		spi-max-frequency = <20000000>;
+		status = "okay";
+	};
+};
+
+// =============================================
+// Board specific stuff here
+
+&gio_aon {
+	// Don't use GIO_AON as an interrupt controller because it will
+	// clash with the firmware monitoring the PMIC interrupt via the VPU.
+
+	/delete-property/ interrupt-controller;
+};
+
+&main_aon_irq {
+	// Don't use the MAIN_AON_IRQ interrupt controller because it will
+	// clash with the firmware monitoring the PMIC interrupt via the VPU.
+
+	status = "disabled";
+};
+
+&gio {
+	// The GPIOs above 35 are not used on Pi 5, so shrink the upper bank
+	// to reduce the clutter in gpioinfo/pinctrl
+	brcm,gpio-bank-widths = <32 4>;
+
+	gpio-line-names =
+		"-", // GPIO_000
+		"2712_BOOT_CS_N", // GPIO_001
+		"2712_BOOT_MISO", // GPIO_002
+		"2712_BOOT_MOSI", // GPIO_003
+		"2712_BOOT_SCLK", // GPIO_004
+		"-", // GPIO_005
+		"-", // GPIO_006
+		"-", // GPIO_007
+		"-", // GPIO_008
+		"-", // GPIO_009
+		"-", // GPIO_010
+		"-", // GPIO_011
+		"-", // GPIO_012
+		"-", // GPIO_013
+		"PCIE_SDA", // GPIO_014
+		"PCIE_SCL", // GPIO_015
+		"-", // GPIO_016
+		"-", // GPIO_017
+		"-", // GPIO_018
+		"-", // GPIO_019
+		"PWR_GPIO", // GPIO_020
+		"2712_G21_FS", // GPIO_021
+		"-", // GPIO_022
+		"-", // GPIO_023
+		"BT_RTS", // GPIO_024
+		"BT_CTS", // GPIO_025
+		"BT_TXD", // GPIO_026
+		"BT_RXD", // GPIO_027
+		"WL_ON", // GPIO_028
+		"BT_ON", // GPIO_029
+		"WIFI_SDIO_CLK", // GPIO_030
+		"WIFI_SDIO_CMD", // GPIO_031
+		"WIFI_SDIO_D0", // GPIO_032
+		"WIFI_SDIO_D1", // GPIO_033
+		"WIFI_SDIO_D2", // GPIO_034
+		"WIFI_SDIO_D3"; // GPIO_035
+};
+
+&gio_aon {
+	gpio-line-names =
+		"RP1_SDA", // AON_GPIO_00
+		"RP1_SCL", // AON_GPIO_01
+		"RP1_RUN", // AON_GPIO_02
+		"SD_IOVDD_SEL", // AON_GPIO_03
+		"SD_PWR_ON", // AON_GPIO_04
+		"SD_CDET_N", // AON_GPIO_05
+		"SD_FLG_N", // AON_GPIO_06
+		"-", // AON_GPIO_07
+		"2712_WAKE", // AON_GPIO_08
+		"2712_STAT_LED", // AON_GPIO_09
+		"-", // AON_GPIO_10
+		"-", // AON_GPIO_11
+		"PMIC_INT", // AON_GPIO_12
+		"UART_TX_FS", // AON_GPIO_13
+		"UART_RX_FS", // AON_GPIO_14
+		"-", // AON_GPIO_15
+		"-", // AON_GPIO_16
+
+		// Pad bank0 out to 32 entries
+		"", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
+
+		"HDMI0_SCL", // AON_SGPIO_00
+		"HDMI0_SDA", // AON_SGPIO_01
+		"HDMI1_SCL", // AON_SGPIO_02
+		"HDMI1_SDA", // AON_SGPIO_03
+		"PMIC_SCL", // AON_SGPIO_04
+		"PMIC_SDA"; // AON_SGPIO_05
+};
+
+/ {
+	aliases {
+		blconfig = &blconfig;
+		blpubkey = &blpubkey;
+		console = &uart10;
+		mailbox = &mailbox;
+		mmc0 = &sdio1;
+		uart10 = &uart10;
+		serial10 = &uart10;
+		gpio1 = &gio;
+		gpio2 = &gio_aon;
+		gpio3 = &pinctrl;
+		gpio4 = &pinctrl_aon;
+	};
+
+	__overrides__ {
+		button_debounce = <&pwr_key>, "debounce-interval:0";
+		random = <&random>, "status";
+		sd_cqe = <&sdio1>, "supports-cqe?";
+		suspend = <&pwr_key>, "linux,code:0=205";
+		act_led_activelow = <&led_act>,"gpios:8";
+		act_led_trigger = <&led_act>, "linux,default-trigger";
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
new file mode 100644
index 000000000000..d04e39b9c0b6
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/power/raspberrypi-power.h>
+
+&soc {
+	firmware: firmware {
+		compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		mboxes = <&mailbox>;
+		dma-ranges;
+
+		firmware_clocks: clocks {
+			compatible = "raspberrypi,firmware-clocks";
+			#clock-cells = <1>;
+		};
+
+		reset: reset {
+			compatible = "raspberrypi,firmware-reset";
+			#reset-cells = <1>;
+		};
+	};
+
+	power: power {
+		compatible = "raspberrypi,bcm2835-power";
+		firmware = <&firmware>;
+		#power-domain-cells = <1>;
+	};
+
+	/* Define these notional regulators for use by overlays, etc. */
+	vdd_3v3_reg: fixedregulator_3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3";
+	};
+
+	vdd_5v0_reg: fixedregulator_5v0 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "5v0";
+	};
+};
+
+/ {
+	__overrides__ {
+		arm_freq;
+	};
+};
+
+&rmem {
+	/*
+	 * RPi5's co-processor will copy the board's bootloader configuration
+	 * into memory for the OS to consume. It'll also update this node with
+	 * its placement information.
+	 */
+	blconfig: nvram@0 {
+		compatible = "raspberrypi,bootloader-config", "nvmem-rmem";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x0 0x0>;
+		no-map;
+		status = "disabled";
+	};
+	/*
+	 * RPi5 will copy the binary public key blob (if present) from the bootloader
+	 * into memory for use by the OS.
+	 */
+	blpubkey: nvram@1 {
+		compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x0 0x0>;
+		no-map;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
new file mode 100644
index 000000000000..fd5a19f68b49
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -0,0 +1,841 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/bcm2835-pm.h>
+#include <dt-bindings/phy/phy.h>
+
+/ {
+	compatible = "brcm,bcm2712", "brcm,bcm2711";
+	model = "BCM2712";
+
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	interrupt-parent = <&gicv2>;
+
+	rmem: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		atf@0 {
+			reg = <0x0 0x0 0x80000>;
+			no-map;
+		};
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x4000000>; /* 64MB */
+			reusable;
+			linux,cma-default;
+
+			/*
+			 * arm64 reserves the CMA by default somewhere in
+			 * ZONE_DMA32, that's not good enough for the BCM2711
+			 * as some devices can only address the lower 1G of
+			 * memory (ZONE_DMA).
+			 */
+			alloc-ranges = <0x0 0x00000000 0x40000000>;
+		};
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <2000>;
+			polling-delay = <1000>;
+			coefficients = <(-550) 450000>;
+			thermal-sensors = <&thermal>;
+
+			thermal_trips: trips {
+				cpu_crit: cpu-crit {
+					temperature	= <110000>;
+					hysteresis	= <0>;
+					type		= "critical";
+				};
+			};
+
+			cooling_maps: cooling-maps {
+			};
+		};
+	};
+
+	clk_27MHz: clk-27M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+		clock-output-names = "27MHz-clock";
+	};
+
+	clk_108MHz: clk-108M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <108000000>;
+		clock-output-names = "108MHz-clock";
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ranges     = <0x7c000000  0x10 0x7c000000  0x04000000>;
+		/* Emulate a contiguous 30-bit address range for DMA */
+		dma-ranges = <0xc0000000  0x00 0x00000000  0x40000000>,
+			     <0x7c000000  0x10 0x7c000000  0x04000000>;
+
+		system_timer: timer@7c003000 {
+			compatible = "brcm,bcm2835-system-timer";
+			reg = <0x7c003000 0x1000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+		     		     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+		     		     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <1000000>;
+		};
+
+		mailbox: mailbox@7c013880 {
+			compatible = "brcm,bcm2835-mbox";
+			reg = <0x7c013880 0x40>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+		};
+
+		disp_intr: interrupt-controller@7c502000 {
+			compatible = "brcm,bcm2711-l2-intc", "brcm,l2-intc";
+			reg = <0x7c502000 0x30>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			status = "disabled";
+		};
+
+		dvp: clock@7c700000 {
+			compatible = "brcm,brcm2711-dvp";
+			reg = <0x7c700000 0x10>;
+			clocks = <&clk_108MHz>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		/*
+		 * This node is the provider for the enable-method for
+		 * bringing up secondary cores.
+		 */
+		local_intc: local_intc@7cd00000 {
+			compatible = "brcm,bcm2836-l1-intc";
+			reg = <0x7cd00000 0x100>;
+		};
+
+		uart0: serial@7d001000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x7d001000 0x200>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_uart>,
+				 <&clk_vpu>;
+			clock-names = "uartclk", "apb_pclk";
+			arm,primecell-periphid = <0x00241011>;
+			status = "disabled";
+		};
+
+		uart2: serial@7d001400 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x7d001400 0x200>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_uart>,
+				 <&clk_vpu>;
+			clock-names = "uartclk", "apb_pclk";
+			arm,primecell-periphid = <0x00241011>;
+			status = "disabled";
+		};
+
+		uart5: serial@7d001a00 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x7d001a00 0x200>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_uart>,
+				 <&clk_vpu>;
+			clock-names = "uartclk", "apb_pclk";
+			arm,primecell-periphid = <0x00241011>;
+			status = "disabled";
+		};
+
+		sdhost: mmc@7d002000 {
+			compatible = "brcm,bcm2835-sdhost";
+			reg = <0x7d002000 0x100>;
+			//interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			status = "disabled";
+		};
+
+		i2s: i2s@7d003000 {
+			compatible = "brcm,bcm2835-i2s";
+			reg = <0x7d003000 0x24>;
+			//clocks = <&cprman BCM2835_CLOCK_PCM>;
+			status = "disabled";
+		};
+
+		spi0: spi@7d004000 {
+			compatible = "brcm,bcm2835-spi";
+			reg = <0x7d004000 0x200>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi3: spi@7d004600 {
+			compatible = "brcm,bcm2835-spi";
+			reg = <0x7d004600 0x0200>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi4: spi@7d004800 {
+			compatible = "brcm,bcm2835-spi";
+			reg = <0x7d004800 0x0200>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi5: spi@7d004a00 {
+			compatible = "brcm,bcm2835-spi";
+			reg = <0x7d004a00 0x0200>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi6: spi@7d004c00 {
+			compatible = "brcm,bcm2835-spi";
+			reg = <0x7d004c00 0x0200>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@7d005000 {
+			compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg = <0x7d005000 0x20>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@7d005600 {
+			compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg = <0x7d005600 0x20>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@7d005800 {
+			compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg = <0x7d005800 0x20>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@7d005a00 {
+			compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg = <0x7d005a00 0x20>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@7d005c00 {
+			compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg = <0x7d005c00 0x20>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@7d005e00 {
+			compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
+			reg = <0x7d005e00 0x20>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_vpu>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		pwm0: pwm@7d00c000 {
+			compatible = "brcm,bcm2835-pwm";
+			reg = <0x7d00c000 0x28>;
+			assigned-clock-rates = <50000000>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@7d00c800 {
+			compatible = "brcm,bcm2835-pwm";
+			reg = <0x7d00c800 0x28>;
+			assigned-clock-rates = <50000000>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		cprman: cprman@7d202000 {
+			compatible = "brcm,bcm2711-cprman";
+			reg = <0x7d202000 0x2000>;
+			#clock-cells = <1>;
+
+			/* CPRMAN derives almost everything from the
+			 * platform's oscillator.  However, the DSI
+			 * pixel clocks come from the DSI analog PHY.
+			 */
+			clocks = <&clk_osc>;
+			status = "disabled";
+		};
+
+		random: rng@7d208000 {
+			compatible = "brcm,bcm2711-rng200";
+			reg = <0x7d208000 0x28>;
+			status = "okay";
+		};
+
+		cpu_l2_irq: intc@7d503000 {
+			compatible = "brcm,l2-intc";
+			reg = <0x7d503000 0x18>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		pinctrl: pinctrl@7d504100 {
+			compatible = "brcm,bcm2712-pinctrl";
+			reg = <0x7d504100 0x30>;
+
+			uarta_24_pins: uarta_24_pins {
+				pin_rts {
+					function = "uart0";
+					pins = "gpio24";
+					bias-disable;
+				};
+				pin_cts {
+					function = "uart0";
+					pins = "gpio25";
+					bias-pull-up;
+				};
+				pin_txd {
+					function = "uart0";
+					pins = "gpio26";
+					bias-disable;
+				};
+				pin_rxd {
+					function = "uart0";
+					pins = "gpio27";
+					bias-pull-up;
+				};
+			};
+
+			sdio2_30_pins: sdio2_30_pins {
+				pin_clk {
+					function = "sd2";
+					pins = "gpio30";
+					bias-disable;
+				};
+				pin_cmd {
+					function = "sd2";
+					pins = "gpio31";
+					bias-pull-up;
+				};
+				pins_dat {
+					function = "sd2";
+					pins = "gpio32", "gpio33", "gpio34", "gpio35";
+					bias-pull-up;
+				};
+			};
+		};
+
+		ddc0: i2c@7d508200 {
+			compatible = "brcm,brcmstb-i2c";
+			reg = <0x7d508200 0x58>;
+			interrupt-parent = <&bsc_irq>;
+			interrupts = <1>;
+			clock-frequency = <97500>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		ddc1: i2c@7d508280 {
+			compatible = "brcm,brcmstb-i2c";
+			reg = <0x7d508280 0x58>;
+			interrupt-parent = <&bsc_irq>;
+			interrupts = <2>;
+			clock-frequency = <97500>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		bscd: i2c@7d508300 {
+			compatible = "brcm,brcmstb-i2c";
+			reg = <0x7d508300 0x58>;
+			interrupt-parent = <&bsc_irq>;
+			interrupts = <0>;
+			clock-frequency = <200000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		bsc_irq: intc@7d508380 {
+			compatible = "brcm,bcm7271-l2-intc";
+			reg = <0x7d508380 0x10>;
+			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		main_irq: intc@7d508400 {
+			compatible = "brcm,bcm7271-l2-intc";
+			reg = <0x7d508400 0x10>;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gio: gpio@7d508500 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x7d508500 0x40>;
+			interrupt-parent = <&main_irq>;
+			interrupts = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			brcm,gpio-bank-widths = <32 22>;
+			brcm,gpio-direct;
+		};
+
+		uarta: serial@7d50c000 {
+			compatible = "brcm,bcm7271-uart";
+			reg = <0x7d50c000 0x20>;
+			reg-names = "uart";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+			skip-init;
+			status = "disabled";
+		};
+
+		uartb: serial@7d50d000 {
+			compatible = "brcm,bcm7271-uart";
+			reg = <0x7d50d000 0x20>;
+			reg-names = "uart";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
+			skip-init;
+			status = "disabled";
+		};
+
+		aon_intr: interrupt-controller@7d510600 {
+			compatible = "brcm,bcm2711-l2-intc", "brcm,l2-intc";
+			reg = <0x7d510600 0x30>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			status = "disabled";
+		};
+
+		pinctrl_aon: pinctrl@7d510700 {
+			compatible = "brcm,bcm2712-aon-pinctrl";
+			reg = <0x7d510700 0x20>;
+
+			i2c3_m4_agpio0_pins: i2c3_m4_agpio0_pins {
+				function = "vc_i2c3";
+				pins = "aon_gpio0", "aon_gpio1";
+				bias-pull-up;
+			};
+
+			bsc_m1_agpio13_pins: bsc_m1_agpio13_pins {
+				function = "bsc_m1";
+				pins = "aon_gpio13", "aon_gpio14";
+				bias-pull-up;
+			};
+
+			bsc_pmu_sgpio4_pins: bsc_pmu_sgpio4_pins {
+				function = "avs_pmu_bsc";
+				pins = "aon_sgpio4", "aon_sgpio5";
+			};
+
+			bsc_m2_sgpio4_pins: bsc_m2_sgpio4_pins {
+				function = "bsc_m2";
+				pins = "aon_sgpio4", "aon_sgpio5";
+			};
+
+			pwm_aon_agpio1_pins: pwm_aon_agpio1_pins {
+				function = "aon_pwm";
+				pins = "aon_gpio1", "aon_gpio2";
+			};
+
+			pwm_aon_agpio4_pins: pwm_aon_agpio4_pins {
+				function = "vc_pwm0";
+				pins = "aon_gpio4", "aon_gpio5";
+			};
+
+			pwm_aon_agpio7_pins: pwm_aon_agpio7_pins {
+				function = "aon_pwm";
+				pins = "aon_gpio7", "aon_gpio9";
+			};
+		};
+
+		intc@7d517000 {
+			compatible = "brcm,bcm7271-l2-intc";
+			reg = <0x7d517000 0x10>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			status = "disabled";
+		};
+
+		bscc: i2c@7d517a00 {
+			compatible = "brcm,brcmstb-i2c";
+			reg = <0x7d517a00 0x58>;
+			interrupt-parent = <&bsc_aon_irq>;
+			interrupts = <0>;
+			clock-frequency = <200000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		pwm_aon: pwm@7d517a80 {
+			compatible = "brcm,bcm7038-pwm";
+			reg = <0x7d517a80 0x28>;
+			#pwm-cells = <3>;
+			clocks = <&clk_27MHz>;
+		};
+
+		main_aon_irq: intc@7d517ac0 {
+			compatible = "brcm,bcm7271-l2-intc";
+			reg = <0x7d517ac0 0x10>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		bsc_aon_irq: intc@7d517b00 {
+			compatible = "brcm,bcm7271-l2-intc";
+			reg = <0x7d517b00 0x10>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gio_aon: gpio@7d517c00 {
+			compatible = "brcm,brcmstb-gpio";
+			reg = <0x7d517c00 0x40>;
+			interrupt-parent = <&main_aon_irq>;
+			interrupts = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			brcm,gpio-bank-widths = <17 6>;
+			brcm,gpio-direct;
+		};
+
+		avs_monitor: avs-monitor@7d542000 {
+			compatible = "brcm,bcm2711-avs-monitor",
+				     "syscon", "simple-mfd";
+			reg = <0x7d542000 0xf00>;
+			status = "okay";
+
+			thermal: thermal {
+				compatible = "brcm,bcm2711-thermal";
+				#thermal-sensor-cells = <0>;
+			};
+		};
+
+		bsc_pmu: i2c@7d544000 {
+			compatible = "brcm,brcmstb-i2c";
+			reg = <0x7d544000 0x58>;
+			interrupt-parent = <&bsc_aon_irq>;
+			interrupts = <1>;
+			clock-frequency = <200000>;
+			status = "disabled";
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a76-pmu";
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		/* This only applies to the ARMv7 stub */
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "brcm,bcm2836-smp"; // for ARM 32-bit
+
+		/* Source for d/i cache-line-size, cache-sets, cache-size
+		 * https://developer.arm.com/documentation/100798/0401
+		 * /L1-memory-system/About-the-L1-memory-system?lang=en
+		 */
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x000>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x100>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l1>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x200>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x300>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l3>;
+		};
+
+		/* Source for cache-line-size and cache-sets:
+		 * https://developer.arm.com/documentation/100798/0401
+		 * /L2-memory-system/About-the-L2-memory-system?lang=en
+		 * and for cache-size:
+		 * https://www.raspberrypi.com/documentation/computers
+		 * /processors.html#bcm2712
+		 */
+		l2_cache_l0: l2-cache-l0 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l1: l2-cache-l1 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l2: l2-cache-l2 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l3: l2-cache-l3 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		/* Source for cache-line-size and cache-sets:
+		 * https://developer.arm.com/documentation/100453/0401/L3-cache?lang=en
+		 * Source for cache-size:
+		 * https://www.raspberrypi.com/documentation/computers/processors.html#bcm2712
+		 */
+		l3_cache: l3-cache {
+			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>; // 2MiB(size)/64(line-size)=32768ways/16-way set
+			cache-level = <3>;
+		};
+	};
+
+	psci {
+		method = "smc";
+		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
+		cpu_on = <0xc4000003>;
+		cpu_suspend = <0xc4000001>;
+		cpu_off = <0x84000002>;
+	};
+
+	axi: axi {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x00 0x00000000  0x00 0x00000000  0x10 0x00000000>,
+			 <0x10 0x00000000  0x10 0x00000000  0x01 0x00000000>,
+			 <0x14 0x00000000  0x14 0x00000000  0x04 0x00000000>,
+			 <0x18 0x00000000  0x18 0x00000000  0x04 0x00000000>,
+			 <0x1c 0x00000000  0x1c 0x00000000  0x04 0x00000000>;
+
+		dma-ranges = <0x00 0x00000000  0x00 0x00000000  0x10 0x00000000>,
+			     <0x10 0x00000000  0x10 0x00000000  0x01 0x00000000>,
+			     <0x14 0x00000000  0x14 0x00000000  0x04 0x00000000>,
+			     <0x18 0x00000000  0x18 0x00000000  0x04 0x00000000>,
+			     <0x1c 0x00000000  0x1c 0x00000000  0x04 0x00000000>;
+
+		sdio1: mmc@fff000 {
+			compatible = "brcm,bcm2712-sdhci";
+			reg = <0x10 0x00fff000  0x0 0x260>,
+			      <0x10 0x00fff400  0x0 0x200>,
+			      <0x10 0x015040b0  0x0 0x4>,  // Bus isolation control
+			      <0x10 0x015200f0  0x0 0x24>; // LCPLL control misc0-8
+			reg-names = "host", "cfg", "busisol", "lcpll";
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_emmc2>;
+			sdhci-caps-mask = <0x0000C000 0x0>;
+			sdhci-caps = <0x0 0x0>;
+			mmc-ddr-3_3v;
+			clock-names = "sw_sdio";
+		};
+
+		sdio2: mmc@1100000 {
+			compatible = "brcm,bcm2712-sdhci";
+			reg = <0x10 0x01100000  0x0 0x260>,
+			      <0x10 0x01100400  0x0 0x200>;
+			reg-names = "host", "cfg";
+			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_emmc2>;
+			sdhci-caps-mask = <0x0000C000 0x0>;
+			sdhci-caps = <0x0 0x0>;
+			supports-cqe;
+			mmc-ddr-3_3v;
+			status = "disabled";
+		};
+
+		bcm_reset: reset-controller@1504318 {
+			compatible = "brcm,brcmstb-reset";
+			reg = <0x10 0x01504318  0x0 0x30>;
+			#reset-cells = <1>;
+		};
+
+		gicv2: interrupt-controller@7fff9000 {
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			compatible = "arm,gic-400";
+			reg =	<0x10 0x7fff9000  0x0 0x1000>,
+				<0x10 0x7fffa000  0x0 0x2000>,
+				<0x10 0x7fffc000  0x0 0x2000>,
+				<0x10 0x7fffe000  0x0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+						 IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	clocks {
+		/* The oscillator is the root of the clock tree. */
+		clk_osc: clk-osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "osc";
+			clock-frequency = <54000000>;
+		};
+
+		clk_vpu: clk_vpu {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <750000000>;
+			clock-output-names = "vpu-clock";
+		};
+
+		clk_uart: clk_uart {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <9216000>;
+			clock-output-names = "uart-clock";
+		};
+
+		clk_emmc2: clk_emmc2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+			clock-output-names = "emmc2-clock";
+		};
+	};
+};
-- 
2.35.3


