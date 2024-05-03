Return-Path: <linux-kernel+bounces-168268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C68BB60C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5E21C23E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46684E03;
	Fri,  3 May 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fsfDzlC9"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BE58ABC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772201; cv=none; b=hyBFfNdDC8l+eiWOQ9DVkIituxf81WA6ZHXeZpJONrCCADiJTFCSyF7ZbrEdmfjx28fvQY80e5ws3auFrt5w/8w+AEQ+ni1Swmw4DlfLJVyiD5G2uQcUZk7Lb0Rs38z+89JhGNBsYRVx+hBHaYAVfCj6LJE04VIf9XSxSQvz1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772201; c=relaxed/simple;
	bh=szuDzoCZuRFvsQUIOomj1teaF1eqZrWLsjF/lnyPTAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IECtVaTfbdz91NAZCxfEGYedzFeQzC2FLp9kg/KhXH06IHuvm3hH61NbhTpolrXMMDJBWOpTGruAGmNwLKZ1wvGqCQdqBtQ/NLCN1S4Lq4XrRX/RFINSa3yzeo8QPdyb3ecW8bJB1KtvymCf4ElLNeXYtsOF4TGxvSgKFSo+ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fsfDzlC9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso847995ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772199; x=1715376999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCoTs68fkVHbhVnPnaiJoDVVCaB+mneUDffLrqHY7lM=;
        b=fsfDzlC9Z8bSqButUjT/8o3VxerAS6G1iPfpjTZCOp34IqcUi5gotKPneW1BR09Ry+
         S0IwTw6SGkkHS1QbSEbZ96J2q7XZWfMuywuv7UYwl2CU7GYTdgmpaNbdd3Tna1oa2txz
         7wOellpTLwv0Z89Eb+xntZQ7pPKSex5qrzTZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772199; x=1715376999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCoTs68fkVHbhVnPnaiJoDVVCaB+mneUDffLrqHY7lM=;
        b=sAHtTdwclvmGbg2vt7POuxdp7iQou6JBbJ6On17vUGuE2dR88S+S/JWci5DAJ7lO2l
         xIU0E9yIJEXmkdJ+TeSmjO0w+q3/Imric2NjlqjW3T27j13HN65QeJLDLeolrOdUoenA
         QHM/4rz2AFM8IJh3tp6lhGzGcCZ3m/1oo7+mW71kDFGUYeG2a6jHjaoQiKqD3kshi8Ek
         nklJiRN7HodzZXh0i+3izGLnLIQ35+48RyWMbkl7KF5a79PjBMJQ/sUaCOa8BO18GOF5
         xo65qxqQWPZYTNvJIHv+vcnW4XsYamw5vnUWCXBvjq2QVtEEntoiPxVhodQKI14GuNNm
         Jw/g==
X-Forwarded-Encrypted: i=1; AJvYcCXNzeCL5+uufb4OVrLHvvojmfj2cnKiuDiiNim99VDRK8bCaZkoqP0PQHuGgECba8FNaRfoO72kuh97ITlK1rH1JjuhNAQeD0Dz/TIO
X-Gm-Message-State: AOJu0Yyj2WhmU4Wawd9aV8IA3CZW0ADGUT/BDVHJFGWrqGuwiOn/mH4k
	k9K78pAay3CWHjWlh+N1dkW9ut8Pt2YVHFD6UEh7aiEIe6v69WNfkZ2BWYm9fQ==
X-Google-Smtp-Source: AGHT+IELE7rVEQIWwU2v7bYG2I6EIH6w07IbYCviD6Ulwew4A7zRTV/QWIpp+ISdHunRXglP3i8Fyw==
X-Received: by 2002:a17:902:e5c4:b0:1ec:2274:8205 with SMTP id u4-20020a170902e5c400b001ec22748205mr5122613plf.48.1714772199273;
        Fri, 03 May 2024 14:36:39 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:38 -0700 (PDT)
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
Subject: [RFT PATCH v2 06/48] drm/panel: edp: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:32:47 -0700
Message-ID: <20240503143327.RFT.v2.6.I4d1bf08781593c08127e506422687ab19fd3c824@changeid>
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

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-edp.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 6db277efcbb7..344f67871d41 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -222,11 +222,8 @@ struct edp_panel_entry {
 
 struct panel_edp {
 	struct drm_panel base;
-	bool enabled;
 	bool no_hpd;
 
-	bool prepared;
-
 	ktime_t prepared_time;
 	ktime_t powered_on_time;
 	ktime_t unprepared_time;
@@ -395,14 +392,9 @@ static int panel_edp_disable(struct drm_panel *panel)
 {
 	struct panel_edp *p = to_panel_edp(panel);
 
-	if (!p->enabled)
-		return 0;
-
 	if (p->desc->delay.disable)
 		msleep(p->desc->delay.disable);
 
-	p->enabled = false;
-
 	return 0;
 }
 
@@ -420,17 +412,11 @@ static int panel_edp_suspend(struct device *dev)
 
 static int panel_edp_unprepare(struct drm_panel *panel)
 {
-	struct panel_edp *p = to_panel_edp(panel);
 	int ret;
 
-	/* Unpreparing when already unprepared is a no-op */
-	if (!p->prepared)
-		return 0;
-
 	ret = pm_runtime_put_sync_suspend(panel->dev);
 	if (ret < 0)
 		return ret;
-	p->prepared = false;
 
 	return 0;
 }
@@ -542,21 +528,14 @@ static int panel_edp_resume(struct device *dev)
 
 static int panel_edp_prepare(struct drm_panel *panel)
 {
-	struct panel_edp *p = to_panel_edp(panel);
 	int ret;
 
-	/* Preparing when already prepared is a no-op */
-	if (p->prepared)
-		return 0;
-
 	ret = pm_runtime_get_sync(panel->dev);
 	if (ret < 0) {
 		pm_runtime_put_autosuspend(panel->dev);
 		return ret;
 	}
 
-	p->prepared = true;
-
 	return 0;
 }
 
@@ -565,9 +544,6 @@ static int panel_edp_enable(struct drm_panel *panel)
 	struct panel_edp *p = to_panel_edp(panel);
 	unsigned int delay;
 
-	if (p->enabled)
-		return 0;
-
 	delay = p->desc->delay.enable;
 
 	/*
@@ -598,8 +574,6 @@ static int panel_edp_enable(struct drm_panel *panel)
 
 	panel_edp_wait(p->powered_on_time, p->desc->delay.powered_on_to_enable);
 
-	p->enabled = true;
-
 	return 0;
 }
 
@@ -869,7 +843,6 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 	if (!panel)
 		return -ENOMEM;
 
-	panel->enabled = false;
 	panel->prepared_time = 0;
 	panel->desc = desc;
 	panel->aux = aux;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


