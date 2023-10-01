Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD67B4845
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjJAPBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjJAPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:01:31 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA22ADD;
        Sun,  1 Oct 2023 08:01:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,191,1694703600"; 
   d="scan'208";a="181547677"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Oct 2023 00:01:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.25])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A2054420635B;
        Mon,  2 Oct 2023 00:01:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/3] pinctrl: mcp23s08: Simplify probe()/mcp23s08_spi_regmap_init()
Date:   Sun,  1 Oct 2023 16:01:13 +0100
Message-Id: <20231001150113.7752-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231001150113.7752-1-biju.das.jz@bp.renesas.com>
References: <20231001150113.7752-1-biju.das.jz@bp.renesas.com>
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

Add struct mcp23s08_info and simplify probe()/mcp23s08_spi_regmap_init() by
replacing match data 'type' with 'struct mcp23s08_info'.

While at it, replace 'dev_err()'->'dev_err_probe()' and drop printing
'type' in error path for i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3->v4:
 * Added Rb tag from Andy.
 * Removed duplicate mcp23s08 in the name of variables for
   struct mcp23s08_info.
v2->v3:
 * Added struct mcp23s08_info in pinctrl-mcp23s08.h and both i2c and spi
   drivers using same match data structure.
v1->v2:
 * Updated commit description
 * Dropped printing 'type' in error path for i2c_get_match_data(). 
---
 drivers/pinctrl/pinctrl-mcp23s08.h     |  8 +++
 drivers/pinctrl/pinctrl-mcp23s08_i2c.c | 93 ++++++++++++--------------
 drivers/pinctrl/pinctrl-mcp23s08_spi.c | 88 ++++++++++++------------
 3 files changed, 93 insertions(+), 96 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.h b/drivers/pinctrl/pinctrl-mcp23s08.h
index b15516af7783..105bce9e0f50 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.h
+++ b/drivers/pinctrl/pinctrl-mcp23s08.h
@@ -22,6 +22,14 @@ struct regmap;
 
 struct pinctrl_dev;
 
