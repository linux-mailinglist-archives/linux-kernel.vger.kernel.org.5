Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC7799981
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjIIQZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbjIIPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:54:29 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11C0913E;
        Sat,  9 Sep 2023 08:54:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,239,1688396400"; 
   d="scan'208";a="175533633"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Sep 2023 00:54:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.15])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EFB0640118FA;
        Sun, 10 Sep 2023 00:54:20 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] clk: clk-si544: Simplify probe() and is_valid_frequency()
Date:   Sat,  9 Sep 2023 16:54:18 +0100
Message-Id: <20230909155418.24426-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Unify the OF/ID table by using max_freq as match data instead of
enum si544_speed_grade and replace the ID lookup table for
the match data by i2c_get_match_data(). This allows to simplify both
probe() and is_valid_frequency().

Drop enum si544_speed_grade as there is no user.

While at it, remove the trailing comma in the terminator entry for the OF
table making code robust against (theoretical) misrebases or other similar
things where the new entry goes _after_ the termination without the
compiler noticing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-si544.c | 51 ++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index 22925968aa35..4132db706144 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -56,17 +56,11 @@
 #define DELTA_M_FRAC_NUM	19
 #define DELTA_M_FRAC_DEN	20000
 
-enum si544_speed_grade {
-	si544a,
-	si544b,
-	si544c,
-};
-
 struct clk_si544 {
 	struct clk_hw hw;
 	struct regmap *regmap;
 	struct i2c_client *i2c_client;
-	enum si544_speed_grade speed_grade;
+	unsigned long  max_freq;
 };
 #define to_clk_si544(_hw)	container_of(_hw, struct clk_si544, hw)
 
@@ -196,24 +190,10 @@ static int si544_set_muldiv(struct clk_si544 *data,
 static bool is_valid_frequency(const struct clk_si544 *data,
 	unsigned long frequency)
 {
-	unsigned long max_freq = 0;
-
 	if (frequency < SI544_MIN_FREQ)
 		return false;
 
-	switch (data->speed_grade) {
-	case si544a:
-		max_freq = 1500000000;
-		break;
-	case si544b:
-		max_freq = 800000000;
-		break;
-	case si544c:
-		max_freq = 350000000;
-		break;
-	}
-
-	return frequency <= max_freq;
+	return frequency <= data->max_freq;
 }
 
 /* Calculate divider settings for a given frequency */
@@ -451,19 +431,10 @@ static const struct regmap_config si544_regmap_config = {
 	.volatile_reg = si544_regmap_is_volatile,
 };
 
-static const struct i2c_device_id si544_id[] = {
-	{ "si544a", si544a },
-	{ "si544b", si544b },
-	{ "si544c", si544c },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, si544_id);
-
 static int si544_probe(struct i2c_client *client)
 {
 	struct clk_si544 *data;
 	struct clk_init_data init;
-	const struct i2c_device_id *id = i2c_match_id(si544_id, client);
 	int err;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
@@ -475,7 +446,7 @@ static int si544_probe(struct i2c_client *client)
 	init.num_parents = 0;
 	data->hw.init = &init;
 	data->i2c_client = client;
-	data->speed_grade = id->driver_data;
+	data->max_freq = (uintptr_t)i2c_get_match_data(client);
 
 	if (of_property_read_string(client->dev.of_node, "clock-output-names",
 			&init.name))
@@ -507,11 +478,19 @@ static int si544_probe(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id si544_id[] = {
+	{ "si544a", 1500000000 },
+	{ "si544b", 800000000 },
+	{ "si544c", 350000000 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si544_id);
+
 static const struct of_device_id clk_si544_of_match[] = {
-	{ .compatible = "silabs,si544a" },
-	{ .compatible = "silabs,si544b" },
-	{ .compatible = "silabs,si544c" },
-	{ },
+	{ .compatible = "silabs,si544a", .data = (void *)1500000000 },
+	{ .compatible = "silabs,si544b", .data = (void *)800000000 },
+	{ .compatible = "silabs,si544c", .data = (void *)350000000 },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_si544_of_match);
 
-- 
2.25.1

