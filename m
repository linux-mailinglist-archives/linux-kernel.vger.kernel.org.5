Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1577678F2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbjHaScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbjHaScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:32:06 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F308E5F;
        Thu, 31 Aug 2023 11:32:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174628372"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 03:32:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E66FB40029A1;
        Fri,  1 Sep 2023 03:32:00 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/4] mfd: palmas: Constify .data in OF table and {palmas,tps65917}_irq_chip
Date:   Thu, 31 Aug 2023 19:31:51 +0100
Message-Id: <20230831183153.63750-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
References: <20230831183153.63750-1-biju.das.jz@bp.renesas.com>
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

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Restored the OF table position and moved near to the user in patch#3.
v1->v2:
 * Moved the OF table just above its user.
 * Removed trailing comma from the terminator entry for the OF table.
---
 drivers/mfd/palmas.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 769538b50903..3c0a3d644834 100644
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
@@ -463,26 +463,21 @@ static void palmas_power_off(void)
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
 
@@ -507,7 +502,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 {
 	struct palmas *palmas;
 	struct palmas_platform_data *pdata;
-	struct palmas_driver_data *driver_data;
+	const struct palmas_driver_data *driver_data;
 	struct device_node *node = i2c->dev.of_node;
 	int ret = 0, i;
 	unsigned int reg, addr;
@@ -535,8 +530,8 @@ static int palmas_i2c_probe(struct i2c_client *i2c)
 	palmas->dev = &i2c->dev;
 	palmas->irq = i2c->irq;
 
-	driver_data = (struct palmas_driver_data *) device_get_match_data(&i2c->dev);
-	palmas->features = *driver_data->features;
+	driver_data = device_get_match_data(&i2c->dev);
+	palmas->features = driver_data->features;
 
 	for (i = 0; i < PALMAS_NUM_CLIENTS; i++) {
 		if (i == 0)
-- 
2.25.1

