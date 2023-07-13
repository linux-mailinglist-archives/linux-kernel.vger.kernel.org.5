Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5290275233C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjGMNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjGMNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:17:31 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EAC270A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:17:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6264:77e5:42e2:477d])
        by michel.telenet-ops.be with bizsmtp
        id LdHN2A00d3wy6xv06dHNae; Thu, 13 Jul 2023 15:17:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJwC3-001GrC-48;
        Thu, 13 Jul 2023 15:17:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJwCA-00GWyv-QU;
        Thu, 13 Jul 2023 15:17:22 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 7/8] drm/fb-helper: Add support for DRM_FORMAT_R1
Date:   Thu, 13 Jul 2023 15:17:15 +0200
Message-Id: <ea0d68ef5630fe9748a11e50f6d79f79a768ebdb.1689252746.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the monochrome light-on-dark buffer format (R1) to the
fb helper, so this format can be used for fbdev emulation and for the
text console.  This avoids the overhead of using XR24 and the associated
conversions on display hardware that supports only a simple monochrome
format.

R1 is very similar to C1 (monochrome indexed color), and shares the same
depth and bpp.  As drm_mode_legacy_fb_format() returns a format based on
only depth and bpp, it cannot distinguish between R1 and C1.  Hence
drm_fb_helper_find_format() is modified to try to fall back to R1 if C1
is not supported.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 41 ++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index e870b2ce7a8625e3..1f1bfa764b6b9f00 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1130,7 +1130,7 @@ static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
 {
 	u8 depth = format->depth;
 
-	if (format->is_color_indexed) {
+	if (format->format == DRM_FORMAT_R1 || format->is_color_indexed) {
 		var->red.offset = 0;
 		var->green.offset = 0;
 		var->blue.offset = 0;
@@ -1236,6 +1236,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 	case DRM_FORMAT_C1:
 	case DRM_FORMAT_C2:
 	case DRM_FORMAT_C4:
+	case DRM_FORMAT_R1:
 		/* supported format with sub-byte pixels */
 		break;
 
@@ -1439,12 +1440,24 @@ int drm_fb_helper_pan_display(struct fb_var_screeninfo *var,
 }
 EXPORT_SYMBOL(drm_fb_helper_pan_display);
 
+static bool is_supported_format(uint32_t format, const uint32_t *formats,
+				size_t format_count)
+{
+	size_t i;
+
+	for (i = 0; i < format_count; ++i) {
+		if (formats[i] == format)
+			return true;
+	}
+
+	return false;
+}
+
 static uint32_t drm_fb_helper_find_format(struct drm_fb_helper *fb_helper, const uint32_t *formats,
 					  size_t format_count, uint32_t bpp, uint32_t depth)
 {
 	struct drm_device *dev = fb_helper->dev;
 	uint32_t format;
-	size_t i;
 
 	/*
 	 * Do not consider YUV or other complicated formats
@@ -1457,10 +1470,12 @@ static uint32_t drm_fb_helper_find_format(struct drm_fb_helper *fb_helper, const
 	if (!format)
 		goto err;
 
-	for (i = 0; i < format_count; ++i) {
-		if (formats[i] == format)
-			return format;
-	}
+	if (is_supported_format(format, formats, format_count))
+		return format;
+
+	if (format == DRM_FORMAT_C1 &&
+	    is_supported_format(DRM_FORMAT_R1, formats, format_count))
+		return DRM_FORMAT_R1;
 
 err:
 	/* We found nothing. */
@@ -1680,11 +1695,15 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 }
 
 static void drm_fb_helper_fill_fix(struct fb_info *info, uint32_t pitch,
-				   bool is_color_indexed)
+				   const struct drm_format_info *format)
 {
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
-	info->fix.visual = is_color_indexed ? FB_VISUAL_PSEUDOCOLOR
-					    : FB_VISUAL_TRUECOLOR;
+	if (format->format == DRM_FORMAT_R1)
+		info->fix.visual = FB_VISUAL_MONO10;
+	else if (format->is_color_indexed)
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+	else
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 	info->fix.mmio_start = 0;
 	info->fix.mmio_len = 0;
 	info->fix.type_aux = 0;
@@ -1707,6 +1726,7 @@ static void drm_fb_helper_fill_var(struct fb_info *info,
 	case DRM_FORMAT_C1:
 	case DRM_FORMAT_C2:
 	case DRM_FORMAT_C4:
+	case DRM_FORMAT_R1:
 		/* supported format with sub-byte pixels */
 		break;
 
@@ -1747,8 +1767,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
 
-	drm_fb_helper_fill_fix(info, fb->pitches[0],
-			       fb->format->is_color_indexed);
+	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format);
 	drm_fb_helper_fill_var(info, fb_helper,
 			       sizes->fb_width, sizes->fb_height);
 
-- 
2.34.1

