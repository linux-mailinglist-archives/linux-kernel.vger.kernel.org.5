Return-Path: <linux-kernel+bounces-168309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF68BB64B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8E31F21C05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B413775D;
	Fri,  3 May 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mo1fiC6o"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC38564D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772289; cv=none; b=gdhh6+TapsN4fXhxyyrtN4cKjM9lSeDTa/kNkrD2XWKhhocXlXMlEK6p23tNkMR9+q4wmUMz/QIS+y+yLM2Cst97K3hHgCLaek+ksDrc+9vtDW6FomuL4/yBN9BdfA43a3iM+nbdXJXkZC3khgbM/STie/8ywOsmSvyffYYRI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772289; c=relaxed/simple;
	bh=AqXmeERjnXg7zaGdjwwFP08nCPLkPR3oger7zvpxqFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqnUenIk4vjo1Xy9LGTwpXqqaNMmkxP4cHJVUIFAloqeJxbpmXg8Z7eDXzTerhIUo7UwG0JIBon7A+FeX7CiKZhuxXcKkibWY9kqgm8hYZ/PKmopYw1G3e55qLKd6nUn4cSc5OXEN6CppzEhGHW866vgE+g4OGhSe2L/QKYoccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mo1fiC6o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3f17c6491so786455ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772288; x=1715377088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIFkEzqD+TIhqStDpaYlErlu7+fCFfSMn8LHhnvMED8=;
        b=Mo1fiC6oiut9Ga3mRHDWeK+Y/XnxdxP2H8vyRLoEPCBLIHY2u2AWs5TO6oMYNOBBFz
         79Dxlcf96v6UAyxQdoWZRDx6fxBdLNHgFA/E4EuZZ2R3c1uRNkzfCC+WEI3h7tmqvuJo
         96aDL3E/ZcOqwjgImIt65a58hCEUEIrBGo/fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772288; x=1715377088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIFkEzqD+TIhqStDpaYlErlu7+fCFfSMn8LHhnvMED8=;
        b=BQHTfeeihwHj/hHaCWb7eShQ4Rs2Zn3fmNnRAvM7XbeL9S4cKor3X2zUi7jZm5dA3H
         KWVeA6Qeu4vw60efRdVr0jxo5Cmho5RGi54KMPMR3j68OUuzahatcDFQwvZpswfEaN3o
         EfvKE2StpE4aIHSECMSDFELXBAHLYplGMvlNUTw3ix018f34hljF833BxDJEbR40R13H
         rm7fbfrc1gfa6nBnAuhQCGASnoNqk7FSRKOGaAXFGzYSnggPe/BK3CpvlzyZANIFBsuV
         h9mXtc6kHu+FAPIV5puR4hBKAfQqtSRxLgmWvSNnjv3wD8KNrS8AQC8aroH4n5HwZBh6
         7iMA==
X-Forwarded-Encrypted: i=1; AJvYcCXlt9BgLaCWvl1tLOQyGfwnxcfnrO4arhxq6jFHZsN1Yqj0v7EYi8FdYtGXZZgf+L+j3eE4StzCDc+vBFqnqu41k06nM3CTba5R3LxP
X-Gm-Message-State: AOJu0Ywj+PHT+kzo+J1Z5JLaoU6ITYr9zSFviurDAxF7fGvlEHhLh9/E
	ubc/dj4H+1UiPMxAomP2KSYrh7ef1qy7QC+a1IAfWmPZ3Z8yYG2ywdKt/fLtiw==
X-Google-Smtp-Source: AGHT+IEppDICkxPotojV6v+5Nxi2QTdXAAGWwbdKCVuRTx7nnbpoKjn0h1KLaB5gimMRVhmWkqxAGw==
X-Received: by 2002:a17:902:e943:b0:1eb:7aeb:54f3 with SMTP id b3-20020a170902e94300b001eb7aeb54f3mr5417928pll.36.1714772287701;
        Fri, 03 May 2024 14:38:07 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:38:07 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 44/48] drm/panel: raydium-rm67191: Stop tracking enabled
Date: Fri,  3 May 2024 14:33:25 -0700
Message-ID: <20240503143327.RFT.v2.44.I20f82e9dd1597a14ae37a64c6b8275add60fbdb1@changeid>
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

The conversion of the rm67191 panel driver follows many of the other
panel drivers but has a few differences that need to be called out.

Like in commit 1e0465eb16a4 ("drm/panel: otm8009a: Don't double check
prepared/enabled"), this panel also uses the "prepared" flag to
prevent the backlight functions from running when the panel is powered
off. This is probably not the safest thing to do but the old behavior
was preserved. See the discussion in the otm8009a patch. Because of
this, I've left the driver tracking "prepared" but removed its
tracking of "enabled".

NOTE: as part of this, transition the panel's direct calls to its
disable/unprepare functions in shutdown to call through DRM panel.

Cc: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 21 ++-----------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index dbb1ed4efbed..fa9bf89d3bb5 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -205,7 +205,6 @@ struct rad_panel {
 	unsigned int num_supplies;
 
 	bool prepared;
-	bool enabled;
 };
 
 static const struct drm_display_mode default_mode = {
@@ -267,9 +266,6 @@ static int rad_panel_prepare(struct drm_panel *panel)
 	struct rad_panel *rad = to_rad_panel(panel);
 	int ret;
 
-	if (rad->prepared)
-		return 0;
-
 	ret = regulator_bulk_enable(rad->num_supplies, rad->supplies);
 	if (ret)
 		return ret;
@@ -291,9 +287,6 @@ static int rad_panel_unprepare(struct drm_panel *panel)
 	struct rad_panel *rad = to_rad_panel(panel);
 	int ret;
 
-	if (!rad->prepared)
-		return 0;
-
 	/*
 	 * Right after asserting the reset, we need to release it, so that the
 	 * touch driver can have an active connection with the touch controller
@@ -322,9 +315,6 @@ static int rad_panel_enable(struct drm_panel *panel)
 	int color_format = color_format_from_dsi_format(dsi->format);
 	int ret;
 
-	if (rad->enabled)
-		return 0;
-
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	ret = rad_panel_push_cmd_list(dsi);
@@ -389,8 +379,6 @@ static int rad_panel_enable(struct drm_panel *panel)
 
 	backlight_enable(rad->backlight);
 
-	rad->enabled = true;
-
 	return 0;
 
 fail:
@@ -406,9 +394,6 @@ static int rad_panel_disable(struct drm_panel *panel)
 	struct device *dev = &dsi->dev;
 	int ret;
 
-	if (!rad->enabled)
-		return 0;
-
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	backlight_disable(rad->backlight);
@@ -429,8 +414,6 @@ static int rad_panel_disable(struct drm_panel *panel)
 		return ret;
 	}
 
-	rad->enabled = false;
-
 	return 0;
 }
 
@@ -633,8 +616,8 @@ static void rad_panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
 
-	rad_panel_disable(&rad->panel);
-	rad_panel_unprepare(&rad->panel);
+	drm_panel_disable(&rad->panel);
+	drm_panel_unprepare(&rad->panel);
 }
 
 static const struct of_device_id rad_of_match[] = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


