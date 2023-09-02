Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2617906CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351919AbjIBJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIBJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 05:09:48 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2A5B1709;
        Sat,  2 Sep 2023 02:09:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,222,1688396400"; 
   d="scan'208";a="178490887"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2023 18:09:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 401B34005B30;
        Sat,  2 Sep 2023 18:09:41 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] pinctrl: mcp23s08: Extend match support for OF tables
Date:   Sat,  2 Sep 2023 10:09:36 +0100
Message-Id: <20230902090937.32195-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230902090937.32195-1-biju.das.jz@bp.renesas.com>
References: <20230902090937.32195-1-biju.das.jz@bp.renesas.com>
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

The driver has OF match table, still it uses ID lookup table for
retrieving match data. Currently the driver is working on the
assumption that a I2C device registered via OF will always match a
legacy I2C device ID. The correct approach is to have an OF device ID
table using of_device_match_data() if the devices are registered via OF.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/pinctrl-mcp23s08_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
index 3dd1bd8e73eb..393d9b099cc5 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
@@ -10,9 +10,8 @@
 
 static int mcp230xx_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device *dev = &client->dev;
-	unsigned int type = id->driver_data;
+	unsigned int type;
 	struct mcp23s08 *mcp;
 	int ret;
 
@@ -20,6 +19,7 @@ static int mcp230xx_probe(struct i2c_client *client)
 	if (!mcp)
 		return -ENOMEM;
 
+	type = (uintptr_t)i2c_get_match_data(client);
 	switch (type) {
 	case MCP_TYPE_008:
 		mcp->regmap = devm_regmap_init_i2c(client, &mcp23x08_regmap);
-- 
2.25.1

