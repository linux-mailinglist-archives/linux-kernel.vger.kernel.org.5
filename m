Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC558072E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442269AbjLFOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442111AbjLFOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:45:08 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B715198B;
        Wed,  6 Dec 2023 06:44:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADF9FBFD15;
        Wed,  6 Dec 2023 15:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701873889; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=LzCepDPihJFEKeRie8QIRkXeAXlAu8NPaswOAfzNp8c=;
        b=oiq+3yC8b1H9TqXnTWRzOw3pndvyxQRJUN07OMNivKWAAXfy1FZIhfu/b6O2kuP9eUpVBK
        LGMpVf1KFNwHXvKV6ir6bmVREEsNmvm2Y53N0BkQEDLR//uRZm5DCKz3AebN4wEYYa5wlM
        YCPu40uYPXbrURSx25Jc9LRduDrBsmcAro+bm2mcrhX58cxhzqRdBKCYOHSBpXAeOjbFGK
        9WMIIweEHlNOWmzw1v7Ti/kTA9jcgGtotyA6d3o1nVXmSItrxrSrrwqJR21ifCw/VOzV0m
        H7SSaWPyTQ1ZE7hvlg324VioelStMk8981f5vIwxFE/aGX9XmvfguZnNwBxavg==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 14/14] arm64: dts: imx8mm-kontron: Refactor devicetree for OSM-S module and board
Date:   Wed,  6 Dec 2023 15:41:17 +0100
Message-ID: <20231206144201.46911-15-frieder@fris.de>
In-Reply-To: <20231206144201.46911-1-frieder@fris.de>
References: <20231206144201.46911-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The OSM spec defines dedicated functions for all pads of the SoM.
Therefore we can assume that carrier board designs stick to these
definitions and extend the SoM devicetree include with matching
default nodes and pinmux settings.

This way we can reduce the overhead and redundancy in the carrier
board devicetrees while still sticking to the policy of separating
board and module description.

Even if the carrier board design deviates slightly from the spec it
can define its own pinmux definitions and use them as necessary or
even disable unused nodes from the SoM devicetree.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* Address Shawn's review comments (thanks!)

Changes for v2:
* none
---
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts | 269 +++------
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   | 552 +++++++++++++++++-
 2 files changed, 616 insertions(+), 205 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
