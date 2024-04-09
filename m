Return-Path: <linux-kernel+bounces-136943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD489DA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71042854DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807212FF9C;
	Tue,  9 Apr 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X6PrbbC8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF212F5A6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669152; cv=none; b=hLPdjuYyYjM4i51Kcm2iANz27yzfUN6x5DtaL9Z9Wd/IFntJTw0eQr0p61pnmounEzYnhPyFmVdkwnuwPnd0xjcEYU2JIrJEZggn5ZCi2BOZ0cizdDqD6TEApn17QSmG2YmX63emOvL8jx3j+yWF7P1mO9ha3dNwwOnF+lYZs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669152; c=relaxed/simple;
	bh=jy8xSXJEOqn5wUFVqbS80+Pv0J4IEDT2C+geoMLpavQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jreSS6gIKSv8K+Z6bFdvp3YFhu8t9v70UKjmM4cbddHb++RWi7GXmsl6mm3PhkrA2A7nuBErRgeD/DQ1ptdMKoJOa1fmwjfyjmv+rS4iFUnBqfdXJ6hMGPwLOY3qSwMqWGMuzFJIsRcjQcTOdzoBNTbvZgk+P+0fzZxZAYKgG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X6PrbbC8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AB57240012;
	Tue,  9 Apr 2024 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otbY3dyaK1xzegWiEm+JvrF5ZlRlYhNif7wGB0lFHTo=;
	b=X6PrbbC8W2JXMRiYSZo+XIEvRXF8D3ZRCUZe/k4HBCXGBG8M+BC73vvsiyItC2sp/9UAPG
	fVKbg5lBdKaqz0c0cw44aEJTXSnQ8+TAxRM4CrYxYlfH9kPSs4LgwV4JP/q1JFhvj+vbPG
	9h0NXd8fAvxYFmAYBIILlPrHZgJQax3eCuVGHTPnz8iKl56A/WPzP+WAXkjlWtRUyeld/5
	WeoLZHb+Jo1fGIon5/n8jXU4dZ72Iosvf/ASXll9ujHtJVWqGL+lvujF0Swb0vDDM8A9aI
	2uuPT5EUhq/NsujjLuBPDijrVZofnvjM0bq9a3Q01QvrZLOqYF8ZlfW04dDWaA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:23 +0200
Subject: [PATCH v6 05/17] drm/vkms: Add dummy pixel_read/pixel_write
 callbacks to avoid NULL pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-5-de1c5728fd70@bootlin.com>
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
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4683;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=jy8xSXJEOqn5wUFVqbS80+Pv0J4IEDT2C+geoMLpavQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHRjnIKr6XaGUdRrQ/zSO85JD+Bgx2elpHeg
 azBWENJYTqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB0QAKCRAgrS7GWxAs
 4gTcEACqiz1/FHfzWsEmZe/7eBdcnJaNPjHjeR+Xmw56wExV0oSp0264h431jkCPK+3is6hQBGG
 auMMUJ5EGF60T0tvGxT06VVsALKj3EKY11Qjt+pAH69ESGJJLrc34QKutBkhrzUQgfet0pWD173
 BW96lXufbZOihE0OKmPcAFb72pjOguTiq9CJ7z4cjHc2odJ6XNwznsLO2xhTYuzb19joflTPj3X
 ecsk/sbUNDSymYqiN09GRvAwM5hBGmpSYML50ls5vGAEaBdwbRMJzuyVL9dr2mVNwznGANQgE6l
 OiNeI/i46Zs6MZCLmxRsa5UJDMCxKFt67l1JxhsINioogyiJP89+KB+MgPhxToUX72NdmKmudFp
 1aImmor5YUAUDm+aWk8ac4utobGbXfPAhaOSwEf/cdCIZHdICgi04BfG8porn4xzfx0xN/iyPiF
 pFrmLFF3tjG3wZOUxyHo+1taWyO2lLVHHZeSHUETt6jkoDS4DiioEyBGd/5tBEtMXf2h0vJ8DnJ
 koZ4gb+ii/LsDruFQVMlEop1I807KkErax1LyJNAQBRGiZEe90LoQAb54dlRc7ZCInHAlgZNL+Z
 kWiII67BhGqlGEQnp3/IsvuIeZbdm/gHeyyQ9BdBt2Beh0n0BuYLfDDH8YrZotXwb+ql35d9xUo
 Sz/epifT4/hJkeA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Introduce two callbacks which does nothing. They are used in replacement
