Return-Path: <linux-kernel+bounces-48595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0D845E92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07AB1C27949
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB45C031;
	Thu,  1 Feb 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o4NwI2W7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11484025
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808742; cv=none; b=bq83zL5b5rSToNpLsOHmjOyNnfcURpuHd07jQR4HralU9Ig0q4pdHR7mNgk/ER7QhK59K1uRsAsT4PaAkkjgfmc78nT8i80NBoe3Z5+GZQAsWnrGqcl1sytrBTau+/xK2KW6I+dQGUn2GDQW7TednlGTg+O/g4xBfHHBEvYDf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808742; c=relaxed/simple;
	bh=sy6XOjKiwgGLJghXuUCDDipZtMBjZVoiNnbEzSMpZZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sf3l+3Pb0XUUexuBui55KHhVzxqh3AW/KuzyU4OK+2zAd6YHfP5ovjd7YcanPDiQ1nLGV/7lpuzuNTS7+oc2voF7ZhAhj5agjyXQQcdEkF+MLvd4UIzkJ8B3JMFUlCAe8ug4+oj6sb7F84lKzNP9tW+heLe3GtyhPPg3n4jk+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o4NwI2W7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E23B1C000E;
	Thu,  1 Feb 2024 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706808732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+aqzxTPAUjOzIodHPzxeC6qMPaNLGnJXnuBentQENE=;
	b=o4NwI2W71cP/524XS5XZd+wR6dynrd7bQz1YYFr85lIod0g7wnCEVb5vMnkvfFa4swnFa6
	Vga1gARfj5bJ4msfrmpsnust9S++UbhaLijPItbdzjUqSpZtYTV35ugOmwnlntXZ+9lfam
	uJftslgpJgj5g70KbaSDZfl4zGTDb5UP4ZWqeiSikA3jiebmiiYid8XZKd9QXevyUeoIVh
	fDmCB5CoGVdj+DFAUoIg4NVT0tnzc/n4iZ0Cz/xZCT9/jQ0UOrpkF+h7J+jAlBG8Pr+FkM
	CTYn91NG3ddpR1Y0LytRlrgqt5mb3zN/BNOlE23tdqRBEeojZORxMfxNUlKV8w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 01 Feb 2024 18:31:31 +0100
Subject: [PATCH 1/2] drm/vkms: Create a type to check a function pointer
 validity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-yuv-v1-1-3ca376f27632@bootlin.com>
References: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
In-Reply-To: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, marcheu@google.com, seanpaul@google.com, 
 nicolejadeyee@google.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, thomas.petazzoni@bootlin.com, 
 miquel.raynal@bootlin.com
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3051;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=sy6XOjKiwgGLJghXuUCDDipZtMBjZVoiNnbEzSMpZZE=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBlu9WZSdSr1fJmjjmgoEgdMXRsHSkHazV7I02+1oIU
 rS216fCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZbvVmQAKCRAgrS7GWxAs4lx2D/
 9gzX3KmylHrfqn4EdZ5irvLsNj7XKSNitiwqJLoic7NSfewZYK0ZTimaTYAqOJWUGC+1W7wWv8Y/Ah
 ujjMwiIwHX4ee+EmgvT5nFbtlNxwUbS/6YoGHh5z+JoAdCzZA3paPGkfLcRexE4W0KQFP23tsWD18F
 rb2Tlkqn5gHrT9PLwSV0VTiWfAi4KUv8fnc7CAyv/6BLnP5pRYHfOLo4TcTL/AztLn3hu4z27VytY3
 Jd7Glyf8Y7Pc4fU0arCO8WrcI0+KaLp7NsEBM9bXJKYYUOncvYxiCBwUT5bibv9fZVU3t/0BLrDRRa
 VWQUXmKd48TfrZD0F/vNEnvOllKijrIg6usH81Qcm2hgBvNbIfIHokg9IoMKJH14fwlOJfLdtrfNOS
 ICe8GWq8r1njHfduxaUaTFBAnCFRcybcq/5qQdz3l2mNU6LJipXQKUvl46AHT26eHjVIGk33y+vQJN
 0B7uU6HXys4vdlLpj8TsVHtlV8v7nPiG5N39l2NEjlWZ3nv1HAV6dWXA1SjJGMDUqQKftYSYaZMMGW
 qrCqrJ+E4SAR7w8If6pZXTaINxjhRvL+N+ZAPDIqwMH/OTxpJne5tJmwV3Jz/M6OyQ8kfw3k9k3Q56
 b7qTPQxXPPYvKBVUcO2rvl3An1HvyBXGzH+NZHQPifz2RqVzzSZv9aItU2pQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Add the pixel_read_t type to check function prototype in structures
and functions.
It avoids casting to (void *) and at the same occasion allows the
compiler to check the type properly.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h     | 17 +++++++++++++++--
 drivers/gpu/drm/vkms/vkms_formats.c |  4 ++--
 drivers/gpu/drm/vkms/vkms_formats.h |  2 +-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 51349a0c32d8..cb20bab26cae 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -48,6 +48,20 @@ struct vkms_writeback_job {
 	void (*pixel_write)(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel);
 };
 
+/**
+ * typedef pixel_read_t - These functions are used to read the pixels in the source frame, convert
+ * them to argb16 and write them to out_pixel.
+ * It assumes that src_pixels point to a valid pixel (not a block, or a block of 1x1 pixel)
+ *
+ * @src_pixels: Source pointer to a pixel
+ * @out_pixel: Pointer where to write the pixel value
+ * @encoding: Color encoding to use (mainly used for YUV formats)
+ * @range: Color range to use (mainly used for YUV formats)
+ */
+typedef void (*pixel_read_t)(u8 **src_pixels, int y,
+			     struct pixel_argb_u16 *out_pixel, enum drm_color_encoding enconding,
+			     enum drm_color_range range);
+
 /**
  * vkms_plane_state - Driver specific plane state
  * @base: base plane state
@@ -56,8 +70,7 @@ struct vkms_writeback_job {
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
 	struct vkms_frame_info *frame_info;
-	void (*pixel_read)(u8 **src_buffer, struct pixel_argb_u16 *out_pixel,
-			   enum drm_color_encoding enconding, enum drm_color_range range);
+	pixel_read_t pixel_read;
 };
 
 struct vkms_plane {
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index e06bbd7c0a67..c6376db58d38 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -390,7 +390,7 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 		wb->pixel_write(dst_pixels, &in_pixels[x]);
 }
 
-void *get_pixel_conversion_function(u32 format)
+pixel_read_t get_pixel_conversion_function(u32 format)
 {
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
@@ -420,7 +420,7 @@ void *get_pixel_conversion_function(u32 format)
 	case DRM_FORMAT_YVU444:
 		return &planar_yvu_to_argb_u16;
 	default:
-		return NULL;
+		return (pixel_read_t)NULL;
 	}
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index 0cf835292cec..04e31e126ab1 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -5,7 +5,7 @@
 
 #include "vkms_drv.h"
 
-void *get_pixel_conversion_function(u32 format);
+pixel_read_t get_pixel_conversion_function(u32 format);
 
 void *get_pixel_write_function(u32 format);
 

-- 
2.43.0


