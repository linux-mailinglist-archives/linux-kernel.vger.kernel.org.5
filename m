Return-Path: <linux-kernel+bounces-168292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20438BB634
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891A62811DA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD783A10;
	Fri,  3 May 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YsZETJWm"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7461332A0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772250; cv=none; b=qmGjq6DQixf5iffgJVXjQGrKnISo6a9fvmN8rUFHcl+IX2iNLmYggRuaTUkzKXIkbjUugkWE4tZCihBZ14Njg4OEqAYM2J2RaVuq+ktlsgEyYqmTAnV3f4+w01qKGPJwAix9kBM/3D3ndYB+56OgSwV/UBwSBGjQUozg9gYQXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772250; c=relaxed/simple;
	bh=Z07k6LmvrCqJVYhqJqW7ZsjRIaRSeJkSq0Its1w6ixE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2THu8exQIAUofC0abhf95jnVK1bTJexC/OFoD6y4U1GKFrelEL2yUrVkBU8OnOmoEN7XowdmkNl7oQWV930A3hxhWFsZbbAvnLVn22PGJ3xmLMOd7PEdKL7l7IvvDE9MDkuUxaH1UJamR4zF7Ox0YUhbL0pJInn8H7QHmU28Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YsZETJWm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so1226655ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772248; x=1715377048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm5pMW+JcxQoAhIpk954JqF6buuPfxcd3q3C5XmFPm8=;
        b=YsZETJWmABhnVgXi/GijDgbwFXw4t7xU4i1Ib8zciuOx40Wdxeglc0dISitIZHOr0k
         O8iCn5dpqx4NLlZ7rb5J0imkHGCZ0iCArMKbLPFRPPXETZMchqLHIqfK9BVI3DrsFvaN
         IL45myX+XQZD2kQIoG5YFr/edl/oAozJ8aW4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772248; x=1715377048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm5pMW+JcxQoAhIpk954JqF6buuPfxcd3q3C5XmFPm8=;
        b=CiUZJ6XfZkb4EnOjqg1/904ZMUkDu1Yl9poi/NOMNn1fx8lKIosbfjVqRHFuP6vV3Y
         TK5uXmKqJ+c60AUzrGijTBnqglVSNVPhrJedeJXN7Mr4TUNeBkiw1gxDHzR+5HlhmoYA
         PfYeDAsq/C76J03xrPZ7n7sZiw9u9y580SW3kbcZtC7KWg6fcmdHrmLWkkdUQVWlvx2C
         1lZervBuJtenQZW4NgRRRPm6QgCrByxUv+OPlgbS9eoKEC+/KNtzuuO353kUS3wqwTdH
         TSgRf4ITMH5/8E7jgw/Bo40UAjWDYfuG8MMrRpB3zETSmF+/qhItwPANr8Na0cCbxnA8
         ACKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUhRh+zG5azmNRf1X9GjVYChu/SSFJzRsFPi58uG2F9sDFPpBJMH1cY6Ykng+JZrLQrN4uM43PJq9UPX5yJBeIYPhr24E/fZphiADw
X-Gm-Message-State: AOJu0YxsSjVbN9zu0yyw6E+QVGgYofjDbM31BBgSny+wbwkLAPtFEPxs
	n257td9vA26FQ8KFu7aYpBJziSm2MHWGR1AcfN8T53rj6cINdrgaLQRdNgmS1ww27HVjhneFB6+
	fqQ==
X-Google-Smtp-Source: AGHT+IFYxFgWOwV/QXfwpPyO6iPfA33qW7XGRgN/4aov9d0tBWLiBcNJ5IccHks/fAhE+4fNaDTPow==
X-Received: by 2002:a17:902:e54d:b0:1e6:7731:80 with SMTP id n13-20020a170902e54d00b001e677310080mr5258220plf.11.1714772248114;
        Fri, 03 May 2024 14:37:28 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:27 -0700 (PDT)
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
Subject: [RFT PATCH v2 27/48] drm/panel: simple: Add a comment about unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:08 -0700
Message-ID: <20240503143327.RFT.v2.27.I639183ac987e139092491a94e22d46a5d857580c@changeid>
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
drivers are using panel-simple due to the sheer number of panels it
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

 drivers/gpu/drm/panel/panel-simple.c | 33 +++++++++++++++++++---------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 42d902d2bbbe..f39122ffdead 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -716,26 +716,39 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	return err;
 }
 
-static void panel_simple_remove(struct device *dev)
+static void panel_simple_shutdown(struct device *dev)
 {
 	struct panel_simple *panel = dev_get_drvdata(dev);
 
-	drm_panel_remove(&panel->base);
+	/*
+	 * NOTE: the following two calls don't really belong here. It is the
+	 * responsibility of a correctly written DRM modeset driver to call
+	 * drm_atomic_helper_shutdown() at shutdown time and that should
+	 * cause the panel to be disabled / unprepared if needed. For now,
+	 * however, we'll keep these calls due to the sheer number of
+	 * different DRM modeset drivers used with panel-simple. The fact that
+	 * we're calling these and _also_ the drm_atomic_helper_shutdown()
+	 * will try to disable/unprepare means that we can get a warning about
+	 * trying to disable/unprepare an already disabled/unprepared panel,
+	 * but that's something we'll have to live with until we've confirmed
+	 * that all DRM modeset drivers are properly calling
+	 * drm_atomic_helper_shutdown().
+	 */
 	drm_panel_disable(&panel->base);
 	drm_panel_unprepare(&panel->base);
-
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_disable(dev);
-	if (panel->ddc)
-		put_device(&panel->ddc->dev);
 }
 
-static void panel_simple_shutdown(struct device *dev)
+static void panel_simple_remove(struct device *dev)
 {
 	struct panel_simple *panel = dev_get_drvdata(dev);
 
-	drm_panel_disable(&panel->base);
-	drm_panel_unprepare(&panel->base);
+	drm_panel_remove(&panel->base);
+	panel_simple_shutdown(dev);
+
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+	if (panel->ddc)
+		put_device(&panel->ddc->dev);
 }
 
 static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


