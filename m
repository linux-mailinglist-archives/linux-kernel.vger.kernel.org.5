Return-Path: <linux-kernel+bounces-46515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E718440D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E5B31431
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20582899;
	Wed, 31 Jan 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCGAEjdi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254C83CA1;
	Wed, 31 Jan 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708346; cv=none; b=u5n5LphaZ8aFvJZYpaP8o6pa2INLI7xK89HRVo7pRSsR0wxQcYin3pfAyKniW+PSoqvTSkbL2b7u2qLKiBshmbTIjtIJ7gPRf6srmYwmwPyotwdrmIRvRYCrR2DleHwi+YRnXxli2mC79dH0eV4D78NH2iRcEo7P4R/X+WyYhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708346; c=relaxed/simple;
	bh=Qs4aSPJ6OwhjgwZyWHQMpPbuWNjlN+wugqCyOvtMx00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcLjUpah4bhsEKovDtKr/RCZxy2Qy1tCD6ZMHi++ABBd5LcOK25eV/g+T4zEGy2A7AaaLXIyeZpPEP/gvP/F/GNkZ5ILUzlKZEJZ5NFGRC8ozxj5FtYQa5Kr6nyQdF3hl6D0iN0BwRUdLBDQF+pxq3kMVOZshQZqQHVudZqnfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCGAEjdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2D5C433A6;
	Wed, 31 Jan 2024 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708345;
	bh=Qs4aSPJ6OwhjgwZyWHQMpPbuWNjlN+wugqCyOvtMx00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCGAEjdicB1LI1k6ii8fJPWylVWGvQpa75+K/+V1y+Rg5+d4FuZadpQWXkux0OqeG
	 Xj9hjI0RiEfRJPX7/cSq8eUuKoxBrW7PzIc3+g/cQnQaUmjnZ8Q2YmMXoJOWnhaOGj
	 Zg6qBKCv9S6glO14XWF2VMmEhe4o+ZOxQu3SabaBEb+AHXQuBxhp/17SRE8W0iyQI0
	 4XirMm6R5Vk/Inwt4OYnTfZXzrAIrGHWBHXL2dk89Osv9ukACpUVWzfZbSO+F21UjP
	 ec0H+FTpTbBBIYr+bKsx7USpUh3QaiQuI7QxWUBOKgWy6wcUPNW/cJ+idV6EU1BpXN
	 LFOLYPzChzEPg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards
Date: Wed, 31 Jan 2024 21:25:59 +0800
Message-ID: <20240131132600.4067-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131132600.4067-1-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare for Milkv Mars board dts support in the following
patch. Let's factored out common part into .dtsi.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 600 +----------------
 .../jh7110-visionfive2-mars-common.dtsi       | 617 ++++++++++++++++++
 2 files changed, 618 insertions(+), 599 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-visionfive2-mars-common.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 974851a764e1..76a2b061a421 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -5,82 +5,14 @@
  */
 
 /dts-v1/;
-#include "jh7110.dtsi"
-#include "jh7110-pinfunc.h"
-#include <dt-bindings/gpio/gpio.h>
+#include "jh7110-visionfive2-mars-common.dtsi"
 
 / {
 	aliases {
-		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
-		i2c0 = &i2c0;
-		i2c2 = &i2c2;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
-		mmc0 = &mmc0;
-		mmc1 = &mmc1;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x1 0x0>;
-	};
-
-	gpio-restart {
-		compatible = "gpio-restart";
-		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
-		priority = <224>;
-	};
-
-	pwmdac_codec: audio-codec {
-		compatible = "linux,spdif-dit";
-		#sound-dai-cells = <0>;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		simple-audio-card,dai-link@0 {
-			reg = <0>;
-			format = "left_j";
-			bitclock-master = <&sndcpu0>;
-			frame-master = <&sndcpu0>;
-
-			sndcpu0: cpu {
-				sound-dai = <&pwmdac>;
-			};
-
-			codec {
-				sound-dai = <&pwmdac_codec>;
-			};
-		};
 	};
 };
 
-&cpus {
-	timebase-frequency = <4000000>;
-};
-
-&dvp_clk {
-	clock-frequency = <74250000>;
-};
-
-&gmac0_rgmii_rxin {
-	clock-frequency = <125000000>;
-};
-
-&gmac0_rmii_refin {
-	clock-frequency = <50000000>;
-};
-
 &gmac1_rgmii_rxin {
 	clock-frequency = <125000000>;
 };
