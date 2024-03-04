Return-Path: <linux-kernel+bounces-90829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34AC870584
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A261C2224E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A052F9B;
	Mon,  4 Mar 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ts3VOVkU"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28C47A57
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566172; cv=none; b=JtU11C94mvV0gi9ENGvGLOyLK/PJXhZJ9gBH9TVxiTQhldGt1zubVlSNapdrv7TL44pOUYkljEwzc8pbubur2mReoJXced2wzbxrakY0Lk0OdA2sGRuyOMMrhsKJHmdDGugBqxCg54r3N+IXCbtz7NbzlH85GBYMdKX1zE7D7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566172; c=relaxed/simple;
	bh=81s8pH+2KKpkPCCipJdtlkeM01WWiW3JBRoPFdnRHvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ne69mHVh+F4yvvKqnR2Fw5gxI3YGy308nhzUZrdjGRtTlZ816qaqfaGiQOU/BYUSKkai4hrRcc3FJBwmCD/vpvqVe/VNbefILH4uU+m3hvpfgFFN6ttnvqSNwGC8UhSC6iejvmm3HQSb36A0IgA3mHpKgmU24uVaV5X8dx7DTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ts3VOVkU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0817E1C0003;
	Mon,  4 Mar 2024 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709566169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRdBGBr45+6C8R4ecjWPrxY0eSUCRzxD4rOLgPsUrZg=;
	b=Ts3VOVkUvBT2z25vcHqG2r1yiaeucxrjBMmbe9Z9Pg+Asdc2YZP2m+wrCzR2CAl5/jZwlI
	v4Be/nB3hSqEe+Rkw5cRgNXGtSdG35obqZlpIzRpOEouNANr5CFp3sUzlzVb+jkgi7dIdY
	c8sNw7f04tHYAgmwWxrTC5kAADGelSb7NxloWExUV2888YX1Yvk38ZzQBin7un5pBRfBm4
	M0cusFbMVTzD499YHJOlZdszZi+jGTxP3W5megq47+BzGAhEFNs+yhKer5st2Ksaohpt4n
	nVrx3bwvQLF1aSjMevixKrdoHBbbVWs796SdQz/15JyMFeS+YGcPxvbHOXFbGA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 04 Mar 2024 16:28:14 +0100
Subject: [PATCH v4 09/14] drm/vkms: Introduce pixel_read_direction enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-yuv-v4-9-76beac8e9793@bootlin.com>
References: <20240304-yuv-v4-0-76beac8e9793@bootlin.com>
In-Reply-To: <20240304-yuv-v4-0-76beac8e9793@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4675;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=81s8pH+2KKpkPCCipJdtlkeM01WWiW3JBRoPFdnRHvI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl5ejMaeFjK7sgLEywSSRXA2Nl+d3nYAMK/eVwDRQO
 O8hXb8yJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZeXozAAKCRAgrS7GWxAs4qu5D/
 9nDsvT5miB45QS9wIkhJImLzpVOk+YCjkccQ/TYobQTr/CQ7dyypzDlyssNPB+dCapkKDqGxvGfw4W
 RoouuzpVscaXkOKTzSiECs3yPrqN82ERz7J5+EEqM9P51SzfFnKSsjKvrbVJUdJ/32B6oV2GOIm8VA
 DaTBHJrFDesbamhgHCewBgUrvDpfEqp9LvCfURswApVQbFUDIb65j3UOP0STmZQwhtc1I3UTTdEbhg
 BP5on9Z1icYbDNdyXAhCzJZm/yVjNIvN6drg0mEFK6JDvGo3ajNYng+/UCvqvonBhRMGke8bzX1LKO
 DTYjI31BYgw4UAzVe/li139MpzPftxaghVQyW8TuscsP8RwYG0QypVE8SFX6MXGL8DvSz0SF/8jRJu
 1wBWIF8ZWgTH9zmpghRUpC0NTmnyTO6yLtcoh8OkI/cYLaUzmC0bndJadgRuSO4qQtVcQdPMRniAhJ
 lYA1PIdxiYZlKYJvV5favC6kwXQahT9rAjjrMYDV7ZIGBHTdnDmXZ4JsDDSaBQ981GKACfjY1p/H8k
 W5sDnNryQv9E3O23v+b2Kvqz+ZMVsXHlbPTP6MdblLrsr2Hx/vM5y7OBgxaAqVEUm9/Q8GDQifuK9t
 GZjqy8JizhPdHT6VjWLEn7gHYHa01zvTsuEo8Cz9/KvGwkoqbAHO/NcO6uvw==
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
 drivers/gpu/drm/vkms/vkms_composer.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c  | 28 ++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 26e8789630bd..068b6d838d7a 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -162,6 +162,42 @@ static void apply_lut(const struct vkms_crtc_state *crtc_state, struct line_buff
 	}
 }
 
+/**
+ * direction_for_rotation() - Get the correct reading direction for a given rotation
+ *
+ * This function will use the @rotation setting of a source plane to compute the reading
+ * direction in this plane which correspond to a "left to right writing" in the CRTC.
+ * For example, if the buffer is reflected on X axis, the pixel must be read from right to left
+ * to be written from left to right on the CRTC.
+ *
+ * @rotation: Rotation to analyze. It correspond the field @frame_info.rotation.
+ */
+static enum pixel_read_direction direction_for_rotation(unsigned int rotation)
+{
+	if (rotation & DRM_MODE_ROTATE_0) {
+		if (rotation & DRM_MODE_REFLECT_X)
+			return READ_RIGHT_TO_LEFT;
+		else
+			return READ_LEFT_TO_RIGHT;
+	} else if (rotation & DRM_MODE_ROTATE_90) {
+		if (rotation & DRM_MODE_REFLECT_Y)
+			return READ_BOTTOM_TO_TOP;
+		else
+			return READ_TOP_TO_BOTTOM;
+	} else if (rotation & DRM_MODE_ROTATE_180) {
+		if (rotation & DRM_MODE_REFLECT_X)
+			return READ_LEFT_TO_RIGHT;
+		else
+			return READ_RIGHT_TO_LEFT;
+	} else if (rotation & DRM_MODE_ROTATE_270) {
+		if (rotation & DRM_MODE_REFLECT_Y)
+			return READ_TOP_TO_BOTTOM;
+		else
+			return READ_BOTTOM_TO_TOP;
+	}
+	return READ_LEFT_TO_RIGHT;
+}
+
 /**
  * blend - blend the pixels from all planes and compute crc
  * @wb: The writeback frame buffer metadata
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 3ead8b39af4a..985e7a92b7bc 100644
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
index 089e4bdd5da8..7a1bc1d8651f 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -62,6 +62,34 @@ static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
 	return (u8 *)frame_info->map[0].vaddr + packed_pixels_offset(frame_info, x, y, plane_index);
 }
 
+/**
+ * get_step_1x1() - Common helper to compute the correct step value between each pixel to read in a
+ * certain direction.
+ * This must be used only with format where blockh == blockw == 1.
+ * In the case when direction is not a valid pixel_read_direction, the returned step is 0, so you
+ * must not rely on this result to create a loop variant if the direction can be invalid.
+ *
+ * @fb: Framebuffer to iter on
+ * @direction: Direction of the reading
+ * @plane_index: Plane to get the step from
+ */
+static int get_step_1x1(struct drm_framebuffer *fb, enum pixel_read_direction direction,
+			int plane_index)
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
 static void *get_packed_src_addr(const struct vkms_frame_info *frame_info, int y,
 				 size_t plane_index)
 {

-- 
2.43.0


