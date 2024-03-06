Return-Path: <linux-kernel+bounces-94525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA9C874110
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204E71F24D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F0142914;
	Wed,  6 Mar 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="KBUssgDW"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF1142906
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755433; cv=none; b=umStkdhyUxojdqY0rRLJRw1AorJtK9dwJ9HsfZz70tE+Uo8+iCOgpr+1T9liCcZ/g4JagVoUrvwbAKZBIOvAoaGNiUL2iGq3zN0hxWgw59wDjYZAtRj3fZCNAzWCP8pRKdfbyC1Zm5nAg1mkgd6S23rYdMNaWlohCHxxVAq2xi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755433; c=relaxed/simple;
	bh=59X3+X8y6CRkn1d/16QLRYbU3Gb1zh88V0W6zGldVwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibC1FYk0hjP2hGPF+h73v8/GnO80k+SsScrC1rOB3Mkmi/Krue2NxNZOltHqqtycTLLMaUYKKp0D5ucg0trkr8lQIF2tOYjZCe4gb/oSyumKuzdSSd+qbgXUZC3vRos/NawoVO/kARgL0Pkp9hpu/57nEbL+O9/tQCWuRsDib20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=KBUssgDW; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Tqk063sk5zDqKS;
	Wed,  6 Mar 2024 20:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709755431; bh=59X3+X8y6CRkn1d/16QLRYbU3Gb1zh88V0W6zGldVwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KBUssgDWvwO9q+Gyw3HMYjgIM0oUz4Z4asd7o11r9o4zGCFdblqryU2gx7x8V81z2
	 kOpIk+hRxkw7eCFKbyMVZNdx8Gh1VR2BuUxu0yi2kgu69UCAAUH68c/n13pYgyxF4T
	 DcnFyDwhSPa4wEalA6KhGslmAeaYJnK3jpRmsi0w=
X-Riseup-User-ID: 6CED4191914E2568ECF5ECDD7B8DA489F5CCA88F9C04B501EB2B99EDD3282301
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Tqk014150zFvsZ;
	Wed,  6 Mar 2024 20:03:45 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Wed, 06 Mar 2024 17:03:11 -0300
Subject: [PATCH 4/7] drm/vkms: Fix compilation issues
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-louis-vkms-conv-v1-4-5bfe7d129fdd@riseup.net>
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

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h               | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
index 4636b013602f..3522ecee960f 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -113,7 +113,7 @@ static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
 	for (size_t i = 0; i < param->n_colors; i++) {
 		const struct format_pair *color = &param->colors[i];
 
-		const struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
+		struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
 			(DRM_FORMAT_NV12, param->encoding, param->range);
 
 		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, matrix);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 393b76e7c694..3d62578499ab 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -47,6 +47,10 @@ struct pixel_argb_u16 {
 	u16 a, r, g, b;
 };
 
+struct pixel_yuv_u8 {
+	u8 y, u, v;
+};
+
 struct line_buffer {
 	size_t n_pixels;
 	struct pixel_argb_u16 *pixels;

-- 
2.43.0


