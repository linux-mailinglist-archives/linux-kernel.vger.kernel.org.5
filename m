Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD137582AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjGRQzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGRQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:54:58 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD519B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:54 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by laurent.telenet-ops.be with bizsmtp
        id Ngur2A00A0ucMBo01gurj9; Tue, 18 Jul 2023 18:54:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nYw-FH;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gcw-GS;
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
Subject: [PATCH v2 23/41] drm: renesas: shmobile: Use struct videomode in platform data
Date:   Tue, 18 Jul 2023 18:54:28 +0200
Message-Id: <8b9676b675bcae39311421b7da8dc3e37fa5f0b8.1689698048.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689698048.git.geert+renesas@glider.be>
References: <cover.1689698048.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace the drm_mode_modeinfo field with videomode that includes more
signal polarity flags.  This simplifies driver handling of panel modes
and prepares for DT support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[geert: Simplify]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2:
  - Add Reviewed-by,
  - Select VIDEOMODE_HELPERS.

Changes compared to Laurent's original:
  - Rebase,
  - Fix build,
  - Remove unneeded {width,height}_mm intermediaries from
    shmob_drm_connector,
  - Replace embedded videomode by a const pointer to pdata.
---
 drivers/gpu/drm/renesas/shmobile/Kconfig      |  1 +
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 35 ++++++++-----------
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.h |  3 ++
 include/linux/platform_data/shmob_drm.h       | 11 ++----
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/Kconfig b/drivers/gpu/drm/renesas/shmobile/Kconfig
index ba941587ca70e08c..027220b8fe1c5fbd 100644
--- a/drivers/gpu/drm/renesas/shmobile/Kconfig
+++ b/drivers/gpu/drm/renesas/shmobile/Kconfig
@@ -6,6 +6,7 @@ config DRM_SHMOBILE
 	select BACKLIGHT_CLASS_DEVICE
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
+	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have an SH Mobile chipset.
 	  If M is selected the module will be called shmob-drm.
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index f62ae047a48f615b..b3ef10b7828de197 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -23,6 +23,8 @@
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
+#include <video/videomode.h>
+
 #include "shmob_drm_crtc.h"
 #include "shmob_drm_drv.h"
 #include "shmob_drm_kms.h"
@@ -41,18 +43,16 @@ static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
 {
 	struct drm_crtc *crtc = &scrtc->crtc;
 	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
-	const struct shmob_drm_interface_data *idata = &sdev->pdata->iface;
+	enum display_flags dpy_flags = sdev->connector.mode->flags;
 	const struct drm_display_mode *mode = &crtc->mode;
 	u32 value;
 
 	value = sdev->ldmt1r
 	      | ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : LDMT1R_VPOL)
 	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : LDMT1R_HPOL)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DWPOL) ? LDMT1R_DWPOL : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DIPOL) ? LDMT1R_DIPOL : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DAPOL) ? LDMT1R_DAPOL : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_HSCNT) ? LDMT1R_HSCNT : 0)
-	      | ((idata->flags & SHMOB_DRM_IFACE_FL_DWCNT) ? LDMT1R_DWCNT : 0);
+	      | ((dpy_flags & DISPLAY_FLAGS_PIXDATA_POSEDGE) ? LDMT1R_DWPOL : 0)
+	      | ((dpy_flags & DISPLAY_FLAGS_DE_LOW) ? LDMT1R_DIPOL : 0);
+
 	lcdc_write(sdev, LDMT1R, value);
 
 	value = ((mode->hdisplay / 8) << 16)			/* HDCN */
