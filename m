Return-Path: <linux-kernel+bounces-61619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25385148D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27301C2292D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F93C488;
	Mon, 12 Feb 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK0vOj6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE43C473;
	Mon, 12 Feb 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743623; cv=none; b=BgpC6WADXwWQ8pQmqcdJjPw1LZZe5iPzax908Re16GXCSpDaNVIKVwC3tT++7F7H7ovFN8Zah024g+rEf6WRFEt68XA2jYEN/M1I1fR0pNL1jKxNydlz/kNQdhR/paEnCSN9QgYudD3BAdr2MRuHQS2wXDVmL+HHtoniHwFwpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743623; c=relaxed/simple;
	bh=xJnMCtf3ntBpekt5KmTcAothtAUv0sGGZE7OhCZRHUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s//UCKhNKhB2Mc229OM7kbRifq+nC1PZmm7GKJtxlNr93HvDOEDHMWQm8Lw2VTuzXHbyEXeMvJBy/6/GqiqYllOqQfeX2PV6o4ChlgIOuKSS3gVg98bEiXceDkupEH4rHnFh06T1QhDgwkWSe96WE58xJ2MV9FFJEOJjR96ZQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK0vOj6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF7EC433C7;
	Mon, 12 Feb 2024 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743622;
	bh=xJnMCtf3ntBpekt5KmTcAothtAUv0sGGZE7OhCZRHUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qK0vOj6H3ojylIBcL02RVplpwufSMrsbNouYM5O+6aecu/Ku0Zw6wFkmVb+AHx+i9
	 uY47zBNCRksyDyuyliF2VnFJoCaUYFGV5GaGIVcjs7/DBGCL+6Q3dmkt8DcNnV0br5
	 Ong+FM57+FDF48O7K1r7L0tPx3deP4yQFnNx0kgBHdGyd3zhQ8X0IFyPcuhTFBMThN
	 D25JzqOVHWPAT9QPnuIwyyZQQDD/LIEk7OKlKvWJg9+W18VOUvNKMby8InAZ/Yu8oC
	 Vfd+teJjyWwZm00Vq8kYH0kGB/qHt3xuiQ+J/z8rqlnDbDY1ze4V8YI7tYh0vfUO/Y
	 i3MDJSwuktVCA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 12 Feb 2024 14:12:48 +0100
Subject: [PATCH v6 05/36] drm/tests: connector: Add tests for
 drmm_connector_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-kms-hdmi-connector-state-v6-5-f4bcdc979e6f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5901; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xJnMCtf3ntBpekt5KmTcAothtAUv0sGGZE7OhCZRHUo=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmnJBMFVPz2FosckRdR9V67wYYtPPDtBmPnxMDy2WGX3
 lR9anrTUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgInc5mL4Z64o8fvevrqwTWIP
 eHLuKCcYf3x2OXnJFdMJE3bfNLv2+jkjw4kLa9IDvs6wf/FCjKFPvy+IfznXkrbp2QZmdt+KRUX
 TmAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drmm_connector_init is the preferred function to initialize a
drm_connector structure. Let's add a bunch of unit tests for it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 170 ++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index c66aa2dc8d9d..a268847be8d1 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -3,10 +3,175 @@
  * Kunit test for drm_modes functions
  */
 
+#include <linux/i2c.h>
+
+#include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_kunit_helpers.h>
 
 #include <kunit/test.h>
 
