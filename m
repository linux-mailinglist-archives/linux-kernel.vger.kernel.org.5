Return-Path: <linux-kernel+bounces-122172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383BE88F30D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C51E1C2DA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6F156241;
	Wed, 27 Mar 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="jjSDi0ap"
Received: from mail-108-mta191.mxroute.com (mail-108-mta191.mxroute.com [136.175.108.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB80155A59
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581792; cv=none; b=WLAgYOQ/Qla9sVJHrh2rWirl8QL+p6xFCeYWW5UKPvEZfAkPZxc/TjRMAD9TqhvE+5xV+RgQirTVSGgTTBQ6VuN6IZJJ7yTynoN/BV+OaHJmf6yhS7gv1i4pKYkHsz1mEPD6lAdoOu9XmtlLeHusgbPkhFnbeI26LRccKqPHmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581792; c=relaxed/simple;
	bh=4IFlHHYQOC9tV4yl8FKLXbjVjJLVUilxrsOQLLplhHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv2bmskdZM4SeXbGUzyFuD1H+1D4Na50bKp9vJQShfAZvIUcE0dZNZXRW9owfmInSdQwIb4LNrgP4scOn71/2nnI4KGyVqTF8ZdpPFx4U4r2/e2t3Z7mg9S9EUBXI2HEJCLgUrsU0s2HkAIdTHE5WTzOvkn4LbjB/+IJXSwpJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=jjSDi0ap; arc=none smtp.client-ip=136.175.108.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta191.mxroute.com (ZoneMTA) with ESMTPSA id 18e823473d50003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:17:39 +0000
X-Zone-Loop: 2d6fe2b772aba4f69230dfdd857a25831a8ca9f0c9f3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KTzgM/Hg/qDUQABeevstUkAZjkMCak0+N7cZAxmCg3o=; b=jjSDi0apZwodL/ENrPR2nIWVBK
	0YJHaHEqGP2vIlEsZWNEvBhXySz5pt+VvjrFo31pqxt/X8hmZyokc5Vu06BUpmk+PJc198ZrE9O5F
	LB0DHgUix/P0IVmDDGM7437z/dGiXanogqUOPy5W3hXm0xSkkgj1Qh0OlUYnwU/p6SuumnxEuaUyl
	CicIVvuADexow2WYWq9ghTX4kwPZ52dAEMajoOyoFIfeu66c9kgEf8832g+9sZDCEIJMIzaMxSbl1
	PqafgWgTf3DlA+8e/qIPl0XkIXVL+scReX9jB5gLX9sU1Lne3DSSjO/qOIjRAv/oe2riA6lww60w5
	eFuUM5PQ==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Luigi311 <git@luigi311.com>
Subject: [PATCH 11/23] media: i2c: imx258: Add get_selection for pixel array information
Date: Wed, 27 Mar 2024 17:16:57 -0600
Message-ID: <20240327231710.53188-12-git@luigi311.com>
In-Reply-To: <20240327231710.53188-1-git@luigi311.com>
References: <20240327231710.53188-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Libcamera requires the cropping information for each mode, so
add this information to the driver.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luigi311 <git@luigi311.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/i2c/imx258.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 1f5fb980cfbe..979ac7872249 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -77,6 +77,14 @@
 #define REG_CONFIG_MIRROR_FLIP		0x03
 #define REG_CONFIG_FLIP_TEST_PATTERN	0x02
 
+/* IMX258 native and active pixel array size. */
+#define IMX258_NATIVE_WIDTH		4224U
+#define IMX258_NATIVE_HEIGHT		3192U
+#define IMX258_PIXEL_ARRAY_LEFT		8U
+#define IMX258_PIXEL_ARRAY_TOP		16U
+#define IMX258_PIXEL_ARRAY_WIDTH	4208U
+#define IMX258_PIXEL_ARRAY_HEIGHT	3120U
+
 struct imx258_reg {
 	u16 address;
 	u8 val;
@@ -116,6 +124,9 @@ struct imx258_mode {
 	u32 link_freq_index;
 	/* Default register values */
 	struct imx258_reg_list reg_list;
+
+	/* Analog crop rectangle. */
+	struct v4l2_rect crop;
 };
 
 /*
@@ -567,6 +578,12 @@ static const struct imx258_mode supported_modes[] = {
 			.regs = mode_4208x3120_regs,
 		},
 		.link_freq_index = IMX258_LINK_FREQ_1267MBPS,
+		.crop = {
+			.left = IMX258_PIXEL_ARRAY_LEFT,
+			.top = IMX258_PIXEL_ARRAY_TOP,
+			.width = 4208,
+			.height = 3120,
+		},
 	},
 	{
 		.width = 2104,
@@ -578,6 +595,12 @@ static const struct imx258_mode supported_modes[] = {
 			.regs = mode_2104_1560_regs,
 		},
 		.link_freq_index = IMX258_LINK_FREQ_640MBPS,
+		.crop = {
+			.left = IMX258_PIXEL_ARRAY_LEFT,
+			.top = IMX258_PIXEL_ARRAY_TOP,
+			.width = 4208,
+			.height = 3120,
+		},
 	},
 	{
 		.width = 1048,
@@ -589,6 +612,12 @@ static const struct imx258_mode supported_modes[] = {
 			.regs = mode_1048_780_regs,
 		},
 		.link_freq_index = IMX258_LINK_FREQ_640MBPS,
+		.crop = {
+			.left = IMX258_PIXEL_ARRAY_LEFT,
+			.top = IMX258_PIXEL_ARRAY_TOP,
+			.width = 4208,
+			.height = 3120,
+		},
 	},
 };
 
@@ -705,6 +734,7 @@ static int imx258_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 {
 	struct v4l2_mbus_framefmt *try_fmt =
 		v4l2_subdev_state_get_format(fh->state, 0);
+	struct v4l2_rect *try_crop;
 
 	/* Initialize try_fmt */
 	try_fmt->width = supported_modes[0].width;
@@ -712,6 +742,13 @@ static int imx258_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 	try_fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
 	try_fmt->field = V4L2_FIELD_NONE;
 
+	/* Initialize try_crop */
+	try_crop = v4l2_subdev_state_get_crop(fh->state, 0);
+	try_crop->left = IMX258_PIXEL_ARRAY_LEFT;
+	try_crop->top = IMX258_PIXEL_ARRAY_TOP;
+	try_crop->width = IMX258_PIXEL_ARRAY_WIDTH;
+	try_crop->height = IMX258_PIXEL_ARRAY_HEIGHT;
+
 	return 0;
 }
 
@@ -959,6 +996,58 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static const struct v4l2_rect *
+__imx258_get_pad_crop(struct imx258 *imx258,
+		      struct v4l2_subdev_state *sd_state,
+		      unsigned int pad, enum v4l2_subdev_format_whence which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_state_get_crop(sd_state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &imx258->cur_mode->crop;
+	}
+
+	return NULL;
+}
+
+static int imx258_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP: {
+		struct imx258 *imx258 = to_imx258(sd);
+
+		mutex_lock(&imx258->mutex);
+		sel->r = *__imx258_get_pad_crop(imx258, sd_state, sel->pad,
+						sel->which);
+		mutex_unlock(&imx258->mutex);
+
+		return 0;
+	}
+
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+		sel->r.left = 0;
+		sel->r.top = 0;
+		sel->r.width = IMX258_NATIVE_WIDTH;
+		sel->r.height = IMX258_NATIVE_HEIGHT;
+
+		return 0;
+
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.left = IMX258_PIXEL_ARRAY_LEFT;
+		sel->r.top = IMX258_PIXEL_ARRAY_TOP;
+		sel->r.width = IMX258_PIXEL_ARRAY_WIDTH;
+		sel->r.height = IMX258_PIXEL_ARRAY_HEIGHT;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 /* Start streaming */
 static int imx258_start_streaming(struct imx258 *imx258)
 {
@@ -1135,6 +1224,7 @@ static const struct v4l2_subdev_pad_ops imx258_pad_ops = {
 	.get_fmt = imx258_get_pad_format,
 	.set_fmt = imx258_set_pad_format,
 	.enum_frame_size = imx258_enum_frame_size,
+	.get_selection = imx258_get_selection,
 };
 
 static const struct v4l2_subdev_ops imx258_subdev_ops = {
-- 
2.42.0


