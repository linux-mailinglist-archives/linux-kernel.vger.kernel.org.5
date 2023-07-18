Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6529758311
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjGRQ4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjGRQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:55:07 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FB1BE9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:54:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5803:2d6d:5bbc:e252])
        by michel.telenet-ops.be with bizsmtp
        id Ngur2A00H0ucMBo06gurXL; Tue, 18 Jul 2023 18:54:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyD-001nYs-Ed;
        Tue, 18 Jul 2023 18:54:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qLnyN-000gcr-Fk;
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 22/41] drm: renesas: shmobile: Replace .dev_private with container_of()
Date:   Tue, 18 Jul 2023 18:54:27 +0200
Message-Id: <7754103c9ee06bd89fc78677e1646a5db1d1c828.1689698048.git.geert+renesas@glider.be>
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

Now that drm_device is embedded in shmob_drm_device, we can use
a container_of()-based helper to get the shmob_drm_device pointer from
the drm_device, instead of using the deprecated drm_device.dev_private
field.

While at it, restore reverse Xmas tree ordering of local variable
declarations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
v2:
  - Add Reviewed-by.
---
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 20 +++++++++----------
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  4 +---
 .../gpu/drm/renesas/shmobile/shmob_drm_drv.h  |  5 +++++
 .../drm/renesas/shmobile/shmob_drm_plane.c    |  6 +++---
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 207fa98fe76d6f88..f62ae047a48f615b 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -40,7 +40,7 @@
 static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
 {
 	struct drm_crtc *crtc = &scrtc->crtc;
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 	const struct shmob_drm_interface_data *idata = &sdev->pdata->iface;
 	const struct drm_display_mode *mode = &crtc->mode;
 	u32 value;
@@ -79,7 +79,7 @@ static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
 
 static void shmob_drm_crtc_start_stop(struct shmob_drm_crtc *scrtc, bool start)
 {
-	struct shmob_drm_device *sdev = scrtc->crtc.dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(scrtc->crtc.dev);
 	u32 value;
 
 	value = lcdc_read(sdev, LDCNT2R);
@@ -113,7 +113,7 @@ static void shmob_drm_crtc_start_stop(struct shmob_drm_crtc *scrtc, bool start)
 static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 {
 	struct drm_crtc *crtc = &scrtc->crtc;
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 	const struct shmob_drm_interface_data *idata = &sdev->pdata->iface;
 	const struct shmob_drm_format_info *format;
 	struct drm_device *dev = &sdev->ddev;
@@ -193,7 +193,7 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
 static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
 {
 	struct drm_crtc *crtc = &scrtc->crtc;
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 
 	if (!scrtc->started)
 		return;
@@ -247,7 +247,7 @@ static void shmob_drm_crtc_compute_base(struct shmob_drm_crtc *scrtc,
 static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
 {
 	struct drm_crtc *crtc = &scrtc->crtc;
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 
 	shmob_drm_crtc_compute_base(scrtc, crtc->x, crtc->y);
 
@@ -289,8 +289,8 @@ static int shmob_drm_crtc_mode_set(struct drm_crtc *crtc,
 				   int x, int y,
 				   struct drm_framebuffer *old_fb)
 {
+	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
 	const struct shmob_drm_format_info *format;
 
 	format = shmob_drm_format_info(crtc->primary->fb->format->format);
@@ -395,7 +395,7 @@ static void shmob_drm_crtc_enable_vblank(struct shmob_drm_device *sdev,
 
 static int shmob_drm_enable_vblank(struct drm_crtc *crtc)
 {
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 
 	shmob_drm_crtc_enable_vblank(sdev, true);
 
@@ -404,7 +404,7 @@ static int shmob_drm_enable_vblank(struct drm_crtc *crtc)
 
 static void shmob_drm_disable_vblank(struct drm_crtc *crtc)
 {
-	struct shmob_drm_device *sdev = crtc->dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
 
 	shmob_drm_crtc_enable_vblank(sdev, false);
 }
@@ -478,7 +478,7 @@ static bool shmob_drm_encoder_mode_fixup(struct drm_encoder *encoder,
 					 struct drm_display_mode *adjusted_mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct shmob_drm_device *sdev = dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(dev);
 	struct drm_connector *connector = &sdev->connector.connector;
 	const struct drm_display_mode *panel_mode;
 
@@ -548,7 +548,7 @@ static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connecto
 
 static int shmob_drm_connector_get_modes(struct drm_connector *connector)
 {
-	struct shmob_drm_device *sdev = connector->dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(connector->dev);
 	struct drm_display_mode *mode;
 
 	mode = drm_mode_create(connector->dev);
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
index 3f40ebb96747d1e7..c9ac8a86a7c39097 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
@@ -95,7 +95,7 @@ static int shmob_drm_setup_clocks(struct shmob_drm_device *sdev,
 static irqreturn_t shmob_drm_irq(int irq, void *arg)
 {
 	struct drm_device *dev = arg;
-	struct shmob_drm_device *sdev = dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(dev);
 	unsigned long flags;
 	u32 status;
 
@@ -244,8 +244,6 @@ static int shmob_drm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ddev->dev_private = sdev;
-
 	ret = shmob_drm_modeset_init(sdev);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
index 77bb0da48f37ace8..5e55ba7a207865bd 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
@@ -39,4 +39,9 @@ struct shmob_drm_device {
 	struct shmob_drm_connector connector;
 };
 
+static inline struct shmob_drm_device *to_shmob_device(struct drm_device *dev)
+{
+	return container_of(dev, struct shmob_drm_device, ddev);
+}
+
 #endif /* __SHMOB_DRM_DRV_H__ */
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 258288c80756bf16..c58b9dca34736342 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -63,7 +63,7 @@ static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
 static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
 				    struct drm_framebuffer *fb)
 {
-	struct shmob_drm_device *sdev = splane->plane.dev->dev_private;
+	struct shmob_drm_device *sdev = to_shmob_device(splane->plane.dev);
 	u32 format;
 
 	/* TODO: Support ROP3 mode */
@@ -135,8 +135,8 @@ shmob_drm_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
 		       uint32_t src_w, uint32_t src_h,
 		       struct drm_modeset_acquire_ctx *ctx)
 {
+	struct shmob_drm_device *sdev = to_shmob_device(plane->dev);
 	struct shmob_drm_plane *splane = to_shmob_plane(plane);
-	struct shmob_drm_device *sdev = plane->dev->dev_private;
 	const struct shmob_drm_format_info *format;
 
 	format = shmob_drm_format_info(fb->format->format);
@@ -167,8 +167,8 @@ shmob_drm_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
 static int shmob_drm_plane_disable(struct drm_plane *plane,
 				   struct drm_modeset_acquire_ctx *ctx)
 {
+	struct shmob_drm_device *sdev = to_shmob_device(plane->dev);
 	struct shmob_drm_plane *splane = to_shmob_plane(plane);
-	struct shmob_drm_device *sdev = plane->dev->dev_private;
 
 	splane->format = NULL;
 
-- 
2.34.1

