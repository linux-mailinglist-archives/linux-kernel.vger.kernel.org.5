Return-Path: <linux-kernel+bounces-100659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707F7879B67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956F51C21EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381B13D302;
	Tue, 12 Mar 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSkoGLxp"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B213C9FA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268278; cv=none; b=ZqBMJUrx0A6Dwh6gG5V2AzBAQslJAZIUv+9qHD2XwauzbAA3qLygf0QVoQXwls7vV9VSDoAkeAbfYl+RvKVfyZ5emEDEAWXpbAqD9ph4ixB5d4Fdd0qMLCj4RhFqR17C9/L4gQCZoCdtATvf3AIsrw8DLTiV9lOjWmA0aTfcmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268278; c=relaxed/simple;
	bh=IG1/QuuCyZab6uaf343Xx63BOPiPFaEpFINhDj+OsmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6U/+MzYPE9y9AB3pehf07eAzfa6CBzJBHJkTNQYXEhEx0ny9iuf4eIZSwsgruCoJW8lOFLuWmQLDeRvnnlG/PNBIvwgLJvsQJaWotgP2yzRSHEuG5kBTXkBZVYCRKO0smfu/kI6NM68M2JXpbhVwSbcupvYf/Gmuu5RwkKALEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gSkoGLxp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513c1434283so239703e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710268275; x=1710873075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw2xDPlNe7SKmtRrwGLhAFX/roF84DFnyDd6BhT5KcM=;
        b=gSkoGLxpAEGz3fGmbuFi1gVehTVsdjtoD9QGICelXFUkn8urodH1qeT9LtOSih0z1X
         bJfA60wTOFMDKydmJbUCLtui2Y/vtCFh1qLRnXaJo4uNcOfv9prqFiYIAacIwUu6yZ7B
         R080hBkwvRFxCgU7m7rA5kKoWkpVMmCRX8cS5tXUQWy3B5l9VmBVV+LjXGvavZx+aAqL
         y5svQmhhXWGY4csJ6v0OdOcmKKMz5xDq3QavR/ll7PZMxXPWI+JRPMzOT4WBx2MjtdA4
         3cXTWDpZy9Hx/0BgOp146t2D3WhYT2juTe4VttldA0v1GKB3c0SRw8iYl8+uKVWNrw3t
         vDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268275; x=1710873075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw2xDPlNe7SKmtRrwGLhAFX/roF84DFnyDd6BhT5KcM=;
        b=v1biTjVh1ZOWBs1HdzqtM8SSHLRG3oxX8TnRGj1v9SlUHsaGBJDbVx8bY7vfGZoUWW
         X5X80ggAugP8n9+jATh+iCP1xjyNA98WJYA2KLhGMVuQB8P56CUsixE2LY7rL00CfCr5
         NnS9zhvSTIa09urL/oljpRz7yoQxYjChratn7ks6NltxT8R0feaEQO6cCRGig1HDY1vE
         kojk2Fp0g7+vnrZLnHe2r2EMN3GPoCV+tuORyqRFOBAooi6z7TvG1Yb5FbXN8JePUNCa
         +w02ewq0KZqpKhVEl7lcfQoYMrrXgnCY3xlCK2JdNftYlmZ58QKMW4VEKJWVYaPZUai4
         bfXA==
X-Forwarded-Encrypted: i=1; AJvYcCUZEmMqXbfXXS3Z4s0rjQEyUsuClRPAGNU5lHlHnHqV2bGhpv7oYgHC9bBd/ugxn0L/0Ghely1tSl4mGmqYCbZ1uIMdlqJObTZfBe35
X-Gm-Message-State: AOJu0Ywk8n26hz1Jr1ewzaNnx/piyhBWowM1H1McERdXGwkqIF3fVx3S
	niEZTQLzM3tGkOvZP7ezzdTrAyRSqSAG46HmefmxhC/vb2LFfG3+gWcGz3WdQwg=
X-Google-Smtp-Source: AGHT+IFZ0YIuOzhmA2zL+kySltHSERfmg5xOrosGsca8rbD/pqygXA44AhOEldxt0FddF7G/aQDwew==
X-Received: by 2002:a05:6512:46e:b0:513:c5b7:9ee3 with SMTP id x14-20020a056512046e00b00513c5b79ee3mr747592lfd.6.1710268275053;
        Tue, 12 Mar 2024 11:31:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b0051329001f53sm1661012lfe.54.2024.03.12.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:31:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: samsung: smdk4412: fix keypad no-autorepeat
Date: Tue, 12 Mar 2024 19:31:04 +0100
Message-Id: <20240312183105.715735-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183105.715735-1-krzysztof.kozlowski@linaro.org>
References: <20240312183105.715735-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the Samsung SoC keypad binding defined
linux,keypad-no-autorepeat property, Linux driver never implemented it
and always used linux,input-no-autorepeat.  Correct the DTS to use
property actually implemented.

This also fixes dtbs_check errors like:

  exynos4412-smdk4412.dtb: keypad@100a0000: 'key-A', 'key-B', 'key-C', 'key-D', 'key-E', 'linux,keypad-no-autorepeat' do not match any of the regexes: '^key-[0-9a-z]+$', 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: c9b92dd70107 ("ARM: dts: Add keypad entries to SMDK4412")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
index 715dfcba1417..e16df9e75fcb 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
@@ -69,7 +69,7 @@ cooling_map1: map1 {
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <8>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
-- 
2.34.1


