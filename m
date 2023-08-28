Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA8978B4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjH1Pil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjH1PiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:38:16 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 391AB102
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:38:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,207,1688396400"; 
   d="scan'208";a="174228938"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2023 00:38:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3BC91400A677;
        Tue, 29 Aug 2023 00:38:10 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mfd: max77541: Simplify probe()
Date:   Mon, 28 Aug 2023 16:38:05 +0100
Message-Id: <20230828153805.78421-1-biju.das.jz@bp.renesas.com>
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

Simplify probe() by replacing device_get_match_data() and ID lookup for
retrieving match data by i2c_get_match_data().

While at it, drop leading commas from OF table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Restored error code -EINVAL.
---
 drivers/mfd/max77541.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
index 10c2e274b4af..2d50444a7b96 100644
--- a/drivers/mfd/max77541.c
+++ b/drivers/mfd/max77541.c
@@ -162,7 +162,6 @@ static int max77541_pmic_setup(struct device *dev)
 
 static int max77541_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device *dev = &client->dev;
 	struct max77541 *max77541;
 
@@ -173,10 +172,7 @@ static int max77541_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, max77541);
 	max77541->i2c = client;
 
-	max77541->id = (uintptr_t)device_get_match_data(dev);
-	if (!max77541->id)
-		max77541->id  = (enum max7754x_ids)id->driver_data;
-
+	max77541->id = (uintptr_t)i2c_get_match_data(client);
 	if (!max77541->id)
 		return -EINVAL;
 
@@ -190,14 +186,8 @@ static int max77541_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id max77541_of_id[] = {
-	{
-		.compatible = "adi,max77540",
-		.data = (void *)MAX77540,
-	},
-	{
-		.compatible = "adi,max77541",
-		.data = (void *)MAX77541,
-	},
+	{ .compatible = "adi,max77540", .data = (void *)MAX77540 },
+	{ .compatible = "adi,max77541", .data = (void *)MAX77541 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max77541_of_id);
-- 
2.25.1

