Return-Path: <linux-kernel+bounces-168289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B68BB630
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65EF2848AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6B1327FF;
	Fri,  3 May 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WwpHQ++f"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84113248D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772242; cv=none; b=tmuOlfw9cyidA1IcBzoX3qlWdvNDDjtGiRk+hnEqXchPp2K7CM9zohiCrGg/urZwG2ZGKYhSVZSP9dhWZQ3Shk/6e/ME87klCVp0LJeZfLSMvT4swAIRXw4AMT2arO/T5aerqIignhVFNIxRo3zFwlw1tka8N2vcTWr30UfKXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772242; c=relaxed/simple;
	bh=GX4HIAvO+VZX4N8pwlhT++o+kYYGJe0qQHHVtQMYJ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwXybGJ4HnLfzT5AjQiQQaxu0h8mW6uAOK7mgzXZaVN8XTJ62ff8cb/12uKsZ0+m0WYSvBcI9jgr+IyZ/zQdHNupMvaixIKQzUQLp5gSVVGTICLjdIl5a63QXFrEHQ0r2GZyCyaFBh7cIgxMvjCXoxF/1JUem9DOhzh92xxCrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WwpHQ++f; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e5c7d087e1so1048565ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772241; x=1715377041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4ZnBWaIKiuSZ6rYgD6PXXRcgsfalihno55gNzam3kQ=;
        b=WwpHQ++fSV1kqSAHqQ/5r6IqAwsvkk0Vep+T0JlwzDhVbDgeP9V/m2bmnpoK+kn48E
         fHesmArLB/2nrg/YRJ0JkDx91F1KwnrxPiILhel1QxZUVbLmbEJEa5XLahcC2kxLnsAT
         uGSXo6y6dtEHuznIK8F9Gnpog+/BnoKjABkKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772241; x=1715377041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4ZnBWaIKiuSZ6rYgD6PXXRcgsfalihno55gNzam3kQ=;
        b=rU68hPGk+3TCDHWklTuZB5diZ2RQlPjjBgts4lAEF6Dm04ZZw1xUKRObPPNEfcVifz
         LfmT+lUgPSv9ln3VPX/m5b5WqnCEPolNg1XmxeEq2b6l0e3sWqIlbSoEfhleczDWoVta
         q3Yeo83oSfNZeCavnu/QcTs8Mv0UlXOGCAdr/SbOH5DgQhodS/AtR5N3AjWFApTboca8
         zCjYWcIe0PnUyEcIQPKhP3lBIe5j5u+y11WKBPhzguDIUYuPIJzoZfHu1/sIVkI5ac8D
         L8yaF0Q/G5TriXQstspckBOURTFEbtyF15PnDp/9rwl/YHRyB3Vl3rgIZLMQFalI6kKd
         hATA==
X-Forwarded-Encrypted: i=1; AJvYcCVLmvZTYpPQdrD9lJcgGvevjprK+m1KpVQqGxCewKUKPvbhSHQTgm447qpi8LOlDptzgwTez5cET8O5c9ExsrfuuklE2Bsaxs+fKQ5c
X-Gm-Message-State: AOJu0YxwfUe0dmKlmL647Ua44IaeBnW2pEff/UkdI3ImmJ0ytGXdZoqc
	P1ugu4K4Xd6ehajgFZ3IuHGFpxzk7CpuOGwaHjogX+SL8qFjr1CXIRwsxLdwZA==
X-Google-Smtp-Source: AGHT+IFBu/Hjhl9CXDDNgZhms0TZtEM8WWT7JEQNvy6BxJ5HNCgPTDI2jWO6fbS+Td4nj2A1qpFYHw==
X-Received: by 2002:a17:902:6503:b0:1e0:a3dd:82df with SMTP id b3-20020a170902650300b001e0a3dd82dfmr4006853plk.38.1714772240760;
        Fri, 03 May 2024 14:37:20 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:19 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 24/48] drm/panel: samsung-atna33xc20: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:33:05 -0700
Message-ID: <20240503143327.RFT.v2.24.Ibb4f923363a27167c480a432e52884b117221974@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index a9f0d214a900..a322dd0a532f 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -25,8 +25,6 @@
 
 struct atana33xc20_panel {
 	struct drm_panel base;
-	bool prepared;
-	bool enabled;
 	bool el3_was_on;
 
 	bool no_hpd;
@@ -143,13 +141,8 @@ static int atana33xc20_disable(struct drm_panel *panel)
 {
 	struct atana33xc20_panel *p = to_atana33xc20(panel);
 
-	/* Disabling when already disabled is a no-op */
-	if (!p->enabled)
-		return 0;
-
 	gpiod_set_value_cansleep(p->el_on3_gpio, 0);
 	p->el_on3_off_time = ktime_get_boottime();
-	p->enabled = false;
 
 	/*
 	 * Keep track of the fact that EL_ON3 was on but we haven't power
@@ -173,10 +166,6 @@ static int atana33xc20_enable(struct drm_panel *panel)
 {
 	struct atana33xc20_panel *p = to_atana33xc20(panel);
 
-	/* Enabling when already enabled is a no-op */
-	if (p->enabled)
-		return 0;
-
 	/*
 	 * Once EL_ON3 drops we absolutely need a power cycle before the next
 	 * enable or the backlight will never come on again. The code ensures
@@ -195,20 +184,14 @@ static int atana33xc20_enable(struct drm_panel *panel)
 	atana33xc20_wait(p->powered_on_time, 400);
 
 	gpiod_set_value_cansleep(p->el_on3_gpio, 1);
-	p->enabled = true;
 
 	return 0;
 }
 
 static int atana33xc20_unprepare(struct drm_panel *panel)
 {
-	struct atana33xc20_panel *p = to_atana33xc20(panel);
 	int ret;
 
-	/* Unpreparing when already unprepared is a no-op */
-	if (!p->prepared)
-		return 0;
-
 	/*
 	 * Purposely do a put_sync, don't use autosuspend. The panel's tcon
 	 * seems to sometimes crash when you stop giving it data and this is
@@ -220,26 +203,19 @@ static int atana33xc20_unprepare(struct drm_panel *panel)
 	ret = pm_runtime_put_sync_suspend(panel->dev);
 	if (ret < 0)
 		return ret;
-	p->prepared = false;
 
 	return 0;
 }
 
 static int atana33xc20_prepare(struct drm_panel *panel)
 {
-	struct atana33xc20_panel *p = to_atana33xc20(panel);
 	int ret;
 
-	/* Preparing when already prepared is a no-op */
-	if (p->prepared)
-		return 0;
-
 	ret = pm_runtime_get_sync(panel->dev);
 	if (ret < 0) {
 		pm_runtime_put_autosuspend(panel->dev);
 		return ret;
 	}
-	p->prepared = true;
 
 	return 0;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


