Return-Path: <linux-kernel+bounces-38852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1983C742
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B2F1C22FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B567763E;
	Thu, 25 Jan 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RxGJO89s"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1F74E39;
	Thu, 25 Jan 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197773; cv=none; b=Dm1ccn6w8zjyyIXi94UY6hhNlTmRBQ787iasLgq9ViojIa1M5opFxTiYwZ/gZvvbpMKsrbQoajKcZMJ+2s0k7lqMFyAGbUsLDjdGhqplwiJ8btgLfjlnmt3hXrocpeLNFiUeZOoFneAZH08aS+dZznnToL9uukfjs/0Qx9qQ9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197773; c=relaxed/simple;
	bh=sNqc72hXfiqjcA5T1DAcrQtkWiD9ghOesnwHAwy4z+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPAlx7hwGnXVc8OLOdaLYedz5SisZL/5gn9XCfQT/a6nt0drRgXi5zvMxYyRwZxISl1A08r6ur4pZogr8AIFyO1eUM2dsFqpoo6EGBvvRC3kIyWucpboTgSp7CDRrtSAElwSmUORFkbZVwya40TEPYPIpix8XXOdiQ11vAzWbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RxGJO89s; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.175])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C84004AB0;
	Thu, 25 Jan 2024 16:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706197692;
	bh=sNqc72hXfiqjcA5T1DAcrQtkWiD9ghOesnwHAwy4z+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxGJO89sbqewdlb3+I6ggRl3YXi16E+yMGe7Yhtxs7/qHBsJgeKv9H8Y95/CTb/bJ
	 xkd+ZnZYmp2L+KomWQhrvdxoZwouuuJtqvHC9SOIbjtdLN4OrQy6gNdI/4wf/7mptt
	 XztoTeEeIRrnxm2ihkD5RAycxdNGtLfjTldSyHZg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 3/4] media: i2c: imx335: Support multiple link frequency
Date: Thu, 25 Jan 2024 21:19:07 +0530
Message-ID: <20240125154908.465191-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125154908.465191-1-umang.jain@ideasonboard.com>
References: <20240125154908.465191-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support link frequency of 445MHz in addition to 594MHz.
Break out the register set specific to each data lane rate and also add
the general timing register set corresponding to the each data
lane rate.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 108 +++++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 5add50af20e6..e64ee99cbae4 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -49,7 +49,8 @@
 #define IMX335_INCLK_RATE	24000000
 
 /* CSI2 HW configuration */
-#define IMX335_LINK_FREQ	594000000
+#define IMX335_LINK_FREQ_594MHz	594000000
+#define IMX335_LINK_FREQ_445MHz	445500000
 #define IMX335_NUM_DATA_LANES	4
 
 #define IMX335_REG_MIN		0x00
