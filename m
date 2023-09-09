Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E717999EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjIIQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbjIIPFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:05:30 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDF831A8;
        Sat,  9 Sep 2023 08:05:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="179253444"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Sep 2023 00:05:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 48FBD40062A3;
        Sun, 10 Sep 2023 00:05:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] clk: cdce925: Extend match support for OF tables
Date:   Sat,  9 Sep 2023 16:05:16 +0100
Message-Id: <20230909150516.10353-1-biju.das.jz@bp.renesas.com>
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

The driver has an OF match table, still, it uses an ID lookup table for
retrieving match data. Currently, the driver is working on the
assumption that an I2C device registered via OF will always match a
legacy I2C device ID. The correct approach is to have an OF device ID
table using i2c_get_match_data() if the devices are registered via OF/ID.

Unify the OF/ID table by using struct clk_cdce925_chip_info
as match data for both these tables and replace the ID lookup table for
the match data by i2c_get_match_data().

Split the array clk_cdce925_chip_info_tbl[] as individual variables, and
make lines shorter by referring to e.g. &clk_cdce913_info instead of
&clk_cdce925_chip_info_tbl[CDCE913].

Drop enum related to chip type as there is no user.

While at it, remove the trailing comma in the terminator entry for the OF
table making code robust against (theoretical) misrebases or other similar
things where the new entry goes _after_ the termination without the
compiler noticing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-cdce925.c | 65 +++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index cdee4958f26d..584c103394bb 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -25,25 +25,11 @@
  * Model this as 2 PLL clocks which are parents to the outputs.
  */
 
-enum {
-	CDCE913,
-	CDCE925,
-	CDCE937,
-	CDCE949,
-};
-
 struct clk_cdce925_chip_info {
 	int num_plls;
 	int num_outputs;
 };
 
-static const struct clk_cdce925_chip_info clk_cdce925_chip_info_tbl[] = {
-	[CDCE913] = { .num_plls = 1, .num_outputs = 3 },
-	[CDCE925] = { .num_plls = 2, .num_outputs = 5 },
-	[CDCE937] = { .num_plls = 3, .num_outputs = 7 },
-	[CDCE949] = { .num_plls = 4, .num_outputs = 9 },
-};
-
 #define MAX_NUMBER_OF_PLLS	4
 #define MAX_NUMBER_OF_OUTPUTS	9
 
@@ -621,20 +607,10 @@ static struct regmap_bus regmap_cdce925_bus = {
 	.read = cdce925_regmap_i2c_read,
 };
 
-static const struct i2c_device_id cdce925_id[] = {
-	{ "cdce913", CDCE913 },
-	{ "cdce925", CDCE925 },
-	{ "cdce937", CDCE937 },
-	{ "cdce949", CDCE949 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, cdce925_id);
-
 static int cdce925_probe(struct i2c_client *client)
 {
 	struct clk_cdce925_chip *data;
 	struct device_node *node = client->dev.of_node;
-	const struct i2c_device_id *id = i2c_match_id(cdce925_id, client);
 	const char *parent_name;
 	const char *pll_clk_name[MAX_NUMBER_OF_PLLS] = {NULL,};
 	struct clk_init_data init;
@@ -665,7 +641,7 @@ static int cdce925_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->i2c_client = client;
-	data->chip_info = &clk_cdce925_chip_info_tbl[id->driver_data];
+	data->chip_info = i2c_get_match_data(client);
 	config.max_register = CDCE925_OFFSET_PLL +
 		data->chip_info->num_plls * 0x10 - 1;
 	data->regmap = devm_regmap_init(&client->dev, &regmap_cdce925_bus,
@@ -822,12 +798,41 @@ static int cdce925_probe(struct i2c_client *client)
 	return err;
 }
 
+static const struct clk_cdce925_chip_info clk_cdce913_info = {
+	.num_plls = 1,
+	.num_outputs = 3,
+};
+
+static const struct clk_cdce925_chip_info clk_cdce925_info = {
+	.num_plls = 2,
+	.num_outputs = 5,
+};
+
+static const struct clk_cdce925_chip_info clk_cdce937_info = {
+	.num_plls = 3,
+	.num_outputs = 7,
+};
+
+static const struct clk_cdce925_chip_info clk_cdce949_info = {
+	.num_plls = 4,
+	.num_outputs = 9,
+};
+
+static const struct i2c_device_id cdce925_id[] = {
+	{ "cdce913", (kernel_ulong_t)&clk_cdce913_info },
+	{ "cdce925", (kernel_ulong_t)&clk_cdce925_info },
+	{ "cdce937", (kernel_ulong_t)&clk_cdce937_info },
+	{ "cdce949", (kernel_ulong_t)&clk_cdce949_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cdce925_id);
+
 static const struct of_device_id clk_cdce925_of_match[] = {
-	{ .compatible = "ti,cdce913" },
-	{ .compatible = "ti,cdce925" },
-	{ .compatible = "ti,cdce937" },
-	{ .compatible = "ti,cdce949" },
-	{ },
+	{ .compatible = "ti,cdce913", .data = &clk_cdce913_info },
+	{ .compatible = "ti,cdce925", .data = &clk_cdce925_info },
+	{ .compatible = "ti,cdce937", .data = &clk_cdce937_info },
+	{ .compatible = "ti,cdce949", .data = &clk_cdce949_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_cdce925_of_match);
 
-- 
2.25.1

