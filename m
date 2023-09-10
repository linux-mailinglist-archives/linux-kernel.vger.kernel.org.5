Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFA799CD9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346338AbjIJGy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 02:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbjIJGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 02:54:59 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FA441B8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 23:54:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,241,1688396400"; 
   d="scan'208";a="179288419"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Sep 2023 15:54:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 45E124005B40;
        Sun, 10 Sep 2023 15:54:49 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3] regulator: max20086: Drop ID table
Date:   Sun, 10 Sep 2023 07:54:44 +0100
Message-Id: <20230910065444.25906-1-biju.das.jz@bp.renesas.com>
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

The driver has an ID table, but it uses the wrong API for retrieving match
data and that will lead to a crash, if it is instantiated by user space or
using ID. From this, there is no user for the ID table and let's drop it
from the driver as it saves some memory.

While at it, drop blank lines before MODULE_DEVICE_TABLE* and remove
trailing comma in the terminator entry for OF table making code robust
against (theoretical) misrebases or other similar things where the new
entry goes _after_ the termination without the compiler noticing.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v2->v3:
 * Dropped ID table
 * Updated cpmmit header and description.
 * Added Suggested-by tag from Laurent.
v1->v2:
 * Removed trailing comma in the terminator entry for OF/ID table.
---
 drivers/regulator/max20086-regulator.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index 32f47b896fd1..0eb0a4fb077f 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -275,16 +275,6 @@ static int max20086_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
-static const struct i2c_device_id max20086_i2c_id[] = {
-	{ "max20086" },
-	{ "max20087" },
-	{ "max20088" },
-	{ "max20089" },
-	{ /* Sentinel */ },
-};
-
-MODULE_DEVICE_TABLE(i2c, max20086_i2c_id);
-
 static const struct of_device_id max20086_dt_ids[] __maybe_unused = {
 	{
 		.compatible = "maxim,max20086",
@@ -311,9 +301,8 @@ static const struct of_device_id max20086_dt_ids[] __maybe_unused = {
 			.num_outputs = 2,
 		}
 	},
-	{ /* Sentinel */ },
+	{ /* Sentinel */ }
 };
-
 MODULE_DEVICE_TABLE(of, max20086_dt_ids);
 
 static struct i2c_driver max20086_regulator_driver = {
@@ -323,7 +312,6 @@ static struct i2c_driver max20086_regulator_driver = {
 		.of_match_table = of_match_ptr(max20086_dt_ids),
 	},
 	.probe = max20086_i2c_probe,
-	.id_table = max20086_i2c_id,
 };
 
 module_i2c_driver(max20086_regulator_driver);
-- 
2.25.1

