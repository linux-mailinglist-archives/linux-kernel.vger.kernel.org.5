Return-Path: <linux-kernel+bounces-168304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B18BB642
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F71C215D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B8B13699B;
	Fri,  3 May 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wku1IRIK"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DC136671
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772277; cv=none; b=oM+ON59geGhVuSeWXCDNLV5yubRT7/0y46+7T2FWbKS1Hk8rEWMRbgrFUddv4st8gnuvq1/g+rNzLOvqIa9FGF58R61WJTaL5q8OeAORJyKXTZ3X1/RvEAEzPaIfDgwkb8uyOBCIns2K6j9SI4BLSKclf2zzdRiwzbdrJ+ORQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772277; c=relaxed/simple;
	bh=NyKOElo7sVYzjTbWVk81v0plZbxckd0wXadRZmZkbOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shpNqBLbuu27A2MKw3i8jceDeA8nl/E0V9nGbQwUTAUV6tqdUyZkemhriQHBHxOOpAqY7Evu4J/4WTF1CWhYoBDIZDziREMJI8mcd3TNtkdDHFWn+SNpjqV78t4RGC1B44e8+cKKI2rCRgbGp4jDtLSExqePs9yJ+h5QAqC1Ta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wku1IRIK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e86d56b3bcso1257475ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772275; x=1715377075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ2bcwxBHMvzwpRFsoGmIetgpC7SnvJGS8R4x5ACAaI=;
        b=Wku1IRIKWvAzNsEGU5VjgyQYnJQZvScHU+9b7inR3utV+f0C5yBLe0Zzz4UBDrd22o
         smBSoWe56WyQh0Mk0tVUo0bGLbeIe4TgGelu6TzF7rP2VXTLd3sEaBW1uo7TlKX7GoJJ
         A5Azm7aHg9oZUpng1ftBQk3cJf37g+vB5W/Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772275; x=1715377075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ2bcwxBHMvzwpRFsoGmIetgpC7SnvJGS8R4x5ACAaI=;
        b=HyamWEQimYHTmT1v0Mg3SOcb2+M3VOUQCF9bEOmMoxTwkuM0gJGi0fLSQquqzEroL7
         /5YnSgiJQG3Q/k7UU27e7AcVCn4zGm0BdAXwAhcqndGBUElhEScOlDQsvaCGaViwBziX
         D9BHhAvX6zMEU0dmPQ97dE76IBYWsZnxqK5AghbghAPLt4PJIl0SWl5BytxJ1oPX56f5
         ehbxW5/FGMYtYFxAYYc5Kjn6ASsuVl847vxs1ZNHE2one4iyzlw8LKWwZyC4QGrjR/FN
         PQBBuNWcmdEJBvih/0GhwUIFemFs5TXjsUrdqRGN/uHnjDgywWzK+iwmxa+qiB6QdJDx
         XfoA==
X-Forwarded-Encrypted: i=1; AJvYcCU+HjNvx0lq/yskkYI1Jn2rlqEwa5XosYE2xj4/qdKH5SY11eMUlfHCJxTjOlR4yglw8HA42ibq1azLZk/aoCPIMZC/HLtUD811KD8G
X-Gm-Message-State: AOJu0Yy2X3tQXQZPn4dzvfJAsBp+DLIanY8VBG1hKOcSC7Trx1Wjk+mx
	vDSJUhzG51mN7IxvlOFjc/vvLgYreoIM9iq0OnlK8C8yAlj7we5Emq3MD0EdaQ==
X-Google-Smtp-Source: AGHT+IF4B6Nfr3ZtrpYHNA9pejG1rE3AiUgc8H89qrn9KVvMkhOXg6EYM81DsPyLvBFCo2ge0DZf3A==
X-Received: by 2002:a17:903:2306:b0:1eb:1af8:309f with SMTP id d6-20020a170903230600b001eb1af8309fmr5575949plh.4.1714772274987;
        Fri, 03 May 2024 14:37:54 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:54 -0700 (PDT)
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
Subject: [RFT PATCH v2 39/48] drm/panel: sharp-lq101r1sx01: Don't call disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:20 -0700
Message-ID: <20240503143327.RFT.v2.39.I6a87fce1ee027c96f71c7adf74248b865f50b336@changeid>
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
indicates that it is used by Tegra boards. The Tegra driver appears to
be correctly calling drm_atomic_helper_shutdown() so we can remove the
calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   | 24 ++-----------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index 8f6c21b99522..edc9425bb143 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -357,32 +357,13 @@ static void sharp_panel_remove(struct mipi_dsi_device *dsi)
 	struct sharp_panel *sharp = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	/* only detach from host for the DSI-LINK2 interface */
-	if (!sharp) {
-		mipi_dsi_detach(dsi);
-		return;
-	}
-
-	err = drm_panel_disable(&sharp->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
-
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
-	sharp_panel_del(sharp);
-}
-
-static void sharp_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct sharp_panel *sharp = mipi_dsi_get_drvdata(dsi);
-
-	/* nothing to do for DSI-LINK2 */
+	/* only detach from host for the DSI-LINK2 interface */
 	if (!sharp)
-		return;
-
-	drm_panel_disable(&sharp->base);
+		sharp_panel_del(sharp);
 }
 
 static struct mipi_dsi_driver sharp_panel_driver = {
@@ -392,7 +373,6 @@ static struct mipi_dsi_driver sharp_panel_driver = {
 	},
 	.probe = sharp_panel_probe,
 	.remove = sharp_panel_remove,
-	.shutdown = sharp_panel_shutdown,
 };
 module_mipi_dsi_driver(sharp_panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


