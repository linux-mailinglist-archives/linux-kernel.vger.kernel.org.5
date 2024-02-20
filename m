Return-Path: <linux-kernel+bounces-72696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E385B779
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBB284503
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922B63CAE;
	Tue, 20 Feb 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UO4s/xrP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DC60881;
	Tue, 20 Feb 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421318; cv=none; b=EI7qP8FNgKKW4lsWsBjGzVMLx62TQ7lxgdYnVvfSe/0JrFae+tmf+HinNbe6UprkdvQDz6FAZS13U1FiNI3mdLe0E1zrspcpAU01gQdiwZwfvycohf/KY4iWCImmiqN51leachdSbF+ikQIyTetKJgjvxXrMpSZ2aMgK8zDHMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421318; c=relaxed/simple;
	bh=qXG+xWIeAzR0Odss+ql3FBGpuSNVYP9vQKaFrOq/7lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAp8oD6gcuGNDE8rt+kgmYE54km20o7BDSI30cAjgMEhYxnqD8KhlbKMSjQ/G1DsbUAapJj5jQy+r3NrFcTOzp85/Tj4b0GzIhZFGP8bl6R/AJSfIlUmuytIzH2yNNPi5HYIVsh+H5pF7BfRWLCkGkSSiQb7xDFkuxHytF6BwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UO4s/xrP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.159])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94C6E1536;
	Tue, 20 Feb 2024 10:28:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708421308;
	bh=qXG+xWIeAzR0Odss+ql3FBGpuSNVYP9vQKaFrOq/7lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UO4s/xrPT2paE7l1twzre7srmKkBASkpodFN16l9oRWIs6gkFLy6+IG9lRV3NljDY
	 Jcf1BFhGm7gRJBgi40WrEF71mZWJYo9xU37zNiknjfZ63ITgJqMREGddtojhFgq8SX
	 pGPZQ5e8eit1HSvtOn/YJk4BeIYy4ak89oJV+s1I=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 3/5] media: imx335: Support multiple link frequency
Date: Tue, 20 Feb 2024 14:58:19 +0530
Message-ID: <20240220092821.1993-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220092821.1993-1-umang.jain@ideasonboard.com>
References: <20240220092821.1993-1-umang.jain@ideasonboard.com>
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
 drivers/media/i2c/imx335.c | 84 +++++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index e34e34503dda..27f850a5b9b7 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -49,7 +49,9 @@
 #define IMX335_INCLK_RATE	24000000
 
 /* CSI2 HW configuration */
-#define IMX335_LINK_FREQ	594000000LL
+#define IMX335_LINK_FREQ_594MHz		594000000LL
+#define IMX335_LINK_FREQ_445MHz		445500000LL
+
 #define IMX335_NUM_DATA_LANES	4
 
 #define IMX335_REG_MIN		0x00
@@ -99,7 +101,6 @@ static const char * const imx335_supply_name[] = {
  * @vblank_min: Minimum vertical blanking in lines
  * @vblank_max: Maximum vertical blanking in lines
  * @pclk: Sensor pixel clock
- * @link_freq_idx: Link frequency index
  * @reg_list: Register list for sensor mode
  */
 struct imx335_mode {
@@ -111,7 +112,6 @@ struct imx335_mode {
 	u32 vblank_min;
 	u32 vblank_max;
 	u64 pclk;
-	u32 link_freq_idx;
 	struct imx335_reg_list reg_list;
 };
 
@@ -162,16 +162,10 @@ struct imx335 {
 	u32 cur_mbus_code;
 };
 
-static const s64 link_freq[] = {
-	IMX335_LINK_FREQ,
-};
-
 /* Sensor mode registers */
 static const struct imx335_reg mode_2592x1940_regs[] = {
 	{0x3000, 0x01},
 	{0x3002, 0x00},
-	{0x300c, 0x3b},
-	{0x300d, 0x2a},
 	{0x3018, 0x04},
 	{0x302c, 0x3c},
 	{0x302e, 0x20},
@@ -179,10 +173,6 @@ static const struct imx335_reg mode_2592x1940_regs[] = {
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
@@ -268,6 +258,65 @@ static const struct imx335_reg raw12_framefmt_regs[] = {
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
@@ -282,7 +331,6 @@ static const struct imx335_mode supported_mode = {
 	.vblank_min = 2560,
 	.vblank_max = 133060,
 	.pclk = 396000000,
-	.link_freq_idx = 0,
 	.reg_list = {
 		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
 		.regs = mode_2592x1940_regs,
@@ -765,6 +813,14 @@ static int imx335_start_streaming(struct imx335 *imx335)
 	const struct imx335_reg_list *reg_list;
 	int ret;
 
+	/* Setup PLL */
+	reg_list = &link_freq_reglist[__ffs(imx335->link_freq_bitmap)];
+	ret = imx335_write_regs(imx335, reg_list->regs, reg_list->num_of_regs);
+	if (ret) {
+		dev_err(imx335->dev, "%s failed to set plls\n", __func__);
+		return ret;
+	}
+
 	/* Write sensor mode registers */
 	reg_list = &imx335->cur_mode->reg_list;
 	ret = imx335_write_regs(imx335, reg_list->regs,
-- 
2.43.0


