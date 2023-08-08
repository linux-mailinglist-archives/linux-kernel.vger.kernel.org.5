Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF17744DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjHHS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjHHS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:29:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 034EF25B22
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:45:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23AA411FB;
        Tue,  8 Aug 2023 07:02:46 -0700 (PDT)
Received: from debian.lan?044arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3973F3F64C;
        Tue,  8 Aug 2023 07:02:03 -0700 (PDT)
From:   Jon Mason <jon.mason@arm.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/fb-helper: move zeroing code to drm_fb_helper_fill_var
Date:   Tue,  8 Aug 2023 09:01:52 -0500
Message-Id: <20230808140152.3605346-1-jon.mason@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__fill_var is used by both drm_fb_helper_check_var and
drm_fb_helper_fill_var.  In drm_fb_helper_check_var, it is possible that
some of the variables in fb_info->var which are currently being zero'ed
have pre-existing values.  Zeroing these causes some fb tests to fail
with (from the Xorg.log):

[     9.897] (II) Module fbdevhw: vendor="X.Org Foundation"
[     9.897]    compiled for 1.21.1.8, module version = 0.0.2
[     9.897]    ABI class: X.Org Video Driver, version 25.2
[     9.898] (II) FBDEV(0): using default device
[     9.901] (==) FBDEV(0): Depth 24, (==) framebuffer bpp 32
[     9.902] (==) FBDEV(0): RGB weight 888
[     9.902] (==) FBDEV(0): Default visual is TrueColor
[     9.902] (==) FBDEV(0): Using gamma correction (1.0, 1.0, 1.0)
[     9.902] (II) FBDEV(0): hardware: virtio_gpudrmfb (video memory:
4000kB)
[     9.902] (DB) xf86MergeOutputClassOptions unsupported bus type 0
[     9.903] (II) FBDEV(0): checking modes against framebuffer device...
[     9.904] (II) FBDEV(0):     mode "640x480" test failed
[     9.904] (II) FBDEV(0):     mode "640x480" test failed
[     9.904] (II) FBDEV(0):     mode "640x480" test failed
[     9.904] (II) FBDEV(0):     mode "640x480" test failed
[     9.904] (II) FBDEV(0):     mode "640x480" not found
[     9.904] (II) FBDEV(0): checking modes against monitor...
[     9.905] (II) FBDEV(0): Virtual size is 1280x800 (pitch 1280)
[     9.905] (**) FBDEV(0):  Built-in mode "current"
[     9.905] (==) FBDEV(0): DPI set to (96, 96)

Previously, these values were not modified.  Moving the zero'ing of the
variables to drm_fb_helper_fill_var resolves the issue.

Fixes: ee4cce0a8f03 ("drm/fb-helper: fix input validation gaps in check_var")
Signed-off-by: Jon Mason <jon.mason@arm.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 61a5d450cc20..8e1cba064a75 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1190,8 +1190,6 @@ static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
 static void __fill_var(struct fb_var_screeninfo *var, struct fb_info *info,
 		       struct drm_framebuffer *fb)
 {
-	int i;
-
 	var->xres_virtual = fb->width;
 	var->yres_virtual = fb->height;
 	var->accel_flags = 0;
@@ -1199,15 +1197,6 @@ static void __fill_var(struct fb_var_screeninfo *var, struct fb_info *info,
 
 	var->height = info->var.height;
 	var->width = info->var.width;
-
-	var->left_margin = var->right_margin = 0;
-	var->upper_margin = var->lower_margin = 0;
-	var->hsync_len = var->vsync_len = 0;
-	var->sync = var->vmode = 0;
-	var->rotate = 0;
-	var->colorspace = 0;
-	for (i = 0; i < 4; i++)
-		var->reserved[i] = 0;
 }
 
 /**
@@ -1701,6 +1690,7 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
 	const struct drm_format_info *format = fb->format;
+	int i;
 
 	switch (format->format) {
 	case DRM_FORMAT_C1:
@@ -1718,6 +1708,14 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
 	info->pseudo_palette = fb_helper->pseudo_palette;
 	info->var.xoffset = 0;
 	info->var.yoffset = 0;
+	info->var.left_margin = info->var.right_margin = 0;
+	info->var.upper_margin = info->var.lower_margin = 0;
+	info->var.hsync_len = info->var.vsync_len = 0;
+	info->var.sync = info->var.vmode = 0;
+	info->var.rotate = 0;
+	info->var.colorspace = 0;
+	for (i = 0; i < 4; i++)
+		info->var.reserved[i] = 0;
 	__fill_var(&info->var, info, fb);
 	info->var.activate = FB_ACTIVATE_NOW;
 
-- 
2.30.2

