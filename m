Return-Path: <linux-kernel+bounces-78241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9186109B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA8B267BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9257AE7F;
	Fri, 23 Feb 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VFekYC8Z"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0597E596
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688275; cv=none; b=WuIWn90SUO7ChZWIS27OfTiL9Vk/tSO1WmL6DYlh7NF1NSp80SA0hLOZyu4Z3QehCJmhLKj5NVgQoqpKm/AFSKOI/s1VAYqoWIhCy5TfQitFn92aZo0JzXxLeETrTo0E/sGOelBCA05NwuVFKC9PavJN23Z7FryjJvK4fNqRXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688275; c=relaxed/simple;
	bh=zLfCmB2cOAi+rHOF4QFtEGgN1NdsdG4phUDjzA77YMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SeJXjC4FEaJCkTNM2IQUJ7HYoZyef3c8ApwDxVVrnRIlbMT2sbX9X8SL4HLQB3mXsEcYTh4LYVUt8SlnWbiPWIruZi7zORhQwZZF72hT92nsyrevdcBcsbUp5561aRUkIzzSYuvbvux0RdrStgUGhQrEuEZYvu9yrqj+woFDjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VFekYC8Z; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C445D4000F;
	Fri, 23 Feb 2024 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708688271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/uAsG5Jzk7tw7K+ro+IYvCPbIFvsjURySsIlhGEh+s=;
	b=VFekYC8ZIL4eSE9sGzxrCu9kK7A+NBl17oSlnsPJ1dFUoad3B0h4IbwFMpMYyxqoe+rD0H
	nzdS2EVtGK00N+ORgNT6XM8CD6Q4HGYxtBihmqavl1ywfoeUrOF0wk5UVggM8qSSnAQxmq
	HiQA9Qe4tujw90WVpFyv6cXCoabOboyBagMWEfC/wCzGeX9GsjvC/4Rq5YqKbSJuTsmk7G
	M5xPVFdT7t7wjcN/hJkCOz5mOHoj4bUvhDDej/mkfeBwpM3wbPosNgoQwhNLt4ap4wEpsR
	tShgpFMld+WrkgXDEiOJ+xa7yj2fKYPuv2bqi27l5y0kffgEJeYqlJtRv8B1Cw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 23 Feb 2024 12:37:29 +0100
Subject: [PATCH v2 9/9] drm/vkms: Create KUnit tests for YUV conversions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-yuv-v2-9-aa6be2827bb7@bootlin.com>
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
In-Reply-To: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9589;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=6XGbmMJEqhgEJWTl1n4SZWXpBs90sgie29UDQGxwWdI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl2IOF80X8OnoSpyP4OU6ccp11jjdSSj+6CqfRM/s2
 Mukdt+OJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZdiDhQAKCRAgrS7GWxAs4pYTD/
 4/91LtSPsX5Ss0nBDjIzZzBK+O2owp3lYMClxPSwEWCXo75Wq85GNJ3t2OuvTwEZ8ak/MSe8OJ2Plv
 59mP4tuon7uSygyiJceoEcBUaxnNDipdVKWHUjLESI/PbVuvdL+qKLEuVHnmzLKOG5WfBEek3+WKPg
 qnVj37dv5RahrhteMkJ/YAJZKCXIIWrVjFA31u+UHZwlMXnIrd9S+/6QLKriKndWhE0gL41GRmhLlb
 X1E+FUBOrYgP+IaFVUD0aGrXNPMpLd4EXTjMiHdPkInBJoXqsjAG4IozmKXpAKM80hMM/AGlx2uWh5
 FYrkyWKeqPH84nDveeEQphuNB9NP4m5umueLmUvADE38LENCSB6ABzuai7rcK45M7ZdlamLIAScE89
 r39AaZzJy7LB8dciVGxUuM5qXrofGWAArC/oG1d2e6JjZhbHYodmkbuZwFiggWWaejSjGs1vjWtnBj
 NvWK5XRIwFuZBqlnPvTl+lTk9OHN/pOm6NJ/pWqWDOphhHqQv/V/RFVOn+jb0RaXryygLaBUiNyQzY
 PAIpCLSF4upoyz0h6osWmqF98R3vO60SMquHd3xoJfEooSFo4Le5EsIqzGL2go5+kOi900DK+FNd/F
 uYgSiLK6mUPdI7MxuRzL1YnrvqxyNwjyZ3AmN0zyOkpoDLruEjuj7SIlpCnA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Create KUnit tests to test the conversion between YUV and RGB. Test each
conversion and range combination with some common colors.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
[Louis Chauvet: fix minor formating issues (whitespace, double line)]
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/Makefile                 |   1 +
 drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
 drivers/gpu/drm/vkms/tests/Makefile           |   3 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 155 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c           |   9 +-
 drivers/gpu/drm/vkms/vkms_formats.h           |   5 +
 6 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 1b28a6a32948..8d3e46dde635 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -9,3 +9,4 @@ vkms-y := \
 	vkms_writeback.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
+obj-$(CONFIG_DRM_VKMS_KUNIT_TESTS) += tests/
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
diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
new file mode 100644
index 000000000000..2d1df668569e
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DRM_VKMS_KUNIT_TESTS) += vkms_format_test.o
diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
new file mode 100644
index 000000000000..cb6d32ff115d
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <kunit/test.h>
+
+#include <drm/drm_fixed.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_print.h>
+
+#include "../../drm_crtc_internal.h"
+
+#include "../vkms_drv.h"
+#include "../vkms_formats.h"
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
index 515c80866a58..20dd23ce9051 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -7,6 +7,8 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_fixed.h>
 
+#include <kunit/visibility.h>
+
 #include "vkms_formats.h"
 
 /**
@@ -175,8 +177,10 @@ static void ycbcr2rgb(const s16 m[3][3], u8 y, u8 cb, u8 cr, u8 y_offset, u8 *r,
 	*b = clamp(b_16, 0, 0xffff) >> 8;
 }
 
-static void yuv_u8_to_argb_u16(struct pixel_argb_u16 *argb_u16, const struct pixel_yuv_u8 *yuv_u8,
-			       enum drm_color_encoding encoding, enum drm_color_range range)
+VISIBLE_IF_KUNIT void yuv_u8_to_argb_u16(struct pixel_argb_u16 *argb_u16,
+					 const struct pixel_yuv_u8 *yuv_u8,
+					 enum drm_color_encoding encoding,
+					 enum drm_color_range range)
 {
 	static const s16 bt601_full[3][3] = {
 		{ 256, 0,   359 },
@@ -237,6 +241,7 @@ static void yuv_u8_to_argb_u16(struct pixel_argb_u16 *argb_u16, const struct pix
 	argb_u16->g = g * 257;
 	argb_u16->b = b * 257;
 }
+EXPORT_SYMBOL_IF_KUNIT(yuv_u8_to_argb_u16);
 
 /*
  * The following functions are read_line function for each pixel format supported by VKMS.
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index 5a3a9e1328d8..4245a5c5e956 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -13,4 +13,9 @@ struct pixel_yuv_u8 {
 	u8 y, u, v;
 };
 
+#if IS_ENABLED(CONFIG_KUNIT)
+void yuv_u8_to_argb_u16(struct pixel_argb_u16 *argb_u16, const struct pixel_yuv_u8 *yuv_u8,
+			enum drm_color_encoding encoding, enum drm_color_range range);
+#endif
+
 #endif /* _VKMS_FORMATS_H_ */

-- 
2.43.0


