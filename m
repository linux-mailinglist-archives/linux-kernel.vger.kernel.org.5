Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E57D5D26
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbjJXV02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjJXV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:26:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08BF9D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso41757325ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182784; x=1698787584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmaXnn3FVuKUUd5bHXt0ruoyEZHefu8VCNGbhNVksAI=;
        b=gOWrzAUuyy1lrldZXPEqSxlIbHJJhPvsr9Cgxw327rVMGx4NmMAYqSTRYdnjqJnTvX
         hbnVP73fqxy6/WS6dhdAwZ7+r4MzF3zvDpipVhycEBvvr3FgZ1dGYA1uKb7f/AoekE5/
         kDS7lzel70HicKArVsvt2j2CmoxQukxzW2VQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182784; x=1698787584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmaXnn3FVuKUUd5bHXt0ruoyEZHefu8VCNGbhNVksAI=;
        b=NSU2DnyXJwTOiBs+QKAOKmCEN+t1u0/PEP7Mz55g4RAKdJnqWNoS6Jt72KqEQSMuSi
         O7oupXcC0mKQvJJ5VWGLTw1poj9RNPbv/P+rjgT6K3cVFBPvoiEEXWIxcdbrATd2Rajp
         LQuiKpaOmBife7/Ic2OPb9iMHMAU5gDrliNd4E55YVg6YwEMDXeQ8y/3oYgHuvyGbP0J
         yTh/LH61pbu1J+wDqs84E+EIA7v3u6DtgN52E/lgbj9a4u21YhgKSLYx0Z3w+aNLK4uX
         ccFLgPySFfkGPep3Y2r8EKILU0SU1Z4T6dFJLu37RSGRtGqwkWVouws/QUWu54Wuj3M8
         e6tg==
X-Gm-Message-State: AOJu0Yw/2ULMfy+K8OezfxZNkIVvd1c5+S4Rqu+/PXjoqzl4OHyUMXom
        z2nfyPSTMrBbPIqdxz+oGuxJxg==
X-Google-Smtp-Source: AGHT+IH6kkrCgqN3YbV+L9kA6VrGOZAuIviVBNVqMBdTy/sBN4fYAQaPOXKyDQS8CBZc5AyopntO/Q==
X-Received: by 2002:a17:903:11c7:b0:1bb:77a2:edda with SMTP id q7-20020a17090311c700b001bb77a2eddamr14437012plh.36.1698182784439;
        Tue, 24 Oct 2023 14:26:24 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:5a2d:c345:7f3f:d26c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b001b850c9d7b3sm7824140plf.249.2023.10.24.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:26:24 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/7] arm64: dts: mt8183: kukui: Fix underscores in node names
