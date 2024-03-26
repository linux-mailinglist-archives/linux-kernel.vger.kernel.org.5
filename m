Return-Path: <linux-kernel+bounces-119374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0026188C7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F631C623F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE413F428;
	Tue, 26 Mar 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeh96zqX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BCA13EFF4;
	Tue, 26 Mar 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467673; cv=none; b=IU0xLcCNkHQSEzX3UgPiqcTRYxaMLoyRlCmJsqptzvXvBOcfNlVBSvj6WxwbuWF2xIfxnPqxzgUEdu04gVYGLRMljDy20gARtHqGIXyJox+BpsdXrOXEdRCgv/q2krfZi2KBxzYZvo7M3gwirhT8N5LO8RtjroB5wr6KLTbOjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467673; c=relaxed/simple;
	bh=HpUrolYR+ACe5u1nRopOeqbxhk4RPWm36DemTlIjZG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwzfSlk+T+vXOU+xMaZtVLPELHA7GIc4z4QdfYDewWA2LxYDkiNwnwOADthjFWFKc50YK/5ZVm8cmPRVzF6K4Y5sIsQ3H3Hhg4zk6s2Qr4JidlAXJa9CzwzCUK1bT3Wk0iN6H5UiqUECyLlqEe+v3mSHNgsf5CyZpWhAS4MUBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeh96zqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A77C433F1;
	Tue, 26 Mar 2024 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467673;
	bh=HpUrolYR+ACe5u1nRopOeqbxhk4RPWm36DemTlIjZG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aeh96zqX1NDkbfMRTHBQSEuR2u6bhaECadVLXnXrp1hlf8LGy2pne/Xc/v9IY76gC
	 hMZOUwQu7k7tz4ASqPb4PV0J9R7uzuwHIMD4bKtjBH51DVw6+ZHKfrkGogNZMD4XcW
	 X0q2nYynVwpRkht5C9RMD+F1ce9EU/tPttiIOpwrKWTxPSfodUqRzqF30qUmnbmg8A
	 B4A3HABQCcLcNU6eII9bxq+o4uXn17+cUaAEO9B8ww8kjW4GFQvOVRgILtJAW+b6oa
	 kk9iMqoTm7jABly/DYvnHQYNM6G/Eac0fFC1C4zkGQhYhH+qJ+5EcITwyROIKq0E4n
	 XlJ2VtAQDXL6A==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 Mar 2024 16:40:19 +0100
Subject: [PATCH v11 15/28] drm/connector: hdmi: Compute bpc and format
 automatically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-kms-hdmi-connector-state-v11-15-c5680ffcf261@kernel.org>
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
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11722; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HpUrolYR+ACe5u1nRopOeqbxhk4RPWm36DemTlIjZG8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGlMb1IvzrhXPv904oR0m46mI+6P/kx/9bZe2bJOTTdub
 m1/+SSWjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR/emM9Q6n2RgevF8q3xl/
 a17qultP7b/M9Jl6LmbGyj7BCn7td8ZPThftsU5xE59ms9Zry4SpEYwNF9cKhLoyuKune2UXvU6
 STJq2dqpU+n/OnZfKj/4ob1zraDQ/uUs8VqJBLdVK9fG7BgYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that we have all the infrastructure needed, we can add some code
that will, for a given connector state and mode, compute the best output
format and bpc.

