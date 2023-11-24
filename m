Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6767F704F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbjKXJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:47:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B610E3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:47:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00191363c1so249748066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819224; x=1701424024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/gUZBIUzYMuHRAbSO088kKXpKpS1gNBs/8WDq2VIbQ=;
        b=jKO6odCBYkXTweTsrHdmd5TISGHQqRmzdF5guzWkJSTn8Nt4NujmolMhWDuYAUAz9f
         nbjZj/wxZhXLfi5JB9xXKUi94SjzFgb2ejKkIKCPU0qI8lDQ1Cy2wbP9sBGzM171QSvw
         ooP0wyki7HGqnnznOCO0f1uRLHBIdGytqkgkSC8KuPRRax9Y9bJ25Yj2LMS7hIxs3yt7
         jU22FhsvKk13DkdciH90PehmpKrFz8r1S37IoqwwlA6CEK6w9YiTA0Se0LCsA7yz5FoR
         fB2xJX7h5j+yaQzyUMMjFjJ+orLBtSs1A80v0jUsgqu0uvug3ltv6xdozuIaep83KBLZ
         MF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819224; x=1701424024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/gUZBIUzYMuHRAbSO088kKXpKpS1gNBs/8WDq2VIbQ=;
        b=t4xJ5hSkClrmVKtNsuOdQLOXuggWqK0nZ3+JCXJHqIs2BFCFYvgZat7MlbOH8c2bM4
         Kyxx3CEzyQdClkzuZ6ABfOOZS/l3PeGtDUlX8P2+lH6SoIGcatcLr49uTrc5RPHCTli6
         H32rLH3g/kHNKDRroBOVZMvD9eiqH6plmKh5qHEGF1lKYgNQ1ttBwD0k05gMsT8j3H7s
         K5cOaO/I4oEPLKMkOqcTSQeeui4SerodzQe3G7X94HXnyPMs5Jy+VzpP2FmmrCwwKHzf
         jD2KBNb3EXKyglEHiuWEA8MSGotblIZW8KYUScHHcgCst7UPPKmZtM1BLt7GAaYXo1Bu
         mOcA==
X-Gm-Message-State: AOJu0YycLwRXUJI2wDOu5jcf/EE/PMM3i4E/6aYbXkqVrCZ27VZUHJOb
        WxT3plsBLrdgV3ocGtHDqS+nhQ==
X-Google-Smtp-Source: AGHT+IFMvp2KSIa0Xp2qSzbbXG24Z2Ciz59q7uri8yqqjGSTT4CLqK9Dzs88aSY4DgaBLqnb9qMAKw==
X-Received: by 2002:a17:906:7387:b0:9ff:6ae6:9fea with SMTP id f7-20020a170906738700b009ff6ae69feamr1467114ejl.55.1700819224271;
        Fri, 24 Nov 2023 01:47:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906378700b009b2cc87b8c3sm1852685ejc.52.2023.11.24.01.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:47:03 -0800 (PST)
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
Subject: [PATCH] arm64: dts: amlogic: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:47:00 +0100
Message-Id: <20231124094700.58071-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts    | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi        | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
index 0062667c4f65..c9e84db0831a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dts
@@ -30,7 +30,7 @@ &sd_emmc_b {
 &uart_B {
 	bluetooth {
 		compatible = "realtek,rtl8822cs-bt";
-		enable-gpios  = <&gpio GPIOZ_7 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio GPIOZ_7 GPIO_ACTIVE_HIGH>;
 		host-wake-gpios = <&gpio GPIOZ_8 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio GPIOZ_6 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
index 995ce10d5c81..08c33ec7e9f1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
@@ -369,7 +369,7 @@ &uart_A {
 
 	bluetooth {
 		compatible = "realtek,rtl8822cs-bt";
-		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		host-wake-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
index 0a6a12808568..4b8db872bbf3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
@@ -487,7 +487,7 @@ &uart_A {
 
 	bluetooth {
 		compatible = "realtek,rtl8822cs-bt";
-		enable-gpios  = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		host-wake-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.34.1

