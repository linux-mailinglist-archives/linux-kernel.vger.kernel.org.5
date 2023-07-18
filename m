Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53870758307
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjGRQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjGRQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:05 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2E819BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by laurent.telenet-ops.be with bizsmtp
        id Ngur2A0040ucMBo01gurj5; Tue, 18 Jul 2023 18:54:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nYC-8E;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gc4-9Q;
        Tue, 18 Jul 2023 18:54:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 12/41] drm: renesas: shmobile: Remove backlight support
Date:   Tue, 18 Jul 2023 18:54:17 +0200
Message-Id: <1577826904a186d982fe001fdc211397f7dddedf.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Backlight support should be implemented by panels, not by the LCDC
driver.  As the feature is currently unused anyway, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[geert: Cleanups]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2:
  - Add Reviewed-by.

Changes compared to Laurent's original:
  - Rebase,
  - Remove unused variable ‘scon’,
  - Remove now unused to_shmob_encoder() macro,
  - Remove now empty shmob_drm_encoder wrapper.
---
 drivers/gpu/drm/renesas/shmobile/Makefile     |  3 +-
 .../renesas/shmobile/shmob_drm_backlight.c    | 82 -------------------
 .../renesas/shmobile/shmob_drm_backlight.h    | 19 -----
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 33 +-------
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.h |  8 --
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.h  |  2 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_kms.c  |  2 +-
 include/linux/platform_data/shmob_drm.h       |  8 --
 8 files changed, 7 insertions(+), 150 deletions(-)
 delete mode 100644 drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c
 delete mode 100644 drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h

diff --git a/drivers/gpu/drm/renesas/shmobile/Makefile b/drivers/gpu/drm/renesas/shmobile/Makefile
index 861edafed8562c87..2679555d61a70207 100644
--- a/drivers/gpu/drm/renesas/shmobile/Makefile
+++ b/drivers/gpu/drm/renesas/shmobile/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-shmob-drm-y := shmob_drm_backlight.o \
-	       shmob_drm_crtc.o \
+shmob-drm-y := shmob_drm_crtc.o \
 	       shmob_drm_drv.o \
 	       shmob_drm_kms.o \
 	       shmob_drm_plane.o
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c
deleted file mode 100644
index 794573badfe86076..0000000000000000
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * shmob_drm_backlight.c  --  SH Mobile DRM Backlight
- *
- * Copyright (C) 2012 Renesas Electronics Corporation
- *
- * Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- */
-
-#include <linux/backlight.h>
-
-#include "shmob_drm_backlight.h"
-#include "shmob_drm_crtc.h"
-#include "shmob_drm_drv.h"
-
-static int shmob_drm_backlight_update(struct backlight_device *bdev)
-{
-	struct shmob_drm_connector *scon = bl_get_data(bdev);
-	struct shmob_drm_device *sdev = scon->connector.dev->dev_private;
-	const struct shmob_drm_backlight_data *bdata = &sdev->pdata->backlight;
-	int brightness = backlight_get_brightness(bdev);
-
-	return bdata->set_brightness(brightness);
-}
-
-static int shmob_drm_backlight_get_brightness(struct backlight_device *bdev)
-{
-	struct shmob_drm_connector *scon = bl_get_data(bdev);
-	struct shmob_drm_device *sdev = scon->connector.dev->dev_private;
-	const struct shmob_drm_backlight_data *bdata = &sdev->pdata->backlight;
-
-	return bdata->get_brightness();
-}
-
-static const struct backlight_ops shmob_drm_backlight_ops = {
-	.options	= BL_CORE_SUSPENDRESUME,
-	.update_status	= shmob_drm_backlight_update,
-	.get_brightness	= shmob_drm_backlight_get_brightness,
-};
-
-void shmob_drm_backlight_dpms(struct shmob_drm_connector *scon, int mode)
-{
-	if (scon->backlight == NULL)
-		return;
-
-	scon->backlight->props.power = mode == DRM_MODE_DPMS_ON
-				     ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
-	backlight_update_status(scon->backlight);
-}
-
-int shmob_drm_backlight_init(struct shmob_drm_connector *scon)
-{
-	struct shmob_drm_device *sdev = scon->connector.dev->dev_private;
-	const struct shmob_drm_backlight_data *bdata = &sdev->pdata->backlight;
-	struct drm_connector *connector = &scon->connector;
-	struct drm_device *dev = connector->dev;
-	struct backlight_device *backlight;
-
-	if (!bdata->max_brightness)
-		return 0;
-
-	backlight = backlight_device_register(bdata->name, dev->dev, scon,
-					      &shmob_drm_backlight_ops, NULL);
-	if (IS_ERR(backlight)) {
-		dev_err(dev->dev, "unable to register backlight device: %ld\n",
-			PTR_ERR(backlight));
-		return PTR_ERR(backlight);
-	}
-
-	backlight->props.max_brightness = bdata->max_brightness;
-	backlight->props.brightness = bdata->max_brightness;
-	backlight->props.power = FB_BLANK_POWERDOWN;
-	backlight_update_status(backlight);
-
-	scon->backlight = backlight;
-	return 0;
-}
-
-void shmob_drm_backlight_exit(struct shmob_drm_connector *scon)
-{
-	backlight_device_unregister(scon->backlight);
-}
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h
deleted file mode 100644
index d9abb7a60be5c414..0000000000000000
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * shmob_drm_backlight.h  --  SH Mobile DRM Backlight
- *
- * Copyright (C) 2012 Renesas Electronics Corporation
- *
- * Laurent Pinchart (laurent.pinchart@ideasonboard.com)
- */
-
-#ifndef __SHMOB_DRM_BACKLIGHT_H__
-#define __SHMOB_DRM_BACKLIGHT_H__
-
-struct shmob_drm_connector;
-
-void shmob_drm_backlight_dpms(struct shmob_drm_connector *scon, int mode);
-int shmob_drm_backlight_init(struct shmob_drm_connector *scon);
-void shmob_drm_backlight_exit(struct shmob_drm_connector *scon);
-
-#endif /* __SHMOB_DRM_BACKLIGHT_H__ */
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 2cdf8f9b06e5feb8..db9d8d440144db36 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -7,7 +7,6 @@
  * Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