index 12f786a72fbd5..efadfdff00af1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
@@ -25,8 +25,6 @@ osc_can: clock-osc-can {
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
 
 		led1 {
 			label = "led1";
@@ -52,24 +50,12 @@ pwm-beeper {
 
 	reg_rst_eth2: regulator-rst-eth2 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usb_eth2>;
 		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
 		regulator-name = "rst-usb-eth2";
 	};
 
-	reg_usb1_vbus: regulator-usb1-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb1_vbus>;
-		gpio = <&gpio3 25 GPIO_ACTIVE_LOW>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-name = "usb1-vbus";
-	};
-
 	reg_vdd_5v: regulator-5v {
 		compatible = "regulator-fixed";
 		regulator-always-on;
@@ -80,9 +66,6 @@ reg_vdd_5v: regulator-5v {
 };
 
 &ecspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	can@0 {
@@ -103,9 +86,6 @@ can@0 {
 };
 
 &ecspi3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi3>;
-	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeram@0 {
@@ -117,7 +97,7 @@ eeram@0 {
 
 &fec1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
+	pinctrl-0 = <&pinctrl_enet_rgmii>;
 	phy-connection-type = "rgmii-id";
 	phy-handle = <&ethphy>;
 	status = "okay";
@@ -136,27 +116,59 @@ ethphy: ethernet-phy@0 {
 	};
 };
 
+/*
+ * Rename SoM signals according to board usage:
+ *   GPIO_B_0      -> DIO1_OUT
+ *   GPIO_B_1      -> DIO2_OUT
+ */
 &gpio1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio1>;
-	gpio-line-names = "", "", "", "dio1-out", "", "", "dio1-in", "dio2-out",
-			  "dio2-in", "dio3-out", "dio3-in", "dio4-out", "", "", "", "",
-			  "", "", "", "", "", "", "", "",
-			  "", "", "", "", "", "", "", "";
+	gpio-line-names = "", "GPIO_A_0", "", "GPIO_A_1",
+			  "", "GPIO_A_2", "GPIO_A_3", "GPIO_A_4",
+			  "GPIO_A_5", "GPIO_A_6", "GPIO_A_7", "DIO1_OUT",
+			  "DIO2_OUT", "USB_A_OC#", "CAM_MCK", "USB_B_OC#",
+			  "ETH_MDC", "ETH_MDIO", "ETH_A_(S)(R)(G)MII_TXD3",
+			  "ETH_A_(S)(R)(G)MII_TXD2", "ETH_A_(S)(R)(G)MII_TXD1",
+			  "ETH_A_(S)(R)(G)MII_TXD0", "ETH_A_(R)(G)MII_TX_EN(_ER)",
+			  "ETH_A_(R)(G)MII_TX_CLK", "ETH_A_(R)(G)MII_RX_DV(_ER)",
+			  "ETH_A_(R)(G)MII_RX_CLK", "ETH_A_(S)(R)(G)MII_RXD0",
+			  "ETH_A_(S)(R)(G)MII_RXD1", "ETH_A_(R)(G)MII_RXD2",
+			  "ETH_A_(R)(G)MII_RXD3";
 };
 
-&gpio5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio5>;
-	gpio-line-names = "", "", "dio4-in", "", "", "", "", "",
-			  "", "", "", "", "", "", "", "",
-			  "", "", "", "", "", "", "", "",
-			  "", "", "", "", "", "", "", "";
+/*
+ * Rename SoM signals according to board usage:
+ *   GPIO_B_2      -> DIO3_OUT
+ *   GPIO_B_3      -> DIO4_OUT
+ */
+&gpio3 {
+	gpio-line-names = "GPIO_C_5", "GPIO_C_4", "SDIO_B_CD#", "SDIO_B_D5",
+			  "SDIO_B_D6", "SDIO_B_D7", "GPIO_C_0", "GPIO_C_1",
+			  "GPIO_C_2", "GPIO_C_3", "SDIO_B_D0", "SDIO_B_D1",
+			  "SDIO_B_D2", "SDIO_B_D3", "", "SDIO_B_D4",
+			  "CARRIER_PWR_EN", "SDIO_B_CLK", "SDIO_B_CMD", "DIO3_OUT",
+			  "USB_B_EN", "DIO4_OUT", "PCIe_CLKREQ#", "PCIe_A_PERST#",
+			  "PCIe_WAKE#", "USB_A_EN";
+};
+
+/*
+ * Rename SoM signals according to board usage:
+ *   GPIO_B_4      -> DIO1_IN
+ *   GPIO_B_5      -> DIO2_IN
+ *   GPIO_B_6      -> DIO3_IN
+ *   GPIO_B_7      -> DIO4_IN
+ */
+&gpio4 {
+	gpio-line-names = "GPIO_C_7", "", "I2S_A_DATA_IN", "I2S_B_DATA_IN",
+			  "DIO1_IN", "BOOT_SEL0#", "BOOT_SEL1#", "",
+			  "", "", "I2S_LRCLK", "I2S_BITCLK",
+			  "I2S_A_DATA_OUT", "I2S_B_DATA_OUT", "DIO2_IN", "DIO3_IN",
+			  "DIO4_IN", "SPI_A_/WP_(IO2)", "SPI_A_/HOLD_(IO3)", "GPIO_C_6",
+			  "I2S_MCLK", "UART_A_TX", "UART_A_RX", "UART_A_CTS",
+			  "UART_A_RTS", "", "", "",
+			  "PCIe_SM_ALERT", "UART_B_RTS", "UART_B_CTS", "UART_B_RX";
 };
 
 &i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
 	usb-hub@2c {
@@ -169,27 +181,28 @@ usb-hub@2c {
 	};
 };
 
-&i2c4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-};
-
 &pwm2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
 };
 
+&reg_usb2_vbus {
+	status = "disabled";
+};
+
+&reg_usdhc2_vcc {
+	status = "disabled";
+};
+
+&reg_usdhc3_vcc {
+	status = "disabled";
+};
+
 &uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
 	uart-has-rtscts;
 	status = "okay";
 };
 
 &uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
 	linux,rs485-enabled-at-boot-time;
 	uart-has-rtscts;
 	status = "okay";
