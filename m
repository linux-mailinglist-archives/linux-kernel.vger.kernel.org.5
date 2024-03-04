Return-Path: <linux-kernel+bounces-90828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C8F870583
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DCE1C21EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0B524B4;
	Mon,  4 Mar 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V340mM9e"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68B4DA10
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566171; cv=none; b=KBg/qyymJJo1fchLron2VjCOHulze6RahvXrknD/IwQtd1Qzh7Sf7PfeLNn+qRwb7eDXSw0aBgfem/yPPrd1VcFWXWPdj/qvpHtwcpLmQHtmtPZh+BH5rT2owhJx+dNaPGXDqoKr+Djk9+gv7IbG1U3IbRTqeBHH4AVkGdew+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566171; c=relaxed/simple;
	bh=XzAcWcn+2gPTC+2NmrNB0BrJq5y1708nNfvcdGRsxyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jI4IFQknt/4NX+ZB5XMPKPaH+XouJ44Z/uOCZhIRlnESZyoLnaRZDZIRlURWITRfY0QhsGmhdyYHuNOXHkcJn4mK6eunsc6cKCayD+4LOark4mxS4iKS7L2yse4xZddtCJE5GTYzIKjn9Q0IGotabzoriDmhjkKaA5fXNJxBUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V340mM9e; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00B5B1C000E;
	Mon,  4 Mar 2024 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709566167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlPJwPnunQbGidl7fHxGe4JYFmFSn93i4z+wR+eCxZY=;
	b=V340mM9ebh4hDSnmayeSxNSglNxrj1f5u7xvWPsVXFvoxE/xLBpYmUMQJZL0aFf5vneJ24
	yhD5vU/Cw2APf+1txmZrYf1fkVbTSWV9//srZfnBcHaMXQnU9GQ7CpVvpL6n2FgUri4HNp
	33eFgKOnMQYBwW/oSJk8b/LyzWh5VvayU0oVBua344OHJPD87gtXqyy/DvDmwrBicRXD50
	WYa3Rx20XelYV2/HIwZAfjKoTBhbIEmgaBSClhI8OYQvN3Glq/3qAMerauXnKHTsiAD5GI
	N5sIiPCXWcY1puh7oBonIS1w0VussWxywP0kFEXNti6ejhwi1Z59sU7LjaevWA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 04 Mar 2024 16:28:13 +0100
Subject: [PATCH v4 08/14] drm/vkms: Avoid computing blending limits inside
 pre_mul_alpha_blend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-yuv-v4-8-76beac8e9793@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4025;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=XzAcWcn+2gPTC+2NmrNB0BrJq5y1708nNfvcdGRsxyM=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl5ejMEigVnIk7GZaM3RDJKUfZuS41fLYX6FeURKUO
 wUlMk2CJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZeXozAAKCRAgrS7GWxAs4ky1EA
 CEw8nxLowl2vjtUYcf3BR0As9SZjqf6gU9aVS6z+SF48UKqM09GPw8ZgIUtr0GbcVZH/KxrEb4ckj2
 N5WxU08kkYxkEvYUOyQ/xziP/fi4RJsGPf/o2F/HGP7fWs98UcsF0BvQ63jDgbASvuEY9Oyc9ZjN3/
 eW650EorgyZilJ+u/qAfDbTEVDL3oUw11Ty1gdAYldTMSKoaANy/40mC0gEJvjBWwDTzKpZwmuR+SJ
 egiNxCpB7AOEUzupFMP4dSx6znT3t4G1tnRZPL+V2BfnurTaqx0R1QLFSj6mq+49U2ccYK2bAXDzcu
 JH/pkhatIZl9KfJSU8zW80MiNNuhLTvEpz1UwEXGw21RmJ7E8RQ+ReR2Kl7VYSruKfObGZsjds+JaJ
 2bS0tH2rAesEu/PozDyqJTf49REwbh2I8G5NqgoSp7ewfVB9IMqSoPVwx8qRrE63ZE/J2z4V92lqmQ
 Il9mVFB7k2195HFZyKbc2L/xvtwigsWFslJnf6Ocmi9Qnr6OrgoyCIf12EarVOQEtNprRPjVUeXJWR
 O2MX/TQyePmkTXwvkBAY0P2tMvPtWybX1MemyBfLIY/k3CsxNZ/2ItW+1t6uDMC5s8J8rxySuPgC1K
 mknUrYsC2zPmHCCIj6GUq7PhstjYBfTCZnt9nLKaI9sQEhxCusFRVp9Efm9A==
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
 drivers/gpu/drm/vkms/vkms_composer.c | 43 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index da0651a94c9b..26e8789630bd 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -24,34 +24,33 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
 
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
+static void pre_mul_alpha_blend(
+	const struct line_buffer *stage_buffer,
+	struct line_buffer *output_buffer,
+	int x_start,
+	int pixel_count)
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
+	const struct pixel_argb_u16 *in = &stage_buffer->pixels[x_start];
+
+	for (int i = 0; i < pixel_count; i++) {
+		out[i].a = (u16)0xffff;
+		out[i].r = pre_mul_blend_channel(in[i].r, out[i].r, in[i].a);
+		out[i].g = pre_mul_blend_channel(in[i].g, out[i].g, in[i].a);
+		out[i].b = pre_mul_blend_channel(in[i].b, out[i].b, in[i].a);
 	}
 }
 
@@ -183,7 +182,7 @@ static void blend(struct vkms_writeback_job *wb,
 {
 	struct vkms_plane_state **plane = crtc_state->active_planes;
 	u32 n_active_planes = crtc_state->num_active_planes;
-	int y_pos;
+	int y_pos, x_dst, x_limit;
 
 	const struct pixel_argb_u16 background_color = { .a = 0xffff };
 
@@ -201,14 +200,16 @@ static void blend(struct vkms_writeback_job *wb,
 
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


