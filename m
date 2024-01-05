Return-Path: <linux-kernel+bounces-18075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2D825861
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE217285C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464A3609E;
	Fri,  5 Jan 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Ov/iRB1t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364F36080;
	Fri,  5 Jan 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4T68JR4j03z9vft;
	Fri,  5 Jan 2024 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704472664; bh=kfiPKlJJAWP0tElgrak34/RRNpo3DWernVsWqOr7jF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ov/iRB1trlh1vu6kQdGY07442OHIG1Vh/mgwH5iw45nDWZGvQCzsyyq3MNg02mj2h
	 l3ALKSvugaKMzwn2PATF1MCcDr2JRUX9LsQl1/+AuO435y6/wZ5JEOb65Q2q1N/cbL
	 9lsh+TY0hdZdn8HB1fzBHWC6jC2A4czma9c6CPJ4=
X-Riseup-User-ID: 0B18EFBC03C610BDF7561D6BC8BE9EB10A004B2057E322A35FBD1457606B2F56
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T68JL2c8BzJntT;
	Fri,  5 Jan 2024 16:37:38 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Date: Fri, 05 Jan 2024 13:35:08 -0300
Subject: [PATCH 7/7] drm/vkms: Create KUnit tests for YUV conversions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240105-vkms-yuv-v1-7-34c4cd3455e0@riseup.net>
References: <20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net>
In-Reply-To: <20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net>
To: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Arthur Grillo <arthurgrillo@riseup.net>

Create KUnit tests to test the conversion between YUV and RGB. Test each
conversion and range combination with some common colors.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/vkms/Kconfig                  |  15 +++
 drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 151 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c           |   4 +
 4 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
index b9ecdebecb0b..5b0094ad41eb 100644
--- a/drivers/gpu/drm/vkms/Kconfig
+++ b/drivers/gpu/drm/vkms/Kconfig
@@ -13,3 +13,18 @@ config DRM_VKMS
 	  a VKMS.
 
 	  If M is selected the module will be called vkms.
