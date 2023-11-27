Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA927F9CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjK0Jew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjK0Jeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:34:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A80188
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:34:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a02d12a2444so576512666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701077693; x=1701682493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RY9K8qPrQv/S8sDmHQHNclT5diku1Ugllu02/SpchUk=;
        b=OcUylt7e8FUgks8dowt5QKdiHlMkSfY9gzMPlD0SD5KaSsSF+uTryPSYVzy2EBMDN1
         SoZBZsEarsx1ER7KovnLoO2m7zCa7/tHQ/nmGX1J2DYua8GAgxNbbu5q4wJS7pQdzehj
         2VFqjDfTw0ATEyl/veryqd+lly1/QLdWYNI3u22rLaEGU6C0NIG4ZYjOQNru8XeLOKg2
         7asUOh6DapbpM6OsQWHn69jy7TjU1Rli9kJzEUYFQ2Z3kEaVLP63zbEJGD0YUWUEyp2s
         xms54IUxWZIqxpUoe5Cpg7wqMEIyMpsQ+K1JLHu7AZ2+wfKR8noofze0QJzDeV86UN1j
         k+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701077693; x=1701682493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RY9K8qPrQv/S8sDmHQHNclT5diku1Ugllu02/SpchUk=;
        b=nQwXRmTmYZ+AzXSufBnZgWOMnKWE2eQTJL94M5LNfJlaqeLo9IRiHIPNRunhNa7ksY
         DepMPGkbSwc3mrw+0livhdvkrv00Rbrg9Cl3awkWgz0zHIvq/OUjQLIqOvVH3agn0/VX
         pvpERwYY+5XD5qljw6MHTob8v1JStFHrSaFhClImagyQ61CuXWHgJMb3lAZGfkx5XXsr
         dqeg80vrRiLKTjEs1sBhf5YMaP3iyuMmUVP6LhM4r6JufRh1BP4Bg0IAYw7CacdOKKe5
         YqO0t4Lrxg3XpLckfVmKY7E2Osjb9hbwNXVR5ENTTnFwAE3F+QYnBywjgTv00UO7PKuK
         wf4Q==
X-Gm-Message-State: AOJu0Yz7l3TvrPTXKXOwKehnuUASgDMFTecRWTQyt0asykN12HteW7os
        dRGJzed7o7UU1OtOJLMoOlc5A8jEwpjNlMn61yZbCg==
X-Google-Smtp-Source: AGHT+IE9CZCMTfy7aaNTGRDc+CebTi2e9gEFVB4o1ghijITLjwGO5qgGsKoJq6+VGWhPmF+3KN8NXA==
X-Received: by 2002:a17:906:15a:b0:a0c:c11a:ded0 with SMTP id 26-20020a170906015a00b00a0cc11aded0mr3485993ejh.41.1701077693658;
        Mon, 27 Nov 2023 01:34:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a170906051900b00a0bdfab0f02sm2762905eja.77.2023.11.27.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:34:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ARM: dts: ste: minor whitespace cleanup around '='
