Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64999790CCD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbjICPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:43:07 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BFC798
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:43:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178557873"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2023 00:43:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A1B02400C0EB;
        Mon,  4 Sep 2023 00:43:00 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] regulator: max20086: Make similar OF and ID table
Date:   Sun,  3 Sep 2023 16:42:57 +0100
Message-Id: <20230903154257.70800-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make similar OF and ID table to extend support for ID match using
i2c_match_data(). Currently it works only for OF match tables as the
driver_data is wrong for ID match.

While at it, drop blank lines before MODULE_DEVICE_TABLE* and remove
trailing comma in the terminator entry for OF/ID table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Removed trailing comma in the terminator entry for OF/ID table.
---
 drivers/regulator/max20086-regulator.c | 65 ++++++++++++--------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index 32f47b896fd1..59eb23d467ec 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -223,7 +223,7 @@ static int max20086_i2c_probe(struct i2c_client *i2c)
 		return -ENOMEM;
 
 	chip->dev = &i2c->dev;
-	chip->info = device_get_match_data(chip->dev);
+	chip->info = i2c_get_match_data(i2c);
 
 	i2c_set_clientdata(i2c, chip);
 
@@ -275,45 +275,42 @@ static int max20086_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
-static const struct i2c_device_id max20086_i2c_id[] = {
-	{ "max20086" },
-	{ "max20087" },
-	{ "max20088" },
-	{ "max20089" },
-	{ /* Sentinel */ },
+static const struct max20086_chip_info max20086_chip_info = {
+	.id = MAX20086_DEVICE_ID_MAX20086,
+	.num_outputs = 4,
+};
+
+static const struct max20086_chip_info max20087_chip_info = {
+	.id = MAX20086_DEVICE_ID_MAX20087,
+	.num_outputs = 4,
+};
+
+static const struct max20086_chip_info max20088_chip_info = {
+	.id = MAX20086_DEVICE_ID_MAX20088,
+	.num_outputs = 2,
+};
+
+static const struct max20086_chip_info max20089_chip_info = {
+	.id = MAX20086_DEVICE_ID_MAX20089,
+	.num_outputs = 2,
 };
 
+static const struct i2c_device_id max20086_i2c_id[] = {
+	{ "max20086", (kernel_ulong_t)&max20086_chip_info },
+	{ "max20087", (kernel_ulong_t)&max20087_chip_info },
+	{ "max20088", (kernel_ulong_t)&max20088_chip_info },
+	{ "max20089", (kernel_ulong_t)&max20089_chip_info },
+	{ /* Sentinel */ }
+};
 MODULE_DEVICE_TABLE(i2c, max20086_i2c_id);
 
 static const struct of_device_id max20086_dt_ids[] __maybe_unused = {
-	{
-		.compatible = "maxim,max20086",
-		.data = &(const struct max20086_chip_info) {
-			.id = MAX20086_DEVICE_ID_MAX20086,
-			.num_outputs = 4,
-		}
-	}, {
-		.compatible = "maxim,max20087",
-		.data = &(const struct max20086_chip_info) {
-			.id = MAX20086_DEVICE_ID_MAX20087,
-			.num_outputs = 4,
-		}
-	}, {
-		.compatible = "maxim,max20088",
-		.data = &(const struct max20086_chip_info) {
-			.id = MAX20086_DEVICE_ID_MAX20088,
-			.num_outputs = 2,
-		}
-	}, {
-		.compatible = "maxim,max20089",
-		.data = &(const struct max20086_chip_info) {
-			.id = MAX20086_DEVICE_ID_MAX20089,
-			.num_outputs = 2,
-		}
-	},
-	{ /* Sentinel */ },
+	{ .compatible = "maxim,max20086", .data = &max20086_chip_info },
+	{ .compatible = "maxim,max20087", .data = &max20087_chip_info },
+	{ .compatible = "maxim,max20088", .data = &max20088_chip_info },
+	{ .compatible = "maxim,max20089", .data = &max20089_chip_info },
+	{ /* Sentinel */ }
 };
-
 MODULE_DEVICE_TABLE(of, max20086_dt_ids);
 
 static struct i2c_driver max20086_regulator_driver = {
-- 
2.25.1

