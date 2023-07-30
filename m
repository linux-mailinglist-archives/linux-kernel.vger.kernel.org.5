Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E37686E7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjG3RuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjG3RuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:50:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965B1709
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:50:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bccc9ec02so596574866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690739401; x=1691344201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0JMSr6ztA05jmLDaIzGxamkK1kTz52ftEBBvAyV0mA=;
        b=WGgNOz1T5FuGFUgMWJng2mqOuR62p2WNmaq4WZQZc8EtAvQg/gvbavjgGHPsdL5byv
         /8n4vjVxnfbym1Fd+wl7UkYOXleEd6+jNrAYJ7bMoS4euqunAWZE0G7hfE9bdQLoRuA2
         BWyG9uFWaaGacDcfnkVsNpB8G1wu/lXQgW1PMwkHPGMXdrRGKhnU596b++8xkUKXUlHt
         XHAvraIqWvMpXD+ifaxCB35iS6Mex/cIqIlbpAy+nvNxqMS8lGuXWtlWttBpgytiECa5
         xDXzWhIqDYOqZnQj+Qd5LwDAynaRBk1AiuwGHyddZ1uoXPYVsQqQ5rQRs6pZjALlkh0l
         6Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690739401; x=1691344201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0JMSr6ztA05jmLDaIzGxamkK1kTz52ftEBBvAyV0mA=;
        b=MYRoEkXJTjlVuMAsnP/4ZW2Kl8vVN/DRGAJ+xOftWi/JqjNU6UV5nfdNngBGDv+RNz
         N7M6x2HfoS9paffEx3XXOboj3AY6mgKDRui1MlGd9ALjC4X92G/A3FU1KAokTEJUHwD+
         OcdMH2fuElc+zFt3bXRGg6jaV3tYrTXUAufdNWXHFJbg/X6LlWt2tvy0omwGnFm4A4vx
         S1vXUxn+47LiYX/ZC7mmUfIMlJvc7B7+uXwjjYzWeQ1Pex7EEX8pTpKT+RDjOSik2QW3
         Dvevk0F8BeSUqM+9D6L0m7VpInLqOthjmApu8FTt8Tudf3buHG2HC1vtiuQsFgjUYIWw
         B1bw==
X-Gm-Message-State: ABy/qLaT2aC2DY58cH2qWfyEKsvYOLm/TW2Q0H49IHoxMeruxuN5ygKK
        jFujmL7y6/VbB/+vbg/Sgm1bGQ==
X-Google-Smtp-Source: APBJJlGz19IFvmEMqfL23X2YXbqU3Sz+jR/XJnz6m0yn6JR5EwOFd9qqlwMPvB+JXLEz8LNeezUGiw==
X-Received: by 2002:a17:906:5393:b0:99b:d6f5:afee with SMTP id g19-20020a170906539300b0099bd6f5afeemr5486169ejo.23.1690739400806;
        Sun, 30 Jul 2023 10:50:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906495300b00992c4103cb5sm4913537ejt.129.2023.07.30.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 10:50:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] ARM: dts: st: ste: switch to enable-gpios
Date:   Sun, 30 Jul 2023 19:49:53 +0200
Message-Id: <20230730174954.5293-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230730174954.5293-1-krzysztof.kozlowski@linaro.org>
References: <20230730174954.5293-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recommended name for enable GPIOs property in regulator-gpio is
"enable-gpios".  This is also required by bindings:

  ste-hrefv60plus-stuib.dtb: regulator-gpio: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Correct subject prefix: AMR->ARM
---
 arch/arm/boot/dts/st/ste-href520-tvk.dts       | 2 +-
 arch/arm/boot/dts/st/ste-hrefprev60-stuib.dts  | 2 +-
 arch/arm/boot/dts/st/ste-hrefprev60-tvk.dts    | 2 +-
 arch/arm/boot/dts/st/ste-hrefv60plus-stuib.dts | 2 +-
 arch/arm/boot/dts/st/ste-hrefv60plus-tvk.dts   | 2 +-
 arch/arm/boot/dts/st/ste-snowball.dts          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-href520-tvk.dts b/arch/arm/boot/dts/st/ste-href520-tvk.dts
