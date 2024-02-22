Return-Path: <linux-kernel+bounces-77109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2806686014F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9463EB2569A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14F140397;
	Thu, 22 Feb 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR1hMWSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5A140366;
	Thu, 22 Feb 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625752; cv=none; b=ivpiZmSf2U/OKS8Nx6mdBtLS5ZY2QRQZgXvFXwyz44SjKRzOTCc3PdPqVwowDhTZw16OHJ2lDHKf6p8MHRvR6BfNNyfLWxThtTKVUXTSQaPau10aWpzeth09MvRBQ5LL3wvNW8s4VvGhPv/X/wB9QuBITlxvw6UPW+j3qBfB+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625752; c=relaxed/simple;
	bh=8tamAetoSgHQ1OcsRskLkqCtZqUknTtgTwiDjxhENTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CG3k+xSMsGSuoDDrClcq2TXpIOpTlBQroLusB5ZafLi2NLBsL60EPugEPjbqFPKaRH+oCPR5JlaV3yea8zrr7WThbaJ+/czFwyvxeaD7hYm1jI4Fl2hFMSR1Vm0DqduhH3YNJOrwjel/VPacIRflPeVuWSmPsAMCD8ZcGSqq7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR1hMWSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C59C433C7;
	Thu, 22 Feb 2024 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625752;
	bh=8tamAetoSgHQ1OcsRskLkqCtZqUknTtgTwiDjxhENTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QR1hMWSIWiLieEB07vaDhgJeHXTdXha3tjaZH33S3sg362WRN1ZZmhTXdIBRJ2RIf
	 kx5G6BVDwCFO2Pw8zKk3fB2XvclUOSpITaHM3lqqvIkXIYzyl96eagH3ajpktkHGz1
	 RqnIoyB6FYqgD63xmGjdZdw+smV+y0a//JDUBtaa+JlqvGSJ2DeBCP3hVa6WBFe0BC
	 QQE2Ify7Tb7bNNr9u3aY2UU5ba24WpD/o0QL6ND+9jauSeUtCls8QxG/nLoBrbfgrr
	 cLgiQYtjjkcwsJFjqul27/k+DKr/TkF29jBqwh7bwT7BBxywGsC8TgpXk8O5R0haLC
	 ksyfoNvuab6Pw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Feb 2024 19:14:16 +0100
Subject: [PATCH v7 30/36] drm/vc4: tests: Convert to plane creation helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-kms-hdmi-connector-state-v7-30-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
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
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8tamAetoSgHQ1OcsRskLkqCtZqUknTtgTwiDjxhENTo=;
 b=kA0DAAoW4+8Nb2cYUcUByyZiAGXXjvyhaRrBDlWjl3LMUICDVFNoGLYbz56S+cfYlsUBjdB/8
 4h1BAAWCgAdFiEEXBM3pF7KmuuJBg6e4+8Nb2cYUcUFAmXXjvwACgkQ4+8Nb2cYUcX6lQD+LVKq
 N8MxTOTivfG8G6auJjmW4gY0MqC1O3/UbUDHPsgBAL3lPa49s3q5gr6HBNPRtQL4Ct9vghvk+cx
 KHDnHkGQN
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that we have a plane create helper for kunit mocked drivers, let's
convert to it in vc4.

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
+	KUNIT_ASSERT_EQ(test, type, DRM_PLANE_TYPE_PRIMARY);
+
+	plane = drm_kunit_helper_create_primary_plane(test, drm,
+						      NULL,
+						      NULL,
+						      NULL, 0,
+						      NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
 
-	drm_plane_helper_add(plane, &vc4_dummy_plane_helper_funcs);
-
 	return plane;
 }

-- 
2.43.2