@@ -197,8 +210,6 @@ &uart2 {
 
 &usbotg1 {
 	dr_mode = "otg";
-	disable-over-current;
-	vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
 
@@ -209,6 +220,9 @@ &usbotg2 {
 	#size-cells = <0>;
 	status = "okay";
 
+	/* VBUS is controlled by the hub */
+	/delete-property/ vbus-supply;
+
 	usb1@1 {
 		compatible = "usb424,2514";
 		reg = <1>;
@@ -224,171 +238,20 @@ usbnet: ethernet@1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	vmmc-supply = <&reg_vdd_3v3>;
-	vqmmc-supply = <&reg_nvcc_sd>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
 &iomuxc {
 	pinctrl_can: cangrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x19
-		>;
-	};
-
-	pinctrl_ecspi2: ecspi2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
-			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
-			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
-		>;
-	};
-
-	pinctrl_ecspi3: ecspi3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82
-			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82
-			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82
-			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19
-		>;
-	};
-
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19 /* PHY RST */
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x19
-			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
-			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
-		>;
-	};
-
-	pinctrl_gpio1: gpio1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19
-			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
-			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
-			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
-		>;
-	};
-
-	pinctrl_gpio5: gpio5grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000083
-			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083
-		>;
-	};
-
-	pinctrl_pwm2: pwm2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
-		>;
-	};
-
-	pinctrl_reg_usb1_vbus: regusb1vbusgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x0
-			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x0
-			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x0
-			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x0
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x0
-			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x0
-			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x0
-			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0
-		>;
-	};
-
-	pinctrl_usb_eth2: usbeth2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x90
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x94
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x19  /* SDIO_B_PWR_EN */
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+	pinctrl_usb_hub: usbhubgrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x96
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19 /* SDIO_B_WP */
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 6b9058fc53332..663ae52b48526 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2022 Kontron Electronics GmbH
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "imx8mm.dtsi"
 
@@ -28,6 +29,73 @@ memory@40000000 {
 	chosen {
 		stdout-path = &uart3;
 	};
+
+	reg_vdd_carrier: regulator-vdd-carrier {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vdd_carrier>;
+		gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "VDD_CARRIER";
+
+		regulator-state-standby {
+			regulator-on-in-suspend;
+		};
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+
+		regulator-state-disk {
+			regulator-off-in-suspend;
+		};
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb1_vbus>;
+		enable-active-high;
+		gpio = <&gpio3 25 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "VBUS_USB1";
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb2_vbus>;
+		enable-active-high;
+		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "VBUS_USB2";
+	};
+
+	reg_usdhc2_vcc: regulator-usdhc2-vcc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vcc>;
+		enable-active-high;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VCC_SDIO_A";
+	};
+
+	reg_usdhc3_vcc: regulator-usdhc3-vcc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc3_vcc>;
+		enable-active-high;
+		gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "VCC_SDIO_B";
+	};
 };
 
 &A53_0 {
@@ -96,6 +164,79 @@ partition@1f0000 {
 	};
 };
 
