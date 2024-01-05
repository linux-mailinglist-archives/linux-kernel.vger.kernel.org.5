Return-Path: <linux-kernel+bounces-18069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4AE825852
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BACD1F2233F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFC8328D6;
	Fri,  5 Jan 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="sLiPVVOG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547D328B7;
	Fri,  5 Jan 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T68Hw1Z6NzDqch;
	Fri,  5 Jan 2024 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704472636; bh=HQz7U8ppxHpCgDfOU0gPu+GqWwC5FYrZtrAlOo+/h7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sLiPVVOGML5nDzFnb53JGiPKNRvx+/Wf4/QLcRcL8NSU87X/szVAi2uGx364mBxDW
	 Nx3a7YzaA8ZqmXEAQcxEroul+AEHiErYnvAMdJLI1ABd4OfeKDCh8g1vxe5Ixh9GOa
	 wVMcVRgMXjdOxllPrhQgNoE+mRXqOkflGAwu22sQ=
X-Riseup-User-ID: 119BDBD345BA5107D7439A214E1B9AD473AF09349C036D0930D8DAD1FA6A552C
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T68Hp6W3xzJntT;
	Fri,  5 Jan 2024 16:37:10 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Fri, 05 Jan 2024 13:35:03 -0300
Subject: [PATCH 2/7] drm/vkms: Add support for multy-planar framebuffers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-vkms-yuv-v1-2-34c4cd3455e0@riseup.net>
References: <20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net>
In-Reply-To: <20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net>
To: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Arthur Grillo <arthurgrillo@riseup.net>

Add support to multy-planar formats by adding an index argument to the
framebuffer data access functions.

Also, give all the planes to the conversion functions. This, for now,
should be noop, as all the supported formats have only one plane.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/vkms_drv.h     |  2 +-
 drivers/gpu/drm/vkms/vkms_formats.c | 73 +++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index b4b357447292..c38590562e4b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -56,7 +56,7 @@ struct vkms_writeback_job {
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
 	struct vkms_frame_info *frame_info;
-	void (*pixel_read)(u8 *src_buffer, struct pixel_argb_u16 *out_pixel);
+	void (*pixel_read)(u8 **src_buffer, struct pixel_argb_u16 *out_pixel);
 };
 
 struct vkms_plane {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 172830a3936a..5566a7cd7bb4 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -9,12 +9,12 @@
 
 #include "vkms_formats.h"
 
-static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y)
+static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int y, size_t index)
 {
 	struct drm_framebuffer *fb = frame_info->fb;
 
-	return fb->offsets[0] + (y * fb->pitches[0])
-			      + (x * fb->format->cpp[0]);
+	return fb->offsets[index] + (y * fb->pitches[index])
+				  + (x * fb->format->cpp[index]);
 }
 
 /*
@@ -23,27 +23,25 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
  * @frame_info: Buffer metadata
  * @x: The x(width) coordinate of the 2D buffer
  * @y: The y(Heigth) coordinate of the 2D buffer
+ * @index: The index of the plane on the 2D buffer
  *
  * Takes the information stored in the frame_info, a pair of coordinates, and
- * returns the address of the first color channel.
- * This function assumes the channels are packed together, i.e. a color channel
- * comes immediately after another in the memory. And therefore, this function
- * doesn't work for YUV with chroma subsampling (e.g. YUV420 and NV21).
+ * returns the address of the first color channel on the desired index.
  */
 static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
-				int x, int y)
+				int x, int y, size_t index)
 {
-	size_t offset = pixel_offset(frame_info, x, y);
+	size_t offset = pixel_offset(frame_info, x, y, index);
 
 	return (u8 *)frame_info->map[0].vaddr + offset;
 }
 
-static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y)
+static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y, size_t index)
 {
 	int x_src = frame_info->src.x1 >> 16;
 	int y_src = y - frame_info->rotated.y1 + (frame_info->src.y1 >> 16);
 
-	return packed_pixels_addr(frame_info, x_src, y_src);
+	return packed_pixels_addr(frame_info, x_src, y_src, index);
 }
 
 static int get_x_position(const struct vkms_frame_info *frame_info, int limit, int x)
@@ -53,7 +51,7 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
 	return x;
 }
 
