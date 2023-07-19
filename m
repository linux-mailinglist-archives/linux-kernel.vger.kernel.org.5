Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D225D7595FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGSMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGSMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:54:38 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093B11C;
        Wed, 19 Jul 2023 05:54:37 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 72127206BC;
        Wed, 19 Jul 2023 14:54:35 +0200 (CEST)
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
Subject: [PATCH v1 1/2] arm64: dts: freescale: verdin-imx8mp: dahlia: add sound card
Date:   Wed, 19 Jul 2023 14:54:29 +0200
Message-Id: <20230719125430.249644-2-francesco@dolcini.it>
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

Add WM8904 based analog sound card to Dahlia carrier board.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   | 56 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 56b0e4b865c9..7e9e4b13b5c5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -3,7 +3,36 @@
  * Copyright 2022 Toradex
  */
 
-/* TODO: Audio Codec */
+/ {
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "imx8mp-wm8904";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Headphone Jack", "MICBIAS",
+			"IN1L", "Headphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Headphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+
+		codec_dai: simple-audio-card,codec {
+			clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1>;
+			sound-dai = <&wm8904_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+	};
+};
 
 &backlight {
 	power-supply = <&reg_3p3v>;
@@ -64,7 +93,21 @@ &i2c3 {
 &i2c4 {
 	status = "okay";
 
-	/* TODO: Audio Codec */
+	/* Audio Codec */
+	wm8904_1a: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai1>;
+		#sound-dai-cells = <0>;
+		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_1p8v>;
+		CPVDD-supply = <&reg_1p8v>;
+		DBVDD-supply = <&reg_1p8v>;
+		DCVDD-supply = <&reg_1p8v>;
+		MICVDD-supply = <&reg_1p8v>;
+	};
 };
 
 /* Verdin PCIE_1 */
@@ -95,7 +138,14 @@ &reg_usdhc2_vmmc {
 	vin-supply = <&reg_3p3v>;
 };
 
-/* TODO: Verdin I2S_1 */
+/* Verdin I2S_1 */
+&sai1 {
+	assigned-clocks = <&clk IMX8MP_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
 
 /* Verdin UART_1 */
 &uart1 {
-- 
2.25.1

