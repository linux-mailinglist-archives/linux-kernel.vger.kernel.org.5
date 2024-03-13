Return-Path: <linux-kernel+bounces-102301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515487B048
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5CF28DE21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1C134721;
	Wed, 13 Mar 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C9KMtrT1"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAB664C0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351940; cv=none; b=UjD4296bDnNvLraAkGgQP+mdJMesGyW9yZpiBsw9LVwfEzVWIWQGuzyeWJvzjd7TZJLMIGcPxGSbJ13X4HKt+dh32hWsGTfpbHzCeU66Td/+OhHpyRSIwIQ2IA/FO1o3Dn6ieFYpETLsxC84VraFbdfaPXkFpJ7NEuXsfrsRtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351940; c=relaxed/simple;
	bh=LN600J/FnLEqSMjYXKqVPbLYRqj27Lwqilp/WDPlSs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OT/MmErH2BFKUTrI2KKJ8AbY48dxHuAYMt/cC/l6PKepG7LMG3yu8I2DMkxyQoULFJTv1JXoGyHVRZMQ5I9Uf/TmJHuelEATUYkIP1nxJk/4RolwwmxLO4nhhEYcjkEQOQVdGNGy45hoe90Dh34ddKCxiSvEE3TRXFuuWPU8aiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C9KMtrT1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D7FD40008;
	Wed, 13 Mar 2024 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710351935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMstdhDPz4vxVLkbs1vWT/dPmbE9XkubESTK+znot4g=;
	b=C9KMtrT1eyc93j8aSzRoeI+Anfo6BTjh8CtgsnrQ4qI945aV8Q7X22IrmF0kSLrcepkKlw
	i5fffyH3Mzd+nR9oWfDMG0n7ihjqXmGW8wWaAxDTi/W6gLCWA1M0IMX7o37s++P5c1VxUt
	pBwsztlBcWDDBtC+pX1mtw9vxM5YI+1WErSn66P144YVanc1bWAY2kau8MPHjwlWdCk19t
	jLm5kS97ZCi+Iip0mXDkuKCUu4L1Z2B63TGyX1Vq0Hhl7KEM/WsFNZVEVPeAEJ/9C1UaiV
	UOqTtjuKIdDLsRqKfr49qe6q3tHFXc6jVqTW/97LUawfSQXqnDsGxiSfvF2DbA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 13 Mar 2024 18:45:02 +0100
Subject: [PATCH v5 08/16] drm/vkms: Avoid computing blending limits inside
 pre_mul_alpha_blend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-yuv-v5-8-e610cbd03f52@bootlin.com>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
In-Reply-To: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4008;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=LN600J/FnLEqSMjYXKqVPbLYRqj27Lwqilp/WDPlSs4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl8eYz9hf3F9w8htumYUb6KlKrtqpbmCKe8R5pvJ+o
 4vwifwaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZfHmMwAKCRAgrS7GWxAs4gxJEA
 Cu7eY95oSNOqvf2k4uAo1LXtF3mJ7ntDFPjgsHg6Ii38d/o9UsDDlznI3IglIqYlm8vMQ3M3itfgjP
 JiY4cvCkjEuI+NCiF4TU9f0dBvNYGWS+YqnUi+9YAhq822Ucjd7xR6SkHCr5KiqRJuTZ20WXQLphfC
 QtNJwbFdMaQEsWtq/YGnguc8C0sJ4E5RZY7M6XWlt30foyGH8gwfSj4wvyqRA5AZy//H0hzdqy02FD
 +83HSAmVpn+CeUG70MdP0cdF2avbi/E3reUT2RGR1OPIRk27LT5Wec7Ofw9OZf1w5hLgR8Jayfug49
 6rPJhrWvamqc3EeCZ6GLdJWPZn8wRVcVIo8L2QuCFup0uGPvZj4Z1wfabwiI/CWxtGRvVbIKv8eWVT
 EYcSZO2/dnk7dP604BXSX4LyZv5C5PIvIM9/M2sP995Qh2P9J9MHg2cykjm+TOuDdpq1wrXP5MZydR
 iR+2eQnGd2+hvIp+QPb6Jlnukq+ja9yNlplS73kK1KYyaQft7YNzA6rUWFLGsRJlZqu5HKnvU1iZWQ
 Cpj8kQWtyk3ikdaZEft2dVdDVSWvyrTaUNa5RdnNLDjKNXmEfTf2KLikJFIeytx8IAfIBvAgjlKxoJ
 fTnjopTJbccwWzppmiOtBSFt5GquwRuTT8qMFiRPr/WRcPnpV+IhuQpVOsbA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