@@ -548,7 +548,7 @@ static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connecto
 
 static int shmob_drm_connector_get_modes(struct drm_connector *connector)
 {
-	struct shmob_drm_device *sdev = to_shmob_device(connector->dev);
+	struct shmob_drm_connector *scon = to_shmob_connector(connector);
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_create(connector->dev);
@@ -556,18 +556,9 @@ static int shmob_drm_connector_get_modes(struct drm_connector *connector)
 		return 0;
 
 	mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
-	mode->clock = sdev->pdata->panel.mode.clock;
-	mode->hdisplay = sdev->pdata->panel.mode.hdisplay;
-	mode->hsync_start = sdev->pdata->panel.mode.hsync_start;
-	mode->hsync_end = sdev->pdata->panel.mode.hsync_end;
-	mode->htotal = sdev->pdata->panel.mode.htotal;
-	mode->vdisplay = sdev->pdata->panel.mode.vdisplay;
-	mode->vsync_start = sdev->pdata->panel.mode.vsync_start;
-	mode->vsync_end = sdev->pdata->panel.mode.vsync_end;
-	mode->vtotal = sdev->pdata->panel.mode.vtotal;
-	mode->flags = sdev->pdata->panel.mode.flags;
-
-	drm_mode_set_name(mode);
+
+	drm_display_mode_from_videomode(scon->mode, mode);
+
 	drm_mode_probed_add(connector, mode);
 
 	return 1;
@@ -601,10 +592,12 @@ static const struct drm_connector_funcs connector_funcs = {
 int shmob_drm_connector_create(struct shmob_drm_device *sdev,
 			       struct drm_encoder *encoder)
 {
-	struct drm_connector *connector = &sdev->connector.connector;
+	struct shmob_drm_connector *scon = &sdev->connector;
+	struct drm_connector *connector = &scon->connector;
 	int ret;
 
-	sdev->connector.encoder = encoder;
+	scon->encoder = encoder;
+	scon->mode = &sdev->pdata->panel.mode;
 
 	connector->display_info.width_mm = sdev->pdata->panel.width_mm;
 	connector->display_info.height_mm = sdev->pdata->panel.height_mm;
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
index bce6926269453b77..f507eaf912e16a22 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
@@ -14,6 +14,8 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_encoder.h>
 
+#include <video/videomode.h>
+
 struct drm_pending_vblank_event;
 struct shmob_drm_device;
 struct shmob_drm_format_info;
@@ -33,6 +35,7 @@ struct shmob_drm_crtc {
 struct shmob_drm_connector {
 	struct drm_connector connector;
 	struct drm_encoder *encoder;
+	const struct videomode *mode;
 };
 
 int shmob_drm_crtc_create(struct shmob_drm_device *sdev);
diff --git a/include/linux/platform_data/shmob_drm.h b/include/linux/platform_data/shmob_drm.h
index b728e24222d99158..f3cb19ff9f818aca 100644
--- a/include/linux/platform_data/shmob_drm.h
+++ b/include/linux/platform_data/shmob_drm.h
@@ -10,7 +10,7 @@
 #ifndef __SHMOB_DRM_H__
 #define __SHMOB_DRM_H__
 
-#include <drm/drm_mode.h>
+#include <video/videomode.h>
 
 enum shmob_drm_clk_source {
 	SHMOB_DRM_CLK_BUS,
@@ -32,19 +32,12 @@ enum shmob_drm_interface {
 struct shmob_drm_panel_data {
 	unsigned int width_mm;		/* Panel width in mm */
 	unsigned int height_mm;		/* Panel height in mm */
-	struct drm_mode_modeinfo mode;
+	struct videomode mode;
 };
 
-#define SHMOB_DRM_IFACE_FL_DWPOL (1 << 0) /* Rising edge dot clock data latch */
-#define SHMOB_DRM_IFACE_FL_DIPOL (1 << 1) /* Active low display enable */
-#define SHMOB_DRM_IFACE_FL_DAPOL (1 << 2) /* Active low display data */
-#define SHMOB_DRM_IFACE_FL_HSCNT (1 << 3) /* Disable HSYNC during VBLANK */
-#define SHMOB_DRM_IFACE_FL_DWCNT (1 << 4) /* Disable dotclock during blanking */
-
 struct shmob_drm_interface_data {
 	enum shmob_drm_interface interface;
 	unsigned int clk_div;
-	unsigned int flags;
 };
 
 struct shmob_drm_platform_data {
-- 
2.34.1

