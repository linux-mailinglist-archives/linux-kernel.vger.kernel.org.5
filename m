Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9132178B516
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjH1QHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjH1QHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:07:04 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 809AD11A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:07:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,207,1688396400"; 
   d="scan'208";a="177938453"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2023 01:07:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B42D400A899;
        Tue, 29 Aug 2023 01:07:00 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] mfd: max8998: Simplify probe() and drop max8998_i2c_get_driver_data()
Date:   Mon, 28 Aug 2023 17:06:57 +0100
Message-Id: <20230828160657.94785-1-biju.das.jz@bp.renesas.com>
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
max8998_i2c_get_driver_data() for retrieving match data from
OF/ID tables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

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

