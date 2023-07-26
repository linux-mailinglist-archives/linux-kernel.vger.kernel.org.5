Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F565762CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjGZHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjGZHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:06:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA962D5B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:04:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso985868566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355039; x=1690959839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRaenXoW9ED5z6ykYCC4nTP4YO7Ln/kJx6OoQkFxhJ0=;
        b=AcuFcfWRbOIvi//TDDtHtI9SDhOAqbU26ab9g7x3ewborwzWCcZkkzRi0LTcYxt1aI
         9/6x9Ab8Mnc/cfEblggBpEsO6iLxegIgPo+d2arWFmKPg3EUNBhv4+76Qbq3c2FL/0WT
         PC8Jfibs4zwR4aHnjibtNhTZEY+b9Y7ni+UjDCbwl44+AxrOMp/QyHtqzL8TfHZEdO+C
         RqdMvQXA5nxjN16lrbFDXa6QV+du1PM8g19JfKKE0Axa0WGlXzQ5cypldaiGEJ+ICo0/
         C8qvHJoCJzqR6VTHuvkL4g07h5xxTrWVd6mu+cdxXd3FlBC6VH2bOwdjIVd6tFhEwc4K
         vA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355039; x=1690959839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRaenXoW9ED5z6ykYCC4nTP4YO7Ln/kJx6OoQkFxhJ0=;
        b=krIK8ImquZX5OukmEac4Npv6Q5nMzxB77JEuqRrmbzkyr2qWcdsfTDJVAcnHe0euVX
         OGHBf7BtviCFktw2tt2EXUJ2PLRJv47HmWqDRiZulwvFKd5x5RyLQKfY6W4HRpBuIJVA
         U6K07U1lfGtGzJuc60Icoy9tUemsCbnZmntXjvDcUGEzCgbPI2cYDns8206Qqq/YCvvg
         K4s0kSB8XDogbn/WtZWvzDQ9iXcVQV00+504cZ0rttbf3Pm7ZaEXaJhXtq7harzO97ce
         NG5KhC/4jEHuPnGASXrhesqaWhimWcVCpkYuaX3GiJwKDgpg1N7hpPeSOqslxVfIQvKC
         uoRg==
X-Gm-Message-State: ABy/qLYuVgRJ8vZ9/yu9VCim2iBYLQJz6m6/m0trnPSAg/rPrD3o3Aza
        bXdTyfW5b2h7lcPyy37mShLScQ==
X-Google-Smtp-Source: APBJJlFszf/28HoAVClrXvkXOPjHFCAcWzrtDqfxU+rdB5bRhmL1z1O+ONed789extBHeuUtidnd1A==
X-Received: by 2002:a17:906:53c2:b0:99b:59bb:c4a4 with SMTP id p2-20020a17090653c200b0099b59bbc4a4mr772410ejo.60.1690355039243;
        Wed, 26 Jul 2023 00:03:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b0097404f4a124sm9212372ejb.2.2023.07.26.00.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:58 -0700 (PDT)
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
Subject: [PATCH 3/4] AMR: dts: st: ste: switch to enable-gpios
Date:   Wed, 26 Jul 2023 09:03:52 +0200
Message-Id: <20230726070353.103989-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org>
References: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

