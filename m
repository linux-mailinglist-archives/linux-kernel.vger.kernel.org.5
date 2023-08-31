Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0578E7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbjHaIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbjHaIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:10:24 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B35E0E7F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:10:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,216,1688396400"; 
   d="scan'208";a="174580076"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Aug 2023 17:10:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F07CA4010DFB;
        Thu, 31 Aug 2023 17:09:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Zhu Wang <wangzhu9@huawei.com>,
        =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        Rob Herring <robh@kernel.org>, Sandor Yu <Sandor.yu@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 3/4] drm/bridge: Drop CONFIG_OF conditionals around of_node pointers
Date:   Thu, 31 Aug 2023 09:09:37 +0100
Message-Id: <20230831080938.47454-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having conditional around the of_node pointers turns out to make driver
code use ugly #ifdef and #if blocks. So drop the conditionals.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v5->v6:
 * Added Rb tag from Douglas Anderson.
 * Dropped conditionals from remaining drm/bridge drivers.
v5:
 * Split from patch#2
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 2 --
 drivers/gpu/drm/bridge/panel.c                     | 2 --
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 2 --
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      | 2 --
 4 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 6169db73d2fe..ad8241758896 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -1231,9 +1231,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client)
 
 	mutex_init(&anx78xx->lock);
 
-#if IS_ENABLED(CONFIG_OF)
 	anx78xx->bridge.of_node = client->dev.of_node;
-#endif
 
 	anx78xx->client = client;
 	i2c_set_clientdata(client, anx78xx);
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 9316384b4474..7f41525f7a6e 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -302,9 +302,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 	panel_bridge->panel = panel;
 
 	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
-#ifdef CONFIG_OF
 	panel_bridge->bridge.of_node = panel->dev->of_node;
-#endif
 	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
 	panel_bridge->bridge.type = connector_type;
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 6c1d79474505..52d91a0df85e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3541,9 +3541,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 			 | DRM_BRIDGE_OP_HPD;
 	hdmi->bridge.interlace_allowed = true;
 	hdmi->bridge.ddc = hdmi->ddc;
-#ifdef CONFIG_OF
 	hdmi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 04d4a1a10698..a8dd2a2e7c7b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1182,9 +1182,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 
 	dsi->bridge.driver_private = dsi;
 	dsi->bridge.funcs = &dw_mipi_dsi_bridge_funcs;
-#ifdef CONFIG_OF
 	dsi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	return dsi;
 }
-- 
2.25.1

