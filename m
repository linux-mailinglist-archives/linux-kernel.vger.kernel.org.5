Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9977D7729
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjJYVzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjJYVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:55:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA0133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so190816b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698270925; x=1698875725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3FNJ8A+GbUsumip1Po2xsvT59wrp8LwEJPH7AuCIOo=;
        b=C/MM+nVj9n1SraJ8cQkf8ElE9LxhqF0iN6AQ27XHsQDE9KVxL1lEfDrsLcPG76+Zte
         ZCIR25GEFuCmJPIdnIbLEETeJuzWb3w/G31tNth990FYbbOw/JC/XH/HOkGPiMFPIkvU
         o9bcbDWlroSL6Kg9J3az9kdXfGzqDt1EEFl0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698270925; x=1698875725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3FNJ8A+GbUsumip1Po2xsvT59wrp8LwEJPH7AuCIOo=;
        b=A5SezBRXauD2bDxMYQe5foteevlnAUXQKAzakQOQYQppucl3wHOqlrI+HzV6xfzuQR
         zu93wp37craMG3rFoqtvwq+VRiDMy/k2MLkDnXyxUH8Rgsc40P9OVKcFUWJsbWjjBADv
         sln89+pW+pOLqJ+VH0c9yVSBYBjyic0mtNG7LTgXJFWsW3DgrppSP4YPPHXyOyKcL9kJ
         fX2IiDTwWzrop9G0TC3gFVCrnFRUeKvsbmXKhIFAOB1EeQWEJnhH2OfNNlyaxQTkfneb
         s0Xy4mirgj3qOajUTd3t04brxY24mOirplP9FbKiRINE6up8xWvYrkgFDQrHqOg19b13
         q99Q==
X-Gm-Message-State: AOJu0Ywygjntf+d+E7cSQ2A0sX16cF1nA7/5B1+FFCeATyH2GniRcNCL
        2Ryl338GQDO+7ken6Ox2ryJlbQ==
X-Google-Smtp-Source: AGHT+IHncNMUueqNAcd7SiopQLrMR9ylk6wp5IE2XabuhGuyEu9dSE3BI9rgpqog1+9SmY31rzAn8w==
X-Received: by 2002:a05:6a20:7351:b0:15c:fa48:2c09 with SMTP id v17-20020a056a20735100b0015cfa482c09mr7716664pzc.15.1698270925425;
        Wed, 25 Oct 2023 14:55:25 -0700 (PDT)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:f0fe:5c3b:1d70:d0bb])
        by smtp.gmail.com with ESMTPSA id w14-20020a63160e000000b005b8ebef9fa0sm2994943pgl.83.2023.10.25.14.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 14:55:25 -0700 (PDT)
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
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/7] arm64: dts: mt8183: kukui: Fix underscores in node names
Date:   Wed, 25 Oct 2023 14:48:43 -0700
Message-ID: <20231025215517.1388735-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231025215517.1388735-1-hsinyi@chromium.org>
References: <20231025215517.1388735-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace underscores with hyphens in pinctrl node names both for consistency
and to adhere to the bindings.

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Fixes: 1652dbf7363a ("arm64: dts: mt8183: add scp node")
Fixes: 27eaf34df364 ("arm64: dts: mt8183: config dsi node")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2->v3: Update commit message. Add Fixes tags.
---
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  6 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 94 +++++++++----------
 2 files changed, 50 insertions(+), 50 deletions(-)

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
index bf7de35ffcbc..4ff207ab1d26 100644
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
@@ -693,15 +693,15 @@ pins_clk {
 		};
 	};
 
-	panel_pins_default: panel_pins_default {
-		panel_reset {
+	panel_pins_default: panel-pins-default {
+		panel-reset {
 			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
 			output-low;
 			bias-pull-up;
 		};
 	};
 
-	pwm0_pin_default: pwm0_pin_default {
+	pwm0_pin_default: pwm0-pin-default {
 		pins1 {
 			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
 			output-high;
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

