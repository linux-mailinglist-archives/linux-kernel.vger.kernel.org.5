Return-Path: <linux-kernel+bounces-61655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973D2851501
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BFD28B01F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C3B524A1;
	Mon, 12 Feb 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF+tMWnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB051C43;
	Mon, 12 Feb 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743694; cv=none; b=nakUWu0z7b59uxz8HwW6aEI2QMOmEvTd1+uYEx9ivwI/pUje5xiEABgRhVFmfC12yTNtGo2InBCfdqYuL5PTddB7Ag2j0GFzQt5/WDxcKHXCX86dO1S4TKh9XxWqk9XLXHNA96PB1vuWWDF4Skm2a6zEoDo5gcDo1EDUZoCGMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743694; c=relaxed/simple;
	bh=9I0REbcpKSt1MVBIkF5lrOnJOl7fX+Traw8aZNWXX1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3vLxTlBDncC6QJaCXxd3MWNat2OEOdKW8gWqCllAj9qyPVY/9tvmPpQOYC1XNxWBdz/LG0Sj9WjN+efTFT4sGemqTIYIpZNrSUh+K2wq5KhwHgUsN2MRBl6/t4kNslC2btBonATMwAQs2ixZTt9wrTWbi8SFQAeMXagKuam4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF+tMWnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAE6C43399;
	Mon, 12 Feb 2024 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743694;
	bh=9I0REbcpKSt1MVBIkF5lrOnJOl7fX+Traw8aZNWXX1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CF+tMWnEsHyAg1Jd1/77+v4kTOpFkQj+1p8X/b2Ni0TCg7bGlMtiDNQvJ/yw//UJI
	 8za4jfG4dWuO1GwfwsXvK73pC43gBQu1nOS6yvOJRNHH7BF1TmXHGUrLgflmO7Sv0u
	 9qRfh7z2ASctZLz3dXldHW/MLNXrkv78oTNvvcEBAks3IciAWAQYJDbxfZp7S+0q0O
	 cxWMwwSRmFgGpHayOIWY6x1H77/j0TAR8IHNlRG400rQkdrqPGwC99PlKVCrBUfadb
	 n5ICKvyOdIx++xYUSU8paNth4faiiSE5TQ9rceFz5STpgu3mv2NUQxdxkZ15i1C4w5
	 x/S+Gh+YhVdCQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:13:13 +0100
Subject: [PATCH v6 30/36] drm/vc4: tests: Convert to plane creation helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-30-f4bcdc979e6f@kernel.org>
References: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
In-Reply-To: <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, 
 Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9I0REbcpKSt1MVBIkF5lrOnJOl7fX+Traw8aZNWXX1Y=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJAuvREvsUY9ojPzovJHzkWT07O7tlpqJ/5KrVgQ0K
 G28d1ako5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABOZ+JGR4SUL45T0TsY9+8TK
 ElXbBdIrmyfIu7UlGitd9uLz+pEXwciwx0hnX79esb5BUsfc/5p9dhUGAucnctgGVNRnCCU0yzM
 CAA==
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
2.43.0


