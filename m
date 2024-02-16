Return-Path: <linux-kernel+bounces-68387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B418585798E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FF01C20B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C903200C9;
	Fri, 16 Feb 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dY9h2Y2b"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E121F93E;
	Fri, 16 Feb 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077339; cv=none; b=cMDoPtDiq5F12dC+BW5IeEqHaaNtuWCh9Cql5t/syzgkmIHppwaQkh6SmF0DNR6VS9uhQ8IcWo36asgvT/6L0HIRCDmjHtbK0kWNozMUi/Qj1bwtoSCCZc1gm5cj5dWWAYcyAZsJtMtBB8z9ttxKs51Lf2vJXOsKuCGxE/UfN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077339; c=relaxed/simple;
	bh=8U+d6hL24MZGPZFxK9bYc4RDQf5dPvWZOf7qapIJo0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6G1b4X429xNBb1we02SGEtrrKiY1mv+JHK9MHWDcaycIiRo/5eMBwahGvSfYj/E1wwerqCGTkiwFtughT/j7gM2dKikFaze8M4sKKcoKS1ZAPZGJnA4JBw168EdM90d9BaFoDsvAsWOO6Ji7cFw7crsk8cas7Icr9rsndFgUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dY9h2Y2b; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04DA5D4A;
	Fri, 16 Feb 2024 10:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708077332;
	bh=8U+d6hL24MZGPZFxK9bYc4RDQf5dPvWZOf7qapIJo0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dY9h2Y2bHKE5aKn51aImxQVGxPzKk7tXWlmJ4aQqYxeu+hH02clk3UUO9nfXA9SSK
	 4Vaze+gj20sZ76Sk5NZoeCDtwuRWtsGGiVR8xwcYSxalOXOiDFoqFLyMbngLkivNPY
	 xSmvqoT1wBmwOt3I49jeOUkRZWYqumlGxeWzTgLw=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Paul Elder <paul.elder@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 04/12] media: rkisp1: Support devices lacking dual crop
Date: Fri, 16 Feb 2024 18:54:50 +0900
Message-Id: <20240216095458.2919694-5-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some versions of the ISP supported by the rkisp1 driver, such as the ISP
in the i.MX8MP, lack the dual crop registers and don't support cropping
at the resizer input. They instead rely on cropping in the Image
Stabilization module, at the output of the ISP, to modify the resizer
input size and implement digital zoom.

Add a dual crop feature flag to distinguish the versions of the ISP that
support dual crop from those that don't, and make sure that the sink
crop is set to the sink format when dual crop is not supported.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v12:
- Remove mention of moving resizer input crop to image stabilizer from
  commit message
- Make sure the sink crop is set to the sink format when dual crop is
  not supported
---
 .../media/platform/rockchip/rkisp1/rkisp1-common.h    |  2 ++
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c   |  6 ++++--
 .../media/platform/rockchip/rkisp1/rkisp1-resizer.c   | 11 +++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index f7c251f79aa9..219d4a2547aa 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -112,6 +112,7 @@ enum rkisp1_isp_pad {
  * @RKISP1_FEATURE_MIPI_CSI2: The ISP has an internal MIPI CSI-2 receiver
  * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
  * @RKISP1_FEATURE_SELF_PATH: The ISP has a self path
+ * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
  *
  * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
  * the driver to implement support for features present in some ISP versions
@@ -121,6 +122,7 @@ enum rkisp1_feature {
 	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
 	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
 	RKISP1_FEATURE_SELF_PATH = BIT(2),
+	RKISP1_FEATURE_DUAL_CROP = BIT(3),
 };
 
 #define rkisp1_has_feature(rkisp1, feature) \
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index f48a21985b18..2e40c376cab5 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -507,7 +507,8 @@ static const struct rkisp1_info px30_isp_info = {
 	.isr_size = ARRAY_SIZE(px30_isp_isrs),
 	.isp_ver = RKISP1_V12,
 	.features = RKISP1_FEATURE_MIPI_CSI2
-		  | RKISP1_FEATURE_SELF_PATH,
+		  | RKISP1_FEATURE_SELF_PATH
+		  | RKISP1_FEATURE_DUAL_CROP,
 };
 
 static const char * const rk3399_isp_clks[] = {
@@ -527,7 +528,8 @@ static const struct rkisp1_info rk3399_isp_info = {
 	.isr_size = ARRAY_SIZE(rk3399_isp_isrs),
 	.isp_ver = RKISP1_V10,
 	.features = RKISP1_FEATURE_MIPI_CSI2
-		  | RKISP1_FEATURE_SELF_PATH,
+		  | RKISP1_FEATURE_SELF_PATH
+		  | RKISP1_FEATURE_DUAL_CROP,
 };
 
 static const struct of_device_id rkisp1_of_match[] = {
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
index dd77a31e6014..755d319b568e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -447,8 +447,9 @@ static void rkisp1_rsz_set_sink_crop(struct rkisp1_resizer *rsz,
 	/* Not crop for MP bayer raw data */
 	mbus_info = rkisp1_mbus_info_get_by_code(sink_fmt->code);
 
-	if (rsz->id == RKISP1_MAINPATH &&
-	    mbus_info->pixel_enc == V4L2_PIXEL_ENC_BAYER) {
+	if ((rsz->id == RKISP1_MAINPATH &&
+	     mbus_info->pixel_enc == V4L2_PIXEL_ENC_BAYER) ||
+	    !rkisp1_has_feature(rsz->rkisp1, DUAL_CROP)) {
 		sink_crop->left = 0;
 		sink_crop->top = 0;
 		sink_crop->width = sink_fmt->width;
@@ -635,7 +636,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
 	struct v4l2_subdev_state *sd_state;
 
 	if (!enable) {
-		rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
+		if (rkisp1_has_feature(rkisp1, DUAL_CROP))
+			rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
 		rkisp1_rsz_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
 		return 0;
 	}
@@ -646,7 +648,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
 	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
 
 	rkisp1_rsz_config(rsz, sd_state, when);
-	rkisp1_dcrop_config(rsz, sd_state);
+	if (rkisp1_has_feature(rkisp1, DUAL_CROP))
+		rkisp1_dcrop_config(rsz, sd_state);
 
 	v4l2_subdev_unlock_state(sd_state);
 
-- 
2.39.2


