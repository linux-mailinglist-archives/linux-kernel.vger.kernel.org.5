Return-Path: <linux-kernel+bounces-168298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080E8BB63C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E8CB229B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B91350DA;
	Fri,  3 May 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0P2j7zj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEC134CCA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772265; cv=none; b=FqcvUuh4qLDvhrRUfS/YIwCqBluuiWdbi70Szo1POj/oyYBa3Ie2IedDN1ojToLheRjwLXU5Gcou54YCHytkdxStc75ie2ROTnSStRe/L8CTsD1cebz2t3qXM3f2p68N0f4/FWrrRc2t5BumZ46kIZR1Dk8WCUvNUljBm5WS4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772265; c=relaxed/simple;
	bh=BF3dCpXK+NdR+9fZmJzvRA35PnI5/Esc/CrBPmmzn04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG0vZdIbDmhZS/UFCs/qnUqPovVF8dDIPj05LtDuEzvgM0wsSzavT5ZfjXHwcvVxR0phwAHMg+E2Nk1X7UwmAuT9qqgvB8PAtzPdwkrO3BJ46pmCsbD2Wma3GLL1F8W406fvVXwaGED70+T3BhnGxCAjg6+CfrephBWl75UPUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W0P2j7zj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecd9dab183so19701325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772262; x=1715377062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlKkW94AChnsvIhCVySiJbRiNalT5tOJ34PXKTcPDbA=;
        b=W0P2j7zjZIcPhUzYYNNGaG17xzxoF7u89nO60go5ZjlA9Qjpjdr3J8pzD8ftCaXuuz
         yM4b0ZcIWuv/h40VkU7J9S92NOutnlOFKUMt+8TPhqgZ002I7smRCJ7AxtKnU90qWz3F
         HXJByypXcKSO+/nwRJPsCqQTFc9uQa9xAWXgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772262; x=1715377062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlKkW94AChnsvIhCVySiJbRiNalT5tOJ34PXKTcPDbA=;
        b=HqDpTqqPhmJw5W5Xp+/PL7vpRul3rPWzlEAX9hcPQNnE7G77Krvh7j4aVhku2rBtvh
         rwQQ66OSSCuZG99KVc4XQLcuM9MGG7IhxmXx3/h1djX9sFnfKI4L+hiG83agr3+dCMRc
         9M6vdqFeghfbJBSY2rMO+HOf1lQ/BKQfef1gWGUVAtuqLKgSt8XJp+pIOd8ehJimHeVx
         d88FaUhNb8IEVYXX5I/BoS4MVinIf/gRuAuHEvbGNPqldEeP/sN1SXbdB8XjJXtRNzNZ
         BcckPrbfj3zU8cq+LeZVrtqAmI23F6pFP3zTDB8zXNqglVdltRrJqrB4IgjMSVJvImpm
         EdDw==
X-Forwarded-Encrypted: i=1; AJvYcCU86m2k3tvgVzT5SfmKhTNjVOeZ+4K2Gx1uMkuehKN58YjujEH+zqxpIOXJ2kpEIHHsSmetl4lAzY23eiTFSVthtOnKvakgp0pRzLFS
X-Gm-Message-State: AOJu0YyseGBVM+y4cXtxoQRhB/TYDX7OBmp6Z6/x5TBzDMz6oPSLGB1Z
	mVMSXAATB95HqcX3O3wyoagKMzKxmpHQ2kIG7W7bM5KVKavt78Plp57NzdpOxQ==
X-Google-Smtp-Source: AGHT+IEq5AgUw6GyV8pe9okGVdoOhJW8iWaIkyS1EF9ClHC3n8yX96iFTRmuWTK/fQ6r8ShwT0dFzQ==
X-Received: by 2002:a17:903:41cb:b0:1eb:8299:db35 with SMTP id u11-20020a17090341cb00b001eb8299db35mr10401266ple.32.1714772262650;
        Fri, 03 May 2024 14:37:42 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:41 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Vinay Simha BN <simhavcs@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 33/48] drm/panel: jdi-lt070me05000: Don't call disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:14 -0700
Message-ID: <20240503143327.RFT.v2.33.I5f3426e511e77b93c247e0aac114bd12b2b2a933@changeid>
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

Cc: Vinay Simha BN <simhavcs@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 4ddddee6fa1e..b1ce186de261 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -452,10 +452,6 @@ static void jdi_panel_remove(struct mipi_dsi_device *dsi)
 	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&jdi->base);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
@@ -464,13 +460,6 @@ static void jdi_panel_remove(struct mipi_dsi_device *dsi)
 	jdi_panel_del(jdi);
 }
 
-static void jdi_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&jdi->base);
-}
-
 static struct mipi_dsi_driver jdi_panel_driver = {
 	.driver = {
 		.name = "panel-jdi-lt070me05000",
@@ -478,7 +467,6 @@ static struct mipi_dsi_driver jdi_panel_driver = {
 	},
 	.probe = jdi_panel_probe,
 	.remove = jdi_panel_remove,
-	.shutdown = jdi_panel_shutdown,
 };
 module_mipi_dsi_driver(jdi_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


