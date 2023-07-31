Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38A6768983
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGaBSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGaBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:18:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9DDA1A4;
        Sun, 30 Jul 2023 18:18:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3080168F;
        Sun, 30 Jul 2023 18:19:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD283F5A1;
        Sun, 30 Jul 2023 18:18:21 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
Date:   Mon, 31 Jul 2023 02:17:23 +0100
Message-Id: <20230731011725.7228-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230731011725.7228-1-andre.przywara@arm.com>
References: <20230731011725.7228-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Orange Pi Zero 2 got a successor (Zero 3), which shares quite some
DT nodes with the Zero 2, but comes with a different PMIC.

Move the common parts (except the PMIC) into a new shared file, and
include that from the existing board .dts file.

No functional change, the generated DTB is the same, except some phandle
numbering differences.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
 .../allwinner/sun50i-h616-orangepi-zerox.dtsi | 131 ++++++++++++++++++
 2 files changed, 132 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
index cb8600d0ea1ef..c786b170fb9a8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
@@ -5,95 +5,19 @@
 
 /dts-v1/;
 
-#include "sun50i-h616.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/leds/common.h>
+#include "sun50i-h616-orangepi-zerox.dtsi"
 
 / {
 	model = "OrangePi Zero2";
 	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
-
-	aliases {
-		ethernet0 = &emac0;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			function = LED_FUNCTION_POWER;
-			color = <LED_COLOR_ID_RED>;
-			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
-			default-state = "on";
-		};
-
-		led-1 {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_GREEN>;
-			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 */
-		};
-	};
-
-	reg_vcc5v: vcc5v {
-		/* board wide 5V supply directly from the USB-C socket */
-		compatible = "regulator-fixed";
-		regulator-name = "vcc-5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
-
-	reg_usb1_vbus: regulator-usb1-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "usb1-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&reg_vcc5v>;
-		enable-active-high;
-		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
-	};
 };
 
-&ehci1 {
-	status = "okay";
-};
-
-/* USB 2 & 3 are on headers only. */
-
 &emac0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ext_rgmii_pins>;
-	phy-mode = "rgmii";
-	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_dcdce>;
-	allwinner,rx-delay-ps = <3100>;
-	allwinner,tx-delay-ps = <700>;
-	status = "okay";
-};
-
-&mdio0 {
-	ext_rgmii_phy: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-	};
 };
 
 &mmc0 {
 	vmmc-supply = <&reg_dcdce>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
-	bus-width = <4>;
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
 };
 
 &r_rsb {
@@ -211,44 +135,3 @@ &pio {
 	vcc-ph-supply = <&reg_aldo1>;
 	vcc-pi-supply = <&reg_aldo1>;
 };
-
-&spi0  {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
-
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_ph_pins>;
-	status = "okay";
-};
-
-&usbotg {
-	/*
-	 * PHY0 pins are connected to a USB-C socket, but a role switch
-	 * is not implemented: both CC pins are pulled to GND.
-	 * The VBUS pins power the device, so a fixed peripheral mode
-	 * is the best choice.
-	 * The board can be powered via GPIOs, in this case port0 *can*
-	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
-	 * then provided by the GPIOs. Any user of this setup would
-	 * need to adjust the DT accordingly: dr_mode set to "host",
-	 * enabling OHCI0 and EHCI0.
-	 */
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi
new file mode 100644
index 0000000000000..56c7e1d87bd95
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2020 Arm Ltd.
+ */
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		ethernet0 = &emac0;
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
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
+			default-state = "on";
+		};
+
+		led-1 {
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
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_vcc5v>;
+		enable-active-high;
+		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+/* USB 2 & 3 are on headers only. */
+
+&emac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	allwinner,rx-delay-ps = <3100>;
+	allwinner,tx-delay-ps = <700>;
+	status = "okay";
+};
+
+&mdio0 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&spi0  {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
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
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.35.8

