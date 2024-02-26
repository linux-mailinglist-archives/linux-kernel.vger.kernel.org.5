Return-Path: <linux-kernel+bounces-80957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13142866E60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371DD1C23EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3A5EE70;
	Mon, 26 Feb 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nnsvRHFM"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F55D720
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937279; cv=none; b=NIWbPGWw5q2QQLxILb9GzFfGLUd89LTztwpFwWacE8Pp4tskqncyV/U3uOqviz2EkBaErs82McF0Lpqt9LgESc4NUxVKsM6BANBb8cQSsYqY1DvwvKWAXKciE+XMsk23hPFFAhZ+4ISXbZGX8heqFRUz9/daWZH77ajVoIedzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937279; c=relaxed/simple;
	bh=D4TC7GfNKrDRx6FBTflEjIvY9r2R7Bzpo66QJhUPBxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OiGCq9klhGCLSQtkSEIKwiLB0pnAhBtKaJ3umStUcHYL6VEpCyG994LgGFgsxpMpthrsVOWdlhIsgd0DC4oFJD3hfnGUs/Ahq2375S5PY0YP/QhPvmk4sNYkuaUS+5o+8d6jWAOhWrhUtXsFWdUoJLHmtn3L4CoPwDtypEw8hPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nnsvRHFM; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7DCDE000E;
	Mon, 26 Feb 2024 08:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708937269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNrV5eCxkdETUulcpe7tOcXgNVakjWdt073qLmEHzKs=;
	b=nnsvRHFMgEKRJoZyGAbi+AKZse9xv51B33lc1Z0J4zvaO782RYKUS7BMZifQk7d3TGKMwL
	iXTWxUeZHwROSFL1Vgi31G9A4MqX3u9VhyymSETq79LCPahB3fNOqoidt/QZIApbvtxdbI
	YLSmKNFHYTMDAe362bYGI3jT1KVIqncuKl9qdl9POP0L38Pv+q1KTZMivR8KI8vVTI18o8
	Fw3NvWkdVv8AahYNsMpOiyOsDzns8hcB5VDXzZsbE4JZ+iRs5gV0VmuFvwY2HW+HbcCCuT
	iIC8jxf1ONbYURLK9JQy429ZFPneQeHAtBLKcSkXh8rrLKsa8xdhEbDAzza4vg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 26 Feb 2024 09:46:34 +0100
Subject: [PATCH v3 4/9] drm/vkms: Add typedef and documentation for
 pixel_read and pixel_write functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-yuv-v3-4-ff662f0994db@bootlin.com>
References: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
In-Reply-To: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6217;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=D4TC7GfNKrDRx6FBTflEjIvY9r2R7Bzpo66QJhUPBxk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl3FAuDkmkYvQPapjBzISBGHDQL2Jvr3QU1BL6VsCW
 Zw58MYqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdxQLgAKCRAgrS7GWxAs4gflD/
 94FqaSHUckFIQxcpQWwMc103UBvVqGmWjfAwMClvrGQjNN+AHPCdAcjl29zng0i73vvTLT72wjxsul
 vLcPgPgsIPsaLG5+2LGDeaBSWsU8knlzYAj/SQ4faimx1i3+EvhCSM0in2herV+j7nb9V0jpv6JfLJ
 fLQ/fuzbYSt5nRDvLOs6VFXrXFHbVg3jNSLcLiWnM21gkT1r+ykQFtpYvaMnRfUZjmo0NAYSToxeEr
 qvVS44T/FnMoBNDiqKc7dWo3HUj073HK2XwbXpiLNLm4U91mdT/qwtuuISeFInI6U7mBJDQzjuyGRi
 ++MIFuvtj6LfMeYCKXIA4NGFFX+o9rMaxKt3qupag7Rp/QI0poiwdbUzwkZv+tLKL0zPrS/7e7ahe/
 3QNHGhVMgMvOgHPO64YNzt22Fv3O+6biwFx7EHH/kFNeeRN3FZhotVpqj9nVcuuqGNfICbJknWvSL8
 mutkG+beH4TiSCR/XDw4anoNi+MENO6S7EJZ8xjTDiqIo/uGyxY2+OMbeCjS4B6iAtKmmvvZ8idCJf
 b1dp/zzxZrV+Dhhs6AUwXpIFQe7bWaERBQJdY6TS/JeRKdxUn527LkDcQIddpssN+3EMH6vetvV0zC
 bkEVviHKwB1qh/k532LrfHAYLZA0zo0KaHxwdqyOeYIipxkT87TL7wz3v1mg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce two typedefs: pixel_read_t and pixel_write_t. It allows the
compiler to check if the passed functions take the correct arguments.
Such typedefs will help ensuring consistency across the code base in
case of update of these prototypes.

Introduce a check around the get_pixel_*_functions to avoid using a
nullptr as a function.

