Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CFF7A75DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjITI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:27:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F790
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:27:45 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BEBF66003AF;
        Wed, 20 Sep 2023 09:27:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695198464;
        bh=DbWGcn6zI7FsJFEu+IPzpjZSXjvXMMCEXJn4aXMt218=;
        h=From:To:Cc:Subject:Date:From;
        b=lV+NRHy9R1DzJrhNmu1OqK8DVNExlmtN2Vphj8vkfm0JReVuaE7FnjRtc426NmVX+
         SdgJ+NECW6+yMTwVSZSsxZ8L6CR7B9Gl5VpQXzEJVJnLlKZJUTVZQNOhJeIrOLV49j
         rM8tmDngAf9gWgQRNHQhc+yHVrrzPiJfkTAEEmM/Mq9v2BbVEnnA64THsYqIb2noPd
         UfFVxgJbixYUadcOwmP1mZZd2ROlztvXAG459sgYKS1Bpf7Aa11vIl9c4Lm0h1d2gn
         7IIKSvRXMJ03nsbgTA1xRBZuPtJKfgoLWQhrYw19K6ARmQ4ASh3CwYA5CxVWpOOz9h
         WA+Nvw+IC9uBA==
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
Subject: [PATCH v2] drm/bridge: panel: Fix device link for DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date:   Wed, 20 Sep 2023 10:27:27 +0200
Message-ID: <20230920082727.57729-1-angelogioacchino.delregno@collabora.com>
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

Changes in v2:
 - Added device_link_del() for (!bridge->encoder) error condition

 drivers/gpu/drm/bridge/panel.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index e00d2e94c751..e48823a4f1ed 100644
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
@@ -83,6 +75,15 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
+	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+		return 0;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Missing encoder\n");
+		device_link_del(panel_bridge->link);
+		return -ENODEV;
+	}
+
 	drm_connector_helper_add(connector,
 				 &panel_bridge_connector_helper_funcs);
 
-- 
2.42.0

