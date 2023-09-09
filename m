Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFC0799A14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjIIQrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjIIQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:47:52 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74322129;
        Sat,  9 Sep 2023 09:47:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="175535710"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Sep 2023 01:47:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 80FD7400197C;
        Sun, 10 Sep 2023 01:47:41 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] clk: si570: Simplify probe()
Date:   Sat,  9 Sep 2023 17:47:38 +0100
Message-Id: <20230909164738.47708-1-biju.das.jz@bp.renesas.com>
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

Unify the OF/ID table by adding struct clk_si570_info as match data
instead of clk_si570_variant and replace the ID lookup table for
the match data by i2c_get_match_data(). This allows to simplify
probe().

Drop enum clk_si570_variant as there is no user.

While at it, remove the trailing comma in the terminator entry for the OF
table making code robust against (theoretical) misrebases or other similar
things where the new entry goes _after_ the termination without the
compiler noticing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-si570.c | 67 +++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index de0212fb5f87..ad053a922a42 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -49,12 +49,22 @@
 
 #define SI570_FREEZE_DCO	(1 << 4)
 
+/**
+ * struct clk_si570_info:
+ * @max_freq:	Maximum frequency for this device
+ * @has_temperature_stability: Device support temperature stability
+ */
+struct clk_si570_info {
+	u64 max_freq;
+	bool has_temperature_stability;
+};
+
 /**
  * struct clk_si570:
  * @hw:	Clock hw struct
  * @regmap:	Device's regmap
  * @div_offset:	Rgister offset for dividers
- * @max_freq:	Maximum frequency for this device
+ * @info:	Device info
  * @fxtal:	Factory xtal frequency
  * @n1:		Clock divider N1
  * @hs_div:	Clock divider HSDIV
@@ -66,7 +76,7 @@ struct clk_si570 {
 	struct clk_hw hw;
 	struct regmap *regmap;
 	unsigned int div_offset;
-	u64 max_freq;
+	const struct clk_si570_info *info;
 	u64 fxtal;
 	unsigned int n1;
 	unsigned int hs_div;
@@ -76,11 +86,6 @@ struct clk_si570 {
 };
 #define to_clk_si570(_hw)	container_of(_hw, struct clk_si570, hw)
 
-enum clk_si570_variant {
-	si57x,
-	si59x
-};
-
 /**
  * si570_get_divs() - Read clock dividers from HW
  * @data:	Pointer to struct clk_si570
@@ -341,7 +346,7 @@ static int si570_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct i2c_client *client = data->i2c_client;
 	int err;
 
-	if (rate < SI570_MIN_FREQ || rate > data->max_freq) {
+	if (rate < SI570_MIN_FREQ || rate > data->info->max_freq) {
 		dev_err(&client->dev,
 			"requested frequency %lu Hz is out of range\n", rate);
 		return -EINVAL;
@@ -398,24 +403,13 @@ static const struct regmap_config si570_regmap_config = {
 	.volatile_reg = si570_regmap_is_volatile,
 };
 
-static const struct i2c_device_id si570_id[] = {
-	{ "si570", si57x },
-	{ "si571", si57x },
-	{ "si598", si59x },
-	{ "si599", si59x },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, si570_id);
-
 static int si570_probe(struct i2c_client *client)
 {
 	struct clk_si570 *data;
 	struct clk_init_data init;
-	const struct i2c_device_id *id = i2c_match_id(si570_id, client);
 	u32 initial_fout, factory_fout, stability;
 	bool skip_recall;
 	int err;
-	enum clk_si570_variant variant = id->driver_data;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -427,7 +421,8 @@ static int si570_probe(struct i2c_client *client)
 	data->hw.init = &init;
 	data->i2c_client = client;
 
-	if (variant == si57x) {
+	data->info = i2c_get_match_data(client);
+	if (data->info->has_temperature_stability) {
 		err = of_property_read_u32(client->dev.of_node,
 				"temperature-stability", &stability);
 		if (err) {
@@ -438,10 +433,6 @@ static int si570_probe(struct i2c_client *client)
 		/* adjust register offsets for 7ppm devices */
 		if (stability == 7)
 			data->div_offset = SI570_DIV_OFFSET_7PPM;
-
-		data->max_freq = SI570_MAX_FREQ;
-	} else {
-		data->max_freq = SI598_MAX_FREQ;
 	}
 
 	if (of_property_read_string(client->dev.of_node, "clock-output-names",
@@ -496,12 +487,30 @@ static int si570_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct clk_si570_info clk_si570_info = {
+	.max_freq = SI570_MAX_FREQ,
+	.has_temperature_stability = true,
+};
+
+static const struct clk_si570_info clk_si590_info = {
+	.max_freq = SI598_MAX_FREQ,
+};
+
+static const struct i2c_device_id si570_id[] = {
+	{ "si570", (kernel_ulong_t)&clk_si570_info },
+	{ "si571", (kernel_ulong_t)&clk_si570_info },
+	{ "si598", (kernel_ulong_t)&clk_si590_info },
+	{ "si599", (kernel_ulong_t)&clk_si590_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si570_id);
+
 static const struct of_device_id clk_si570_of_match[] = {
-	{ .compatible = "silabs,si570" },
-	{ .compatible = "silabs,si571" },
-	{ .compatible = "silabs,si598" },
-	{ .compatible = "silabs,si599" },
-	{ },
+	{ .compatible = "silabs,si570", .data = &clk_si570_info },
+	{ .compatible = "silabs,si571", .data = &clk_si570_info },
+	{ .compatible = "silabs,si598", .data = &clk_si590_info },
+	{ .compatible = "silabs,si599", .data = &clk_si590_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_si570_of_match);
 
-- 
2.25.1

