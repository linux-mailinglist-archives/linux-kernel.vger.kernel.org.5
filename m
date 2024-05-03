Return-Path: <linux-kernel+bounces-168291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC358BB632
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734101C208FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA058AA5;
	Fri,  3 May 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8TirT8k"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B37132C1B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772247; cv=none; b=Usjc8JLTTO5TL8U1mjh1z5XzqyffN9lSXJ+wa5ySMs+0ZViC4g/QTG+BiXE0Z+ZtYwcNxHt1fc4WDoZlCj97WmVZv5hTi830Lz+DQ+V09rSxOZqsyoQFkjdhpIb/FAoaU7ZD42VzREf+ZM4EhFJiHB8P9a1PeBriu3dOr0UM2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772247; c=relaxed/simple;
	bh=05gtrOeEcREq4hvpJoIjfeQYqWEadvX+bGZawKnk+qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGEfbmlilgZJPdijVwr359qmMMYDHjPQbe7k8etX6Ef9SSP0h4rjIaBMu2K7auZUbSuRAwmxnEApGjuBugHzhCN3U/L+Ycro5fH+MzfHNyNt0tkiF3iNegFnt4Ji8ZskF8D/vy7eWDekQd1zsJzE6TxpcbeMCZ1/SbUNydiCr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W8TirT8k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eab16c8d83so859245ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772246; x=1715377046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2B/kTWdyUau2alXgEoUxYv1c4k3su/yovwNR5wduBo=;
        b=W8TirT8kTmbRwEVOcn5doiFArZL3pXEnpSmXjOWgYJ+j01hdcV0av1VE0SyUVybUaB
         oSi8SLzyPTKEXcUnlImExNBvkBjeS8mjyNisB1qM9SuJ0YAt9e4Vwx1CVC3HiRvBV31W
         Tf4smy1Bz0Mox1BU2cg9w3RIiM7ph95dNbZkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772246; x=1715377046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2B/kTWdyUau2alXgEoUxYv1c4k3su/yovwNR5wduBo=;
        b=NJ/tI8zilEYX2yaHqwDCKyZrdeosw1qjfDRR1O83FlPsO+r2G5aspJ0ZkIVPOMj5RZ
         gMgTR7kRJ5CIL39b0wzkfMxRVI/bc7w7oKMvUdkd12mmXdEzxcIJIZUcGJXTlUiC1CoP
         ND/OgRO8bR+/OOxsCchi94Fcn4kRgmXxT4XNS6f+/Xmy7WecfplDA9af18VNmurcrTEn
         WJfeVrAX4QJLoV5D1lx3dykNQJ1yXUIO4gMvRU+II7cSM6RlJunfZalKMxUQjQkmVUdV
         uvT6iqwi/cv1bqeEiw1DeRm0c3SDoYVhIXW30hXajoutiaHmRy2bvltf0I7J626/Y1Tc
         ACug==
X-Forwarded-Encrypted: i=1; AJvYcCUbpuSP3qhoiYtsAq/tDIZYi/Lfdh/nWMBXE+nGWicFNTMDFRvK+GrQVmt3HC3TLx+WHi2hEtV966d+VEPd0pNfWoN/8c3Br4OB4Rlr
X-Gm-Message-State: AOJu0YwkwHC0skkJxD3z7N5nUGfPQQ1sGtqqq8Wq86PZDnGZRCsHoYoy
	+CumYXN8YdLYwZt5ZIYsQRcpsg7GgC7VLQLVxE518vhNSIf8OwgeB0eFB27VVg==
X-Google-Smtp-Source: AGHT+IHeLoFfHMC/OUeeJoDhqoJSJfOwPhDJNHriFCGoke4s3Yn0fXRdNzl+m82UbjoOonNJKwQK5Q==
X-Received: by 2002:a17:902:d386:b0:1eb:519e:e05f with SMTP id e6-20020a170902d38600b001eb519ee05fmr3748669pld.45.1714772245858;
        Fri, 03 May 2024 14:37:25 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:24 -0700 (PDT)
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
Subject: [RFT PATCH v2 26/48] drm/panel: simple: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:33:07 -0700
Message-ID: <20240503143327.RFT.v2.26.I865be97dd393d6ae3c3a3cd1358c95fdbca0fe83@changeid>
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

 drivers/gpu/drm/panel/panel-simple.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dcb6d0b6ced0..42d902d2bbbe 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -138,9 +138,6 @@ struct panel_desc {
 
 struct panel_simple {
 	struct drm_panel base;
-	bool enabled;
-
-	bool prepared;
 
 	ktime_t unprepared_time;
 
@@ -290,14 +287,9 @@ static int panel_simple_disable(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
 
-	if (!p->enabled)
-		return 0;
-
 	if (p->desc->delay.disable)
 		msleep(p->desc->delay.disable);
 
-	p->enabled = false;
-
 	return 0;
 }
 
@@ -317,18 +309,12 @@ static int panel_simple_suspend(struct device *dev)
 
 static int panel_simple_unprepare(struct drm_panel *panel)
 {
-	struct panel_simple *p = to_panel_simple(panel);
 	int ret;
 
-	/* Unpreparing when already unprepared is a no-op */
-	if (!p->prepared)
-		return 0;
-
 	pm_runtime_mark_last_busy(panel->dev);
 	ret = pm_runtime_put_autosuspend(panel->dev);
 	if (ret < 0)
 		return ret;
-	p->prepared = false;
 
 	return 0;
 }
@@ -356,21 +342,14 @@ static int panel_simple_resume(struct device *dev)
 
 static int panel_simple_prepare(struct drm_panel *panel)
 {
-	struct panel_simple *p = to_panel_simple(panel);
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
-
 	return 0;
 }
 
@@ -378,14 +357,9 @@ static int panel_simple_enable(struct drm_panel *panel)
 {
 	struct panel_simple *p = to_panel_simple(panel);
 
-	if (p->enabled)
-		return 0;
-
 	if (p->desc->delay.enable)
 		msleep(p->desc->delay.enable);
 
-	p->enabled = true;
-
 	return 0;
 }
 
@@ -609,7 +583,6 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	if (!panel)
 		return -ENOMEM;
 
-	panel->enabled = false;
 	panel->desc = desc;
 
 	panel->supply = devm_regulator_get(dev, "power");
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


