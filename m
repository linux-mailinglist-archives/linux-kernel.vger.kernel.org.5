Return-Path: <linux-kernel+bounces-61621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62E851494
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1851C21AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E93C47D;
	Mon, 12 Feb 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYmLt1Ez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC59E3CF5C;
	Mon, 12 Feb 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743629; cv=none; b=oT/pUKFV2ktREVk1bc3yruWB106kXHVDdi+9wzxMz4etOieYCKZwQK9U9WSUC+NDWhyk5uf2diL8rlcBdshtAcJeaUjwL5gneSkPh2MSDq0quUUI2+Kp2EMm4QaJIMDHtWSTSIHfVbDpRzImr51d615MCD/UZ9dua3YNcBWxqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743629; c=relaxed/simple;
	bh=ekRYwIKWq6y5QbBEMB/WwN89jVENEHbv42HIP/z5kwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTh1dusNWFXYkogipvwdFsKDV94S/LevxZY4EVj/ZwHASUWOtj+3WM6IPOJSdbzORNWV9ROTevBBWuMc9e8aSG7usTKAxsLS/8XE62n/FiyT//0bUXVGJdzvFlXsvuSCKDPzNoJF6aEQVWdcF337UdMDbfSkepnL0eF+wZ5TMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYmLt1Ez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7AC43390;
	Mon, 12 Feb 2024 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743628;
	bh=ekRYwIKWq6y5QbBEMB/WwN89jVENEHbv42HIP/z5kwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JYmLt1EzYcG9A5rQgBbKIx30t/IxdRkjOtxg3QWg3aFQ22a0Q8jNRdGlsIy+CPlvI
	 iAD4T0H3lBi+r9xAgKn7UdCCIBbq5WNf5KWLcyymUP5td5bRDsMHNteBhdolP16MZI
	 RTr9+Vi2inq7GaSskpstFtwkK0yrcsvW+Ch09LNjcZ23kggNH4bHaBP3BYxnlmiTo4
	 ZlE6NbKbQttIh8av1baMAemxmCZfjkfpi15n/0wxFD2ALtiWDY2iL7gjzGSpE1nyCt
	 dTVLwwiePQEWr4WpWq8/Hz91L9VWh/N5toZqKemJvBwGo5GyT+XjCAUp3Bl3xuPrYq
	 8rJPnwYDpg4bA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:12:50 +0100
Subject: [PATCH v6 07/36] drm/tests: connector: Add tests for
 drmm_connector_hdmi_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-7-f4bcdc979e6f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4892; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ekRYwIKWq6y5QbBEMB/WwN89jVENEHbv42HIP/z5kwU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJJM+mT1bl/73zvFjyXL5y8OShVcvvX5ohebSlUwrp
 NdP+2Zq1lHKwiDGxSArpsgSI2y+JO7UrNedbHzzYOawMoEMYeDiFICJhNxgZNibe/TUnedOYpfb
 Hvw+Y9LIIrhL26ZkqUyRz82Tee/qLusz/A95f+7RUuXEm6l+/4V3q2z4Nify5qLOVCWT8CmTeh1
 n8zADAA==
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
index a268847be8d1..8f070cacab3b 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -172,6 +172,128 @@ static struct kunit_suite drmm_connector_init_test_suite = {
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
@@ -236,6 +358,7 @@ static struct kunit_suite drm_get_tv_mode_from_name_test_suite = {
 };
 
 kunit_test_suites(
+	&drmm_connector_hdmi_init_test_suite,
 	&drmm_connector_init_test_suite,
 	&drm_get_tv_mode_from_name_test_suite
 );

-- 
2.43.0


