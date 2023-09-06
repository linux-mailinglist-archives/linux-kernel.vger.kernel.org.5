Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1F7935AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbjIFGvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbjIFGvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:51:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB7E43
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:51:34 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1493BE45;
        Wed,  6 Sep 2023 08:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693983006;
        bh=0EfCziQEtPenXwyT1aCWHhnZx/9dexcT0cb02lmSlQ8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=k6OPqb3EDSMp4nQsQvwfJaDOE/R3Kivr3zIgmeV9WpANteiuN58i6p5lYEJyp6iQz
         2W3bg0O7vSF6LPRttb0cuxnsGc3PzaIP8miew8hT0x0R1/XqpyAbOUSk/niaKZLy+x
         OmJfXzu3icIYqfUlzN/Ckr20pdmZ0xguLrWcbmvo=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 06 Sep 2023 09:50:53 +0300
Subject: [PATCH v4 06/12] drm/bridge: tc358768: Use struct videomode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-tc358768-v4-6-31725f008a50@ideasonboard.com>
References: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
In-Reply-To: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4918;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=0EfCziQEtPenXwyT1aCWHhnZx/9dexcT0cb02lmSlQ8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk+CFpdH13kZ3Wf268UMnIvO0bawwfhCfufAhBD
 vsl4N4ZIP2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZPghaQAKCRD6PaqMvJYe
 9SN7EACdAE5aR2Auv41Qn6lTE5jPJYA8cPXorWaA0rjhXibrJNsEger62b/PA7lOYacpOmBHhBA
 SdR3wjZx4vuE19TCMRQ+XD4HWFDoqfCKMQ1dFiDxTu67dx2B3iwcKH+zCu3KGIYW6CaUHhSj/Ck
 THwyAkXjgvo2p84Yt1ioJP/cRgZkYq7sNWVPTh2iqHMwM63Pu7m/fOQQ9RpQK7nMY+bt7lz73Ux
 2p73lBVin45wgmsMYInFok1SbGS3PN9vESs9+EtVBvG7WsiGVi0y+Wdqxfk2FJx2ll7OHF8DOE5
 +pB/+B+oizIEwk9OwV+TmR3dm2X29v2LN71DT3IFdTb2gFYD5CKnuZzno9rdlJ+VM3qkRvc/+pS
 STt9qG+iq2SOHoEZg0s7Ib5uSJB0JWEeVMe/zvzW9uhJtrFrElwwdZvcDAP4CbrQPOzxOMHwE3J
 VgKAMj+SKT8yEHpN9j0FqZ5lQvFAapBSoWgMgFiGvVfqrk8Zg+0/3GEepH0GrpX9tNlUgLd/i7i
 /vzLDzQk9qTOqDmFQWeHZM3BcIjpw1EhGARC3e/F8w3ySeHoLCK8OUxdyN6OAEhNQ8Og+OVP//h
 lKeLekUdFHyG9N9EXCArCPhtlPNdeJw2CKwxhRL1IEFiwoH37dvEI42NRmcpl7tU5eUjP3Hwock
 +8WbGMKGfvVcffQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TC358768 documentation uses HFP, HBP, etc. values to deal with the
video mode, while the driver currently uses the DRM display mode
(htotal, hsync_start, etc).

Change the driver to convert the DRM display mode to struct videomode,
which then allows us to use the same units the documentation uses. This
makes it much easier to work on the code when using the TC358768
documentation as a reference.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 45 +++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index a465674f1e2e..b98c517c4726 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -650,6 +650,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	u32 dsiclk, dsibclk, video_start;
 	const u32 internal_delay = 40;
 	int ret, i;
+	struct videomode vm;
 
 	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
 		dev_warn_once(priv->dev, "Non-continuous mode unimplemented, falling back to continuous\n");
@@ -673,6 +674,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		return;
 	}
 
+	drm_display_mode_to_videomode(mode, &vm);
+
 	dsiclk = priv->dsiclk;
 	dsibclk = dsiclk / 4;
 
