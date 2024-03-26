Return-Path: <linux-kernel+bounces-119362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F8A88C7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDBF3220BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73413D8A6;
	Tue, 26 Mar 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbr8mrD4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796C13D88D;
	Tue, 26 Mar 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467639; cv=none; b=SzzIp3LhlcFaPBHpoMv31htE2tqYcYJF4Vq0PPhRZjqVRhfpzl/5uOaHAeYkrhqHTmDLQtT/TKsDle+42vci7IRhCsbxfdDPmvyVI7lbzWO3KuqqpN38rWLwHGxKtnKo4kJ1TY2MPs/X6eW/FvXQkxTy6Fhfzs9Pg8HO7zmL2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467639; c=relaxed/simple;
	bh=SrnWZ5KkC/XwgOJuxIVWTq5Vw8YwNfeJAKkOYup4OWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HE3MgGQTxHfGI8KGjHsdIIyGPKe4DCiisibA3xJ4+XbF6nZAgmnvOTd2FytqQmyZMe3cfPJ2qk4GRHy0S3HpsGacX4Ympt5s0NVhpla6bYFHbyIcAkEa5ZAfTrMH+FdQ+c0tgcDcR0h57lr2rKNq+Ftj2GLdx9FCM81ANRE9F2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbr8mrD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343C8C433F1;
	Tue, 26 Mar 2024 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467639;
	bh=SrnWZ5KkC/XwgOJuxIVWTq5Vw8YwNfeJAKkOYup4OWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lbr8mrD4AFlPxRgu2KZESXi4immwnU2XgF8wJkYEtY4A6pfdrLnA+K3KgMPZQduUU
	 Hs6Tox1SvcrgLbf2phWEKKBLg1EpDu5xUz75zwlCJ1d1EQLGR2jYxGXxTkJKWALbyi
	 euIbp5zQYSCWZFt4LO6m40ijsemCAML0uRCZ7sR+o/L7hFpWasVySblrYFsDmscEwg
	 7usCxeuW9FpZJgukELnijILNggt+I6Jg99R3ilKen+P1UmYomoZGcpI1IiYsldVL0G
	 rbeF7BfRRYOmleE2qMg8i1tbo+zCYdz+H836MWmYn3O51dUH5AVEIT/emDUhXXok0m
	 cf+du1DdozWIA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 Mar 2024 16:40:07 +0100
Subject: [PATCH v11 03/28] drm/tests: connector: Add tests for
 drmm_connector_hdmi_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-kms-hdmi-connector-state-v11-3-c5680ffcf261@kernel.org>
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
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5120; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SrnWZ5KkC/XwgOJuxIVWTq5Vw8YwNfeJAKkOYup4OWM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGlMb+LZzdV8Z+XzsZ57ZhytoJp9YJbt903e7QcO+NrGG
 K1yFrjZMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACayZBpjnX20/O4oJ18b7n0J
 L7oar85ITrgr8ll33+3QP+s+NNzQ7+ALjL6ymX1SYc2iOeHbXx6RZ6x3MdQU/aHzMCVg+mNJBTN
 53eIzf79ZS53K3nMmUrdeNub5jyVt6rNuZZ3cyrZuiXDu3pUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

We just introduced a new initialization function for our connectors, so
let's build a kunit test suite for it as well.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 123 +++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 44f82ed2a958..261d4109946d 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -170,10 +170,132 @@ static struct kunit_suite drmm_connector_init_test_suite = {
 	.name = "drmm_connector_init",
 	.init = drm_test_connector_init,
 	.test_cases = drmm_connector_init_tests,
 };
 
