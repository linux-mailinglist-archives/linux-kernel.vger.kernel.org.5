Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC27A4BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjIRPWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbjIRPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:21:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215E1991
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:18:14 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF2C466072FB;
        Mon, 18 Sep 2023 16:01:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695049263;
        bh=4sbRG2aeCSqvnQfdgkb5xEWF2nVPvL6FiYhQyfisGCs=;
        h=From:To:Cc:Subject:Date:From;
        b=END5yvqWkPZ6TqXEEb3QXDyd6O9kk91YYcp4YfsHXOlfLL2esJhHnj4mo2svnZAKh
         wuR4OX6AGy7TOK3B+yAQ0vS13HNbM7lzqPC1U2fjYOFy+VrUa+ZQvJOx1LFPuHXbjc
         STDCAValnQVetcP6Ak8ZN6xop3bSG9fiUqhFX7rOReGAW40nGEIwU1AOPZMZLy1dCF
         vXZPbGbAo5CvaD4xQL3hFQD0gGHHV0jsbej1Lv1OgxbTkm6Lpngo7qi1A607Coc1B3
         Ps9gTBi/PCQBarc4wFN8GHr2VyxbqkJ6fKHlRSSeIVAqvEehbHSlYXff8MJUcxUs0F
         zy11qj6g+LheA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     andrzej.hajda@intel.com
Cc:     neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        ulf.hansson@linaro.org, victor.liu@nxp.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, ehristev@collabora.com, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] drm/bridge: panel: Fix device link for DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date:   Mon, 18 Sep 2023 17:00:43 +0200
Message-ID: <20230918150043.403250-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When external bridges are attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR,
the panel bridge may also get the same flag, but in the .attach()
callback for the panel bridge a device link is added only when this
flag is not present; To make things worse, the .detach() callback
tries to delete the device link unconditionally and without checking
if it was created in the first place, crashing the kernel with a NULL
pointer kernel panic upon calling panel_bridge_detach().

Fix that by moving the device_link_add() call before checking if the
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is present.

Fixes: 199cf07ebd2b ("drm/bridge: panel: Add a device link between drm device and panel device")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/bridge/panel.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index e00d2e94c751..8c507dfd589e 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -67,14 +67,6 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 	struct drm_device *drm_dev = bridge->dev;
 	int ret;
 
-	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
-		return 0;
-
-	if (!bridge->encoder) {
-		DRM_ERROR("Missing encoder\n");
-		return -ENODEV;
-	}
-
 	panel_bridge->link = device_link_add(drm_dev->dev, panel->dev,
 					     DL_FLAG_STATELESS);
 	if (!panel_bridge->link) {
@@ -83,6 +75,14 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
+	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+		return 0;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Missing encoder\n");
+		return -ENODEV;
+	}
+
 	drm_connector_helper_add(connector,
 				 &panel_bridge_connector_helper_funcs);
 
-- 
2.42.0

