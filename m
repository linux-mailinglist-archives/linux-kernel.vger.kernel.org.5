Return-Path: <linux-kernel+bounces-60229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D748501A8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F621F255AA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB113A1BD;
	Sat, 10 Feb 2024 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTTG5bG9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50D1EEFC;
	Sat, 10 Feb 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528082; cv=none; b=Z+uNCsUVejP/W001ViXTy3cRVOod44721eS5H480tXNrveyafcxKHF43fYbu5LuFKF3cULE5XL47H/Ue1H4ToT4exRrLxyVY/C2HwaJyQn8J5iFQwKDSK2opW2EGkKFyttC38P2jiWb6L9Mw98gfxIMLyZ/E9/FE+Sbtu61tias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528082; c=relaxed/simple;
	bh=ARG2AkAQTI7mIyrNgp6Em/JtWCLuWczye2541q0j+0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li97Xet30CC98Vb54HgleigBOML8kscPYPI1anqltWtN53pbznmCwUL8Y1HIzIi0lCKJqO/FRtM0vAlgVJ08Gmk6w+qhL82VcRKxc/nb4aM1ep80h0jd5/1vIJVUT8HkK7BpS/rxmke6zdey8f05CX5sulxCTQ59mTtHN/NPXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTTG5bG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5D7C32782;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=ARG2AkAQTI7mIyrNgp6Em/JtWCLuWczye2541q0j+0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTTG5bG97vSQm/o2181lcpq2eovrYaFn/1lLwCC3ypYpDJiyMHe+KtADdAhXF0WvJ
	 Y/dKu6p9h6NKHe2GpPPJ9+wmDYfCo/56WIMKDfTnmoLnLzkmWoBRoDGAsI3fRh4DUo
	 Q8iyfhypajtbk6U4b5Fb4D5/cKCxiSMNLoWdhf4kljUN2YHHyp7OGE2plfn7Buw++W
	 apr1o5KL9jvjMQvKb1J8J4wuhx2XeXUBpda0mNATpBdMSV+qc6hRSx5yyQD9wS6BqC
	 rzwtGcbRfIkKzPy3t0fCUFz0niVrr6Y0qJHc2ct0UeMGEdc9E7b+LIA3SEvb0ZvxB3
	 6JNZvP7knSSAA==
Received: by mercury (Postfix, from userid 1000)
	id 064071069F7E; Sat, 10 Feb 2024 02:21:16 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/14] ARM: dts: imx6ull-uti260b: Add board
Date: Sat, 10 Feb 2024 02:18:18 +0100
Message-ID: <20240210012114.489102-15-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210012114.489102-1-sre@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add UNI-T UTi260b thermal camera board.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts | 564 ++++++++++++++++++
 2 files changed, 565 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index a724d1a7a9a0..47350cf3ddeb 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -349,6 +349,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-tarragon-slavext.dtb \
 	imx6ull-tqma6ull2-mba6ulx.dtb \
 	imx6ull-tqma6ull2l-mba6ulx.dtb \
+	imx6ull-uti260b.dtb \
 	imx6ulz-14x14-evk.dtb \
 	imx6ulz-bsh-smm-m2.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts
