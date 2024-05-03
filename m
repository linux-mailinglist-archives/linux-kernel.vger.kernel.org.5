Return-Path: <linux-kernel+bounces-168290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B550F8BB631
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E702E1C23FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB0682492;
	Fri,  3 May 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bbrXolp/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886558AA5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772244; cv=none; b=CrLavkx8iQEP37iCR+wxq03JHtBj7kFyRhqisdcIaOkgOrpt52gPL4KAS8YgByq1T8OKk2wNJGMqG+dqE6Fig43+CIv8KqJXzdsEjGfrvKaQhlAijkq84RA3aPHOWr8ReY7J7XiSZQzA8OONQN7df4hB4ZgF6AB9GTJVMAw5aJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772244; c=relaxed/simple;
	bh=MwnlaM489yP+C9bmKLyltsY0MI3Q8BhgFJLPRXwGLlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKO3ENFPijMf25aXLcfU70VdPOn51pABDnQLM2+LvKgYm085YK/Ckud7u6UFoauNwMOSXO/OOK/FPqgCHma1E7mB1rUBnW5aYZ+h2jwHV6CB6RVfPCW323p/MvBPZ0vA5FLWYk0itA4CVkVOlHjakfTGZhSeGnDcJEhpyGFDqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bbrXolp/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e86d56b3bcso1254135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772242; x=1715377042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRQb/I07011T3t9lbY5bJjPOFJ2fx1sx6agjLTdJWzE=;
        b=bbrXolp/yxIrUNsBCWm4I6Wg6xzuPZg1N3aPSA+0xuCb5QK+ZVgNuWuAKivH6u+ran
         9kpxJ2VU+Qws15JWtK5eAM7zUvFMKQJSYTBMSBT17bcXcLTPRkW19ZWBAaE1PGivA+qq
         gKlLVlOWyOIYukJIt9eHUNMAeE/vG3OEnkG/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772242; x=1715377042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRQb/I07011T3t9lbY5bJjPOFJ2fx1sx6agjLTdJWzE=;
        b=nDrlx2fMwERzgU9tWz+GFI0Hrxq1hSgIeq3wOLLYIlGweD261nSB5mJvofKwY2e+Tb
         xpQc0+Pw/Zx5kiF0nD9HFR2PNjBipEKpuLj+MXiGD+37JNGyvwpLeL1wd1A5T7mzuyGV
         KW8bYJjOiGYbA4F0nwGkdQ5lp7M+j/+9GcTus1zOE0pjmvlepBHWlPBM4iH3kreu6FPN
         SibJdECPTHIJaS7GQpt1x9mP/ezhg/t2SLSHbtpPTUK+5yT5uvAJ5qAyPp8xYhTtTEXu
         7VwGBVKrdS69lo4eH/Op3Qt9C0U1vQyLSN0VxighjYCl9c4HNX264jvvQElwKsCSxKR6
         jORw==
X-Forwarded-Encrypted: i=1; AJvYcCUkH6ZJ9Y5lazdufe+hbS9Z963LlwK4LXGdhXavfW2beHRSRMpM8gRaW4exdxQBtTEm0AbHkiFOnCkgLLJIlc1Qd6ymQNcISDb80FXf
X-Gm-Message-State: AOJu0YzZMF1H2+jlHCTu+g3wutmT9SAn9iS0ivSaF5N+oLpAdBLzujmD
	8qIBkX9OmEBar+j9FAZLx6nCnEFzudAztAarbNNQVh4AGAFusXnzlCjsGt7gHw==
X-Google-Smtp-Source: AGHT+IF6CDvqfSrYxn7iKNnjnE2VAXasLzRdp4BnWV2DoDu3VKywSCP3Ny+zWphkbKiYpV8TR9pS2g==
X-Received: by 2002:a17:902:cec7:b0:1e2:817b:460a with SMTP id d7-20020a170902cec700b001e2817b460amr4432991plg.34.1714772242613;
        Fri, 03 May 2024 14:37:22 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:21 -0700 (PDT)
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
Subject: [RFT PATCH v2 25/48] drm/panel: samsung-atna33xc20: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:06 -0700
Message-ID: <20240503143327.RFT.v2.25.Iaeacccf98e6cb729b8fc3a782725769cd66812ad@changeid>
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

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

A grep through mainline for compatible strings used by this driver
indicates that it is used by Qualcomm boards. The Qualcomm driver
appears to be correctly calling drm_atomic_helper_shutdown() so we can
remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index a322dd0a532f..9a482a744b8c 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -327,21 +327,10 @@ static void atana33xc20_remove(struct dp_aux_ep_device *aux_ep)
 	struct atana33xc20_panel *panel = dev_get_drvdata(dev);
 
 	drm_panel_remove(&panel->base);
-	drm_panel_disable(&panel->base);
-	drm_panel_unprepare(&panel->base);
 
 	drm_edid_free(panel->drm_edid);
 }
 
-static void atana33xc20_shutdown(struct dp_aux_ep_device *aux_ep)
-{
-	struct device *dev = &aux_ep->dev;
-	struct atana33xc20_panel *panel = dev_get_drvdata(dev);
-
-	drm_panel_disable(&panel->base);
-	drm_panel_unprepare(&panel->base);
-}
-
 static const struct of_device_id atana33xc20_dt_match[] = {
 	{ .compatible = "samsung,atna33xc20", },
 	{ /* sentinal */ }
@@ -362,7 +351,6 @@ static struct dp_aux_ep_driver atana33xc20_driver = {
 	},
 	.probe = atana33xc20_probe,
 	.remove = atana33xc20_remove,
-	.shutdown = atana33xc20_shutdown,
 };
 
 static int __init atana33xc20_init(void)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


