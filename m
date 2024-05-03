Return-Path: <linux-kernel+bounces-168277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5BF8BB623
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3478B24FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DC12FF9B;
	Fri,  3 May 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nwblLWNv"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4412F382
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772217; cv=none; b=OzxHhQqxQEC+17V+FeCJInKvwSlhzM+QOdWPQcbAVoKypIv/e5Mn7Mlx0lvrZ/zJ5PIGWMiLeVgT23Hz088rVXRdH3yevHuAyVy8Bct3TSx5cnjZdEQ3E1cYVj0nUMbsBmAoqgISBLquc3DLY9m3lEhWMF3puPN55ePUYu/0lxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772217; c=relaxed/simple;
	bh=MBnyH8mXANNQ2wH6x1SnrtTpzMyE3MelDz2HOgqKRow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KITRoIDlE3Fgu29I34Qi6ZYEsBldXQXPxt4DeJGPjmVHt1o6FUdl28+UVtyfc27z7Fpn2mM1wE9/RMGNtCG+6hkvE9e/kk5FRaIhgD7TvVc+8C/Y5/2z07MydfePuqgWyz4JjoIBe92jPp4lLbP2E8fxCUe/GfchrOK8yaIU45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nwblLWNv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ed835f3c3cso1038375ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772216; x=1715377016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb3TgP/wCNf81D+aV3nRlzqlLyhQoFFUaND2nsUQhqU=;
        b=nwblLWNvIIHb8q4WRA8BA6LcIblwz+OUJfxMT3S6xKoXAt01EIN/dRFW2Lhm49etHs
         qKGPVOGkhZMu93SGJ+B8b1xtsP6vkYFj8hBdR7EtEkUF/rRKvObcKU3h8ngXLG0+Lyk7
         DhBB8Xw4uEuI0BXVilCnOpJ83SR57NXIEOju4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772216; x=1715377016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb3TgP/wCNf81D+aV3nRlzqlLyhQoFFUaND2nsUQhqU=;
        b=FVhDpAKbBuPxbzFWEA3OfJUyZtledFEGfS7CDOCUVzGul9ptaCT/24ScaHL4DgFrgB
         TR/J00sYUP67sjP+kjUTA3unrxA8xp8BySBECF+/NLJD7E2b3DyKvrHUap1/Q9v78QF5
         +5gLRhfdy5SEwXxNJ0bGroRKrj9+eNJFOb664vElOMbQFUQywcmHpg3AEFO/P4hTIZ39
         eIMwpLOLYZ67rloFKLYNdhd/i895xlFVyBM3LxoOWZFVbZube65P4+wCwDRvcd7X8BtP
         SohqGUhr4X9eLqHcZAF/cOQpMFKj6CwujmHEcXNc6Wck0bEV6I+132zcWxUDMW0Cw/Of
         L95A==
X-Forwarded-Encrypted: i=1; AJvYcCVV9k0HBCi/sCQ9q2WhR0qn+QJTCMxgEfrCoHgP8l3Ob/WcR/fKYUG1FBX6jDXbmn8YuF6gI2C7TO60fvkn6Zf9Wh5YUFXlcUBnGOiM
X-Gm-Message-State: AOJu0YydDG85CC1vAY/kzOUmrP7rkvDJj+umLxwrl1GE5X6byOLfIk2u
	CP6Aps5/fel8O4EmS8dTfprdLHt5MjfM9H5xOCU5aWZ3lX8tbv+p0cn64wsDNA==
X-Google-Smtp-Source: AGHT+IFNtgQI4tL4b59ZXyBnIDIYmn8Ia9hPYK7earn8DOm88NvX2c1QDLLSGNTvuzAvGjP8xynfPQ==
X-Received: by 2002:a17:903:2306:b0:1eb:1af8:309f with SMTP id d6-20020a170903230600b001eb1af8309fmr5572876plh.4.1714772215701;
        Fri, 03 May 2024 14:36:55 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:54 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Nickey Yang <nickey.yang@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 13/48] drm/panel: kingdisplay-kd097d04: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:54 -0700
Message-ID: <20240503143327.RFT.v2.13.I6c7c84b1560dd374f6e7e8dc50f419a870d31d31@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

A grep through mainline for compatible strings used by this driver
indicates that it is used by Rockchip boards. The Rockchip driver
appear to be correctly calling drm_atomic_helper_shutdown() so we can
remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Brian Norris <briannorris@chromium.org>
Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Nickey Yang <nickey.yang@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-kingdisplay-kd097d04.c  | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 88d775e000d4..d6b912277196 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -389,14 +389,6 @@ static void kingdisplay_panel_remove(struct mipi_dsi_device *dsi)
 	struct kingdisplay_panel *kingdisplay = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	err = drm_panel_unprepare(&kingdisplay->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
-
-	err = drm_panel_disable(&kingdisplay->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
-
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
@@ -404,14 +396,6 @@ static void kingdisplay_panel_remove(struct mipi_dsi_device *dsi)
 	kingdisplay_panel_del(kingdisplay);
 }
 
-static void kingdisplay_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct kingdisplay_panel *kingdisplay = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_unprepare(&kingdisplay->base);
-	drm_panel_disable(&kingdisplay->base);
-}
-
 static struct mipi_dsi_driver kingdisplay_panel_driver = {
 	.driver = {
 		.name = "panel-kingdisplay-kd097d04",
@@ -419,7 +403,6 @@ static struct mipi_dsi_driver kingdisplay_panel_driver = {
 	},
 	.probe = kingdisplay_panel_probe,
 	.remove = kingdisplay_panel_remove,
-	.shutdown = kingdisplay_panel_shutdown,
 };
 module_mipi_dsi_driver(kingdisplay_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


