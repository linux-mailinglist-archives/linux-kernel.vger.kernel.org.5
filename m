Return-Path: <linux-kernel+bounces-136657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91089D6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4DC1F20F80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC3131E38;
	Tue,  9 Apr 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BXu3f1XD"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805C130ADE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657652; cv=none; b=aziSqtoEJn0DmeCVnWfqHuvvd6LvTlLTrXQy256avLXzj8DYt9oTIawoQZdFPOGz/CvL/F9F2jaPUbOnxU+MxKGc4+o9JYaWuivXNK1r56bCIdMNVPM2Gvi1rX6G15N4u/EyYEtd4o8bk9pxNyZpWgNzSudXP/PnFKelGLCA2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657652; c=relaxed/simple;
	bh=OGw78hpGmJopJetuhUNzzTWlhmL6j3P+xSZHkHfTIPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giLkGSK24e27IPBjf8Ur2E1Jb7WMoGTbbUM5CeJx1xGnENpMiYbYsXX05W/cHhS3cRyQZDmyL7XOyhSbBc7Miz728anj95r06RU9slfmLJQBNdIcPRkR7GSir1apBsEsw9OVYhpUS7m7ep1xMFYT0qmBaKGV1UyKVsGs+bxhgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BXu3f1XD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso6265820e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712657647; x=1713262447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhS125P+ZQHHlpX+fCGmsJ3MAcYkFtKGP8FooRfGuHY=;
        b=BXu3f1XD0xwX4WIz/1dB/VEZ9j6cEx6iwtVDdWS77eYjwZsY25I16BuiXtD8xtLAI7
         lYB6I7knqNb1m67cNIknNOtOJvHQcpOrZUS1BITB8av+WsxhcklMbwDq7p9i3PJod155
         nIPzhJBXwfkVsrG9L1dECf8NRMM+aGBt29WOrQGtYjFxf6o4WR0D1au7Ct8Nt1Ga/AZz
         C/dBAG0Ox5gNWGlm5yf/RetxwZr4akPBPG7uUsSw+ENwHg6NhEVL5T95xhQL9p9kDJCq
         OWUqQulX+i8ndbpZsz4eDW76uGi3CFHRUkjf+NqhPkBKCiMnvf9XbOCT0B23+wOqvYZ8
         AIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657647; x=1713262447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhS125P+ZQHHlpX+fCGmsJ3MAcYkFtKGP8FooRfGuHY=;
        b=XihTkcikY1PBNOTzXa1IG6Q2YhiYbjRO1CRdhYDYOT0pdzOO7dNEB1vPmcoZHrVVOV
         FmiCY03olFc+0qHqwEpNbN6t7Qr2ACjkE5mt0aJ20kmmPJ0XO+7Fc41KVx3bbig09YE/
         Hrh1qLU1HomBuYEuyE2JaE2XSrlfWg4rrg9T2YvgHs05Qs1BNNDn+MLdaxoY45UiXM39
         9QONU9uoxYGhja9V+8x/pb8IBXs3iUVi/Saj7/Z/rB814SkoWCsfkXonMkPGj11Fioj0
         OlwWFt+n992ei3JCdDZt4bq1AE5BQU/JrInyiSidCxXtPRjvoeuLoz6pkf467zDVt+aB
         CNKw==
X-Forwarded-Encrypted: i=1; AJvYcCWVH/C2L7w7FZTyNemgL10/17GLWL8YA6jrCEIZQ8ntLwJCvPAJ5lWMvsJsIzIYFtiPz+IBa+uC1FgqeWXH/dkb24gcXGk+V5V/d7Cc
X-Gm-Message-State: AOJu0Ywan4wLjzOiSBtWeihX+y67MuYU7e6WBOkAWCgTRQ4PvkuVPbvd
	s91EFNQbXizLxVMiHWpIcciqtwTvrXDqIoa3g8SQai8sfXnKoadbMv7fL4NomNBlL3ZOf9IBQo1
	LjoM=
X-Google-Smtp-Source: AGHT+IFF17tHptZ9yy6IboRmSrKnC6vMAvTQkGkS1sBkZY8PuDxFonOZnqVYYrkMq5Oo47sHNuMP1w==
X-Received: by 2002:a2e:888f:0:b0:2d6:cd05:1890 with SMTP id k15-20020a2e888f000000b002d6cd051890mr8048170lji.0.1712657646820;
        Tue, 09 Apr 2024 03:14:06 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b00416b035c2d8sm1124149wmo.3.2024.04.09.03.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:14:06 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 12:13:38 +0200
