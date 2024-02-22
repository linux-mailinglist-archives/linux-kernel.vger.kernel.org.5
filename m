Return-Path: <linux-kernel+bounces-77069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA52F8600DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100A6B2335C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B815CD5C;
	Thu, 22 Feb 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTou2p8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328615B992;
	Thu, 22 Feb 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625680; cv=none; b=TXINuz4G4xp/cZrDtc8cEmZUwIg43MnOpU4fHhNStd5VYsDWqFXqeAHvC5Tia6cp3FzKAM8KZGs0NG5at4QVlo8uQbFWMVoN1xUtcnyMRRseqLEqXpFyaqVLqDfHS9/r41brm93ZAIsiL1D0JBysHmeWb78fxTy5zZVAxi+zGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625680; c=relaxed/simple;
	bh=+carovPUcrljcpRVv3z7gkTq0nha5XSrXPMvLfHaNxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZTXZFgiVV/HYcEcrcvkp8caIodlTzMaqGNw0rNujxRH/r4eF4z4rTzin4nXnK99VJeGuHtQSbuNe9TJYNmkcPlG1Gg7ncoY5jNiUIn/wvgXwgLqulPo4ByAXt9eab+r9papuraCUWgMm4TpxwhwXETS4PMNBilRA474ySXFPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTou2p8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDDCC433C7;
	Thu, 22 Feb 2024 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625679;
	bh=+carovPUcrljcpRVv3z7gkTq0nha5XSrXPMvLfHaNxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VTou2p8d5pbdwCO+Z3GcUPUivBLpLhufXqW8+OuEelivIxPbghA+PYfDssNS9cQvW
	 PzMNpHlt7W84SRvfR1YIr4O2j+HqmAPo0Xy/THcrFGkxc4QNIhVVzK+ULkmExuWVnN
	 obPiBogyAuxx+aVMYoDnUETyR4nYjfrKXkC00K5qfvTLdsuAp9XkKRVs57Blyhm1op
	 +fPF6SEw4ku8nyTrYEM3i562cf0WmT530YbXaneZbD8XEI4EzBTb253/RMOcVZus76
	 N+XSHhummEb3AUf3ZgmWC6x1/9/QBgmkeMxFamaU+YuoIU+Wrue7QoWG6gcqf0l3Ys
	 oUTXxM3hfiMAg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Feb 2024 19:13:50 +0100
Subject: [PATCH v7 04/36] drm/tests: Add helper to create mock crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-kms-hdmi-connector-state-v7-4-8f4af575fce2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3793; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+carovPUcrljcpRVv3z7gkTq0nha5XSrXPMvLfHaNxg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnX+16XHBar+OE7IWvpjKy0Y49FT84w9d/UVemtuWmGb
 lbNOZHnHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZjI3zZGhgcLp77/cPPhwsA/
 5nWW8+c+jzRTm/1ljU73On4Xiw+Cp94yMmxf2JHh+i8td3ZH3d2HKjOSLVO1A0QbvZu0Oa50fTc
 r5wAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We're going to need a full-blown, functional, KMS device to test more
components of the atomic modesetting infrastructure.

Let's add a new helper to create a dumb, mocked, CRTC. By default it
will create a CRTC relying only on the default helpers, but drivers are
free to deviate from that.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 62 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           | 10 +++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 32dc8354641a..d5317d13d3fc 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -249,5 +249,67 @@ drm_kunit_helper_create_primary_plane(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_create_primary_plane);
 
+static const struct drm_crtc_helper_funcs default_crtc_helper_funcs = {
+};
+
+static const struct drm_crtc_funcs default_crtc_funcs = {
+	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.reset                  = drm_atomic_helper_crtc_reset,
+};
+
+/**
+ * drm_kunit_helper_create_crtc - Creates a mock CRTC for a KUnit test
+ * @test: The test context object
+ * @drm: The device to alloc the plane for
+ * @primary: Primary plane for CRTC
+ * @cursor: Cursor plane for CRTC. Optional.
+ * @funcs: Callbacks for the new plane. Optional.
+ * @helper_funcs: Helpers callbacks for the new plane. Optional.
+ *
+ * This allocates and initializes a mock struct &drm_crtc meant to be
+ * part of a mock device for a KUnit test.
+ *
+ * Resources will be cleaned up automatically.
+ *
+ * @funcs will default to the default helpers implementations.
+ * @helper_funcs will default to an empty implementation.
+ *
+ * Returns:
+ * A pointer to the new CRTC, or an ERR_PTR() otherwise.
+ */
+struct drm_crtc *
+drm_kunit_helper_create_crtc(struct kunit *test,
+			     struct drm_device *drm,
+			     struct drm_plane *primary,
+			     struct drm_plane *cursor,
+			     const struct drm_crtc_funcs *funcs,
+			     const struct drm_crtc_helper_funcs *helper_funcs)
+{
+	struct drm_crtc *crtc;
+	int ret;
+
+	if (!funcs)
+		funcs = &default_crtc_funcs;
+
+	if (!helper_funcs)
+		helper_funcs = &default_crtc_helper_funcs;
+
+	crtc = drmm_kzalloc(drm, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	ret = drmm_crtc_init_with_planes(drm, crtc,
+					 primary,
+					 cursor,
+					 funcs,
+					 NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_crtc_helper_add(crtc, helper_funcs);
+
+	return crtc;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index 38667d624aa8..6e99627edf45 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -9,6 +9,8 @@
 
 #include <kunit/test.h>
 
+struct drm_crtc_funcs;
+struct drm_crtc_helper_funcs;
 struct drm_device;
 struct drm_plane_funcs;
 struct drm_plane_helper_funcs;
@@ -110,4 +112,12 @@ drm_kunit_helper_create_primary_plane(struct kunit *test,
 				      unsigned int num_formats,
 				      const uint64_t *modifiers);
 
+struct drm_crtc *
+drm_kunit_helper_create_crtc(struct kunit *test,
+			     struct drm_device *drm,
+			     struct drm_plane *primary,
+			     struct drm_plane *cursor,
+			     const struct drm_crtc_funcs *funcs,
+			     const struct drm_crtc_helper_funcs *helper_funcs);
+
 #endif // DRM_KUNIT_HELPERS_H_

-- 
2.43.2


