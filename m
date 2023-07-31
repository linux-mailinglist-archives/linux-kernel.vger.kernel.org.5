Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8792876929A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjGaJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGaJ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:58:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5E1999
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bed101b70so504505966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797457; x=1691402257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4xCUnvnajAMffo2tQXzXco0sqRw4y5MSAi7V6IpqSc=;
        b=ztFrXwmjIr3RyuCrEofPXVRRQ5k26Vo8kxVM8mq2xIsonEuDi9jI4txDcx15PjOrMq
         Xneo6ilBVxSAxME/g+XfeuoQctrRuIfpNASpyxNQhhjaQ+49xIZmvXH411JnaxlpxaXE
         5YP4cay3g2PNHUNC/dKgbtLm8334mjd6al/JpxV13vxYqA8amGHJTCj9vXA7t7BSc3NU
         ufUcKLlm1j6qjKz+GSO7x+SzkdBhWbF9FB7eJ2IvroOUFucI8AQCYhqvx82W0V/X1ndv
         C7LLgZCoVD8fiiOWhyVAr1nbsNUgwVXmOt/IATMd26RUgk3nRdY/o4OhuzJOxK80lu3W
         Ne8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797457; x=1691402257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4xCUnvnajAMffo2tQXzXco0sqRw4y5MSAi7V6IpqSc=;
        b=V7sxDzMHPHjiVOsBguOYHRYE1Y58oA0BhBWY7oizZIOJJO+f7eYCztcSznfGikVLeC
         vnRfjmqay7vvS2G6pzP4ePX47FHR2/Gsh5OIu8PWMhHKUXGKHtX9RtPUYg7OGYUW/oQ+
         Gz14YsX4Yc6x2qpLYsywT6PzHYuwO9HBibpm0M82RGfvbjEDxDlTTE+KBBkuvqxufp2Z
         HPXiRuuosojtbenIFttYEAAYTRUg27fzNNRAtFtasm1RO7VCfy50XpkAzlCzZDKfAEag
         62yeWhK0LgUrgcW0ShBKXviK3DJE7StPcbSoMJXtwOgxqQY9sq0nAiR7Kh23u8mNYF7X
         xGHg==
X-Gm-Message-State: ABy/qLb11db61dIZEjd7ezGWgY0ORPIAO9AxATJmQeUIYA10BznsZTnE
        lScK67qZCZKsMT+K4XqOuLf9+g==
X-Google-Smtp-Source: APBJJlFn3ZlVsvPPiPpm8oX/qFYOcB7wdnVWDdBaGtr/0cKHqgTzV15smjb3dX99cybUxZ0O8Fmz7g==
X-Received: by 2002:a17:906:518f:b0:99b:ed53:5bff with SMTP id y15-20020a170906518f00b0099bed535bffmr7183670ejk.10.1690797457393;
        Mon, 31 Jul 2023 02:57:37 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b009828e26e519sm5860678ejb.122.2023.07.31.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:57:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/8] ARM: dts: samsung: exynos4412-n710x: switch sound card to audio-routing
Date:   Mon, 31 Jul 2023 11:57:26 +0200
Message-Id: <20230731095730.204567-4-krzysztof.kozlowski@linaro.org>
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
 .../arm/boot/dts/samsung/exynos4412-n710x.dts | 39 +++++++++----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-n710x.dts b/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
index 9ae05b0d684c..0a151437fc73 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-n710x.dts
@@ -76,34 +76,33 @@ &s5c73m3 {
 };
 
 &sound {
-	samsung,audio-routing =
-		"HP", "HPOUT1L",
-		"HP", "HPOUT1R",
+	audio-routing = "HP", "HPOUT1L",
+			"HP", "HPOUT1R",
 
-		"SPK", "SPKOUTLN",
-		"SPK", "SPKOUTLP",
+			"SPK", "SPKOUTLN",
+			"SPK", "SPKOUTLP",
 
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
 
-		"IN1LP", "MICBIAS2",
-		"IN1LN", "MICBIAS2",
-		"Headset Mic", "MICBIAS2",
+			"IN1LP", "MICBIAS2",
+			"IN1LN", "MICBIAS2",
+			"Headset Mic", "MICBIAS2",
 
-		"IN1RP", "Sub Mic",
-		"IN1RN", "Sub Mic",
+			"IN1RP", "Sub Mic",
+			"IN1RN", "Sub Mic",
 
-		"IN2LP:VXRN", "Main Mic",
-		"IN2LN", "Main Mic",
+			"IN2LP:VXRN", "Main Mic",
+			"IN2LN", "Main Mic",
 
-		"IN2RN", "FM In",
-		"IN2RP:VXRP", "FM In";
+			"IN2RN", "FM In",
+			"IN2RP:VXRP", "FM In";
 };
 
 &submic_bias_reg {
-- 
2.34.1

