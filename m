Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BD790970
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjIBUFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjIBUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:05:29 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4FC5CE;
        Sat,  2 Sep 2023 13:05:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,223,1688396400"; 
   d="scan'208";a="174805141"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2023 05:05:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5A694406C23C;
        Sun,  3 Sep 2023 05:05:23 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] power: supply: bq2515x: Simpilfy bq2515x_read_properties() and probe()
Date:   Sat,  2 Sep 2023 21:05:17 +0100
Message-Id: <20230902200518.91585-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
References: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct bq2515x_info and replace device_id->info in struct
bq2515x_device.

Simpilfy bq2515x_read_properties() and probe() by adding struct
bq2425x_chip_info as match data for OF/ID tables and use
i2c_get_match_data for retrieving match data instead of ID lookup.

Drop enum bq2515x_id as there is no user.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/power/supply/bq2515x_charger.c | 61 ++++++++++++--------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index 1dbacc9b015d..ada4532fda45 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -147,9 +147,14 @@ struct bq2515x_init_data {
 	int iprechg;
 };
 
-enum bq2515x_id {
-	BQ25150,
-	BQ25155,
+/**
+ * struct bq2515x_info -
+ * @regmap_config: register map config
+ * @ilim: input current limit
+ */
+struct bq2515x_info {
+	const struct regmap_config *regmap_config;
+	int ilim;
 };
 
 /**
@@ -164,8 +169,8 @@ enum bq2515x_id {
  * @ac_detect_gpio: power good (PG) pin
  * @ce_gpio: charge enable (CE) pin
  *
+ * @info: device info
  * @model_name: string value describing device model
- * @device_id: value of device_id
  * @mains_online: boolean value indicating power supply online
  *
  * @init_data: charger initialization data structure
@@ -181,8 +186,8 @@ struct bq2515x_device {
 	struct gpio_desc *ac_detect_gpio;
 	struct gpio_desc *ce_gpio;
 
+	const struct bq2515x_info *info;
 	char model_name[I2C_NAME_SIZE];
-	int device_id;
 	bool mains_online;
 
 	struct bq2515x_init_data init_data;
@@ -998,16 +1003,8 @@ static int bq2515x_read_properties(struct bq2515x_device *bq2515x)
 	ret = device_property_read_u32(bq2515x->dev,
 				      "input-current-limit-microamp",
 				      &bq2515x->init_data.ilim);
-	if (ret) {
-		switch (bq2515x->device_id) {
-		case BQ25150:
-			bq2515x->init_data.ilim = BQ25150_DEFAULT_ILIM_UA;
-			break;
-		case BQ25155:
-			bq2515x->init_data.ilim = BQ25155_DEFAULT_ILIM_UA;
-			break;
-		}
-	}
+	if (ret)
+		bq2515x->init_data.ilim = bq2515x->info->ilim;
 
 	bq2515x->ac_detect_gpio = devm_gpiod_get_optional(bq2515x->dev,
 						   "ac-detect", GPIOD_IN);
@@ -1094,19 +1091,9 @@ static int bq2515x_probe(struct i2c_client *client)
 
 	strncpy(bq2515x->model_name, id->name, I2C_NAME_SIZE);
 
-	bq2515x->device_id = id->driver_data;
-
-	switch (bq2515x->device_id) {
-	case BQ25150:
-		bq2515x->regmap = devm_regmap_init_i2c(client,
-						&bq25150_regmap_config);
-		break;
-	case BQ25155:
-		bq2515x->regmap = devm_regmap_init_i2c(client,
-						&bq25155_regmap_config);
-		break;
-	}
-
+	bq2515x->info = i2c_get_match_data(client);
+	bq2515x->regmap = devm_regmap_init_i2c(client,
+					       bq2515x->info->regmap_config);
 	if (IS_ERR(bq2515x->regmap)) {
 		dev_err(dev, "failed to allocate register map\n");
 		return PTR_ERR(bq2515x->regmap);
@@ -1139,16 +1126,26 @@ static int bq2515x_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct bq2515x_info bq25150 = {
+	.regmap_config = &bq25150_regmap_config,
+	.ilim = BQ25150_DEFAULT_ILIM_UA,
+};
+
+static const struct bq2515x_info bq25155 = {
+	.regmap_config = &bq25155_regmap_config,
+	.ilim = BQ25155_DEFAULT_ILIM_UA,
+};
+
 static const struct i2c_device_id bq2515x_i2c_ids[] = {
-	{ "bq25150", BQ25150, },
-	{ "bq25155", BQ25155, },
+	{ "bq25150", (kernel_ulong_t)&bq25150 },
+	{ "bq25155", (kernel_ulong_t)&bq25155 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq2515x_i2c_ids);
 
 static const struct of_device_id bq2515x_of_match[] = {
-	{ .compatible = "ti,bq25150", },
-	{ .compatible = "ti,bq25155", },
+	{ .compatible = "ti,bq25150", .data = &bq25150 },
+	{ .compatible = "ti,bq25155", .data = &bq25155 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq2515x_of_match);
-- 
2.25.1

