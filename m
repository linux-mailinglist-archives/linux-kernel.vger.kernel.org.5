Return-Path: <linux-kernel+bounces-119381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257688C7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5241F3D239
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609213C91C;
	Tue, 26 Mar 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzFo5rsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB01411DF;
	Tue, 26 Mar 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467693; cv=none; b=Cd4e0dd4unPuAiX8FzRjJVh3N3JxDg2AzMzVuQSdRjn2uMy9eEBvZ0YVavRpq3vYVVs9UiBNZ14HmEfsEEaYvbNB9eaC2f3caaPcR9UVFqLmnXImAShLH19NkXS7+VoxedjZu40rcvUlTukXNgtnHE2WF4zpPjqsdNyqVjVYQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467693; c=relaxed/simple;
	bh=Z1h9h/BKTg3T18HJhrzyl0i2u670WHhwWj1kWnPTCTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OD9zPuaz5tHwkSNavDetIBQoWY2RGS/Ku2qvLq3Ave9g7U/VygqRZV/W7fZ47TX/1vwmyAIN91V1P1xv6d1urfIrdJAys5KhVmv26T52bLTsye0YxOj44o7ZEtSnP/7A4OgCqSHUfN8P23M1pBMI7HMxojSEpvw4e5POZW2uc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzFo5rsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F379BC43394;
	Tue, 26 Mar 2024 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467693;
	bh=Z1h9h/BKTg3T18HJhrzyl0i2u670WHhwWj1kWnPTCTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jzFo5rsmPUVk4PfFMT/bj1M8Am7ySltiMXOCCEtwHRheojPmNoZ51nn0J6wBugVEW
	 5I4f1Dd0lf9L8CZur7HDQRKhcUuqGVI8FoGMy0WPRr2z1zop6pF2Q3qsBFmBQjSC6p
	 TYeKh0aW3fFUgfTGZ9fL2u9F7LG4/G4WhaJ1j1t7q9IN9DrZN7ueFRG870mLFi/A7w
	 liVXiuQz1uXZ81dvce5QZC/DuEXhz3FlkZ9LqokB5ODCiRsXSzAoWMjU1gnGdpMNnB
	 /0OBIh1uCGhmnU3nXsPnqQIhF3E8ZWnSaKt9JJNJw1AdvP2oZlVrPMb2y7AVALNaYE
	 fh8zr/Pv74COg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 Mar 2024 16:40:26 +0100
Subject: [PATCH v11 22/28] drm/tests: Add infoframes test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-kms-hdmi-connector-state-v11-22-c5680ffcf261@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8730; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z1h9h/BKTg3T18HJhrzyl0i2u670WHhwWj1kWnPTCTU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDGlMbzLEXKpUPqnnizc7hHDmXZ2Ss43HcnbvpYNdk4ROd
 Zc2qX7qmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNx1WZs2Bgb+kjkYcfJmZt+
 +ni35cvXM97qP/i80dW0cu6RA4+u/FU41+K3clngbUXR64YMoRk3GOv0Ij3KjefrJBbJMu28buF
 XwrVs2/3pihP+1BXNuX80icV03zNulcZrX/dISYVEt9q8ZwIA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The previous patch added the generation of the infoframes matching an