new file mode 100644
index 000000000000..336727895fa4
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-uti260b.dts
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2022 Sebastian Reichel <sre@kernel.org>
+
+/dts-v1/;
+#include "imx6ull.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/clock/imx6ul-clock.h>
+
+/ {
+	model = "UNI-T UTi260B Thermal Camera";
+	compatible = "uni-t,imx6ull-uti260b", "fsl,imx6ull";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_led_ctrl>;
+
+		led {
+			label = "led";
+			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_gpio_keys>;
+		autorepeat;
+
+		up-key {
+			label = "Up";
+			gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_UP>;
+		};
+
+		down-key {
+			label = "Down";
+			gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_DOWN>;
+		};
+
+		left-key {
+			label = "Left";
+			gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFT>;
+		};
+
+		right-key {
+			label = "Right";
+			gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RIGHT>;
+		};
+
+		ok-key {
+			label = "Ok";
+			gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ENTER>;
+		};
+
+		return-key {
+			label = "Return";
+			gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ESC>;
+		};
+
+		play-key {
+			label = "Media";
+			gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MEDIA>;
+		};
+
+		trigger-key {
+			label = "Trigger";
+			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_TRIGGER>;
+		};
+
+		power-key {
+			label = "Power";
+			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+		};
+
+		light-key {
+			label = "Light";
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LIGHTS_TOGGLE>;
+		};
+	};
+
+	panel_backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		enable-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_backlight_enable>;
+		power-supply = <&reg_vsd>;
+		pwms = <&pwm1 0 50000 0>;
+	};
+
+	reg_vsd: regulator-vsd {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_vref: regulator-vref-4v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREF_4V2";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+	};
+
+	tp5000: charger {
+		compatible = "gpio-charger";
+		charger-type = "usb-sdp";
+		gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_charger_stat1>;
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		/* generic 26650 battery */
+		device-chemistry = "lithium-ion";
+		charge-full-design-microamp-hours = <5000000>;
+		voltage-max-design-microvolt = <4200000>;
+		voltage-min-design-microvolt = <3300000>;
+	};
+
+	fuel-gauge {
+		compatible = "adc-battery";
+		charged-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+		io-channel-names = "voltage";
+		io-channels = <&adc1 7>;
+		monitored-battery = <&battery>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_charger_stat2>;
+		power-supplies = <&tp5000>;
+	};
+
+	poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_poweroff>;
+	};
+};
+
+&gpio1 {
+	ir-reset-hog {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_LOW>;
+		line-name = "ir-reset-gpio";
+		output-low;
+		pinctrl-0 = <&mux_ir_reset>;
+	};
+};
+
+&gpio2 {
+	/* configuring this to output-high results in poweroff */
+	power-en-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		line-name = "power-en-gpio";
+		output-low;
+		pinctrl-0 = <&mux_poweroff2>;
+	};
+};
+
+&ecspi3 {
+	cs-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_spi3>, <&mux_spi3_cs>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "inanbo,t28cp45tn89-v17";
+		reg = <0>;
+		backlight = <&panel_backlight>;
+		power-supply = <&reg_vsd>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency = <100000>;
+		spi-rx-bus-width = <0>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_uart>;
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_pwm>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_i2c1>;
+	status = "okay";
+
+	camera@21 {
+		compatible = "galaxycore,gc0308";
+		reg = <0x21>;
+		clocks = <&clks IMX6UL_CLK_CSI>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mux_gc0308>;
+		powerdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		vdd28-supply = <&reg_vsd>;
+
+		port {
+			gc0308_to_parallel: endpoint {
+				remote-endpoint = <&parallel_from_gc0308>;
+				bus-width = <8>;
+				data-shift = <2>; /* lines 9:2 are used */
+				hsync-active = <1>; /* active high */
+				vsync-active = <1>; /* active high */
+				data-active = <1>; /* active high */
+				pclk-sample = <1>; /* sample on rising edge */
+			};
+		};
+	};
+};
+
+&csi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_csi>;
+
+	port {
+		parallel_from_gc0308: endpoint {
+			remote-endpoint = <&gc0308_to_parallel>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_i2c2>;
+	status = "okay";
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&lcdif {
+	assigned-clocks = <&clks IMX6UL_CLK_LCDIF_PRE_SEL>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL5_VIDEO_DIV>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_lcd_data>, <&mux_lcd_ctrl>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&usdhc1 {
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	no-1-8-v;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&mux_sdhc1>, <&mux_sdhc1_cd>;
+	pinctrl-1 = <&mux_sdhc1_100mhz>, <&mux_sdhc1_cd>;
+	pinctrl-2 = <&mux_sdhc1_200mhz>, <&mux_sdhc1_cd>;
+	wakeup-source;
+	vmmc-supply = <&reg_vsd>;
+	status = "okay";
+};
+
+&usdhc2 {
+	keep-power-in-suspend;
+	no-1-8-v;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_sdhc2>;
+	wakeup-source;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_wdog>;
+};
+
+&adc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mux_adc>;
+	vref-supply = <&reg_vref>;
+	#io-channel-cells = <1>;
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <106>;
+};
+
+&iomuxc {
+	mux_ir_reset: irresetgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0x3008
+		>;
+	};
+
+	mux_poweroff: poweroffgrp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04		0x3008
+		>;
+	};
+
+	mux_poweroff2: poweroff2grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_TX_CLK__GPIO2_IO06		0x3008
+		>;
+	};
+
+	mux_charger_stat1: charger1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0x3008
+		>;
+	};
+
+	mux_charger_stat2: charger2grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0x3008
+		>;
+	};
+
+	mux_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY		0x30b0
+		>;
+	};
+
+	mux_sdhc1_cd: sdhc1-cd-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19		0x17059
+		>;
+	};
+
+	mux_sdhc1: sdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD			0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK			0x10071
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0		0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1		0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2		0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3		0x17059
+		>;
+	};
+
+	mux_sdhc1_100mhz: sdhc1-100mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD			0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK			0x170b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0		0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1		0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2		0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3		0x170b9
+		>;
+	};
+
+	mux_sdhc1_200mhz: sdhc1-200mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD			0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK			0x170f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0		0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1		0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2		0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3		0x170f9
+		>;
+	};
+
+	mux_sdhc2: sdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK			0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD			0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0		0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1		0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2		0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3		0x17059
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4		0x17059
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5		0x17059
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6		0x17059
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7		0x17059
+		>;
+	};
+
+	mux_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL		0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA		0x4001b8b0
+		>;
+	};
+
+	mux_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL		0x4001f8a8
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA		0x4001f8a8
+		>;
+	};
+
+	mux_uart: uartgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX		0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX		0x1b0b1
+		>;
+	};
+
+	mux_gpio_keys: gpiokeygrp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11		0x3008
+			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12		0x3008
+			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13		0x3008
+			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10		0x3008
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09		0x3008
+			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15		0x3008
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08		0x3008
+			MX6UL_PAD_ENET2_TX_CLK__GPIO2_IO14		0x3008
+			MX6UL_PAD_ENET1_TX_DATA0__GPIO2_IO03		0x3008
+			MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01		0x3008
+		>;
+	};
+
+	mux_led_ctrl: ledctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__GPIO2_IO02		0x3008
+		>;
+	};
+
+	mux_adc: adcgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__GPIO1_IO07		0xb0
+		>;
+	};
+
+	mux_pwm: pwm1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO08__PWM1_OUT			0x110b0
+		>;
+	};
+
+	mux_backlight_enable: blenablegrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09		0x3008
+		>;
+	};
+
+	mux_lcd_data: lcdifdatgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00		0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01		0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02		0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03		0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04		0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05		0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06		0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07		0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08		0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09		0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10		0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11		0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12		0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13		0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14		0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15		0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16		0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17		0x79
+		>;
+	};
+
+	mux_lcd_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK			0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE		0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC		0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC		0x79
+		>;
+	};
+
+	mux_csi: csi1grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__CSI_PIXCLK		0x1b088
+			MX6UL_PAD_CSI_VSYNC__CSI_VSYNC			0x1b088
+			MX6UL_PAD_CSI_HSYNC__CSI_HSYNC			0x1b088
+			MX6UL_PAD_CSI_DATA00__CSI_DATA02		0x1b088
+			MX6UL_PAD_CSI_DATA01__CSI_DATA03		0x1b088
+			MX6UL_PAD_CSI_DATA02__CSI_DATA04		0x1b088
+			MX6UL_PAD_CSI_DATA03__CSI_DATA05		0x1b088
+			MX6UL_PAD_CSI_DATA04__CSI_DATA06		0x1b088
+			MX6UL_PAD_CSI_DATA05__CSI_DATA07		0x1b088
+			MX6UL_PAD_CSI_DATA06__CSI_DATA08		0x1b088
+			MX6UL_PAD_CSI_DATA07__CSI_DATA09		0x1b088
+		>;
+	};
+
+	mux_gc0308: gc0308grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_MCLK__CSI_MCLK			0x1e038
+			MX6UL_PAD_GPIO1_IO05__GPIO1_IO05		0x1b088
+			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06		0x1b088
+		>;
+	};
+
+
+	mux_spi3: ecspi3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI		0x100b1
+			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK		0x100b1
+		>;
+	};
+
+	mux_spi3_cs: ecspi3_csgrp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20		0x3008
+		>;
+	};
+};
-- 
2.43.0


