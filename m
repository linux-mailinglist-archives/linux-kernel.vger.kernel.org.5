Return-Path: <linux-kernel+bounces-168300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA3A8BB63E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1384F1F21898
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F913541F;
	Fri,  3 May 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvV2Hg4S"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632891353E1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772268; cv=none; b=f+FTyWl2sqhm1FrMwqAkv9sC3V9EXfuJukhVb/2GQ8WqbR4xg8iUDBa0+i6wl778789l2/SUqREWUQDjN/aemE7M+eW2Bm83OKDVzd5ODVNcEIDYgxi/Ua282LuBBP3kOBMOAl7cjFETSrL4Gh4p1DbNd/oGJILWGnq++zonixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772268; c=relaxed/simple;
	bh=0c2PVXNgA4nlOkkqlvM45fh6+dC0inZ9PV3m/UHMawM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTVa/euLU4eAAT7lHlsSbTUN1QWAu3OfhO90PSZIuKzvOfKi2n7X+m05069LHpmzRxvX5dWVeh3FPX9GZsseiviCqBsqZizedOGQ3ERP9YNmEmxk+h5kp74MlbVGFn13KjJxuVx3Iaa4g7jrVs6VKFGp2rnF8sCNqHKuTkX58w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PvV2Hg4S; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so1228245ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772267; x=1715377067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIn+sWO9dEDf1DvG5c+RzmcIdDo8LI3xPQg/VI7zljA=;
        b=PvV2Hg4Sc1J3CW1rGaUx9E/Nhq4Z0rzwuQ42f0fAPwMFQgkzXSVTOB6DZaE3GXhowA
         Ujkg33H0T5XZmUWaYQ4Axf63V28uIPCDgZKXENIRoioZk8nwITInCiPiurIc9gb03C1q
         9+jiFb5kv3L8CCQeeDprMyRZdK2GvByvIM/nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772267; x=1715377067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIn+sWO9dEDf1DvG5c+RzmcIdDo8LI3xPQg/VI7zljA=;
        b=YRBWWMg2W5m8h2GEX+Zgo54WhVyns/q0KdAtQ3UrUHHapY2A/nQmIzMgVAilWWTqUP
         d5SvfRYP14dgXU58Yz3uSDWwYHfJDiH6aK/LQw9FH2axqg5h7I2EevRV2syoLdPr04DN
         xfXZSHcCMUofBOpiz+luwEhP0knHuJ1zGN6vaRtVDz3nGFzPvch4Hsu0mAXH2bE5mDy9
         V8TBloYCn/qaXooe5+6j0+nGKl3aV70OEvFo5YdTzVc7Wz9unMbDLokJJQzExZdWpDc0
         UbV7Nrn8Uoz69sL7yEd6jvaItkLVU1/p3Pp4AvMYp4O3ZGyYU6EgXpzoyohumFOTgJGL
         GdOg==
X-Forwarded-Encrypted: i=1; AJvYcCUDn9NS1H9gP1judrqQs/DF0sAvn6BsJjGq9qsfy0ui6e8k93tAOEl7s7aIYBcQ/qTSbMf6AW0joVgogRq/u2+7Otd/ZdGNnPIAH8rq
X-Gm-Message-State: AOJu0YzgvRDqaFtXUR1MAqrlLL0MjP70l2Gm7fVXNdLWrefJVYICqkdf
	12PNfRxRjrwGlvTa8Ivf/WAdrzF+/sFPH+pj95g7HWiUuQMRihoKeQ2YnB6AnQ==
X-Google-Smtp-Source: AGHT+IFgOtsvmnCpgD9YCuirDNOd6sEAldzPJUUEeKJ2LJEqLasuF33MZxCdPNTGTti/0Ofhqu2Ztw==
X-Received: by 2002:a17:902:f54c:b0:1eb:5b59:fab9 with SMTP id h12-20020a170902f54c00b001eb5b59fab9mr5096772plf.53.1714772266832;
        Fri, 03 May 2024 14:37:46 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:46 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 35/48] drm/panel: panasonic-vvx10f034n00: Don't call disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:16 -0700
Message-ID: <20240503143327.RFT.v2.35.I1562c864ee35a9c166765488c95104b7e4e562da@changeid>
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

Unfortunately, grepping mainline for this panel's compatible string
shows no hits, so we can't be 100% sure if the DRM modeset driver used
with this panel has been fixed. If it is found that the DRM modeset
driver hasn't been fixed then this patch could be temporarily reverted
until it is.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index 822ca2f971eb..d1c5c9bc3c56 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -222,10 +222,6 @@ static void wuxga_nt_panel_remove(struct mipi_dsi_device *dsi)
 	struct wuxga_nt_panel *wuxga_nt = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&wuxga_nt->base);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
@@ -233,13 +229,6 @@ static void wuxga_nt_panel_remove(struct mipi_dsi_device *dsi)
 	wuxga_nt_panel_del(wuxga_nt);
 }
 
-static void wuxga_nt_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct wuxga_nt_panel *wuxga_nt = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&wuxga_nt->base);
-}
-
 static struct mipi_dsi_driver wuxga_nt_panel_driver = {
 	.driver = {
 		.name = "panel-panasonic-vvx10f034n00",
@@ -247,7 +236,6 @@ static struct mipi_dsi_driver wuxga_nt_panel_driver = {
 	},
 	.probe = wuxga_nt_panel_probe,
 	.remove = wuxga_nt_panel_remove,
-	.shutdown = wuxga_nt_panel_shutdown,
 };
 module_mipi_dsi_driver(wuxga_nt_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


