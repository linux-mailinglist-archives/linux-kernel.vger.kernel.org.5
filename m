Return-Path: <linux-kernel+bounces-136947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D357889DA3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1191F2357D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBC130E3F;
	Tue,  9 Apr 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f9pMjhR3"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C3130A4C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669157; cv=none; b=onEGgUVN0h5GnUQXYyu2mPGEQTkWN01viJDnuhqk5J0UTH+qnX765wxH7yRsGPvYCL4nYXL9W5cAaLPOA10z3XFMF6nuLwcz+b1Sm3lNvFFmDT+HYPvl/pVlUwI5QZA4hm6EB621IWAqdJLEy7JvSrNmKeKGyp3pYfqOBjF/9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669157; c=relaxed/simple;
	bh=Sfh4O+PqEC7Ra3tm97F32x1rZZ3jsiSoO6x9STnYV+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABxERRB7oR5VFzWY6sXwywedDzSa/qVw6FAofaq/vL+QpdSE3/K0juPiKkyAqZRh/vX7JMC50xhnyqk7YGo5nZkeOOs4N3CjNzKCrM7Ot4OvIkFrg83a/v0FUDInDU+s/+3YxRmXfQ6aPBKNx22FSL16mcIm37lLX43F9dUu//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f9pMjhR3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B262124001A;
	Tue,  9 Apr 2024 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUE71gsvF+O8LiPn3Cww9o4Q8NkzACOq7bQghVtFikM=;
	b=f9pMjhR3U5jmJ4VfKAKvEHgSsLNOdWKw9uF0hqTuSy+By0EQQVo7Koyhxplv46EQe0gwdq
	dkyy+iVRdDlNJugupNlOGMupm0lK2XKjzhaR9wuFqaFBhRD6upBS9QfMC9Mh5/mNNhOIw5
	dXvjq8MOO1GEDClOaDtdGRVQtoGD5O1nR3K2c67Xk9iDXg1qNboVrXsx5SC0vYOW4S8hyi
	S/Ns41poKMJgpnO/wEbrPVvQCMzqQPsvPpRNZuA1iN3yGpW5qYK75N/OVQaN7XlPeLPgnD
	JpksHz1rjUJq6B4yMWifsLgJwlk4YTaQp1M5zbooQvT0Ww0wb36psEvhGjGyzA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:27 +0200
Subject: [PATCH v6 09/17] drm/vkms: Introduce pixel_read_direction enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-9-de1c5728fd70@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4783;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Sfh4O+PqEC7Ra3tm97F32x1rZZ3jsiSoO6x9STnYV+0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHSE5TRpRROVpTIcXXs9789QEBbMnFyxQqWQ
 0qaI49ij2KJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB0gAKCRAgrS7GWxAs
 4r1lEACI3a+IaDSA9EePy7BRCpLL7QLEB65F6qkCJQCF3q7eASEgKZ5Hu36xT0+QmCpzyqioSHb
 zzUoY2KGwe2b895to3mBAghhNAYk4FRw3Z+wtyr/ABWGOJAhvc+g4bTXwxSSH1WV4YM71vzC6Gv
 pcx+pick75r0t+aNVkds9O6PGw2a4NN7dBRYFfgm9eE3ZQKNbBgCirEGfIkqGKOE2lmJSGOUHnb
 HHlUNV/QrCLH+uEzTdY8k6K1TugcEUsMmT9fzcSaewXX0WY07c7rrXpgVQzTZjAbXjM0tUpIrXU
 ZBSN0qPSdgXhDEwder5xgQTL+3dwWMucJoEPVN4Vw3vwtNG2jIpR3cTqDOxME69JfJfqhzqrCZ8
 CJ+bn53vYBiMGpK9kj8tzv4pB3Fr5kRQ+6JJxUgF68cvo5irErVXLByQ/jsduXewp2v/1C/5unU
 C/A0E96BK6R9kG7n12jeJCOjuSjIyNdxUq4FxQjc7gENQpPqKdnQl50R7WqwScfOgXORD7NFK1m
 fb1AdwFJuveYVOIVTz4lCT8v0Pl1VZN8vxHbdtTFSRiIwASojg1+PFp8oth4WWswf5GznqJWwkq
 SCatN/aKW0TlgBU/u9nI/fuG6+Hht++8CPBRi4Z0Fxpr1Dgi5/RlUbR7znyyy/Awx19Pij0IsoG
 qDpdL0Osbqy4UOA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The pixel_read_direction enum is useful to describe the reading direction
