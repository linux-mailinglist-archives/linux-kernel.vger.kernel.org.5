Return-Path: <linux-kernel+bounces-61641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B548514D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918B4289628
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BD481BA;
	Mon, 12 Feb 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt0dQRF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17A47A57;
	Mon, 12 Feb 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743671; cv=none; b=rJBqTXuBvlJd6rmi3M5jZ027fmRcas9LpRmj2PL6ViS7Q2bvHwvYyHTYOHdmtR7fMKMmhaUdAQbl/0pWXNAUwgCZg35dUkJ8FxfXYQB0K188xpimJc/oJ0Xna5DIiFwa1B9edGbWluzunwkV6QVKse1cpotcPISY9y0eTUpFx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743671; c=relaxed/simple;
	bh=qjCUh+MOUGaoHfnBp8m5jk+g0FV9Vj8vmvysXWvLAuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lp7B8m0uPUHAVpIz2wwI9CL6NAtfik2lTlb9FMXfas5rr2Vftn02T3k3OTsfXs1ZfdLHLtxsCFCIJQnLX29M/3U3+g3vdeyysYXnwks9jII4CJWRHKbDxrbxgUzVMq+GC+obh1aAU20+myUKz/idKGXh0kJCV8pXwKRxnF0joX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt0dQRF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADDBC3277A;
	Mon, 12 Feb 2024 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743670;
	bh=qjCUh+MOUGaoHfnBp8m5jk+g0FV9Vj8vmvysXWvLAuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rt0dQRF3MEGHjZ6GyqelsvJ6Lplv8YjXD+dViULXEzR9MA6D/cKMBfcPZjOoo5p4g
	 E0lf2h0N1h4RlX5oHsaS0KAGUX4JURpHn7Ha7C/e9TVf8dYAXqspm+vBPX4SG1wvqj
	 nF30sMDzUwDo4TS1gcS2zbPYLck+4n0fIkXCsJp+34NGWCYD0OHFm/E0gDgoklJnHS
	 iKR7LHWPHkEh9eUBkzNZrpM2bqX2mu3eAjkFF3GZERuM0VQNY/T5C8HxNDUS8jS6zu
	 hE00WupkFsbyfMuozkH05W05iUaGLM2vhrUvPyWcJXJnt0DLg2SMhSK8dYoY6sNbIn
	 vtshyAadq8L8A==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:13:05 +0100
Subject: [PATCH v6 22/36] drm/tests: Add HDMI connector rate filter hook
 tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-22-f4bcdc979e6f@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4001; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qjCUh+MOUGaoHfnBp8m5jk+g0FV9Vj8vmvysXWvLAuQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJHOWBSdMXbnm0bKYlNPiuhcX+m6NSs791tnvxnXVJ
 ufAizKHjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzkeRgjQzuLXoiGJtPzI9Ff
 Q0O/G/i2htw9tm+q1+E/h4+cT3RxdWT47zTl2qe27yvF2U1evDxrcvpWxnnt91lvdNaLx21Z7cl
 /lhMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The previous patch adds a new hook for HDMI connectors to filter out
configurations based on the TMDS character rate. Let's add some tests to
make sure it works as expected.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 .../gpu/drm/tests/drm_atomic_state_helper_test.c   | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c b/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
index a43bbfc2c2d0..e7dbdd4a4e7f 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_helper_test.c
@@ -113,6 +113,18 @@ static int set_connector_edid(struct kunit *test, struct drm_connector *connecto
 static const struct drm_connector_hdmi_funcs dummy_connector_hdmi_funcs = {
 };
 
+static enum drm_mode_status
+reject_connector_tmds_char_rate_valid(const struct drm_connector *connector,
+				       const struct drm_display_mode *mode,
+				       unsigned long long tmds_rate)
+{
+	return MODE_BAD;
+}
+
+static const struct drm_connector_hdmi_funcs reject_connector_hdmi_funcs = {
+	.tmds_char_rate_valid	= reject_connector_tmds_char_rate_valid,
+};
+
 static int dummy_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv =
@@ -960,6 +972,58 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate, preferred->clock * 1500);
 }
 
+/*
+ * Test that if we filter a rate through our hook, it's indeed rejected
+ * by the whole atomic_check logic.
+ *
+ * We do so by first doing a commit on the pipeline to make sure that it
+ * works, change the HDMI helpers pointer, and then try the same commit
+ * again to see if it fails as it should.
+ */
+static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
+{
+	struct drm_atomic_helper_connector_hdmi_priv *priv;
+	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_atomic_state *state;
+	struct drm_display_mode *preferred;
+	struct drm_crtc_state *crtc_state;
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
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	conn = &priv->connector;
+	preferred = find_preferred_mode(conn);
+	KUNIT_ASSERT_NOT_NULL(test, preferred);
+
+	drm = &priv->drm;
+	crtc = priv->crtc;
+	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* You shouldn't be doing that at home. */
+	conn->hdmi.funcs = &reject_connector_hdmi_funcs;
+
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
+
+	crtc_state->connectors_changed = true;
+
+	ret = drm_atomic_check_only(state);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
 static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode),
 	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode_vic_1),
@@ -969,6 +1033,7 @@ static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_broadcast_rgb_limited_cea_mode_vic_1),
 	KUNIT_CASE(drm_test_check_broadcast_rgb_crtc_mode_changed),
 	KUNIT_CASE(drm_test_check_broadcast_rgb_crtc_mode_not_changed),
+	KUNIT_CASE(drm_test_check_hdmi_funcs_reject_rate),
 	KUNIT_CASE(drm_test_check_output_bpc_crtc_mode_changed),
 	KUNIT_CASE(drm_test_check_output_bpc_crtc_mode_not_changed),
 	KUNIT_CASE(drm_test_check_tmds_char_rate_rgb_8bpc),

-- 
2.43.0


