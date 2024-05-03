Return-Path: <linux-kernel+bounces-168308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F98BB649
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA1284206
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB6136E3E;
	Fri,  3 May 2024 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcjQYI8w"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020965B1E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772285; cv=none; b=UOkCO8zH+dktNYmrlVlswpFf5LZD897XuEOHBW3HFZ8LaNut4FYGffQWyBsZY1YqQwAY92GgTnBD5F5kzrfzXCSYdSr2YdZckJGcAGoJhxHdtOgu7rraWT1tNOwPzNrslHiX/betmqiiKrtkwIZILplAT5Vl3Qt3wIlWAM1/F2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772285; c=relaxed/simple;
	bh=kJpO3gyrfbbb9Uz3lEEMOXm5oGJ96WuhGuKz+E1GyzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4c6CtA0vX1s7XnyTZMoCGMpeg8uHtU+RhGLVF+mQztVMKxdoEIvCDa3tCWHHyXuWp40BRodj/FdchyMHVZuexKbWYXZM8fHNTXde/aqSMq3W5PUr3/2mn80Ul4CP4yseCMDiXYaOYhfQncPv20K75XKyiJS9F2dvOrFYMsAvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gcjQYI8w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed41eb3382so1033785ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772283; x=1715377083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Avvw3HtD9t825/57o/WJV3t+qgm+MjAo1zab7qfrAw=;
        b=gcjQYI8wgbln7HionxbuDf/OmIDoXbZd5pmcCoAUHja4XSWWqwLhIkH9qv6bU7l93F
         yrGIaSkT1aIT8fv2/EtD9O1aJOgsUWMf/yihhT6T9fZKV6fzD8+wbhBly4pKx3Acv4lP
         nXB2fwopQRSnSH8yR5P3D6rIMJVndDhyayUGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772283; x=1715377083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Avvw3HtD9t825/57o/WJV3t+qgm+MjAo1zab7qfrAw=;
        b=u8PJfZ9Swb6ao5gBNxl0r+4Zbd4kNvlRwkthOhoINDJgdXPvOQVMi5U/FcxoW84OA1
         lIdLbSUxQ/oqs9yBo2kc5hcYIAhYJz5bIoiOaaXV3msTDbNnO8kCFVIV2Rtm1WsZe4DF
         e2ecJTl9IUJOMU4JaPvmQeSMJZ0ejNp9A65yLyhV9QHLU3ZfqS4GiakYuRUcqEw7qgIP
         kSNqRDjYGEyz/+2B3p9i2sxCgfOAFpAY5UeMu1YjAdr94UHlIbwlTT+aDSFzeYvEWt4U
         5ErA9ZvQpuRJcILj6SBMR2f0VEWOGTroCcrNeUUz+dJVJA2OSEbRoNS96WAj81hdhxm5
         /GVg==
X-Forwarded-Encrypted: i=1; AJvYcCVLUo8w0bXgK1gguG9hO74S+rHTSEmPertc7HHDLRLzkPo4hYepZXi+0p1UFGpH5B7Ml3GaszOl0ryR1trCwFEgi/TjTGKYlusGGq/M
X-Gm-Message-State: AOJu0YzyRHhEIdPYEgF3tDUQYD4uoFF11/oRUem9TiZuQXc2SihFiD1X
	fahwWEbN24qsd4SEtAN0K5gjF+WrRSntSEauiFBdOnYQBhxukUZ+GQbuwo8vwg==
X-Google-Smtp-Source: AGHT+IEu82XmRy0lY1T4aUx77LcpN+15wj25rF0IIbfio5kewqFsMtXS5VE3myBBns7XneJTh6xgPw==
X-Received: by 2002:a17:902:b784:b0:1e5:a025:12f9 with SMTP id e4-20020a170902b78400b001e5a02512f9mr4001966pls.28.1714772283235;
        Fri, 03 May 2024 14:38:03 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:38:02 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Frank Oltmanns <frank@oltmanns.dev>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Purism Kernel Team <kernel@puri.sm>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 43/48] drm/panel: sitronix-st7703: Don't call disable at shutdown/remove
Date: Fri,  3 May 2024 14:33:24 -0700
Message-ID: <20240503143327.RFT.v2.43.I08ba0d4e2d534c06ab0ede9c148bb14cc7c1a9d7@changeid>
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

The compatible strings used by this driver seem to show up across
boards using a variety of DRM drivers. It appears that the relevant
drivers have been converted, but at least one compatible string
doesn't seem to be found in any mainline dts files so we can't be 100%
sure. If it is found that the DRM modeset driver hasn't been fixed
then this patch could be temporarily reverted until it is.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: "Guido Günther" <agx@sigxcpu.org>
Cc: "Ondřej Jirman" <megi@xff.cz>
Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: Frank Oltmanns <frank@oltmanns.dev>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 6b2d940640ca..77b30e045a57 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -937,27 +937,11 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void st7703_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct st7703 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = drm_panel_unprepare(&ctx->panel);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to unprepare panel: %d\n", ret);
-
-	ret = drm_panel_disable(&ctx->panel);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to disable panel: %d\n", ret);
-}
-
 static void st7703_remove(struct mipi_dsi_device *dsi)
 {
 	struct st7703 *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	st7703_shutdown(dsi);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
@@ -981,7 +965,6 @@ MODULE_DEVICE_TABLE(of, st7703_of_match);
 static struct mipi_dsi_driver st7703_driver = {
 	.probe	= st7703_probe,
 	.remove = st7703_remove,
-	.shutdown = st7703_shutdown,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = st7703_of_match,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


