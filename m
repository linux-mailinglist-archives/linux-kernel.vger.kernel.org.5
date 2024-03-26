Return-Path: <linux-kernel+bounces-119385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9317888C801
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72E11C329D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8045142623;
	Tue, 26 Mar 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULruZmpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A01422C9;
	Tue, 26 Mar 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467705; cv=none; b=INCJwJLBvSXd646QWS1ruPrFQaNRH4ofS7GIqLqndMNNrfwfjbN4DhMnUH5aGN4gbzFqXMBC+JdNatXyYvonbDY8ptTetpr1SeN/J/N7qGeQPa1XUAswTe8A3/IZCp7tLaD0kDwX0gFbJ0zN5BTnj6tOy90Hv/w9t1F8Xlc+szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467705; c=relaxed/simple;
	bh=KphIRHuqty8drrA3+chsi6Ea8a803tyozTB0Wym2y9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrFIUn5iYfyfx4ezhQ362nGW4JgKq+2CkepLu2bFAy6rUvgANE1A/bCALQRaavnBqstabwXmJC4Ehyb4aqtwRs5cAvXLEalTSHUhJwPTfLl0pQ2t8Y8aDHLVkvRADSLmuBX9v0XuOklLMYku75XTqXZ0aXVceU9eZNXkZaBnL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULruZmpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EDCC433F1;
	Tue, 26 Mar 2024 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467704;
	bh=KphIRHuqty8drrA3+chsi6Ea8a803tyozTB0Wym2y9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ULruZmpa1hFZqTkn1uLbmaHuwhG7uoJOhR9k0+AEUO/W4bNsmneQvzCHACYZY7A2B
	 n3efmikYG5ICeSLVVaHMXRRgJQQxw65il2/ykGYNzydCXBUOANLRtXcbKb9hk9wzbl
	 09JXdpme290b5Ela8lLlWgLnOTZjWa12f5BSBAPTTKE3sW4qd7OA9Mg6oL5a+wLAU0
	 STGH4SYj/7V26D5jFZJE7pgcZJJ2jC0Z8cTtCzYzuuCjREcsRqKVlsjYlviIuiAmko
	 SFOI5SMAKvpc7anmksP2G8p767oXFEuyIG3JgpuKTKj+Uo8ThGyp/MY8cQcilWBeBY
	 Rrj5rW+An4bOA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 Mar 2024 16:40:30 +0100
Subject: [PATCH v11 26/28] drm/vc4: tests: Convert to plane creation helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240326-kms-hdmi-connector-state-v11-26-c5680ffcf261@kernel.org>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
In-Reply-To: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
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
 h=from:subject:message-id; bh=KphIRHuqty8drrA3+chsi6Ea8a803tyozTB0Wym2y9I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGlMb7KeCx8W/a/umv9+DffExl8prC/+7F53ov3bjmhxn
 bBaC0OTjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRPXyM9R43nn04KJFeMttP
 5vSGC5cblmrfDVtqkjTFpmy96guBuOKnG5jEvJesXLhjusoErVurhBirWa5/ZvrT1fOxMLp20df
 kcsa/ym9VOhVdj1jMcFp3qXZB+BE7kf/eS4w6supW6l2PkjMHAA==
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
2.44.0


