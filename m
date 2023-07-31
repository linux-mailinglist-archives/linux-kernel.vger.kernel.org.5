Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC4769299
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjGaJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGaJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:58:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774619A2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso6335016a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797460; x=1691402260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b7lqvl9+xzm2M9ezYAd3WHYZ/uyZwwx1X/wyt05wXs=;
        b=YM3wWg+BcN8YWbbDRDbtcqbGGzUtCRPEwYwJSQr9i1Sfybow52eXTVfuhlIyhzRFsE
         vbiYQ9wuQ+IiFitk6haoefzTZw6wRIynZAdvz0L71car4R0QYVYEZZcrJZIOEBQcHR0v
         rQihg9rHtpzVyGBc1StdV2D/urxoP/a4UDwPJjb/WTpe8Fa2W0PIKxPP17hswzXGYFuW
         TSTo2eUHCPMtshATIVLC1ves23BpsIpENSKRbI+Brx90ydLwUcT+BIgvW8BWDOxfayBo
         PlGW54hzHKkrCPAV8HLXPL0/KKEApzI9vy9aToxaYa/B0QMCBMW+W8VGty9GnJKkcGGO
         LuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797460; x=1691402260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b7lqvl9+xzm2M9ezYAd3WHYZ/uyZwwx1X/wyt05wXs=;
        b=F6Qu9UVoUis1pGOh5aPERwfeEr8CjoKnU4iWl3fYvSZ+wZQkJ9xlG7mh4gRu9Q1L3F
         7PU2n3pI2CpVyfqegiQ0z1nOyEG1LnJeJbv5i4p6O7nh4/YL+ify2AiCQboFXayJ0gxe
         4wqCwwPma5LxzzKE5aJOajq+lQD2B/vx/jLiaRn7G2bbUFIVryUSTwNLvr/bOVZwv5Q7
         25U3NPwVcJskRM9T2bOnPaKuLRmAhhPQtuwoRr11j0wA2ImoewTKmzGrtDoNg47EXhqR
         XfpkEKkSUnY70Ita5N3RD7snd9ZnALABPUt8qqxFDnks9RSzw98pTQ14KHPcxwmZmg4D
         gdzw==
X-Gm-Message-State: ABy/qLZ8xx9bRDM1BM4jUgoI3Q5FgLR5hp5pLltHtPy0sdMYwZMqehv4
        lMjq1DITk0oMN7FqEnjAmc6aIw==
X-Google-Smtp-Source: APBJJlFh1J4/vop52FckddnD9utMIv9WonoVRPk4OYaP7UrWchTbyiVrHaCmN/ZYyijZ3PQJl1r07Q==
X-Received: by 2002:a17:906:77d0:b0:99b:ef9c:e634 with SMTP id m16-20020a17090677d000b0099bef9ce634mr6089122ejn.65.1690797459730;
        Mon, 31 Jul 2023 02:57:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b009828e26e519sm5860678ejb.122.2023.07.31.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:57:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/8] ARM: dts: samsung: exynos5422-odroid: switch sound card to audio-routing
Date:   Mon, 31 Jul 2023 11:57:28 +0200
Message-Id: <20230731095730.204567-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
References: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"samsung,audio-routing" property is being deprecated, so switch to
generic "audio-routing".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../samsung/exynos5422-odroidxu3-audio.dtsi   | 19 +++++++++----------
 .../boot/dts/samsung/exynos5422-odroidxu4.dts |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-audio.dtsi
index 86b96f9706db..52a1d8fd5452 100644
--- a/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-audio.dtsi
@@ -18,16 +18,15 @@ sound: sound {
 		samsung,audio-widgets =
 			"Headphone", "Headphone Jack",
 			"Speakers", "Speakers";
-		samsung,audio-routing =
-			"Headphone Jack", "HPL",
-			"Headphone Jack", "HPR",
-			"Headphone Jack", "MICBIAS",
-			"IN12", "Headphone Jack",
-			"Speakers", "SPKL",
-			"Speakers", "SPKR",
-			"I2S Playback", "Mixer DAI TX",
-			"HiFi Playback", "Mixer DAI TX",
-			"Mixer DAI RX", "HiFi Capture";
+		audio-routing = "Headphone Jack", "HPL",
+				"Headphone Jack", "HPR",
+				"Headphone Jack", "MICBIAS",
+				"IN12", "Headphone Jack",
+				"Speakers", "SPKL",
+				"Speakers", "SPKR",
+				"I2S Playback", "Mixer DAI TX",
+				"HiFi Playback", "Mixer DAI TX",
+				"Mixer DAI RX", "HiFi Capture";
 
 		cpu {
 			sound-dai = <&i2s0 0>, <&i2s0 1>;
diff --git a/arch/arm/boot/dts/samsung/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/samsung/exynos5422-odroidxu4.dts
index f5fb617f46bd..363786f032cc 100644
--- a/arch/arm/boot/dts/samsung/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/samsung/exynos5422-odroidxu4.dts
@@ -35,7 +35,7 @@ sound: sound {
 		compatible = "samsung,odroid-xu3-audio";
 		model = "Odroid-XU4";
 
-		samsung,audio-routing = "I2S Playback", "Mixer DAI TX";
+		audio-routing = "I2S Playback", "Mixer DAI TX";
 
 		cpu {
 			sound-dai = <&i2s0 0>, <&i2s0 1>;
-- 
2.34.1