Document for those typedefs.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h       | 23 +++++++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_formats.c   |  8 ++++----
 drivers/gpu/drm/vkms/vkms_formats.h   |  4 ++--
 drivers/gpu/drm/vkms/vkms_plane.c     |  9 ++++++++-
 drivers/gpu/drm/vkms/vkms_writeback.c |  9 ++++++++-
 5 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 18086423a3a7..886c885c8cf5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -53,12 +53,31 @@ struct line_buffer {
 	struct pixel_argb_u16 *pixels;
 };
 
+/**
+ * typedef pixel_write_t - These functions are used to read a pixel from a
+ * `struct pixel_argb_u16*`, convert it in a specific format and write it in the @dst_pixels
+ * buffer.
+ *
+ * @dst_pixel: destination address to write the pixel
+ * @in_pixel: pixel to write
+ */
+typedef void (*pixel_write_t)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
+
 struct vkms_writeback_job {
 	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
 	struct vkms_frame_info wb_frame_info;
-	void (*pixel_write)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
+	pixel_write_t pixel_write;
 };
 
+/**
+ * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
+ * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
+ *
+ * @src_pixels: Pointer to the pixel to read
+ * @out_pixel: Pointer to write the converted pixel
+ */
+typedef void (*pixel_read_t)(u8 *src_pixels, struct pixel_argb_u16 *out_pixel);
+
 /**
  * vkms_plane_state - Driver specific plane state
  * @base: base plane state
@@ -69,7 +88,7 @@ struct vkms_writeback_job {
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
 	struct vkms_frame_info *frame_info;
-	void (*pixel_read)(u8 *src_buffer, struct pixel_argb_u16 *out_pixel);
+	pixel_read_t pixel_read;
 };
 
 struct vkms_plane {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index cb7a49b7c8e7..1f5aeba57ad6 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -262,7 +262,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
  *
  * @format: 4cc of the format
  */
-void *get_pixel_conversion_function(u32 format)
+pixel_read_t get_pixel_read_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
@@ -276,7 +276,7 @@ void *get_pixel_conversion_function(u32 format)
 	case DRM_FORMAT_RGB565:
 		return &RGB565_to_argb_u16;
 	default:
-		return NULL;
+		return (pixel_read_t)NULL;
 	}
 }
 
@@ -287,7 +287,7 @@ void *get_pixel_conversion_function(u32 format)
  *
  * @format: 4cc of the format
  */
-void *get_pixel_write_function(u32 format)
+pixel_write_t get_pixel_write_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
@@ -301,6 +301,6 @@ void *get_pixel_write_function(u32 format)
 	case DRM_FORMAT_RGB565:
 		return &argb_u16_to_RGB565;
 	default:
-		return NULL;
+		return (pixel_write_t)NULL;
 	}
 }
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index cf59c2ed8e9a..3ecea4563254 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -5,8 +5,8 @@
 
 #include "vkms_drv.h"
 
-void *get_pixel_conversion_function(u32 format);
+pixel_read_t get_pixel_read_function(u32 format);
 
-void *get_pixel_write_function(u32 format);
+pixel_write_t get_pixel_write_function(u32 format);
 
 #endif /* _VKMS_FORMATS_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index d5203f531d96..f68b1b03d632 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -106,6 +106,13 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 		return;
 
 	fmt = fb->format->format;
+	pixel_read_t pixel_read = get_pixel_read_function(fmt);
+
+	if (!pixel_read) {
+		DRM_WARN("Pixel format is not supported by VKMS planes. State is inchanged\n");
+		return;
+	}
+
 	vkms_plane_state = to_vkms_plane_state(new_state);
 	shadow_plane_state = &vkms_plane_state->base;
 
@@ -124,7 +131,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	drm_rect_rotate(&frame_info->rotated, drm_rect_width(&frame_info->rotated),
 			drm_rect_height(&frame_info->rotated), frame_info->rotation);
 
-	vkms_plane_state->pixel_read = get_pixel_conversion_function(fmt);
+	vkms_plane_state->pixel_read = pixel_read;
 }
 
 static int vkms_plane_atomic_check(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index c8582df1f739..c92b9f06c4a4 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -140,6 +140,13 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	if (!conn_state)
 		return;
 
+	pixel_write_t pixel_write = get_pixel_write_function(wb_format);
+
+	if (!pixel_write) {
+		DRM_WARN("Pixel format is not supported by VKMS writeback. State is inchanged\n");
+		return;
+	}
+
 	vkms_set_composer(&vkmsdev->output, true);
 
 	active_wb = conn_state->writeback_job->priv;
@@ -150,7 +157,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	crtc_state->wb_pending = true;
 	spin_unlock_irq(&output->composer_lock);
 	drm_writeback_queue_job(wb_conn, connector_state);
-	active_wb->pixel_write = get_pixel_write_function(wb_format);
+	active_wb->pixel_write = pixel_write;
 	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
 	drm_rect_init(&wb_frame_info->dst, 0, 0, crtc_width, crtc_height);
 }

-- 
2.43.0


