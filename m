Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029117AC432
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjIWRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjIWRtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:49:51 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7D4E136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:49:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,171,1694703600"; 
   d="scan'208";a="176997674"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Sep 2023 02:49:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EC22740061B8;
        Sun, 24 Sep 2023 02:49:42 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/4] mfd: max8998: Simplify obtaining I2C match data and drop max8998_i2c_get_driver_data()
Date:   Sat, 23 Sep 2023 18:49:28 +0100
Message-Id: <20230923174928.56824-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230923174928.56824-1-biju.das.jz@bp.renesas.com>
References: <20230923174928.56824-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify probe() by using i2c_get_match_data() instead of
max8998_i2c_get_driver_data() for retrieving match data from
OF/ID tables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Note:
 This patch is only compile tested.

v3->v4:
 * Updated commit header.
V2->v3:
 * Added Rb tag from Andy.
v1->v2:
 * Used uintptr_t for enum casting.
---
 drivers/mfd/max8998.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 4cc426a6c767..6ba27171da28 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -152,18 +152,8 @@ static struct max8998_platform_data *max8998_i2c_parse_dt_pdata(
 	return pd;
 }
 
-static inline unsigned long max8998_i2c_get_driver_data(struct i2c_client *i2c,
-						const struct i2c_device_id *id)
-{
-	if (i2c->dev.of_node)
-		return (unsigned long)of_device_get_match_data(&i2c->dev);
-
-	return id->driver_data;
-}
-
 static int max8998_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct max8998_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct max8998_dev *max8998;
 	int ret = 0;
@@ -183,7 +173,7 @@ static int max8998_i2c_probe(struct i2c_client *i2c)
 	max8998->dev = &i2c->dev;
 	max8998->i2c = i2c;
 	max8998->irq = i2c->irq;
-	max8998->type = max8998_i2c_get_driver_data(i2c, id);
+	max8998->type = (uintptr_t)i2c_get_match_data(i2c);
 	max8998->pdata = pdata;
 	if (pdata) {
 		max8998->ono = pdata->ono;
-- 
2.25.1

