Return-Path: <linux-kernel+bounces-125859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF790892D27
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5E028290C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC142A93;
	Sat, 30 Mar 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPPRkmoY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E541C0DFD
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831118; cv=none; b=PzaBkq6jPalpO9UQXPSOI9FCZdyKyO7Cl4n/lDVVbkhw+aikCMPG+2oKXqAKt/YIeuJfPtjxY0v3q+/vJ7l/glQfvZiwWKwTV2xXdfuOmU5TOf0RS148TtIbmUiqxLEgduxhKlgOLiXe4p6uZIeEPoKzM9Rud35GddU1ow300GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831118; c=relaxed/simple;
	bh=bVYwQBXE4BH9+HD89OZrCRfr+JGwR2ptZxYmQM11vS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gB8X4YhxLX6BxkSWn1oBQ7tpT198TlLowZds3z29f36ddrGkXHjCZsKRfpRJWLfgVlnD1XFwQYKCoiDqkynmz92QFBaALB3MkDcbg6REIePwh0cN3q6DkIhixt53qChyO9EnS8ayao/BXxLtIyrEXBC3jdLq3pYTLXumda9Et70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nPPRkmoY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4154471fb81so18242035e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831115; x=1712435915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qiZfiYec9JvljDN1YM11DQZd3LvrJpGPdWmUgthRHDA=;
        b=nPPRkmoYVMI9b/Qjpnz7Skn++5/NjWmua/0RHR+tAeKIAf27wW95nqs+XGaiVb0E60
         19tkJ9km1/5wCWBpH+CnNpbHJrKbcUlONGBGT2s4j+ZzIjkpvVlPbnrOt5D4BVhDba1z
         uLGqWxx9ZnHDMDrdWO6Mj3Y+rr+AKp14N/p/GSUIZMCpHBmUV1NLnwk6DCkr4xe0+Fbk
         GMf2c92MuvVvtreqZ7fJjdtcuFmfGBooowkZhVKsK1lPzAY900K7HMAl/o/uc7X28LL+
         C1TO2f10jO3rgLBkR7eh2nfL3SMxbEeYI0VFsWwr+j+MoKng30PrdHV4HmnJdPanqyEr
         fPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831115; x=1712435915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiZfiYec9JvljDN1YM11DQZd3LvrJpGPdWmUgthRHDA=;
        b=P2bKE8ULw9k2Guq0eVLnKlO/AW4xrqwloeIIxdx2BYxuwgar1jPlZHpt6XWzWd7xWI
         4rfYiSx6l5U6OTeEZvf/80xPHo1Ip3ZfeepLN/OooEBu3EqLz/z+wlSDqLJhiqosqhEa
         z+SUgG2wd4y5i/mrhxFO3T+eNoO9HOOiutedM7GnSaGuHLDin2flOF4jFzHZPhc8lN+M
         JgAZ8XNyUrig+nLz/J2O91fid16zxog9rGVUXaNH/VKYsW2EkqZt3z5+C4K0x+AuKCk6
         7Kb1/pU30jeHIro1NpBMC+cH5YuP06uFPdFkB1uw7cpvy/Y2hEoJwbrCTLtzpVebygC1
         zVRw==
X-Forwarded-Encrypted: i=1; AJvYcCVJaZKziuOW00h1yL/eNLyjR3Y/I15OiNqoIPYKJvcsoqeBHnuLegD+jsjMQdihyiD35s1IbfOHnJFplTY69sAhgHP//bAfniv8Mo0l
X-Gm-Message-State: AOJu0Yy36kZGSXHFybqvkCI1xmKYQ8FS4aP35DgdCyYL9d2s++HluOir
	AHb+w4kpM+lSMzTG9M30E3etkp/v5LqPjBybIcCImnTTe+Bf8L9hctB2v7SFQbI=
X-Google-Smtp-Source: AGHT+IGAw24+hOas7D5hzaxRF5caQ5bx7P/vLD5i+/kvSP3UAzqxOqiL8pC5Mv/I75CHrhlERYGNkA==
X-Received: by 2002:a05:600c:4eca:b0:412:ea4c:dc4b with SMTP id g10-20020a05600c4eca00b00412ea4cdc4bmr4148579wmq.6.1711831115459;
        Sat, 30 Mar 2024 13:38:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b0041493e21844sm12663154wmq.27.2024.03.30.13.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:38:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] drm/sti: dvo: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:38:28 +0100
Message-Id: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/sti/sti_dvo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index fd1df4ce3852..00502889c7f4 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -581,7 +581,6 @@ MODULE_DEVICE_TABLE(of, dvo_of_match);
 struct platform_driver sti_dvo_driver = {
 	.driver = {
 		.name = "sti-dvo",
-		.owner = THIS_MODULE,
 		.of_match_table = dvo_of_match,
 	},
 	.probe = sti_dvo_probe,
-- 
2.34.1


