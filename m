Return-Path: <linux-kernel+bounces-18071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4502C825857
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476A81C2338B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85735292;
	Fri,  5 Jan 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="CHA6LNtf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004534CF4;
	Fri,  5 Jan 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T68J15FgwzDr8c;
	Fri,  5 Jan 2024 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704472642; bh=sqwpQ6x5qhOlKhST2bTqDbph6jVTFp9MazqbgU4yuSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CHA6LNtfdvv+W7pwOBOvQ4NRRAgIDG2JHHeWdgaF+Ux0bZheqpTZyIAi1sx0zP9/4
	 HDpPpsO+swcPEy+bZJipVVXtCdAUaC+lsFB+LfzlGNtypNytq89jHWdwOiBIKL9k6g
	 2f1VtKxOa+Yaw4bE0SO1Pl0tAhWbqpTKTr3oktSA=
X-Riseup-User-ID: CC767B1388D339A0556428D7788F9FD121D74D1B3A067AB065D4BA19CBCA3A74
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T68Hw3vbczJp2K;
	Fri,  5 Jan 2024 16:37:16 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Fri, 05 Jan 2024 13:35:04 -0300
Subject: [PATCH 3/7] drm/vkms: Add range and encoding properties to
 pixel_read function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-vkms-yuv-v1-3-34c4cd3455e0@riseup.net>
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

Create range and encoding properties. This should be noop, as none of
the conversion functions need those properties.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/vkms_drv.h     |  3 ++-
 drivers/gpu/drm/vkms/vkms_formats.c | 20 ++++++++++++++------
 drivers/gpu/drm/vkms/vkms_plane.c   |  9 +++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index c38590562e4b..51349a0c32d8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -56,7 +56,8 @@ struct vkms_writeback_job {
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
 	struct vkms_frame_info *frame_info;
-	void (*pixel_read)(u8 **src_buffer, struct pixel_argb_u16 *out_pixel);
+	void (*pixel_read)(u8 **src_buffer, struct pixel_argb_u16 *out_pixel,
+			   enum drm_color_encoding enconding, enum drm_color_range range);
 };
 
 struct vkms_plane {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 5566a7cd7bb4..0156372aa1ef 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -51,7 +51,8 @@ static int get_x_position(const struct vkms_frame_info *frame_info, int limit, i
 	return x;
 }
 
-static void ARGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
+static void ARGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
+				 enum drm_color_encoding encoding, enum drm_color_range range)
 {
 	/*
 	 * The 257 is the "conversion ratio". This number is obtained by the
@@ -65,7 +66,8 @@ static void ARGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pix
 	out_pixel->b = (u16)src_pixels[0][0] * 257;
 }
 
-static void XRGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
+static void XRGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
+				 enum drm_color_encoding encoding, enum drm_color_range range)
 {
 	out_pixel->a = (u16)0xffff;
 	out_pixel->r = (u16)src_pixels[0][2] * 257;
@@ -73,7 +75,8 @@ static void XRGB8888_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pix
 	out_pixel->b = (u16)src_pixels[0][0] * 257;
 }
 
-static void ARGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
+static void ARGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
+				     enum drm_color_encoding encoding, enum drm_color_range range)
 {
 	u16 *pixels = (u16 *)src_pixels[0];
 
@@ -83,7 +86,8 @@ static void ARGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out
 	out_pixel->b = le16_to_cpu(pixels[0]);
 }
 
-static void XRGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
+static void XRGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
+				     enum drm_color_encoding encoding, enum drm_color_range range)
 {
 	u16 *pixels = (u16 *)src_pixels[0];
 
@@ -93,7 +97,8 @@ static void XRGB16161616_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out
 	out_pixel->b = le16_to_cpu(pixels[0]);
 }
 
-static void RGB565_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel)
+static void RGB565_to_argb_u16(u8 **src_pixels, struct pixel_argb_u16 *out_pixel,
+			       enum drm_color_encoding encoding, enum drm_color_range range)
 {
 	u16 *pixels = (u16 *)src_pixels[0];
 
@@ -132,6 +137,9 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 	int limit = min_t(size_t, drm_rect_width(&frame_info->dst), stage_buffer->n_pixels);
 	u8 *src_pixels[DRM_FORMAT_MAX_PLANES];
 
+	enum drm_color_encoding encoding = plane->base.base.color_encoding;
+	enum drm_color_range range = plane->base.base.color_range;
+
 	for (size_t i = 0; i < frame_format->num_planes; i++)
 		src_pixels[i] = get_packed_src_addr(frame_info, y, i);
 
@@ -146,7 +154,7 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 			}
 		}
 
-		plane->pixel_read(src_pixels, &out_pixels[x_pos]);
+		plane->pixel_read(src_pixels, &out_pixels[x_pos], encoding, range);
 
 		for (size_t i = 0; i < frame_format->num_planes; i++)
 			src_pixels[i] += frame_format->cpp[i];
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8f2c6ea419a3..e87c80575b7d 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -212,5 +212,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
 					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 
+	drm_plane_create_color_properties(&plane->base,
+					  BIT(DRM_COLOR_YCBCR_BT601) |
+					  BIT(DRM_COLOR_YCBCR_BT709) |
+					  BIT(DRM_COLOR_YCBCR_BT2020),
+					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+					  DRM_COLOR_YCBCR_BT601,
+					  DRM_COLOR_YCBCR_FULL_RANGE);
+
 	return plane;
 }

-- 
2.43.0


