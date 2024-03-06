Return-Path: <linux-kernel+bounces-94523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953587410B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D422C280D70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDC8140E46;
	Wed,  6 Mar 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="JZYrCyhu"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2A1386A3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755427; cv=none; b=EgFZypxQI532LWWl5DGk8QEVzPqrLn2OcOKjnX8wriusqG4WVdOIBix8ATD7iyGapvYH4JGV+RlqTplKmd5GFi/w2D7BRFJQsK4muSXi7KKIaXpMjBhvC8H0HBcUcaylmFfszQNQPgxHXtAXisc10P2F/ssSiMbBx2Li4WDIpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755427; c=relaxed/simple;
	bh=aJDZ4Vxhj0c8mxaTvf8OfzINnVswHkVDwaZ4BftVAO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gA1dW74CwChncyg3bAGyKsdcuB4txM44LpenjTUY4HY1id6EXAj9n7uelS02rkVCYYcBSkGx7yyiJgeR/WGGpwiBlPLLC2xStmZrOzXWcQ7XP6Th+GTwJJBA4FQHHQO60cLWUQlu5mjhbdwSgyDA8vtZig8jIQxFvf0p7pRUoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=JZYrCyhu; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Tqk012NgDzDq8y;
	Wed,  6 Mar 2024 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709755425; bh=aJDZ4Vxhj0c8mxaTvf8OfzINnVswHkVDwaZ4BftVAO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JZYrCyhuwaxxvwBmTWhTbdwqX+yxQfSBhbOKo8LCyht1hV3D+3qC0oaNLnJIHVnn9
	 k3El+VABMgfJlqtz/QhtvkSlofZ7N6hdiNS7EU0pQOB3j+5UfOhNBBdvY4pcOSPCvC
	 jR9rUVynAMVSt7YuhVcjbD+sNJtXdQmQV4V0LGJo=
X-Riseup-User-ID: DADEB8FF0353ACC6617D59334D8182D0B118D71F27E0E6AC0D010F7BF29A0ECC
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Tqjzw1r4LzFvr9;
	Wed,  6 Mar 2024 20:03:40 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Wed, 06 Mar 2024 17:03:10 -0300
Subject: [PATCH 3/7] drm/vkmm: Use drm_fixed api
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-louis-vkms-conv-v1-3-5bfe7d129fdd@riseup.net>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
In-Reply-To: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com

With the new 32.32 values it makes more sense to use drm_fixed functions
than trying to recreate the wheel.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 54 +++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 55ed3f598bd7..adde53cdea26 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -191,32 +191,34 @@ VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 cb, u8 cr,
 						  struct conversion_matrix *matrix)
 {
 	u8 r, g, b;
-	s64 y_16, cb_16, cr_16;
-	s64 r_16, g_16, b_16;
-
-	y_16 = y - matrix->y_offset;
-	cb_16 = cb - 128;
-	cr_16 = cr - 128;
-
-	r_16 = matrix->matrix[0][0] * y_16 + matrix->matrix[0][1] * cb_16 +
-	       matrix->matrix[0][2] * cr_16;
-	g_16 = matrix->matrix[1][0] * y_16 + matrix->matrix[1][1] * cb_16 +
-	       matrix->matrix[1][2] * cr_16;
-	b_16 = matrix->matrix[2][0] * y_16 + matrix->matrix[2][1] * cb_16 +
-	       matrix->matrix[2][2] * cr_16;
-
-	// rounding the values
-	r_16 = r_16 + (1LL << (CONVERSION_MATRIX_FLOAT_DEPTH - 4));
-	g_16 = g_16 + (1LL << (CONVERSION_MATRIX_FLOAT_DEPTH - 4));
-	b_16 = b_16 + (1LL << (CONVERSION_MATRIX_FLOAT_DEPTH - 4));
-
-	r_16 = clamp(r_16, 0, (1LL << (CONVERSION_MATRIX_FLOAT_DEPTH + 8)) - 1);
-	g_16 = clamp(g_16, 0, (1LL << (CONVERSION_MATRIX_FLOAT_DEPTH + 8)) - 1);
-	b_16 = clamp(b_16, 0, (1LL << (CONVERSION_MATRIX_FLOAT_DEPTH + 8)) - 1);
-
-	r = r_16 >> CONVERSION_MATRIX_FLOAT_DEPTH;
-	g = g_16 >> CONVERSION_MATRIX_FLOAT_DEPTH;
-	b = b_16 >> CONVERSION_MATRIX_FLOAT_DEPTH;
+	s64 fp_y, fp_cb, fp_cr;
+	s64 fp_r, fp_g, fp_b;
+
+	fp_y = y - matrix->y_offset;
+	fp_cb = cb - 128;
+	fp_cr = cr - 128;
+
+	fp_y = drm_int2fixp(fp_y);
+	fp_cb = drm_int2fixp(fp_cb);
+	fp_cr = drm_int2fixp(fp_cr);
+
+	fp_r = drm_fixp_mul(matrix->matrix[0][0], fp_y) +
+	       drm_fixp_mul(matrix->matrix[0][1], fp_cb) +
+	       drm_fixp_mul(matrix->matrix[0][2], fp_cr);
+	fp_g = drm_fixp_mul(matrix->matrix[1][0], fp_y) +
+	       drm_fixp_mul(matrix->matrix[1][1], fp_cb) +
+	       drm_fixp_mul(matrix->matrix[1][2], fp_cr);
+	fp_b = drm_fixp_mul(matrix->matrix[2][0], fp_y) +
+	       drm_fixp_mul(matrix->matrix[2][1], fp_cb) +
+	       drm_fixp_mul(matrix->matrix[2][2], fp_cr);
+
+	fp_r = drm_fixp2int_round(fp_r);
+	fp_g = drm_fixp2int_round(fp_g);
+	fp_b = drm_fixp2int_round(fp_b);
+
+	r = clamp(fp_r, 0, 0xff);
+	g = clamp(fp_g, 0, 0xff);
+	b = clamp(fp_b, 0, 0xff);
 
 	return argb_u16_from_u8888(255, r, g, b);
 }

-- 
2.43.0


