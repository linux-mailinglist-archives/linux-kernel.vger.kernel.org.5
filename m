Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDB790CEF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245705AbjICQsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjICQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:48:46 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA07294
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:48:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178560459"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2023 01:48:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 89471402309A;
        Mon,  4 Sep 2023 01:48:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] regulator: pv880x0: Simplify probe()
Date:   Sun,  3 Sep 2023 17:48:32 +0100
Message-Id: <20230903164832.83077-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230903164832.83077-1-biju.das.jz@bp.renesas.com>
References: <20230903164832.83077-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pv88080_types->pv88080_compatible_regmap in OF/ID tables and
simplify the probe() by replacing of_match_node() and ID lookup for
retrieving match data by i2c_get_match_data(). After this there is
no user of enum pv88080_types. So drop it.

While at it, move OF table near to the user.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Moved OF tables close to the user as patch#1 restored OF table
   position.
 * Dropped extra space from OF table entry.
v1->v2:
 * Moved OF/ID tables close to the user
 * Removed trailing comma in the terminator entry for OF/ID tables.
---
 drivers/regulator/pv88080-regulator.c | 51 ++++++++-------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 1b2a8385e2e8..9fe539a34786 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -29,11 +29,6 @@ enum {
 	PV88080_ID_HVBUCK,
 };
 
-enum pv88080_types {
-	TYPE_PV88080_AA,
-	TYPE_PV88080_BA,
-};
-
 struct pv88080_regulator {
 	struct regulator_desc desc;
 	unsigned int mode_reg;
@@ -197,14 +192,6 @@ static const struct pv88080_compatible_regmap pv88080_ba_regs = {
 	.hvbuck_vsel_mask		  = PV88080_VHVBUCK_MASK,
 };
 
-static const struct of_device_id pv88080_dt_ids[] = {
-	{ .compatible = "pvs,pv88080",    .data = (void *)TYPE_PV88080_AA },
-	{ .compatible = "pvs,pv88080-aa", .data = (void *)TYPE_PV88080_AA },
-	{ .compatible = "pvs,pv88080-ba", .data = (void *)TYPE_PV88080_BA },
-	{}
-};
-MODULE_DEVICE_TABLE(of, pv88080_dt_ids);
-
 static unsigned int pv88080_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct pv88080_regulator *info = rdev_get_drvdata(rdev);
@@ -375,11 +362,9 @@ static irqreturn_t pv88080_irq_handler(int irq, void *data)
  */
 static int pv88080_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct regulator_init_data *init_data = dev_get_platdata(&i2c->dev);
 	struct pv88080 *chip;
 	const struct pv88080_compatible_regmap *regmap_config;
-	const struct of_device_id *match;
 	struct regulator_config config = { };
 	int i, error, ret;
 	unsigned int conf2, conf5;
@@ -397,16 +382,9 @@ static int pv88080_i2c_probe(struct i2c_client *i2c)
 		return error;
 	}
 
-	if (i2c->dev.of_node) {
-		match = of_match_node(pv88080_dt_ids, i2c->dev.of_node);
-		if (!match) {
-			dev_err(chip->dev, "Failed to get of_match_node\n");
-			return -EINVAL;
-		}
-		chip->type = (unsigned long)match->data;
-	} else {
-		chip->type = id->driver_data;
-	}
+	chip->regmap_config = i2c_get_match_data(i2c);
+	if (!chip->regmap_config)
+		return -ENODEV;
 
 	i2c_set_clientdata(i2c, chip);
 
@@ -451,15 +429,6 @@ static int pv88080_i2c_probe(struct i2c_client *i2c)
 		dev_warn(chip->dev, "No IRQ configured\n");
 	}
 
-	switch (chip->type) {
-	case TYPE_PV88080_AA:
-		chip->regmap_config = &pv88080_aa_regs;
-		break;
-	case TYPE_PV88080_BA:
-		chip->regmap_config = &pv88080_ba_regs;
-		break;
-	}
-
 	regmap_config = chip->regmap_config;
 	config.dev = chip->dev;
 	config.regmap = chip->regmap;
@@ -545,10 +514,18 @@ static int pv88080_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
+static const struct of_device_id pv88080_dt_ids[] = {
+	{ .compatible = "pvs,pv88080",    .data = &pv88080_aa_regs },
+	{ .compatible = "pvs,pv88080-aa", .data = &pv88080_aa_regs },
+	{ .compatible = "pvs,pv88080-ba", .data = &pv88080_ba_regs },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pv88080_dt_ids);
+
 static const struct i2c_device_id pv88080_i2c_id[] = {
-	{ "pv88080",    TYPE_PV88080_AA },
-	{ "pv88080-aa", TYPE_PV88080_AA },
-	{ "pv88080-ba", TYPE_PV88080_BA },
+	{ "pv88080",    (kernel_ulong_t)&pv88080_aa_regs },
+	{ "pv88080-aa", (kernel_ulong_t)&pv88080_aa_regs },
+	{ "pv88080-ba", (kernel_ulong_t)&pv88080_ba_regs },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, pv88080_i2c_id);
-- 
2.25.1

