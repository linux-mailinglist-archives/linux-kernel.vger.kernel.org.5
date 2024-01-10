Return-Path: <linux-kernel+bounces-22551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A597829F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FD01C217C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953EB4E1A0;
	Wed, 10 Jan 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="KYezJL8p"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE24D59D;
	Wed, 10 Jan 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T9FYC5GngzDqwQ;
	Wed, 10 Jan 2024 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704908672; bh=WibHmCZfubrdUIl1IxqVcLZcKWoO43ZgT2tYTKfxTxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KYezJL8pD+myZse/2G2+P20ErYIm5GjxxS3o67ww77z0snqcT1rgrRHGHmz0qvJGJ
	 9G0JlTcNCfQmb4UH6Dd5vY4EKBeX1UjJCImTYRXXw1pOYp3v2XyZp0HB87fZDkwULE
	 RLfNcAY6Eoppo1sLhfjaQ7drUU6Qo31Tysm+YFLk=
X-Riseup-User-ID: 9FA7D4907E67B96F8A70C063943DBC32D31F05A2CDF76D5EE0C16085438934EC
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T9FY71yY4zJp2K;
	Wed, 10 Jan 2024 17:44:26 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Wed, 10 Jan 2024 14:44:04 -0300
Subject: [PATCH v2 4/7] drm/vkms: Add chroma subsampling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-vkms-yuv-v2-4-952fcaa5a193@riseup.net>
References: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
In-Reply-To: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
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

Add support to chroma subsampling. This should be noop, as all supported
formats do not have chroma subsampling.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 0156372aa1ef..098ed16f2104 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -26,12 +26,15 @@ static size_t pixel_offset(const struct vkms_frame_info *frame_info, int x, int
  * @index: The index of the plane on the 2D buffer
  *
  * Takes the information stored in the frame_info, a pair of coordinates, and
- * returns the address of the first color channel on the desired index.
+ * returns the address of the first color channel on the desired index. The
+ * format's specific subsample is applied.
  */
 static void *packed_pixels_addr(const struct vkms_frame_info *frame_info,
 				int x, int y, size_t index)
 {
-	size_t offset = pixel_offset(frame_info, x, y, index);
+	int vsub = index == 0 ? 1 : frame_info->fb->format->vsub;
+	int hsub = index == 0 ? 1 : frame_info->fb->format->hsub;
+	size_t offset = pixel_offset(frame_info, x / hsub, y / vsub, index);
 
 	return (u8 *)frame_info->map[0].vaddr + offset;
 }
@@ -146,18 +149,23 @@ void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state
 	for (size_t x = 0; x < limit; x++) {
 		int x_pos = get_x_position(frame_info, limit, x);
 
+		bool shoud_inc = !((x + 1) % frame_format->num_planes);
+
 		if (drm_rotation_90_or_270(frame_info->rotation)) {
 			for (size_t i = 0; i < frame_format->num_planes; i++) {
 				src_pixels[i] = get_packed_src_addr(frame_info,
 								    x + frame_info->rotated.y1, i);
-				src_pixels[i] += frame_format->cpp[i] * y;
+				if (!i || shoud_inc)
+					src_pixels[i] += frame_format->cpp[i] * y;
 			}
 		}
 
 		plane->pixel_read(src_pixels, &out_pixels[x_pos], encoding, range);
 
-		for (size_t i = 0; i < frame_format->num_planes; i++)
-			src_pixels[i] += frame_format->cpp[i];
+		for (size_t i = 0; i < frame_format->num_planes; i++) {
+			if (!i || shoud_inc)
+				src_pixels[i] += frame_format->cpp[i];
+		}
 	}
 }
 

-- 
2.43.0


