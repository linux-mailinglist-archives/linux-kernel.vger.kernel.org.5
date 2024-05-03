Return-Path: <linux-kernel+bounces-168305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F8E8BB643
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EE61C21866
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A71369AD;
	Fri,  3 May 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/CazDPa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66446136992
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772278; cv=none; b=sMotxhVOI57Dpib3mFehcSgClHdE2daiZ5yNTCjMAiXh/jl4JZKwLe+C+u+od1KWGVDCXry5OFgtIDuUPgBPjZKfqCoomJMjH1DPTsNjCSfbJx+5uFBUCfPvuho4bF+HCnkXfygvc6DkujHYoFNBZHjB6T7CycNMBNP+5klP1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772278; c=relaxed/simple;
	bh=24YRgd+bMU8QhFuBpmcHLr3V7mmVueRyG88apmBnS24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAcg5JYl9j6tg4ZQ0DeCCZWlHg6scBe+K142JUA5svoKC24QEkd6/OPIKaj62WYBocIcmKnXxSG68nIcEx2mm9EDJ8nPqraEuq/o2zfm+FL/91beXjaVeny7NWYqTiiNpLoSWG4jVv1mdkLA4zeyOX2I8TlP7iDOXnCmNx3gBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U/CazDPa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec5387aed9so1022795ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772277; x=1715377077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC/7w7cvbMIg1H0tLbovKCpsSruQDzBcns5w6WWFLNE=;
        b=U/CazDPaQqjv/OLLZUtlgtr5LeQiKcPrJi/Vrf19DgQkaLtx3GQqKUSyVpK/Sa6WXh
         jv+mVoi4Dw/KcdehTYvObj8EcyyjoWRFLmnZfjXy1MHbQAs6XtYwwayUbKzVZmGaMiSM
         1Z0gUpuGp77H4fzjSNB2LKtobrlzZn+ortDVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772277; x=1715377077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cC/7w7cvbMIg1H0tLbovKCpsSruQDzBcns5w6WWFLNE=;
        b=O7DBSLnI/ohLDexSZ23Bq0kvUEAtTxTqfXYeLZ4q3NyhFabiA1iyHiCyUhUVn08B8C
         axHmbA76R2cUhsjsfVqyrMfJhnERHZcIJlJ+jtSLp0YFNXjhhIW0PFQENourFv/swlJU
         09W434yfG7CzI5tHzaKLBFUgMOEUiHEfq1lzOR7xpYZ0cg95J/w54Mp1k1epZvh6r/EK
         YkZAz/g3MBcTlW3yt65+7bG/T5cNhBKxJbXPHUgNYLLzUpdwGMoT/cCzHhFl1XFof5Kc
         eTNFn7RoG/05KVkRWQVHc2CXeiiwqXsq5jwSNowfgtTsCCsNjE7DW6+qSPMR4j8h1IHd
         8TEA==
X-Forwarded-Encrypted: i=1; AJvYcCU2mSXiS9lj1Ggth0dejXgN2DiDxGamhODq8GlvLqAsjABUM31B9CEEIU7sKndI7jk0FdilFXBc2eZuQiMTg87h1lIpC3xSxEUQyTzD
X-Gm-Message-State: AOJu0YxSIg+cp7JQl03430fmRLEncZCGzUBQAhb/wmLe3gXv9pKvjHfR
	boT6CnLtQNVUXwrTWYRMGGg3pkJ/pKnPj5VF73xhNH/Vzvp+RPFhWlLZKYzjH+lPiOeAHx2ISAD
	EnA==
X-Google-Smtp-Source: AGHT+IG4SIdj15z6GG8hET0eYzMhdd/lRGVRHEH1MacWakPy0nnB+jvXlG5KXqoNJ3o0nqOGfLsZdA==
X-Received: by 2002:a17:902:ecc2:b0:1e8:c993:a13c with SMTP id a2-20020a170902ecc200b001e8c993a13cmr4897231plh.25.1714772276873;
        Fri, 03 May 2024 14:37:56 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:56 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 40/48] drm/panel: sharp-ls043t1le01: Stop tracking prepared
Date: Fri,  3 May 2024 14:33:21 -0700
Message-ID: <20240503143327.RFT.v2.40.I56849dbe7c906f0cff076dc5286fd05c7e3e9c18@changeid>
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

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 855e64444daa..c86337954ad7 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -26,8 +26,6 @@ struct sharp_nt_panel {
 
 	struct regulator *supply;
 	struct gpio_desc *reset_gpio;
-
-	bool prepared;
 };
 
 static inline struct sharp_nt_panel *to_sharp_nt_panel(struct drm_panel *panel)
@@ -99,9 +97,6 @@ static int sharp_nt_panel_unprepare(struct drm_panel *panel)
 	struct sharp_nt_panel *sharp_nt = to_sharp_nt_panel(panel);
 	int ret;
 
-	if (!sharp_nt->prepared)
-		return 0;
-
 	ret = sharp_nt_panel_off(sharp_nt);
 	if (ret < 0) {
 		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
@@ -112,8 +107,6 @@ static int sharp_nt_panel_unprepare(struct drm_panel *panel)
 	if (sharp_nt->reset_gpio)
 		gpiod_set_value(sharp_nt->reset_gpio, 0);
 
-	sharp_nt->prepared = false;
-
 	return 0;
 }
 
@@ -122,9 +115,6 @@ static int sharp_nt_panel_prepare(struct drm_panel *panel)
 	struct sharp_nt_panel *sharp_nt = to_sharp_nt_panel(panel);
 	int ret;
 
-	if (sharp_nt->prepared)
-		return 0;
-
 	ret = regulator_enable(sharp_nt->supply);
 	if (ret < 0)
 		return ret;
@@ -152,8 +142,6 @@ static int sharp_nt_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	sharp_nt->prepared = true;
-
 	return 0;
 
 poweroff:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


