Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2436579BD58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbjIKVPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242539AbjIKPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:46:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFDE127
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so49515735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694447157; x=1695051957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSIzaGY4JTGWQViW6JO82zhUaR3rfht5CJdLlOs6lcQ=;
        b=ozHdDp991UdVNd+uAa4UswhG3Y5KdOcj/MrJUzT+mWfILc/zixDwhsINbrPRv6dA+D
         A8nJR+jDWhZIg3TjoJnFJBtfGQWK41f8xRMNSNm9ihm3S1nGcd6CN+cUSiE0BxdN/8uv
         yQLJTIoWvhqvSdltBkoauUuWXpq1DhFzElTtgG97izwO2Gj0PXWeQMwD6gii4l8CeGEY
         IJ45cBXUw+ODgZBCKKo3ODYyoa7xEvkF/260odw2u9DSB+8unGlgsIPRBqjvgA4ac2ZC
         UoqcgK58b+h93wU4vUoCae1oS6TnLlbPVtqlgfzzKBD2j5lTANy3PveH+4YcA07hznpc
         Ybcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447157; x=1695051957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSIzaGY4JTGWQViW6JO82zhUaR3rfht5CJdLlOs6lcQ=;
        b=YY+lxX1lS+OGul0+wizAWP5IaW/2z4khVRbUU7pwx7AYiL+gee8pPpcaXHMbFoXRcj
         //QRwTk6taqRHN+YZyBgqKeMjXthsYu6+DdzRo2KO69mYAQr/EtijrghjPITKM/8eYXa
         5SbDMLgJb1d1kQilZtmI75fheyG+i5GgCehEoh15fkEzObJj6btKtd5xWAMbllQrk2kL
         KTYa/M9dqXsqRjve1WAcW1VmzqpqoqArbCRHiliPcX7OBtwGrs/5ymg4vgD/RZjYKQoT
         vibhguByMVTA2wdq1LPKEHyEyvptwffeCgEES4GQ6p+mpNu7od4D3EPzM0c+JgxCUThw
         HchA==
X-Gm-Message-State: AOJu0YyxAoQKbe5NYOw1O6i3Fd9iNKCT+CXTrqqt17ll0mrcFuiy4S/E
        zdljDhYTBxo9kzU3GgsMOiH83Q==
X-Google-Smtp-Source: AGHT+IGhLPBA7FSbST65jTdBOh+qXxiGny/m9t3mksHt37rJQNayJyIdmGOMbsoTZtN+Egf8qMpPjA==
X-Received: by 2002:a05:600c:204c:b0:401:23fc:1f92 with SMTP id p12-20020a05600c204c00b0040123fc1f92mr8964501wmg.25.1694447156746;
        Mon, 11 Sep 2023 08:45:56 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:55be:8f7e:5f59:7ed1])
        by smtp.googlemail.com with ESMTPSA id q12-20020a05600c040c00b003fe539b83f2sm13616255wmb.42.2023.09.11.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:45:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 5/5] arm64: dts: meson: u200: add onboard devices
Date:   Mon, 11 Sep 2023 17:45:41 +0200
Message-Id: <20230911154541.471484-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230911154541.471484-1-jbrunet@baylibre.com>
References: <20230911154541.471484-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing audio devices found on the u200 PCB. This includes
* Lineout connected to the internal DAC
* SPDIF input connected to a coaxial socket
* TDM input decoders allowing output loopback
* TDM A and B output encoders and interfaces

TDM A and B link format is set by the related external codec.
Internal audio DAC can hook to any TDM output.

This change does not include support necessary the optional the speaker and
PDM Mic headers

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 228 +++++++++++++++++-
 1 file changed, 218 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index da66e2e1dffb..9abe37b5b227 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+#include <dt-bindings/sound/meson-g12a-toacodec.h>
 
 / {
 	compatible = "amlogic,u200", "amlogic,g12a";
@@ -19,6 +20,22 @@ aliases {
 		ethernet0 = &ethmac;
 	};
 
+	dioo2133: audio-amplifier-0 {
+		#sound-dai-cells = <0>;
+		compatible = "simple-audio-amplifier";
+		status = "okay";
+		enable-gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+		VCC-supply = <&vcc_5v>;
+		sound-name-prefix = "10U2";
+	};
+
+	spdif_dir: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dir";
+		status = "okay";
+		sound-name-prefix = "DIR";
+	};
+
 	spdif_dit: audio-codec-1 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
