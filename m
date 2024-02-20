Return-Path: <linux-kernel+bounces-73842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BABA85CC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5163A284429
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF9155A57;
	Tue, 20 Feb 2024 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="VgGLavrH"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46703155A4E;
	Tue, 20 Feb 2024 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473450; cv=none; b=D9salBaLhrINNjbFa2tSN/FD+0xqEohvF5w9H/XlPqZ8Wsp9fMuS6+W2sJlB8ARbZ61FCJ7WumZI5mWKuoFGf29lZFT0b1g+4IC1c8qg0Q7/WfOEWNNtgXOMV4osU6XggFNhdyWxlug6sgoObqhAXtvLcoeQG7S/Xnx5zAJvDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473450; c=relaxed/simple;
	bh=DGjkuFJuDK9TXlqvQDkKIyUp+GaWhAK+/qIZgY/58r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pW9mDOCrGIl7Vc4sNExMGQ9Zxl84zLViNbkSM0XZVVV/3jNuxnYR8XJ0jdgxOOrqV0Ink3X25r5qtUPT+DW3LbRGf48WoiSG/q1ZEFnFC0OoK99IdOX6gu4Ruw07BYgkHPoMacDQNlD33GHXpTXYs18aN+TkyCt1+a8npuKtodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=VgGLavrH; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708473446; bh=DGjkuFJuDK9TXlqvQDkKIyUp+GaWhAK+/qIZgY/58r4=;
	h=From:To:Cc:Subject:Date:From;
	b=VgGLavrHkjCjYdeq4qeuydbidUOPsmlvmuRZRoZEVd1DfzWqbReHEkLGK7q0abGH9
	 myy/TVZqegSS2FfKQYSMOGiFAUjjyHiVW1jIKg8W3KrpiPp3H8SMPkRl2UmwaHg9NV
	 7hvaieBdGeoBJDTL2cNs0g13oNoHgcz+5LYtsP5M=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-media@vger.kernel.org (open list:ROCKCHIP ISP V1 DRIVER),
	linux-rockchip@lists.infradead.org (open list:ROCKCHIP ISP V1 DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support)
Subject: [PATCH] media: rkisp1: Adapt to different SoCs having different size limits
Date: Wed, 21 Feb 2024 00:57:17 +0100
Message-ID: <20240220235720.3010608-1-megi@xff.cz>
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

Use rkisp1_info struct to encode the limits.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-common.h  | 6 ++++--
 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c     | 5 +++--
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c     | 4 ++++
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c     | 9 +++++----
 drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c | 4 ++--
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index b757f75edecf..423e7932e7fd 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -33,8 +33,6 @@ struct dentry;
 #define RKISP1_ISP_SD_SINK			BIT(1)
 
 /* min and max values for the widths and heights of the entities */
-#define RKISP1_ISP_MAX_WIDTH			4032
-#define RKISP1_ISP_MAX_HEIGHT			3024
 #define RKISP1_ISP_MIN_WIDTH			32
 #define RKISP1_ISP_MIN_HEIGHT			32
 
@@ -128,6 +126,8 @@ enum rkisp1_feature {
  * @isr_size: number of entries in the @isrs array
  * @isp_ver: ISP version
  * @features: bitmask of rkisp1_feature features implemented by the ISP
+ * @max_width: maximum input frame width
+ * @max_height: maximum input frame height
  *
  * This structure contains information about the ISP specific to a particular
  * ISP model, version, or integration in a particular SoC.
@@ -139,6 +139,8 @@ struct rkisp1_info {
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
index 73cf08a74011..93296dbacfef 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -506,6 +506,8 @@ static const struct rkisp1_info px30_isp_info = {
 	.isr_size = ARRAY_SIZE(px30_isp_isrs),
 	.isp_ver = RKISP1_V12,
 	.features = RKISP1_FEATURE_MIPI_CSI2,
+	.max_width = 3264,
+	.max_height = 2448,
 };
 
 static const char * const rk3399_isp_clks[] = {
@@ -525,6 +527,8 @@ static const struct rkisp1_info rk3399_isp_info = {
 	.isr_size = ARRAY_SIZE(rk3399_isp_isrs),
 	.isp_ver = RKISP1_V10,
 	.features = RKISP1_FEATURE_MIPI_CSI2,
+	.max_width = 4416,
+	.max_height = 3312,
 };
 
 static const struct of_device_id rkisp1_of_match[] = {
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 78a1f7a1499b..5e0a63d353e3 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -394,6 +394,7 @@ static int rkisp1_isp_enum_frame_size(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_state *sd_state,
 				      struct v4l2_subdev_frame_size_enum *fse)
 {
+	struct rkisp1_isp *isp = to_rkisp1_isp(sd);
 	const struct rkisp1_mbus_info *mbus_info;
 
 	if (fse->pad == RKISP1_ISP_PAD_SINK_PARAMS ||
@@ -416,9 +417,9 @@ static int rkisp1_isp_enum_frame_size(struct v4l2_subdev *sd,
 		return -EINVAL;
 
 	fse->min_width = RKISP1_ISP_MIN_WIDTH;
-	fse->max_width = RKISP1_ISP_MAX_WIDTH;
+	fse->max_width = isp->rkisp1->info->max_width;
 	fse->min_height = RKISP1_ISP_MIN_HEIGHT;
-	fse->max_height = RKISP1_ISP_MAX_HEIGHT;
+	fse->max_height = isp->rkisp1->info->max_height;
 
 	return 0;
 }
@@ -649,10 +650,10 @@ static void rkisp1_isp_set_sink_fmt(struct rkisp1_isp *isp,
 
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
index a8e377701302..34938fe8e812 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -493,10 +493,10 @@ static void rkisp1_rsz_set_sink_fmt(struct rkisp1_resizer *rsz,
 
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
2.43.0


