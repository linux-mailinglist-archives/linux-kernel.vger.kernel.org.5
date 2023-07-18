Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9132757C34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGRMuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjGRMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:50:05 -0400
Received: from mail.croughan.sh (mail.croughan.sh [135.181.193.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A70198;
        Tue, 18 Jul 2023 05:50:04 -0700 (PDT)
From:   Matthew Croughan <matthew.croughan@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1689684600; bh=nwlBb65OLa7zMh3H51fSU4uBOp2MNxRFHVyMKLw7ne8=;
        h=From:To:Cc:Subject:Date;
        b=WaeuGGt9ajw5LFAm9PDNAjkmciSaA2j0vsA3H9bhddl6D0Ohzg56Pnf6U679Lsx7+
         FVAy3xzU9ct1hru3Ai2NRF7F4wPrGeZywShwD3XaxK3ltJq0pWDvI2wYQsSI2mU6Tz
         z7cgHN9ox4UQZ2YpVcIw0vJM8jmPAL+AbWtIERo0=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Matthew Croughan <matthew.croughan@nix.how>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
Date:   Tue, 18 Jul 2023 13:47:51 +0100
Message-ID: <20230718124752.1279094-1-matthew.croughan@nix.how>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mango Pi MQ Quad is a H616 based SBC, add basic support for the board
and its peripherals
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 6a96494a2e0a..06c5b97dbfc3 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-mangopi-mq-quad.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
new file mode 100644
index 000000000000..47fd49af2886
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Arm Ltd.
+/*
+ * Copyright (C) 2023 Matthew Croughan <matthew.croughan@nix.how>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "MangoPi MQ-Quad";
+	compatible = "widora,mangopi-mq-quad", "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
+		};
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the USB-C socket */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		/* board wide 3V3 supply directly from SY8008 regulator */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+/* USB 2 & 3 are on headers only. */
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	rtl8723ds: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 15 IRQ_TYPE_LEVEL_LOW>; /* PG15 */
+		interrupt-names = "host-wake";
+	};
+};
+
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723ds-bt";
+		device-wake-gpios = <&pio 6 17 GPIO_ACTIVE_HIGH>; /* PG17 */
+		enable-gpios = <&pio 6 19 GPIO_ACTIVE_HIGH>; /* PG19 */
+		host-wake-gpios = <&pio 6 16 GPIO_ACTIVE_HIGH>; /* PG16 */
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313a: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		x-powers,self-working-mode;
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-1v8";
+			};
+
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3-pmic";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vdd-dram";
+			};
+
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usbotg {
+	/*
+	 * PHY0 pins are connected to a USB-C socket, but a role switch
+	 * is not implemented: both CC pins are pulled to GND.
+	 * The VBUS pins power the device, so a fixed peripheral mode
+	 * is the best choice.
+	 * The board can be powered via GPIOs, in this case port0 *can*
+	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
+	 * then provided by the GPIOs. Any user of this setup would
+	 * need to adjust the DT accordingly: dr_mode set to "host",
+	 * enabling OHCI0 and EHCI0.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
-- 
2.41.0

