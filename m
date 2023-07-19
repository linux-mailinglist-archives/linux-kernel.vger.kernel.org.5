Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C147595FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGSMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:54:39 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C010B;
        Wed, 19 Jul 2023 05:54:38 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 109AB209AC;
        Wed, 19 Jul 2023 14:54:36 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] arm64: dts: freescale: verdin-imx8mp: dev: add sound card
Date:   Wed, 19 Jul 2023 14:54:30 +0200
Message-Id: <20230719125430.249644-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719125430.249644-1-francesco@dolcini.it>
References: <20230719125430.249644-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add NAU8822 based analog sound card to Development carrier board.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi | 55 +++++++++++++++++--
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index bdfdd4c782f1..a509b2b7fa85 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -4,8 +4,6 @@
  */
 
 / {
-	/* TODO: Audio Codec */
-
 	reg_eth2phy: regulator-eth2phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -17,6 +15,41 @@ reg_eth2phy: regulator-eth2phy {
 		startup-delay-us = <200000>;
 		vin-supply = <&reg_3p3v>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "imx8mp-nau8822";
+		simple-audio-card,routing =
+			"Headphones", "LHP",
+			"Headphones", "RHP",
+			"Speaker", "LSPK",
+			"Speaker", "RSPK",
+			"Line Out", "AUXOUT1",
+			"Line Out", "AUXOUT2",
+			"LAUX", "Line In",
+			"RAUX", "Line In",
+			"LMICP", "Mic In",
+			"RMICP", "Mic In";
+		simple-audio-card,widgets =
+			"Headphones", "Headphones",
+			"Line Out", "Line Out",
+			"Speaker", "Speaker",
+			"Microphone", "Mic In",
+			"Line", "Line In";
+
+		codec_dai: simple-audio-card,codec {
+			clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1>;
+			sound-dai = <&nau8822_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+	};
 };
 
 &backlight {
@@ -88,7 +121,14 @@ &i2c3 {
 &i2c4 {
 	status = "okay";
 
-	/* TODO: Audio Codec */
+	/* Audio Codec */
+	nau8822_1a: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai1>;
+		#sound-dai-cells = <0>;
+	};
 };
 
 /* Verdin PCIE_1 */
@@ -119,7 +159,14 @@ &reg_usdhc2_vmmc {
 	vin-supply = <&reg_3p3v>;
 };
 
-/* TODO: Verdin I2C_1 with Audio Codec */
+/* Verdin I2S_1 */
+&sai1 {
+	assigned-clocks = <&clk IMX8MP_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
 
 /* Verdin UART_1, connector X50 through RS485 transceiver */
 &uart1 {
-- 
2.25.1