+struct drm_connector_init_priv {
+	struct drm_device drm;
+	struct drm_connector connector;
+	struct i2c_adapter ddc;
+};
+
+static const struct drm_connector_funcs dummy_funcs = {
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.reset			= drm_atomic_helper_connector_reset,
+};
+
+static int dummy_ddc_xfer(struct i2c_adapter *adapter,
+			  struct i2c_msg *msgs, int num)
+{
+	return num;
+}
+
+static u32 dummy_ddc_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm dummy_ddc_algorithm = {
+	.master_xfer = dummy_ddc_xfer,
+	.functionality = dummy_ddc_func,
+};
+
+static void i2c_del_adapter_wrapper(void *ptr)
+{
+	struct i2c_adapter *adap = ptr;
+
+	i2c_del_adapter(adap);
+}
+
+static int drm_test_connector_init(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv;
+	struct device *dev;
+	int ret;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	priv = drm_kunit_helper_alloc_drm_device(test, dev,
+						 struct drm_connector_init_priv, drm,
+						 DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	strscpy(priv->ddc.name, "dummy-connector-ddc", sizeof(priv->ddc.name));
+	priv->ddc.owner = THIS_MODULE;
+	priv->ddc.algo = &dummy_ddc_algorithm;
+	priv->ddc.dev.parent = dev;
+
+	ret = i2c_add_adapter(&priv->ddc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kunit_add_action_or_reset(test, i2c_del_adapter_wrapper, &priv->ddc);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	test->priv = priv;
+	return 0;
+}
+
+/*
+ * Test that the registration of a bog standard connector works as
+ * expected and doesn't report any error.
+ */
+static void drm_test_drmm_connector_init(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_init(&priv->drm, &priv->connector,
+				  &dummy_funcs,
+				  DRM_MODE_CONNECTOR_HDMIA,
+				  &priv->ddc);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/*
+ * Test that the registration of a connector without a DDC adapter
+ * doesn't report any error.
+ */
+static void drm_test_drmm_connector_init_null_ddc(struct kunit *test)
+{
+	struct drm_connector_init_priv *priv = test->priv;
+	int ret;
+
+	ret = drmm_connector_init(&priv->drm, &priv->connector,
+				  &dummy_funcs,
+				  DRM_MODE_CONNECTOR_HDMIA,
+				  NULL);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/*
+ * Test that the registration of a connector succeeds for all possible
+ * connector types.
+ */
+static void drm_test_drmm_connector_init_type_valid(struct kunit *test)
+{
+       struct drm_connector_init_priv *priv = test->priv;
+       unsigned int connector_type = *(unsigned int *)test->param_value;
+       int ret;
+
+       ret = drmm_connector_init(&priv->drm, &priv->connector,
+				 &dummy_funcs,
+				 connector_type,
+				 &priv->ddc);
+       KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+static const unsigned int drm_connector_init_type_valid_tests[] = {
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
+	DRM_MODE_CONNECTOR_HDMIA,
+	DRM_MODE_CONNECTOR_HDMIB,
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
+static void drm_connector_init_type_desc(const unsigned int *type, char *desc)
+{
+	sprintf(desc, "%s", drm_get_connector_type_name(*type));
+}
+
+KUNIT_ARRAY_PARAM(drm_connector_init_type_valid,
+		  drm_connector_init_type_valid_tests,
+		  drm_connector_init_type_desc);
+
+static struct kunit_case drmm_connector_init_tests[] = {
+	KUNIT_CASE(drm_test_drmm_connector_init),
+	KUNIT_CASE(drm_test_drmm_connector_init_null_ddc),
+	KUNIT_CASE_PARAM(drm_test_drmm_connector_init_type_valid,
+			 drm_connector_init_type_valid_gen_params),
+	{ }
+};
+
+static struct kunit_suite drmm_connector_init_test_suite = {
+	.name = "drmm_connector_init",
+	.init = drm_test_connector_init,
+	.test_cases = drmm_connector_init_tests,
+};
+
 struct drm_get_tv_mode_from_name_test {
 	const char *name;
 	enum drm_connector_tv_mode expected_mode;
@@ -70,7 +235,10 @@ static struct kunit_suite drm_get_tv_mode_from_name_test_suite = {
 	.test_cases = drm_get_tv_mode_from_name_tests,
 };
 
-kunit_test_suite(drm_get_tv_mode_from_name_test_suite);
+kunit_test_suites(
+	&drmm_connector_init_test_suite,
+	&drm_get_tv_mode_from_name_test_suite
+);
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");

-- 
2.43.0


