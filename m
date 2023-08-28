Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789EB78B477
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjH1PcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjH1Pby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:31:54 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8826E125;
        Mon, 28 Aug 2023 08:31:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,207,1688396400"; 
   d="scan'208";a="174228506"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 00:31:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4435C40065DD;
        Tue, 29 Aug 2023 00:31:49 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] mfd: palmas: Constify .data in OF table and {palmas,tps65917}_irq_chip
Date:   Mon, 28 Aug 2023 16:31:43 +0100
Message-Id: <20230828153144.75479-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828153144.75479-1-biju.das.jz@bp.renesas.com>
References: <20230828153144.75479-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify .data in OF table and {palmas,tps65917}_irq_chip and replace
the variable *features->features in struct palmas_driver_data and
drop the {palmas,tps659038}_features variables and use their values
directly in the named initialization.

While at it, drop the inner leading commas for OF match table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Moved the OF table just above its user.
 * Removed trailing comma from the terminator entry for the OF table.
---
 drivers/mfd/palmas.c | 52 ++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 6e562bab62e4..3ac9dec2b117 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -296,7 +296,7 @@ static const struct regmap_irq palmas_irqs[] = {
 	},
 };
 
-static struct regmap_irq_chip palmas_irq_chip = {
+static const struct regmap_irq_chip palmas_irq_chip = {
 	.name = "palmas",
 	.irqs = palmas_irqs,
 	.num_irqs = ARRAY_SIZE(palmas_irqs),
@@ -309,7 +309,7 @@ static struct regmap_irq_chip palmas_irq_chip = {
 			PALMAS_INT1_MASK),
 };
 
-static struct regmap_irq_chip tps65917_irq_chip = {
+static const struct regmap_irq_chip tps65917_irq_chip = {
 	.name = "tps65917",
 	.irqs = tps65917_irqs,
 	.num_irqs = ARRAY_SIZE(tps65917_irqs),
@@ -463,51 +463,29 @@ static void palmas_power_off(void)
 				__func__, ret);
 }
 
-static unsigned int palmas_features = PALMAS_PMIC_FEATURE_SMPS10_BOOST;
-static unsigned int tps659038_features;
-
 struct palmas_driver_data {
-	unsigned int *features;
-	struct regmap_irq_chip *irq_chip;
+	unsigned int features;
+	const struct regmap_irq_chip *irq_chip;
 };
 
-static struct palmas_driver_data palmas_data = {
-	.features = &palmas_features,
+static const struct palmas_driver_data palmas_data = {
+	.features = PALMAS_PMIC_FEATURE_SMPS10_BOOST,
 	.irq_chip = &palmas_irq_chip,
 };
 
-static struct palmas_driver_data tps659038_data = {
-	.features = &tps659038_features,
+static const struct palmas_driver_data tps659038_data = {
 	.irq_chip = &palmas_irq_chip,
 };
 
-static struct palmas_driver_data tps65917_data = {
-	.features = &tps659038_features,
+static const struct palmas_driver_data tps65917_data = {
 	.irq_chip = &tps65917_irq_chip,
 };
 
-static const struct of_device_id of_palmas_match_tbl[] = {
-	{
-		.compatible = "ti,palmas",
-		.data = &palmas_data,
-	},
-	{
-		.compatible = "ti,tps659038",
-		.data = &tps659038_data,
-	},
-	{
-		.compatible = "ti,tps65917",
-		.data = &tps65917_data,
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
-
 static int palmas_i2c_probe(struct i2c_client *i2c)
 {
 	struct palmas *palmas;
 	struct palmas_platform_data *pdata;
-	struct palmas_driver_data *driver_data;
+	const struct palmas_driver_data *driver_data;
 	struct device_node *node = i2c->dev.of_node;
 	int ret = 0, i;
 	unsigned int reg, addr;
@@ -535,8 +513,8 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 	palmas->dev = &i2c->dev;
 	palmas->irq = i2c->irq;
 
-	driver_data = (struct palmas_driver_data *) device_get_match_data(&i2c->dev);
-	palmas->features = *driver_data->features;
+	driver_data = device_get_match_data(&i2c->dev);
+	palmas->features = driver_data->features;
 
 	for (i = 0; i < PALMAS_NUM_CLIENTS; i++) {
 		if (i == 0)
@@ -712,6 +690,14 @@ static void palmas_i2c_remove(struct i2c_client *i2c)
 	}
 }
 
+static const struct of_device_id of_palmas_match_tbl[] = {
+	{ .compatible = "ti,palmas", .data = &palmas_data },
+	{ .compatible = "ti,tps659038", .data = &tps659038_data },
+	{ .compatible = "ti,tps65917", .data = &tps65917_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
+
 static const struct i2c_device_id palmas_i2c_id[] = {
 	{ "palmas", },
 	{ "twl6035", },
-- 
2.25.1

