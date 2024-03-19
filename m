Return-Path: <linux-kernel+bounces-107166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198B87F85E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9E21C2151A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2F154670;
	Tue, 19 Mar 2024 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZRaYPP31"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4009548EA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833257; cv=none; b=XJ8j+paiq5CBdJeUnsE7pWl0TQcIz4nFtbVTzbE/9pTsGdLVCH1uFSMpLnuATOpXYjbc/ZKDuPsf8SuVrLWXi71FmhQY9ILVf8Wo1UekdhEpXujVfm1o4joxOo9Uf1DaXx/AIuonM6neZ8rjT7qvwQSQ+LMCusygb+kBg85x2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833257; c=relaxed/simple;
	bh=1rpo1Xv0OlmyuYXfVPAM0GvwsntMwPp5HiLKtzCXDXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7meVcnBO72fZXvzTB16P+ihmLtw0m6GOvOp39WQ2B/Gvl7r4+1c/Nyk3QycgYXpdfc14xBuPYogCA95GzpzdJhYSuOtHUc9KgTrpYEi0ZlUgHZPAAOdu1laJ3uQW8j0EYKBoZ5YLjAt8YyKbJpvXDxv1lRanXJmJnaemZyKxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZRaYPP31; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.138])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 722F8F02;
	Tue, 19 Mar 2024 08:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710833227;
	bh=1rpo1Xv0OlmyuYXfVPAM0GvwsntMwPp5HiLKtzCXDXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRaYPP316wM/gLSXjTGKbt/+8dTJDbGdGFkpPsjaqUeKekwUk6WMrxAVLWWNzvM9R
	 Dsiv2Zb2zASPiUSVu7+gmNmBlvhNqCaHLdnlTmRNOa/W/Wikcrx5+zAoPM2Bfj0peI
	 VBtSkQNRyukVYxHJfio2WgHq/dcVqok+fLOCpjG0=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 3/6] media: imx335: Use V4L2 CCI for accessing sensor registers
Date: Tue, 19 Mar 2024 12:57:09 +0530
Message-ID: <20240319072712.133449-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319072712.133449-1-umang.jain@ideasonboard.com>
References: <20240319072712.133449-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new comon CCI register access helpers to replace the private
register access helpers in the imx335 driver.

