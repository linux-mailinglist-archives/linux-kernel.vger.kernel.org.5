Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B1799F0C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjIJQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIJQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 12:54:45 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C877CC5;
        Sun, 10 Sep 2023 09:54:41 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,242,1688396400"; 
   d="scan'208";a="179309131"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 01:54:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9485840001D2;
        Mon, 11 Sep 2023 01:54:38 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] media: i2c: mt9v032: Extend match support for OF tables
Date:   Sun, 10 Sep 2023 17:54:31 +0100
Message-Id: <20230910165432.76378-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910165432.76378-1-biju.das.jz@bp.renesas.com>
References: <20230910165432.76378-1-biju.das.jz@bp.renesas.com>
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

Unify the OF/ID table by using mt9v032_model_info as match data for both
these tables and replace the ID lookup table for the match data by
i2c_get_match_data() and simplifly probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/mt9v032.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/mt9v032.c b/drivers/media/i2c/mt9v032.c
index 00e7bc6e3235..0f448aa27e53 100644
--- a/drivers/media/i2c/mt9v032.c
+++ b/drivers/media/i2c/mt9v032.c
@@ -1046,7 +1046,6 @@ mt9v032_get_pdata(struct i2c_client *client)
 
 static int mt9v032_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *did = i2c_client_get_device_id(client);
 	struct mt9v032_platform_data *pdata = mt9v032_get_pdata(client);
 	struct mt9v032 *mt9v032;
 	unsigned int i;
@@ -1076,7 +1075,7 @@ static int mt9v032_probe(struct i2c_client *client)
 
 	mutex_init(&mt9v032->power_lock);
 	mt9v032->pdata = pdata;
-	mt9v032->model = (const void *)did->driver_data;
+	mt9v032->model = i2c_get_match_data(client);
 
 	v4l2_ctrl_handler_init(&mt9v032->ctrls, 11 +
 			       ARRAY_SIZE(mt9v032_aegc_controls));
@@ -1272,20 +1271,20 @@ static const struct i2c_device_id mt9v032_id[] = {
 	{ "mt9v032m", (kernel_ulong_t)&mt9v032_models[MT9V032_MODEL_V032_MONO] },
 	{ "mt9v034", (kernel_ulong_t)&mt9v032_models[MT9V032_MODEL_V034_COLOR] },
 	{ "mt9v034m", (kernel_ulong_t)&mt9v032_models[MT9V032_MODEL_V034_MONO] },
-	{ }
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, mt9v032_id);
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id mt9v032_of_match[] = {
-	{ .compatible = "aptina,mt9v022" },
-	{ .compatible = "aptina,mt9v022m" },
-	{ .compatible = "aptina,mt9v024" },
-	{ .compatible = "aptina,mt9v024m" },
-	{ .compatible = "aptina,mt9v032" },
-	{ .compatible = "aptina,mt9v032m" },
-	{ .compatible = "aptina,mt9v034" },
-	{ .compatible = "aptina,mt9v034m" },
+	{ .compatible = "aptina,mt9v022", .data = &mt9v032_models[MT9V032_MODEL_V022_COLOR] },
+	{ .compatible = "aptina,mt9v022m", .data = &mt9v032_models[MT9V032_MODEL_V022_MONO] },
+	{ .compatible = "aptina,mt9v024", .data = &mt9v032_models[MT9V032_MODEL_V024_COLOR] },
+	{ .compatible = "aptina,mt9v024m", .data = &mt9v032_models[MT9V032_MODEL_V024_MONO] },
+	{ .compatible = "aptina,mt9v032", .data = &mt9v032_models[MT9V032_MODEL_V032_COLOR] },
+	{ .compatible = "aptina,mt9v032m", .data = &mt9v032_models[MT9V032_MODEL_V032_MONO] },
+	{ .compatible = "aptina,mt9v034", .data = &mt9v032_models[MT9V032_MODEL_V034_COLOR] },
+	{ .compatible = "aptina,mt9v034m", .data = &mt9v032_models[MT9V032_MODEL_V034_MONO] },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mt9v032_of_match);
-- 
2.25.1