different concepts (coordinate calculation and color management), extract
the x_limit and x_dst computation outside of this helper.
It also increases the maintainability by grouping the computation related
to coordinates in the same place: the loop in `blend`.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index da0651a94c9b..9254086f23ff 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
 
 /**
  * pre_mul_alpha_blend - alpha blending equation
- * @frame_info: Source framebuffer's metadata
  * @stage_buffer: The line with the pixels from src_plane
  * @output_buffer: A line buffer that receives all the blends output
+ * @x_start: The start offset to avoid useless copy
+ * @count: The number of byte to copy
  *
- * Using the information from the `frame_info`, this blends only the
- * necessary pixels from the `stage_buffer` to the `output_buffer`
- * using premultiplied blend formula.
+ * Using @x_start and @count information, only few pixel can be blended instead of the whole line
+ * each time.
  *
  * The current DRM assumption is that pixel color values have been already
  * pre-multiplied with the alpha channel values. See more
  * drm_plane_create_blend_mode_property(). Also, this formula assumes a
  * completely opaque background.
  */
-static void pre_mul_alpha_blend(struct vkms_frame_info *frame_info,
-				struct line_buffer *stage_buffer,
-				struct line_buffer *output_buffer)
+static void pre_mul_alpha_blend(const struct line_buffer *stage_buffer,
+				struct line_buffer *output_buffer, int x_start, int pixel_count)
 {
-	int x_dst = frame_info->dst.x1;
-	struct pixel_argb_u16 *out = output_buffer->pixels + x_dst;
-	struct pixel_argb_u16 *in = stage_buffer->pixels;
-	int x_limit = min_t(size_t, drm_rect_width(&frame_info->dst),
-			    stage_buffer->n_pixels);
-
-	for (int x = 0; x < x_limit; x++) {
-		out[x].a = (u16)0xffff;
-		out[x].r = pre_mul_blend_channel(in[x].r, out[x].r, in[x].a);
-		out[x].g = pre_mul_blend_channel(in[x].g, out[x].g, in[x].a);
-		out[x].b = pre_mul_blend_channel(in[x].b, out[x].b, in[x].a);
+	struct pixel_argb_u16 *out = &output_buffer->pixels[x_start];
+	const struct pixel_argb_u16 *in = stage_buffer->pixels;
+
+	for (int i = 0; i < pixel_count; i++) {
+		out[i].a = (u16)0xffff;
+		out[i].r = pre_mul_blend_channel(in[i].r, out[i].r, in[i].a);
+		out[i].g = pre_mul_blend_channel(in[i].g, out[i].g, in[i].a);
+		out[i].b = pre_mul_blend_channel(in[i].b, out[i].b, in[i].a);
 	}
 }
 
@@ -183,7 +179,7 @@ static void blend(struct vkms_writeback_job *wb,
 {
 	struct vkms_plane_state **plane = crtc_state->active_planes;
 	u32 n_active_planes = crtc_state->num_active_planes;
-	int y_pos;
+	int y_pos, x_dst, x_limit;
 
 	const struct pixel_argb_u16 background_color = { .a = 0xffff };
 
@@ -201,14 +197,16 @@ static void blend(struct vkms_writeback_job *wb,
 
 		/* The active planes are composed associatively in z-order. */
 		for (size_t i = 0; i < n_active_planes; i++) {
+			x_dst = plane[i]->frame_info->dst.x1;
+			x_limit = min_t(size_t, drm_rect_width(&plane[i]->frame_info->dst),
+					stage_buffer->n_pixels);
 			y_pos = get_y_pos(plane[i]->frame_info, y);
 
 			if (!check_limit(plane[i]->frame_info, y_pos))
 				continue;
 
 			vkms_compose_row(stage_buffer, plane[i], y_pos);
-			pre_mul_alpha_blend(plane[i]->frame_info, stage_buffer,
-					    output_buffer);
+			pre_mul_alpha_blend(stage_buffer, output_buffer, x_dst, x_limit);
 		}
 
 		apply_lut(crtc_state, output_buffer);

-- 
2.43.0