The algorithm is equivalent to the one already found in i915 and vc4.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 197 ++++++++++++++++++++-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  25 ++-
 2 files changed, 210 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 063421835dba..b9bc0fb027ea 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: MIT
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_print.h>
 
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
 /**
@@ -46,10 +48,110 @@ connector_state_get_mode(const struct drm_connector_state *conn_state)
 		return NULL;
 
 	return &crtc_state->mode;
 }
 
+static bool
+sink_supports_format_bpc(const struct drm_connector *connector,
+			 const struct drm_display_info *info,
+			 const struct drm_display_mode *mode,
+			 unsigned int format, unsigned int bpc)
+{
+	struct drm_device *dev = connector->dev;
+	u8 vic = drm_match_cea_mode(mode);
+
+	/*
+	 * CTA-861-F, section 5.4 - Color Coding & Quantization states
+	 * that the bpc must be 8, 10, 12 or 16 except for the default
+	 * 640x480 VIC1 where the value must be 8.
+	 *
+	 * The definition of default here is ambiguous but the spec
+	 * refers to VIC1 being the default timing in several occasions
+	 * so our understanding is that for the default timing (ie,
+	 * VIC1), the bpc must be 8.
+	 */
+	if (vic == 1 && bpc != 8) {
+		drm_dbg_kms(dev, "VIC1 requires a bpc of 8, got %u\n", bpc);
+		return false;
+	}
+
+	if (!info->is_hdmi &&
+	    (format != HDMI_COLORSPACE_RGB || bpc != 8)) {
+		drm_dbg_kms(dev, "DVI Monitors require an RGB output at 8 bpc\n");
+		return false;
+	}
+
+	if (!(connector->hdmi.supported_formats & BIT(format))) {
+		drm_dbg_kms(dev, "%s format unsupported by the connector.\n",
+			    drm_hdmi_connector_get_output_format_name(format));
+		return false;
+	}
+
+	switch (format) {
+	case HDMI_COLORSPACE_RGB:
+		drm_dbg_kms(dev, "RGB Format, checking the constraints.\n");
+
+		if (!(info->color_formats & DRM_COLOR_FORMAT_RGB444))
+			return false;
+
+		if (bpc == 10 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_30)) {
+			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n");
+			return false;
+		}
+
+		if (bpc == 12 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_36)) {
+			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n");
+			return false;
+		}
+
+		drm_dbg_kms(dev, "RGB format supported in that configuration.\n");
+
+		return true;
+
+	case HDMI_COLORSPACE_YUV422:
+		drm_dbg_kms(dev, "YUV422 format, checking the constraints.\n");
+
+		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR422)) {
+			drm_dbg_kms(dev, "Sink doesn't support YUV422.\n");
+			return false;
+		}
+
+		if (bpc != 12) {
+			drm_dbg_kms(dev, "YUV422 only supports 12 bpc.\n");
+			return false;
+		}
+
+		drm_dbg_kms(dev, "YUV422 format supported in that configuration.\n");
+
+		return true;
+
+	case HDMI_COLORSPACE_YUV444:
+		drm_dbg_kms(dev, "YUV444 format, checking the constraints.\n");
+
+		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR444)) {
+			drm_dbg_kms(dev, "Sink doesn't support YUV444.\n");
+			return false;
+		}
+
+		if (bpc == 10 && !(info->edid_hdmi_ycbcr444_dc_modes & DRM_EDID_HDMI_DC_30)) {
+			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n");
+			return false;
+		}
+
+		if (bpc == 12 && !(info->edid_hdmi_ycbcr444_dc_modes & DRM_EDID_HDMI_DC_36)) {
+			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n");
+			return false;
+		}
+
+		drm_dbg_kms(dev, "YUV444 format supported in that configuration.\n");
+
+		return true;
+	}
+
+	return false;
+}
+
 static enum drm_mode_status
 hdmi_clock_valid(const struct drm_connector *connector,
 		 const struct drm_display_mode *mode,
 		 unsigned long long clock)
 {
@@ -90,10 +192,101 @@ hdmi_compute_clock(const struct drm_connector *connector,
 	conn_state->hdmi.tmds_char_rate = clock;
 
 	return 0;
 }
 
+static bool
+hdmi_try_format_bpc(const struct drm_connector *connector,
+		    struct drm_connector_state *conn_state,
+		    const struct drm_display_mode *mode,
+		    unsigned int bpc, enum hdmi_colorspace fmt)
+{
+	const struct drm_display_info *info = &connector->display_info;
+	struct drm_device *dev = connector->dev;
+	int ret;
+
+	drm_dbg_kms(dev, "Trying %s output format\n",
+		    drm_hdmi_connector_get_output_format_name(fmt));
+
+	if (!sink_supports_format_bpc(connector, info, mode, fmt, bpc)) {
+		drm_dbg_kms(dev, "%s output format not supported with %u bpc\n",
+			    drm_hdmi_connector_get_output_format_name(fmt),
+			    bpc);
+		return false;
+	}
+
+	ret = hdmi_compute_clock(connector, conn_state, mode, bpc, fmt);
+	if (ret) {
+		drm_dbg_kms(dev, "Couldn't compute clock for %s output format and %u bpc\n",
+			    drm_hdmi_connector_get_output_format_name(fmt),
+			    bpc);
+		return false;
+	}
+
+	drm_dbg_kms(dev, "%s output format supported with %u (TMDS char rate: %llu Hz)\n",
+		    drm_hdmi_connector_get_output_format_name(fmt),
+		    bpc, conn_state->hdmi.tmds_char_rate);
+
+	return true;
+}
+
+static int
+hdmi_compute_format(const struct drm_connector *connector,
+		    struct drm_connector_state *conn_state,
+		    const struct drm_display_mode *mode,
+		    unsigned int bpc)
+{
+	struct drm_device *dev = connector->dev;
+
+	/*
+	 * TODO: Add support for YCbCr420 output for HDMI 2.0 capable
+	 * devices, for modes that only support YCbCr420.
+	 */
+	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPACE_RGB)) {
+		conn_state->hdmi.output_format = HDMI_COLORSPACE_RGB;
+		return 0;
+	}
+
+	drm_dbg_kms(dev, "Failed. No Format Supported for that bpc count.\n");
+
+	return -EINVAL;
+}
+
+static int
+hdmi_compute_config(const struct drm_connector *connector,
+		    struct drm_connector_state *conn_state,
+		    const struct drm_display_mode *mode)
+{
+	struct drm_device *dev = connector->dev;
+	unsigned int max_bpc = clamp_t(unsigned int,
+				       conn_state->max_bpc,
+				       8, connector->max_bpc);
+	unsigned int bpc;
+	int ret;
+
+	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
+		drm_dbg_kms(dev, "Trying with a %d bpc output\n", bpc);
+
+		ret = hdmi_compute_format(connector, conn_state, mode, bpc);
+		if (ret)
+			continue;
+
+		conn_state->hdmi.output_bpc = bpc;
+
+		drm_dbg_kms(dev,
+			    "Mode %ux%u @ %uHz: Found configuration: bpc: %u, fmt: %s, clock: %llu\n",
+			    mode->hdisplay, mode->vdisplay, drm_mode_vrefresh(mode),
+			    conn_state->hdmi.output_bpc,
+			    drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
+			    conn_state->hdmi.tmds_char_rate);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 /**
  * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
  * @connector: DRM Connector
  * @state: the DRM State object
  *
@@ -113,13 +306,11 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		drm_atomic_get_new_connector_state(state, connector);
 	const struct drm_display_mode *mode =
 		connector_state_get_mode(new_conn_state);
 	int ret;
 
-	ret = hdmi_compute_clock(connector, new_conn_state, mode,
-				 new_conn_state->hdmi.output_bpc,
-				 new_conn_state->hdmi.output_format);
+	ret = hdmi_compute_config(connector, new_conn_state, mode);
 	if (ret)
 		return ret;
 
 	if (old_conn_state->hdmi.output_bpc != new_conn_state->hdmi.output_bpc ||
 	    old_conn_state->hdmi.output_format != new_conn_state->hdmi.output_format) {
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index ead998a691e7..a49a544d7b49 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -70,13 +70,10 @@ static int light_up_connector(struct kunit *test,
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	conn_state = drm_atomic_get_connector_state(state, connector);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
-	conn_state->hdmi.output_bpc = connector->max_bpc;
-	conn_state->hdmi.output_format = HDMI_COLORSPACE_RGB;
-
 	ret = drm_atomic_set_crtc_for_connector(conn_state, crtc);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
@@ -251,14 +248,19 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	priv = drm_atomic_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
+	conn = &priv->connector;
+	ret = set_connector_edid(test, conn,
+				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
+				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	conn = &priv->connector;
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
@@ -272,15 +274,15 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
 
 	old_conn_state = drm_atomic_get_old_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_conn_state);
 
-	new_conn_state->hdmi.output_bpc = 8;
+	new_conn_state->max_requested_bpc = 8;
 
 	KUNIT_ASSERT_NE(test,
-			old_conn_state->hdmi.output_bpc,
-			new_conn_state->hdmi.output_bpc);
+			old_conn_state->max_requested_bpc,
+			new_conn_state->max_requested_bpc);
 
 	ret = drm_atomic_check_only(state);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	old_conn_state = drm_atomic_get_old_connector_state(state, conn);
@@ -320,14 +322,19 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	priv = drm_atomic_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
+	conn = &priv->connector;
+	ret = set_connector_edid(test, conn,
+				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
+				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	conn = &priv->connector;
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
@@ -670,11 +677,11 @@ static void drm_test_check_format_value(struct kunit *test)
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
 	conn_state = conn->state;
-	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, 0);
 }
 
 /*
  * Test that the value of the output format property out of reset is set
  * to 0, and will be computed at atomic_check time.

-- 
2.44.0


