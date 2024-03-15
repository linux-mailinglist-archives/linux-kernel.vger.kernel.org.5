Return-Path: <linux-kernel+bounces-104974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD187D71D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0166B1F210F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF915A0FC;
	Fri, 15 Mar 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="pwlJNKud"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD654BEC;
	Fri, 15 Mar 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710543779; cv=none; b=p94bIJV81wu+vuS3OkkQNCfwB0HDxCVeS0NMxPL9JNSSroF+o47GjsQPZfygHXkFS3fBAp+dvP+jI21VXa2NciGfh2LNbXBltVDMyG8ZxEE0A35TDP0YntVjUSeBrfpXL0KINXpJOBhEAh9eSZSBwitXEz5T42FMNhtpt9oTiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710543779; c=relaxed/simple;
	bh=7Ga9GsL3FjKm37mVZwSoCl7qdw/o5OzPS1w6PZASAHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBfQlo+xBnoSd7cmrhS67HX7ZrcIbKPQ2aUEdKJUruRRl9olWwIGP5rl1yeZPXCsTf9FMwBsmQMg0dZWJAtd4AZDOsZRTdemCwZssI0S0kvyJ9atr/tho+l2NRu00P8vKxkGjPwEXG5ytWFJz+uajO8lI0PxM2FekgzIkd26G1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=pwlJNKud; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1710543766; bh=7Ga9GsL3FjKm37mVZwSoCl7qdw/o5OzPS1w6PZASAHs=;
	h=From:To:Cc:Subject:Date:From;
	b=pwlJNKudPE8BIJ/FBv7exsVoV/mPu4SJlUgQnAYAJrO5KAtBVWpJJGw+8RAw/5bed
	 B0BMK2qj+1T7/FthaRRqaChW51verab9otzLN3+DbDYGc+gK7+j4w0KSwnhBVUiZ5d
	 fO3jdx5aP49MxXCtRdM33gMTkFrEqP50ctrPE6j0=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: paul.elder@ideasonboard.com,
	Ondrej Jirman <megi@xff.cz>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-media@vger.kernel.org (open list:ROCKCHIP ISP V1 DRIVER),
	linux-rockchip@lists.infradead.org (open list:ROCKCHIP ISP V1 DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support)
Subject: [PATCH v2] media: rkisp1: Adapt to different SoCs having different size limits
Date: Sat, 16 Mar 2024 00:02:41 +0100
Message-ID: <20240315230245.1385902-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

- RK3399 has input/output limit of main path 4416 x 3312
- PX30 has input/output limit of main path 3264 x 2448
- i.MX8MP has input/output limit of main path 4096 x 3072

Use rkisp1_info struct to encode the limits.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
v2:
- adapt to i.MX8MP merged for v6.9

 drivers/media/platform/rockchip/rkisp1/rkisp1-common.h  | 6 ++++--
 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c     | 5 +++--
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c     | 6 ++++++
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c     | 9 +++++----
 drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c | 4 ++--
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 26573f6ae575..b4c958b93629 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -34,8 +34,6 @@ struct regmap;
 #define RKISP1_ISP_SD_SINK			BIT(1)
 
 /* min and max values for the widths and heights of the entities */
-#define RKISP1_ISP_MAX_WIDTH			4032
-#define RKISP1_ISP_MAX_HEIGHT			3024
 #define RKISP1_ISP_MIN_WIDTH			32
 #define RKISP1_ISP_MIN_HEIGHT			32
 