of NULL and it avoid kernel OOPS if this NULL is called.

If those callback are used, it means that there is a mismatch between
what formats are announced by atomic_check and what is realy supported by
atomic_update.

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 45 ++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 6b3e17374b19..c28c32b00e39 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -135,6 +135,21 @@ static void RGB565_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
 	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
 }
 
+/**
+ * magenta_to_argb_u16() - pixel_read callback which always read magenta
+ *
+ * This callback is used when an invalid format is requested for plane reading.
+ * It is used to avoid null pointer to be used as a function. In theory, this function should
+ * never be called, except if you found a bug in the driver/DRM core.
+ */
+static void magenta_to_argb_u16(u8 *in_pixel, struct pixel_argb_u16 *out_pixel)
+{
+	out_pixel->a = (u16)0xFFFF;
+	out_pixel->r = (u16)0xFFFF;
+	out_pixel->g = 0;
+	out_pixel->b = (u16)0xFFFF;
+}
+
 /**
  * vkms_compose_row - compose a single row of a plane
  * @stage_buffer: output line with the composed pixels
@@ -237,6 +252,16 @@ static void argb_u16_to_RGB565(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
 	*pixel = cpu_to_le16(r << 11 | g << 5 | b);
 }
 
+/**
+ * argb_u16_to_nothing() - pixel_write callback with no effect
+ *
+ * This callback is used when an invalid format is requested for writeback.
+ * It is used to avoid null pointer to be used as a function. In theory, this should never
+ * happen, except if there is a bug in the driver
+ */
+static void argb_u16_to_nothing(u8 *out_pixel, struct pixel_argb_u16 *in_pixel)
+{}
+
 /**
  * vkms_writeback_row() - Generic loop for all supported writeback format. It is executed just
  * after the blending to write a line in the writeback buffer.
@@ -260,8 +285,10 @@ void vkms_writeback_row(struct vkms_writeback_job *wb,
 
 /**
  * get_pixel_conversion_function() - Retrieve the correct read_pixel function for a specific
- * format. The returned pointer is NULL for unsupported pixel formats. The caller must ensure that
- * the pointer is valid before using it in a vkms_plane_state.
+ * format.
+ *
+ * If the format is not supported by VKMS a warning is emitted and a dummy "always read magenta"
+ * function is returned.
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */
@@ -284,18 +311,21 @@ pixel_read_t get_pixel_read_function(u32 format)
 		 * format must:
 		 * - Be listed in vkms_formats in vkms_plane.c
 		 * - Have a pixel_read callback defined here
+		 *
+		 * To avoid kernel crash, a dummy "always read magenta" function is used. It means
+		 * that during the composition, this plane will always be magenta.
 		 */
 		WARN(true,
 		     "Pixel format %p4cc is not supported by VKMS planes. This is a kernel bug, atomic check must forbid this configuration.\n",
 		     &format);
-		return (pixel_read_t)NULL;
+		return &magenta_to_argb_u16;
 	}
 }
 
 /**
  * get_pixel_write_function() - Retrieve the correct write_pixel function for a specific format.
- * The returned pointer is NULL for unsupported pixel formats. The caller must ensure that the
- * pointer is valid before using it in a vkms_writeback_job.
+ * If the format is not supported by VKMS a warning is emitted and a dummy "don't do anything"
+ * function is returned.
  *
  * @format: DRM_FORMAT_* value for which to obtain a conversion function (see [drm_fourcc.h])
  */
@@ -318,10 +348,13 @@ pixel_write_t get_pixel_write_function(u32 format)
 		 * format must:
 		 * - Be listed in vkms_wb_formats in vkms_writeback.c
 		 * - Have a pixel_write callback defined here
+		 *
+		 * To avoid kernel crash, a dummy "don't do anything" function is used. It means
+		 * that the resulting writeback buffer is not composed and can contains any values.
 		 */
 		WARN(true,
 		     "Pixel format %p4cc is not supported by VKMS writeback. This is a kernel bug, atomic check must forbid this configuration.\n",
 		     &format);
-		return (pixel_write_t)NULL;
+		return &argb_u16_to_nothing;
 	}
 }

-- 
2.43.0


