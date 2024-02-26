Return-Path: <linux-kernel+bounces-80953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A297866E59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2462E286468
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4475D736;
	Mon, 26 Feb 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nAZWxsWy"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E745C5F2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937276; cv=none; b=AYCrXPL1zRWNMf6KeVZ/MEDsppTTFXw8Ek76RTEgUZji3SZGHeAfQoOkTEgOn9cH3mPHWzFjJAIR4ze2LOfSWOpWXMSCCf+klC/db1MSpSpf1Q7CiEtHwf8EPFm6hf3+y/aFksp7MCt/LDQhZ0NYL91bZdzt+he2wuzphm9HqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937276; c=relaxed/simple;
	bh=WtbjyPm53hzNlCoTEu2tMOVKVRGjW9BjcslmdMUrI3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9iurHpSt3dqKgTp/8HWSf3/NJJy6BEAh4uN7b70etyI83V93KDOHoeEcxQw5tEdxx0ZX7oS6bAQ2d4HkWvayobdpFgtuSZKcSgQNgQO48BNNEX0AvoeJxdYImJIaW0UCanodidTTQwsPTuMBXaK3tOLMtqZOROdpnTkiLiVec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nAZWxsWy; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B4DFE0016;
	Mon, 26 Feb 2024 08:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708937273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFcELKdEH2CqVcdv8HdPB42K6t4+ILioqNSm5RowIZQ=;
	b=nAZWxsWyWy8iTA5GHKJyzVaWbQmel+ZWRgnuyrCc/8PgHYNNXsZPAdmwoxY61t2H3XLg+O
	2JnSpzn3XASIQQ9iPKdhGZ7LOAr74/KIsBwd0tO3u3EqxLHPD6//WQ6cOFMVuC4gr4bQw2
	MvpyS7Jy7B0kq70ltMDJ9gtuItgr7xQgZ6RLph9W/qiANF5GJLUBHBXC1Wm/TZB+5Qb6s6
	6Z1PksbFMMubdkv0X7M4y6KlzkOhxFzYP0VpSQLI9OsD2taQXd4gc51c/U9tzFHrHd6aUO
	J05VU5gAun+jj9bfeeue+kOhvqQxKdTCWw/JQLu7H+6NMpi4Nb0TeyvqDcy9Wg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 26 Feb 2024 09:46:37 +0100
Subject: [PATCH v3 7/9] drm/vkms: Add range and encoding properties to
 pixel_read function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-yuv-v3-7-ff662f0994db@bootlin.com>
References: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
In-Reply-To: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=vFKwJ9LvmL6TH9o/eb/NeXNgMqZMacWZ1OBVcb0LDIk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl3FAukzY8KaZO7FMrnXURFUQb3OqcogtEjW+Jtayr
 VMHCBb+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdxQLgAKCRAgrS7GWxAs4gDZD/
 9KQ0ph+07NE94lo1zi5xUwN1JnjbzuPErCi9fwe04Xscm8paR3OegBCno8Znh2frrFqUuF+Sxn/y1g
 7RFOJGME6nFyt+3hadE5D8CC2P+HPa7ZdiKGo85Vn+ETVfK15Iwn8OUkCoazpNus+yDiO6WbWGE7kh
 WPu30pjNyvs1z1/jZvKWEzHbfISFnOVT9qxNgIr+fDWRzRKboihgWZN91/jZeqQidama75nZmzuVUN
 eVGCYEcHzapsv9qTqS6iqm90NOQ9kQUxfW5Zh8NSOHajdJkIoMUb41hRNhIhx4vmuYBzOX5eGLyWSu
 SzglPYVkd4udTyDlfIeeuYdDrmqqd3leIXCm5MW1dfTpIYg/31u3a98L3ED0IahHlbHg+3M4O6tySJ
 FIGoUiHLtCbPwgPR5GhLrjx2q8n77vUAtxaLxtBkdA8lYLh12rdaTdQJRdV42alNZ851GSS30DNxHq
 Rh4niDXfL0u+OREdpJIOk5N427TWK3YT7YR2b4byvHByCe5gUFqrd6ApQ/HqHyeWHUQTiEjM0zIsoN
 JV0BlO2FeIItTCsGQ9zL3Ie8tbdeqE5+Mz+NP2KHLOGrbw5uZP/kMAspexquIcuFV8H09gdv6btrFb
 RCEgr561YMVP/AoD5Dz/bUlb7+FDnHyHL2FohJ8jEVFocmpsO2qZg+4tuQow==
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


