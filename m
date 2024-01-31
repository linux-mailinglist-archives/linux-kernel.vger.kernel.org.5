Return-Path: <linux-kernel+bounces-45793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E884364A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B51B25625
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596340C15;
	Wed, 31 Jan 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oI4lxaXY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143C3EA6B;
	Wed, 31 Jan 2024 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680351; cv=none; b=ebA/CmK6xB2d6eUstjAUGudpXIMhsuD12L7RPhLtkueIjT0subarDNc0Ontnt0yJcf4MS5tjuZkyF7jZrr1FqpgpYepDkss8nZ4neQjzIk0mU/YE+syAZ8DMNnNWRNb7cE6im99n29Hd/fO0nq2K6196vwTEaHQA4QoJA6S1Yy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680351; c=relaxed/simple;
	bh=+81kCPpzrGbUT4UrtdbXKXI39jv/j4e7Ovmg+k42eK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SllVXT6jsctywFfmp3YqBpp0D33y+ivGtpG37/piAAk/hkOHfvlt1sU88b8vkRO4XEHaGz36jBl6X0qtZa6zsjDj5LXSE7a/caU0U856whQuHDcysAN8gJ39tDP0lOPX0Cbj3+np6aTss3o5F4gSe0r8itAOLBvsJENQC18HLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oI4lxaXY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.Jain (unknown [103.86.18.206])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48DA0605A;
	Wed, 31 Jan 2024 06:51:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706680263;
	bh=+81kCPpzrGbUT4UrtdbXKXI39jv/j4e7Ovmg+k42eK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oI4lxaXYFWgDVlELgBOBp4JXz787CjI69XGZa5yywA3+oHVXhir93xn+2XGR50IXw
	 SQi8SRNrOfbwWu5EIA46JUWRSyxnLOK+dT+8YPsoALjTu2kDYN7ED+S2EsFVgoPiDn
	 4ckuAdKhW1JTCk9Fx81N+mLkswpZCjd3kZ5pX2Jg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 3/5] media: i2c: imx335: Support multiple link frequency
Date: Wed, 31 Jan 2024 11:22:06 +0530
Message-ID: <20240131055208.170934-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240131055208.170934-1-umang.jain@ideasonboard.com>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
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
index 73691069556f..ca3eab50f714 100644
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
@@ -267,6 +257,65 @@ static const struct imx335_reg raw12_framefmt_regs[] = {
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
@@ -281,7 +330,6 @@ static const struct imx335_mode supported_mode = {
 	.vblank_min = 2560,
 	.vblank_max = 133060,
 	.pclk = 396000000,
-	.link_freq_idx = 0,
 	.reg_list = {
 		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
 		.regs = mode_2592x1940_regs,
@@ -764,6 +812,14 @@ static int imx335_start_streaming(struct imx335 *imx335)
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
2.41.0