Select V4L2_CCI_I2C Kconfig option which the imx335 driver now
depends on.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/Kconfig  |   1 +
 drivers/media/i2c/imx335.c | 593 ++++++++++++++++---------------------
 2 files changed, 263 insertions(+), 331 deletions(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index e4da68835683..c1f6d882efae 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -205,6 +205,7 @@ config VIDEO_IMX334
 config VIDEO_IMX335
 	tristate "Sony IMX335 sensor support"
 	depends on OF_GPIO
+	select V4L2_CCI_I2C
 	help
 	  This is a Video4Linux2 sensor driver for the Sony
 	  IMX335 camera.
diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index b8cf85984127..ae4341644a84 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -11,62 +11,104 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
+#include <media/v4l2-cci.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
 /* Streaming Mode */
-#define IMX335_REG_MODE_SELECT	0x3000
-#define IMX335_MODE_STANDBY	0x01
-#define IMX335_MODE_STREAMING	0x00
+#define IMX335_REG_MODE_SELECT		CCI_REG8(0x3000)
+#define IMX335_MODE_STANDBY		0x01
+#define IMX335_MODE_STREAMING		0x00
 
-/* Data Lanes */
-#define IMX335_LANEMODE		0x3a01
-#define IMX335_2LANE		1
-#define IMX335_4LANE		3
+/* Group hold register */
+#define IMX335_REG_HOLD			CCI_REG8(0x3001)
+
+#define IMX335_REG_MASTER_MODE		CCI_REG8(0x3002)
+#define IMX335_REG_BCWAIT_TIME		CCI_REG8(0x300c)
+#define IMX335_REG_CPWAIT_TIME		CCI_REG8(0x300d)
+#define IMX335_REG_WINMODE		CCI_REG8(0x3018)
+#define IMX335_REG_HTRIMMING_START	CCI_REG16_LE(0x302c)
+#define IMX335_REG_HNUM			CCI_REG8(0x302e)
 
 /* Lines per frame */
-#define IMX335_REG_LPFR		0x3030
+#define IMX335_REG_VMAX			CCI_REG24_LE(0x3030)
 
-/* Chip ID */
-#define IMX335_REG_ID		0x3912
-#define IMX335_ID		0x00
+#define IMX335_REG_OPB_SIZE_V		CCI_REG8(0x304c)
+#define IMX335_REG_ADBIT		CCI_REG8(0x3050)
+#define IMX335_REG_Y_OUT_SIZE		CCI_REG16_LE(0x3056)
 
-/* Exposure control */
-#define IMX335_REG_SHUTTER	0x3058
-#define IMX335_EXPOSURE_MIN	1
-#define IMX335_EXPOSURE_OFFSET	9
-#define IMX335_EXPOSURE_STEP	1
-#define IMX335_EXPOSURE_DEFAULT	0x0648
+#define IMX335_REG_SHUTTER		CCI_REG24_LE(0x3058)
+#define IMX335_EXPOSURE_MIN		1
+#define IMX335_EXPOSURE_OFFSET		9
+#define IMX335_EXPOSURE_STEP		1
+#define IMX335_EXPOSURE_DEFAULT		0x0648
 
-/* Analog gain control */
-#define IMX335_REG_AGAIN	0x30e8
-#define IMX335_AGAIN_MIN	0
-#define IMX335_AGAIN_MAX	240
-#define IMX335_AGAIN_STEP	1
-#define IMX335_AGAIN_DEFAULT	0
+#define IMX335_REG_AREA3_ST_ADR_1	CCI_REG16_LE(0x3074)
+#define IMX335_REG_AREA3_WIDTH_1	CCI_REG16_LE(0x3076)
 
-/* Group hold register */
-#define IMX335_REG_HOLD		0x3001
+/* Analog gain control */
+#define IMX335_REG_AGAIN		CCI_REG8(0x30e8)
+#define IMX335_AGAIN_MIN		0
+#define IMX335_AGAIN_MAX		240
+#define IMX335_AGAIN_STEP		1
+#define IMX335_AGAIN_DEFAULT		0
+
+#define IMX335_REG_TPG_TESTCLKEN	CCI_REG8(0x3148)
+#define IMX335_REG_INCLKSEL1		CCI_REG16_LE(0x314c)
+#define IMX335_REG_INCLKSEL2		CCI_REG8(0x315a)
+#define IMX335_REG_INCLKSEL3		CCI_REG8(0x3168)
+#define IMX335_REG_INCLKSEL4		CCI_REG8(0x316a)
+#define IMX335_REG_MDBIT		CCI_REG8(0x319d)
+#define IMX335_REG_SYSMODE		CCI_REG8(0x319e)
+
+#define IMX335_REG_XVS_XHS_DRV		CCI_REG8(0x31a1)
 
 /* Test pattern generator */
-#define IMX335_REG_TPG		0x329e
-#define IMX335_TPG_ALL_000	0
-#define IMX335_TPG_ALL_FFF	1
-#define IMX335_TPG_ALL_555	2
-#define IMX335_TPG_ALL_AAA	3
-#define IMX335_TPG_TOG_555_AAA	4
-#define IMX335_TPG_TOG_AAA_555	5
-#define IMX335_TPG_TOG_000_555	6
-#define IMX335_TPG_TOG_555_000	7
-#define IMX335_TPG_TOG_000_FFF	8
-#define IMX335_TPG_TOG_FFF_000	9
-#define IMX335_TPG_H_COLOR_BARS 10
-#define IMX335_TPG_V_COLOR_BARS 11
+#define IMX335_REG_TPG_DIG_CLP_MODE	CCI_REG8(0x3280)
+#define IMX335_REG_TPG_EN_DUOUT		CCI_REG8(0x329c)
+#define IMX335_REG_TPG			CCI_REG8(0x329e)
+#define IMX335_REG_TPG_COLORWIDTH	CCI_REG8(0x32a0)
+#define IMX335_REG_TPG_BLKLEVEL		CCI_REG16_LE(0x3302)
+#define IMX335_REG_TPG_WRJ_OPEN		CCI_REG8(0x336c)
+#define IMX335_TPG_ALL_000		0
+#define IMX335_TPG_ALL_FFF		1
+#define IMX335_TPG_ALL_555		2
+#define IMX335_TPG_ALL_AAA		3
+#define IMX335_TPG_TOG_555_AAA		4
+#define IMX335_TPG_TOG_AAA_555		5
+#define IMX335_TPG_TOG_000_555		6
+#define IMX335_TPG_TOG_555_000		7
+#define IMX335_TPG_TOG_000_FFF		8
+#define IMX335_TPG_TOG_FFF_000		9
+#define IMX335_TPG_H_COLOR_BARS		10
+#define IMX335_TPG_V_COLOR_BARS		11
+
+#define IMX335_REG_ADBIT1		CCI_REG16_LE(0x341c)
+
+/* Chip ID */
+#define IMX335_REG_ID			CCI_REG8(0x3912)
+#define IMX335_ID			0x00
+
+/* Data Lanes */
+#define IMX335_REG_LANEMODE		CCI_REG8(0x3a01)
+#define IMX335_2LANE			1
+#define IMX335_4LANE			3
+
+#define IMX335_REG_TCLKPOST		CCI_REG16_LE(0x3a18)
+#define IMX335_REG_TCLKPREPARE		CCI_REG16_LE(0x3a1a)
+#define IMX335_REG_TCLK_TRAIL		CCI_REG16_LE(0x3a1c)
+#define IMX335_REG_TCLK_ZERO		CCI_REG16_LE(0x3a1e)
+#define IMX335_REG_THS_PREPARE		CCI_REG16_LE(0x3a20)
+#define IMX335_REG_THS_ZERO		CCI_REG16_LE(0x3a22)
+#define IMX335_REG_THS_TRAIL		CCI_REG16_LE(0x3a24)
+#define IMX335_REG_THS_EXIT		CCI_REG16_LE(0x3a26)
+#define IMX335_REG_TPLX			CCI_REG16_LE(0x3a28)
 
 /* Input clock rate */
-#define IMX335_INCLK_RATE	24000000
+#define IMX335_INCLK_RATE		24000000
 
 /* CSI2 HW configuration */
 #define IMX335_LINK_FREQ_594MHz		594000000LL
@@ -74,9 +116,6 @@
 
 #define IMX335_NUM_DATA_LANES	4
 
-#define IMX335_REG_MIN		0x00
-#define IMX335_REG_MAX		0xfffff
-
 /* IMX335 native and active pixel array size. */
 #define IMX335_NATIVE_WIDTH		2616U
 #define IMX335_NATIVE_HEIGHT		1964U
@@ -85,16 +124,6 @@
 #define IMX335_PIXEL_ARRAY_WIDTH	2592U
 #define IMX335_PIXEL_ARRAY_HEIGHT	1944U
 
-/**
- * struct imx335_reg - imx335 sensor register
- * @address: Register address
- * @val: Register value
- */
-struct imx335_reg {
-	u16 address;
-	u8 val;
-};
-
 /**
  * struct imx335_reg_list - imx335 sensor register list
  * @num_of_regs: Number of registers in the list
@@ -102,7 +131,7 @@ struct imx335_reg {
  */
 struct imx335_reg_list {
 	u32 num_of_regs;
-	const struct imx335_reg *regs;
+	const struct cci_reg_sequence *regs;
 };
 
 static const char * const imx335_supply_name[] = {
@@ -165,6 +194,7 @@ struct imx335 {
 	struct media_pad pad;
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(imx335_supply_name)];
+	struct regmap *cci;
 
 	struct clk *inclk;
 	struct v4l2_ctrl_handler ctrl_handler;
@@ -217,140 +247,135 @@ static const int imx335_tpg_val[] = {
 };
 
 /* Sensor mode registers */
-static const struct imx335_reg mode_2592x1940_regs[] = {
-	{0x3000, 0x01},
-	{0x3002, 0x00},
-	{0x3018, 0x04},
-	{0x302c, 0x3c},
-	{0x302e, 0x20},
-	{0x3056, 0x94},
-	{0x3074, 0xc8},
-	{0x3076, 0x28},
-	{0x304c, 0x00},
-	{0x31a1, 0x00},
-	{0x3288, 0x21},
-	{0x328a, 0x02},
-	{0x3414, 0x05},
-	{0x3416, 0x18},
-	{0x3648, 0x01},
-	{0x364a, 0x04},
-	{0x364c, 0x04},
-	{0x3678, 0x01},
-	{0x367c, 0x31},
-	{0x367e, 0x31},
-	{0x3706, 0x10},
-	{0x3708, 0x03},
-	{0x3714, 0x02},
-	{0x3715, 0x02},
-	{0x3716, 0x01},
-	{0x3717, 0x03},
-	{0x371c, 0x3d},
-	{0x371d, 0x3f},
-	{0x372c, 0x00},
-	{0x372d, 0x00},
-	{0x372e, 0x46},
-	{0x372f, 0x00},
-	{0x3730, 0x89},
-	{0x3731, 0x00},
-	{0x3732, 0x08},
-	{0x3733, 0x01},
-	{0x3734, 0xfe},
-	{0x3735, 0x05},
-	{0x3740, 0x02},
-	{0x375d, 0x00},
-	{0x375e, 0x00},
-	{0x375f, 0x11},
-	{0x3760, 0x01},
-	{0x3768, 0x1b},
-	{0x3769, 0x1b},
-	{0x376a, 0x1b},
-	{0x376b, 0x1b},
-	{0x376c, 0x1a},
-	{0x376d, 0x17},
-	{0x376e, 0x0f},
-	{0x3776, 0x00},
-	{0x3777, 0x00},
-	{0x3778, 0x46},
-	{0x3779, 0x00},
-	{0x377a, 0x89},
-	{0x377b, 0x00},
-	{0x377c, 0x08},
-	{0x377d, 0x01},
-	{0x377e, 0x23},
-	{0x377f, 0x02},
-	{0x3780, 0xd9},
-	{0x3781, 0x03},
-	{0x3782, 0xf5},
-	{0x3783, 0x06},
-	{0x3784, 0xa5},
-	{0x3788, 0x0f},
-	{0x378a, 0xd9},
-	{0x378b, 0x03},
-	{0x378c, 0xeb},
-	{0x378d, 0x05},
-	{0x378e, 0x87},
-	{0x378f, 0x06},
-	{0x3790, 0xf5},
-	{0x3792, 0x43},
-	{0x3794, 0x7a},
-	{0x3796, 0xa1},
-	{0x37b0, 0x36},
-	{0x3a00, 0x00},
+static const struct cci_reg_sequence mode_2592x1940_regs[] = {
+	{IMX335_REG_MODE_SELECT, 0x01},
+	{IMX335_REG_MASTER_MODE, 0x00},
+	{IMX335_REG_WINMODE, 0x04},
+	{IMX335_REG_HTRIMMING_START, 0x0180},
+	{IMX335_REG_HNUM, 0x0a20},
+	{IMX335_REG_Y_OUT_SIZE, 0x0794},
+	{IMX335_REG_AREA3_ST_ADR_1, 0x00b0},
+	{IMX335_REG_AREA3_WIDTH_1, 0x0f58},
+	{IMX335_REG_OPB_SIZE_V, 0x00},
+	{IMX335_REG_XVS_XHS_DRV, 0x00},
+	{CCI_REG8(0x3288), 0x21}, /* undocumented */
+	{CCI_REG8(0x328a), 0x02}, /* undocumented */
+	{CCI_REG8(0x3414), 0x05}, /* undocumented */
+	{CCI_REG8(0x3416), 0x18}, /* undocumented */
+	{CCI_REG8(0x3648), 0x01}, /* undocumented */
+	{CCI_REG8(0x364a), 0x04}, /* undocumented */
+	{CCI_REG8(0x364c), 0x04}, /* undocumented */
+	{CCI_REG8(0x3678), 0x01}, /* undocumented */
+	{CCI_REG8(0x367c), 0x31}, /* undocumented */
+	{CCI_REG8(0x367e), 0x31}, /* undocumented */
+	{CCI_REG8(0x3706), 0x10}, /* undocumented */
+	{CCI_REG8(0x3708), 0x03}, /* undocumented */
+	{CCI_REG8(0x3714), 0x02}, /* undocumented */
+	{CCI_REG8(0x3715), 0x02}, /* undocumented */
+	{CCI_REG8(0x3716), 0x01}, /* undocumented */
+	{CCI_REG8(0x3717), 0x03}, /* undocumented */
+	{CCI_REG8(0x371c), 0x3d}, /* undocumented */
+	{CCI_REG8(0x371d), 0x3f}, /* undocumented */
+	{CCI_REG8(0x372c), 0x00}, /* undocumented */
+	{CCI_REG8(0x372d), 0x00}, /* undocumented */
+	{CCI_REG8(0x372e), 0x46}, /* undocumented */
+	{CCI_REG8(0x372f), 0x00}, /* undocumented */
+	{CCI_REG8(0x3730), 0x89}, /* undocumented */
+	{CCI_REG8(0x3731), 0x00}, /* undocumented */
+	{CCI_REG8(0x3732), 0x08}, /* undocumented */
+	{CCI_REG8(0x3733), 0x01}, /* undocumented */
+	{CCI_REG8(0x3734), 0xfe}, /* undocumented */
+	{CCI_REG8(0x3735), 0x05}, /* undocumented */
+	{CCI_REG8(0x3740), 0x02}, /* undocumented */
+	{CCI_REG8(0x375d), 0x00}, /* undocumented */
+	{CCI_REG8(0x375e), 0x00}, /* undocumented */
+	{CCI_REG8(0x375f), 0x11}, /* undocumented */
+	{CCI_REG8(0x3760), 0x01}, /* undocumented */
+	{CCI_REG8(0x3768), 0x1b}, /* undocumented */
+	{CCI_REG8(0x3769), 0x1b}, /* undocumented */
+	{CCI_REG8(0x376a), 0x1b}, /* undocumented */
+	{CCI_REG8(0x376b), 0x1b}, /* undocumented */
+	{CCI_REG8(0x376c), 0x1a}, /* undocumented */
+	{CCI_REG8(0x376d), 0x17}, /* undocumented */
+	{CCI_REG8(0x376e), 0x0f}, /* undocumented */
+	{CCI_REG8(0x3776), 0x00}, /* undocumented */
+	{CCI_REG8(0x3777), 0x00}, /* undocumented */
+	{CCI_REG8(0x3778), 0x46}, /* undocumented */
+	{CCI_REG8(0x3779), 0x00}, /* undocumented */
+	{CCI_REG8(0x377a), 0x89}, /* undocumented */
+	{CCI_REG8(0x377b), 0x00}, /* undocumented */
+	{CCI_REG8(0x377c), 0x08}, /* undocumented */
+	{CCI_REG8(0x377d), 0x01}, /* undocumented */
+	{CCI_REG8(0x377e), 0x23}, /* undocumented */
+	{CCI_REG8(0x377f), 0x02}, /* undocumented */
+	{CCI_REG8(0x3780), 0xd9}, /* undocumented */
+	{CCI_REG8(0x3781), 0x03}, /* undocumented */
+	{CCI_REG8(0x3782), 0xf5}, /* undocumented */
+	{CCI_REG8(0x3783), 0x06}, /* undocumented */
+	{CCI_REG8(0x3784), 0xa5}, /* undocumented */
+	{CCI_REG8(0x3788), 0x0f}, /* undocumented */
+	{CCI_REG8(0x378a), 0xd9}, /* undocumented */
+	{CCI_REG8(0x378b), 0x03}, /* undocumented */
+	{CCI_REG8(0x378c), 0xeb}, /* undocumented */
+	{CCI_REG8(0x378d), 0x05}, /* undocumented */
+	{CCI_REG8(0x378e), 0x87}, /* undocumented */
+	{CCI_REG8(0x378f), 0x06}, /* undocumented */
+	{CCI_REG8(0x3790), 0xf5}, /* undocumented */
+	{CCI_REG8(0x3792), 0x43}, /* undocumented */
+	{CCI_REG8(0x3794), 0x7a}, /* undocumented */
+	{CCI_REG8(0x3796), 0xa1}, /* undocumented */
+	{CCI_REG8(0x37b0), 0x36}, /* undocumented */
+	{CCI_REG8(0x3a00), 0x00}, /* undocumented */
 };
 
-static const struct imx335_reg raw10_framefmt_regs[] = {
-	{0x3050, 0x00},
-	{0x319d, 0x00},
-	{0x341c, 0xff},
-	{0x341d, 0x01},
+static const struct cci_reg_sequence raw10_framefmt_regs[] = {
+	{IMX335_REG_ADBIT, 0x00},
+	{IMX335_REG_MDBIT, 0x00},
+	{IMX335_REG_ADBIT1, 0x1ff},
 };
 
-static const struct imx335_reg raw12_framefmt_regs[] = {
-	{0x3050, 0x01},
-	{0x319d, 0x01},
-	{0x341c, 0x47},
-	{0x341d, 0x00},
+static const struct cci_reg_sequence raw12_framefmt_regs[] = {
+	{IMX335_REG_ADBIT, 0x01},
+	{IMX335_REG_MDBIT, 0x01},
+	{IMX335_REG_ADBIT1, 0x47},
 };
 
-static const struct imx335_reg mipi_data_rate_1188Mbps[] = {
-	{0x300c, 0x3b},
-	{0x300d, 0x2a},
-	{0x314c, 0xc6},
-	{0x314d, 0x00},
-	{0x315a, 0x02},
-	{0x3168, 0xa0},
-	{0x316a, 0x7e},
-	{0x319e, 0x01},
-	{0x3a18, 0x8f},
-	{0x3a1a, 0x4f},
-	{0x3a1c, 0x47},
-	{0x3a1e, 0x37},
-	{0x3a1f, 0x01},
-	{0x3a20, 0x4f},
-	{0x3a22, 0x87},
-	{0x3a24, 0x4f},
-	{0x3a26, 0x7f},
-	{0x3a28, 0x3f},
+static const struct cci_reg_sequence mipi_data_rate_1188Mbps[] = {
+	{IMX335_REG_BCWAIT_TIME, 0x3b},
+	{IMX335_REG_CPWAIT_TIME, 0x2a},
+	{IMX335_REG_INCLKSEL1, 0x00c6},
+	{IMX335_REG_INCLKSEL2, 0x02},
+	{IMX335_REG_INCLKSEL3, 0xa0},
+	{IMX335_REG_INCLKSEL4, 0x7e},
+	{IMX335_REG_SYSMODE, 0x01},
+	{IMX335_REG_TCLKPOST, 0x8f},
+	{IMX335_REG_TCLKPREPARE, 0x4f},
+	{IMX335_REG_TCLK_TRAIL, 0x47},
+	{IMX335_REG_TCLK_ZERO, 0x0137},
+	{IMX335_REG_THS_PREPARE, 0x4f},
+	{IMX335_REG_THS_ZERO,  0x87},
+	{IMX335_REG_THS_TRAIL, 0x4f},
+	{IMX335_REG_THS_EXIT, 0x7f},
+	{IMX335_REG_TPLX, 0x3f},
 };
 
-static const struct imx335_reg mipi_data_rate_891Mbps[] = {
-	{0x300c, 0x3b},
-	{0x300d, 0x2a},
-	{0x314c, 0x29},
-	{0x314d, 0x01},
-	{0x315a, 0x06},
-	{0x3168, 0xa0},
-	{0x316a, 0x7e},
-	{0x319e, 0x02},
-	{0x3a18, 0x7f},
-	{0x3a1a, 0x37},
-	{0x3a1c, 0x37},
-	{0x3a1e, 0xf7},
-	{0x3a20, 0x3f},
-	{0x3a22, 0x6f},
-	{0x3a24, 0x3f},
-	{0x3a26, 0x5f},
-	{0x3a28, 0x2f},
+static const struct cci_reg_sequence mipi_data_rate_891Mbps[] = {
+	{IMX335_REG_BCWAIT_TIME, 0x3b},
+	{IMX335_REG_CPWAIT_TIME, 0x2a},
+	{IMX335_REG_INCLKSEL1, 0x0129},
+	{IMX335_REG_INCLKSEL2, 0x06},
+	{IMX335_REG_INCLKSEL3, 0xa0},
+	{IMX335_REG_INCLKSEL4, 0x7e},
+	{IMX335_REG_SYSMODE, 0x02},
+	{IMX335_REG_TCLKPOST, 0x7f},
+	{IMX335_REG_TCLKPREPARE, 0x37},
+	{IMX335_REG_TCLK_TRAIL, 0x37},
+	{IMX335_REG_TCLK_ZERO, 0xf7},
+	{IMX335_REG_THS_PREPARE, 0x3f},
+	{IMX335_REG_THS_ZERO, 0x6f},
+	{IMX335_REG_THS_TRAIL, 0x3f},
+	{IMX335_REG_THS_EXIT, 0x5f},
+	{IMX335_REG_TPLX, 0x2f},
 };
 
 static const s64 link_freq[] = {
@@ -402,101 +427,6 @@ static inline struct imx335 *to_imx335(struct v4l2_subdev *subdev)
 	return container_of(subdev, struct imx335, sd);
 }
 
-/**
- * imx335_read_reg() - Read registers.
- * @imx335: pointer to imx335 device
- * @reg: register address
- * @len: length of bytes to read. Max supported bytes is 4
- * @val: pointer to register value to be filled.
- *
- * Big endian register addresses with little endian values.
- *
- * Return: 0 if successful, error code otherwise.
- */
-static int imx335_read_reg(struct imx335 *imx335, u16 reg, u32 len, u32 *val)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&imx335->sd);
-	struct i2c_msg msgs[2] = {0};
-	u8 addr_buf[2] = {0};
-	u8 data_buf[4] = {0};
-	int ret;
-
-	if (WARN_ON(len > 4))
-		return -EINVAL;
-
-	put_unaligned_be16(reg, addr_buf);
-
-	/* Write register address */
-	msgs[0].addr = client->addr;
-	msgs[0].flags = 0;
-	msgs[0].len = ARRAY_SIZE(addr_buf);
-	msgs[0].buf = addr_buf;
-
-	/* Read data from register */
-	msgs[1].addr = client->addr;
-	msgs[1].flags = I2C_M_RD;
-	msgs[1].len = len;
-	msgs[1].buf = data_buf;
-
-	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
-	if (ret != ARRAY_SIZE(msgs))
-		return -EIO;
-
-	*val = get_unaligned_le32(data_buf);
-
-	return 0;
-}
-
-/**
- * imx335_write_reg() - Write register
- * @imx335: pointer to imx335 device
- * @reg: register address
- * @len: length of bytes. Max supported bytes is 4
- * @val: register value
- *
- * Big endian register addresses with little endian values.
- *
- * Return: 0 if successful, error code otherwise.
- */
-static int imx335_write_reg(struct imx335 *imx335, u16 reg, u32 len, u32 val)
-{
-	struct i2c_client *client = v4l2_get_subdevdata(&imx335->sd);
-	u8 buf[6] = {0};
-
-	if (WARN_ON(len > 4))
-		return -EINVAL;
-
-	put_unaligned_be16(reg, buf);
-	put_unaligned_le32(val, buf + 2);
-	if (i2c_master_send(client, buf, len + 2) != len + 2)
-		return -EIO;
-
-	return 0;
-}
-
-/**
- * imx335_write_regs() - Write a list of registers
- * @imx335: pointer to imx335 device
- * @regs: list of registers to be written
- * @len: length of registers array
- *
- * Return: 0 if successful. error code otherwise.
- */
-static int imx335_write_regs(struct imx335 *imx335,
-			     const struct imx335_reg *regs, u32 len)
-{
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < len; i++) {
-		ret = imx335_write_reg(imx335, regs[i].address, 1, regs[i].val);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * imx335_update_controls() - Update control ranges based on streaming mode
  * @imx335: pointer to imx335 device
@@ -533,7 +463,8 @@ static int imx335_update_controls(struct imx335 *imx335,
 static int imx335_update_exp_gain(struct imx335 *imx335, u32 exposure, u32 gain)
 {
 	u32 lpfr, shutter;
-	int ret;
+	int ret_hold;
+	int ret = 0;
 
 	lpfr = imx335->vblank + imx335->cur_mode->height;
 	shutter = lpfr - exposure;
@@ -541,64 +472,55 @@ static int imx335_update_exp_gain(struct imx335 *imx335, u32 exposure, u32 gain)
 	dev_dbg(imx335->dev, "Set exp %u, analog gain %u, shutter %u, lpfr %u\n",
 		exposure, gain, shutter, lpfr);
 
-	ret = imx335_write_reg(imx335, IMX335_REG_HOLD, 1, 1);
-	if (ret)
-		return ret;
-
-	ret = imx335_write_reg(imx335, IMX335_REG_LPFR, 3, lpfr);
-	if (ret)
-		goto error_release_group_hold;
-
-	ret = imx335_write_reg(imx335, IMX335_REG_SHUTTER, 3, shutter);
-	if (ret)
-		goto error_release_group_hold;
-
-	ret = imx335_write_reg(imx335, IMX335_REG_AGAIN, 2, gain);
-
-error_release_group_hold:
-	imx335_write_reg(imx335, IMX335_REG_HOLD, 1, 0);
+	cci_write(imx335->cci, IMX335_REG_HOLD, 1, &ret);
+	cci_write(imx335->cci, IMX335_REG_VMAX, lpfr, &ret);
+	cci_write(imx335->cci, IMX335_REG_SHUTTER, shutter, &ret);
+	cci_write(imx335->cci, IMX335_REG_AGAIN, gain, &ret);
+	/*
+	 * Unconditionally attempt to release the hold, but track the
+	 * error if the unhold itself fails.
+	 */
+	ret_hold = cci_write(imx335->cci, IMX335_REG_HOLD, 0, NULL);
+	if (ret_hold)
+		ret = ret_hold;
 
 	return ret;
 }
 
 static int imx335_update_test_pattern(struct imx335 *imx335, u32 pattern_index)
 {
-	int ret;
+	int ret = 0;
 
 	if (pattern_index >= ARRAY_SIZE(imx335_tpg_val))
 		return -EINVAL;
 
 	if (pattern_index) {
-		const struct imx335_reg tpg_enable_regs[] = {
-			{ 0x3148, 0x10 },
-			{ 0x3280, 0x00 },
-			{ 0x329c, 0x01 },
-			{ 0x32a0, 0x11 },
-			{ 0x3302, 0x00 },
-			{ 0x3303, 0x00 },
-			{ 0x336c, 0x00 },
+		const struct cci_reg_sequence tpg_enable_regs[] = {
+			{IMX335_REG_TPG_TESTCLKEN, 0x10},
+			{IMX335_REG_TPG_DIG_CLP_MODE, 0x00},
+			{IMX335_REG_TPG_EN_DUOUT, 0x01},
+			{IMX335_REG_TPG_COLORWIDTH, 0x11},
+			{IMX335_REG_TPG_BLKLEVEL, 0x00},
+			{IMX335_REG_TPG_WRJ_OPEN, 0x00},
 		};
 
-		ret = imx335_write_reg(imx335, IMX335_REG_TPG, 1,
-				       imx335_tpg_val[pattern_index]);
-		if (ret)
-			return ret;
+		cci_write(imx335->cci, IMX335_REG_TPG,
+			  imx335_tpg_val[pattern_index], &ret);
 
-		ret = imx335_write_regs(imx335, tpg_enable_regs,
-					ARRAY_SIZE(tpg_enable_regs));
+		cci_multi_reg_write(imx335->cci, tpg_enable_regs,
+				    ARRAY_SIZE(tpg_enable_regs), &ret);
 	} else {
-		const struct imx335_reg tpg_disable_regs[] = {
-			{ 0x3148, 0x00 },
-			{ 0x3280, 0x01 },
-			{ 0x329c, 0x00 },
-			{ 0x32a0, 0x10 },
-			{ 0x3302, 0x32 },
-			{ 0x3303, 0x00 },
-			{ 0x336c, 0x01 },
+		const struct cci_reg_sequence tpg_disable_regs[] = {
+			{IMX335_REG_TPG_TESTCLKEN, 0x00},
+			{IMX335_REG_TPG_DIG_CLP_MODE, 0x01},
+			{IMX335_REG_TPG_EN_DUOUT, 0x00},
+			{IMX335_REG_TPG_COLORWIDTH, 0x10},
+			{IMX335_REG_TPG_BLKLEVEL, 0x32},
+			{IMX335_REG_TPG_WRJ_OPEN, 0x01},
 		};
 
-		ret = imx335_write_regs(imx335, tpg_disable_regs,
-					ARRAY_SIZE(tpg_disable_regs));
+		cci_multi_reg_write(imx335->cci, tpg_disable_regs,
+				    ARRAY_SIZE(tpg_disable_regs), &ret);
 	}
 
 	return ret;
@@ -897,12 +819,14 @@ static int imx335_set_framefmt(struct imx335 *imx335)
 {
 	switch (imx335->cur_mbus_code) {
 	case MEDIA_BUS_FMT_SRGGB10_1X10:
-		return imx335_write_regs(imx335, raw10_framefmt_regs,
-					 ARRAY_SIZE(raw10_framefmt_regs));
+		return cci_multi_reg_write(imx335->cci, raw10_framefmt_regs,
+					   ARRAY_SIZE(raw10_framefmt_regs),
+					   NULL);
 
 	case MEDIA_BUS_FMT_SRGGB12_1X12:
-		return imx335_write_regs(imx335, raw12_framefmt_regs,
-					 ARRAY_SIZE(raw12_framefmt_regs));
+		return cci_multi_reg_write(imx335->cci, raw12_framefmt_regs,
+					   ARRAY_SIZE(raw12_framefmt_regs),
+					   NULL);
 	}
 
 	return -EINVAL;
@@ -921,7 +845,8 @@ static int imx335_start_streaming(struct imx335 *imx335)
 
 	/* Setup PLL */
 	reg_list = &link_freq_reglist[__ffs(imx335->link_freq_bitmap)];
-	ret = imx335_write_regs(imx335, reg_list->regs, reg_list->num_of_regs);
+	ret = cci_multi_reg_write(imx335->cci, reg_list->regs,
+				  reg_list->num_of_regs, NULL);
 	if (ret) {
 		dev_err(imx335->dev, "%s failed to set plls\n", __func__);
 		return ret;
@@ -929,8 +854,8 @@ static int imx335_start_streaming(struct imx335 *imx335)
 
 	/* Write sensor mode registers */
 	reg_list = &imx335->cur_mode->reg_list;
-	ret = imx335_write_regs(imx335, reg_list->regs,
-				reg_list->num_of_regs);
+	ret = cci_multi_reg_write(imx335->cci, reg_list->regs,
+				  reg_list->num_of_regs, NULL);
 	if (ret) {
 		dev_err(imx335->dev, "fail to write initial registers\n");
 		return ret;
@@ -944,7 +869,8 @@ static int imx335_start_streaming(struct imx335 *imx335)
 	}
 
 	/* Configure lanes */
-	ret = imx335_write_reg(imx335, IMX335_LANEMODE, 1, imx335->lane_mode);
+	ret = cci_write(imx335->cci, IMX335_REG_LANEMODE,
+			imx335->lane_mode, NULL);
 	if (ret)
 		return ret;
 
@@ -956,8 +882,8 @@ static int imx335_start_streaming(struct imx335 *imx335)
 	}
 
 	/* Start streaming */
-	ret = imx335_write_reg(imx335, IMX335_REG_MODE_SELECT,
-			       1, IMX335_MODE_STREAMING);
+	ret = cci_write(imx335->cci, IMX335_REG_MODE_SELECT,
+			IMX335_MODE_STREAMING, NULL);
 	if (ret) {
 		dev_err(imx335->dev, "fail to start streaming\n");
 		return ret;
@@ -977,8 +903,8 @@ static int imx335_start_streaming(struct imx335 *imx335)
  */
 static int imx335_stop_streaming(struct imx335 *imx335)
 {
-	return imx335_write_reg(imx335, IMX335_REG_MODE_SELECT,
-				1, IMX335_MODE_STANDBY);
+	return cci_write(imx335->cci, IMX335_REG_MODE_SELECT,
+			 IMX335_MODE_STANDBY, NULL);
 }
 
 /**
@@ -1029,14 +955,14 @@ static int imx335_set_stream(struct v4l2_subdev *sd, int enable)
 static int imx335_detect(struct imx335 *imx335)
 {
 	int ret;
-	u32 val;
+	u64 val;
 
-	ret = imx335_read_reg(imx335, IMX335_REG_ID, 2, &val);
+	ret = cci_read(imx335->cci, IMX335_REG_ID, &val, NULL);
 	if (ret)
 		return ret;
 
 	if (val != IMX335_ID) {
-		dev_err(imx335->dev, "chip id mismatch: %x!=%x\n",
+		dev_err(imx335->dev, "chip id mismatch: %x!=%llx\n",
 			IMX335_ID, val);
 		return -ENXIO;
 	}
@@ -1337,6 +1263,11 @@ static int imx335_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	imx335->dev = &client->dev;
+	imx335->cci = devm_cci_regmap_init_i2c(client, 16);
+	if (IS_ERR(imx335->cci)) {
+		dev_err(imx335->dev, "Unable to initialize I2C\n");
+		return -ENODEV;
+	}
 
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx335->sd, client, &imx335_subdev_ops);
-- 
2.43.0


