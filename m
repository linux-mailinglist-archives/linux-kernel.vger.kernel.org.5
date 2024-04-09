Return-Path: <linux-kernel+bounces-136949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FFA89DA3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CD41F233A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EDC1311B9;
	Tue,  9 Apr 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mPc1BX4S"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4F130E4A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669160; cv=none; b=JQGIQAGoTqEwNvwVdgJCckmQrKjVrkMuLY2ArRYbhKHKNbeOx6PX1+y6rw4Jld1fDdX5XlrNlipFfuj9wdGqCeXhS2lwtB8fzmK29YUeu3Drn0/O936H8Mj8xb/Lb3LgStTq9hPBEGxcoxyc/rpRq9s/wG4GrJlnxvjOFl8av1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669160; c=relaxed/simple;
	bh=4XaxvY/cAweYN7SOJe5yq3QGEn/dKNihs/Jfqv1vCLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QpQppP+VndTW9lISzhkkiFkRJ/uBE6aIiHHwS5FNNS5JBwN4OWB8vBPB0uFQZUgP5RKO2MUtoen2Zraj4UzAvHbRPmHG2mQimKQ2cWtYnnD7eOl8vSJNSM2nH1NrKuBSgSwEjYX+B8zpOLdyW/mHyrxlstQlK9N25c3ABhrIr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mPc1BX4S; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F5D0240018;
	Tue,  9 Apr 2024 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712669156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2u0GRNid3Th9H3bLBVSqGYconIdWdfP+/YzKnPowrI=;
	b=mPc1BX4S65GLkMe6nzqtjBgmqUYrlBW+ho+xt6OPBW9BuF5slLywY3ngZfmifLRdWe3qnE
	dl9b9ry3mg9wBeIiJXFnWxG4/VvCSE20iU0xLz3EQs3ze1lHLmyLYcb0JtAP/yWI1mIxXo
	AfNgnB2SvXkG2fknBLbeG0qDm7PTzlqqUtm38N5fzL4sd0vSUJ3k1OClmyoGD/bHSY07eP
	k6YDKzP1XNjs4e1WJXmksLpZBEPwMax26YekQI4tQVnlHDHoZw54Q0G4HvXvMz53a+Bnhi
	gwKD2M5PPqIkPMM/oVl5V4C/lwdu4fDHM35Fqt8ELneqT2a++pQxHCGbMc1NMw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 15:25:29 +0200
Subject: [PATCH v6 11/17] drm/vkms: Remove useless drm_rotation_simplify
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-yuv-v6-11-de1c5728fd70@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=4XaxvY/cAweYN7SOJe5yq3QGEn/dKNihs/Jfqv1vCLE=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFUHS0flirwrtAxXfjk0mjdEIFfOqu0cP2F7YR
 Jt/Uzh8/L+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhVB0gAKCRAgrS7GWxAs
 4sPTD/9dujULLjIHUBix3mcO6jW64FcLIURlem6vdE9lSg3/s37eFNMvhnuq3jl/jOC+k/krX2U
 D34NSBiLpzOCgTpL3KKEV87jeV8E9+8/gnmM1HFp9+4Wxxqbq14BaEYvXkobwiPkU+s0oybSUXu
 r3yhlhpP6TYgMO7A9PcuQUN4uxZnVqlJa9uZVoOaJ5Go8nzuOXYLrXBPXOCRDj8zMXgmDYVoc4t
 7o7aue4BFA7PRP9gx7MnctHplbboMmauggyI31smiV117HZ4NWT0jqriomgGfjZRIYU4j8V2M4Q
 Uuz414R96p8WdBg9a3ZPBweL+Px+59Eu504xFkGVUuRByRHhb8tVkPF2CC9UYpSrnuXO0t77Tap
 4bSIaP2gmoRuelsilNXB2zpFZZuFqD307KjrEeya/0lCBkHoMn75PPmvTT920cAoNQRdMtJcmti
 gpn83OMjc/SOZRaaEq15gEACAqIZq86tA3kaIiHogzs08D0gL2nqzdcy83FsZ0j01tI5OztW3GS
 tVA5bs0wC3nHxaqOcxYiisOf1it8M1PnVeOypNen/8bB+6wJSU7tYYPMfCmncdaAlObG5eCTwrV
 ua2DSBV1hKfrFfNukSbNkud+Kng9ilNvPoloVXTU5pUsjTgP5kP16rXxlugDgp4y+r4uVrutKfG
 Xr34vVMQ9laYStg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

As all the rotation are now supported by VKMS, this simplification does
not make sense anymore, so remove it.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8875bed76410..5a028ee96c91 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	frame_info->fb = fb;
 	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
 	drm_framebuffer_get(frame_info->fb);
-	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
-									  DRM_MODE_ROTATE_90 |
-									  DRM_MODE_ROTATE_270 |
-									  DRM_MODE_REFLECT_X |
-									  DRM_MODE_REFLECT_Y);
-
+	frame_info->rotation = new_state->rotation;
 
 	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
 }

-- 
2.43.0