index 4201547c5988..7f661f8f13ad 100644
--- a/arch/arm/boot/dts/st/ste-href520-tvk.dts
+++ b/arch/arm/boot/dts/st/ste-href520-tvk.dts
@@ -28,7 +28,7 @@ vmmci: regulator-gpio {
 			  2900000 0x0>;
 
 		gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
-		enable-gpio = <&gpio2 14 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio2 14 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/st/ste-hrefprev60-stuib.dts b/arch/arm/boot/dts/st/ste-hrefprev60-stuib.dts
index dfc933214c1a..a29e345a43d3 100644
--- a/arch/arm/boot/dts/st/ste-hrefprev60-stuib.dts
+++ b/arch/arm/boot/dts/st/ste-hrefprev60-stuib.dts
@@ -27,7 +27,7 @@ vmmci: regulator-gpio {
 			  2900000 0x0>;
 
 		gpios = <&tc3589x_gpio 18 GPIO_ACTIVE_HIGH>;
-		enable-gpio = <&tc3589x_gpio 17 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&tc3589x_gpio 17 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
diff --git a/arch/arm/boot/dts/st/ste-hrefprev60-tvk.dts b/arch/arm/boot/dts/st/ste-hrefprev60-tvk.dts
index 75506339a93c..1968bd143114 100644
--- a/arch/arm/boot/dts/st/ste-hrefprev60-tvk.dts
+++ b/arch/arm/boot/dts/st/ste-hrefprev60-tvk.dts
@@ -27,7 +27,7 @@ vmmci: regulator-gpio {
 			  2900000 0x0>;
 
 		gpios = <&tc3589x_gpio 18 GPIO_ACTIVE_HIGH>;
-		enable-gpio = <&tc3589x_gpio 17 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&tc3589x_gpio 17 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 };
diff --git a/arch/arm/boot/dts/st/ste-hrefv60plus-stuib.dts b/arch/arm/boot/dts/st/ste-hrefv60plus-stuib.dts
index 52c56ed17ae6..7a5b6aa1db5b 100644
--- a/arch/arm/boot/dts/st/ste-hrefv60plus-stuib.dts
+++ b/arch/arm/boot/dts/st/ste-hrefv60plus-stuib.dts
@@ -29,7 +29,7 @@ vmmci: regulator-gpio {
 			  2900000 0x0>;
 
 		gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
-		enable-gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/st/ste-hrefv60plus-tvk.dts b/arch/arm/boot/dts/st/ste-hrefv60plus-tvk.dts
index 2db2f8be8b03..d5af3f375161 100644
--- a/arch/arm/boot/dts/st/ste-hrefv60plus-tvk.dts
+++ b/arch/arm/boot/dts/st/ste-hrefv60plus-tvk.dts
@@ -29,7 +29,7 @@ vmmci: regulator-gpio {
 			  2900000 0x0>;
 
 		gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
-		enable-gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/st/ste-snowball.dts b/arch/arm/boot/dts/st/ste-snowball.dts
index 9a3d6546399d..27c2ec51e732 100644
--- a/arch/arm/boot/dts/st/ste-snowball.dts
+++ b/arch/arm/boot/dts/st/ste-snowball.dts
@@ -229,7 +229,7 @@ vmmci: regulator-gpio {
 			/* GPIO228 SD_SEL */
 			gpios = <&gpio7 4 GPIO_ACTIVE_HIGH>;
 			/* GPIO217 MMC_EN */
-			enable-gpio = <&gpio6 25 GPIO_ACTIVE_HIGH>;
+			enable-gpios = <&gpio6 25 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 
 			regulator-min-microvolt = <1800000>;
-- 
2.34.1

