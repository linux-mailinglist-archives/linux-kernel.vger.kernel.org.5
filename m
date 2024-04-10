Return-Path: <linux-kernel+bounces-138159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9689ED78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F911C20E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C0113D535;
	Wed, 10 Apr 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gs1OrPbO"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A413D523
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737349; cv=none; b=T7wVF5lKGmHyI2yCrzbXXyi8qbQQABAIlVXWWDeD4aPTrBOCslI9244J43qojZmGx5R+Xaveu9l1WG0DUKS9E+cQ4JWNV+NRfF9yt05WjyvimUjkKyeP8+EfcpZJQ6GzXOntc7khG8Wa1voj08OMmrnGVxtGXsldxyRrrzqMMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737349; c=relaxed/simple;
	bh=8AIv34knIGS8Wt8UqUeprfZr1emVeDOGFwxiBOkiJoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZvZUbZmK9RbdZkjofoDvEB6ZMjCoO/PFJtkph4G4ylcwPTsnStNX6ilRhJefXFz99mr4DVZNi2KeEbdXArYTb9MRJ8ON3RqOJf6OcxxrMzQOOC+vwASv0Iw83nEeV+FekkGI3Hfo8973pkHGDarTptQLeFhyeimxTIbFXYDYC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gs1OrPbO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so7363296a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712737345; x=1713342145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kww4yyZZsepXA1zvLsc6VOyWxL+8PLx2SuiK5eoL4A0=;
        b=gs1OrPbOPeF+fC93Cd0KYy7TC5NPRqrEA/v10y1iCdl0/waDC7xwCx/ggyA70Gi5LV
         AJw93o13+4Aps1mx1CEGlmUhcnoMulMDdALm9iCPOsQVWn1GEYzEz9LFM5CKCRZlXbOn
         QfgKXUSZBHHSlKaospeA6BRAyqX6xYSMYmp3RyDTWzUknimIHmkAKt85C8RE9JRg20Jb
         D30XOxSZJDG7aGg3DcVXSzWU0umaGIbXqCBArRjHe4PvPXVwYvp0oVy3yQlWV0JtaRMv
         7FDO+aliuz65aihq/UlfHjCCLtX6d7mFICIXEzNaAwBbBkJDBXyy7cxN5DuufsTZGa1z
         pXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737345; x=1713342145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kww4yyZZsepXA1zvLsc6VOyWxL+8PLx2SuiK5eoL4A0=;
        b=dXjC+Dj8N14tXZc4p89bYG+Ok51uPRbjpWtXFKC4y3mdTz386+lEDMxT3LZuTWEmuE
         hx6zPJ6I+6qO7nWFmgkKcRJNCRI3P2r6gTGx+hU5zBbGp73zsmQ2LSv3sGqUUcrPNBar
         J3q7Jw7fc4nPJkvdtgmL3aceKb7WCDXGwu2Gei7HmQrmhbx0poGPsYsK9V5+3hBmiwEg
         kMKy4lv//OWAVk8ydWitVDz+cTTPmTVwEsYUN3KMYiGY0/OjLg6Atl/Y+oB2K1xgxc/9
         +Jn+ds36S/wZ8ifTMdNo2eBRGdcQWQ73m1R1K6R732rbPW2BRLO53VrNXrGPfWr/20pQ
         9Qjw==
X-Forwarded-Encrypted: i=1; AJvYcCUpP/v4oo4H/T3wVzSDjof+f+rs8olU2c0gHLi8309AwVsTCO2hjBqdHsO7FoFphYA7R567LLwvnT7V12hUzjP6I3SI0vSpwPAY5f7e
X-Gm-Message-State: AOJu0YxuuJrm1cyoFdrVK38ucq3vkK7SfScIxMKi3+YOzj8sfl6Saidj
	lkC8Qj2KttCittbhzVZbVIhZ4YdUtt3k6bNL0P4mV6ErS4MTVw3c76xz5vbJJIA=
X-Google-Smtp-Source: AGHT+IEtecmPwxZNGIHCQ26Q+9Nf031V8etRRaG96Ui//oFqXfGHVqbraygxywND8sq/gwzeCowbpw==
X-Received: by 2002:a17:906:4888:b0:a51:9938:f77c with SMTP id v8-20020a170906488800b00a519938f77cmr968170ejq.52.1712737345532;
        Wed, 10 Apr 2024 01:22:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id hx12-20020a170906846c00b00a51a9eccf2asm6338213ejc.125.2024.04.10.01.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:22:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Russell King <linux@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RESEND] drm/armada: drop unneeded MODULE_ALIAS
Date: Wed, 10 Apr 2024 10:22:18 +0200
Message-Id: <20240410082218.46525-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resent third time
https://lore.kernel.org/all/20220407202443.23000-1-krzysztof.kozlowski@linaro.org/

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/armada/armada_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index e51ecc4f7ef4..f48e2cf8de43 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -283,4 +283,3 @@ module_exit(armada_drm_exit);
 MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
 MODULE_DESCRIPTION("Armada DRM Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:armada-drm");
-- 
2.34.1