Date:   Mon, 27 Nov 2023 10:34:51 +0100
Message-Id: <20231127093451.20577-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Split previous commit touching entire 'st' directory.
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi           | 18 +++++++++---------
 arch/arm/boot/dts/st/ste-hrefprev60.dtsi       |  2 +-
 arch/arm/boot/dts/st/ste-hrefv60plus.dtsi      |  2 +-
 arch/arm/boot/dts/st/ste-nomadik-stn8815.dtsi  |  8 ++++----
 arch/arm/boot/dts/st/ste-snowball.dts          |  2 +-
 .../dts/st/ste-ux500-samsung-codina-tmo.dts    |  2 +-
 .../boot/dts/st/ste-ux500-samsung-codina.dts   |  2 +-
 .../boot/dts/st/ste-ux500-samsung-gavini.dts   |  2 +-
 .../boot/dts/st/ste-ux500-samsung-janice.dts   |  2 +-
 .../arm/boot/dts/st/ste-ux500-samsung-kyle.dts |  2 +-
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index d5d88771ef97..0f87abeddc33 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -425,7 +425,7 @@ rtc@80154000 {
 		gpio0: gpio@8012e000 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8012e000 0x80>;
+			reg = <0x8012e000 0x80>;
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -440,7 +440,7 @@ gpio0: gpio@8012e000 {
 		gpio1: gpio@8012e080 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8012e080 0x80>;
+			reg = <0x8012e080 0x80>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -455,7 +455,7 @@ gpio1: gpio@8012e080 {
 		gpio2: gpio@8000e000 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8000e000 0x80>;
+			reg = <0x8000e000 0x80>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -470,7 +470,7 @@ gpio2: gpio@8000e000 {
 		gpio3: gpio@8000e080 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8000e080 0x80>;
+			reg = <0x8000e080 0x80>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -485,7 +485,7 @@ gpio3: gpio@8000e080 {
 		gpio4: gpio@8000e100 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8000e100 0x80>;
+			reg = <0x8000e100 0x80>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -500,7 +500,7 @@ gpio4: gpio@8000e100 {
 		gpio5: gpio@8000e180 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8000e180 0x80>;
+			reg = <0x8000e180 0x80>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -515,7 +515,7 @@ gpio5: gpio@8000e180 {
 		gpio6: gpio@8011e000 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8011e000 0x80>;
+			reg = <0x8011e000 0x80>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -530,7 +530,7 @@ gpio6: gpio@8011e000 {
 		gpio7: gpio@8011e080 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0x8011e080 0x80>;
+			reg = <0x8011e080 0x80>;
 			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -545,7 +545,7 @@ gpio7: gpio@8011e080 {
 		gpio8: gpio@a03fe000 {
 			compatible = "stericsson,db8500-gpio",
 				"st,nomadik-gpio";
-			reg =  <0xa03fe000 0x80>;
+			reg = <0xa03fe000 0x80>;
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/st/ste-hrefprev60.dtsi b/arch/arm/boot/dts/st/ste-hrefprev60.dtsi
index 9859ee91a15e..c87fd27b4434 100644
--- a/arch/arm/boot/dts/st/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/st/ste-hrefprev60.dtsi
@@ -62,7 +62,7 @@ spi@80002000 {
 
 		// External Micro SD slot
 		mmc@80126000 {
-			cd-gpios  = <&tc3589x_gpio 3 GPIO_ACTIVE_HIGH>;
+			cd-gpios = <&tc3589x_gpio 3 GPIO_ACTIVE_HIGH>;
 		};
 
 		pinctrl {
diff --git a/arch/arm/boot/dts/st/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/st/ste-hrefv60plus.dtsi
index e66fa59c2de6..f87f4150ea68 100644
--- a/arch/arm/boot/dts/st/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/st/ste-hrefv60plus.dtsi
@@ -191,7 +191,7 @@ gpio@8011e080 {
 
 		// External Micro SD slot
 		mmc@80126000 {
-			cd-gpios  = <&gpio2 31 GPIO_ACTIVE_HIGH>; // 95
+			cd-gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>; // 95
 		};
 
 		pinctrl {
diff --git a/arch/arm/boot/dts/st/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/st/ste-nomadik-stn8815.dtsi
index 6816eef39d45..4d37c5fb553c 100644
--- a/arch/arm/boot/dts/st/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/st/ste-nomadik-stn8815.dtsi
@@ -52,7 +52,7 @@ mtu1: mtu@101e3000 {
 
 	gpio0: gpio@101e4000 {
 		compatible = "st,nomadik-gpio";
-		reg =  <0x101e4000 0x80>;
+		reg = <0x101e4000 0x80>;
 		interrupt-parent = <&vica>;
 		interrupts = <6>;
 		interrupt-controller;
@@ -66,7 +66,7 @@ gpio0: gpio@101e4000 {
 
 	gpio1: gpio@101e5000 {
 		compatible = "st,nomadik-gpio";
-		reg =  <0x101e5000 0x80>;
+		reg = <0x101e5000 0x80>;
 		interrupt-parent = <&vica>;
 		interrupts = <7>;
 		interrupt-controller;
@@ -80,7 +80,7 @@ gpio1: gpio@101e5000 {
 
 	gpio2: gpio@101e6000 {
 		compatible = "st,nomadik-gpio";
-		reg =  <0x101e6000 0x80>;
+		reg = <0x101e6000 0x80>;
 		interrupt-parent = <&vica>;
 		interrupts = <8>;
 		interrupt-controller;
@@ -94,7 +94,7 @@ gpio2: gpio@101e6000 {
 
 	gpio3: gpio@101e7000 {
 		compatible = "st,nomadik-gpio";
-		reg =  <0x101e7000 0x80>;
+		reg = <0x101e7000 0x80>;
 		ngpio = <28>;
 		interrupt-parent = <&vica>;
 		interrupts = <9>;
diff --git a/arch/arm/boot/dts/st/ste-snowball.dts b/arch/arm/boot/dts/st/ste-snowball.dts
index 27c2ec51e732..1322abfc7acf 100644
--- a/arch/arm/boot/dts/st/ste-snowball.dts
+++ b/arch/arm/boot/dts/st/ste-snowball.dts
@@ -266,7 +266,7 @@ mmc@80126000 {
 			pinctrl-1 = <&mc0_a_1_sleep>;
 
 			/* GPIO218 MMC_CD */
-			cd-gpios  = <&gpio6 26 GPIO_ACTIVE_LOW>;
+			cd-gpios = <&gpio6 26 GPIO_ACTIVE_LOW>;
 
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
index 463942ae755e..c623cc35c5ea 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts
@@ -310,7 +310,7 @@ mmc@80126000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&mc0_a_2_default>;
 			pinctrl-1 = <&mc0_a_2_sleep>;
-			cd-gpios  = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
+			cd-gpios = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
index c1ae0e23fe45..2355ca6e9ad6 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-codina.dts
@@ -402,7 +402,7 @@ mmc@80126000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&mc0_a_2_default>;
 			pinctrl-1 = <&mc0_a_2_sleep>;
-			cd-gpios  = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
+			cd-gpios = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-gavini.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-gavini.dts
index b21e40da3dfd..ad9a20ccaaeb 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-gavini.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-gavini.dts
@@ -362,7 +362,7 @@ mmc@80126000 {
 			pinctrl-0 = <&mc0_a_2_default>;
 			pinctrl-1 = <&mc0_a_2_sleep>;
 			/* "flash detect" actually card detect */
-			cd-gpios  = <&gpio6 25 GPIO_ACTIVE_LOW>;
+			cd-gpios = <&gpio6 25 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
index 6e586e875565..229f7c32103c 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-janice.dts
@@ -412,7 +412,7 @@ mmc@80126000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&mc0_a_2_default>;
 			pinctrl-1 = <&mc0_a_2_sleep>;
-			cd-gpios  = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
+			cd-gpios = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts b/arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts
index ba4421080b2a..cdb147dcc1db 100644
--- a/arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts
+++ b/arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts
@@ -238,7 +238,7 @@ mmc@80126000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&mc0_a_1_default>;
 			pinctrl-1 = <&mc0_a_1_sleep>;
-			cd-gpios  = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
+			cd-gpios = <&gpio6 25 GPIO_ACTIVE_LOW>; // GPIO217
 			status = "okay";
 		};
 
-- 
2.34.1

