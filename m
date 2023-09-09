Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D207997E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345831AbjIIMT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbjIIMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:19:25 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7793FCD6;
        Sat,  9 Sep 2023 05:19:20 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="179248600"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Sep 2023 21:19:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4EC0041EBFFC;
        Sat,  9 Sep 2023 21:19:18 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/4] pinctrl: mcp23s08_spi: Simplify mcp23s08_spi_regmap_init()
Date:   Sat,  9 Sep 2023 13:19:03 +0100
Message-Id: <20230909121903.34062-5-biju.das.jz@bp.renesas.com>
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

Add struct mcp23s08_spi_info and simplify mcp23s08_spi_regmap_init() by
replacing match data 'type' with 'struct mcp23s08_spi_info'.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 drivers/pinctrl/pinctrl-mcp23s08_spi.c | 92 ++++++++++++++------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08_spi.c b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
index caf528284d07..b7f5b4109007 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
@@ -11,6 +11,13 @@
 
 #define MCP_MAX_DEV_PER_CS	8
 
+struct mcp23s08_spi_info {
+	const struct regmap_config *regmap;
+	unsigned int type;
+	u16 ngpio;
+	bool reg_shift;
+};
+
 /*
  * A given spi_device can represent up to eight mcp23sxx chips
  * sharing the same chipselect but using different addresses
@@ -80,21 +87,18 @@ static const struct regmap_bus mcp23sxx_spi_regmap = {
 };
 
 static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
-				    unsigned int addr, unsigned int type)
+				    unsigned int addr,
+				    const struct mcp23s08_spi_info *info)
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
@@ -102,13 +106,10 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
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
@@ -116,20 +117,18 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 		break;
 
 	case MCP_TYPE_S18:
-		mcp->reg_shift = 1;
-		mcp->chip.ngpio = 16;
 		mcp->chip.label = "mcp23s18";
-
-		config = &mcp23x17_regmap;
-		name = config->name;
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
 
@@ -143,17 +142,17 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 
 static int mcp23s08_probe(struct spi_device *spi)
 {
+	const struct mcp23s08_spi_info *info;
 	struct mcp23s08_driver_data *data;
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
@@ -182,7 +181,7 @@ static int mcp23s08_probe(struct spi_device *spi)
 		data->mcp[addr] = &data->chip[--chips];
 		data->mcp[addr]->irq = spi->irq;
 
-		ret = mcp23s08_spi_regmap_init(data->mcp[addr], dev, addr, type);
+		ret = mcp23s08_spi_regmap_init(data->mcp[addr], dev, addr, info);
 		if (ret)
 			return ret;
 
@@ -192,7 +191,8 @@ static int mcp23s08_probe(struct spi_device *spi)
 		if (!data->mcp[addr]->pinctrl_desc.name)
 			return -ENOMEM;
 
-		ret = mcp23s08_probe_one(data->mcp[addr], dev, 0x40 | (addr << 1), type, -1);
+		ret = mcp23s08_probe_one(data->mcp[addr], dev, 0x40 | (addr << 1),
+					 info->type, -1);
 		if (ret < 0)
 			return ret;
 
@@ -203,36 +203,42 @@ static int mcp23s08_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct mcp23s08_spi_info mcp23s08_spi_s08 = {
+	.regmap = &mcp23x08_regmap,
+	.type = MCP_TYPE_S08,
+	.ngpio = 8,
+	.reg_shift = 0,
+};
+
+static const struct mcp23s08_spi_info mcp23s08_spi_s17 = {
+	.regmap = &mcp23x17_regmap,
+	.type = MCP_TYPE_S17,
+	.ngpio = 16,
+	.reg_shift = 1,
+};
+
+static const struct mcp23s08_spi_info mcp23s08_spi_s18 = {
+	.regmap = &mcp23x17_regmap,
+	.type = MCP_TYPE_S18,
+	.ngpio = 16,
+	.reg_shift = 1,
+};
+
 static const struct spi_device_id mcp23s08_ids[] = {
-	{ "mcp23s08", MCP_TYPE_S08 },
-	{ "mcp23s17", MCP_TYPE_S17 },
-	{ "mcp23s18", MCP_TYPE_S18 },
+	{ "mcp23s08", (kernel_ulong_t)&mcp23s08_spi_s08 },
+	{ "mcp23s17", (kernel_ulong_t)&mcp23s08_spi_s17 },
+	{ "mcp23s18", (kernel_ulong_t)&mcp23s08_spi_s18 },
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
+	{ .compatible = "microchip,mcp23s08", .data = &mcp23s08_spi_s08 },
+	{ .compatible = "microchip,mcp23s17", .data = &mcp23s08_spi_s17 },
+	{ .compatible = "microchip,mcp23s18", .data = &mcp23s08_spi_s18 },
 /* NOTE: The use of the mcp prefix is deprecated and will be removed. */
-	{
-		.compatible = "mcp,mcp23s08",
-		.data = (void *) MCP_TYPE_S08,
-	},
-	{
-		.compatible = "mcp,mcp23s17",
-		.data = (void *) MCP_TYPE_S17,
-	},
+	{ .compatible = "mcp,mcp23s08", .data = &mcp23s08_spi_s08 },
+	{ .compatible = "mcp,mcp23s17", .data = &mcp23s08_spi_s17 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp23s08_spi_of_match);
-- 
2.25.1