@@ -89,58 +21,6 @@ &gmac1_rmii_refin {
 	clock-frequency = <50000000>;
 };
 
-&hdmitx0_pixelclk {
-	clock-frequency = <297000000>;
-};
-
-&i2srx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2srx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&i2stx_bclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&i2stx_lrck_ext {
-	clock-frequency = <192000>;
-};
-
-&mclk_ext {
-	clock-frequency = <12288000>;
-};
-
-&osc {
-	clock-frequency = <24000000>;
-};
-
-&rtc_osc {
-	clock-frequency = <32768>;
-};
-
-&tdm_ext {
-	clock-frequency = <49152000>;
-};
-
-&gmac0 {
-	phy-handle = <&phy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-
-		phy0: ethernet-phy@0 {
-			reg = <0>;
-		};
-	};
-};
-
 &gmac1 {
 	phy-handle = <&phy1>;
 	phy-mode = "rgmii-id";
@@ -157,488 +37,10 @@ phy1: ethernet-phy@1 {
 	};
 };
 
-&i2c0 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&i2c5 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c5_pins>;
-	status = "okay";
-
-	axp15060: pmic@36 {
-		compatible = "x-powers,axp15060";
-		reg = <0x36>;
-		interrupts = <0>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-
-		regulators {
-			vcc_3v3: dcdc1 {
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_3v3";
-			};
-
-			vdd_cpu: dcdc2 {
-				regulator-always-on;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1540000>;
-				regulator-name = "vdd-cpu";
-			};
-
-			emmc_vdd: aldo4 {
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "emmc_vdd";
-			};
-		};
-	};
-};
-
-&i2c6 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <510>;
-	i2c-scl-falling-time-ns = <510>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
-	status = "okay";
-};
-
-&i2srx {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2srx_pins>;
-	status = "okay";
-};
-
-&i2stx0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mclk_ext_pins>;
-	status = "okay";
-};
-
-&i2stx1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2stx1_pins>;
-	status = "okay";
-};
-
 &mmc0 {
-	max-frequency = <100000000>;
-	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
-	assigned-clock-rates = <50000000>;
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
 	non-removable;
-	cap-mmc-hw-reset;
-	post-power-on-delay-ms = <200>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&emmc_vdd>;
-	status = "okay";
 };
 
 &mmc1 {
-	max-frequency = <100000000>;
-	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
-	assigned-clock-rates = <50000000>;
-	bus-width = <4>;
-	no-sdio;
-	no-mmc;
 	broken-cd;
-	cap-sd-highspeed;
-	post-power-on-delay-ms = <200>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	status = "okay";
-};
-
-&pwmdac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwmdac_pins>;
-	status = "okay";
-};
-
-&qspi {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	nor_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		cdns,read-delay = <5>;
-		spi-max-frequency = <12000000>;
-		cdns,tshsl-ns = <1>;
-		cdns,tsd2d-ns = <1>;
-		cdns,tchsh-ns = <1>;
-		cdns,tslch-ns = <1>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			spl@0 {
-				reg = <0x0 0x80000>;
-			};
-			uboot-env@f0000 {
-				reg = <0xf0000 0x10000>;
-			};
-			uboot@100000 {
-				reg = <0x100000 0x400000>;
-			};
-			reserved-data@600000 {
-				reg = <0x600000 0xa00000>;
-			};
-		};
-	};
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins>;
-	status = "okay";
-
-	spi_dev0: spi@0 {
-		compatible = "rohm,dh2228fv";
-		reg = <0>;
-		spi-max-frequency = <10000000>;
-	};
-};
-
-&sysgpio {
-	i2c0_pins: i2c0-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(57, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_CLK,
-					      GPI_SYS_I2C0_CLK)>,
-				 <GPIOMUX(58, GPOUT_LOW,
-					      GPOEN_SYS_I2C0_DATA,
-					      GPI_SYS_I2C0_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c2_pins: i2c2-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(3, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_CLK,
-					     GPI_SYS_I2C2_CLK)>,
-				 <GPIOMUX(2, GPOUT_LOW,
-					     GPOEN_SYS_I2C2_DATA,
-					     GPI_SYS_I2C2_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c5_pins: i2c5-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(19, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_CLK,
-					      GPI_SYS_I2C5_CLK)>,
-				 <GPIOMUX(20, GPOUT_LOW,
-					      GPOEN_SYS_I2C5_DATA,
-					      GPI_SYS_I2C5_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c6_pins: i2c6-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(16, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_CLK,
-					      GPI_SYS_I2C6_CLK)>,
-				 <GPIOMUX(17, GPOUT_LOW,
-					      GPOEN_SYS_I2C6_DATA,
-					      GPI_SYS_I2C6_DATA)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2srx_pins: i2srx-0 {
-		clk-sd-pins {
-			pinmux = <GPIOMUX(38, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_BCLK)>,
-				 <GPIOMUX(63, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_LRCK)>,
-				 <GPIOMUX(38, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2STX1_BCLK)>,
-				 <GPIOMUX(63, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2STX1_LRCK)>,
-				 <GPIOMUX(61, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_SDIN0)>;
-			input-enable;
-		};
-	};
-
-	i2stx1_pins: i2stx1-0 {
-		sd-pins {
-			pinmux = <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			input-disable;
-		};
-	};
-
-	mclk_ext_pins: mclk-ext-0 {
-		mclk-ext-pins {
-			pinmux = <GPIOMUX(4, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_MCLK_EXT)>;
-			input-enable;
-		};
-	};
-
-	mmc0_pins: mmc0-0 {
-		 rst-pins {
-			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mmc-pins {
-			pinmux = <PINMUX(64, 0)>,
-				 <PINMUX(65, 0)>,
-				 <PINMUX(66, 0)>,
-				 <PINMUX(67, 0)>,
-				 <PINMUX(68, 0)>,
-				 <PINMUX(69, 0)>,
-				 <PINMUX(70, 0)>,
-				 <PINMUX(71, 0)>,
-				 <PINMUX(72, 0)>,
-				 <PINMUX(73, 0)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-		};
-	};
-
-	mmc1_pins: mmc1-0 {
-		clk-pins {
-			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		mmc-pins {
-			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
-					     GPOEN_SYS_SDIO1_CMD,
-					     GPI_SYS_SDIO1_CMD)>,
-				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
-					      GPOEN_SYS_SDIO1_DATA0,
-					      GPI_SYS_SDIO1_DATA0)>,
-				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
-					      GPOEN_SYS_SDIO1_DATA1,
-					      GPI_SYS_SDIO1_DATA1)>,
-				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
-					     GPOEN_SYS_SDIO1_DATA2,
-					     GPI_SYS_SDIO1_DATA2)>,
-				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
-					     GPOEN_SYS_SDIO1_DATA3,
-					     GPI_SYS_SDIO1_DATA3)>;
-			bias-pull-up;
-			drive-strength = <12>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-
-	pwmdac_pins: pwmdac-0 {
-		pwmdac-pins {
-			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>,
-				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			drive-strength = <2>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-
-	spi0_pins: spi0-0 {
-		mosi-pins {
-			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-
-		miso-pins {
-			pinmux = <GPIOMUX(53, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_SPI0_RXD)>;
-			bias-pull-up;
-			input-enable;
-			input-schmitt-enable;
-		};
-
-		sck-pins {
-			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
-					      GPOEN_ENABLE,
-					      GPI_SYS_SPI0_CLK)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-
-		ss-pins {
-			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
-					      GPOEN_ENABLE,
-					      GPI_SYS_SPI0_FSS)>;
-			bias-disable;
-			input-disable;
-			input-schmitt-disable;
-		};
-	};
-
-	tdm_pins: tdm-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <2>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(61, GPOUT_HIGH,
-					      GPOEN_DISABLE,
-					      GPI_SYS_TDM_RXD)>;
-			input-enable;
-		};
-
-		sync-pins {
-			pinmux = <GPIOMUX(63, GPOUT_HIGH,
-					      GPOEN_DISABLE,
-					      GPI_SYS_TDM_SYNC)>;
-			input-enable;
-		};
-
-		pcmclk-pins {
-			pinmux = <GPIOMUX(38, GPOUT_HIGH,
-					      GPOEN_DISABLE,
-					      GPI_SYS_TDM_CLK)>;
-			input-enable;
-		};
-	};
-
-	uart0_pins: uart0-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
-					     GPOEN_ENABLE,
-					     GPI_NONE)>;
-			bias-disable;
-			drive-strength = <12>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(6, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_UART0_RX)>;
-			bias-disable; /* external pull-up */
-			drive-strength = <2>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-	};
-};
-
-&tdm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&tdm_pins>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins>;
-	status = "okay";
-};
-
-&usb0 {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&U74_1 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_2 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_3 {
-	cpu-supply = <&vdd_cpu>;
-};
-
-&U74_4 {
-	cpu-supply = <&vdd_cpu>;
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7110-visionfive2-mars-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-visionfive2-mars-common.dtsi
new file mode 100644
index 000000000000..72f527a9e75e
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-visionfive2-mars-common.dtsi
@@ -0,0 +1,617 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh7110.dtsi"
+#include "jh7110-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		ethernet0 = &gmac0;
+		i2c0 = &i2c0;
+		i2c2 = &i2c2;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x1 0x0>;
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
+		priority = <224>;
+	};
+
+	pwmdac_codec: audio-codec {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "left_j";
+			bitclock-master = <&sndcpu0>;
+			frame-master = <&sndcpu0>;
+
+			sndcpu0: cpu {
+				sound-dai = <&pwmdac>;
+			};
+
+			codec {
+				sound-dai = <&pwmdac_codec>;
+			};
+		};
+	};
+};
+
+&cpus {
+	timebase-frequency = <4000000>;
+};
+
+&dvp_clk {
+	clock-frequency = <74250000>;
+};
+
+&gmac0_rgmii_rxin {
+	clock-frequency = <125000000>;
+};
+
+&gmac0_rmii_refin {
+	clock-frequency = <50000000>;
+};
+
+&hdmitx0_pixelclk {
+	clock-frequency = <297000000>;
+};
+
+&i2srx_bclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&i2srx_lrck_ext {
+	clock-frequency = <192000>;
+};
+
+&i2stx_bclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&i2stx_lrck_ext {
+	clock-frequency = <192000>;
+};
+
+&mclk_ext {
+	clock-frequency = <12288000>;
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&rtc_osc {
+	clock-frequency = <32768>;
+};
+
+&tdm_ext {
+	clock-frequency = <49152000>;
+};
+
+&gmac0 {
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&i2c5 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	status = "okay";
+
+	axp15060: pmic@36 {
+		compatible = "x-powers,axp15060";
+		reg = <0x36>;
+		interrupts = <0>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		regulators {
+			vcc_3v3: dcdc1 {
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3";
+			};
+
+			vdd_cpu: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1540000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			emmc_vdd: aldo4 {
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "emmc_vdd";
+			};
+		};
+	};
+};
+
+&i2c6 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <510>;
+	i2c-scl-falling-time-ns = <510>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	status = "okay";
+};
+
+&i2srx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2srx_pins>;
+	status = "okay";
+};
+
+&i2stx0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mclk_ext_pins>;
+	status = "okay";
+};
+
+&i2stx1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2stx1_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
+	assigned-clock-rates = <50000000>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	cap-mmc-hw-reset;
+	post-power-on-delay-ms = <200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <100000000>;
+	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
+	assigned-clock-rates = <50000000>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	cap-sd-highspeed;
+	post-power-on-delay-ms = <200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	status = "okay";
+};
+
+&pwmdac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwmdac_pins>;
+	status = "okay";
+};
+
+&qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	nor_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		cdns,read-delay = <5>;
+		spi-max-frequency = <12000000>;
+		cdns,tshsl-ns = <1>;
+		cdns,tsd2d-ns = <1>;
+		cdns,tchsh-ns = <1>;
+		cdns,tslch-ns = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			spl@0 {
+				reg = <0x0 0x80000>;
+			};
+			uboot-env@f0000 {
+				reg = <0xf0000 0x10000>;
+			};
+			uboot@100000 {
+				reg = <0x100000 0x400000>;
+			};
+			reserved-data@600000 {
+				reg = <0x600000 0xa00000>;
+			};
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "okay";
+
+	spi_dev0: spi@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
+&sysgpio {
+	i2c0_pins: i2c0-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(57, GPOUT_LOW,
+					      GPOEN_SYS_I2C0_CLK,
+					      GPI_SYS_I2C0_CLK)>,
+				 <GPIOMUX(58, GPOUT_LOW,
+					      GPOEN_SYS_I2C0_DATA,
+					      GPI_SYS_I2C0_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c2_pins: i2c2-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(3, GPOUT_LOW,
+					     GPOEN_SYS_I2C2_CLK,
+					     GPI_SYS_I2C2_CLK)>,
+				 <GPIOMUX(2, GPOUT_LOW,
+					     GPOEN_SYS_I2C2_DATA,
+					     GPI_SYS_I2C2_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c5_pins: i2c5-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(19, GPOUT_LOW,
+					      GPOEN_SYS_I2C5_CLK,
+					      GPI_SYS_I2C5_CLK)>,
+				 <GPIOMUX(20, GPOUT_LOW,
+					      GPOEN_SYS_I2C5_DATA,
+					      GPI_SYS_I2C5_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c6_pins: i2c6-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(16, GPOUT_LOW,
+					      GPOEN_SYS_I2C6_CLK,
+					      GPI_SYS_I2C6_CLK)>,
+				 <GPIOMUX(17, GPOUT_LOW,
+					      GPOEN_SYS_I2C6_DATA,
+					      GPI_SYS_I2C6_DATA)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2srx_pins: i2srx-0 {
+		clk-sd-pins {
+			pinmux = <GPIOMUX(38, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2SRX_BCLK)>,
+				 <GPIOMUX(63, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2SRX_LRCK)>,
+				 <GPIOMUX(38, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2STX1_BCLK)>,
+				 <GPIOMUX(63, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2STX1_LRCK)>,
+				 <GPIOMUX(61, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_I2SRX_SDIN0)>;
+			input-enable;
+		};
+	};
+
+	i2stx1_pins: i2stx1-0 {
+		sd-pins {
+			pinmux = <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+		};
+	};
+
+	mclk_ext_pins: mclk-ext-0 {
+		mclk-ext-pins {
+			pinmux = <GPIOMUX(4, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_MCLK_EXT)>;
+			input-enable;
+		};
+	};
+
+	mmc0_pins: mmc0-0 {
+		 rst-pins {
+			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mmc-pins {
+			pinmux = <PINMUX(64, 0)>,
+				 <PINMUX(65, 0)>,
+				 <PINMUX(66, 0)>,
+				 <PINMUX(67, 0)>,
+				 <PINMUX(68, 0)>,
+				 <PINMUX(69, 0)>,
+				 <PINMUX(70, 0)>,
+				 <PINMUX(71, 0)>,
+				 <PINMUX(72, 0)>,
+				 <PINMUX(73, 0)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+		};
+	};
+
+	mmc1_pins: mmc1-0 {
+		clk-pins {
+			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mmc-pins {
+			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
+					     GPOEN_SYS_SDIO1_CMD,
+					     GPI_SYS_SDIO1_CMD)>,
+				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
+					      GPOEN_SYS_SDIO1_DATA0,
+					      GPI_SYS_SDIO1_DATA0)>,
+				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
+					      GPOEN_SYS_SDIO1_DATA1,
+					      GPI_SYS_SDIO1_DATA1)>,
+				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
+					     GPOEN_SYS_SDIO1_DATA2,
+					     GPI_SYS_SDIO1_DATA2)>,
+				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
+					     GPOEN_SYS_SDIO1_DATA3,
+					     GPI_SYS_SDIO1_DATA3)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwmdac_pins: pwmdac-0 {
+		pwmdac-pins {
+			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>,
+				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	spi0_pins: spi0-0 {
+		mosi-pins {
+			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		miso-pins {
+			pinmux = <GPIOMUX(53, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_SPI0_RXD)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		sck-pins {
+			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_CLK)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		ss-pins {
+			pinmux = <GPIOMUX(49, GPOUT_SYS_SPI0_FSS,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_FSS)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
+	tdm_pins: tdm-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(61, GPOUT_HIGH,
+					      GPOEN_DISABLE,
+					      GPI_SYS_TDM_RXD)>;
+			input-enable;
+		};
+
+		sync-pins {
+			pinmux = <GPIOMUX(63, GPOUT_HIGH,
+					      GPOEN_DISABLE,
+					      GPI_SYS_TDM_SYNC)>;
+			input-enable;
+		};
+
+		pcmclk-pins {
+			pinmux = <GPIOMUX(38, GPOUT_HIGH,
+					      GPOEN_DISABLE,
+					      GPI_SYS_TDM_CLK)>;
+			input-enable;
+		};
+	};
+
+	uart0_pins: uart0-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
+					     GPOEN_ENABLE,
+					     GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(6, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_UART0_RX)>;
+			bias-disable; /* external pull-up */
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&tdm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&tdm_pins>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&U74_1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&U74_4 {
+	cpu-supply = <&vdd_cpu>;
+};
-- 
2.43.0