@@ -159,17 +176,71 @@ vddcpu: regulator-vddcpu {
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "U200";
-		audio-aux-devs = <&tdmout_c>;
-		audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+		audio-widgets = "Line", "Lineout";
+		audio-aux-devs = <&tdmout_a>, <&tdmout_b>, <&tdmout_c>,
+				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>,
+				 <&tdmin_lb>, <&dioo2133>;
+		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
+				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
+				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
+				"TDM_A Playback", "TDMOUT_A OUT",
+				"TDMOUT_B IN 0", "FRDDR_A OUT 1",
+				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
+				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDMOUT_C IN 0", "FRDDR_A OUT 2",
 				"TDMOUT_C IN 1", "FRDDR_B OUT 2",
 				"TDMOUT_C IN 2", "FRDDR_C OUT 2",
-				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDM_C Playback", "TDMOUT_C OUT",
 				"SPDIFOUT IN 0", "FRDDR_A OUT 3",
 				"SPDIFOUT IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT IN 2", "FRDDR_C OUT 3",
 				"SPDIFOUT_B IN 0", "FRDDR_A OUT 4",
 				"SPDIFOUT_B IN 1", "FRDDR_B OUT 4",
-				"SPDIFOUT_B IN 2", "FRDDR_C OUT 4";
+				"SPDIFOUT_B IN 2", "FRDDR_C OUT 4",
+				"TDMIN_A IN 0", "TDM_A Capture",
+				"TDMIN_A IN 1", "TDM_B Capture",
+				"TDMIN_A IN 2", "TDM_C Capture",
+				"TDMIN_A IN 3", "TDM_A Loopback",
+				"TDMIN_A IN 4", "TDM_B Loopback",
+				"TDMIN_A IN 5", "TDM_C Loopback",
+				"TDMIN_B IN 0", "TDM_A Capture",
+				"TDMIN_B IN 1", "TDM_B Capture",
+				"TDMIN_B IN 2", "TDM_C Capture",
+				"TDMIN_B IN 3", "TDM_A Loopback",
+				"TDMIN_B IN 4", "TDM_B Loopback",
+				"TDMIN_B IN 5", "TDM_C Loopback",
+				"TDMIN_C IN 0", "TDM_A Capture",
+				"TDMIN_C IN 1", "TDM_B Capture",
+				"TDMIN_C IN 2", "TDM_C Capture",
+				"TDMIN_C IN 3", "TDM_A Loopback",
+				"TDMIN_C IN 4", "TDM_B Loopback",
+				"TDMIN_C IN 5", "TDM_C Loopback",
+				"TDMIN_LB IN 3", "TDM_A Capture",
+				"TDMIN_LB IN 4", "TDM_B Capture",
+				"TDMIN_LB IN 5", "TDM_C Capture",
+				"TDMIN_LB IN 0", "TDM_A Loopback",
+				"TDMIN_LB IN 1", "TDM_B Loopback",
+				"TDMIN_LB IN 2", "TDM_C Loopback",
+				"TODDR_A IN 0", "TDMIN_A OUT",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+				"TODDR_C IN 0", "TDMIN_A OUT",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"TODDR_B IN 1", "TDMIN_B OUT",
+				"TODDR_C IN 1", "TDMIN_B OUT",
+				"TODDR_A IN 2", "TDMIN_C OUT",
+				"TODDR_B IN 2", "TDMIN_C OUT",
+				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 3", "SPDIFIN Capture",
+				"TODDR_B IN 3", "SPDIFIN Capture",
+				"TODDR_C IN 3", "SPDIFIN Capture",
+				"TODDR_A IN 6", "TDMIN_LB OUT",
+				"TODDR_B IN 6", "TDMIN_LB OUT",
+				"TODDR_C IN 6", "TDMIN_LB OUT",
+				"10U2 INL", "ACODEC LOLP",
+				"10U2 INR", "ACODEC LORP",
+				"Lineout", "10U2 OUTL",
+				"Lineout", "10U2 OUTR";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -191,8 +262,52 @@ dai-link-2 {
 			sound-dai = <&frddr_c>;
 		};
 
-		/* 8ch hdmi interface */
 		dai-link-3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		/* Connected to the WIFI/BT chip */
+		dai-link-6 {
+			sound-dai = <&tdmif_a>;
+			dai-format = "dsp_a";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&toacodec TOACODEC_IN_A>;
+			};
+
+			codec-1 {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
+			};
+		};
+
+		/* Connected to the onboard AD82584F DAC */
+		dai-link-7 {
+			sound-dai = <&tdmif_b>;
+			dai-format = "i2s";
+			dai-tdm-slot-tx-mask-0 = <1 1>;
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&toacodec TOACODEC_IN_B>;
+			};
+
+			codec-1 {
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+			};
+		};
+
+		/* 8ch HDMI interface */
+		dai-link-8 {
 			sound-dai = <&tdmif_c>;
 			dai-format = "i2s";
 			dai-tdm-slot-tx-mask-0 = <1 1>;
@@ -201,13 +316,17 @@ dai-link-3 {
 			dai-tdm-slot-tx-mask-3 = <1 1>;
 			mclk-fs = <256>;
 
-			codec {
+			codec-0 {
+				sound-dai = <&toacodec TOACODEC_IN_C>;
+			};
+
+			codec-1 {
 				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_C>;
 			};
 		};
 
-		/* spdif hdmi or toslink interface */
-		dai-link-4 {
+		/* spdif hdmi and coax output */
+		dai-link-9 {
 			sound-dai = <&spdifout>;
 
 			codec-0 {
@@ -220,7 +339,7 @@ codec-1 {
 		};
 
 		/* spdif hdmi interface */
-		dai-link-5 {
+		dai-link-10 {
 			sound-dai = <&spdifout_b>;
 
 			codec {
@@ -229,16 +348,38 @@ codec {
 		};
 
 		/* hdmi glue */
-		dai-link-6 {
+		dai-link-11 {
 			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
 
 			codec {
 				sound-dai = <&hdmi_tx>;
 			};
 		};
+
+		/* internal codec glue */
+		dai-link-12 {
+			sound-dai = <&toacodec TOACODEC_OUT>;
+
+			codec {
+				sound-dai = <&acodec>;
+			};
+		};
+
+		/* spdif coax input */
+		dai-link-13 {
+			sound-dai = <&spdifin>;
+
+			codec {
+				sound-dai = <&spdif_dir>;
+			};
+		};
 	};
 };
 
+&acodec {
+	status = "okay";
+};
+
 &arb {
 	status = "okay";
 };
@@ -402,6 +543,12 @@ &sd_emmc_c {
 	vqmmc-supply = <&flash_1v8>;
 };
 
+&spdifin {
+	pinctrl-0 = <&spdif_in_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &spdifout {
 	pinctrl-0 = <&spdif_ao_out_pins>;
 	pinctrl-names = "default";
@@ -412,14 +559,75 @@ &spdifout_b {
 	status = "okay";
 };
 
+&tdmif_a {
+	pinctrl-0 = <&tdm_a_fs_pins>, <&tdm_a_sclk_pins>, <&tdm_a_dout0_pins> ;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tdmif_b {
+	pinctrl-0 = <&mclk0_a_pins>, <&tdm_b_fs_pins>, <&tdm_b_sclk_pins>,
+		    <&tdm_b_dout0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	assigned-clocks = <&clkc_audio AUD_CLKID_TDM_MCLK_PAD0>,
+			  <&clkc_audio AUD_CLKID_TDM_SCLK_PAD1>,
+			  <&clkc_audio AUD_CLKID_TDM_LRCLK_PAD1>;
+	assigned-clock-parents = <&clkc_audio AUD_CLKID_MST_B_MCLK>,
+				 <&clkc_audio AUD_CLKID_MST_B_SCLK>,
+				 <&clkc_audio AUD_CLKID_MST_B_LRCLK>;
+	assigned-clock-rates = <0>, <0>, <0>;
+};
+
 &tdmif_c {
 	status = "okay";
 };
 
+&tdmin_a {
+	status = "okay";
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&tdmin_c {
+	status = "okay";
+};
+
+&tdmin_lb {
+	status = "okay";
+};
+
+&tdmout_a {
+	status = "okay";
+};
+
+&tdmout_b {
+	status = "okay";
+};
+
 &tdmout_c {
 	status = "okay";
 };
 
+&toacodec {
+	status = "okay";
+};
+
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
+
 &tohdmitx {
 	status = "okay";
 };
-- 
2.40.1

