Return-Path: <linux-kernel+bounces-110241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9139885BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246EBB26E64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCA12A171;
	Thu, 21 Mar 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUmx/d0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21512AAD9;
	Thu, 21 Mar 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035021; cv=none; b=VrcIdI0k9qXQqlutM0aAekJl05EkOFkm3iPQD9CTozEJDhAjJ8ATWQC1EEnQh8XCxfRbQjhNE2ruVfY7QrlxRyGLwooI/kbSlpU6QxSW7R3IuBRNU6DfZbU38E6pya+6Kx2/evHiaWq243mEmAWm6W3cO6h4dl8DRN2WIOH6bmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035021; c=relaxed/simple;
	bh=eZh5pzw0dniP0/FDjzaQfmm2DqdDtInqp+9AiU+xa/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWdQes6a80WKtgn+i0JKFotewyBbsHle5VeupDJOYU/+GCh33WX2UJNr+AGnnS7hHuDJrBDjx2W6tHCekMgU0WE/GMN5tHH2Q400vCBN5YiukZn7v+ULb4v6PzDsONI9Un+Eyy8Cwtt9WXXVhdWF+wIU/5z79I7w3y5WCfL2gZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUmx/d0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF46EC43390;
	Thu, 21 Mar 2024 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035021;
	bh=eZh5pzw0dniP0/FDjzaQfmm2DqdDtInqp+9AiU+xa/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JUmx/d0bsFPXEacNvTPykA5ciuZD+UsE6W/3vo+eSoHJ+CvYQXHXKcqCCRTVH13fF
	 xDLEVqbmmHFlLVZsfqals9HLmtz+d6z2XB2dSNLneC6ySOspx3by+p659h+HY9La3K
	 qYPjXS+lMJ3435QIWKOGtAio5kp/CnZ7LmjAvvCiaUeJW4ki6ci5dKuiQeRoVsMLdP
	 dNQgQW4GR7mI5uUGpydeOkVY6QFRduyDn0UA9b51jLXmxT1YreKZeAHpMfeut4M+0f
	 /6B/LmRu1J1tt/SKNuPqm1HO3vQSO4jSoZ4IoD7s8orqYGyHDUX2L4TgYGn9bOtwPb
	 nsf6TL3TgjoRQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 21 Mar 2024 16:29:15 +0100
Subject: [PATCH v10 19/27] drm/tests: Add RGB Quantization tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-kms-hdmi-connector-state-v10-19-e6c178361898@kernel.org>
References: <20240321-kms-hdmi-connector-state-v10-0-e6c178361898@kernel.org>
In-Reply-To: <20240321-kms-hdmi-connector-state-v10-0-e6c178361898@kernel.org>
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
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13395; i=mripard@kernel.org;
 h=from:subject:message-id; bh=eZh5pzw0dniP0/FDjzaQfmm2DqdDtInqp+9AiU+xa/c=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKl/gny92G5UH3npnZnckvb654b90mHv817VrVP/1H/wS
 8vBZyILOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCRzcsYGQ7P9jhzra7rrOPk
 52/WPX4pJxdk2B95cI/9LXfJZ2WJslIM/1Tr+Q16FnSfVTr72XNNo8Hv/0p36tx2HN6gWK4S0Cp
 jzAwA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The previous commit added the infrastructure to the connector state to
track what RGB Quantization should be used in a given state for an HDMI
connector.

Let's add some kunit tests to make sure it works as expected.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 .../gpu/drm/tests/drm_atomic_state_helper_test.c   | 352 +++++++++++++++++++++
 1 file changed, 352 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c b/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
index 9f500a0bf8a8..7c47c1ddc6ba 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
@@ -350,10 +350,351 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 	KUNIT_EXPECT_FALSE(test, crtc_state->mode_changed);
 }
 
