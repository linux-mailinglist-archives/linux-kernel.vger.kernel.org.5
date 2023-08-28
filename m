Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5478B5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjH1QzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjH1Qyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:54:55 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E8A999
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:54:52 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="174232944"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 01:54:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF1B44022338;
        Tue, 29 Aug 2023 01:54:49 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] regulator: sy8824x: Make similar OF and ID table
Date:   Mon, 28 Aug 2023 17:54:47 +0100
Message-Id: <20230828165447.106058-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make similar OF and ID table to extend support for ID match using
i2c_match_data(). Currently it works only for OF match tables as the
driver_data is wrong for ID match.

While at it, drop trailing comma in the terminator entry from ID
table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Dropped trailing comma in the terminator entries for ID table.
---
 drivers/regulator/sy8824x.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index d49c0cba09fb..c05b67e26ac8 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -142,7 +142,7 @@ static int sy8824_i2c_probe(struct i2c_client *client)
 	}
 
 	di->dev = dev;
-	di->cfg = of_device_get_match_data(dev);
+	di->cfg = i2c_get_match_data(client);
 
 	regmap = devm_regmap_init_i2c(client, di->cfg->config);
 	if (IS_ERR(regmap)) {
@@ -204,29 +204,17 @@ static const struct sy8824_config sy20278_cfg = {
 };
 
 static const struct of_device_id sy8824_dt_ids[] = {
-	{
-		.compatible = "silergy,sy8824c",
-		.data = &sy8824c_cfg
-	},
-	{
-		.compatible = "silergy,sy8824e",
-		.data = &sy8824e_cfg
-	},
-	{
-		.compatible = "silergy,sy20276",
-		.data = &sy20276_cfg
-	},
-	{
-		.compatible = "silergy,sy20278",
-		.data = &sy20278_cfg
-	},
+	{ .compatible = "silergy,sy8824c", .data = &sy8824c_cfg },
+	{ .compatible = "silergy,sy8824e", .data = &sy8824e_cfg },
+	{ .compatible = "silergy,sy20276", .data = &sy20276_cfg },
+	{ .compatible = "silergy,sy20278", .data = &sy20278_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sy8824_dt_ids);
 
 static const struct i2c_device_id sy8824_id[] = {
-	{ "sy8824", },
-	{ },
+	{ "sy8824", (kernel_ulong_t)&sy8824c_cfg },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sy8824_id);
 
-- 
2.25.1

