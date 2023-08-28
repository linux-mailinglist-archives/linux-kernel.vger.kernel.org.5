Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FF378B50A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjH1QDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjH1QCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:02:34 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAA71186
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:02:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,207,1688396400"; 
   d="scan'208";a="177938137"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2023 01:02:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6BBB3400A899;
        Tue, 29 Aug 2023 01:02:27 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mfd: max8997: Simplify probe() and drop max8997_i2c_get_driver_data()
Date:   Mon, 28 Aug 2023 17:02:24 +0100
Message-Id: <20230828160224.92037-1-biju.das.jz@bp.renesas.com>
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

Simplify probe() by using i2c_get_match_data() instead of
max8997_i2c_get_driver_data() for retrieving match data from
OF/ID tables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Used uintptr_t for enum casting.
---
 drivers/mfd/max8997.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 110bef71f208..ffe96b40368e 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -142,18 +142,8 @@ static struct max8997_platform_data *max8997_i2c_parse_dt_pdata(
 	return pd;
 }
 
-static inline unsigned long max8997_i2c_get_driver_data(struct i2c_client *i2c,
-						const struct i2c_device_id *id)
-{
-	if (i2c->dev.of_node)
-		return (unsigned long)of_device_get_match_data(&i2c->dev);
-
-	return id->driver_data;
-}
-
 static int max8997_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct max8997_dev *max8997;
 	struct max8997_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	int ret = 0;
@@ -166,7 +156,7 @@ static int max8997_i2c_probe(struct i2c_client *i2c)
 	i2c_set_clientdata(i2c, max8997);
 	max8997->dev = &i2c->dev;
 	max8997->i2c = i2c;
-	max8997->type = max8997_i2c_get_driver_data(i2c, id);
+	max8997->type = (uintptr_t)i2c_get_match_data(i2c);
 	max8997->irq = i2c->irq;
 
 	if (IS_ENABLED(CONFIG_OF) && max8997->dev->of_node) {
-- 
2.25.1

