Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C53790CD1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbjICPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:51:34 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F656E3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:51:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="174850742"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Sep 2023 00:51:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6A95B400EA6A;
        Mon,  4 Sep 2023 00:51:28 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] regulator: mp886x: Make similar OF and ID table
Date:   Sun,  3 Sep 2023 16:51:25 +0100
Message-Id: <20230903155125.73638-1-biju.das.jz@bp.renesas.com>
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

While at it, remove trailing comma in the terminator entry for ID
table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Removed trailing comma in the terminator entry for ID table.
---
 drivers/regulator/mp886x.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 9911be2e6bac..a62ae5444ad8 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -315,7 +315,7 @@ static int mp886x_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(di->en_gpio))
 		return PTR_ERR(di->en_gpio);
 
-	di->ci = of_device_get_match_data(dev);
+	di->ci = i2c_get_match_data(client);
 	di->dev = dev;
 
 	regmap = devm_regmap_init_i2c(client, &mp886x_regmap_config);
@@ -341,21 +341,15 @@ static int mp886x_i2c_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mp886x_dt_ids[] = {
-	{
-		.compatible = "mps,mp8867",
-		.data = &mp8867_ci
-	},
-	{
-		.compatible = "mps,mp8869",
-		.data = &mp8869_ci
-	},
+	{ .compatible = "mps,mp8867", .data = &mp8867_ci },
+	{ .compatible = "mps,mp8869", .data = &mp8869_ci },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mp886x_dt_ids);
 
 static const struct i2c_device_id mp886x_id[] = {
-	{ "mp886x", },
-	{ },
+	{ "mp886x", (kernel_ulong_t)&mp8869_ci },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mp886x_id);
 
-- 
2.25.1

