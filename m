Return-Path: <linux-kernel+bounces-102309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B687B099
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DCEB20E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754741386A6;
	Wed, 13 Mar 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5eK5rLz"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5567C41
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351945; cv=none; b=EbI6r4JdK2p8JMQPeLmdlQ24ROQ9NWruQ1kJ1qr4N2D7Fe41Joohp5BY47m6mw6wFh1AAprWEioayIq7zBPP3GWJd5/el46ZaTEiCIp6ZB8u/UtH9yDPPM6SOAfRPjTxHPJRdKAH2ZSYh/YRYONUfL6pFuEAI+z2zbHo/rAujqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351945; c=relaxed/simple;
	bh=k/cR50Y4nyPMPp70WjIVpQIVr/Pl9dSWckHCxjSrlGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OElFpHtN3o5BL2FqrlFC/+kBzElBhGgLiqQB1AGRiZx1r8/YPUX6wGhQtM8nCw3MSfElSyEjcLWs801JmAEQiPb35sFZvw8AtPxgMy5WeP2/GTdsP5ipp5cg+Cn0Smwf0foWbTq+PGxczewfofpnX1S8veuBc75aWSMx4iMHHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5eK5rLz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4218140011;
	Wed, 13 Mar 2024 17:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710351941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+8KoEpO2IWGv9JRRqBCQWLwDOAVJikmAaabAeNMcO8=;
	b=N5eK5rLzFLoDtTffxYXn816j2dpZh03nbAhOu6EGXMDfHEwWNLYSPjcFV+5xC18+XHhwTV
	mTRzoHHPvciQIOe7PByb0gJbygURLIgZkRHimBlHUE1vGjVVdiyLfXNek3O6cBp5k//yRX
	wyUe3jjyo7J/C5o+wHaFkbZJOQPwYyqZVX+i5ZNabjj37uhRafZ2AAcWoJBt/L2stNZbsx
	Cc+tFR6GbmU/+w1tF5Zhp/jQ2UfGz4VJz8R7dfDuK4Hi5QeRU1rNiFnmeoLICQO4JFQdW9
	TEU4msfkHc2OraLfdcw0rKT05QaSkLj4lZQ4XYTm4XqoRElrwIknZAeNVzrVwA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 13 Mar 2024 18:45:08 +0100
Subject: [PATCH v5 14/16] drm/vkms: Create KUnit tests for YUV conversions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240313-yuv-v5-14-e610cbd03f52@bootlin.com>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
In-Reply-To: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, arthurgrillo@riseup.net, 
 Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
 nicolejadeyee@google.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13522;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=NwSv/ORkaecyeVISHs/IZQX2eP++OQsZXLK46HRqCCw=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBl8eY1NngNRWpFwcpGK3UcWmNcLdoE0nOzy6RfPfCG
 NuqHNrGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZfHmNQAKCRAgrS7GWxAs4npeD/
 9ZDUcwUlW6M2FG4ou8XVds4sMXcbEtfSY155dxF1uojjlQeMHymffdUlg2vkOsPGsx8RFUseE5h1n8
 Tp4ZufRQLuxaq8bLTwvdUR9MPr/OkLBmMO7QZ+6PUIR7WFNzmNvki5tGwtC1nc5lhD1SvqhHgSO7Fy
 jRBfBcree1BltQCQl39LbPCOqKVPyejn1hB4cfncsEKF/EQbboF7/Cf6yatYdG5uNxWCaRMPzYOD0X
 rOMwXSAD3I8FjA2HGKU/N04MZ2NeXM89qUNOYzcLOxSiP/xHqAQNnYMoJw2b/PlBsbVihGj49pDaNl
 9gr+2leS/x2Nw8Pn9NXAkgAv9BwiUPWkSa/Jw2sW1ylKTaDY1SUk6/kLleP+PoF/qq513PFHKT3/hA
 OhuBrAckMZBjQUdzsPxQGf/vmTzgwjptIwP5ezo/aYn3nexio0cN5aLHJkZnhRD149ikZ5DENiTUrX
 t3dcgZlZVXUw7eeD7/PJ7nMsBCMny+lHVObvriKdLFn/TpzHF1JFdE4clFryFF6A1r40+cPuB6wIJr
 nhJwafJmA4vg05AimDqRPGOxwEVLkEcQD2ObdBkUBMlUrtc0vTxNBC+CHidMSxmdiSfCpuFU4XzIvC
 j0Cb6hJC76JiYk+tGRA/LpnZK1nPcRhJZsGOII4f5FLmnfXr8qluBUEj/gyg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Create KUnit tests to test the conversion between YUV and RGB. Test each