+/*
+ * Test that the registration of a bog standard connector works as
+ * expected and doesn't report any error.
+ */
+static void drm_test_connector_hdmi_init_valid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/*
+ * Test that the registration of a connector without a DDC adapter
+ * doesn't report any error.
+ */
+static void drm_test_connector_hdmi_init_null_ddc(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/*
+ * Test that the registration of an HDMI connector with an HDMI
+ * connector type succeeds.
+ */
+static void drm_test_connector_hdmi_init_type_valid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	unsigned int connector_type = *(unsigned int *)test->param_value;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       connector_type,
+				       &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+static const unsigned int drm_connector_hdmi_init_type_valid_tests[] = {
+	DRM_MODE_CONNECTOR_HDMIA,
+	DRM_MODE_CONNECTOR_HDMIB,
+};
+
+static void drm_connector_hdmi_init_type_desc(const unsigned int *type, char *desc)
+{
+	sprintf(desc, "%s", drm_get_connector_type_name(*type));
+}
+
+KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_type_valid,
+		  drm_connector_hdmi_init_type_valid_tests,
+		  drm_connector_hdmi_init_type_desc);
+
+/*
+ * Test that the registration of an HDMI connector with an !HDMI
+ * connector type fails.
+ */
+static void drm_test_connector_hdmi_init_type_invalid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	unsigned int connector_type = *(unsigned int *)test->param_value;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       &dummy_funcs,
+				       connector_type,
+				       &priv->ddc);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+static const unsigned int drm_connector_hdmi_init_type_invalid_tests[] = {
+	DRM_MODE_CONNECTOR_Unknown,
+	DRM_MODE_CONNECTOR_VGA,
+	DRM_MODE_CONNECTOR_DVII,
+	DRM_MODE_CONNECTOR_DVID,
+	DRM_MODE_CONNECTOR_DVIA,
+	DRM_MODE_CONNECTOR_Composite,
+	DRM_MODE_CONNECTOR_SVIDEO,
+	DRM_MODE_CONNECTOR_LVDS,
+	DRM_MODE_CONNECTOR_Component,
+	DRM_MODE_CONNECTOR_9PinDIN,
+	DRM_MODE_CONNECTOR_DisplayPort,
+	DRM_MODE_CONNECTOR_TV,
+	DRM_MODE_CONNECTOR_eDP,
+	DRM_MODE_CONNECTOR_VIRTUAL,
+	DRM_MODE_CONNECTOR_DSI,
+	DRM_MODE_CONNECTOR_DPI,
+	DRM_MODE_CONNECTOR_WRITEBACK,
+	DRM_MODE_CONNECTOR_SPI,
+	DRM_MODE_CONNECTOR_USB,
+};
+
+KUNIT_ARRAY_PARAM(drm_connector_hdmi_init_type_invalid,
+		  drm_connector_hdmi_init_type_invalid_tests,
+		  drm_connector_hdmi_init_type_desc);
+
+static struct kunit_case drmm_connector_hdmi_init_tests[] = {
+	KUNIT_CASE(drm_test_connector_hdmi_init_valid),
+	KUNIT_CASE(drm_test_connector_hdmi_init_null_ddc),
+	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_valid,
+			 drm_connector_hdmi_init_type_valid_gen_params),
+	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_invalid,
+			 drm_connector_hdmi_init_type_invalid_gen_params),
+	{ }
+};
+
+static struct kunit_suite drmm_connector_hdmi_init_test_suite = {
+	.name = "drmm_connector_hdmi_init",
+	.init = drm_test_connector_init,
+	.test_cases = drmm_connector_hdmi_init_tests,
+};
+
 struct drm_get_tv_mode_from_name_test {
 	const char *name;
 	enum drm_connector_tv_mode expected_mode;
 };
 
@@ -234,10 +356,11 @@ static struct kunit_suite drm_get_tv_mode_from_name_test_suite = {
 	.name = "drm_get_tv_mode_from_name",
 	.test_cases = drm_get_tv_mode_from_name_tests,
 };
 
 kunit_test_suites(
+	&drmm_connector_hdmi_init_test_suite,
 	&drmm_connector_init_test_suite,
 	&drm_get_tv_mode_from_name_test_suite
 );
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");

-- 
2.44.0


