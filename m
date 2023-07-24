Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7975FA89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGXPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:16:51 -0400
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 08:16:50 PDT
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0512F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:16:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E13DEBFAE9;
        Mon, 24 Jul 2023 17:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1690211807; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=IMigSv9byDtYWuiV7tdaUPxmriaCAFZ/avJIHWniWQU=;
        b=fsuxTw9q4KDwMJzKo+vcfreuXudubmmkbaOzhiDrk4yfV2KT94QvmVdxKC5sJRX35aoTy4
        BrbWDXABdyFLv2yHAtTq3XBgMM+ji6QwNZpmsHkL35Q00GJp7DvZ+qOAnhm5pn0Ey5jbbU
        jiNrKUXu9RhzLNHcDoZwZSBrIA8H8gtWUDFWZ8gEapPf/FNhwKfkJvHjMEa8PNt1joAgqt
        f9vXRWHER5Xt1CI0txACLGVzdCPBJdnQjmprBvpW8EKXVwIHZwJzDO6EejLe7Rx2eUB//b
        4wRXXnxW2oGanKws1MdhLekgG/2kTD48yU5A7Li6m9cyWPvwflZyxXARzt3Qow==
From:   Frieder Schrempf <frieder@fris.de>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH v2] drm: bridge: samsung-dsim: Fix init during host transfer
Date:   Mon, 24 Jul 2023 17:16:32 +0200
Message-ID: <20230724151640.555490-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

In case the downstream bridge or panel uses DSI transfers before the
DSI host was actually initialized through samsung_dsim_atomic_enable()
which clears the stop state (LP11) mode, all transfers will fail.

This happens with downstream bridges that are controlled by DSI
commands such as the tc358762.

As documented in [1] DSI hosts are expected to allow transfers
outside the normal bridge enable/disable flow.

To fix this make sure that stop state is cleared in
samsung_dsim_host_transfer() which restores the previous
behavior.

We also factor out the common code to enable/disable stop state
to samsung_dsim_set_stop_state().

[1] https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation

Fixes: 0c14d3130654 ("drm: bridge: samsung-dsim: Fix i.MX8M enable flow to meet spec")
Reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
  * Fix reversed stop state enable/disable in samsung_dsim_set_stop_state()

Hi Tim, could you please give this patch a try and report back if
it fixes your problem? Thanks!
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 043b8109e64a..73ec60757dbc 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1386,6 +1386,18 @@ static void samsung_dsim_disable_irq(struct samsung_dsim *dsi)
 	disable_irq(dsi->irq);
 }
 
+static void samsung_dsim_set_stop_state(struct samsung_dsim *dsi, bool enable)
+{
+	u32 reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
+
+	if (enable)
+		reg |= DSIM_FORCE_STOP_STATE;
+	else
+		reg &= ~DSIM_FORCE_STOP_STATE;
+
+	samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
+}
+
 static int samsung_dsim_init(struct samsung_dsim *dsi)
 {
 	const struct samsung_dsim_driver_data *driver_data = dsi->driver_data;
@@ -1445,15 +1457,12 @@ static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
 				       struct drm_bridge_state *old_bridge_state)
 {
 	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
-	u32 reg;
 
 	if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
 		samsung_dsim_set_display_mode(dsi);
 		samsung_dsim_set_display_enable(dsi, true);
 	} else {
-		reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
-		reg &= ~DSIM_FORCE_STOP_STATE;
-		samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
+		samsung_dsim_set_stop_state(dsi, false);
 	}
 
 	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
@@ -1463,16 +1472,12 @@ static void samsung_dsim_atomic_disable(struct drm_bridge *bridge,
 					struct drm_bridge_state *old_bridge_state)
 {
 	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
-	u32 reg;
 
 	if (!(dsi->state & DSIM_STATE_ENABLED))
 		return;
 
-	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
-		reg = samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
-		reg |= DSIM_FORCE_STOP_STATE;
-		samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
-	}
+	if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
+		samsung_dsim_set_stop_state(dsi, true);
 
 	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
 }
@@ -1775,6 +1780,8 @@ static ssize_t samsung_dsim_host_transfer(struct mipi_dsi_host *host,
 	if (ret)
 		return ret;
 
+	samsung_dsim_set_stop_state(dsi, false);
+
 	ret = mipi_dsi_create_packet(&xfer.packet, msg);
 	if (ret < 0)
 		return ret;
-- 
2.41.0

