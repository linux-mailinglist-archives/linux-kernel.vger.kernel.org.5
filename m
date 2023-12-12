Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231E580F706
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbjLLTlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377275AbjLLTk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:40:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21099A;
        Tue, 12 Dec 2023 11:41:01 -0800 (PST)
Received: from umang.jain (unknown [103.86.18.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6BFA9480;
        Tue, 12 Dec 2023 20:40:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702410015;
        bh=fLvoy9Vtgdt4I74X/yGgtQus14ewjnV/vqJoRnQ6bMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Wbwehby7qXiNIanBlO4l8S8G6L1upakOOvtY4KhRUxU6BJLYwAnhSX0o0McDwkNc1
         ZIfGAEvL9WO1xUAbqDcMtnrzdgJYq2dj9Qk+WXVG3CSeSV0z6cTFA8iJaMAl2MOrEm
         znET6iLTuKskxJ/e3Z0hSSPxaLNSg8Uy1GDd430A=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     "Paul J . Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] media: i2c: imx335: Support multiple link frequency
Date:   Wed, 13 Dec 2023 01:10:52 +0530
Message-ID: <20231212194052.458361-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support link frequency of 445MHz in addition to 594MHz.
Break out the register set specific to each data lane rate
and add the general timing register set corresponding to
each data lane rate configuration.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
Changes in v2:
- Split out from [PATCH v3 0/8] media: Sony IMX335 improvements
  where original patch was introduced.
- Add general timing registers to each data lane rate configuration
- Reword commit message. 
---
 drivers/media/i2c/imx335.c | 108 +++++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 7a37eb327ff4..030c4b3dab02 100644
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
@@ -266,6 +258,65 @@ static const struct imx335_reg raw12_framefmt_regs[] = {
 	{0x341d, 0x00},
 };
 
+static const struct imx335_reg mipi_data_rate_1188Mbps[] = {
+        {0x300c, 0x3b},
+        {0x300d, 0x2a},
+        {0x314c, 0xc6},
+        {0x314d, 0x00},
+        {0x315a, 0x02},
+        {0x3168, 0xa0},
+        {0x316a, 0x7e},
+        {0x319e, 0x01},
+        {0x3a18, 0x8f},
+        {0x3a1a, 0x4f},
+        {0x3a1c, 0x47},
+        {0x3a1e, 0x37},
+        {0x3a1f, 0x01},
+        {0x3a20, 0x4f},
+        {0x3a22, 0x87},
+        {0x3a24, 0x4f},
+        {0x3a26, 0x7f},
+        {0x3a28, 0x3f},
+};
+
+static const struct imx335_reg mipi_data_rate_891Mbps[] = {
+        {0x300c, 0x3b},
+        {0x300d, 0x2a},
+        {0x314c, 0x29},
+        {0x314d, 0x01},
+        {0x315a, 0x06},
+        {0x3168, 0xa0},
+        {0x316a, 0x7e},
+        {0x319e, 0x02},
+        {0x3a18, 0x7f},
+        {0x3a1a, 0x37},
+        {0x3a1c, 0x37},
+        {0x3a1e, 0xf7},
+        {0x3a20, 0x3f},
+        {0x3a22, 0x6f},
+        {0x3a24, 0x3f},
+        {0x3a26, 0x5f},
+        {0x3a28, 0x2f},
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
@@ -280,7 +331,6 @@ static const struct imx335_mode supported_mode = {
 	.vblank_min = 2560,
 	.vblank_max = 133060,
 	.pclk = 396000000,
-	.link_freq_idx = 0,
 	.reg_list = {
 		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
 		.regs = mode_2592x1940_regs,
@@ -405,7 +455,7 @@ static int imx335_update_controls(struct imx335 *imx335,
 {
 	int ret;
 
-	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, mode->link_freq_idx);
+	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, imx335->link_freq_idx);
 	if (ret)
 		return ret;
 
@@ -755,6 +805,14 @@ static int imx335_start_streaming(struct imx335 *imx335)
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
@@ -881,7 +939,7 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 	};
 	struct fwnode_handle *ep;
 	unsigned long rate;
-	unsigned int i;
+	unsigned int i, j;
 	int ret;
 
 	if (!fwnode)
@@ -945,13 +1003,21 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
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
@@ -1101,7 +1167,7 @@ static int imx335_init_controls(struct imx335 *imx335)
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

