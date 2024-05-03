Return-Path: <linux-kernel+bounces-168272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E98BB61D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1D11C23CED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B7126F10;
	Fri,  3 May 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e/yRfOcP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F68615F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772208; cv=none; b=bsM1QdRBMIRclDQxGLI3LUrjbIcXzy2OHD8rZ2/rUeydH8mo9Tn5cVM4gzMq83DRIZQDYUOwqQZNMmnPhbisviWDsIYJEwCO2Ua0d33Fw4oO3TmSv1AsJiGSRDpRhXTu6bgbcd/TwmtJ3rmBiMEuGo+vXTiGQyLDTfdXLGGrvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772208; c=relaxed/simple;
	bh=Ls0hx0BhTj3G0QRMQs+tqGMhFB+yvlJdCpWTrSoM8rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLxFmgoYbc/MYwCtNTQaponrepFqW2wyWnytLQR/6XOQRxpgWyTsHEwA5T3GelH034ZZE3Ot9YBijLmpDHYuoZLh1+7M6YkHWD3h+dJm0ZibXS1nMGADo8YxdDTAFGihV32EOsV2xxpyEsGXW/RDgWSB99/zwJkXHCaL7GbgwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e/yRfOcP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e5c7d087e1so1044575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772206; x=1715377006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM3srp3tc9xHdA4+vQgvWU13AmEZ/1q1evFgoZKKMpU=;
        b=e/yRfOcPp2+qhZoSzW6aNc+ojRklJkTmQzVL/1ZN4PNY8jTbJyouM+E47OHrT3psbr
         A83I5VZNIlDcFJ5uAseBQvalFdE7YgThzgBm9w3C9VUCtbfmuv9S5bsnPJrmWGyLDA33
         ocRpSFZ0RTqsdInua0eQre+1FPY0MgO7FzH0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772206; x=1715377006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM3srp3tc9xHdA4+vQgvWU13AmEZ/1q1evFgoZKKMpU=;
        b=DhWocMGw/n5aBcTvAC2q93yTvkhjUINl/Fehl30tAhw0okTgRaM4EJDTc5rOdFnGr7
         A1khPWfXbSiiSZPcLEdp0A8e1Y2Dn2FvFNKNI4iXLQIIckrYlrOARBvYA8tA9tyTa3Fi
         EEjjI3nBoHCeEgNI1H8YuN27PE/MGL2NdsDxTDAFe8DBv9wpZuT8acVacdehgpoIDRP3
         47ih/a+gzGjZ+IKN9lbcK3oFFah2QO9JCbBejIfQJuCXwYNirpAVn/DSJ0SuBLjTglHb
         YhAba4ts13HiSSjMhiSh6RmDyNb6/3+z6/E6MiqluQDyMHmCKDAaDNxELV03riCum1mC
         CXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKtprxksnMDRjBBdKLyP2XHiW40q9epDzB7LPtIhYr8PgE3aprMJPbHZHMAf880q9a3mRWibbCKYiH3K9+7BUoRiutu+dvUXS+owir
X-Gm-Message-State: AOJu0YzGM0kiLpS+sauEfR8RGq3OBI78OHqoam3EjbyF8RVc1lGkr6zx
	vqEbLwTuA9lAirdyVeO2YMoL/6pm34OP+p1W04W/VVG6JzqtXjJxTaFU0Mjd2FIdjVLfX/BTzNo
	ZCw==
X-Google-Smtp-Source: AGHT+IHQD9LkPID127xDFcCRAQJiVGTr5XKbdWyjPjZmELM/1pOIiovaPXVxv+TzcgrmiYCp2kAmvQ==
X-Received: by 2002:a17:903:1211:b0:1e0:115c:e03c with SMTP id l17-20020a170903121100b001e0115ce03cmr4713172plh.53.1714772206553;
        Fri, 03 May 2024 14:36:46 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:45 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Lin Huang <hl@rock-chips.com>,
	Brian Norris <briannorris@chromium.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 09/48] drm/panel: innolux-p079zca: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:50 -0700
Message-ID: <20240503143327.RFT.v2.9.Iaddb8e0cab570e2f8066a4baf1d49239a820b799@changeid>
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
appears to be correctly calling drm_atomic_helper_shutdown() so we can
remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Lin Huang <hl@rock-chips.com>
Cc: Brian Norris <briannorris@chromium.org>
Cc: "Heiko Stübner" <heiko@sntech.de>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 5833d3a0fc79..280f0fc35b67 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -471,13 +471,6 @@ static void innolux_panel_remove(struct mipi_dsi_device *dsi)
 	struct innolux_panel *innolux = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	err = drm_panel_unprepare(&innolux->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
-
-	err = drm_panel_disable(&innolux->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
 
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
@@ -486,14 +479,6 @@ static void innolux_panel_remove(struct mipi_dsi_device *dsi)
 	innolux_panel_del(innolux);
 }
 
-static void innolux_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct innolux_panel *innolux = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_unprepare(&innolux->base);
-	drm_panel_disable(&innolux->base);
-}
-
 static struct mipi_dsi_driver innolux_panel_driver = {
 	.driver = {
 		.name = "panel-innolux-p079zca",
@@ -501,7 +486,6 @@ static struct mipi_dsi_driver innolux_panel_driver = {
 	},
 	.probe = innolux_panel_probe,
 	.remove = innolux_panel_remove,
-	.shutdown = innolux_panel_shutdown,
 };
 module_mipi_dsi_driver(innolux_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