@@ -99,7 +100,6 @@ static const char * const imx335_supply_name[] = {
  * @vblank_min: Minimum vertical blanking in lines
  * @vblank_max: Maximum vertical blanking in lines
  * @pclk: Sensor pixel clock
- * @link_freq_idx: Link frequency index
  * @reg_list: Register list for sensor mode
  */
 struct imx335_mode {
@@ -111,7 +111,6 @@ struct imx335_mode {
 	u32 vblank_min;
 	u32 vblank_max;
 	u64 pclk;
-	u32 link_freq_idx;
 	struct imx335_reg_list reg_list;
 };
 
@@ -133,6 +132,7 @@ struct imx335_mode {
  * @again_ctrl: Pointer to analog gain control
  * @vblank: Vertical blanking in lines
  * @cur_mode: Pointer to current selected sensor mode
+ * @link_freq_idx: Selected link frequency index
  * @mutex: Mutex for serializing sensor controls
  * @cur_mbus_code: Currently selected media bus format code
  */
@@ -156,20 +156,16 @@ struct imx335 {
 	};
 	u32 vblank;
 	const struct imx335_mode *cur_mode;
+	u32 link_freq_idx;
 	struct mutex mutex;
 	u32 cur_mbus_code;
 };
 
-static const s64 link_freq[] = {
-	IMX335_LINK_FREQ,
-};
 
 /* Sensor mode registers */
 static const struct imx335_reg mode_2592x1940_regs[] = {
 	{0x3000, 0x01},
 	{0x3002, 0x00},
-	{0x300c, 0x3b},
-	{0x300d, 0x2a},
 	{0x3018, 0x04},
 	{0x302c, 0x3c},
 	{0x302e, 0x20},
@@ -177,10 +173,6 @@ static const struct imx335_reg mode_2592x1940_regs[] = {
 	{0x3074, 0xc8},
 	{0x3076, 0x28},
 	{0x304c, 0x00},
-	{0x314c, 0xc6},
-	{0x315a, 0x02},
-	{0x3168, 0xa0},
-	{0x316a, 0x7e},
 	{0x31a1, 0x00},
 	{0x3288, 0x21},
 	{0x328a, 0x02},
@@ -265,6 +257,65 @@ static const struct imx335_reg raw12_framefmt_regs[] = {
 	{0x341d, 0x00},
 };
 
+static const struct imx335_reg mipi_data_rate_1188Mbps[] = {
+	{0x300c, 0x3b},
+	{0x300d, 0x2a},
+	{0x314c, 0xc6},
+	{0x314d, 0x00},
+	{0x315a, 0x02},
+	{0x3168, 0xa0},
+	{0x316a, 0x7e},
+	{0x319e, 0x01},
+	{0x3a18, 0x8f},
+	{0x3a1a, 0x4f},
+	{0x3a1c, 0x47},
+	{0x3a1e, 0x37},
+	{0x3a1f, 0x01},
+	{0x3a20, 0x4f},
+	{0x3a22, 0x87},
+	{0x3a24, 0x4f},
+	{0x3a26, 0x7f},
+	{0x3a28, 0x3f},
+};
+
+static const struct imx335_reg mipi_data_rate_891Mbps[] = {
+	{0x300c, 0x3b},
+	{0x300d, 0x2a},
+	{0x314c, 0x29},
+	{0x314d, 0x01},
+	{0x315a, 0x06},
+	{0x3168, 0xa0},
+	{0x316a, 0x7e},
+	{0x319e, 0x02},
+	{0x3a18, 0x7f},
+	{0x3a1a, 0x37},
+	{0x3a1c, 0x37},
+	{0x3a1e, 0xf7},
+	{0x3a20, 0x3f},
+	{0x3a22, 0x6f},
+	{0x3a24, 0x3f},
+	{0x3a26, 0x5f},
+	{0x3a28, 0x2f},
+};
+
+static const s64 link_freq[] = {
+	/* Corresponds to 1188Mbps data lane rate */
+	IMX335_LINK_FREQ_594MHz,
+	/* Corresponds to 891Mbps data lane rate */
+	IMX335_LINK_FREQ_445MHz,
+};
+
+static const struct imx335_reg_list link_freq_reglist[] = {
+	{
+		.num_of_regs = ARRAY_SIZE(mipi_data_rate_1188Mbps),
+		.regs = mipi_data_rate_1188Mbps,
+	},
+	{
+		.num_of_regs = ARRAY_SIZE(mipi_data_rate_891Mbps),
+		.regs = mipi_data_rate_891Mbps,
+	},
+};
+
 static const u32 imx335_mbus_codes[] = {
 	MEDIA_BUS_FMT_SRGGB12_1X12,
 	MEDIA_BUS_FMT_SRGGB10_1X10,
@@ -279,7 +330,6 @@ static const struct imx335_mode supported_mode = {
 	.vblank_min = 2560,
 	.vblank_max = 133060,
 	.pclk = 396000000,
-	.link_freq_idx = 0,
 	.reg_list = {
 		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
 		.regs = mode_2592x1940_regs,
@@ -404,7 +454,7 @@ static int imx335_update_controls(struct imx335 *imx335,
 {
 	int ret;
 
-	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, mode->link_freq_idx);
+	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, imx335->link_freq_idx);
 	if (ret)
 		return ret;
 
@@ -759,6 +809,14 @@ static int imx335_start_streaming(struct imx335 *imx335)
 	const struct imx335_reg_list *reg_list;
 	int ret;
 
+	/* Setup PLL */
+	reg_list = &link_freq_reglist[imx335->link_freq_idx];
+	ret = imx335_write_regs(imx335, reg_list->regs, reg_list->num_of_regs);
+	if (ret) {
+		dev_err(imx335->dev, "%s failed to set plls\n", __func__);
+		return ret;
+	}
+
 	/* Write sensor mode registers */
 	reg_list = &imx335->cur_mode->reg_list;
 	ret = imx335_write_regs(imx335, reg_list->regs,
@@ -885,7 +943,7 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 	};
 	struct fwnode_handle *ep;
 	unsigned long rate;
-	unsigned int i;
+	unsigned int i, j;
 	int ret;
 
 	if (!fwnode)
@@ -949,13 +1007,21 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 		goto done_endpoint_free;
 	}
 
-	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
-		if (bus_cfg.link_frequencies[i] == IMX335_LINK_FREQ)
-			goto done_endpoint_free;
 
-	dev_err(imx335->dev, "no compatible link frequencies found\n");
+	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
+		for (j = 0; j < ARRAY_SIZE(link_freq); j++) {
+			if (bus_cfg.link_frequencies[i] == link_freq[j]) {
+				imx335->link_freq_idx = j;
+				break;
+			}
+		}
 
-	ret = -EINVAL;
+		if (j == ARRAY_SIZE(link_freq)) {
+			ret = dev_err_probe(imx335->dev, -EINVAL,
+					    "no supported link freq found\n");
+			goto done_endpoint_free;
+		}
+	}
 
 done_endpoint_free:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
@@ -1102,7 +1168,7 @@ static int imx335_init_controls(struct imx335 *imx335)
 							V4L2_CID_LINK_FREQ,
 							ARRAY_SIZE(link_freq) -
 							1,
-							mode->link_freq_idx,
+							imx335->link_freq_idx,
 							link_freq);
 	if (imx335->link_freq_ctrl)
 		imx335->link_freq_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-- 
2.41.0


