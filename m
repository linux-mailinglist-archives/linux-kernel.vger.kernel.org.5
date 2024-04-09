Return-Path: <linux-kernel+bounces-136955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7144789DA48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D4BB217C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04713281C;
	Tue,  9 Apr 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lRa+fbQb"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69D131E34
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669166; cv=none; b=Gf3MJrNW/0L8jY2GuiMKdlx96ujr42ZOb4+IKDVPXiXXnzbBhc2s2o76TVMXlF2bBQ74bJNYSkvbyabmamRE1mYMGm+2J5jQOwnfortpQ4GErejtYn/HZpCMAxD4Q8jVEx1O88I4u7VsxgAywjKU/12Gj3CeLrJSujzcss+ulgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669166; c=relaxed/simple;
	bh=iFX/kDaK9uqUiX85yO7iy5cASmjIam5Hn5owEa5VUUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xdkbh2CzHYVDDQXMVp25CFuKC/AXeMMGMz9kVMg/KqYBJnZqLPmHKjW7JO6klQ9hVmerIb22vNdTFZYmFC5avffuvv2V+TUhjdDav1qFDk/sk10aPRb51rkVVDEGKwAi1ot3HNknINTJJbUYS0l1K1s8a2RoFGOSBuut5AjqQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lRa+fbQb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65232240009;
	Tue,  9 Apr 2024 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5y7cEADgJR1FrJhDqhCbiuvpO5e8sfvTGUsiJEPc5I=;
	b=lRa+fbQb+Labjf5gpNtFPKXIyntOd1SvvYRJ8bZiE9MMgzF9Be1T5v8heL2qBj0unxzfGC
	VGYAApd5BMUwRXfzm9ERpZPcYb/OkK7lLhgrTY4BSUMmJLyIxJ8IKFoJ9bdSTpXvwPEuSK
	3ptnJVCGyBqmanssMpSujFyGtlnA5143VnqT3s8Gj1aG9M5kTdBqWiY8bXkAQnvHDVOl1h
	r4NYrZIRI1oRp3skhVoWNz3LE4vyB1aBBg/Z02Ot+d0G5zP+zRN5cvXgOtLuey6po4v8DG
	3IjDNJ5ftXp6xDD+oe2D+TrQjtPjircrHVcr8SymXiePwcq5y6Emwh46K4nc4A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:35 +0200
Subject: [PATCH v6 17/17] drm/vkms: Add support for DRM_FORMAT_R*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-17-de1c5728fd70@bootlin.com>
References: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
In-Reply-To: <20240409-yuv-v6-0-de1c5728fd70@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org, 
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5425;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=iFX/kDaK9uqUiX85yO7iy5cASmjIam5Hn5owEa5VUUc=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHUkwcowQGm/PfTR2bdUt4cq74nbLc5jeYX/
 vRcUuf1WaaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB1AAKCRAgrS7GWxAs
 4qIRD/99A6U72HS1NntwwJjUFS5m/94kekCIgsGmI3mcLS3ofZVt4cqo6TUToG59jAwOiB0W8GM
 wjafDy6boZh8p4E+wWT+z9U0eh2crRi0kv2zhUHX/JQzIwHiZiMWoXCp30x8qVK6HavB+TOZNzi
 qZy24YaygqBxG7S8zsPhev6eIjw/S1oysruG4ihKlqgVDRE2aK0c0OCUSc3UFtEzZ/uRuiZZE21
 XYXKWTNNK69NMZg9sqzA/o824BWyfMJwOOfBzWsQHNTStMFXwz3Jo//v2QeoVRk2bfQq6IG/2+A
 Hx8yUVaD+GuqCmUuwSIZJGlY3DUhbranBTyri6NUPC4hfDMB2g2kHuzKggbriPYBCFgWT08kT2X
 Byzqz1/5zJs5bEuiFe/f0tqt9MhLOvrDeayZ/MFLWri/TQg9piiq8WjfIq4R/KjsPpDJU3NeSR+
 E+FH55fS1YKf6jWdkiLgeDPj0Cl6P/SEiSHMloA7SR16l+oTMHnj/znIjdWlkQK13oh667FX8BF
 uk4fER4nA69i8bCYPI+GI9+T4LsTBZYTYf1NpdfR8ulF/Q31Il8xSPqVPgC6iWTRhjgQOHp3U1j
 TzyflzhriHxoVqlIMdJoBRec0YUJUinvkxAXqybb1HKAxW3i42NTcuOEjB8xDqTrqk+OTyDz8Cs
 FvR76faSH0SUcKA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This add the support for:
- R1/R2/R4/R8

R1 format was tested with [1] and [2].

