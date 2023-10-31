Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059087DD758
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbjJaUrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjJaUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:47:17 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2257010A;
        Tue, 31 Oct 2023 13:47:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A77DDC0269;
        Tue, 31 Oct 2023 21:39:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1698784746; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=94/HYtm9FGvd4Dz1TUcprmc36le0K2PUtTaVtqso0A0=;
        b=pmPhAt7/Pmx02MqsAtw+PizNChGGvCQSsP0K0OzhcUJpbmcKyCN8TJPQ61Bwlbf7jUtFks
        L0tRaD2zRv+ryytcXWPZgNQL1XVDpuLHu5z7wIPQpSz5/cmXP+W9FFjV9WaUDS5pHNVn4Z
        DIUna+29/Ypu9OIRIjZl5hBkHfK9gR6ZuGhehenI9DDF3b4bMa5ry4M8l1fPaaN8KkvWFv
        npPQp4gXGWb6UnE9ZqZq28oGRzzvcEcE7nDOA162zTrpg9suYbeNVuMmXkJdCD02VjZT6y
        TqID3uKMKlw5MG6IKrhvuNgd8MWGLMYXvPf+Yb/+tUlpQtcA1Nnoon9qNaudDQ==
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
Subject: [PATCH 01/14] arm64: dts: imx8mm-kontron: Add support for display bridges on BL i.MX8MM
Date:   Tue, 31 Oct 2023 21:37:38 +0100
Message-ID: <20231031203836.3888404-2-frieder@fris.de>
In-Reply-To: <20231031203836.3888404-1-frieder@fris.de>
References: <20231031203836.3888404-1-frieder@fris.de>
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
 .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
index dcec57c20399e..f1326bf634a7f 100644
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
@@ -132,6 +143,93 @@ ethphy: ethernet-phy@0 {
 	};
 };
 
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+
+	dsi_mux_sel: dsi-mux-sel-hog {
+		gpio-hog;
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "dsi-mux-sel";
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
+				bridge_in_dsi_hdmi: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
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
+				bridge_in_dsi_lvds: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+					data-lanes = <1 2 3 4>;
+				};
+			};
+		};
+	};
+};
+
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -144,6 +242,30 @@ rx8900: rtc@32 {
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
@@ -207,6 +329,12 @@ &iomuxc {
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
@@ -277,6 +405,20 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
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
@@ -290,6 +432,13 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
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
2.42.0