+struct mcp23s08_info {
+	const struct regmap_config *regmap;
+	const char *label;
+	unsigned int type;
+	u16 ngpio;
+	bool reg_shift;
+};
+
 struct mcp23s08 {
 	u8			addr;
 	bool			irq_active_high;
diff --git a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
index 41ea2650a7e4..04e8e7d079f0 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_i2c.c
@@ -10,50 +10,30 @@
 
 static int mcp230xx_probe(struct i2c_client *client)
 {
+	const struct mcp23s08_info *info;
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
 
@@ -62,36 +42,45 @@ static int mcp230xx_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct mcp23s08_info mcp23008_i2c = {
+	.regmap = &mcp23x08_regmap,
+	.label = "mcp23008",
+	.type = MCP_TYPE_008,
+	.ngpio = 8,
+	.reg_shift = 0,
+};
+
+static const struct mcp23s08_info mcp23017_i2c = {
+	.regmap = &mcp23x17_regmap,
+	.label = "mcp23017",
+	.type = MCP_TYPE_017,
+	.ngpio = 16,
+	.reg_shift = 1,
+};
+
+static const struct mcp23s08_info  mcp23018_i2c = {
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
+	{ "mcp23008", (kernel_ulong_t)&mcp23008_i2c },
+	{ "mcp23017", (kernel_ulong_t)&mcp23017_i2c },
+	{ "mcp23018", (kernel_ulong_t)&mcp23018_i2c },
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
+	{ .compatible = "microchip,mcp23008", .data = &mcp23008_i2c },
+	{ .compatible = "microchip,mcp23017", .data = &mcp23017_i2c },
+	{ .compatible = "microchip,mcp23018", .data = &mcp23018_i2c },
 /* NOTE: The use of the mcp prefix is deprecated and will be removed. */
-	{
-		.compatible = "mcp,mcp23008",
-		.data = (void *) MCP_TYPE_008,
-	},
-	{
-		.compatible = "mcp,mcp23017",
-		.data = (void *) MCP_TYPE_017,
-	},
+	{ .compatible = "mcp,mcp23008", .data = &mcp23008_i2c },
+	{ .compatible = "mcp,mcp23017", .data = &mcp23017_i2c },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp23s08_i2c_of_match);
diff --git a/drivers/pinctrl/pinctrl-mcp23s08_spi.c b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
index caf528284d07..4a872fff5fe8 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
@@ -80,21 +80,18 @@ static const struct regmap_bus mcp23sxx_spi_regmap = {
 };
 
 static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
-				    unsigned int addr, unsigned int type)
+				    unsigned int addr,
+				    const struct mcp23s08_info *info)
 {
-	const struct regmap_config *config;
 	struct regmap_config *copy;
 	const char *name;
 
-	switch (type) {
+	switch (info->type) {
 	case MCP_TYPE_S08:
-		mcp->reg_shift = 0;
-		mcp->chip.ngpio = 8;
 		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s08.%d", addr);
 		if (!mcp->chip.label)
 			return -ENOMEM;
 
-		config = &mcp23x08_regmap;
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
 		if (!name)
 			return -ENOMEM;
@@ -102,13 +99,10 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 		break;
 
 	case MCP_TYPE_S17:
-		mcp->reg_shift = 1;
-		mcp->chip.ngpio = 16;
 		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s17.%d", addr);
 		if (!mcp->chip.label)
 			return -ENOMEM;
 
-		config = &mcp23x17_regmap;
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
 		if (!name)
 			return -ENOMEM;
@@ -116,20 +110,18 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 		break;
 
 	case MCP_TYPE_S18:
-		mcp->reg_shift = 1;
-		mcp->chip.ngpio = 16;
-		mcp->chip.label = "mcp23s18";
-
-		config = &mcp23x17_regmap;
-		name = config->name;
+		mcp->chip.label = info->label;
+		name = info->regmap->name;
 		break;
 
 	default:
-		dev_err(dev, "invalid device type (%d)\n", type);
+		dev_err(dev, "invalid device type (%d)\n", info->type);
 		return -EINVAL;
 	}
 
-	copy = devm_kmemdup(dev, config, sizeof(*config), GFP_KERNEL);
+	mcp->reg_shift = info->reg_shift;
+	mcp->chip.ngpio = info->ngpio;
+	copy = devm_kmemdup(dev, info->regmap, sizeof(*info->regmap), GFP_KERNEL);
 	if (!copy)
 		return -ENOMEM;
 
@@ -144,16 +136,16 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 static int mcp23s08_probe(struct spi_device *spi)
 {
 	struct mcp23s08_driver_data *data;
+	const struct mcp23s08_info *info;
 	struct device *dev = &spi->dev;
 	unsigned long spi_present_mask;
 	unsigned int ngpio = 0;
-	unsigned int type;
 	unsigned int addr;
 	int chips;
 	int ret;
 	u32 v;
 
-	type = (uintptr_t)spi_get_device_match_data(spi);
+	info = spi_get_device_match_data(spi);
 
 	ret = device_property_read_u32(dev, "microchip,spi-present-mask", &v);
 	if (ret) {
@@ -182,7 +174,7 @@ static int mcp23s08_probe(struct spi_device *spi)
 		data->mcp[addr] = &data->chip[--chips];
 		data->mcp[addr]->irq = spi->irq;
 
-		ret = mcp23s08_spi_regmap_init(data->mcp[addr], dev, addr, type);
+		ret = mcp23s08_spi_regmap_init(data->mcp[addr], dev, addr, info);
 		if (ret)
 			return ret;
 
@@ -192,7 +184,8 @@ static int mcp23s08_probe(struct spi_device *spi)
 		if (!data->mcp[addr]->pinctrl_desc.name)
 			return -ENOMEM;
 
-		ret = mcp23s08_probe_one(data->mcp[addr], dev, 0x40 | (addr << 1), type, -1);
+		ret = mcp23s08_probe_one(data->mcp[addr], dev, 0x40 | (addr << 1),
+					 info->type, -1);
 		if (ret < 0)
 			return ret;
 
@@ -203,36 +196,43 @@ static int mcp23s08_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct mcp23s08_info mcp23s08_spi = {
+	.regmap = &mcp23x08_regmap,
+	.type = MCP_TYPE_S08,
+	.ngpio = 8,
+	.reg_shift = 0,
+};
+
+static const struct mcp23s08_info mcp23s17_spi = {
+	.regmap = &mcp23x17_regmap,
+	.type = MCP_TYPE_S17,
+	.ngpio = 16,
+	.reg_shift = 1,
+};
+
+static const struct mcp23s08_info mcp23s18_spi = {
+	.regmap = &mcp23x17_regmap,
+	.label = "mcp23s18",
+	.type = MCP_TYPE_S18,
+	.ngpio = 16,
+	.reg_shift = 1,
+};
+
 static const struct spi_device_id mcp23s08_ids[] = {
-	{ "mcp23s08", MCP_TYPE_S08 },
-	{ "mcp23s17", MCP_TYPE_S17 },
-	{ "mcp23s18", MCP_TYPE_S18 },
+	{ "mcp23s08", (kernel_ulong_t)&mcp23s08_spi },
+	{ "mcp23s17", (kernel_ulong_t)&mcp23s17_spi },
+	{ "mcp23s18", (kernel_ulong_t)&mcp23s18_spi },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp23s08_ids);
 
 static const struct of_device_id mcp23s08_spi_of_match[] = {
-	{
-		.compatible = "microchip,mcp23s08",
-		.data = (void *) MCP_TYPE_S08,
-	},
-	{
-		.compatible = "microchip,mcp23s17",
-		.data = (void *) MCP_TYPE_S17,
-	},
-	{
-		.compatible = "microchip,mcp23s18",
-		.data = (void *) MCP_TYPE_S18,
-	},
+	{ .compatible = "microchip,mcp23s08", .data = &mcp23s08_spi },
+	{ .compatible = "microchip,mcp23s17", .data = &mcp23s17_spi },
+	{ .compatible = "microchip,mcp23s18", .data = &mcp23s18_spi },
 /* NOTE: The use of the mcp prefix is deprecated and will be removed. */
-	{
-		.compatible = "mcp,mcp23s08",
-		.data = (void *) MCP_TYPE_S08,
-	},
-	{
-		.compatible = "mcp,mcp23s17",
-		.data = (void *) MCP_TYPE_S17,
-	},
+	{ .compatible = "mcp,mcp23s08", .data = &mcp23s08_spi },
+	{ .compatible = "mcp,mcp23s17", .data = &mcp23s17_spi },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp23s08_spi_of_match);
-- 
2.25.1

