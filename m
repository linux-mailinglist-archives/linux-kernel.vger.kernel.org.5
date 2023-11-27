Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52067FAE33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjK0XKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjK0XKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:10:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F881B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso6963417e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701126627; x=1701731427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSqQHdm2tAnngdZ4T3GO4w4i+AkvfcnW67KysvUoiKg=;
        b=dHD7bPBaH7NU+fOpaDm8oUT6sq5ZpHWqDkpNa1MpYPYt653Vzv7IYc8uHutaqdBeOc
         80KxxgCCrMzuAp5cx8aULqNFPMpbKuQ/ffR9MHrTOzApAen9qU4FooCIKNSrljEl6G9A
         Z277H8IAoTgn6IwDKaEVqiL2qGlP+NmVGpJ2L3PrhqC0IZYkq7Izlc+aXnssZ3piosng
         YGmqLz4QqJoHANkUw1+XPMBEHwAwZsH+lXWuzHP1dNd9lDZ4DToTG6RMcZP9io0AkGr8
         xO/ErFRnV5ojxYLrAbCeEjGxyVFUH8fCkVxUSEVQsQqGoQnKcA2EkZKXtrQhGT7nrpnC
         RVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701126627; x=1701731427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSqQHdm2tAnngdZ4T3GO4w4i+AkvfcnW67KysvUoiKg=;
        b=ZM4iaG5EyMg0Y6pXKSrgZRwqK3LXlbmRuEfO9Yts9hIC2SGmdS26gX9wPdieQ+4mNe
         iZ/zVpcDfTnRlItl8PkdTWxzLzKAOl3uydGVowNKKV9XT12PfiJK++sItipLhpM5S97A
         AQ9niSr+7zfX1cTR0mwW5gwpg3noaz99XL8HOSTqikU2GwERbbq5tvJynF+0aUrt2sqE
         Fz6AE6c3afO3NfLz6xPiYz9ysz5eoFbuIhKjwDqwp+938kzjidDrzU3N6SsVYCA5aGmb
         r1ILUiUUIbYg9KBSJZgeBqQE+xCqea86r8tGGzOeHsmh8S/CdodqgqivlboDdxEqMQJT
         mKiQ==
X-Gm-Message-State: AOJu0YxvcCUWFFEntpQFZlTeApq3TH0IvPIiMr/6eg2IucNtuFtqNtnG
        dGj6Tm8GC7OB06Pxzi+YoBTjpQ==
X-Google-Smtp-Source: AGHT+IEIaVbkz/Qqn3PYVmMWBo7MTr0rs45ISGfiLxrUqq0lGxY5f9yvJf3revevuWpDGFC2mqL8pg==
X-Received: by 2002:a05:6512:20c2:b0:507:b911:6706 with SMTP id u2-20020a05651220c200b00507b9116706mr6914486lfr.25.1701126627002;
        Mon, 27 Nov 2023 15:10:27 -0800 (PST)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id cf17-20020a056512281100b0050aa94e6d15sm1636877lfb.9.2023.11.27.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:10:26 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 00:10:20 +0100
Subject: [PATCH 2/3] Revert "drm/bridge: panel: Check device dependency
 before managing device link"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-revert-panel-fix-v1-2-69bb05048dae@linaro.org>
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
In-Reply-To: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
To:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 39d5b6a64ace77d0c11c398d272218df5f939abb.

This patch was causing build errors by using an unexported
function from the device core, which Greg questions the
saneness in exporting.

Link: https://lore.kernel.org/lkml/CACRpkdaGzXD6HbiX7mVUNJAJtMEPG00Pp6+nJ1P0JrfJ-ArMvQ@mail.gmail.com/T/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/bridge/panel.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 5e8980023407..e48823a4f1ed 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -23,7 +23,6 @@ struct panel_bridge {
 	struct drm_panel *panel;
 	struct device_link *link;
 	u32 connector_type;
-	bool is_independent;
 };
 
 static inline struct panel_bridge *
@@ -68,17 +67,12 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 	struct drm_device *drm_dev = bridge->dev;
 	int ret;
 
-	panel_bridge->is_independent = !device_is_dependent(drm_dev->dev,
-							    panel->dev);
-
-	if (panel_bridge->is_independent) {
-		panel_bridge->link = device_link_add(drm_dev->dev, panel->dev,
-						     DL_FLAG_STATELESS);
-		if (!panel_bridge->link) {
-			DRM_ERROR("Failed to add device link between %s and %s\n",
-				  dev_name(drm_dev->dev), dev_name(panel->dev));
-			return -EINVAL;
-		}
+	panel_bridge->link = device_link_add(drm_dev->dev, panel->dev,
+					     DL_FLAG_STATELESS);
+	if (!panel_bridge->link) {
+		DRM_ERROR("Failed to add device link between %s and %s\n",
+			  dev_name(drm_dev->dev), dev_name(panel->dev));
+		return -EINVAL;
 	}
 
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
@@ -86,8 +80,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 	if (!bridge->encoder) {
 		DRM_ERROR("Missing encoder\n");
-		if (panel_bridge->is_independent)
-			device_link_del(panel_bridge->link);
+		device_link_del(panel_bridge->link);
 		return -ENODEV;
 	}
 
@@ -99,8 +92,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 				 panel_bridge->connector_type);
 	if (ret) {
 		DRM_ERROR("Failed to initialize connector\n");
-		if (panel_bridge->is_independent)
-			device_link_del(panel_bridge->link);
+		device_link_del(panel_bridge->link);
 		return ret;
 	}
 
@@ -123,8 +115,7 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 	struct drm_connector *connector = &panel_bridge->connector;
 
-	if (panel_bridge->is_independent)
-		device_link_del(panel_bridge->link);
+	device_link_del(panel_bridge->link);
 
 	/*
 	 * Cleanup the connector if we know it was initialized.

-- 
2.41.0

