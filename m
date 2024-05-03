Return-Path: <linux-kernel+bounces-168303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991308BB641
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F251F219C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6B136673;
	Fri,  3 May 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4feMluk"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BAE135A69
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772275; cv=none; b=XUUQFP9HUYfNMvLfRrxvi+aU3UgDTB4rQ5FuV7EKteD1GNXGwPVtOeok//wbr5LA+zG0yI3JYupa89MSOqXY5DOXHs84BWlnCF10o1tOKJYhrfHhFD4Ug1sQRMq1QPZ97IQji9Bu/qfiKHfwimZNdtv32HUfsh/T8bpD4RjQZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772275; c=relaxed/simple;
	bh=rH2R2AgAIrcdVtcKMrwr+cwucTsYW77aotJ+kwwjhJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCIRyxAmHooLD751dZ0E7+jPvsCE9njIwEH8sKiZEoF/brQu1espf8tVgprwT3iEl8VvFDupDCwmrgRP/safB/hKHOL2mpslijmUsCoiQfUinNZHIOo0wSG8rn+2DOnmbgCwKcBusKc7UShfKFvHr7w/PxZGWzNcWdoYQNyGt8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c4feMluk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec5387aed9so1022435ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772273; x=1715377073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltVsqzMHcXWQrzEkIaopepMP6yzxK8+ru/cwzj6Xja4=;
        b=c4feMlukqgKAMtKstiJVZ9HCucjwDx/YUBZr0Fu39/bmvrkQgrtzbXbeUPow5Y2645
         9KU3x9bpkzaxBFd1OGoTxiiiN8/irzH3s4wlwnf5BAwux62inr2kn9aYB3dKZ8Jx3vAS
         p0FtxS1H8QJEwmMl/xf6r3c/u7EanApNCtavo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772273; x=1715377073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltVsqzMHcXWQrzEkIaopepMP6yzxK8+ru/cwzj6Xja4=;
        b=LGyvod/66DQ1wOhbOrgvC2VsXnb6E/ViANiVPT9Gdu0X62NEmQSCfQY7tTgLFR46E6
         sKy6b+gT8RwtSxFnWkfFg8CwEL8uqv1CbGaj2NLWQ7TG0zKG9a6S9ik1eM3GN1xDFh9E
         f3DpYAchngklcXgxvbYx6LOG8JkInEhYIQURjdG5aQJXuJ3j7AM8FROofWcrWyYgCUb1
         mw4hKcjW0a8NTPezkQahX/A7g5A0ixxmGCjCo8txp9YzeaZOQEy1yWS4GdpolFlB3Nk3
         jya1D0CnS8g82aazyanAGldXUsl8Lb+ETEW3HDybhlrmm8dh84UmeohsnCqV195vcyk8
         FOHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvF2eM5oQfTmnEFbWALJ7HMXlztT38Ee6JB5PJrDKqgVhdC7j2ThcVK17JW1zan+Q70uwHP+Kwto3lSVsEkvxxG50gIIiLTEY/W9AF
X-Gm-Message-State: AOJu0Yw1o+lQtEl399PU5yORsHnlBpOK8rBQ2Bx+c8B+GmBWTCYu5uTK
	JUlC9Lybz8AHllt3Ub7exJd/g92JL9zeoGjlP29VRgRpoZoDNwoQJHPGgyhA0A==
X-Google-Smtp-Source: AGHT+IGYZcCvztVAnqAetSOocHorxHkEiQPDfYYRF0RW3qXwcDIlheeCC9kdMyrxGDD9aFGgBa5DWQ==
X-Received: by 2002:a17:903:1111:b0:1e5:3684:617e with SMTP id n17-20020a170903111100b001e53684617emr4153719plh.52.1714772272986;
        Fri, 03 May 2024 14:37:52 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:52 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Thierry Reding <treding@nvidia.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 38/48] drm/panel: sharp-lq101r1sx01: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:33:19 -0700
Message-ID: <20240503143327.RFT.v2.38.Ifd6b12b8a4bca7d492e892ea7455e83f5c0ab5a8@changeid>
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

Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   | 39 -------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index 14851408a5e1..8f6c21b99522 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -24,9 +24,6 @@ struct sharp_panel {
 
 	struct regulator *supply;
 
-	bool prepared;
-	bool enabled;
-
 	const struct drm_display_mode *mode;
 };
 
@@ -85,26 +82,11 @@ static __maybe_unused int sharp_panel_read(struct sharp_panel *sharp,
 	return err;
 }
 
-static int sharp_panel_disable(struct drm_panel *panel)
-{
-	struct sharp_panel *sharp = to_sharp_panel(panel);
-
-	if (!sharp->enabled)
-		return 0;
-
-	sharp->enabled = false;
-
-	return 0;
-}
-
 static int sharp_panel_unprepare(struct drm_panel *panel)
 {
 	struct sharp_panel *sharp = to_sharp_panel(panel);
 	int err;
 
-	if (!sharp->prepared)
-		return 0;
-
 	sharp_wait_frames(sharp, 4);
 
 	err = mipi_dsi_dcs_set_display_off(sharp->link1);
@@ -119,8 +101,6 @@ static int sharp_panel_unprepare(struct drm_panel *panel)
 
 	regulator_disable(sharp->supply);
 
-	sharp->prepared = false;
-
 	return 0;
 }
 
@@ -164,9 +144,6 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 	u8 format = MIPI_DCS_PIXEL_FMT_24BIT;
 	int err;
 
-	if (sharp->prepared)
-		return 0;
-
 	err = regulator_enable(sharp->supply);
 	if (err < 0)
 		return err;
@@ -235,8 +212,6 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	sharp->prepared = true;
-
 	/* wait for 6 frames before continuing */
 	sharp_wait_frames(sharp, 6);
 
@@ -247,18 +222,6 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 	return err;
 }
 
-static int sharp_panel_enable(struct drm_panel *panel)
-{
-	struct sharp_panel *sharp = to_sharp_panel(panel);
-
-	if (sharp->enabled)
-		return 0;
-
-	sharp->enabled = true;
-
-	return 0;
-}
-
 static const struct drm_display_mode default_mode = {
 	.clock = 278000,
 	.hdisplay = 2560,
@@ -295,10 +258,8 @@ static int sharp_panel_get_modes(struct drm_panel *panel,
 }
 
 static const struct drm_panel_funcs sharp_panel_funcs = {
-	.disable = sharp_panel_disable,
 	.unprepare = sharp_panel_unprepare,
 	.prepare = sharp_panel_prepare,
-	.enable = sharp_panel_enable,
 	.get_modes = sharp_panel_get_modes,
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


