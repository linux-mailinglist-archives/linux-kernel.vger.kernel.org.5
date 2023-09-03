Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C729790CD7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbjICQDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjICQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:03:14 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A35100
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:03:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="178558807"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2023 01:03:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2A61F4011DF1;
        Mon,  4 Sep 2023 01:03:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] regulator: mp5416: Make similar OF and ID table
Date:   Sun,  3 Sep 2023 17:03:01 +0100
Message-Id: <20230903160301.79111-1-biju.das.jz@bp.renesas.com>
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

While at it, remove trailing comma in the terminator entry for OF/ID
table and drop a space from terminator entry for ID table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Removed trailing comma in the terminator entry for OF/ID table and drop
   a space from terminator entry for ID table.
---
 drivers/regulator/mp5416.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index d068ac93d373..3457e650a994 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -200,7 +200,7 @@ static int mp5416_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	desc = of_device_get_match_data(dev);
+	desc = i2c_get_match_data(client);
 	if (!desc)
 		return -ENODEV;
 
@@ -223,14 +223,14 @@ static int mp5416_i2c_probe(struct i2c_client *client)
 static const struct of_device_id mp5416_of_match[] = {
 	{ .compatible = "mps,mp5416", .data = &mp5416_regulators_desc },
 	{ .compatible = "mps,mp5496", .data = &mp5496_regulators_desc },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, mp5416_of_match);
 
 static const struct i2c_device_id mp5416_id[] = {
-	{ "mp5416", },
-	{ "mp5496", },
-	{ },
+	{ "mp5416", (kernel_ulong_t)&mp5416_regulators_desc },
+	{ "mp5496", (kernel_ulong_t)&mp5496_regulators_desc },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, mp5416_id);
 
-- 
2.25.1

