Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C438072C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379006AbjLFOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379049AbjLFOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:44:24 -0500
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882419A;
        Wed,  6 Dec 2023 06:44:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD368C018E;
        Wed,  6 Dec 2023 15:44:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701873868; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Hndc5GdbsWYNRG+SAYE5hHf0spaPTonGByAkploGSR8=;
        b=cyd8vAXBZHYzmCyKtL9YMcD5n7B3sPxzqb+tPMvDyrT8Z3EgJRhrdWmVlOVNHqyWkwAPut
        h7DT4mQmeWxF/zzy/S4K9P8S8e0ja5TzURPQ7fbYm3m5FHyCrd2fMqSe5smcbuIyGReikG
        xkcBKyh5SbYDDyJscFpUCTkDsjwCa9v89YavLc5Olr0GSH1iDOH1vYIjfJGQGyig5CNjhS
        ArBTbKLTGNc9vNU4QjgXGmzMjc8KnorzhoJQz1RGiSaqDqNJ7CMB36c9uOjnhTLjQ7A2TN
        qbz/8SdAfjLq63yg+nRdDz1QQBCHLeVPjN7Fxl8EXyxiZ3JgdmCd4YeVTtNdiQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 02/14] arm64: dts: imx8mm-kontron: Add DL (Display-Line) overlay with LVDS support
Date:   Wed,  6 Dec 2023 15:41:05 +0100
Message-ID: <20231206144201.46911-3-frieder@fris.de>
In-Reply-To: <20231206144201.46911-1-frieder@fris.de>
References: <20231206144201.46911-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Kontron Electronics DL i.MX8MM consists of the BL i.MX8MM board
and a 7" LVDS panel. Provide an overlay that enables the panel.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* Address Shawn's review comments (thanks!)

Changes for v2:
* Rework DSI mux GPIO logic to be compatible with overlay
---
 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 201 ++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 300049037eb0b..e08024797721a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -166,6 +166,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 
+imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
+
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
+
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
new file mode 100644
index 0000000000000..6784bea857c00
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx8mm-pinfunc.h"
+
+&{/} {
+	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 50000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+	};
+
+	panel {
+		compatible = "panel-lvds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel>;
+		backlight = <&backlight>;
+		data-mapping = "vesa-24";
+		enable-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+		height-mm = <86>;
+		width-mm = <154>;
+
+		panel-timing {
+			clock-frequency = <51200000>;
+			hactive = <1024>;
+			vactive = <600>;
+			hsync-len = <1>;
+			hfront-porch = <160>;
+			hback-porch = <160>;
+			vsync-len = <1>;
+			vfront-porch = <12>;
+			vback-porch = <23>;
+		};
+
+		port {
+			panel_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_mux_sel_hdmi {
+	status = "disabled";
+};
+
+&dsi_mux_sel_lvds {
+	status = "okay";
+};
+
+&dsi_out_bridge {
+	remote-endpoint = <&bridge_in_dsi_lvds>;
+};
+
+&gpio3 {
+	panel_rst {
+		gpio-hog;
+		gpios = <20 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-reset";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel_rst>;
+	};
+
+	panel_stby {
+		gpio-hog;
+		gpios = <21 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-standby";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel_stby>;
+	};
+
+	panel_hinv {
+		gpio-hog;
+		gpios = <24 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-horizontal-invert";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel_hinv>;
+	};
+
+	panel_vinv {
+		gpio-hog;
+		gpios = <25 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "panel-vertical-invert";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel_vinv>;
+	};
+};
+
+&hdmi {
+	status = "disabled";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	gt911@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 8>;
+		reset-gpios = <&gpio3 23 0>;
+		irq-gpios = <&gpio3 22 0>;
+	};
+};
+
+&lvds {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@2 {
+			reg = <2>;
+
+			bridge_out_panel: endpoint {
+				remote-endpoint = <&panel_out_bridge>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000083
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000083
+		>;
+	};
+
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19
+		>;
+	};
+
+	pinctrl_panel_hinv: panelhinvgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x19
+		>;
+	};
+
+	pinctrl_panel_rst: panelrstgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19
+		>;
+	};
+
+	pinctrl_panel_stby: panelstbygrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19
+		>;
+	};
+
+	pinctrl_panel_vinv: panelvinvgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x6
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x19
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x19
+		>;
+	};
+};
-- 
2.43.0

