Return-Path: <linux-kernel+bounces-95649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680788750B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D14D1F24303
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177113AA5C;
	Thu,  7 Mar 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbzw0YT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615313B28A;
	Thu,  7 Mar 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818806; cv=none; b=m87PrhxycplIj1WJEqS6MJUQXbf95f/nXY1wUOBzIH62rNt1w1pdlZGEbS3eR6+V/X/J/Fokf5MVFcAUa/ndNeQRFgUMUa8IgGLno3ORNgNBnAVfP8KzbLPfLWOY3gHNeNQzK+EhDxabvRXvFHRaG/R+8PvFZLu8JydAanCe/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818806; c=relaxed/simple;
	bh=EewgHdae7h/0M9r/RvBrwLIDoK5b4L1MDAyj2KDv0e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qy4YCHsz7Y4YtHxr44LVylBT/6fLs4EMhKWDj+leLT0L091uX0co4ylFg+DffzoYpRp4gj9EgX3dSF3xNb99diP1qCxFT7NWZhglXxTe4zaOFxM2JSbx9XSNtndVM3mqICpjLwa9ExWCFRb3bHn5yySqxt7oNGTpXYwoJ9ez0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbzw0YT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16083C433C7;
	Thu,  7 Mar 2024 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709818806;
	bh=EewgHdae7h/0M9r/RvBrwLIDoK5b4L1MDAyj2KDv0e0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hbzw0YT0AlzES5hC9S0X/3BFzna2QlBXNfyzleSW2U2MiYwBHo1M+5Fd7mXsNGwKf
	 Md0hSeaPJkMoJAKRovO4V7Th/WKvAU3qJ3uzStm0SnBtgHEdwAcIqIlf3z6JT6AOEZ
	 WwXsKKSoXIZzm77ixGx0Wn2MhfC4/vH1MLkbxeb/5Gxe/mpjTg7nKhMZabaUxByOqe
	 L8oijFj7s4P3CZbNjso2pP2ysNV58qy8TEHNXIw1l38kkvv7iPBdbwBOibUd+R0Tjw
	 FwCw/2JLf+IFgk+WYtHiyoEyXD+BrQr3e98zkJQmhtvedUHnHwn5V3QT3+mkdtb8fj
	 j+p/kpRl8QsSw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 07 Mar 2024 14:38:52 +0100
Subject: [PATCH v8 25/27] drm/vc4: tests: Convert to plane creation helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-kms-hdmi-connector-state-v8-25-ef6a6f31964b@kernel.org>
References: <20240307-kms-hdmi-connector-state-v8-0-ef6a6f31964b@kernel.org>
In-Reply-To: <20240307-kms-hdmi-connector-state-v8-0-ef6a6f31964b@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Sebastian Wick <sebastian.wick@redhat.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EewgHdae7h/0M9r/RvBrwLIDoK5b4L1MDAyj2KDv0e0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKkvD2dP/WS2Ml1P7a5P5eToh2dfqutlVx1QvnNcvOX7E
 l/5t62pHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZhIcQEjQ1Pzx9QQ+2yVqTbf
 2A8ZfTkxYWttomn+hb6zj7pE3sxrC2dkaFNQ91V1vLnw3bNy6c38akLzDq/e9cXyh6LLtPCQywe
 /MgAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that we have a plane create helper for kunit mocked drivers, let's
convert to it in vc4.

Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_mock_plane.c | 34 +++++++-----------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
index 973f5f929097..14357db82238 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_plane.c
@@ -1,43 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <drm/drm_atomic_state_helper.h>
-#include <drm/drm_fourcc.h>
-#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_kunit_helpers.h>
 #include <drm/drm_plane.h>
 
 #include <kunit/test.h>
 
 #include "vc4_mock.h"
 
-static const struct drm_plane_helper_funcs vc4_dummy_plane_helper_funcs = {
-};
-
-static const struct drm_plane_funcs vc4_dummy_plane_funcs = {
-	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
-	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
-	.reset			= drm_atomic_helper_plane_reset,
-};
-
-static const uint32_t vc4_dummy_plane_formats[] = {
-	DRM_FORMAT_XRGB8888,
-};
-
 struct drm_plane *vc4_dummy_plane(struct kunit *test, struct drm_device *drm,
 				  enum drm_plane_type type)
 {
 	struct drm_plane *plane;
 
-	plane = __drmm_universal_plane_alloc(drm, sizeof(struct drm_plane), 0,
-						 0,
-						 &vc4_dummy_plane_funcs,
-						 vc4_dummy_plane_formats,
-						 ARRAY_SIZE(vc4_dummy_plane_formats),
-						 NULL,
-						 DRM_PLANE_TYPE_PRIMARY,
-						 NULL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+	KUNIT_ASSERT_EQ(test, type, DRM_PLANE_TYPE_PRIMARY);
 
-	drm_plane_helper_add(plane, &vc4_dummy_plane_helper_funcs);
+	plane = drm_kunit_helper_create_primary_plane(test, drm,
+						      NULL,
+						      NULL,
+						      NULL, 0,
+						      NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
 
 	return plane;
 }

-- 
2.43.2