+
+config DRM_VKMS_KUNIT_TESTS
+	tristate "Tests for VKMS" if !KUNIT_ALL_TESTS
+	depends on DRM_VKMS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for VKMS. This option is not useful for
+	  distributions or general kernels, but only for kernel
+	  developers working on VKMS.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
diff --git a/drivers/gpu/drm/vkms/tests/.kunitconfig b/drivers/gpu/drm/vkms/tests/.kunitconfig
new file mode 100644
index 000000000000..70e378228cbd
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_DRM=y
+CONFIG_DRM_VKMS=y
+CONFIG_DRM_VKMS_KUNIT_TESTS=y
diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
new file mode 100644
index 000000000000..c902cdd2d7f2
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <kunit/test.h>
+
+#include <drm/drm_fixed.h>
+
+#include "../../drm_crtc_internal.h"
+
+#define TEST_BUFF_SIZE 50
+
+struct yuv_u8_to_argb_u16_case {
+	enum drm_color_encoding encoding;
+	enum drm_color_range range;
+	size_t n_colors;
+	struct format_pair {
+		char *name;
+		struct pixel_yuv_u8 yuv;
+		struct pixel_argb_u16 argb;
+	} colors[TEST_BUFF_SIZE];
+};
+
+static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 6,
+		.colors = {
+			{"white", {0xff, 0x80, 0x80}, {0x0000, 0xffff, 0xffff, 0xffff}},
+			{"gray",  {0x80, 0x80, 0x80}, {0x0000, 0x8000, 0x8000, 0x8000}},
+			{"black", {0x00, 0x80, 0x80}, {0x0000, 0x0000, 0x0000, 0x0000}},
+			{"red",   {0x4c, 0x55, 0xff}, {0x0000, 0xffff, 0x0000, 0x0000}},
+			{"green", {0x96, 0x2c, 0x15}, {0x0000, 0x0000, 0xffff, 0x0000}},
+			{"blue",  {0x1d, 0xff, 0x6b}, {0x0000, 0x0000, 0x0000, 0xffff}},
+		},
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 6,
+		.colors = {
+			{"white", {0xeb, 0x80, 0x80}, {0x0000, 0xffff, 0xffff, 0xffff}},
+			{"gray",  {0x7e, 0x80, 0x80}, {0x0000, 0x8000, 0x8000, 0x8000}},
+			{"black", {0x10, 0x80, 0x80}, {0x0000, 0x0000, 0x0000, 0x0000}},
+			{"red",   {0x51, 0x5a, 0xf0}, {0x0000, 0xffff, 0x0000, 0x0000}},
+			{"green", {0x91, 0x36, 0x22}, {0x0000, 0x0000, 0xffff, 0x0000}},
+			{"blue",  {0x29, 0xf0, 0x6e}, {0x0000, 0x0000, 0x0000, 0xffff}},
+		},
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{"white", {0xff, 0x80, 0x80}, {0x0000, 0xffff, 0xffff, 0xffff}},
+			{"gray",  {0x80, 0x80, 0x80}, {0x0000, 0x8000, 0x8000, 0x8000}},
+			{"black", {0x00, 0x80, 0x80}, {0x0000, 0x0000, 0x0000, 0x0000}},
+			{"red",   {0x35, 0x63, 0xff}, {0x0000, 0xffff, 0x0000, 0x0000}},
+			{"green", {0xb6, 0x1e, 0x0c}, {0x0000, 0x0000, 0xffff, 0x0000}},
+			{"blue",  {0x12, 0xff, 0x74}, {0x0000, 0x0000, 0x0000, 0xffff}},
+		},
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{"white", {0xeb, 0x80, 0x80}, {0x0000, 0xffff, 0xffff, 0xffff}},
+			{"gray",  {0x7e, 0x80, 0x80}, {0x0000, 0x8000, 0x8000, 0x8000}},
+			{"black", {0x10, 0x80, 0x80}, {0x0000, 0x0000, 0x0000, 0x0000}},
+			{"red",   {0x3f, 0x66, 0xf0}, {0x0000, 0xffff, 0x0000, 0x0000}},
+			{"green", {0xad, 0x2a, 0x1a}, {0x0000, 0x0000, 0xffff, 0x0000}},
+			{"blue",  {0x20, 0xf0, 0x76}, {0x0000, 0x0000, 0x0000, 0xffff}},
+		},
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{"white", {0xff, 0x80, 0x80}, {0x0000, 0xffff, 0xffff, 0xffff}},
+			{"gray",  {0x80, 0x80, 0x80}, {0x0000, 0x8000, 0x8000, 0x8000}},
+			{"black", {0x00, 0x80, 0x80}, {0x0000, 0x0000, 0x0000, 0x0000}},
+			{"red",   {0x43, 0x5c, 0xff}, {0x0000, 0xffff, 0x0000, 0x0000}},
+			{"green", {0xad, 0x24, 0x0b}, {0x0000, 0x0000, 0xffff, 0x0000}},
+			{"blue",  {0x0f, 0xff, 0x76}, {0x0000, 0x0000, 0x0000, 0xffff}},
+		},
+	},
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{"white", {0xeb, 0x80, 0x80}, {0x0000, 0xffff, 0xffff, 0xffff}},
+			{"gray",  {0x7e, 0x80, 0x80}, {0x0000, 0x8000, 0x8000, 0x8000}},
+			{"black", {0x10, 0x80, 0x80}, {0x0000, 0x0000, 0x0000, 0x0000}},
+			{"red",   {0x4a, 0x61, 0xf0}, {0x0000, 0xffff, 0x0000, 0x0000}},
+			{"green", {0xa4, 0x2f, 0x19}, {0x0000, 0x0000, 0xffff, 0x0000}},
+			{"blue",  {0x1d, 0xf0, 0x77}, {0x0000, 0x0000, 0x0000, 0xffff}},
+		},
+	},
+};
+
+static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
+{
+	const struct yuv_u8_to_argb_u16_case *param = test->param_value;
+	struct pixel_argb_u16 argb;
+
+	for (size_t i = 0; i < param->n_colors; i++) {
+		const struct format_pair *color = &param->colors[i];
+
+		yuv_u8_to_argb_u16(&argb, &color->yuv, param->encoding, param->range);
+
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.a, color->argb.a), 257,
+				    "On the A channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.a, argb.a);
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.r, color->argb.r), 257,
+				    "On the R channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.r, argb.r);
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.g, color->argb.g), 257,
+				    "On the G channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.g, argb.g);
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.b, color->argb.b), 257,
+				    "On the B channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.b, argb.b);
+	}
+}
+
+
+static void vkms_format_test_yuv_u8_to_argb_u16_case_desc(struct yuv_u8_to_argb_u16_case *t,
+							  char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
+		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(t->range));
+}
+
+KUNIT_ARRAY_PARAM(yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_cases,
+		  vkms_format_test_yuv_u8_to_argb_u16_case_desc);
+
+static struct kunit_case vkms_format_test_cases[] = {
+	KUNIT_CASE_PARAM(vkms_format_test_yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_gen_params),
+	{}
+};
+
+static struct kunit_suite vkms_format_test_suite = {
+	.name = "vkms-format",
+	.test_cases = vkms_format_test_cases,
+};
+
+kunit_test_suite(vkms_format_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index b654b6661a20..11df990a0fa9 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -440,3 +440,7 @@ void *get_pixel_write_function(u32 format)
 		return NULL;
 	}
 }
+
+#ifdef CONFIG_DRM_VKMS_KUNIT_TESTS
+#include "tests/vkms_format_test.c"
+#endif

-- 
2.43.0