Subject: [PATCH v2 17/18] arm64: dts: mediatek: add afe support for mt8365
 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v2-17-3043d483de0d@baylibre.com>
References: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
In-Reply-To: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=OGw78hpGmJopJetuhUNzzTWlhmL6j3P+xSZHkHfTIPw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFRTTEUNfu/l/RVmmFfvIfx7YUtVHj60bjRZ75BE3
 zH4QqnqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhUU0wAKCRArRkmdfjHURTusEA
 CtYibBPzDz7hlWPn5zSwhUIaHtQ40nqsNB9rX8kXiBuFjqyqRdaTX4wbJqkHHUGFeEEJR4qJpOPE4s
 s1FqxsB0qzQrHAyMk4ZL5Zbs7M7n+hNutLNMbnpckX7/CNf1knNSHZ+/HO0FyXueP0/j+fvp0DOGA2
 3KFSEW84DMto/lKOKx0d4axfVmzoAwVOXBjYM2hV3R4dVnQuSD6HhkzazzXFiGC6FUZq9pEyqdfqoj
 Wwy/zAD75w/a34+bPUxNBah8QclxBSI6/49cY4mROW/i60I0VaVqhwNNFUG34tetH2lCVcd9bPEgdp
 G0ZfQDDFaFxdmma+3rgRvL8eOY+6XaB/bsS83DCgUAaXQL8dvaGn7G4VwzU1NsFeMcEwPZJwUClZRl
 tqi6Gr4zpFdzLqpSYvfp+G3rKzC4e/Aa+8JnPnRCAmTWpGvvHBlRZKuHMTB0d3hJ4Dhw7rkQ3BFYEv
 uTAsJEtd6pHT1ZT4/ib+Yu26zW6fqmbQUJuAadg+77yDN0cn8zLzkefbEHPccxQ7xfuc9knTbAVqbX
 Vo2VfjkeOfce2+Z5kOh8cpVi0QGNKKJow+sy2J0CKGevUYP4J9PSZs05Njy0DiRECnXCNiYizvMc5h
 C9ZwmafDd+g+rjVce2iRRt/FLjXkkjRlYZcm8ti8E+bZaGuMrTs2t2MUmc+A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add audio front end support of MT8365 SoC.
Update the file header.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 46 +++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 24581f7410aa..0bb6f6388bb8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * (C) 2018 MediaTek Inc.
- * Copyright (C) 2022 BayLibre SAS
- * Fabien Parent <fparent@baylibre.com>
- * Bernhard Rosenkränzer <bero@baylibre.com>
+ * Copyright (C) 2024 BayLibre SAS
+ * Authors: Fabien Parent <fparent@baylibre.com>
+ *	    Bernhard Rosenkränzer <bero@baylibre.com>
+ *	    Alexandre Mergnat <amergnat@baylibre.com>
  */
+
 #include <dt-bindings/clock/mediatek,mt8365-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -813,6 +815,44 @@ apu: syscon@19020000 {
 			reg = <0 0x19020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		afe: audio-controller@11220000 {
+			compatible = "mediatek,mt8365-afe-pcm";
+			reg = <0 0x11220000 0 0x1000>;
+			#sound-dai-cells = <0>;
+			clocks = <&clk26m>,
+				 <&topckgen CLK_TOP_AUDIO_SEL>,
+				 <&topckgen CLK_TOP_AUD_I2S0_M>,
+				 <&topckgen CLK_TOP_AUD_I2S1_M>,
+				 <&topckgen CLK_TOP_AUD_I2S2_M>,
+				 <&topckgen CLK_TOP_AUD_I2S3_M>,
+				 <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
+				 <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
+				 <&topckgen CLK_TOP_AUD_1_SEL>,
+				 <&topckgen CLK_TOP_AUD_2_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S0_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S1_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S2_SEL>,
+				 <&topckgen CLK_TOP_APLL_I2S3_SEL>;
+			clock-names = "top_clk26m_clk",
+				      "top_audio_sel",
+				      "audio_i2s0_m",
+				      "audio_i2s1_m",
+				      "audio_i2s2_m",
+				      "audio_i2s3_m",
+				      "engen1",
+				      "engen2",
+				      "aud1",
+				      "aud2",
+				      "i2s0_m_sel",
+				      "i2s1_m_sel",
+				      "i2s2_m_sel",
+				      "i2s3_m_sel";
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_AUDIO>;
+			mediatek,topckgen = <&topckgen>;
+			status = "disabled";
+		};
 	};
 
 	timer {

-- 
2.25.1


