Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1926769291
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjGaJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjGaJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:58:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF971986
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bccc9ec02so683952266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797456; x=1691402256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3Vi3YksCGCOpys5s2S1isiXjJ58pK8I2do3CJIG8is=;
        b=qXD0FZMJApl4Mp3Bmbcu1JKQXXzNDllLdrv529BiQqs99pL1pEfemp3T/ZTVBeORKJ
         iMjJPNgpf0DaYxxpkwu+5hLIWI6Y47Lw2ebBfav9aS40MERd9ZH5ZlwU4H/wa11SaTpM
         /le8FItPRToM0N/gtmfT2BNlIKfZCTs3eWGkr42uR0hh0BhF0g6W0u5kuYMTlMylhSSs
         okY3TB1gd/IoPIE/w3GCXNdfqkvdNSc1Daw+LDpMn82Fhw8I02hR7ZjIKsmYkGPFeB3V
         UVQT7iBtd4G2bhDeLu45mMn7OqLSuvHpwvzF6ob3mlheQGImCyDdinCmMw45BD1QYMsu
         cdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797456; x=1691402256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3Vi3YksCGCOpys5s2S1isiXjJ58pK8I2do3CJIG8is=;
        b=XNa4Xcv7Mqc8C4aRVb0x+cFHqMNxZe0sxjTO/pPizzMTpsl8xRVBcJgaC/DXu14e3M
         kLemJKj/xjEXeL7xLpl+uU1Oq3mqVpVS5Gb/ZJuLx2TEkqGfge3fytzqzsJu1cj5QBEP
         xwd1kFunQki5Mqze7/NjKK8tRpiDU3ulOLsUociyHCM4SQnyIE/3QuXTUW8h8yMDoE86
         nRBXYBjz0rzJXb9lRy0pkQZz3EQ6OlfBF1rs+nI5N76em652tY2XPVuyU9FPzAq0pbgq
         33FfPElqT8lmemdyrPU8oQZ6uX6rVeeM+viamZVCBDIiY65oadZtw8EFMvsyN+MO2b41
         PJOA==
X-Gm-Message-State: ABy/qLYrs6SXwAY+chipHd1IRTvcCLP7L1erNaYwExna1WLBNkHyrN/1
        Wg1xr7BvS/he1PGJ+gamOEujI/9I2A2w2/MGUaI=
X-Google-Smtp-Source: APBJJlFQZZi4RBD7sSRP3CH9OMsVajRevarlT6gCxGV11wtdzKkHMAmUDGAIaGoJ2+cHAVtBTT5K7g==
X-Received: by 2002:a17:907:7743:b0:99b:f392:10b0 with SMTP id kx3-20020a170907774300b0099bf39210b0mr6514452ejc.37.1690797456264;
        Mon, 31 Jul 2023 02:57:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b009828e26e519sm5860678ejb.122.2023.07.31.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:57:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/8] ARM: dts: samsung: exynos4412-galaxy-s3: switch sound card to audio-routing
Date:   Mon, 31 Jul 2023 11:57:25 +0200
Message-Id: <20230731095730.204567-3-krzysztof.kozlowski@linaro.org>
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
 .../dts/samsung/exynos4412-galaxy-s3.dtsi     | 43 +++++++++----------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi
index 94122e9c6625..54e1a57ae886 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi
@@ -173,36 +173,35 @@ &s5c73m3 {
 };
 
 &sound {
-	samsung,audio-routing =
-		"HP", "HPOUT1L",
-		"HP", "HPOUT1R",
+	audio-routing = "HP", "HPOUT1L",
+			"HP", "HPOUT1R",
 
-		"SPK", "SPKOUTLN",
-		"SPK", "SPKOUTLP",
-		"SPK", "SPKOUTRN",
-		"SPK", "SPKOUTRP",
+			"SPK", "SPKOUTLN",
+			"SPK", "SPKOUTLP",
+			"SPK", "SPKOUTRN",
+			"SPK", "SPKOUTRP",
 
-		"RCV", "HPOUT2N",
-		"RCV", "HPOUT2P",
+			"RCV", "HPOUT2N",
+			"RCV", "HPOUT2P",
 
-		"HDMI", "LINEOUT1N",
-		"HDMI", "LINEOUT1P",
+			"HDMI", "LINEOUT1N",
+			"HDMI", "LINEOUT1P",
 
-		"LINE", "LINEOUT2N",
-		"LINE", "LINEOUT2P",
+			"LINE", "LINEOUT2N",
+			"LINE", "LINEOUT2P",
 
-		"IN1LP", "MICBIAS1",
-		"IN1LN", "MICBIAS1",
-		"Main Mic", "MICBIAS1",
+			"IN1LP", "MICBIAS1",
+			"IN1LN", "MICBIAS1",
+			"Main Mic", "MICBIAS1",
 
-		"IN1RP", "Sub Mic",
-		"IN1RN", "Sub Mic",
+			"IN1RP", "Sub Mic",
+			"IN1RN", "Sub Mic",
 
-		"IN2LP:VXRN", "MICBIAS2",
-		"Headset Mic", "MICBIAS2",
+			"IN2LP:VXRN", "MICBIAS2",
+			"Headset Mic", "MICBIAS2",
 
-		"IN2RN", "FM In",
-		"IN2RP:VXRP", "FM In";
+			"IN2RN", "FM In",
+			"IN2RP:VXRP", "FM In";
 };
 
 &submic_bias_reg {
-- 
2.34.1

