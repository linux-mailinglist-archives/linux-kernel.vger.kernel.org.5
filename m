Return-Path: <linux-kernel+bounces-168287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D848BB62E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF041F22085
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C3131BC3;
	Fri,  3 May 2024 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dem3nHUg"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91976131BA1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772237; cv=none; b=t3rOAXSmOskSITrp1gL/P8tUq/4Wuyqlmwrtc9QhY0cY6afzzTZpaNVPdbGs8zZKeqPAT2AA8N1OJRTVUfcJFHz0AjrJhT7/p27TVt2AAACB2UfYesaL8YFoKgA+xjNxqGaeoZ6ovm+9VZ+CWkSZSdOSGirWej9jndhHebcZGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772237; c=relaxed/simple;
	bh=zY8ZWAOIu/t/wLzAduqlZW1TUKjgHOWfN+8MB5eXoLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah5hzWHghauwZmr/JLp9O56t+NGy2zFQO8QVQ8+fRPu773pptk6V2ojNu77OpKdMse2CUGwZzGdvb3dN2hCRTZRmWJVYBHHnPAZ0Z/9LqcFZe/e74JOQJkAeCUsR0ySnMC5dwS13F2HIZeVpWrZdWFJpexK4LjPtuGhdhp6l/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dem3nHUg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso787155ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772236; x=1715377036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kb398tnZbF7fJMJErZr2qa99FcR7DjSwRYR6pHqFAA=;
        b=dem3nHUgh+42WjTHkBD+BjWNO8fUEdq3tPZbtbPBq3vy7Jfa4jtaBVh0KkRCz6WUrq
         3S3KU1HaIOHKBJEOSr4FZ9Yyv7QT+40+kw7hNCg1Af9Jfj2uNSVSbwNqkI8Xu5oTqwFn
         vkcd9W8kvgbddHuCSZyUQM+A8Bh7/SNVGP58c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772236; x=1715377036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kb398tnZbF7fJMJErZr2qa99FcR7DjSwRYR6pHqFAA=;
        b=ZGBEL94MG1N/PBxPoM/DPhRB4zVJ2wJaTkuPPe0wzqnOVup+oPhpdjwyGlZIou+I5T
         l5LSRbg2hQoXySryxaynaxRJ/FmjjlKptUM8w6PPqdfL7BZwfZ7x7x0tlrPuhcb+ynGt
         vqqmTuZpFMw1NcX70fwbDJmHeo2AJDbHhegvD+/uHcZ2EvqHOiOYGAQnCr+7rnHjZmV9
         yTdkrinNQMxRcjI9q88aVmUU/O5bF1iAw6GPMp40riS4sesCLDggtupHRAnBPs33f5m6
         yiH439Q/WDrqiskH6oKCtk5XPI7/ybn4bzKgERvJvthIXmsu66nuCA5L+qgfeu03l9g2
         fZKA==
X-Forwarded-Encrypted: i=1; AJvYcCXu3NXJgGPeQ51KAcvagHMdIm1puCtAmgYUbE1IwUfJ028dlX/CkCA3LjxYfzB31h9Z8Yw/wGYWr2yUBiwzEDyWCXJiWFVsPcelq7E0
X-Gm-Message-State: AOJu0Yyl/fK1Nei8kst/A+XYXuMfgCvUwgC9GIITqJSCvQJYRPoN6c5k
	vQYfCaKTen52PUKVYc5vz/4fye1Xvdd+BeheIMY/0UTPPHppVlLaKv+iZx57nA==
X-Google-Smtp-Source: AGHT+IHwYPDlKJY3i9orrstWVpc4QIsGJstcoDV81Owbok8H8JVv/jrLAEu/UHN2wqnlkUP+yYrQEQ==
X-Received: by 2002:a17:902:d2c5:b0:1eb:992b:789b with SMTP id n5-20020a170902d2c500b001eb992b789bmr4648219plc.2.1714772235805;
        Fri, 03 May 2024 14:37:15 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:14 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 22/48] drm/panel: osd-osd101t2587-53ts: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:33:03 -0700
Message-ID: <20240503143327.RFT.v2.22.Ic7f6b4ae48027668940a756090cfc454645d3da4@changeid>
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

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 27 +------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index 493e0504f6f7..c0da7d9512e8 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -21,9 +21,6 @@ struct osd101t2587_panel {
 
 	struct regulator *supply;
 
-	bool prepared;
-	bool enabled;
-
 	const struct drm_display_mode *default_mode;
 };
 
@@ -37,13 +34,8 @@ static int osd101t2587_panel_disable(struct drm_panel *panel)
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
 	int ret;
 
-	if (!osd101t2587->enabled)
-		return 0;
-
 	ret = mipi_dsi_shutdown_peripheral(osd101t2587->dsi);
 
-	osd101t2587->enabled = false;
-
 	return ret;
 }
 
@@ -51,11 +43,7 @@ static int osd101t2587_panel_unprepare(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
 
-	if (!osd101t2587->prepared)
-		return 0;
-
 	regulator_disable(osd101t2587->supply);
-	osd101t2587->prepared = false;
 
 	return 0;
 }
@@ -63,16 +51,8 @@ static int osd101t2587_panel_unprepare(struct drm_panel *panel)
 static int osd101t2587_panel_prepare(struct drm_panel *panel)
 {
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
-	int ret;
 
-	if (osd101t2587->prepared)
-		return 0;
-
-	ret = regulator_enable(osd101t2587->supply);
-	if (!ret)
-		osd101t2587->prepared = true;
-
-	return ret;
+	return regulator_enable(osd101t2587->supply);
 }
 
 static int osd101t2587_panel_enable(struct drm_panel *panel)
@@ -80,15 +60,10 @@ static int osd101t2587_panel_enable(struct drm_panel *panel)
 	struct osd101t2587_panel *osd101t2587 = ti_osd_panel(panel);
 	int ret;
 
-	if (osd101t2587->enabled)
-		return 0;
-
 	ret = mipi_dsi_turn_on_peripheral(osd101t2587->dsi);
 	if (ret)
 		return ret;
 
-	osd101t2587->enabled = true;
-
 	return ret;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