-#include <linux/backlight.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 
@@ -24,7 +23,6 @@
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
-#include "shmob_drm_backlight.h"
 #include "shmob_drm_crtc.h"
 #include "shmob_drm_drv.h"
 #include "shmob_drm_kms.h"
@@ -487,21 +485,9 @@ int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
  * Encoder
  */
 
-#define to_shmob_encoder(e) \
-	container_of(e, struct shmob_drm_encoder, encoder)
-
 static void shmob_drm_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
-	struct shmob_drm_encoder *senc = to_shmob_encoder(encoder);
-	struct shmob_drm_device *sdev = encoder->dev->dev_private;
-	struct shmob_drm_connector *scon = &sdev->connector;
-
-	if (senc->dpms == mode)
-		return;
-
-	shmob_drm_backlight_dpms(scon, mode);
-
-	senc->dpms = mode;
+	/* No-op, everything is handled in the CRTC code. */
 }
 
 static bool shmob_drm_encoder_mode_fixup(struct drm_encoder *encoder,
@@ -553,11 +539,9 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 
 int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
 {
-	struct drm_encoder *encoder = &sdev->encoder.encoder;
+	struct drm_encoder *encoder = &sdev->encoder;
 	int ret;
 
-	sdev->encoder.dpms = DRM_MODE_DPMS_OFF;
-
 	encoder->possible_crtcs = 1;
 
 	ret = drm_simple_encoder_init(sdev->ddev, encoder,
@@ -622,9 +606,6 @@ static const struct drm_connector_helper_funcs connector_helper_funcs = {
 
 static void shmob_drm_connector_destroy(struct drm_connector *connector)
 {
-	struct shmob_drm_connector *scon = to_shmob_connector(connector);
-
-	shmob_drm_backlight_exit(scon);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 }
@@ -653,13 +634,9 @@ int shmob_drm_connector_create(struct shmob_drm_device *sdev,
 
 	drm_connector_helper_add(connector, &connector_helper_funcs);
 
-	ret = shmob_drm_backlight_init(&sdev->connector);
-	if (ret < 0)
-		goto err_cleanup;
-
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret < 0)
-		goto err_backlight;
+		goto error;
 
 	drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
 	drm_object_property_set_value(&connector->base,
@@ -667,9 +644,7 @@ int shmob_drm_connector_create(struct shmob_drm_device *sdev,
 
 	return 0;
 
-err_backlight:
-	shmob_drm_backlight_exit(&sdev->connector);
-err_cleanup:
+error:
 	drm_connector_cleanup(connector);
 	return ret;
 }
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
index 21718843f46d3d19..bce6926269453b77 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
@@ -14,7 +14,6 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_encoder.h>
 
-struct backlight_device;
 struct drm_pending_vblank_event;
 struct shmob_drm_device;
 struct shmob_drm_format_info;
@@ -31,16 +30,9 @@ struct shmob_drm_crtc {
 	bool started;
 };
 
-struct shmob_drm_encoder {
-	struct drm_encoder encoder;
-	int dpms;
-};
-
 struct shmob_drm_connector {
 	struct drm_connector connector;
 	struct drm_encoder *encoder;
-
-	struct backlight_device *backlight;
 };
 
 int shmob_drm_crtc_create(struct shmob_drm_device *sdev);
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
index 4964ddd5ab7472b0..16d830168b2ada21 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
@@ -35,7 +35,7 @@ struct shmob_drm_device {
 	struct drm_device *ddev;
 
 	struct shmob_drm_crtc crtc;
-	struct shmob_drm_encoder encoder;
+	struct drm_encoder encoder;
 	struct shmob_drm_connector connector;
 };
 
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
index 8fd360149743f8e2..3051318ddc7999bc 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
@@ -159,7 +159,7 @@ int shmob_drm_modeset_init(struct shmob_drm_device *sdev)
 
 	shmob_drm_crtc_create(sdev);
 	shmob_drm_encoder_create(sdev);
-	shmob_drm_connector_create(sdev, &sdev->encoder.encoder);
+	shmob_drm_connector_create(sdev, &sdev->encoder);
 
 	drm_kms_helper_poll_init(sdev->ddev);
 
diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index d661399b217dfc4b..b6b5b6607fb5e52c 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -40,13 +40,6 @@ enum shmob_drm_interface {
 	SHMOB_DRM_IFACE_SYS24,		/* 24bpp */
 };
 
-struct shmob_drm_backlight_data {
-	const char *name;
-	int max_brightness;
-	int (*get_brightness)(void);
-	int (*set_brightness)(int brightness);
-};
-
 struct shmob_drm_panel_data {
 	unsigned int width_mm;		/* Panel width in mm */
 	unsigned int height_mm;		/* Panel height in mm */
@@ -83,7 +76,6 @@ struct shmob_drm_platform_data {
 	enum shmob_drm_clk_source clk_source;
 	struct shmob_drm_interface_data iface;
 	struct shmob_drm_panel_data panel;
-	struct shmob_drm_backlight_data backlight;
 };
 
 #endif /* __SHMOB_DRM_H__ */
-- 
2.34.1

