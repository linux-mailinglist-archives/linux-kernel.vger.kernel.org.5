Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D95078B592
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjH1QsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjH1Qry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:47:54 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D31313D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:47:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="177940765"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2023 01:47:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1F16A4000F90;
        Tue, 29 Aug 2023 01:47:48 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] regulator: fan53555: Simplify probe()
Date:   Mon, 28 Aug 2023 17:47:46 +0100
Message-Id: <20230828164746.102992-1-biju.das.jz@bp.renesas.com>
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

Simplify probe() by replacing of_device_get_match_data() and ID lookup for
retrieving match data by i2c_get_match_data().

While at it, use dev_fwnode() API instead of 'client->dev.of_node'.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Used uintptr_t for enum casting.
 * Replaced 'client->dev.of_node'->dev_fwnode().
---
 drivers/regulator/fan53555.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 48f312167e53..17c9bf204385 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -659,7 +659,6 @@ MODULE_DEVICE_TABLE(of, fan53555_dt_ids);
 
 static int fan53555_regulator_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device_node *np = client->dev.of_node;
 	struct fan53555_device_info *di;
 	struct fan53555_platform_data *pdata;
@@ -682,10 +681,8 @@ static int fan53555_regulator_probe(struct i2c_client *client)
 				     "Platform data not found!\n");
 
 	di->regulator = pdata->regulator;
-	if (client->dev.of_node) {
-		di->vendor =
-			(unsigned long)of_device_get_match_data(&client->dev);
-	} else {
+	di->vendor = (uintptr_t)i2c_get_match_data(client);
+	if (!dev_fwnode(&client->dev)) {
 		/* if no ramp constraint set, get the pdata ramp_delay */
 		if (!di->regulator->constraints.ramp_delay) {
 			if (pdata->slew_rate >= ARRAY_SIZE(slew_rates))
@@ -695,8 +692,6 @@ static int fan53555_regulator_probe(struct i2c_client *client)
 			di->regulator->constraints.ramp_delay
 					= slew_rates[pdata->slew_rate];
 		}
-
-		di->vendor = id->driver_data;
 	}
 
 	regmap = devm_regmap_init_i2c(client, &fan53555_regmap_config);
-- 
2.25.1

