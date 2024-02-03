Return-Path: <linux-kernel+bounces-51282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACBF8488AF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9F51F22B00
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB85FDD8;
	Sat,  3 Feb 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQNi9+su"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988C5FDC2
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706991623; cv=none; b=U1z1aV/71y9ruXCjm6p5F/KgmQtg92Z2w0LNij1oKys3NdWK7zCRu9d5Zov5UWvW29axAvN7kLwsDeN4ZT2VZuMh0rQED/o3FWo7xz7FubkSmm4VN8fsVL+f3i4a1msf8wor/U4o3R4gEof/6HyJJ89xBBTCdtflXcsZspsGpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706991623; c=relaxed/simple;
	bh=0AAo12kDZgadNPUf8ah1lPSKiCNnZfWTor+R9Sby9as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ay51NDqonK8yy+gY5oaK8s45vxfXjeDqshUEtK362Ge9qOlhmloa+8WDmqEQHMWEjl0Kuz1UsyE29RiKnS+yuR1ye8GXBupbS8kFa+aGgcYHMhKyNoRSrqqIJbx5X79Be4SIlcPkMx4OcZjycg+eZhPaemt/fNhjZUkKYjtBfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VQNi9+su; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fd280421aso4232915e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706991620; x=1707596420; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pewoWUcsLIHtlOoMZy6asN2BD4xRrWRp9TUT7zeRtI=;
        b=VQNi9+su90vsigU4BOE2KBNObETc0esSrctDH2KEw/ai3mZJgFbc7pp4tqsbPsGP0+
         1GRkwIFFLD9Q+Takvjb7msR92smTGHXdS4VYpzoh4PdAjrosqQs6XMw8p/inblsuoZyI
         sANn895VDuqOK6j4sNh/4/q/qSl7+1ox4s8ForYX6SnElFX0yexytqEY+/unQzYh3qPP
         AwjUiJlUVoBWlJTV6NxT0mc3GsPPBjr/m7wYFGh4PpE37YICQjTF6iUYaDj3CKbwuMPP
         HqSTSiv1sYINmsr8fbeqgtMDFR4qca63IWIEbghPIgtM7PcouivRjPWJmqhGjZOxK2jo
         /eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706991620; x=1707596420;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pewoWUcsLIHtlOoMZy6asN2BD4xRrWRp9TUT7zeRtI=;
        b=hbAGJxTiy1TAxfASrZqcxG6If+wRwFnElNiids3BW1OmjtJl42AjokradY/fgL2t3y
         dI188VmgT5/LmleaaP2832k38vxjg4mIZT7TDxj6mSQ5RyID+BrR5TWUGrc6JTy67AS0
         jCQeBR5JWiFXRp1k09MQ43GdvxdMKhN4UgvoXr0lsZMdQt1YgYtBHnkxmp7zCUJlRaFp
         gGX1FyzPPLrGTaOGPlLlDu6ZPRpFvywZi2evt1sitp44PhQRFV4XpCVnIPTNJvCaLsGK
         8xdm+Jdqkf0/bJLQasMppTSncAPa4izUsbd4gLDfoUVd1qUsXrmrLVRpRAKtLyphYZCU
         5VWQ==
X-Gm-Message-State: AOJu0Yw1hEQYM/ab1TjrczqRSUYpAlZB3GbjybznQjaLkeKCP0FufOYZ
	r7uaAhcmdbkO/78Dc9DjC+O8wbDipInRnt2qMPthwxXs7H73c0hxOM5oPj4JT4g=
X-Google-Smtp-Source: AGHT+IHAdc49mfAlWi2pAvdjJSsS72fBmc7yBRfo2xmR70Idt17xiRuLMy1wmVmZyQrB4bWyO8URhw==
X-Received: by 2002:a05:600c:4747:b0:40f:d0f1:23e4 with SMTP id w7-20020a05600c474700b0040fd0f123e4mr1599483wmo.41.1706991619569;
        Sat, 03 Feb 2024 12:20:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXq7YCWkgrvYwQ9+5B5D0Cy97DUywt/wTzr7rJhGXQmr6p5mp+6q4VHxiaNc9fK/iZV7JWifJLVMXizT8garrGQ25oDkJI0odqr7wBAltP2VA0XJsMhXniASn2Kzhf71VNT6JTrp6GASlyHXYZJiGbo9mLD3W6cqPMXORVSVLoh8qTkYaAjbku2be/wjrH4Xfvv3qm9mRO3jpgKxhsNO5RJ
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm3820652wms.41.2024.02.03.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 12:20:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Sat, 03 Feb 2024 21:20:17 +0100
Subject: [PATCH] arm64: deconfig: enable Goodix Berlin SPI touchscreen
 driver as module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-topic-sm8x50-upstream-goodix-spi-defconfig-v1-1-b69ed85ddd05@linaro.org>
X-B4-Tracking: v=1; b=H4sIAACgvmUC/x3NMQ6DMAxA0asgz7UUQkGlV6k6QOKkHoijmKJIi
 Ls36viW/09QKkwKz+6EQgcrS2robx24z5IiIftmsMbejTUD7pLZoW6POhr8Zt0LLRtGEc8VNTN
 6Ck5S4IjjOs1uoDlMfYAWzIUC1//s9b6uH+hijNl8AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0AAo12kDZgadNPUf8ah1lPSKiCNnZfWTor+R9Sby9as=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlvqACH1ji8o0FHwADXMV1X+EJKK266FgqNFd8KIqT
 JuYGpSiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZb6gAgAKCRB33NvayMhJ0f/eD/
 4ru7aLNUj7w+yJfhRjW/zKyH9ja76gcPF5jk1rLaWszk2PjzcxFk8mbUkvTYzipqMZqWen2+TjaE6F
 odnsPsVhvH9/vt1AodTD6rhmbYnVB15LgXre7GGZ8aArbbMfEHtDwYek1pMMzIVAA42K7w3G2nRMkk
 jUTU+Y6oSbPPAxNvjbEzG5ZbeN2e/+Bbnc1fQKtpNmkXbm1Z/BBSI77OLT+XuCqRKz6MWqZuD/tRie
 PSSbHDiUeaDZmMovR4z26gzXqbKrcrnZUq0x0weT/MREksgmyt9nDBL53tXQyx0G5X+9UMd/bWQ/Nd
 BU9xcaMVHpTzLS7N4L6ADPf6BzWAF5rr0DLGdpsbjJqrXBSSUmjOdWGtFbs0zriNnifgcweuE95Gmo
 Ihhbba+h7bfmM2JOh++AotA+jqNfNYXXaq58mRPpLVAIW8g3PkobLc5ymw/WItnfNe37wuC8zfC5fB
 lD+me/axDDotXRCvPBG0i2L5oAs7vK7xm+WZMAeneSNi2wZTpCfl50H1jL95AahUFXY8noC8a2eAwJ
 xBOlTC9Hf8aqGBT0EU1TYwy37AHpzRNLhrIXm6nsF98ZzkN2kZNAJkeM/vjmcvxC6G4E8TkZnxqV/V
 uu0cKlnZ1hYpkBHdiL307xUyS7Pzn7XVt7omtw6Glwp8HGyWA/Z6ob/Uzd9Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

enable Goodix Berlin SPI driver as module since used on the
Qualcomm SM8550 QRD and SM8650 QRD platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2064e7bc529e..ea000c333e50 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -432,6 +432,7 @@ CONFIG_MOUSE_ELAN_I2C=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_GOODIX=m
+CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI=m
 CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y

---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20240203-topic-sm8x50-upstream-goodix-spi-defconfig-5b69c3e9f61f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