+&ecspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>, <&pinctrl_ecspi2_gpio>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
+};
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1>;
+	gpio-line-names = "", "GPIO_A_0", "", "GPIO_A_1",
+			  "", "GPIO_A_2", "GPIO_A_3", "GPIO_A_4",
+			  "GPIO_A_5", "GPIO_A_6", "GPIO_A_7", "GPIO_B_0",
+			  "GPIO_B_1", "USB_A_OC#", "CAM_MCK", "USB_B_OC#",
+			  "ETH_MDC", "ETH_MDIO", "ETH_A_(S)(R)(G)MII_TXD3",
+			  "ETH_A_(S)(R)(G)MII_TXD2", "ETH_A_(S)(R)(G)MII_TXD1",
+			  "ETH_A_(S)(R)(G)MII_TXD0", "ETH_A_(R)(G)MII_TX_EN(_ER)",
+			  "ETH_A_(R)(G)MII_TX_CLK", "ETH_A_(R)(G)MII_RX_DV(_ER)",
+			  "ETH_A_(R)(G)MII_RX_CLK", "ETH_A_(S)(R)(G)MII_RXD0",
+			  "ETH_A_(S)(R)(G)MII_RXD1", "ETH_A_(R)(G)MII_RXD2",
+			  "ETH_A_(R)(G)MII_RXD3";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "SDIO_A_CD#", "SDIO_A_CLK", "SDIO_A_CMD", "SDIO_A_D0",
+			  "SDIO_A_D1", "SDIO_A_D2", "SDIO_A_D3", "SDIO_A_PWR_EN",
+			  "SDIO_A_WP";
+};
+
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3>;
+	gpio-line-names = "GPIO_C_5", "GPIO_C_4", "SDIO_B_CD#", "SDIO_B_D5",
+			  "SDIO_B_D6", "SDIO_B_D7", "GPIO_C_0", "GPIO_C_1",
+			  "GPIO_C_2", "GPIO_C_3", "SDIO_B_D0", "SDIO_B_D1",
+			  "SDIO_B_D2", "SDIO_B_D3", "", "SDIO_B_D4",
+			  "CARRIER_PWR_EN", "SDIO_B_CLK", "SDIO_B_CMD", "GPIO_B_2",
+			  "USB_B_EN", "GPIO_B_3", "PCIe_CLKREQ#", "PCIe_A_PERST#",
+			  "PCIe_WAKE#", "USB_A_EN";
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	gpio-line-names = "GPIO_C_7", "", "I2S_A_DATA_IN", "I2S_B_DATA_IN",
+			  "GPIO_B_4", "BOOT_SEL0#", "BOOT_SEL1#", "",
+			  "", "", "I2S_LRCLK", "I2S_BITCLK",
+			  "I2S_A_DATA_OUT", "I2S_B_DATA_OUT", "GPIO_B_5", "GPIO_B_6",
+			  "GPIO_B_7", "SPI_A_/WP_(IO2)", "SPI_A_/HOLD_(IO3)", "GPIO_C_6",
+			  "I2S_MCLK", "UART_A_TX", "UART_A_RX", "UART_A_CTS",
+			  "UART_A_RTS", "", "", "",
+			  "PCIe_SM_ALERT", "UART_B_RTS", "UART_B_CTS", "UART_B_RX";
+};
+
+&gpio5 {
+	gpio-line-names = "UART_B_TX", "SDIO_B_PWR_EN", "SDIO_B_WP", "PWM_2",
+			  "PWM_1", "PWM_0", "", "",
+			  "", "", "SPI_A_SCK", "SPI_A_SDO_(IO1)",
+			  "SPI_A_SCK", "SPI_A_CS0#", "", "",
+			  "I2C_A_SCL", "I2C_A_SDA", "I2C_B_SCL", "I2C_B_SDA",
+			  "PCIe_SMCLK", "PCIe_SMDAT", "SPI_B_SCK", "SPI_B_SDO",
+			  "SPI_B_SDI", "SPI_B_CS0#", "UART_CON_RX", "UART_CON_TX",
+			  "UART_C_RX", "UART_C_TX";
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -222,12 +363,69 @@ rv3028: rtc@52 {
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+};
+
 &uart3 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
 };
 
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	vbus-supply = <&reg_usb1_vbus>;
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2>;
+	vbus-supply = <&reg_usb2_vbus>;
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -240,6 +438,26 @@ &usdhc1 {
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	vmmc-supply = <&reg_usdhc2_vcc>;
+	vqmmc-supply = <&reg_nvcc_sd>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_usdhc3_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_usdhc3_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_usdhc3_gpio>;
+	vmmc-supply = <&reg_usdhc3_vcc>;
+	vqmmc-supply = <&reg_nvcc_sd>;
+	cd-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
+};
+
 &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