@@ -681,28 +684,28 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	switch (dsi_dev->format) {
 	case MIPI_DSI_FMT_RGB888:
 		val |= (0x3 << 4);
-		hact = mode->hdisplay * 3;
-		video_start = (mode->htotal - mode->hsync_start) * 3;
+		hact = vm.hactive * 3;
+		video_start = (vm.hsync_len + vm.hback_porch) * 3;
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
 		break;
 	case MIPI_DSI_FMT_RGB666:
 		val |= (0x4 << 4);
-		hact = mode->hdisplay * 3;
-		video_start = (mode->htotal - mode->hsync_start) * 3;
+		hact = vm.hactive * 3;
+		video_start = (vm.hsync_len + vm.hback_porch) * 3;
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
 		break;
 
 	case MIPI_DSI_FMT_RGB666_PACKED:
 		val |= (0x4 << 4) | BIT(3);
-		hact = mode->hdisplay * 18 / 8;
-		video_start = (mode->htotal - mode->hsync_start) * 18 / 8;
+		hact = vm.hactive * 18 / 8;
+		video_start = (vm.hsync_len + vm.hback_porch) * 18 / 8;
 		data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
 		break;
 
 	case MIPI_DSI_FMT_RGB565:
 		val |= (0x5 << 4);
-		hact = mode->hdisplay * 2;
-		video_start = (mode->htotal - mode->hsync_start) * 2;
+		hact = vm.hactive * 2;
+		video_start = (vm.hsync_len + vm.hback_porch) * 2;
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		break;
 	default:
@@ -814,43 +817,43 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		tc358768_write(priv, TC358768_DSI_EVENT, 0);
 
 		/* vact */
-		tc358768_write(priv, TC358768_DSI_VACT, mode->vdisplay);
+		tc358768_write(priv, TC358768_DSI_VACT, vm.vactive);
 
 		/* vsw */
-		tc358768_write(priv, TC358768_DSI_VSW,
-			       mode->vsync_end - mode->vsync_start);
+		tc358768_write(priv, TC358768_DSI_VSW, vm.vsync_len);
+
 		/* vbp */
-		tc358768_write(priv, TC358768_DSI_VBPR,
-			       mode->vtotal - mode->vsync_end);
+		tc358768_write(priv, TC358768_DSI_VBPR, vm.vback_porch);
 
 		/* hsw * byteclk * ndl / pclk */
-		val = (u32)div_u64((mode->hsync_end - mode->hsync_start) *
+		val = (u32)div_u64(vm.hsync_len *
 				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
-				   mode->clock * 1000);
+				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HSW, val);
 
 		/* hbp * byteclk * ndl / pclk */
-		val = (u32)div_u64((mode->htotal - mode->hsync_end) *
+		val = (u32)div_u64(vm.hback_porch *
 				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
-				   mode->clock * 1000);
+				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HBPR, val);
 	} else {
 		/* Set event mode */
 		tc358768_write(priv, TC358768_DSI_EVENT, 1);
 
 		/* vact */
-		tc358768_write(priv, TC358768_DSI_VACT, mode->vdisplay);
+		tc358768_write(priv, TC358768_DSI_VACT, vm.vactive);
 
 		/* vsw (+ vbp) */
 		tc358768_write(priv, TC358768_DSI_VSW,
-			       mode->vtotal - mode->vsync_start);
+			       vm.vsync_len + vm.vback_porch);
+
 		/* vbp (not used in event mode) */
 		tc358768_write(priv, TC358768_DSI_VBPR, 0);
 
 		/* (hsw + hbp) * byteclk * ndl / pclk */
-		val = (u32)div_u64((mode->htotal - mode->hsync_start) *
+		val = (u32)div_u64((vm.hsync_len + vm.hback_porch) *
 				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
-				   mode->clock * 1000);
+				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HSW, val);
 
 		/* hbp (not used in event mode) */

-- 
2.34.1

