Return-Path: <linux-kernel+bounces-168270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E48BB619
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB58B24877
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862985C56;
	Fri,  3 May 2024 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKU5PhFc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB75A110
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772204; cv=none; b=OQ61xYLbDsP/ymGkcSuEpK6uEyq9kad4+sLH/omDgspHClxgK07czdSKBAswyIVRSUazHOE5GND0DM6k74V+jsyOFebnRCtb/ZoeeKY9O57zPnMmXssXk+d8Gtf3yFOwM9FU2KaOoYk7c/z1iNPxJe9msTuijpNUULdb3Z04ipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772204; c=relaxed/simple;
	bh=nkEzB5xaPVoz6iOurmdL7HHNVRp9WgHsJcfOVLySFA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGZlhYiWdhtmiql6lOibM29dQfzFabhDGksTYggbpGwKobnAvnJ9BRb5TPfBywzmhX+wE1X6u4vE7c9U3WLurg5bgkGRsZ3ajHEkFp+3km9t/5moeMSpKJYWURGrowsTSCF8fNoLcdJRCOYzNDMcxYCnmLBsGG4xfSah86+3+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LKU5PhFc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3f17c6491so780235ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772202; x=1715377002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/gDi06ypcwTUid62LmhVpKtIZZa53PC46cbq17u59E=;
        b=LKU5PhFcgeyWWI9MK6J8NXiH9uW6ufi8zFcFup1fFMTibgMif+NLTnok9LuGm7OyTq
         ZoGDGseUNc4KksINBqRgLR+ceT+mtxIKUvcPqHB34eeWjJ8aYtwfywlI9OyM4Gyck0sl
         DHXwNMm8H/CajnlKwDbT+bUOAmRuk9pdJTE/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772202; x=1715377002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/gDi06ypcwTUid62LmhVpKtIZZa53PC46cbq17u59E=;
        b=i1s44chKL0irky9+rBg3r98BU5+swaPMmO0KrzhRnz5wbi9Wxso8H/Ifwyf/MjSvpF
         uYgBDD2Gu+8mASS+hTQJNToSzspQFTG+YRbvPWyrrkAJWWyv48v2rqyeoNqzQ0utWvxO
         E2RP4OVB9P0AX2KYCgm3gls4I9fZB2aRK3yv3mbJ4OqGPkAE+mBzmvpBEyjmXTpNxWFG
         sIs6xpfJo8mhAXYcVq/EekiYmYtj5u6gbXC+2ThDjh3FJmMHSOHWEkx5drNiOdc5HRMs
         hMs2lUyClItZGNY9WPgKp3I+BD97BGCqkIuwKGrxs4vy4qEJz2b9CxVyERREjA2mBbdW
         iwww==
X-Forwarded-Encrypted: i=1; AJvYcCWO4ASz46FlS6OCqFU3gTFusxxIFA7ZLNSm7o3An1uoWnrQokwugiiXEPhIsISLkUxhAQsv0ei9zHKUESEPvE1QmUL9NVXC85HX+UwG
X-Gm-Message-State: AOJu0YzBmUARzkIj2oNRySUojrSvB2X5ko5Kl7Sz3/ysvc10s90y490i
	fbUjNiKjMDgLgVmcGQqd/KQYLDGPaOcjfUfv1VBDWnaTi54W+2FQMiqno0r2SA==
X-Google-Smtp-Source: AGHT+IHVkT5EJTIYXQXBX5EIce/1Ex+Br0DGJO9Vob3PlE0kbtZ2ROcTXrJAG7DEeHfLLcWqrz5ILQ==
X-Received: by 2002:a17:902:ce8a:b0:1e4:9ad5:a666 with SMTP id f10-20020a170902ce8a00b001e49ad5a666mr4922430plg.25.1714772202526;
        Fri, 03 May 2024 14:36:42 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:40 -0700 (PDT)
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
Subject: [RFT PATCH v2 07/48] drm/panel: edp: Add a comment about unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:48 -0700
Message-ID: <20240503143327.RFT.v2.7.Icff7f7005d997773d585e36aba9ed41a9865201f@changeid>
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

Unfortunately, it's very difficult to know exactly which DRM modeset
drivers are using panel-edp due to the sheer number of panels it
handles. For now, we'll leave the calls and just add a comment to keep
people from copying this code.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.
- panel-edp and panel-simple just get a comment now.

 drivers/gpu/drm/panel/panel-edp.c | 33 +++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 344f67871d41..9c4c5c0e39a3 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -944,13 +944,34 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 	return err;
 }
 
-static void panel_edp_remove(struct device *dev)
+static void panel_edp_shutdown(struct device *dev)
 {
 	struct panel_edp *panel = dev_get_drvdata(dev);
 
-	drm_panel_remove(&panel->base);
+	/*
+	 * NOTE: the following two calls don't really belong here. It is the
+	 * responsibility of a correctly written DRM modeset driver to call
+	 * drm_atomic_helper_shutdown() at shutdown time and that should
+	 * cause the panel to be disabled / unprepared if needed. For now,
+	 * however, we'll keep these calls due to the sheer number of
+	 * different DRM modeset drivers used with panel-edp. The fact that
+	 * we're calling these and _also_ the drm_atomic_helper_shutdown()
+	 * will try to disable/unprepare means that we can get a warning about
+	 * trying to disable/unprepare an already disabled/unprepared panel,
+	 * but that's something we'll have to live with until we've confirmed
+	 * that all DRM modeset drivers are properly calling
+	 * drm_atomic_helper_shutdown().
+	 */
 	drm_panel_disable(&panel->base);
 	drm_panel_unprepare(&panel->base);
+}
+
+static void panel_edp_remove(struct device *dev)
+{
+	struct panel_edp *panel = dev_get_drvdata(dev);
+
+	drm_panel_remove(&panel->base);
+	panel_edp_shutdown(dev);
 
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
@@ -961,14 +982,6 @@ static void panel_edp_remove(struct device *dev)
 	panel->drm_edid = NULL;
 }
 
-static void panel_edp_shutdown(struct device *dev)
-{
-	struct panel_edp *panel = dev_get_drvdata(dev);
-
-	drm_panel_disable(&panel->base);
-	drm_panel_unprepare(&panel->base);
-}
-
 static const struct display_timing auo_b101ean01_timing = {
 	.pixelclock = { 65300000, 72500000, 75000000 },
 	.hactive = { 1280, 1280, 1280 },
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


