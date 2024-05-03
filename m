Return-Path: <linux-kernel+bounces-168266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F02A8BB5FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21331C23F8E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEED58AA5;
	Fri,  3 May 2024 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iul2cwdk"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EE4CDE0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772193; cv=none; b=USU+nUGyWBwU+/VX80Vu/34Aq4r43RcLVexkJGRl9rY87Jdr4BfTcRk42C3WatUw3iSJnfoymwU+eFvZZFZNzgkGpzxUySbOKhKo3rOWle7AYhiHExPUQZKPz6ppf/N1/oTwX3dUpNZJ21BTNB4yVMbQIfl4kuj0TH9MiABMvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772193; c=relaxed/simple;
	bh=Q15hSl0ME/9Le3lQp5qt508gFauIS2SVi1eec97Q8Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQnWgifxO0AzEiL4ccM7MzHc1Sh5cSpPcrte7WePg4WvUEjMVlggTyGjp9AkZY9cIvsOURoPMKwFEjZnqhjrFO/VzdFwbZKpRVydwXMfPFK6ZvVf+ESFaEBYtQiu+b2vSmekUh+wE6eUHm5s5aIxPtnEC6tulNrR+THrYCxbdJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iul2cwdk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ecd9a81966so16285035ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772191; x=1715376991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivwzpk8LV8o9VOgpaEI0wSikxdx7Ris0rIA4UDrHOxM=;
        b=iul2cwdk5cKHvoCx0SxDgSHT1w/ZgAsGpy/V6uL4ePriVeseLMuXrjyLvKbEJeBZ6y
         8qwOXzi8NeHpf7brGwzGn3JS+84yh90ko1PIHbEgg7SdPm7JK0R4BU1urH+OHFfLDHDB
         +mZ+UIrNccLZ86hfOejHAJl/Z1ZAWuKLR5vx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772191; x=1715376991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivwzpk8LV8o9VOgpaEI0wSikxdx7Ris0rIA4UDrHOxM=;
        b=SRwzMDxqqjBJ3Mcn/66E/6Hnf78QBlm94F46ZinXxv5cAprNFVk7upVpBb8FdzEn/Y
         dox0RyZbs+cWhQ4yjkGUszPTRIUpMCcDz806X9MOBt7p4Q9swnsYGjmWmrJHnw9W5XJO
         y4RJw8OkjOJmJOZDnHS9nYn1obsfiZ+UIg8lesl7w4LD+BBqohJspiahYRS172Mu859t
         pN8JDXzN8Gl6zLB6+YcbNLjVc0ms4/Gu+U0/tQjPmpJW0otvS5ORmoC7uWU+FPjzck49
         UzZKUvlSFQmhqBW8uMIuOGNQ4C9eZGNBImjfAvQgBcQPb/jF4VpKV9GocRfxh6elWFda
         JrLg==
X-Forwarded-Encrypted: i=1; AJvYcCXaVsqUN7IsCtlCM0bKlC5lokB6+TWCK+YcycxW+NO58wyymfip8Of1x997Q0zM6pNDIQEAY4SK+aot96V14me2crYp5n9DaI4qMwbm
X-Gm-Message-State: AOJu0YxjjuE1BBBKxKVCaiCRBmOjfnzjhmzn6mequqlvqRLksYCSAp6a
	fFwJtymcUWIL/xyyuZkArZHyVgD08uwafYKxXueh5dir/eJKBj9Otl3FyGoyYA==
X-Google-Smtp-Source: AGHT+IEhtQwHX90SwQBe2NnOXhamncltrhxwpD6fYsYZstR87YJRnxBbL7AN6shwzv3NIn/AynD71A==
X-Received: by 2002:a17:902:d093:b0:1e0:a2cf:62e8 with SMTP id v19-20020a170902d09300b001e0a2cf62e8mr6761839plv.10.1714772190912;
        Fri, 03 May 2024 14:36:30 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:30 -0700 (PDT)
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
Subject: [RFT PATCH v2 03/48] drm/panel: boe-himax8279d: Don't call unprepare+disable at shutdown/remove
Date: Fri,  3 May 2024 14:32:44 -0700
Message-ID: <20240503143327.RFT.v2.3.I19086c524d38f28f746befe85cb39ffda9d2f666@changeid>
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

Cc: Jerry Han <jerry.han.hq@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rock Wang <rock_wang@himax.com.cn>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-boe-himax8279d.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index 12e14615298b..df746baae301 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -894,14 +894,6 @@ static void panel_remove(struct mipi_dsi_device *dsi)
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	err = drm_panel_disable(&pinfo->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
-
-	err = drm_panel_unprepare(&pinfo->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
-
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
@@ -909,14 +901,6 @@ static void panel_remove(struct mipi_dsi_device *dsi)
 	drm_panel_remove(&pinfo->base);
 }
 
-static void panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&pinfo->base);
-	drm_panel_unprepare(&pinfo->base);
-}
-
 static struct mipi_dsi_driver panel_driver = {
 	.driver = {
 		.name = "panel-boe-himax8279d",
@@ -924,7 +908,6 @@ static struct mipi_dsi_driver panel_driver = {
 	},
 	.probe = panel_probe,
 	.remove = panel_remove,
-	.shutdown = panel_shutdown,
 };
 module_mipi_dsi_driver(panel_driver);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