HDMI connector state. Let's add a few tests to make sure it works as
expected.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 219 +++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 9129cee56975..9260aa378421 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -219,10 +219,221 @@ static void drm_test_connector_hdmi_init_null_ddc(struct kunit *test)
 				       BIT(HDMI_COLORSPACE_RGB),
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/*
+ * Test that the registration of an HDMI connector with a NULL vendor
+ * fails.
+ */
+static void drm_test_connector_hdmi_init_null_vendor(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       NULL, "Product",
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+/*
+ * Test that the registration of an HDMI connector with a NULL product
+ * fails.
+ */
+static void drm_test_connector_hdmi_init_null_product(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       "Vendor", NULL,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+/*
+ * Test that the registration of a connector with a valid, shorter than
+ * the max length, product name succeeds, and is stored padded with 0.
+ */
+static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] = {
+		'P', 'r', 'o', 'd',
+	};
+	const char *product_name = "Prod";
+	int ret;
+
+	KUNIT_ASSERT_LT(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       "Vendor", product_name,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_MEMEQ(test,
+			   priv->connector.hdmi.product,
+			   expected_product,
+			   sizeof(priv->connector.hdmi.product));
+}
+
+/*
+ * Test that the registration of a connector with a valid, at max
+ * length, product name succeeds, and is stored padded without any
+ * trailing \0.
+ */
+static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] = {
+		'P', 'r', 'o', 'd', 'u', 'c', 't',
+		'P', 'r', 'o', 'd', 'u', 'c', 't',
+		'P', 'r',
+	};
+	const char *product_name = "ProductProductPr";
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       "Vendor", product_name,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_MEMEQ(test,
+			   priv->connector.hdmi.product,
+			   expected_product,
+			   sizeof(priv->connector.hdmi.product));
+}
+
+/*
+ * Test that the registration of a connector with a product name larger
+ * than the maximum length fails.
+ */
+static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const char *product_name = "ProductProductProduct";
+	int ret;
+
+	KUNIT_ASSERT_GT(test, strlen(product_name), DRM_CONNECTOR_HDMI_PRODUCT_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       "Vendor", product_name,
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
+/*
+ * Test that the registration of a connector with a vendor name smaller
+ * than the maximum length succeeds, and is stored padded with zeros.
+ */
+static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
+		'V', 'e', 'n', 'd',
+	};
+	const char *vendor_name = "Vend";
+	int ret;
+
+	KUNIT_ASSERT_LT(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       vendor_name, "Product",
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_MEMEQ(test,
+			   priv->connector.hdmi.vendor,
+			   expected_vendor,
+			   sizeof(priv->connector.hdmi.vendor));
+}
+
+/*
+ * Test that the registration of a connector with a vendor name at the
+ * maximum length succeeds, and is stored padded without the trailing
+ * zero.
+ */
+static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] = {
+		'V', 'e', 'n', 'd', 'o', 'r',
+		'V', 'e',
+	};
+	const char *vendor_name = "VendorVe";
+	int ret;
+
+	KUNIT_ASSERT_EQ(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       vendor_name, "Product",
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_MEMEQ(test,
+			   priv->connector.hdmi.vendor,
+			   expected_vendor,
+			   sizeof(priv->connector.hdmi.vendor));
+}
+
+/*
+ * Test that the registration of a connector with a vendor name larger
+ * than the maximum length fails.
+ */
+static void drm_test_connector_hdmi_init_vendor_length_too_long(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	const char *vendor_name = "VendorVendor";
+	int ret;
+
+	KUNIT_ASSERT_GT(test, strlen(vendor_name), DRM_CONNECTOR_HDMI_VENDOR_LEN);
+
+	ret = drmm_connector_hdmi_init(&priv->drm, &priv->connector,
+				       vendor_name, "Product",
+				       &dummy_funcs,
+				       &dummy_hdmi_funcs,
+				       DRM_MODE_CONNECTOR_HDMIA,
+				       &priv->ddc,
+				       BIT(HDMI_COLORSPACE_RGB),
+				       8);
+	KUNIT_EXPECT_LT(test, ret, 0);
+}
+
 /*
  * Test that the registration of a connector with an invalid maximum bpc
  * count fails.
  */
 static void drm_test_connector_hdmi_init_bpc_invalid(struct kunit *test)
@@ -499,10 +710,18 @@ static struct kunit_case drmm_connector_hdmi_init_tests[] = {
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_invalid),
 	KUNIT_CASE(drm_test_connector_hdmi_init_bpc_null),
 	KUNIT_CASE(drm_test_connector_hdmi_init_formats_empty),
 	KUNIT_CASE(drm_test_connector_hdmi_init_formats_no_rgb),
 	KUNIT_CASE(drm_test_connector_hdmi_init_null_ddc),
+	KUNIT_CASE(drm_test_connector_hdmi_init_null_product),
+	KUNIT_CASE(drm_test_connector_hdmi_init_null_vendor),
+	KUNIT_CASE(drm_test_connector_hdmi_init_product_length_exact),
+	KUNIT_CASE(drm_test_connector_hdmi_init_product_length_too_long),
+	KUNIT_CASE(drm_test_connector_hdmi_init_product_valid),
+	KUNIT_CASE(drm_test_connector_hdmi_init_vendor_length_exact),
+	KUNIT_CASE(drm_test_connector_hdmi_init_vendor_length_too_long),
+	KUNIT_CASE(drm_test_connector_hdmi_init_vendor_valid),
 	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_valid,
 			 drm_connector_hdmi_init_type_valid_gen_params),
 	KUNIT_CASE_PARAM(drm_test_connector_hdmi_init_type_invalid,
 			 drm_connector_hdmi_init_type_invalid_gen_params),
 	{ }

-- 
2.44.0


