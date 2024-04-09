Return-Path: <linux-kernel+bounces-136951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E389DA41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C1B1F2333A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48922131BAF;
	Tue,  9 Apr 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NPTZ89v1"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993C1311B5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669162; cv=none; b=MO9tggAFpWN9x2aGGIk8+rmLImx8UFA07+GTTBH/KbjTyWuNHkpLB8LQsyZPKNsW1quFEtj4FMVmi2XYQL4kx5QCI3ncjUxQuIuTREhC5eIXJHtbDPus+Jmt+xYvHMPiOz4aD361Ikibl5SpVxuFajNFD3v+81hnaNEzmdB4i4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669162; c=relaxed/simple;
	bh=3YA0/IeRYDRRoa1AtSpFlrRW0Pq8ZHlclc1kj1lltms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWII6q33KDebVHpssctOrTfsfTWtuOdlkZ8351NqNbMlBIXkw5IlnqY5GS4BmOBEc9jaHVx7ck3Waj6/tEsJPYbmaEBmgvzN3DaQ4k0oX8tUcIHA7sS+EiVlTLqunnlkN+4Nw1144MXtR5XSgHbZ37LQH6YrOETEG0+mUpgcf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NPTZ89v1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04C8A240021;
	Tue,  9 Apr 2024 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNNUCkQ2cyInliwCdgtDUyF4TqooA01tBHRW2ik0cvU=;
	b=NPTZ89v1+tWlV0wBp7IVsyIjxuWwvi6XhNCIcMudsLJCInU7qots5PYo5YcPIykBUdElCc
	8ctRbFVXlWN4PSoM3XvfrUveVnGGdY92s/keEVnsWCh8Www3BUnmfCnjtgNQewOfQ4ItK5
	ySUgxaY7i3vSU6QJVNIM6RurY6wKrdqC2fQleGgMOW2Z1oe+LxkfrmMhUc9wZG6fHC0MBI
	m2Zsz7Qc59Tz72LiS7Iq7pqbF+PJ3e5mvcZuPQ+rdMncukvuDFKU7q/XWIY6w7d6er7kfO
	vvXCozJd5bV7xKPwq1LmgXLYQIrREBe7lLUYV4cBYsApaIaBlBFcHO7zued5sQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:31 +0200
Subject: [PATCH v6 13/17] drm/vkms: Add range and encoding properties to
 the plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-13-de1c5728fd70@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=GuIKbTcZM/N7g93eJKZQXArSIEda7yyerndYbXPpZc8=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHT8fAqgtW0+UxhuEUv9drK2hP1v/IwEajg1
 aiTzd8kZRCJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB0wAKCRAgrS7GWxAs
 4sBPD/9VvtfhYp0AXiF2aRidb45/dDbD/H4twtHgNHbP2Pr1Q72QQ5fNtPQX7R1hx1e9xnRlB0K
 lJF0GAyjqUMRxtjkk1/t8L5bjfUWF4jtEFPEIGBqge1ybRnxmloDksfWccss1dfXyY4s0NFjope
 kMYgjmzudZZAsDJoptL4/kCe+Nt/m3VdR/ikv5kJfDDS5ZlpzMQs+/jZsUn5Ypei/nPGg2cAQ6j
 x7bKxP6hFCGGf+R2V9WhfPHHF+v15orEpbgcEvsWpy6xazXRp74bSxBdIRLZ1t+tUKhNKiK+L8B
 iQZtoUPnfIF9KeLL9+pNNjk8dpgm9G3D7BEcDLpEBfyqVJqG2bhG18UMwdHF6QEfsN+/ATg/z3e
 2WEBXZIrui4OYwPEGT9ADPkiS7ddbIIYXIRJDyMUOyFs/Qog2SMe0C5JcQy215RkZHHvnnoGR3j
 fpTzKG3eMH3zqSOG9N1/8nnbK5YqdEePe/Jxyxe29bpKLozYtT9JuxUvJjc1uXn1NdWQh7mZjAO
 jzHGRVpyqc4REagxmW0H44znlfwH4+sE7OteCs2QcJk5nNR1D6XikKG+o6Qluadccsv8Emq1RFk
 Y4S9axvSRRaH1k96JbpD+U3YlwuDuhiVGwbjgwuWuJaS+eYU/dU0MnF0uUa0ek3o+vieCICsI/h
 7ZbTMgKgIVIQT+w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Now that the driver internally handles these quantization ranges and YUV
encoding matrices, expose the UAPI for setting them.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
[Louis Chauvet: retained only relevant parts, updated the commit message]
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 2 +-
 drivers/gpu/drm/vkms/vkms_plane.c   | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 2d7445a3de93..a294744d29d6 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -238,7 +238,7 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const u16 *pixel)
 static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
 						  const struct conversion_matrix *matrix)
 {
-	u8 r, g, b;
+	u16 r, g, b;
 	s64 fp_y, fp_channel_1, fp_channel_2;
 	s64 fp_r, fp_g, fp_b;
 
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index d4e375913122..8f764a108b00 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -218,5 +218,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
 					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 
+	drm_plane_create_color_properties(&plane->base,
+					  BIT(DRM_COLOR_YCBCR_BT601) |
+					  BIT(DRM_COLOR_YCBCR_BT709) |
+					  BIT(DRM_COLOR_YCBCR_BT2020),
+					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+					  DRM_COLOR_YCBCR_BT601,
+					  DRM_COLOR_YCBCR_FULL_RANGE);
+
 	return plane;
 }

-- 
2.43.0