conversion and range combination with some common colors.

The code used to compute the expected result can be found in comment.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
[Louis Chauvet:
- fix minor formating issues (whitespace, double line)
- change expected alpha from 0x0000 to 0xffff
- adapt to the new get_conversion_matrix usage
- apply the changes from Arthur
- move struct pixel_yuv_u8 to the test itself]
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/Kconfig                  |  15 ++
 drivers/gpu/drm/vkms/Makefile                 |   1 +
 drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
 drivers/gpu/drm/vkms/tests/Makefile           |   3 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 230 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c           |   7 +-
 drivers/gpu/drm/vkms/vkms_formats.h           |   4 +
 7 files changed, 262 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
index b9ecdebecb0b..9b0e1940c14f 100644
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
\ No newline at end of file
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
index 000000000000..0954d606e44a
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -0,0 +1,230 @@
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
+struct pixel_yuv_u8 {
+	u8 y, u, v;
+};
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
+/*
+ * The YUV color representation were acquired via the colour python framework.
+ * Below are the function calls used for generating each case.
+ *
+ * for more information got to the docs:
+ * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_YCbCr.html
+ */
+static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 6,
+		.colors = {
+			{ "white", { 0xff, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x80, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x00, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x4c, 0x55, 0xff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0x96, 0x2c, 0x15 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1d, 0xff, 0x6b }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 6,
+		.colors = {
+			{ "white", { 0xeb, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x10, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x51, 0x5a, 0xf0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0x91, 0x36, 0x22 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x29, 0xf0, 0x6e }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xff, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x80, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x00, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x36, 0x63, 0xff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xb6, 0x1e, 0x0c }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x12, 0xff, 0x74 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                     in_bits = 16,
+	 *                     int_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xeb, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x10, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x3f, 0x66, 0xf0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xad, 0x2a, 0x1a }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x20, 0xf0, 0x76 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xff, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x80, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x00, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x43, 0x5c, 0xff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xad, 0x24, 0x0b }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x0f, 0xff, 0x76 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xeb, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x10, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x4a, 0x61, 0xf0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xa4, 0x2f, 0x19 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1d, 0xf0, 0x77 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
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
+		struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
+			(DRM_FORMAT_NV12, param->encoding, param->range);
+
+		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, matrix);
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
+		  vkms_format_test_yuv_u8_to_argb_u16_case_desc
+);
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
index edbf4b321b91..863fc91d6d48 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -7,6 +7,8 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_fixed.h>
 
+#include <kunit/visibility.h>
+
 #include "vkms_formats.h"
 
 /**
@@ -199,8 +201,8 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const u16 *pixel)
 	return out_pixel;
 }
 
-static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 cb, u8 cr,
-						  struct conversion_matrix *matrix)
+VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 cb, u8 cr,
+							    struct conversion_matrix *matrix)
 {
 	u8 r, g, b;
 	s64 fp_y, fp_cb, fp_cr;
@@ -234,6 +236,7 @@ static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 cb, u8 cr,
 
 	return argb_u16_from_u8888(255, r, g, b);
 }
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
 
 /*
  * The following functions are read_line function for each pixel format supported by VKMS.
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index e1d324764b17..21e66a0cac16 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -13,4 +13,8 @@ struct conversion_matrix *
 get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encoding,
 				  enum drm_color_range range);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 cb, u8 cr, struct conversion_matrix *matrix);
+#endif
+
 #endif /* _VKMS_FORMATS_H_ */

-- 
2.43.0