+/*
+ * Test that for an HDMI connector, with an HDMI monitor, if the
+ * Broadcast RGB property is set to auto with a mode that isn't the
+ * VIC-1 mode, we will get a limited RGB Quantization Range.
+ */
+static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_state *state;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_atomic_helper_connector_hdmi_init(test,
+						     BIT(HDMI_COLORSPACE_RGB),
+						     8);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_ASSERT_EQ(test,
+			conn_state->hdmi.broadcast_rgb,
+			DRM_HDMI_BROADCAST_RGB_AUTO);
+
+	ret = drm_atomic_check_only(state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_full_range);
+}
+
+/*
+ * Test that for an HDMI connector, with an HDMI monitor, if the
+ * Broadcast RGB property is set to auto with a VIC-1 mode, we will get
+ * a full RGB Quantization Range.
+ */
+static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_state *state;
+	struct drm_display_mode *mode;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_atomic_helper_connector_hdmi_init(test,
+						     BIT(HDMI_COLORSPACE_RGB),
+						     8);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	mode = drm_display_mode_from_cea_vic(drm, 1);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_ASSERT_EQ(test,
+			conn_state->hdmi.broadcast_rgb,
+			DRM_HDMI_BROADCAST_RGB_AUTO);
+
+	ret = drm_atomic_check_only(state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.is_full_range);
+}
+
+/*
+ * Test that for an HDMI connector, with an HDMI monitor, if the
+ * Broadcast RGB property is set to full with a mode that isn't the
+ * VIC-1 mode, we will get a full RGB Quantization Range.
+ */
+static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_state *state;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_atomic_helper_connector_hdmi_init(test,
+						     BIT(HDMI_COLORSPACE_RGB),
+						     8);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_FULL;
+
+	ret = drm_atomic_check_only(state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_ASSERT_EQ(test,
+			conn_state->hdmi.broadcast_rgb,
+			DRM_HDMI_BROADCAST_RGB_FULL);
+
+	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.is_full_range);
+}
+
+/*
+ * Test that for an HDMI connector, with an HDMI monitor, if the
+ * Broadcast RGB property is set to full with a VIC-1 mode, we will get
+ * a full RGB Quantization Range.
+ */
+static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_state *state;
+	struct drm_display_mode *mode;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_atomic_helper_connector_hdmi_init(test,
+						     BIT(HDMI_COLORSPACE_RGB),
+						     8);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	mode = drm_display_mode_from_cea_vic(drm, 1);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_FULL;
+
+	ret = drm_atomic_check_only(state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_ASSERT_EQ(test,
+			conn_state->hdmi.broadcast_rgb,
+			DRM_HDMI_BROADCAST_RGB_FULL);
+
+	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.is_full_range);
+}
+
+/*
+ * Test that for an HDMI connector, with an HDMI monitor, if the
+ * Broadcast RGB property is set to limited with a mode that isn't the
+ * VIC-1 mode, we will get a limited RGB Quantization Range.
+ */
+static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_state *state;
+	struct drm_display_mode *preferred;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_atomic_helper_connector_hdmi_init(test,
+						     BIT(HDMI_COLORSPACE_RGB),
+						     8);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_LIMITED;
+
+	ret = drm_atomic_check_only(state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_ASSERT_EQ(test,
+			conn_state->hdmi.broadcast_rgb,
+			DRM_HDMI_BROADCAST_RGB_LIMITED);
+
+	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_full_range);
+}
+
+/*
+ * Test that for an HDMI connector, with an HDMI monitor, if the
+ * Broadcast RGB property is set to limited with a VIC-1 mode, we will
+ * get a limited RGB Quantization Range.
+ */
+static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_state *state;
+	struct drm_display_mode *mode;
+	struct drm_connector *conn;
+	struct drm_device *drm;
+	struct drm_crtc *crtc;
+	int ret;
+
+	priv = drm_atomic_helper_connector_hdmi_init(test,
+						     BIT(HDMI_COLORSPACE_RGB),
+						     8);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+
+	conn = &priv->connector;
+	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
+
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	mode = drm_display_mode_from_cea_vic(drm, 1);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_LIMITED;
+
+	ret = drm_atomic_check_only(state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	conn_state = drm_atomic_get_connector_state(state, conn);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
+
+	KUNIT_ASSERT_EQ(test,
+			conn_state->hdmi.broadcast_rgb,
+			DRM_HDMI_BROADCAST_RGB_LIMITED);
+
+	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_full_range);
+}
+
 /*
  * Test that if we change the maximum bpc property to a different value,
  * we trigger a mode change on the connector's CRTC, which will in turn
  * disable/enable the connector.
  */
@@ -1188,10 +1529,21 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 8);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
 }
 
 static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
+	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode),
+	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode_vic_1),
+	KUNIT_CASE(drm_test_check_broadcast_rgb_full_cea_mode),
+	KUNIT_CASE(drm_test_check_broadcast_rgb_full_cea_mode_vic_1),
+	KUNIT_CASE(drm_test_check_broadcast_rgb_limited_cea_mode),
+	KUNIT_CASE(drm_test_check_broadcast_rgb_limited_cea_mode_vic_1),
+	/*
+	 * TODO: When we'll have YUV output support, we need to check
+	 * that the limited range is always set to limited no matter
+	 * what the value of Broadcast RGB is.
+	 */
 	KUNIT_CASE(drm_test_check_broadcast_rgb_crtc_mode_changed),
 	KUNIT_CASE(drm_test_check_broadcast_rgb_crtc_mode_not_changed),
 	KUNIT_CASE(drm_test_check_hdmi_funcs_reject_rate),
 	KUNIT_CASE(drm_test_check_max_tmds_rate_bpc_fallback),
 	KUNIT_CASE(drm_test_check_max_tmds_rate_format_fallback),

-- 
2.44.0


