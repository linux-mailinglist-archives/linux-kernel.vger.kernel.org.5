Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017D790CF1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbjICQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbjICQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:48:50 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C4F210D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:48:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,224,1688396400"; 
   d="scan'208";a="174853015"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Sep 2023 01:48:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 08C714023AAB;
        Mon,  4 Sep 2023 01:48:37 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] regulator: pv880x0: Drop ifdeffery
Date:   Sun,  3 Sep 2023 17:48:31 +0100
Message-Id: <20230903164832.83077-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230903164832.83077-1-biju.das.jz@bp.renesas.com>
References: <20230903164832.83077-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop of_match_ptr() from pv88080_regulator_driver and get rid of ugly
CONFIG_OF ifdeffery. This slightly increases the size of pv88080_dt_ids
on non-OF system and shouldn't be an issue.

Add mod_devicetable.h include.

While at it, remove trailing comma in the terminator entry for OF/ID
table.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Swapped the patch.
 * Removed trailing comma in the terminator entry for OF/ID table.
 * Restored OF table position.
 * Updated commit description.
v2:
 * New patch.
---
 drivers/regulator/pv88080-regulator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 7ab3e4a9bd28..1b2a8385e2e8 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/init.h>
@@ -196,15 +197,13 @@ static const struct pv88080_compatible_regmap pv88080_ba_regs = {
 	.hvbuck_vsel_mask		  = PV88080_VHVBUCK_MASK,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id pv88080_dt_ids[] = {
 	{ .compatible = "pvs,pv88080",    .data = (void *)TYPE_PV88080_AA },
 	{ .compatible = "pvs,pv88080-aa", .data = (void *)TYPE_PV88080_AA },
 	{ .compatible = "pvs,pv88080-ba", .data = (void *)TYPE_PV88080_BA },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, pv88080_dt_ids);
-#endif
 
 static unsigned int pv88080_buck_get_mode(struct regulator_dev *rdev)
 {
@@ -550,7 +549,7 @@ static const struct i2c_device_id pv88080_i2c_id[] = {
 	{ "pv88080",    TYPE_PV88080_AA },
 	{ "pv88080-aa", TYPE_PV88080_AA },
 	{ "pv88080-ba", TYPE_PV88080_BA },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, pv88080_i2c_id);
 
@@ -558,7 +557,7 @@ static struct i2c_driver pv88080_regulator_driver = {
 	.driver = {
 		.name = "pv88080",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(pv88080_dt_ids),
+		.of_match_table = pv88080_dt_ids,
 	},
 	.probe = pv88080_i2c_probe,
 	.id_table = pv88080_i2c_id,
-- 
2.25.1

