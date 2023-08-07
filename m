Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D10773048
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHGUWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjHGUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:22:10 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637F10E9;
        Mon,  7 Aug 2023 13:22:08 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id AF8B8207CE;
        Mon,  7 Aug 2023 22:22:06 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v3 3/4] arm64: dts: ti: verdin-am62: dev: add sound card
Date:   Mon,  7 Aug 2023 22:21:58 +0200
Message-Id: <20230807202159.13095-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807202159.13095-1-francesco@dolcini.it>
References: <20230807202159.13095-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add NAU8822 based analog sound card to Development carrier board.

Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
index 8205081fda33..6701cb8974bb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
@@ -8,6 +8,42 @@
  * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
  */
 
+/ {
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,name = "verdin-nau8822";
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
+			clocks = <&audio_refclk1>;
+			sound-dai = <&nau8822_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+		};
+	};
+};
+
 /* Verdin ETHs */
 &cpsw3g {
 	pinctrl-names = "default";
@@ -65,6 +101,15 @@ &main_gpio0 {
 &main_i2c1 {
 	status = "okay";
 
+	/* Audio Codec */
+	nau8822_1a: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s1_mclk>;
+		#sound-dai-cells = <0>;
+	};
+
 	/* IO Expander */
 	gpio_expander_21: gpio@21 {
 		compatible = "nxp,pcal6416";
-- 
2.25.1

