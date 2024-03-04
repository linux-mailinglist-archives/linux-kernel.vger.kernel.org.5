Return-Path: <linux-kernel+bounces-90832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCE870587
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4961C221C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD95478B;
	Mon,  4 Mar 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TlcsieNk"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9AB53393
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566175; cv=none; b=efgqUhZhAgmDhATA4nLElBmlUGz6MkJylYMmjN6SpL4b3YVCHnmpLlXXyVHkXX8axRTB39JAqeH+lRYgQbNkgH5oAmW6zl/91mCX1Ua2DBhB92A8EiKBnJYTx59z1yAl16THFrRf3MVcj2wQykQCcQJYjVhWZ1RgT3W903oaBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566175; c=relaxed/simple;
	bh=UDYdXh64nw2efVYXX+oGi1DeZb0b5SJFMQTDbjjBSro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELcEBCAIwUbUwBlfIiD/GgycfDkhAIZs8BOaZsP7dGeLit0JWjLqHJeclOxs9elyCKRwz41twgZ9nR0mmU+iEs7T4b7L+XYc2+cBztEpI6SS+WjduJTLJKxJznmmc3Pajr5a2O9+crQL6NbDWGINpHCgtT9XxBFSFFN8leZuOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TlcsieNk; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3540A1C0010;
	Mon,  4 Mar 2024 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709566172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26jfrCIS+JUx4NErVJifAR1jnrL2bLpCNnl9zevyG7E=;
	b=TlcsieNkAKVFD19DF8gNUqZZYrv3I8hzwSXVbo+CbM9BHBMeA2/5wD8YnKfhWvXv597Nro
	RY3VzSwNJBS8UMkoBi8JGoJvu4iENP7udsOZywqu82ZFa7LBwBLE0QGP+CwPgrZJtHXqxp
	BNx+5NDKtsxunj1GfINU+O71d+yiR263jiN1MNd1qfLrAZTsToi93UHpQl3JIoeGchKbhg
	bf21qE3YtoZkAI+oBkPIDqDlcbncLw4jDBiqUTN1AOcBd74r7uaScTpU0E97gHLpFnaNip
	E1n00vZQrZZzO+PbO3e6qM4ZYnerw0cHj9iClY6WY8pYgUm8lBtj7ld6G87nNA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 04 Mar 2024 16:28:17 +0100
Subject: [PATCH v4 12/14] drm/vkms: Add range and encoding properties to
 the plane
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-yuv-v4-12-76beac8e9793@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Cnbjjk3lDbLwEuT/PRDsmPkqIyFjzRh3yTX0NhmzJqo=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl5ejMXZrje6UM/C+p7h5+cW+P2NbkwUYAEBIyxQsi
 FyLQEMGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZeXozAAKCRAgrS7GWxAs4iCTD/
 9TRgvNYIht1ieF035Yxk5hgxRJjWNAtpZojSWqH1NfhyABwXVy3Pu6aEAy+voqlrx46umtKIwjbqGe
 WAp4YdgEEoc3y4HBvkk8/AxwbIHCKPKUn/cBuLh+Oerkk8Wo+oh+V741ie7YlOJt7WG12QTeJlBJRU
 Ff+J2Y2v+Mf7QWh+xIHqlb/VmyYxnWSwNVqAJdtc/lvzPBTi+VzEqWAE4GJ/7zKgwLPw5aZlQ7ZAfW
 uLcSOjHGZBF9PDPyC3myovy/BDKpf+gQd7IJSteRNsJJSX0Kgd5qyCIdOxq95nF+R43Dx6q+tS2jRN
 9XRXGLzdgyVv+TGQfhYBL7umwwmuaJMCgNeOVrvUxe4UP+C0IGrnRpY0yjxhFAQ5Gq1VGwDxKoHBcN
 uzYNo6DBAYkqoO7xCPcwh5W9w6fE+l1yAgu/uQm800FvOEP1XBdhBvYenWA0lutozTlZPkpxvdwXik
 Gw8kEFWbBKdkNvMr+yACQIKBqwgtfa+pGZeRz++klBSSU8mm19xdklVXvavmEwVRuOKDJHpv6uHvv2
 ErsWkFUAY3sBVKxpbWPtRddvU+ha1bKEP0xRUUzx0bWSl+jJ36O/kVyCmiWo/2/k5+qqhlXEy1+8Sv
 QmbNLXEPSC+xdVVSDaRYImqZYb6PR96+uRf2kafsW1HJYL1IaGmyrMjG1FJw==
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
 drivers/gpu/drm/vkms/vkms_plane.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 93d0a39fa8c5..4bda9ab6e2a4 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -223,5 +223,14 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
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


