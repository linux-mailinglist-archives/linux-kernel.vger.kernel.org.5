Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440027873BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbjHXPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242148AbjHXPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:08:59 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276D1711
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:08:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3c6b:f703:5ab5:f36d])
        by laurent.telenet-ops.be with bizsmtp
        id dT8t2A00D01sfPQ01T8th5; Thu, 24 Aug 2023 17:08:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qZBwx-001dhP-Ip;
        Thu, 24 Aug 2023 17:08:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qZBx7-000Vz6-83;
        Thu, 24 Aug 2023 17:08:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 6/8] drm/fb-helper: Pass buffer format via drm_fb_helper_surface_size
Date:   Thu, 24 Aug 2023 17:08:44 +0200
Message-Id: <df91abce8e86bdf71b9062718b7643c3c143788b.1692888745.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692888745.git.geert@linux-m68k.org>
References: <cover.1692888745.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_fb_helper_single_fb_probe() first calls drm_fb_helper_find_sizes(),
followed by drm_fbdev_generic_helper_fb_probe():
  - The former tries to find a suitable buffer format, taking into
    account limitations of the whole display pipeline,
  - The latter just calls drm_mode_legacy_fb_format() again.

Simplify this by passing the buffer format between these functions
via a new buffer format member in the drm_fb_helper_surface_size
structure.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>
---
v2:
  - Fix accidental debug level increase,
  - Add Reviewed-by, Tested-by.
---
 drivers/gpu/drm/drm_fb_helper.c     | 1 +
 drivers/gpu/drm/drm_fbdev_generic.c | 9 ++++-----
 include/drm/drm_fb_helper.h         | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d612133e2cf7ec99..4dc28fdcc1e0a6a4 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1564,6 +1564,7 @@ static int __drm_fb_helper_find_sizes(struct drm_fb_helper *fb_helper,
 	info = drm_format_info(surface_format);
 	sizes->surface_bpp = drm_format_info_bpp(info, 0);
 	sizes->surface_depth = info->depth;
+	sizes->surface_format = surface_format;
 
 	/* first up get a count of crtcs now in use and new min/maxes width/heights */
 	crtc_count = 0;
diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index d647d89764cb9894..3830d25bcc3ad035 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -77,16 +77,15 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
 	struct fb_info *info;
 	size_t screen_size;
 	void *screen_buffer;
-	u32 format;
 	int ret;
 
-	drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
+	drm_dbg_kms(dev, "surface width(%d), height(%d), bpp(%d) and format(%p4cc)\n",
 		    sizes->surface_width, sizes->surface_height,
-		    sizes->surface_bpp);
+		    sizes->surface_bpp, &sizes->surface_format);
 
-	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
 	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
-					       sizes->surface_height, format);
+					       sizes->surface_height,
+					       sizes->surface_format);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 375737fd6c36ed19..aa3d62a531d12f37 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -45,6 +45,7 @@ struct drm_fb_helper;
  * @surface_height: scanout buffer height
  * @surface_bpp: scanout buffer bpp
  * @surface_depth: scanout buffer depth
+ * @surface_format: scanout buffer format (optional)
  *
  * Note that the scanout surface width/height may be larger than the fbdev
  * width/height.  In case of multiple displays, the scanout surface is sized
@@ -61,6 +62,7 @@ struct drm_fb_helper_surface_size {
 	u32 surface_height;
 	u32 surface_bpp;
 	u32 surface_depth;
+	u32 surface_format;
 };
 
 /**
-- 
2.34.1

