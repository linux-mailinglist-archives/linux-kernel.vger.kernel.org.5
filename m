Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723877AC431
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjIWRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjIWRts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:49:48 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 941E6136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:49:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,171,1694703600"; 
   d="scan'208";a="180730429"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Sep 2023 02:49:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 99B6340061B8;
        Sun, 24 Sep 2023 02:49:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/4] mfd: max77541: Simplify obtaining I2C match data
Date:   Sat, 23 Sep 2023 18:49:27 +0100
Message-Id: <20230923174928.56824-4-biju.das.jz@bp.renesas.com>
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

Simplify probe() by replacing device_get_match_data() and ID lookup for
retrieving match data by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v3->v4:
 * Updated commit header.
v2->v3:
 * Restored OF table.
v1->v2:
 * Restored error code -EINVAL.
---
 drivers/mfd/max77541.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
index 10c2e274b4af..d77c31c86e43 100644
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
 
-- 
2.25.1