Date:   Tue, 24 Oct 2023 14:22:23 -0700
Message-ID: <20231024212618.1079676-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024212618.1079676-1-hsinyi@chromium.org>
References: <20231024212618.1079676-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the underscores in node names.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
new in v2
---
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  6 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 90 +++++++++----------
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index bf97b60ae4d1..06fde1a9aab7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -441,20 +441,20 @@ pins2 {
 	};
 
 	touchscreen_pins: touchscreen-pins {
-		touch_int_odl {
+		touch-int-odl {
 			pinmux = <PINMUX_GPIO155__FUNC_GPIO155>;
 			input-enable;
 			bias-pull-up;
 		};
 
-		touch_rst_l {
+		touch-rst-l {
 			pinmux = <PINMUX_GPIO156__FUNC_GPIO156>;
 			output-high;
 		};
 	};
 
 	trackpad_pins: trackpad-pins {
-		trackpad_int {
+		trackpad-int {
 			pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
 			input-enable;
 			bias-disable; /* pulled externally */
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index bf7de35ffcbc..5a3109e47877 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -460,7 +460,7 @@ &mt6358_vsram_gpu_reg {
 
 &pio {
 	aud_pins_default: audiopins {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO97__FUNC_I2S2_MCK>,
 				<PINMUX_GPIO98__FUNC_I2S2_BCK>,
 				<PINMUX_GPIO101__FUNC_I2S2_LRCK>,
@@ -482,7 +482,7 @@ pins_bus {
 	};
 
 	aud_pins_tdm_out_on: audiotdmouton {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO169__FUNC_TDM_BCK_2ND>,
 				<PINMUX_GPIO170__FUNC_TDM_LRCK_2ND>,
 				<PINMUX_GPIO171__FUNC_TDM_DATA0_2ND>,
@@ -494,7 +494,7 @@ pins_bus {
 	};
 
 	aud_pins_tdm_out_off: audiotdmoutoff {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO169__FUNC_GPIO169>,
 				<PINMUX_GPIO170__FUNC_GPIO170>,
 				<PINMUX_GPIO171__FUNC_GPIO171>,
@@ -508,13 +508,13 @@ pins_bus {
 	};
 
 	bt_pins: bt-pins {
-		pins_bt_en {
+		pins-bt-en {
 			pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
 			output-low;
 		};
 	};
 
-	ec_ap_int_odl: ec_ap_int_odl {
+	ec_ap_int_odl: ec-ap-int-odl {
 		pins1 {
 			pinmux = <PINMUX_GPIO151__FUNC_GPIO151>;
 			input-enable;
@@ -522,7 +522,7 @@ pins1 {
 		};
 	};
 
-	h1_int_od_l: h1_int_od_l {
+	h1_int_od_l: h1-int-od-l {
 		pins1 {
 			pinmux = <PINMUX_GPIO153__FUNC_GPIO153>;
 			input-enable;
@@ -530,7 +530,7 @@ pins1 {
 	};
 
 	i2c0_pins: i2c0 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -539,7 +539,7 @@ pins_bus {
 	};
 
 	i2c1_pins: i2c1 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -548,7 +548,7 @@ pins_bus {
 	};
 
 	i2c2_pins: i2c2 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			bias-disable;
@@ -557,7 +557,7 @@ pins_bus {
 	};
 
 	i2c3_pins: i2c3 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -566,7 +566,7 @@ pins_bus {
 	};
 
 	i2c4_pins: i2c4 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			bias-disable;
@@ -575,7 +575,7 @@ pins_bus {
 	};
 
 	i2c5_pins: i2c5 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
@@ -584,7 +584,7 @@ pins_bus {
 	};
 
 	i2c6_pins: i2c6 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO11__FUNC_SCL6>,
 				 <PINMUX_GPIO12__FUNC_SDA6>;
 			bias-disable;
@@ -592,7 +592,7 @@ pins_bus {
 	};
 
 	mmc0_pins_default: mmc0-pins-default {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
 				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
 				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
@@ -607,13 +607,13 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <01>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_rst {
+		pins-rst {
 			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <01>;
@@ -621,7 +621,7 @@ pins_rst {
 	};
 
 	mmc0_pins_uhs: mmc0-pins-uhs {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
 				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
 				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
@@ -636,19 +636,19 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <01>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_ds {
+		pins-ds {
 			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_rst {
+		pins-rst {
 			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-up-adv = <01>;
@@ -656,7 +656,7 @@ pins_rst {
 	};
 
 	mmc1_pins_default: mmc1-pins-default {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
 				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
@@ -666,7 +666,7 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <10>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			input-enable;
 			mediatek,pull-down-adv = <10>;
@@ -674,7 +674,7 @@ pins_clk {
 	};
 
 	mmc1_pins_uhs: mmc1-pins-uhs {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
 				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
@@ -685,7 +685,7 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <10>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			drive-strength = <MTK_DRIVE_8mA>;
 			mediatek,pull-down-adv = <10>;
@@ -694,7 +694,7 @@ pins_clk {
 	};
 
 	panel_pins_default: panel_pins_default {
-		panel_reset {
+		panel-reset {
 			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
 			output-low;
 			bias-pull-up;
@@ -713,14 +713,14 @@ pins2 {
 	};
 
 	scp_pins: scp {
-		pins_scp_uart {
+		pins-scp-uart {
 			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
 				 <PINMUX_GPIO112__FUNC_TP_UTXD1_AO>;
 		};
 	};
 
 	spi0_pins: spi0 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_GPIO86>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -730,7 +730,7 @@ pins_spi {
 	};
 
 	spi1_pins: spi1 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -740,20 +740,20 @@ pins_spi {
 	};
 
 	spi2_pins: spi2 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>;
 			bias-disable;
 		};
-		pins_spi_mi {
+		pins-spi-mi {
 			pinmux = <PINMUX_GPIO94__FUNC_SPI2_MI>;
 			mediatek,pull-down-adv = <00>;
 		};
 	};
 
 	spi3_pins: spi3 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -763,7 +763,7 @@ pins_spi {
 	};
 
 	spi4_pins: spi4 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -773,7 +773,7 @@ pins_spi {
 	};
 
 	spi5_pins: spi5 {
-		pins_spi {
+		pins-spi {
 			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
 				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
 				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
@@ -783,63 +783,63 @@ pins_spi {
 	};
 
 	uart0_pins_default: uart0-pins-default {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO95__FUNC_URXD0>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO96__FUNC_UTXD0>;
 		};
 	};
 
 	uart1_pins_default: uart1-pins-default {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO121__FUNC_URXD1>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO115__FUNC_UTXD1>;
 		};
-		pins_rts {
+		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
 			output-enable;
 		};
-		pins_cts {
+		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
 			input-enable;
 		};
 	};
 
 	uart1_pins_sleep: uart1-pins-sleep {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO121__FUNC_GPIO121>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO115__FUNC_UTXD1>;
 		};
-		pins_rts {
+		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
 			output-enable;
 		};
-		pins_cts {
+		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
 			input-enable;
 		};
 	};
 
 	wifi_pins_pwrseq: wifi-pins-pwrseq {
-		pins_wifi_enable {
+		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
 			output-low;
 		};
 	};
 
 	wifi_pins_wakeup: wifi-pins-wakeup {
-		pins_wifi_wakeup {
+		pins-wifi-wakeup {
 			pinmux = <PINMUX_GPIO113__FUNC_GPIO113>;
 			input-enable;
 		};
-- 
2.42.0.758.gaed0368e0e-goog