[1]: https://lore.kernel.org/r/20240313-new_rotation-v2-0-6230fd5cae59@bootlin.com
[2]: https://lore.kernel.org/igt-dev/20240306-b4-kms_tests-v1-0-8fe451efd2ac@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 101 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c   |   4 ++
 2 files changed, 105 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index ca9028c1ef1a..7f49995686fd 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -237,6 +237,11 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const u16 *pixel)
 	return out_pixel;
 }
 
+static struct pixel_argb_u16 argb_u16_from_gray8(u8 gray)
+{
+	return argb_u16_from_u8888(255, gray, gray, gray);
+}
+
 VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
 							   const struct conversion_matrix *matrix)
 {
@@ -302,6 +307,94 @@ static void magenta_to_argb_u16(const struct vkms_plane_state *plane, int x_star
 	}
 }
 
+static void Rx_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[], u8 bit_per_pixel, u8 lum_per_level)
+{
+	struct pixel_argb_u16 *end = out_pixel + count;
+	u8 *src_pixels;
+	int rem_x, rem_y;
+
+	WARN_ONCE(drm_format_info_block_height(plane->frame_info->fb->format, 0) != 1,
+		  "%s() only support formats with block_h == 1", __func__);
+
+	packed_pixels_addr(plane->frame_info, x_start, y_start, 0, &src_pixels, &rem_x, &rem_y);
+	int bit_offset = (8-bit_per_pixel) - rem_x * bit_per_pixel;
+	int step = get_block_step_byte(plane->frame_info->fb, direction, 0);
+	int mask = (0x1 << bit_per_pixel) - 1;
+
+	if (direction == READ_LEFT_TO_RIGHT || direction == READ_RIGHT_TO_LEFT) {
+		int restart_bit_offset;
+		int step_bit_offset;
+
+		if (direction == READ_LEFT_TO_RIGHT) {
+			restart_bit_offset = 8 - bit_per_pixel;
+			step_bit_offset = -bit_per_pixel;
+		} else {
+			restart_bit_offset = 0;
+			step_bit_offset = bit_per_pixel;
+		}
+
+		while (out_pixel < end) {
+			u8 val = ((*src_pixels) >> bit_offset) & mask;
+
+			*out_pixel = argb_u16_from_gray8(val * lum_per_level);
+
+			bit_offset += step_bit_offset;
+			if (bit_offset < 0 || 8 <= bit_offset) {
+				bit_offset = restart_bit_offset;
+				src_pixels += step;
+			}
+			out_pixel += 1;
+		}
+	} else if (direction == READ_TOP_TO_BOTTOM || direction == READ_BOTTOM_TO_TOP) {
+		while (out_pixel < end) {
+			u8 val = (*src_pixels >> bit_offset) & mask;
+			*out_pixel = argb_u16_from_gray8(val * lum_per_level);
+			src_pixels += step;
+			out_pixel += 1;
+		}
+	}
+}
+
+static void R1_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel, 1, 0xFF);
+}
+
+static void R2_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel, 2, 0x55);
+}
+
+static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	Rx_read_line(plane, x_start, y_start, direction, count, out_pixel, 4, 0x11);
+}
+
+static void R8_read_line(const struct vkms_plane_state *plane, int x_start,
+			 int y_start, enum pixel_read_direction direction, int count,
+			 struct pixel_argb_u16 out_pixel[])
+{
+	struct pixel_argb_u16 *end = out_pixel + count;
+	u8 *src_pixels;
+	int step = get_block_step_byte(plane->frame_info->fb, direction, 0);
+
+	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);
+
+	while (out_pixel < end) {
+		*out_pixel = argb_u16_from_gray8(*src_pixels);
+		src_pixels += step;
+		out_pixel += 1;
+	}
+}
+
 static void ARGB8888_read_line(const struct vkms_plane_state *plane, int x_start, int y_start,
 			       enum pixel_read_direction direction, int count,
 			       struct pixel_argb_u16 out_pixel[])
@@ -625,6 +718,14 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 	case DRM_FORMAT_YVU422:
 	case DRM_FORMAT_YVU444:
 		return &planar_yuv_read_line;
+	case DRM_FORMAT_R1:
+		return &R1_read_line;
+	case DRM_FORMAT_R2:
+		return &R2_read_line;
+	case DRM_FORMAT_R4:
+		return &R4_read_line;
+	case DRM_FORMAT_R8:
+		return &R8_read_line;
 	default:
 		/*
 		 * This is a bug in vkms_plane_atomic_check(). All the supported
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8f764a108b00..67f891e7ac58 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -30,6 +30,10 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_YVU420,
 	DRM_FORMAT_YVU422,
 	DRM_FORMAT_YVU444,
+	DRM_FORMAT_R1,
+	DRM_FORMAT_R2,
+	DRM_FORMAT_R4,
+	DRM_FORMAT_R8,
 };
 
 static struct drm_plane_state *

-- 
2.43.0