@@ -248,6 +466,12 @@ &wdog1 {
 };
 
 &iomuxc {
+	pinctrl_csi_mck: csimckgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1	0x59 /* CAM_MCK */
+		>;
+	};
+
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
@@ -257,6 +481,106 @@ MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
 		>;
 	};
 
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82 /* SPI_A_SDI_(IO0) */
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82 /* SPI_A_SDO_(IO1) */
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82 /* SPI_A_SCK */
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19 /* SPI_A_CS0# */
+		>;
+	};
+
+	pinctrl_ecspi2_gpio: ecspi2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x19 /* SPI_A_/WP_(IO2) */
+			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x19 /* SPI_A_/HOLD_(IO3) */
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82 /* SPI_B_SDI */
+			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82 /* SPI_B_SDO */
+			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82 /* SPI_B_SCK */
+			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19 /* SPI_B_CS0# */
+		>;
+	};
+
+	pinctrl_enet_rgmii: enetrgmiigrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x03 /* ETH_MDC */
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x03 /* ETH_MDIO */
+			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f /* ETH_A_(S)(R)(G)MII_TXD3 */
+			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f /* ETH_A_(S)(R)(G)MII_TXD2 */
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f /* ETH_A_(S)(R)(G)MII_TXD1 */
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f /* ETH_A_(S)(R)(G)MII_TXD0 */
+			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91 /* ETH_A_(R)(G)MII_RXD3 */
+			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91 /* ETH_A_(R)(G)MII_RXD2 */
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91 /* ETH_A_(S)(R)(G)MII_RXD1 */
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91 /* ETH_A_(S)(R)(G)MII_RXD0 */
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f /* ETH_A_(R)(G)MII_TX_CLK */
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91 /* ETH_A_(R)(G)MII_RX_CLK */
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91 /* ETH_A_(R)(G)MII_RX_DV(_ER) */
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f /* ETH_A_(R)(G)MII_TX_EN(_ER) */
+		>;
+	};
+
+	pinctrl_enet_rmii: enetrmiigrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x03 /* ETH_MDC */
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x03 /* ETH_MDIO */
+			MX8MM_IOMUXC_ENET_TD2_ENET1_TX_CLK		0x4000001f /* ETH_A_(S)(R)(G)MII_TXD2 */
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x56 /* ETH_A_(S)(R)(G)MII_TXD1 */
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x56 /* ETH_A_(S)(R)(G)MII_TXD0 */
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x56 /* ETH_A_(S)(R)(G)MII_RXD1 */
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x56 /* ETH_A_(S)(R)(G)MII_RXD0 */
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RX_ER		0x56 /* ETH_A_(R)(G)MII_RX_CLK */
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x56 /* ETH_A_(R)(G)MII_RX_DV(_ER) */
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x56 /* ETH_A_(R)(G)MII_TX_EN(_ER) */
+		>;
+	};
+
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19 /* GPIO_A_0 */
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19 /* GPIO_A_1 */
+			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x19 /* GPIO_A_2 */
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* GPIO_A_3 */
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19 /* GPIO_A_4 */
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19 /* GPIO_A_5 */
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19 /* GPIO_A_6 */
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19 /* GPIO_A_7 */
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19 /* GPIO_B_0 */
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x19 /* GPIO_B_1 */
+		>;
+	};
+
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0			0x19 /* GPIO_C_5 */
+			MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1		0x19 /* GPIO_C_4 */
+			MX8MM_IOMUXC_NAND_DATA00_GPIO3_IO6		0x19 /* GPIO_C_0 */
+			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7		0x19 /* GPIO_C_1 */
+			MX8MM_IOMUXC_NAND_DATA02_GPIO3_IO8		0x19 /* GPIO_C_2 */
+			MX8MM_IOMUXC_NAND_DATA03_GPIO3_IO9		0x19 /* GPIO_C_3 */
+			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19 /* GPIO_B_2 */
+			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19 /* GPIO_B_3 */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0		0x19 /* GPIO_C_7 */
+			MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4		0x19 /* GPIO_B_4 */
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5		0x19 /* BOOT_SEL0# */
+			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6		0x19 /* BOOT_SEL1# */
+			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x19 /* GPIO_B_5 */
+			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x19 /* GPIO_B_6 */
+			MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x19 /* GPIO_B_7 */
+			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x19 /* GPIO_C_6 */
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000083
@@ -264,22 +588,149 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000083 /* I2C_A_SCL */
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000083 /* I2C_A_SDA */
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000083 /* I2C_B_SCL */
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083 /* I2C_B_SDA */
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000083 /* PCIe_SMCLK and I2C_CAM_SCL/CSI_TX_P */
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000083 /* PCIe_SMDAT and I2C_CAM_SDA/CSI_TX_N */
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x19 /* PCIe_CLKREQ# */
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x19 /* PCIe_A_PERST# */
+			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x19 /* PCIe_WAKE# */
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19 /* PCIe_SM_ALERT */
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x19 /* PWM_0 */
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19 /* PWM_1 */
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT			0x19 /* PWM_2 */
+		>;
+	};
+
+	pinctrl_reg_usb1_vbus: regusb1vbusgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19 /* USB_A_EN */
+		>;
+	};
+
+	pinctrl_reg_usb2_vbus: regusb2vbusgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19 /* USB_B_EN */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vcc: regusdhc2vccgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x19 /* SDIO_A_PWR_EN */
+		>;
+	};
+
+	pinctrl_reg_usdhc3_vcc: regusdhc3vccgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x19 /* SDIO_B_PWR_EN */
+		>;
+	};
+
+	pinctrl_reg_vdd_carrier: regvddcarriergrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19 /* CARRIER_PWR_EN */
+		>;
+	};
+
 	pinctrl_rtc: rtcgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1			0x19
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD0_SAI1_RX_DATA0		0xd6 /* I2S_A_DATA_IN */
+			MX8MM_IOMUXC_SAI1_TXD0_SAI1_TX_DATA0		0xd6 /* I2S_A_DATA_OUT */
+			MX8MM_IOMUXC_SAI1_RXD1_SAI1_RX_DATA1		0xd6 /* I2S_B_DATA_IN */
+			MX8MM_IOMUXC_SAI1_TXD1_SAI1_TX_DATA1		0xd6 /* I2S_B_DATA_OUT */
+			MX8MM_IOMUXC_SAI1_MCLK_SAI1_MCLK		0xd6 /* I2S_MCLK */
+			MX8MM_IOMUXC_SAI1_TXFS_SAI1_TX_SYNC		0xd6 /* I2S_LRCLK */
+			MX8MM_IOMUXC_SAI1_TXC_SAI1_TX_BCLK		0xd6 /* I2S_BITCLK */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x0 /* UART_A_RX */
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x0 /* UART_A_TX */
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x0 /* UART_A_CTS */
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x0 /* UART_A_RTS */
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x0 /* UART_B_RX */
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x0 /* UART_B_TX */
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x0 /* UART_B_CTS */
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x0 /* UART_B_RTS */
+		>;
+	};
+
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
-			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140 /* UART_CON_RX */
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140 /* UART_CON_TX */
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX		0x0 /* UART_C_RX */
+			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX		0x0 /* UART_C_TX */
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x19 /* USB_A_OC# */
+		>;
+	};
+
+	pinctrl_usb2: usb2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC		0x19 /* USB_B_OC# */
 		>;
 	};
 
