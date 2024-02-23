Return-Path: <linux-kernel+bounces-78240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693B86109A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8B51C21043
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669C7EF0C;
	Fri, 23 Feb 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HtFNrbhf"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED97AE72
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688275; cv=none; b=EjA92QhtcgXFN8NoXpJaJXM1d7O9hQLJmfFmUo3IKgUAEqf4qsv66QwjfOHyuPijkWQKZX3J7YZgiQQSErhZdc1APpdeyV06zXRQlzjIu/BkRPVAql7YNfncwE8TKYOl8/nmpQCpqkdyUMpiB8HSeGVsEq8tadTHmSUff5IUbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688275; c=relaxed/simple;
	bh=WtbjyPm53hzNlCoTEu2tMOVKVRGjW9BjcslmdMUrI3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEzbGlbBseO5/wQzzHs8HJCF7VjlIv8Wj9VnXZS63ZGaLaUTdI3f8FdeqnoiA51dRFA9a6KbeQLiqA5lDdSx5juImjczahPLt14hNBVU9Y7gUCWZsG+p1JyzZD7CWshfoYYhPOXJWP7ourf5wq/kFu142WBJ+6cG6yH8OK1fcb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HtFNrbhf; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27C7C40003;
	Fri, 23 Feb 2024 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708688269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFcELKdEH2CqVcdv8HdPB42K6t4+ILioqNSm5RowIZQ=;
	b=HtFNrbhfDTpPlBwtHxSzSJxfEuq60WAuKXwJdaBo4hgsGgF9pVnGIs4W6S/CCfKmRkX3sr
	T7Oy1/0CvQKzqaJd+qmXeCT1CLwsV445vJjMNlaVUEjI++41G6V9EN/Cn1Ojqd4nxXIB0q
	v3roSWFKsqAwDU2izoNYqK914PrP4QvxsIdng2QzwHqZp2G4gkk8rBGUOShtdXuuGwz98A
	5pfULL3Ug8pViDa9o0i4ZrxsCnOIBV310u0UNT6RTXEutJ4j+BUd0HU3FwxepJiUMLzDLg
	8VAbt5o/ZFlbTDA26x2BK+qdI6pRaxLRsS9pgbVM2JuEQvQ9ITu+06VEiO/vaQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 12:37:27 +0100
Subject: [PATCH v2 7/9] drm/vkms: Add range and encoding properties to
 pixel_read function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-yuv-v2-7-aa6be2827bb7@bootlin.com>
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
In-Reply-To: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=vFKwJ9LvmL6TH9o/eb/NeXNgMqZMacWZ1OBVcb0LDIk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2IOFEKpQWR6TBGduFZetzzNzHuB0JsIH2jSYFHsu
 mR2gtDqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdiDhQAKCRAgrS7GWxAs4t1WD/
 4m2QsP5UU2cuakyMhmNFSmNzFkI9oUIHva7vKKVeTCVGzIyFx7qkJsa2LztVpJU+YY4X3dOFf0P7fq
 E5sdSreH46Md9PH894Ylu0e1GRUdOwslCKi9ws9tWQhg/R9fOfkUe2ldJ4Kdf+Z2zwjxP9Df98VNHx
 dIqJbVXy8/nrxS4OhfrbExGTttViu1E5+POdQGUvytHhF/uGfK8E1yvq0pr1R/N6wKIsJf4Wr+a87h
 Riur741OnNdH4sY5SOdLVrxvQy/rDjZm5BMzb19Yy53GAHp8a/LyNMlgl19LickQMT1Dhv1ORi1/dg
 ND/qQnuf2rlXrOXfukGp2TsnfofMxrNmlNB9gqti5LY7jS7XmSB1BKCyKGaxjYJ8psj8BtZ8i2eRZS
 gdztDTq5b2A14qtGfw+myJiR3EqTOtOZZ2i1iwdVvzTix0CzolL2BvXLRQGtSQ7tbftVrBJpeZgspU
 lkRHWAZy9VWIhgGCWQVIiicah6F2BGuYePSW3Bg7iRjHZl8s/KopaD5OzTrLOWuPMa5S13vLmJtMfJ
 sa48mt/o5WqikFBwGUTVcpc9J6QVEsiyKUPGLdfAKjWUYc9edxstCuL2bXgjUegLUOTyi7MGxMuS/g
 7hNGx4kTABgx7EceXKcHRMRLLRS3bAl4NDoKqo2/cFRvyzyyX2q1DE+bwF1A==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Create range and encoding properties. This should be noop, as none of
the conversion functions need those properties.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
[Louis Chauvet: retained only relevant parts]
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 427ca67c60ce..95dfde297377 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -228,5 +228,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
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