-static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void ARGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
 {
 	/*
 	 * The 257 is the "conversion ratio". This number is obtained by the
@@ -61,23 +59,23 @@ static void ARGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
 	 * the best color value in a pixel format with more possibilities.
 	 * A similar idea applies to others RGB color conversions.
 	 */
-	out_pixel->a = (u16)src_pixels[3] * 257;
-	out_pixel->r = (u16)src_pixels[2] * 257;
-	out_pixel->g = (u16)src_pixels[1] * 257;
-	out_pixel->b = (u16)src_pixels[0] * 257;
+	out_pixel->a = (u16)src_pixels[0][3] * 257;
+	out_pixel->r = (u16)src_pixels[0][2] * 257;
+	out_pixel->g = (u16)src_pixels[0][1] * 257;
+	out_pixel->b = (u16)src_pixels[0][0] * 257;
 }
 
-static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void XRGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
 {
 	out_pixel->a = (u16)0xffff;
-	out_pixel->r = (u16)src_pixels[2] * 257;
-	out_pixel->g = (u16)src_pixels[1] * 257;
-	out_pixel->b = (u16)src_pixels[0] * 257;
+	out_pixel->r = (u16)src_pixels[0][2] * 257;
+	out_pixel->g = (u16)src_pixels[0][1] * 257;
+	out_pixel->b = (u16)src_pixels[0][0] * 257;
 }
 
-static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void ARGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
 {
-	u16 *pixels = (u16 *)src_pixels;
+	u16 *pixels = (u16 *)src_pixels[0];
 
 	out_pixel->a = le16_to_cpu(pixels[3]);
 	out_pixel->r = le16_to_cpu(pixels[2]);
@@ -85,9 +83,9 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
 	out_pixel->b = le16_to_cpu(pixels[0]);
 }
 
-static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void XRGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
 {
-	u16 *pixels = (u16 *)src_pixels;
+	u16 *pixels = (u16 *)src_pixels[0];
 
 	out_pixel->a = (u16)0xffff;
 	out_pixel->r = le16_to_cpu(pixels[2]);
@@ -95,9 +93,9 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
 	out_pixel->b = le16_to_cpu(pixels[0]);
 }
 
-static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
+static void RGB565_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
 {
-	u16 *pixels = (u16 *)src_pixels;
+	u16 *pixels = (u16 *)src_pixels[0];
 
 	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
 	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
@@ -130,17 +128,28 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 {
 	struct pixel_argb_u16 *out_pixels = stage_buffer->pixels;
 	struct vkms_frame_info *frame_info = plane->frame_info;
-	u8 *src_pixels = get_packed_src_addr(frame_info, y);
+	const struct drm_format_info *frame_format = frame_info->fb->format;
 	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
+	u8 *src_pixels[DRM_FORMAT_MAX_PLANES];
 
-	for (size_t x = 0; x < limit; x++, src_pixels += frame_info->fb->format->cpp[0]) {
+	for (size_t i = 0; i < frame_format->num_planes; i++)
+		src_pixels[i] = get_packed_src_addr(frame_info, y, i);
+
+	for (size_t x = 0; x < limit; x++) {
 		int x_pos = get_x_position(frame_info, limit, x);
 
-		if (drm_rotation_90_or_270(frame_info->rotation))
-			src_pixels = get_packed_src_addr(frame_info, x + frame_info->rotated.y1)
-				+ frame_info->fb->format->cpp[0] * y;
+		if (drm_rotation_90_or_270(frame_info->rotation)) {
+			for (size_t i = 0; i < frame_format->num_planes; i++) {
+				src_pixels[i] = get_packed_src_addr(frame_info,
+								    x + frame_info->rotated.y1, i);
+				src_pixels[i] += frame_format->cpp[i] * y;
+			}
+		}
 
 		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
+
+		for (size_t i = 0; i < frame_format->num_planes; i++)
+			src_pixels[i] += frame_format->cpp[i];
 	}
 }
 
@@ -221,7 +230,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 {
 	struct vkms_frame_info *frame_info = &wb->wb_frame_info;
 	int x_dst = frame_info->dst.x1;
-	u8 *dst_pixels = packed_pixels_addr(frame_info, x_dst, y);
+	u8 *dst_pixels = packed_pixels_addr(frame_info, x_dst, y, 0);
 	struct pixel_argb_u16 *in_pixels = src_buffer->pixels;
 	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst), src_buffer->n_pixels);
 

-- 
2.43.0


