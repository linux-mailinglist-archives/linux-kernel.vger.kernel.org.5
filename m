Return-Path: <linux-kernel+bounces-168301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB48BB63F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27064B25E15
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08364135A6D;
	Fri,  3 May 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gt2Vmvg/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA8135A47
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772271; cv=none; b=r3Yt1L9tQMJD37PyzPhHFScYjhZkCa41rvq8hm8knIvcXp+O+CuuCdRoE7l7puFIOgAUyomZDWAtt3CgZnmTHXPYkVz0nQSuR3NfvhdNK2o3PhecNnhCoqrFk4dqWfbY5G90veIzXO+0wFT4dRJC3Mzrz8M67o71DklDHyKNAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772271; c=relaxed/simple;
	bh=axmCxiLmm7juCKxfHqZtD6qpzVBDjoTLtSOaskdPvC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzaUv4upnFVso5wOY0RqUTau/gqSAts0GbVqwDuFUb/yfNqyEaW2PG744AZn85tto8BHXYl/J1myP9V6IrBXK3R1MrdgJSE3oSBIjNsRCoq8mVncFDTelo1K5VAtU1ptjLJFJLV5Qi+yYxg9Dvyug18ydZWOTJ2MTU1K6bNApog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gt2Vmvg/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so1228525ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772269; x=1715377069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0iO3yAQ8KkSt7Wokb68l77QkaHVGUqroVg9qjrT7Jw=;
        b=gt2Vmvg/boNoBeBH9SiFssil1wPIC4CxxS9p7fgLhLQWoDorkrXlWAIbh14eFRYZG+
         DFCysT+TK1rvCQ03WSgmsZE+pzppltWxhhhdhBalMyIkLqBeB04qHH58ZnbGXP8KmpIG
         E9nnHJuwXcDjkqLMI0jie9v/J4LDfK/WGlVhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772269; x=1715377069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0iO3yAQ8KkSt7Wokb68l77QkaHVGUqroVg9qjrT7Jw=;
        b=KZbs5nn19BYOaguuE58YnY7nDCCEE2v9csFfGtzEgcO7TiTOvSI8utbhdMP/f0/PvP
         rmsRd4UbLrNgQdWcqfzRKkY6yeTUN3g5YU+NocBIXB4C68BCH7z9moXDt6FGJIBZPWxn
         R9PPDsejoWL0DQMiXsWHFFCeutVjdHzbunoL/9Lu9p5x0EoAe/l/gWrJPaYrMiPKMrQi
         wuCsu8WxRFVleeoUnUSPXgfWE+JIaItNaP2VQdRFk9vJ3r3nV1jlsC5tGuLDefyYaP6c
         N97l7UolKl157nYpltLpaITa1aqLvUgy+/iYnaN3aHVtoIIaXXQwfye41Cy+Hi2bsNkb
         SuRg==
X-Forwarded-Encrypted: i=1; AJvYcCXwzGrBzQfO+VkjWflqoZXHeUqMwGuL/9TxfXBAO3tUQkdq/JcZMXglxtYKtB9160Yi41nh6yqrqzSsGfjD0UHYrg/NI4Xq2F5MIDLO
X-Gm-Message-State: AOJu0YyByF303DcA3odYJNkB+8dvLLq8RgOrKKZJjCqBZv/gUeOQCI8y
	USslaN3yACMrZRr+h4DdW+Ptl1hnu7wAEdIJzKuffDRyppJ7j/CKJjExF8N68w==
X-Google-Smtp-Source: AGHT+IEJXRtPeQGcDuRFCN51uInhuJn+mY1i1wPYgk00iOIMC5r7aJDHEYH9EmcUpqfMP7eJW7lrPw==
X-Received: by 2002:a17:902:7797:b0:1e3:e39a:2e49 with SMTP id o23-20020a170902779700b001e3e39a2e49mr3858363pll.18.1714772269071;
        Fri, 03 May 2024 14:37:49 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:48 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Marco Franchi <marco.franchi@nxp.com>,
	Fabio Estevam <festevam@denx.de>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 36/48] drm/panel: seiko-43wvf1g: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:33:17 -0700
Message-ID: <20240503143327.RFT.v2.36.Idda91d310ca2e4f5a4ab4ca6eaf1afdaf14eeb51@changeid>
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

Cc: Marco Franchi <marco.franchi@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: imx@lists.linux.dev
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c | 40 ---------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 658c7c040570..98480904126c 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -44,8 +44,6 @@ struct seiko_panel_desc {
 
 struct seiko_panel {
 	struct drm_panel base;
-	bool prepared;
-	bool enabled;
 	const struct seiko_panel_desc *desc;
 	struct regulator *dvdd;
 	struct regulator *avdd;
@@ -122,25 +120,10 @@ static int seiko_panel_get_fixed_modes(struct seiko_panel *panel,
 	return num;
 }
 
-static int seiko_panel_disable(struct drm_panel *panel)
-{
-	struct seiko_panel *p = to_seiko_panel(panel);
-
-	if (!p->enabled)
-		return 0;
-
-	p->enabled = false;
-
-	return 0;
-}
-
 static int seiko_panel_unprepare(struct drm_panel *panel)
 {
 	struct seiko_panel *p = to_seiko_panel(panel);
 
-	if (!p->prepared)
-		return 0;
-
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 
 	regulator_disable(p->avdd);
@@ -150,8 +133,6 @@ static int seiko_panel_unprepare(struct drm_panel *panel)
 
 	regulator_disable(p->dvdd);
 
-	p->prepared = false;
-
 	return 0;
 }
 
@@ -160,9 +141,6 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 	struct seiko_panel *p = to_seiko_panel(panel);
 	int err;
 
-	if (p->prepared)
-		return 0;
-
 	err = regulator_enable(p->dvdd);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to enable dvdd: %d\n", err);
@@ -180,8 +158,6 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
-	p->prepared = true;
-
 	return 0;
 
 disable_dvdd:
@@ -189,18 +165,6 @@ static int seiko_panel_prepare(struct drm_panel *panel)
 	return err;
 }
 
-static int seiko_panel_enable(struct drm_panel *panel)
-{
-	struct seiko_panel *p = to_seiko_panel(panel);
-
-	if (p->enabled)
-		return 0;
-
-	p->enabled = true;
-
-	return 0;
-}
-
 static int seiko_panel_get_modes(struct drm_panel *panel,
 				 struct drm_connector *connector)
 {
@@ -228,10 +192,8 @@ static int seiko_panel_get_timings(struct drm_panel *panel,
 }
 
 static const struct drm_panel_funcs seiko_panel_funcs = {
-	.disable = seiko_panel_disable,
 	.unprepare = seiko_panel_unprepare,
 	.prepare = seiko_panel_prepare,
-	.enable = seiko_panel_enable,
 	.get_modes = seiko_panel_get_modes,
 	.get_timings = seiko_panel_get_timings,
 };
@@ -246,8 +208,6 @@ static int seiko_panel_probe(struct device *dev,
 	if (!panel)
 		return -ENOMEM;
 
-	panel->enabled = false;
-	panel->prepared = false;
 	panel->desc = desc;
 
 	panel->dvdd = devm_regulator_get(dev, "dvdd");
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


