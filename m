Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E77997E4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjIIMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjIIMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:19:19 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6439ECD6;
        Sat,  9 Sep 2023 05:19:15 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="179248595"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Sep 2023 21:19:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3B22241EBFFC;
        Sat,  9 Sep 2023 21:19:12 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] pinctrl: mcp23s08_i2c: Simplify probe()
Date:   Sat,  9 Sep 2023 13:19:01 +0100
Message-Id: <20230909121903.34062-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909121903.34062-1-biju.das.jz@bp.renesas.com>
References: <20230909121903.34062-1-biju.das.jz@bp.renesas.com>
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

Add struct mcp23s08_i2c_info and simplify probe() by replacing
match data 'type' with 'struct mcp23s08_i2c_info'.

While at it, replace 'dev_err()'->'dev_err_probe()' and drop printing
'type' in error path for i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description
 * Dropped printing 'type' in error path for i2c_get_match_data().
---
 drivers/pinctrl/pinctrl-mcp23s08_i2c.c | 101 ++++++++++++-------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
index 41ea2650a7e4..34b2cfb45860 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
@@ -8,52 +8,40 @@
 
 #include "pinctrl-mcp23s08.h"
 
+struct mcp23s08_i2c_info {
+	const struct regmap_config *regmap;
+	const char *label;
+	unsigned int type;
+	u16 ngpio;
+	bool reg_shift;
+};
+
 static int mcp230xx_probe(struct i2c_client *client)
 {
+	const struct mcp23s08_i2c_info *info;
 	struct device *dev = &client->dev;
 	struct mcp23s08 *mcp;
-	unsigned int type;
 	int ret;
 
 	mcp = devm_kzalloc(dev, sizeof(*mcp), GFP_KERNEL);
 	if (!mcp)
 		return -ENOMEM;
 
-	type = (uintptr_t)i2c_get_match_data(client);
-	switch (type) {
-	case MCP_TYPE_008:
-		mcp->regmap = devm_regmap_init_i2c(client, &mcp23x08_regmap);
-		mcp->reg_shift = 0;
-		mcp->chip.ngpio = 8;
-		mcp->chip.label = "mcp23008";
-		break;
-
-	case MCP_TYPE_017:
-		mcp->regmap = devm_regmap_init_i2c(client, &mcp23x17_regmap);
-		mcp->reg_shift = 1;
-		mcp->chip.ngpio = 16;
-		mcp->chip.label = "mcp23017";
-		break;
-
-	case MCP_TYPE_018:
-		mcp->regmap = devm_regmap_init_i2c(client, &mcp23x17_regmap);
-		mcp->reg_shift = 1;
-		mcp->chip.ngpio = 16;
-		mcp->chip.label = "mcp23018";
-		break;
-
-	default:
-		dev_err(dev, "invalid device type (%d)\n", type);
-		return -EINVAL;
-	}
+	info = i2c_get_match_data(client);
+	if (!info)
+		return dev_err_probe(dev, -EINVAL, "invalid device type\n");
 
+	mcp->reg_shift = info->reg_shift;
+	mcp->chip.ngpio = info->ngpio;
+	mcp->chip.label = info->label;
+	mcp->regmap = devm_regmap_init_i2c(client, info->regmap);
 	if (IS_ERR(mcp->regmap))
 		return PTR_ERR(mcp->regmap);
 
 	mcp->irq = client->irq;
 	mcp->pinctrl_desc.name = "mcp23xxx-pinctrl";
 
-	ret = mcp23s08_probe_one(mcp, dev, client->addr, type, -1);
+	ret = mcp23s08_probe_one(mcp, dev, client->addr, info->type, -1);
 	if (ret)
 		return ret;
 
@@ -62,36 +50,45 @@ static int mcp230xx_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct mcp23s08_i2c_info mcp23s08_i2c_0008 = {
+	.regmap = &mcp23x08_regmap,
+	.label = "mcp23008",
+	.type = MCP_TYPE_008,
+	.ngpio = 8,
+	.reg_shift = 0,
+};
+
+static const struct mcp23s08_i2c_info mcp23s08_i2c_0017 = {
+	.regmap = &mcp23x17_regmap,
+	.label = "mcp23017",
+	.type = MCP_TYPE_017,
+	.ngpio = 16,
+	.reg_shift = 1,
+};
+
+static const struct mcp23s08_i2c_info mcp23s08_i2c_0018 = {
+	.regmap = &mcp23x17_regmap,
+	.label = "mcp23018",
+	.type = MCP_TYPE_018,
+	.ngpio = 16,
+	.reg_shift = 1,
+};
+
 static const struct i2c_device_id mcp230xx_id[] = {
-	{ "mcp23008", MCP_TYPE_008 },
-	{ "mcp23017", MCP_TYPE_017 },
-	{ "mcp23018", MCP_TYPE_018 },
+	{ "mcp23008", (kernel_ulong_t)&mcp23s08_i2c_0008 },
+	{ "mcp23017", (kernel_ulong_t)&mcp23s08_i2c_0017 },
+	{ "mcp23018", (kernel_ulong_t)&mcp23s08_i2c_0018 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp230xx_id);
 
 static const struct of_device_id mcp23s08_i2c_of_match[] = {
-	{
-		.compatible = "microchip,mcp23008",
-		.data = (void *) MCP_TYPE_008,
-	},
-	{
-		.compatible = "microchip,mcp23017",
-		.data = (void *) MCP_TYPE_017,
-	},
-	{
-		.compatible = "microchip,mcp23018",
-		.data = (void *) MCP_TYPE_018,
-	},
+	{ .compatible = "microchip,mcp23008", .data = &mcp23s08_i2c_0008 },
+	{ .compatible = "microchip,mcp23017", .data = &mcp23s08_i2c_0017 },
+	{ .compatible = "microchip,mcp23018", .data = &mcp23s08_i2c_0018 },
 /* NOTE: The use of the mcp prefix is deprecated and will be removed. */
-	{
-		.compatible = "mcp,mcp23008",
-		.data = (void *) MCP_TYPE_008,
-	},
-	{
-		.compatible = "mcp,mcp23017",
-		.data = (void *) MCP_TYPE_017,
-	},
+	{ .compatible = "mcp,mcp23008", .data = &mcp23s08_i2c_0008 },
+	{ .compatible = "mcp,mcp23017", .data = &mcp23s08_i2c_0017 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp23s08_i2c_of_match);
-- 
2.25.1

