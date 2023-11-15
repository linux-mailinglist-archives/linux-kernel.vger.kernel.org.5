Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B787DDFB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjKAKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjKAKq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:46:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63945F3;
        Wed,  1 Nov 2023 03:46:21 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82AF4AE;
        Wed,  1 Nov 2023 11:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698835562;
        bh=x8bS3rNNLOykwqAZYHNIdSHJMf/DDPOXu+i6Qmi0T0w=;
        h=From:To:Cc:Subject:Date:From;
        b=dEbcSwm77UIpNGSOh1w53lQXyqjNqNRFGNQwHcQZcpPUCuqf9eZuoBOV0+8b9c3Du
         uYu5n3XeM2i3do0840cAf5cYKDxNNjwnsM/QuxTCr8Lpf/vu6G72hjBpdM8Y8EAKtV
         UQThGmTDaGUC8xVCNuFA7BpIJBUTBoYWMmLVBwRE=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm64: dts: freescale: debix-som-a-bmb-08: Add CSI Power Regulators
Date:   Wed,  1 Nov 2023 10:46:11 +0000
Message-Id: <20231101104614.2209986-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the 1.8 and 3.3 volt regulators that are utilised on the Debix
SOM BMB-08 base board.

Facilitate this by also supplying the pin control used to enable the
regulators on the second MIPI CSI port.

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

---
v2:
 - Remove _SW post fixes from regulators.

 .../freescale/imx8mp-debix-som-a-bmb-08.dts   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
index 0b0c95432bdc..386177c66c6d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
@@ -63,6 +63,50 @@ regulator-som-vdd3v3 {
 		regulator-always-on;
 	};
 
+	reg_csi1_1v8: regulator-csi1-vdd1v8 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-name = "CSI1_VDD1V8";
+		gpio = <&expander0 13 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_baseboard_vdd3v3>;
+		enable-active-high;
+	};
+
+	reg_csi1_3v3: regulator-csi1-vdd3v3 {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "CSI1_VDD3V3";
+		gpio = <&expander0 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_vdd5v0>;
+	};
+
+	reg_csi2_1v8: regulator-csi2-vdd1v8 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_csi2_1v8>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-name = "CSI2_VDD1V8";
+		gpio = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_baseboard_vdd3v3>;
+	};
+
+	reg_csi2_3v3: regulator-csi2-vdd3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_csi2_3v3>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "CSI2_VDD3V3";
+		gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_vdd5v0>;
+	};
+
 	regulator-vbus-usb20 {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <5000000>;
@@ -413,6 +457,18 @@ MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x41
 		>;
 	};
 
+	pinctrl_reg_csi2_1v8: regcsi21v8grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x19
+		>;
+	};
+
+	pinctrl_reg_csi2_3v3: regcsi23v3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25		0x19
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x14f
-- 
2.34.1

