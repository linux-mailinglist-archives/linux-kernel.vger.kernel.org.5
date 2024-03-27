Return-Path: <linux-kernel+bounces-122155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479FA88F2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19FD1F2A445
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6F155305;
	Wed, 27 Mar 2024 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="TPzVje5o"
Received: from mail-108-mta54.mxroute.com (mail-108-mta54.mxroute.com [136.175.108.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB04155397
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581498; cv=none; b=FnYAIsKFUo08uHk/E6CfiJT/ycSE/RYrS+ZMI5fme02q2n1lW8YGEnMO7fGKpWPynS7wE3LNYFuG+i35wFLIlKn21fMp7Xms6t/uGlxOXAavvnn82Btg3X7YWn7pL/BCXI9ULsIsZ1ULX/bnJXRPAMaXUBnS4mDLE/cpaXzsYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581498; c=relaxed/simple;
	bh=KZ76x2fc3WeOj7LBiWJxeujGzu6MDjyqqWFmrDXeA10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4Nwr9gbNMr2vm2VxBJcC7+FtEdYbamNg5z6IyOLAqXGerqs/2phX5yHtMZprdfbVGJLo1QxP3omM8cTt7H+s79yU59WfrxFW9bUdPdV4xrh7GuplUK6EW5f9kU3bRdG++Gcio8ogss5npvKjzKIHHOkpDe8Yr5JJ3QBpogIaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=TPzVje5o; arc=none smtp.client-ip=136.175.108.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta54.mxroute.com (ZoneMTA) with ESMTPSA id 18e8234974b0003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:17:48 +0000
X-Zone-Loop: 30969724194de3dd7b3462a090f8549136e99e5b333c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2hEJDv6UdkDP+8OHpzsCbaDIrQpZ6/TPz2mkJ9spkto=; b=TPzVje5oQxj2tk/MgXVmnCTfJU
	gEmic0UoH8ECDZC3vJwbVOVsW/MtnxZIpxTph7HETUijp6zsgIi0JeTBNw7GFvYIQs6rByQ7V/kjP
	/4OWR2uMWU6LXZgul/fdJbO5SB05j4OlH+AbB87696i5cm0Eo/hMlhDBOZegSOIonL/AR7BPtRAkd
	vAny6JcJy1nnI7yMqM8O6wuBu0LlV8Xjsnk/01quoWHWwkxTuZ8YKRQeJhuBkNlpjLZi9gBWd6Uxk
	f2rFKAHqnbndZVHd1N10NWGU8T8BDCFP7phplahzDskHf/bCqOF/hyCK2ol8vaWIKjkcv1jkXVgbe
	e+QUN0wQ==;
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/23] media: i2c: imx258: Support faster pixel rate on binned modes
Date: Wed, 27 Mar 2024 17:17:02 -0600
Message-ID: <20240327231710.53188-17-git@luigi311.com>
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

With the binned modes, there is little point in faithfully
reproducing the horizontal line length of 5352 pixels on the CSI2
bus, and the FIFO between the pixel array and MIPI serialiser
allows us to remove that dependency.

Allow the pixel array to run with the normal settings, with the MIPI
serialiser at half the rate. This requires some additional
information for the link frequency to pixel rate function that
needs to be added to the configuration tables.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/media/i2c/imx258.c | 109 ++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 66022088e4da..f5d0979110fe 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -99,6 +99,11 @@ struct imx258_reg_list {
 	const struct imx258_reg *regs;
 };
 
+struct imx258_link_cfg {
+	unsigned int lf_to_pix_rate_factor;
+	struct imx258_reg_list reg_list;
+};
+
 enum {
 	IMX258_2_LANE_MODE,
 	IMX258_4_LANE_MODE,
@@ -109,8 +114,8 @@ enum {
 struct imx258_link_freq_config {
 	u32 pixels_per_line;
 
-	/* PLL registers for this link frequency */
-	struct imx258_reg_list reg_list[IMX258_LANE_CONFIGS];
+	/* Configuration for this link frequency / num lanes selection */
+	struct imx258_link_cfg link_cfg[IMX258_LANE_CONFIGS];
 };
 
 /* Mode : resolution and related config&values */
@@ -273,7 +278,7 @@ static const struct imx258_reg mipi_640mbps_19_2mhz_4l[] = {
 static const struct imx258_reg mipi_642mbps_24mhz_2l[] = {
 	{ 0x0136, 0x18 },
 	{ 0x0137, 0x00 },
-	{ 0x0301, 0x0A },
+	{ 0x0301, 0x05 },
 	{ 0x0303, 0x02 },
 	{ 0x0305, 0x04 },
 	{ 0x0306, 0x00 },
@@ -479,14 +484,22 @@ enum {
 };
 
 /*
- * pixel_rate = link_freq * data-rate * nr_of_lanes / bits_per_sample
- * data rate => double data rate;
- * number of lanes => (configurable 2 or 4);
- * bits per pixel => 10
+ * Pixel rate does not necessarily relate to link frequency on this sensor as
+ * there is a FIFO between the pixel array pipeline and the MIPI serializer.
+ * The recommendation from Sony is that the pixel array is always run with a
+ * line length of 5352 pixels, which means that there is a large amount of
+ * blanking time for the 1048x780 mode. There is no need to replicate this
+ * blanking on the CSI2 bus, and the configuration of register 0x0301 allows the
+ * divider to be altered.
+ *
+ * The actual factor between link frequency and pixel rate is in the
+ * imx258_link_cfg, so use this to convert between the two.
+ * bits per pixel being 10, and D-PHY being DDR is assumed by this function, so
+ * the value is only the combination of number of lanes and pixel clock divider.
  */
-static u64 link_freq_to_pixel_rate(u64 f, unsigned int nlanes)
+static u64 link_freq_to_pixel_rate(u64 f, const struct imx258_link_cfg *link_cfg)
 {
-	f *= 2 * nlanes;
+	f *= 2 * link_cfg->lf_to_pix_rate_factor;
 	do_div(f, 10);
 
 	return f;
@@ -511,31 +524,33 @@ static const s64 link_freq_menu_items_24[] = {
 	IMX258_LINK_FREQ_321MHZ,
 };
 
+#define REGS(_list) { .num_of_regs = ARRAY_SIZE(_list), .regs = _list, }
+
 /* Link frequency configs */
 static const struct imx258_link_freq_config link_freq_configs_19_2[] = {
 	[IMX258_LINK_FREQ_1267MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
-		.reg_list = {
+		.link_cfg = {
 			[IMX258_2_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_1267mbps_19_2mhz_2l),
-				.regs = mipi_1267mbps_19_2mhz_2l,
+				.lf_to_pix_rate_factor = 2 * 2,
+				.reg_list = REGS(mipi_1267mbps_19_2mhz_2l),
 			},
 			[IMX258_4_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_1267mbps_19_2mhz_4l),
-				.regs = mipi_1267mbps_19_2mhz_4l,
+				.lf_to_pix_rate_factor = 4,
+				.reg_list = REGS(mipi_1267mbps_19_2mhz_4l),
 			},
 		}
 	},
 	[IMX258_LINK_FREQ_640MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
-		.reg_list = {
+		.link_cfg = {
 			[IMX258_2_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_640mbps_19_2mhz_2l),
-				.regs = mipi_640mbps_19_2mhz_2l,
+				.lf_to_pix_rate_factor = 2,
+				.reg_list = REGS(mipi_640mbps_19_2mhz_2l),
 			},
 			[IMX258_4_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_640mbps_19_2mhz_4l),
-				.regs = mipi_640mbps_19_2mhz_4l,
+				.lf_to_pix_rate_factor = 4,
+				.reg_list = REGS(mipi_640mbps_19_2mhz_4l),
 			},
 		}
 	},
@@ -544,27 +559,27 @@ static const struct imx258_link_freq_config link_freq_configs_19_2[] = {
 static const struct imx258_link_freq_config link_freq_configs_24[] = {
 	[IMX258_LINK_FREQ_1267MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
-		.reg_list = {
+		.link_cfg = {
 			[IMX258_2_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_1272mbps_24mhz_2l),
-				.regs = mipi_1272mbps_24mhz_2l,
+				.lf_to_pix_rate_factor = 2,
+				.reg_list = REGS(mipi_1272mbps_24mhz_2l),
 			},
 			[IMX258_4_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_1272mbps_24mhz_4l),
-				.regs = mipi_1272mbps_24mhz_4l,
+				.lf_to_pix_rate_factor = 4,
+				.reg_list = REGS(mipi_1272mbps_24mhz_4l),
 			},
 		}
 	},
 	[IMX258_LINK_FREQ_640MBPS] = {
 		.pixels_per_line = IMX258_PPL_DEFAULT,
-		.reg_list = {
+		.link_cfg = {
 			[IMX258_2_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_642mbps_24mhz_2l),
-				.regs = mipi_642mbps_24mhz_2l,
+				.lf_to_pix_rate_factor = 2 * 2,
+				.reg_list = REGS(mipi_642mbps_24mhz_2l),
 			},
 			[IMX258_4_LANE_MODE] = {
-				.num_of_regs = ARRAY_SIZE(mipi_642mbps_24mhz_4l),
-				.regs = mipi_642mbps_24mhz_4l,
+				.lf_to_pix_rate_factor = 4,
+				.reg_list = REGS(mipi_642mbps_24mhz_4l),
 			},
 		}
 	},
@@ -642,7 +657,7 @@ struct imx258 {
 
 	const struct imx258_link_freq_config *link_freq_configs;
 	const s64 *link_freq_menu_items;
-	unsigned int nlanes;
+	unsigned int lane_mode_idx;
 	unsigned int csi2_flags;
 
 	/*
@@ -952,8 +967,10 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_format *fmt)
 {
 	struct imx258 *imx258 = to_imx258(sd);
-	const struct imx258_mode *mode;
+	const struct imx258_link_freq_config *link_freq_cfgs;
+	const struct imx258_link_cfg *link_cfg;
 	struct v4l2_mbus_framefmt *framefmt;
+	const struct imx258_mode *mode;
 	s32 vblank_def;
 	s32 vblank_min;
 	s64 h_blank;
@@ -977,7 +994,11 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
 		__v4l2_ctrl_s_ctrl(imx258->link_freq, mode->link_freq_index);
 
 		link_freq = imx258->link_freq_menu_items[mode->link_freq_index];
-		pixel_rate = link_freq_to_pixel_rate(link_freq, imx258->nlanes);
+		link_freq_cfgs =
+			&imx258->link_freq_configs[mode->link_freq_index];
+
+		link_cfg = &link_freq_cfgs->link_cfg[imx258->lane_mode_idx];
+		pixel_rate = link_freq_to_pixel_rate(link_freq, link_cfg);
 		__v4l2_ctrl_modify_range(imx258->pixel_rate, pixel_rate,
 					 pixel_rate, 1, pixel_rate);
 		/* Update limits and set FPS to default */
@@ -1075,7 +1096,8 @@ static int imx258_start_streaming(struct imx258 *imx258)
 	/* Setup PLL */
 	link_freq_index = imx258->cur_mode->link_freq_index;
 	link_freq_cfg = &imx258->link_freq_configs[link_freq_index];
-	reg_list = &link_freq_cfg->reg_list[imx258->nlanes == 2 ? 0 : 1];
+
+	reg_list = &link_freq_cfg->link_cfg[imx258->lane_mode_idx].reg_list;
 	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
 	if (ret) {
 		dev_err(&client->dev, "%s failed to set plls\n", __func__);
@@ -1265,9 +1287,11 @@ static const struct v4l2_subdev_internal_ops imx258_internal_ops = {
 static int imx258_init_controls(struct imx258 *imx258)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
+	const struct imx258_link_freq_config *link_freq_cfgs;
 	struct v4l2_fwnode_device_properties props;
-	struct v4l2_ctrl_handler *ctrl_hdlr;
 	struct v4l2_ctrl *vflip, *hflip;
+	struct v4l2_ctrl_handler *ctrl_hdlr;
+	const struct imx258_link_cfg *link_cfg;
 	s64 vblank_def;
 	s64 vblank_min;
 	s64 pixel_rate;
@@ -1301,8 +1325,11 @@ static int imx258_init_controls(struct imx258 *imx258)
 	if (vflip)
 		vflip->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
+	link_freq_cfgs = &imx258->link_freq_configs[0];
+	link_cfg = link_freq_cfgs[imx258->lane_mode_idx].link_cfg;
 	pixel_rate = link_freq_to_pixel_rate(imx258->link_freq_menu_items[0],
-					     imx258->nlanes);
+					     link_cfg);
+
 	/* By default, PIXEL_RATE is read only */
 	imx258->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx258_ctrl_ops,
 				V4L2_CID_PIXEL_RATE,
@@ -1456,10 +1483,16 @@ static int imx258_probe(struct i2c_client *client)
 	}
 
 	/* Get number of data lanes */
-	imx258->nlanes = ep.bus.mipi_csi2.num_data_lanes;
-	if (imx258->nlanes != 2 && imx258->nlanes != 4) {
+	switch (ep.bus.mipi_csi2.num_data_lanes) {
+	case 2:
+		imx258->lane_mode_idx = IMX258_2_LANE_MODE;
+		break;
+	case 4:
+		imx258->lane_mode_idx = IMX258_4_LANE_MODE;
+		break;
+	default:
 		dev_err(&client->dev, "Invalid data lanes: %u\n",
-			imx258->nlanes);
+			ep.bus.mipi_csi2.num_data_lanes);
 		ret = -EINVAL;
 		goto error_endpoint_free;
 	}
-- 
2.42.0


