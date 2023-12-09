Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACF80B45C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjLIMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIMoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:44:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D596ECF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:44:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1ec87a7631so266016866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 04:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702125846; x=1702730646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlW1QeOythGiXV9v0OHR4FjhcGgbYTUzhlL3KytwSuw=;
        b=UgWgGt0tMy0Mg9MZZeCB9MlroGs0z6k1y8mRC99/cjw7cc1H3IsHydznHOAHfZpYog
         z8dkHk/a9g6zrRHHdTAP3cXcF40pd41A7qHVf6q7ejehIauSmHEz4busFZRS+YVP/sOi
         T+yfFpwif9xnEuzYPlfsFZ/nV9LXMgh4+M5WS5B43yrCQNENv8YSfW7OvzltE5UJR5Xy
         WomeXGzxhGXU4j4VAoI6y+ZZR7o0UbLwNdiZYhJZMA4hwp2ItMTdCGd0qbm+fmZJTnBM
         uNJ67rjdEUxFoKsYEqO8Vg/OkmKLEsaNBeSlnVqDweb7qRrpa8CcJIFjdPaz8DjVvf7s
         eo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702125846; x=1702730646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlW1QeOythGiXV9v0OHR4FjhcGgbYTUzhlL3KytwSuw=;
        b=Vy2GDK1DRV2BJ+MmZMaPnZ5BRjvIy8mxMNaIyHFtD6BwmUwS1GMkggGFVNC/QqIjqY
         tm95DDy1AKJrZVbV6gQjVlBwkf6fsD7hsOoWDUf/wMEhQ3F6DVZz9KbcA33axBTakNrM
         /zs+2Jqny9ZUpiYda0zwgM7lwSZ0+HvaM/AludOKIZOIDFS0bUZAkb5dZ632N4sHFej0
         IlJ2iRyeRFKN3cAl+b/g+QG5yc7QRHMxFBppp6cneTrzjtoENXjLHenxOUjtRJoCyG9P
         bsf3MBUAOiJKzFc0B4CsqbdNOgiGsqSCh9fTeZCQO2mJfD5twoUpbhayuiodcTcuesZc
         gXnw==
X-Gm-Message-State: AOJu0Yxgf8+hiHSJlPoyedVFiDRNqCfB4Vui9/JlaRGZTaw+7gcKICWJ
        9o5s64t26ImZUqojAKofiipDaW0PSF2zdZCvJhg=
X-Google-Smtp-Source: AGHT+IFPrs4abrIuCx7HGhbyV988M7akIWQqbGoMdmPgPd+qDRTQsV0FuJWdwJ7Orr4nunEpO15dnA==
X-Received: by 2002:a17:906:1812:b0:a0c:46b4:a705 with SMTP id v18-20020a170906181200b00a0c46b4a705mr814349eje.56.1702125845885;
        Sat, 09 Dec 2023 04:44:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a1b65cd1957sm2191829ejc.107.2023.12.09.04.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 04:44:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: amlogic: drop redundant status=okay
Date:   Sat,  9 Dec 2023 13:44:01 +0100
Message-Id: <20231209124401.93814-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New device nodes are enabled by default, so no need for status=okay.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Tested by comparing decompiled DTBs.
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts         | 5 -----
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts      | 1 -
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts     | 1 -
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts      | 1 -
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts   | 1 -
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts     | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts        | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts    | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts     | 1 -
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts       | 1 -
 13 files changed, 17 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index df16eead2c80..c8905663bc75 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -66,7 +66,6 @@ linein: audio-codec-0 {
 		VDDA-supply = <&vcc_3v3>;
 		VDDP-supply = <&vcc_3v3>;
 		VDDD-supply = <&vcc_3v3>;
-		status = "okay";
 		sound-name-prefix = "Linein";
 	};
 
@@ -75,14 +74,12 @@ lineout: audio-codec-1 {
 		compatible = "everest,es7154";
 		VDD-supply = <&vcc_3v3>;
 		PVDD-supply = <&vcc_5v>;
-		status = "okay";
 		sound-name-prefix = "Lineout";
 	};
 
 	spdif_dit: audio-codec-2 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
@@ -91,14 +88,12 @@ dmics: audio-codec-3 {
 		compatible = "dmic-codec";
 		num-channels = <7>;
 		wakeup-delay-ms = <50>;
-		status = "okay";
 		sound-name-prefix = "MIC";
 	};
 
 	spdif_dir: audio-codec-4 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dir";
-		status = "okay";
 		sound-name-prefix = "DIR";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 0ad0c2b7dfef..4c4550dd4711 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -45,7 +45,6 @@ dmics: audio-codec-1 {
 		compatible = "dmic-codec";
 		num-channels = <2>;
 		wakeup-delay-ms = <50>;
-		status = "okay";
 		sound-name-prefix = "MIC";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 4969a76460fa..9b55982b6a6b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -22,7 +22,6 @@ aliases {
 	spdif_dit: audio-codec-1 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index 8fc2e143cb54..0da386cabe1a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -22,7 +22,6 @@ aliases {
 	spdif_dit: audio-codec-1 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index ce548b373296..6396f190d703 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -17,7 +17,6 @@ / {
 	spdif_dit: audio-codec-1 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 18f7b730289e..e59c3c92b1e7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -26,7 +26,6 @@ dio2133: analog-amplifier {
 	spdif_dit: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index e238f1f10124..f28452b9f00f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -18,7 +18,6 @@ / {
 	spdif_dit: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 292c718ee19c..591455c50e88 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -18,7 +18,6 @@ / {
 	spdif_dit: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index e8303089bff6..74df32534231 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -21,7 +21,6 @@ chosen {
 	spdif_dit: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index e1b74b174915..376760d86766 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -17,7 +17,6 @@ / {
 	spdif_dit: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 7d525bdb0e06..ad2dd4ad0a31 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -28,7 +28,6 @@ chosen {
 	spdif_dit: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 50d49aec41bd..d05dde8da5c5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -37,7 +37,6 @@ memory@0 {
 	spdif_dit: audio-codec-0 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-		status = "okay";
 		sound-name-prefix = "DIT";
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 095579c55f18..109932068dbe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -32,7 +32,6 @@ dmics: audio-codec-1 {
 		compatible = "dmic-codec";
 		num-channels = <2>;
 		wakeup-delay-ms = <50>;
-		status = "okay";
 		sound-name-prefix = "MIC";
 	};
 
-- 
2.34.1

