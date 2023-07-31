Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6922B76928A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGaJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjGaJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:58:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6B10DE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf91956cdso300648566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797455; x=1691402255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfg4ljS/G5hMXyWN2ybdTjORVp3riaVQeb5S/esVdkk=;
        b=Qh2reV8J3b6DOV5dQBvY+Ke9EcprVGYC7vPLfFQNe5jmOaOSLewH4yhj1rs8bAnyQ0
         5kYQeOyaZqNxfeV1XfQCl5Fa3DsxPYSWheE5/L1dF3F+TsAiiqUMlnZS9gYKdbkESNzy
         tj/WTgNSFWk08Zy7B5le8O302OjKjJY5MRqFORs8pVCQl8BnTiPjlC8Dpi2cKQz4kmct
         QQAn++GTaV+22JnmVV4Y1+fixidEyDLLYfDDRpjmFWuSqr0SvFK8Ml5xWPGLlASjbaS6
         HuYC0okeMTsTaPVVJW/rqbwmHNGlYQVOLjG1HbcYWP7cKRYihZMc8ydbWrHGuVtuTGxk
         UXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797455; x=1691402255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfg4ljS/G5hMXyWN2ybdTjORVp3riaVQeb5S/esVdkk=;
        b=Dzk4Qf59yi8NE2dkK1oipV6etYLayT9zKTXK4MM0abudgoyVrbuSfX6LPwC9jY7VM4
         nm3niwv7ItOWUnRpaDMQfCk6KhWiBXySI5WbQ2fl33/Sa/pd0ZPzMnPwDIfVz7PGaxY2
         R6gXatc/6ZrM1A7V1cwVp3QBl99tnW3TVa5uebXBgS+570SI/yO2ScSgX1OwS6iedcMY
         85LeNcY8Ezjft1Kcvlt6hjCJlzNb2qOllXtO0egS1NAx3BOGtj3SuI3Ktxf/+PEt5ZU9
         Yqc6UQ4NA4scSpXKq0Tczha8S/UoR8jnnFzRdDjltjaarKP9drsHZEfXuCkcU5oDQ3Z0
         cW1A==
X-Gm-Message-State: ABy/qLb6oqADz5WzW/QlLlqldivxdf5x9kD0pNaSOYr8hgmGpjSPt1mG
        77ooJt7C82scDSZCQ/sQInZFXQ==
X-Google-Smtp-Source: APBJJlFeUa2mlh8RvHfFZuQSnVyR7+J8aqs/JkQaBAT2t6IPASs8mtV+RKQjzjUk18opMhPc3AvpMQ==
X-Received: by 2002:a17:907:a077:b0:993:d536:3cb8 with SMTP id ia23-20020a170907a07700b00993d5363cb8mr5558534ejc.2.1690797455143;
        Mon, 31 Jul 2023 02:57:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b009828e26e519sm5860678ejb.122.2023.07.31.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:57:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] ARM: dts: samsung: exynos4212-tab3: switch sound card to audio-routing
Date:   Mon, 31 Jul 2023 11:57:24 +0200
Message-Id: <20230731095730.204567-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
References: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
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

"samsung,audio-routing" property is being deprecated, so switch to
generic "audio-routing".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Change depends on ASoC:
https://lore.kernel.org/linux-devicetree/20230731094303.185067-1-krzysztof.kozlowski@linaro.org/T/#t
---
 .../arm/boot/dts/samsung/exynos4212-tab3.dtsi | 41 +++++++++----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index ce81e42bf5eb..d7954ff466b4 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -300,34 +300,33 @@ sound: sound {
 		mic-bias-supply = <&mic_bias_reg>;
 		submic-bias-supply = <&submic_bias_reg>;
 
-		samsung,audio-routing =
-			"HP", "HPOUT1L",
-			"HP", "HPOUT1R",
+		audio-routing = "HP", "HPOUT1L",
+				"HP", "HPOUT1R",
 
-			"SPK", "SPKOUTLN",
-			"SPK", "SPKOUTLP",
-			"SPK", "SPKOUTRN",
-			"SPK", "SPKOUTRP",
+				"SPK", "SPKOUTLN",
+				"SPK", "SPKOUTLP",
+				"SPK", "SPKOUTRN",
+				"SPK", "SPKOUTRP",
 
-			"RCV", "HPOUT2N",
-			"RCV", "HPOUT2P",
+				"RCV", "HPOUT2N",
+				"RCV", "HPOUT2P",
 
-			"LINE", "LINEOUT2N",
-			"LINE", "LINEOUT2P",
+				"LINE", "LINEOUT2N",
+				"LINE", "LINEOUT2P",
 
-			"HDMI", "LINEOUT1N",
-			"HDMI", "LINEOUT1P",
+				"HDMI", "LINEOUT1N",
+				"HDMI", "LINEOUT1P",
 
-			"IN2LP:VXRN", "MICBIAS1",
-			"IN2LN", "MICBIAS1",
-			"Main Mic", "MICBIAS1",
+				"IN2LP:VXRN", "MICBIAS1",
+				"IN2LN", "MICBIAS1",
+				"Main Mic", "MICBIAS1",
 
-			"IN1RP", "MICBIAS2",
-			"IN1RN", "MICBIAS2",
-			"Sub Mic", "MICBIAS2",
+				"IN1RP", "MICBIAS2",
+				"IN1RN", "MICBIAS2",
+				"Sub Mic", "MICBIAS2",
 
-			"IN1LP", "Headset Mic",
-			"IN1LN", "Headset Mic";
+				"IN1LP", "Headset Mic",
+				"IN1LN", "Headset Mic";
 
 		cpu {
 			sound-dai = <&i2s0 0>;
-- 
2.34.1