in a plane. It avoids using the rotation property of DRM, which not
practical to know the direction of reading.
This patch also introduce two helpers, one to compute the
pixel_read_direction from the DRM rotation property, and one to compute
the step, in byte, between two successive pixel in a specific direction.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 42 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h      | 11 ++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c  | 30 ++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 45b111c74884..7c2e328c9510 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -159,6 +159,48 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
 	}
 }
 
+/**
+ * direction_for_rotation() - Get the correct reading direction for a given rotation
+ *
+ * @rotation: Rotation to analyze. It correspond the field @frame_info.rotation.
+ *
+ * This function will use the @rotation setting of a source plane to compute the reading
+ * direction in this plane which correspond to a "left to right writing" in the CRTC.
+ * For example, if the buffer is reflected on X axis, the pixel must be read from right to left
+ * to be written from left to right on the CRTC.
+ */
+static enum pixel_read_direction direction_for_rotation(unsigned int rotation)
+{
+	struct drm_rect tmp_a, tmp_b;
+	int x, y;
+
+	/*
+	 * The direction is computed by rotating the vector AB (top-left to top-right) in a
+	 * 1x1 square.
+	 */
+
+	tmp_a = DRM_RECT_INIT(0, 0, 0, 0);
+	tmp_b = DRM_RECT_INIT(1, 0, 0, 0);
+	drm_rect_rotate_inv(&tmp_a, 1, 1, rotation);
+	drm_rect_rotate_inv(&tmp_b, 1, 1, rotation);
+
+	x = tmp_b.x1 - tmp_a.x1;
+	y = tmp_b.y1 - tmp_a.y1;
+
+	if (x == 1)
+		return READ_LEFT_TO_RIGHT;
+	else if (x == -1)
+		return READ_RIGHT_TO_LEFT;
+	else if (y == 1)
+		return READ_TOP_TO_BOTTOM;
+	else if (y == -1)
+		return READ_BOTTOM_TO_TOP;
+
+
+	WARN_ONCE(true, "The inverse of the rotation gives an incorrect direction.");
+	return READ_LEFT_TO_RIGHT;
+}
+
 /**
  * blend - blend the pixels from all planes and compute crc
  * @wb: The writeback frame buffer metadata
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 2e1a1b824a3c..16317b063c20 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -69,6 +69,17 @@ struct vkms_writeback_job {
 	pixel_write_t pixel_write;
 };
 
+/**
+ * enum pixel_read_direction - Enum used internaly by VKMS to represent a reading direction in a
+ * plane.
+ */
+enum pixel_read_direction {
+	READ_BOTTOM_TO_TOP,
+	READ_TOP_TO_BOTTOM,
+	READ_RIGHT_TO_LEFT,
+	READ_LEFT_TO_RIGHT
+};
+
 /**
  * typedef pixel_read_t - These functions are used to read a pixel in the source frame,
  * convert it to `struct pixel_argb_u16` and write it to @out_pixel.
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 9a1400ad4db6..f76944874fe7 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -75,6 +75,36 @@ static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
 	*addr = (u8 *)frame_info->map[0].vaddr + offset;
 }
 
+/**
+ * get_block_step_byte() - Common helper to compute the correct step value between each pixel block
+ * to read in a certain direction.
+ *
+ * @fb: Framebuffer to iter on
+ * @direction: Direction of the reading
+ * @plane_index: Plane to get the step from
+ *
+ * As the returned offset is the number of bytes between two consecutive blocks in a direction,
+ * the caller may have to read multiple pixel before using the next one (for example, to read from
+ * left to right in a DRM_FORMAT_R1 plane, each block contains 8 pixels, so the step must be used
+ * only every 8 pixels.
+ */
+static int get_block_step_byte(struct drm_framebuffer *fb, enum pixel_read_direction direction,
+			       int plane_index)
+{
+	switch (direction) {
+	case READ_LEFT_TO_RIGHT:
+		return fb->format->char_per_block[plane_index];
+	case READ_RIGHT_TO_LEFT:
+		return -fb->format->char_per_block[plane_index];
+	case READ_TOP_TO_BOTTOM:
+		return (int)fb->pitches[plane_index];
+	case READ_BOTTOM_TO_TOP:
+		return -(int)fb->pitches[plane_index];
+	}
+
+	return 0;
+}
+
 /**
  * packed_pixels_addr_1x1() - Get the pointer to the block containing the pixel at the given
  * coordinates

-- 
2.43.0