@@ -140,6 +138,8 @@ enum rkisp1_feature {
  * @isr_size: number of entries in the @isrs array
  * @isp_ver: ISP version
  * @features: bitmask of rkisp1_feature features implemented by the ISP
+ * @max_width: maximum input frame width
+ * @max_height: maximum input frame height
  *
  * This structure contains information about the ISP specific to a particular
  * ISP model, version, or integration in a particular SoC.
@@ -151,6 +151,8 @@ struct rkisp1_info {
 	unsigned int isr_size;
 	enum rkisp1_cif_isp_version isp_ver;
 	unsigned int features;
+	unsigned int max_width;
+	unsigned int max_height;
 };
 
 /*
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
index 4202642e0523..841e58c20f7f 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
@@ -307,6 +307,7 @@ static int rkisp1_csi_set_fmt(struct v4l2_subdev *sd,
 			      struct v4l2_subdev_state *sd_state,
 			      struct v4l2_subdev_format *fmt)
 {
+	struct rkisp1_csi *csi = to_rkisp1_csi(sd);
 	const struct rkisp1_mbus_info *mbus_info;
 	struct v4l2_mbus_framefmt *sink_fmt, *src_fmt;
 
@@ -326,10 +327,10 @@ static int rkisp1_csi_set_fmt(struct v4l2_subdev *sd,
 
 	sink_fmt->width = clamp_t(u32, fmt->format.width,
 				  RKISP1_ISP_MIN_WIDTH,
-				  RKISP1_ISP_MAX_WIDTH);
+				  csi->rkisp1->info->max_width);
 	sink_fmt->height = clamp_t(u32, fmt->format.height,
 				   RKISP1_ISP_MIN_HEIGHT,
-				   RKISP1_ISP_MAX_HEIGHT);
+				   csi->rkisp1->info->max_height);
 
 	fmt->format = *sink_fmt;
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index bb0202386c70..0535ce57e862 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -510,6 +510,8 @@ static const struct rkisp1_info px30_isp_info = {
 	.features = RKISP1_FEATURE_MIPI_CSI2
 		  | RKISP1_FEATURE_SELF_PATH
 		  | RKISP1_FEATURE_DUAL_CROP,
+	.max_width = 3264,
+	.max_height = 2448,
 };
 
 static const char * const rk3399_isp_clks[] = {
@@ -531,6 +533,8 @@ static const struct rkisp1_info rk3399_isp_info = {
 	.features = RKISP1_FEATURE_MIPI_CSI2
 		  | RKISP1_FEATURE_SELF_PATH
 		  | RKISP1_FEATURE_DUAL_CROP,
+	.max_width = 4416,
+	.max_height = 3312,
 };
 
 static const char * const imx8mp_isp_clks[] = {
@@ -551,6 +555,8 @@ static const struct rkisp1_info imx8mp_isp_info = {
 	.isp_ver = RKISP1_V_IMX8MP,
 	.features = RKISP1_FEATURE_MAIN_STRIDE
 		  | RKISP1_FEATURE_DMA_34BIT,
+	.max_width = 4096,
+	.max_height = 3072,
 };
 
 static const struct of_device_id rkisp1_of_match[] = {
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index e45a213baf49..f787a7e91e3e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -517,6 +517,7 @@ static int rkisp1_isp_enum_frame_size(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_state *sd_state,
 				      struct v4l2_subdev_frame_size_enum *fse)
 {
+	struct rkisp1_isp *isp = to_rkisp1_isp(sd);
 	const struct rkisp1_mbus_info *mbus_info;
 
 	if (fse->pad == RKISP1_ISP_PAD_SINK_PARAMS ||
@@ -539,9 +540,9 @@ static int rkisp1_isp_enum_frame_size(struct v4l2_subdev *sd,
 		return -EINVAL;
 
 	fse->min_width = RKISP1_ISP_MIN_WIDTH;
-	fse->max_width = RKISP1_ISP_MAX_WIDTH;
+	fse->max_width = isp->rkisp1->info->max_width;
 	fse->min_height = RKISP1_ISP_MIN_HEIGHT;
-	fse->max_height = RKISP1_ISP_MAX_HEIGHT;
+	fse->max_height = isp->rkisp1->info->max_height;
 
 	return 0;
 }
@@ -772,10 +773,10 @@ static void rkisp1_isp_set_sink_fmt(struct rkisp1_isp *isp,
 
 	sink_fmt->width = clamp_t(u32, format->width,
 				  RKISP1_ISP_MIN_WIDTH,
-				  RKISP1_ISP_MAX_WIDTH);
+				  isp->rkisp1->info->max_width);
 	sink_fmt->height = clamp_t(u32, format->height,
 				   RKISP1_ISP_MIN_HEIGHT,
-				   RKISP1_ISP_MAX_HEIGHT);
+				   isp->rkisp1->info->max_height);
 
 	/*
 	 * Adjust the color space fields. Accept any color primaries and
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
index 6f3931ca5b51..e22cc2db24cf 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -494,10 +494,10 @@ static void rkisp1_rsz_set_sink_fmt(struct rkisp1_resizer *rsz,
 
 	sink_fmt->width = clamp_t(u32, format->width,
 				  RKISP1_ISP_MIN_WIDTH,
-				  RKISP1_ISP_MAX_WIDTH);
+				  rsz->rkisp1->info->max_width);
 	sink_fmt->height = clamp_t(u32, format->height,
 				   RKISP1_ISP_MIN_HEIGHT,
-				   RKISP1_ISP_MAX_HEIGHT);
+				   rsz->rkisp1->info->max_height);
 
 	/*
 	 * Adjust the color space fields. Accept any color primaries and
-- 
2.44.0


