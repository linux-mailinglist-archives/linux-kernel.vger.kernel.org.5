Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D298072C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379011AbjLFOoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378978AbjLFOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:44:22 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49025D4B;
        Wed,  6 Dec 2023 06:44:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C388C0131;
        Wed,  6 Dec 2023 15:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701873864; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ZNb5mGtHz1UeWfUC79dgVMDzRbY7b/tvjIXIDYkEZss=;
        b=JrKJwofqVfNgFuFtuUXKuPJizfwinPAMvh+r6cvsIHCksvxfV2eQ983vVXcNeqoIChyMyz
        KaeRn08igBAvXK2tqgTlsgeENTx7n1HuVdTN7YCm2EaChInWi7NOf9vEfdGzoFRBwFBBUb
        BWHxUl8FzybRLpg33dY+PHnduCYypZAYHZwOl9uJBmptwp3HLxSymat9S5vZzSkVjtWrEL
        B6Umf1omFpwYjEgcD+Z1TRWy8xzaBkRsjNKbDw2zqdBicjckNpM2j40Nt41bF/twSij/qH
        ROmTAcvgP8PPdIa6OImesReRjojxA1OLm5FEgGfA0KDhCG3D59+QYkIJ+6wDTA==
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
Subject: [PATCH v3 01/14] arm64: dts: imx8mm-kontron: Add support for display bridges on BL i.MX8MM
Date:   Wed,  6 Dec 2023 15:41:04 +0100
Message-ID: <20231206144201.46911-2-frieder@fris.de>
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

The Kontron Electronics BL i.MX8MM has oboard disply bridges for
DSI->HDMI and DSI->LVDS conversion. The DSI interface is muxed by
a GPIO-controlled switch to one of these two bridges.

By default the HDMI bridge is enabled. The LVDS bridge can be
selected by loading an additional (panel-specific) overlay.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* Address Shawn's review comments (thanks!)

Changes for v2:
* Rework DSI mux GPIO logic to be compatible with overlay
* Switch from 4 to 2 DSI lanes for LVDS bridge to fix non-working display
---
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index dcec57c20399e..a0f0be3f104fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
@@ -25,6 +25,17 @@ osc_can: clock-osc-can {
 		clock-output-names = "osc-can";
 	};
 
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_in_conn: endpoint {
+				remote-endpoint = <&bridge_out_conn>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -132,6 +143,104 @@ ethphy: ethernet-phy@0 {
 	};
 };
 
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+
+	dsi_mux_sel_hdmi: dsi-mux-sel-hdmi-hog {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "dsi-mux-sel";
+	};
+
+	dsi_mux_sel_lvds: dsi-mux-sel-lvds-hog {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "dsi-mux-sel";
+		status = "disabled";
+	};
+
+	dsi-mux-oe-hog {
+		gpio-hog;
+		gpios = <15 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "dsi-mux-oe";
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	hdmi: hdmi@39 {
+		compatible = "adi,adv7535";
+		reg = <0x39>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_adv7535>;
+
+		interrupt-parent = <&gpio4>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+
+		adi,dsi-lanes = <4>;
+
+		a2vdd-supply = <&reg_vdd_1v8>;
+		avdd-supply = <&reg_vdd_1v8>;
+		dvdd-supply = <&reg_vdd_1v8>;
+		pvdd-supply = <&reg_vdd_1v8>;
+		v1p2-supply = <&reg_vdd_1v8>;
+		v3p3-supply = <&reg_vdd_3v3>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				bridge_in_dsi_hdmi: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				bridge_out_conn: endpoint {
+					remote-endpoint = <&hdmi_in_conn>;
+				};
+			};
+		};
+	};
+
+	lvds: bridge@2c {
+		compatible = "ti,sn65dsi84";
+		reg = <0x2c>;
+		enable-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sn65dsi84>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				bridge_in_dsi_lvds: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+					data-lanes = <1 2>;
+				};
+			};
+		};
+	};
+};
+
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -144,6 +253,30 @@ rx8900: rtc@32 {
 	};
 };
 
+&lcdif {
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <54000000>;
+	/*
+	 * Let the driver calculate an appropriate clock rate based on the pixel
+	 * clock instead of using the fixed value from imx8mm.dtsi.
+	 */
+	/delete-property/ samsung,pll-clock-frequency;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			dsi_out_bridge: endpoint {
+				remote-endpoint = <&bridge_in_dsi_hdmi>;
+			};
+		};
+	};
+};
+
 &pwm2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
@@ -207,6 +340,12 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio>;
 
+	pinctrl_adv7535: adv7535grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x19
+		>;
+	};
+
 	pinctrl_can: cangrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
@@ -277,6 +416,20 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
 		>;
 	};
 
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x19
+			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x19
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000083
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
@@ -290,6 +443,13 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
 		>;
 	};
 
+	pinctrl_sn65dsi84: sn65dsi84grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19
+			MX8MM_IOMUXC_SD2_WP_GPIO2_IO20			0x19
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
-- 
2.43.0