@@ -334,6 +785,103 @@ MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x196
 		>;
 	};
 
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x90 /* SDIO_A_CLK */
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0 /* SDIO_A_CMD */
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0 /* SDIO_A_D0 */
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0 /* SDIO_A_D1 */
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0 /* SDIO_A_D2 */
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0 /* SDIO_A_D3 */
+			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6 /* SDIO_A_WP */
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x94 /* SDIO_A_CLK */
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4 /* SDIO_A_CMD */
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4 /* SDIO_A_D0 */
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4 /* SDIO_A_D1 */
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4 /* SDIO_A_D2 */
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4 /* SDIO_A_D3 */
+			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6 /* SDIO_A_WP */
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x96 /* SDIO_A_CLK */
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6 /* SDIO_A_CMD */
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6 /* SDIO_A_D0 */
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6 /* SDIO_A_D1 */
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6 /* SDIO_A_D2 */
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6 /* SDIO_A_D3 */
+			MX8MM_IOMUXC_SD2_WP_USDHC2_WP			0x400000d6 /* SDIO_A_WP */
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x90
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x19 /* SDIO_A_CD# */
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x90 /* SDIO_B_CLK */
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x90 /* SDIO_B_CMD */
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x90 /* SDIO_B_D0 */
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x90 /* SDIO_B_D1 */
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x90 /* SDIO_B_D2 */
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x90 /* SDIO_B_D3 */
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x90 /* SDIO_B_D4 */
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x90 /* SDIO_B_D5 */
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x90 /* SDIO_B_D6 */
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x90 /* SDIO_B_D7 */
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x94 /* SDIO_B_CLK */
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x94 /* SDIO_B_CMD */
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x94 /* SDIO_B_D0 */
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x94 /* SDIO_B_D1 */
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x94 /* SDIO_B_D2 */
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x94 /* SDIO_B_D3 */
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x94 /* SDIO_B_D4 */
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x94 /* SDIO_B_D5 */
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x94 /* SDIO_B_D6 */
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x94 /* SDIO_B_D7 */
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x96 /* SDIO_B_CLK */
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x96 /* SDIO_B_CMD */
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x96 /* SDIO_B_D0 */
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x96 /* SDIO_B_D1 */
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x96 /* SDIO_B_D2 */
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x96 /* SDIO_B_D3 */
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x96 /* SDIO_B_D4 */
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x96 /* SDIO_B_D5 */
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x96 /* SDIO_B_D6 */
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x96 /* SDIO_B_D7 */
+		>;
+	};
+
+	pinctrl_usdhc3_gpio: usdhc3gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19 /* SDIO_B_CD# */
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19 /* SDIO_B_WP */
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
-- 
2.43.0

