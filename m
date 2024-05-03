Return-Path: <linux-kernel+bounces-168264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156C8BB5ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497D51F21192
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83367A0D;
	Fri,  3 May 2024 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MvAkl/X0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578FF59162
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772190; cv=none; b=KXC/JWTTe+E/mc7BmaTvzEGjP7V6wAnwR+LUnlaLIVmyR2MbLsPqrN3JLAf2bXPAb7zzu7c17u5rBu4EJakJWKGuex6ExcKh7/L48BUHK5BFHjBAtFqcJZOz+wLx44fTgYq2ZgfAxzHJBxLfV9v8gU17jwrRpRQ/S7KwoQdiNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772190; c=relaxed/simple;
	bh=cqR7hS4vud8zXa5zW9gAw2iNuJRgRwzWpTUNSCfJM78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdK7na75N7XjnNo11AcxtlMbzAJYVrA8c1kDC0dHuzhohnOh528eugLhpS4i2VdhNPea0Pn6mz4W/9k3532R3KnUhmjdts+jj+UpZxilnHxF+3UNpdJI30VX/s8qPXFZzs/bwlgEjEnr5PfOvJNf0vmMeTJsJujUuVuaSdErULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MvAkl/X0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso847105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772187; x=1715376987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlLGPoCdKZFYuD2WMpAl+nCcCPU9f5yFXStRl2ODaEI=;
        b=MvAkl/X0nCAxHWFmhsviVHIlPSMwQaD0p6VrQ4/rrVOUfKKxM+jN7ZT5DGi6/x8bK2
         PkQc3wn/eGVUiWorvh3/pJTBMcHFrG/GdEblNZrtiR9XkLv8650pCdNthU/w52/SUxu7
         jTiR6gUJILRnD9KtY0hA3OSytQgxMuw0BjgtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772187; x=1715376987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlLGPoCdKZFYuD2WMpAl+nCcCPU9f5yFXStRl2ODaEI=;
        b=ZHQmgPex7Z8LBPl68x2ihfsyc4QAzurnExgMhhDcF1Bqmi/gXtx3/gp1l1laEjzWCq
         KjZzSJ68VneqZA5dtaDcFDVOCA+W69uxxolMLhbthdtRYrgLsE9uz8RlYQmk6OaoVHSb
         lAasdG//pGVFxpVn8GUXSqrR0Yt1AxeWr6L2pZ0t8mtynCLvjgx+ljPDzD3Akfk2Gbkd
         oIQYS/OjRPpPJWXDx1u+mmGR8LGrvQXBna5rsDN/155sHcX/SYcdIyEtBpHXitw/diNI
         GsLlJesUC7UOqYAKUVdlmO8j14ZxRY3m2LBZe39VWISX3yUQtADtJvqaf72XdvTaMdqS
         1q5w==
X-Forwarded-Encrypted: i=1; AJvYcCVszsuukpSbiyPrTUqH+EA/NI49R7eJGv8bBFnfV6mTVzRaoyLULi9LKPXEevUYObPjOAskTXEeLm5+4WOirO4RUOxzUwQZmY7FRYsu
X-Gm-Message-State: AOJu0YwzM/2QV8XMJYxxtXT/lKIlpP1w8c3Qj6ByGFZvGFX/CMlBDGi2
	BIxC0qJekpfCGTpPWLStcyAcnpfc7el7XVvzEVYzSnYhzGB0VpRC9bZ37Q6oBA==
X-Google-Smtp-Source: AGHT+IFaMjrOZx6PlnR9YpeAGNYEPKz0BZS22xq3/WCuAMWn8FGGgonr0VuEXbwoSJfpxSoPjNw6pg==
X-Received: by 2002:a17:902:db0e:b0:1ec:3227:94ea with SMTP id m14-20020a170902db0e00b001ec322794eamr4805493plx.67.1714772187608;
        Fri, 03 May 2024 14:36:27 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:27 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Jerry Han <jerry.han.hq@gmail.com>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Rock Wang <rock_wang@himax.com.cn>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [RFT PATCH v2 02/48] drm/panel: boe-himax8279d: Stop tracking prepared/enabled
Date: Fri,  3 May 2024 14:32:43 -0700
Message-ID: <20240503143327.RFT.v2.2.Ia3f254ab6e04e4f7afba6c066454498c8fb01324@changeid>
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

NOTE: as part of this, transition the panel's direct calls to its
disable/unprepare functions in shutdown/remove to call through DRM
panel.

Cc: Jerry Han <jerry.han.hq@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rock Wang <rock_wang@himax.com.cn>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-boe-himax8279d.c | 31 +++-----------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index e225840b0d67..12e14615298b 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -47,9 +47,6 @@ struct panel_info {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *pp33_gpio;
 	struct gpio_desc *pp18_gpio;
-
-	bool prepared;
-	bool enabled;
 };
 
 static inline struct panel_info *to_panel_info(struct drm_panel *panel)
@@ -86,17 +83,12 @@ static int boe_panel_disable(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int err;
 
-	if (!pinfo->enabled)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(pinfo->link);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
 		return err;
 	}
 
-	pinfo->enabled = false;
-
 	return 0;
 }
 
@@ -105,9 +97,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int err;
 
-	if (!pinfo->prepared)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(pinfo->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
@@ -121,8 +110,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 
 	disable_gpios(pinfo);
 
-	pinfo->prepared = false;
-
 	return 0;
 }
 
@@ -131,9 +118,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int err;
 
-	if (pinfo->prepared)
-		return 0;
-
 	gpiod_set_value(pinfo->pp18_gpio, 1);
 	/* T1: 5ms - 6ms */
 	usleep_range(5000, 6000);
@@ -180,8 +164,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	/* T7: 20ms - 21ms */
 	usleep_range(20000, 21000);
 
-	pinfo->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -194,9 +176,6 @@ static int boe_panel_enable(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int ret;
 
-	if (pinfo->enabled)
-		return 0;
-
 	usleep_range(120000, 121000);
 
 	ret = mipi_dsi_dcs_set_display_on(pinfo->link);
@@ -205,8 +184,6 @@ static int boe_panel_enable(struct drm_panel *panel)
 		return ret;
 	}
 
-	pinfo->enabled = true;
-
 	return 0;
 }
 
@@ -917,11 +894,11 @@ static void panel_remove(struct mipi_dsi_device *dsi)
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	err = boe_panel_disable(&pinfo->base);
+	err = drm_panel_disable(&pinfo->base);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
 
-	err = boe_panel_unprepare(&pinfo->base);
+	err = drm_panel_unprepare(&pinfo->base);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
 
@@ -936,8 +913,8 @@ static void panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
 
-	boe_panel_disable(&pinfo->base);
-	boe_panel_unprepare(&pinfo->base);
+	drm_panel_disable(&pinfo->base);
+	drm_panel_unprepare(&pinfo->base);
 }
 
 static struct mipi_dsi_driver panel_driver = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


