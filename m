Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CDD799EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbjIJQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjIJQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 12:01:40 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE7D8135;
        Sun, 10 Sep 2023 09:01:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,242,1688396400"; 
   d="scan'208";a="179306928"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 01:01:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 54101401175F;
        Mon, 11 Sep 2023 01:01:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] media: mt9p031: Extend match support for OF tables
Date:   Sun, 10 Sep 2023 17:01:25 +0100
Message-Id: <20230910160126.70122-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910160126.70122-1-biju.das.jz@bp.renesas.com>
References: <20230910160126.70122-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has an OF match table, still, it uses an ID lookup table for
retrieving match data. Currently, the driver is working on the
assumption that an I2C device registered via OF will always match a
legacy I2C device ID. The correct approach is to have an OF device ID
table using i2c_get_match_data() if the devices are registered via OF/ID.

Unify the OF/ID table by using MEDIA_BUS_FMT as match data for both these
tables and replace the ID lookup table for the match data by
i2c_get_match_data() and simplifly probe() and mt9p031_init_cfg()

Drop mt9p031_init_cfg as there is no user.

While at it, remove the trailing comma in the terminator entry for the OF
table making code robust against (theoretical) misrebases or other similar
things where the new entry goes _after_ the termination without the
compiler noticing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/mt9p031.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
index 348f1e1098fb..540cb519915c 100644
--- a/drivers/media/i2c/mt9p031.c
+++ b/drivers/media/i2c/mt9p031.c
@@ -112,11 +112,6 @@
 #define MT9P031_TEST_PATTERN_RED			0xa2
 #define MT9P031_TEST_PATTERN_BLUE			0xa3
 
-enum mt9p031_model {
-	MT9P031_MODEL_COLOR,
-	MT9P031_MODEL_MONOCHROME,
-};
-
 struct mt9p031 {
 	struct v4l2_subdev subdev;
 	struct media_pad pad;
@@ -129,7 +124,7 @@ struct mt9p031 {
 	struct clk *clk;
 	struct regulator_bulk_data regulators[3];
 
-	enum mt9p031_model model;
+	u32 code;
 	struct aptina_pll pll;
 	unsigned int clk_div;
 	bool use_pll;
@@ -714,12 +709,7 @@ static int mt9p031_init_cfg(struct v4l2_subdev *subdev,
 	crop->height = MT9P031_WINDOW_HEIGHT_DEF;
 
 	format = __mt9p031_get_pad_format(mt9p031, sd_state, 0, which);
-
-	if (mt9p031->model == MT9P031_MODEL_MONOCHROME)
-		format->code = MEDIA_BUS_FMT_Y12_1X12;
-	else
-		format->code = MEDIA_BUS_FMT_SGRBG12_1X12;
-
+	format->code = mt9p031->code;
 	format->width = MT9P031_WINDOW_WIDTH_DEF;
 	format->height = MT9P031_WINDOW_HEIGHT_DEF;
 	format->field = V4L2_FIELD_NONE;
@@ -1104,7 +1094,6 @@ mt9p031_get_pdata(struct i2c_client *client)
 
 static int mt9p031_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *did = i2c_client_get_device_id(client);
 	struct mt9p031_platform_data *pdata = mt9p031_get_pdata(client);
 	struct i2c_adapter *adapter = client->adapter;
 	struct mt9p031 *mt9p031;
@@ -1129,7 +1118,7 @@ static int mt9p031_probe(struct i2c_client *client)
 	mt9p031->pdata = pdata;
 	mt9p031->output_control	= MT9P031_OUTPUT_CONTROL_DEF;
 	mt9p031->mode2 = MT9P031_READ_MODE_2_ROW_BLC;
-	mt9p031->model = did->driver_data;
+	mt9p031->code = (uintptr_t)i2c_get_match_data(client);
 
 	mt9p031->regulators[0].supply = "vdd";
 	mt9p031->regulators[1].supply = "vdd_io";
@@ -1226,19 +1215,19 @@ static void mt9p031_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mt9p031_id[] = {
-	{ "mt9p006", MT9P031_MODEL_COLOR },
-	{ "mt9p031", MT9P031_MODEL_COLOR },
-	{ "mt9p031m", MT9P031_MODEL_MONOCHROME },
-	{ }
+	{ "mt9p006", MEDIA_BUS_FMT_SGRBG12_1X12 },
+	{ "mt9p031", MEDIA_BUS_FMT_SGRBG12_1X12 },
+	{ "mt9p031m", MEDIA_BUS_FMT_Y12_1X12 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, mt9p031_id);
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id mt9p031_of_match[] = {
-	{ .compatible = "aptina,mt9p006", },
-	{ .compatible = "aptina,mt9p031", },
-	{ .compatible = "aptina,mt9p031m", },
-	{ /* sentinel */ },
+	{ .compatible = "aptina,mt9p006", .data = (void *)MEDIA_BUS_FMT_SGRBG12_1X12 },
+	{ .compatible = "aptina,mt9p031", .data = (void *)MEDIA_BUS_FMT_SGRBG12_1X12 },
+	{ .compatible = "aptina,mt9p031m", .data = (void *)MEDIA_BUS_FMT_Y12_1X12 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mt9p031_of_match);
 #endif
-- 
2.25.1

