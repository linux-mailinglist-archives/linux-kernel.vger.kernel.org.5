Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC9769787
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjGaNZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjGaNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A497170C;
        Mon, 31 Jul 2023 06:25:36 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 299B5E79;
        Mon, 31 Jul 2023 15:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809866;
        bh=YclCu9MWxI1RLNahbDvt0bUIxt4jnTE0SQ6Uw7/PHgk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=haxec1VanzgITfRb+YEitnEb+GWf8YVElPmzQY5poulc/uHyq4INVQAWcUnY0zhQ1
         j5rvi+kW0xiCUdT+KtE5vh7v2CprEAqyNyQtGI4wVaIioRsve9bkbdXhSYNUNEiSvM
         /Kx7jAiXL6fkh4h5Lq4W1jGFabp1VlpuiTxNSwLE=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:41 +0300
Subject: [PATCH v3 7/9] media: i2c: ds90ub953: Restructure clkout
 management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-7-8acfc49c215a@ideasonboard.com>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
In-Reply-To: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6404;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=YclCu9MWxI1RLNahbDvt0bUIxt4jnTE0SQ6Uw7/PHgk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7ZAG3xYVxOm16pm5AQBuD2QxklzuzG6HPmir
 eLryUajVSuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2QAAKCRD6PaqMvJYe
 9Ur7D/9qZQ5TcwVXsxkQtEkVL35DXgkSPfkSlgEN9YM1LVPtLuTNfQBze5BXybI8EsvNtCr6qln
 xPJCmUGMSAgfxRkJq26c0F8SwGgdkwQ3j3JY+ZMJjutIVV4GVZpbUJkFPWJtTP8aXmKSfHlsmDB
 8WqlxS6Xp3WjIZa1esT3S3CWVYjVGBQOFEooFRs2ZlnrsL1jYulzb0ihYaxZ/v8l+7k2TVhlqdJ
 Ep5zUCaeooP0dmb0p0U+SbtI/T3B/UAYtECRzFh8K9AYJ96KdloODxdgYelAuUYhe5v/2TxO5vC
 1ZmnDVwNJKM6uDtZIg1gjHSjH3KIOY+eBOolY7OFFLlEXOvO3zyCjRw8WE1JejFSjwvB7EeZLGl
 eu2/bLa0orAuJvkLObHHRzbqtfyUKv5MKV0wGUeVIAeps6OE7nJJGi6VDZ8oSkxAyYFOe6lw3Ti
 b2RttYQ/bKlJmwIubsq1cwSY1QzsEJArzI9BEz8cDxKSr/126Xh6cAmYHjCA9LUYajbFjlquWHe
 wuV/0gtjfQs9yXqlPj8sJGzCiAsHlmdG+nEjJjMt1j7Jw7t+AHs/dzKWEqsXYo00/tFqiQh1Txl
 k8XJZSpb9bpXh3g4s7KWYHPvDgkj6Ho2kMBBNrYUuCAYuTIycLncOGi6o/ALdb1PtIqpibpsdQd
 S8lExH1fwu/2ToQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate clkout calculations and register writes into two functions:
ub953_calc_clkout_params and ub953_write_clkout_regs, and add a struct
ub953_clkout_data that is used to store the clkout parameters.

This simplifies the clkout management.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ds90ub953.c | 141 +++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 65 deletions(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index eedbca986928..e1bd33e91eff 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -34,6 +34,8 @@
 
 #define UB953_NUM_GPIOS			4
 
+#define UB953_DEFAULT_CLKOUT_RATE	25000000UL
+
 #define UB953_REG_RESET_CTL			0x01
 #define UB953_REG_RESET_CTL_DIGITAL_RESET_1	BIT(1)
 #define UB953_REG_RESET_CTL_DIGITAL_RESET_0	BIT(0)
@@ -131,6 +133,13 @@ struct ub953_hw_data {
 	bool is_ub971;
 };
 
+struct ub953_clkout_data {
+	u32 hs_div;
+	u32 m;
+	u32 n;
+	unsigned long rate;
+};
+
 struct ub953_data {
 	const struct ub953_hw_data	*hw_data;
 
@@ -906,6 +915,62 @@ static unsigned long ub953_calc_clkout_ub971(struct ub953_data *priv,
 	return res;
 }
 
+static void ub953_calc_clkout_params(struct ub953_data *priv,
+				     unsigned long target_rate,
+				     struct ub953_clkout_data *clkout_data)
+{
+	struct device *dev = &priv->client->dev;
+	unsigned long clkout_rate;
+	u64 fc_rate;
+
+	fc_rate = ub953_get_fc_rate(priv);
+
+	if (priv->hw_data->is_ub971) {
+		u8 m, n;
+
+		clkout_rate = ub953_calc_clkout_ub971(priv, target_rate,
+						      fc_rate, &m, &n);
+
+		clkout_data->m = m;
+		clkout_data->n = n;
+
+		dev_dbg(dev, "%s %llu * %u / (8 * %u) = %lu (requested %lu)",
+			__func__, fc_rate, m, n, clkout_rate, target_rate);
+	} else {
+		u8 hs_div, m, n;
+
+		clkout_rate = ub953_calc_clkout_ub953(priv, target_rate,
+						      fc_rate, &hs_div, &m, &n);
+
+		clkout_data->hs_div = hs_div;
+		clkout_data->m = m;
+		clkout_data->n = n;
+
+		dev_dbg(dev, "%s %llu / %u * %u / %u = %lu (requested %lu)",
+			__func__, fc_rate, hs_div, m, n, clkout_rate,
+			target_rate);
+	}
+
+	clkout_data->rate = clkout_rate;
+}
+
+static void ub953_write_clkout_regs(struct ub953_data *priv,
+				    const struct ub953_clkout_data *clkout_data)
+{
+	u8 clkout_ctrl0, clkout_ctrl1;
+
+	if (priv->hw_data->is_ub971)
+		clkout_ctrl0 = clkout_data->m;
+	else
+		clkout_ctrl0 = (__ffs(clkout_data->hs_div) << 5) |
+			       clkout_data->m;
+
+	clkout_ctrl1 = clkout_data->n;
+
+	ub953_write(priv, UB953_REG_CLKOUT_CTRL0, clkout_ctrl0);
+	ub953_write(priv, UB953_REG_CLKOUT_CTRL1, clkout_ctrl1);
+}
+
 static unsigned long ub953_clkout_recalc_rate(struct clk_hw *hw,
 					      unsigned long parent_rate)
 {
@@ -965,52 +1030,25 @@ static long ub953_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long *parent_rate)
 {
 	struct ub953_data *priv = container_of(hw, struct ub953_data, clkout_clk_hw);
-	struct device *dev = &priv->client->dev;
-	unsigned long res;
-	u64 fc_rate;
-	u8 hs_div, m, n;
-
-	fc_rate = ub953_get_fc_rate(priv);
-
-	if (priv->hw_data->is_ub971) {
-		res = ub953_calc_clkout_ub971(priv, rate, fc_rate, &m, &n);
+	struct ub953_clkout_data clkout_data;
 
-		dev_dbg(dev, "%s %llu * %u / (8 * %u) = %lu (requested %lu)",
-			__func__, fc_rate, m, n, res, rate);
-	} else {
-		res = ub953_calc_clkout_ub953(priv, rate, fc_rate, &hs_div, &m, &n);
+	ub953_calc_clkout_params(priv, rate, &clkout_data);
 
-		dev_dbg(dev, "%s %llu / %u * %u / %u = %lu (requested %lu)",
-			__func__, fc_rate, hs_div, m, n, res, rate);
-	}
-
-	return res;
+	return clkout_data.rate;
 }
 
 static int ub953_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
 {
 	struct ub953_data *priv = container_of(hw, struct ub953_data, clkout_clk_hw);
-	u64 fc_rate;
-	u8 hs_div, m, n;
-	unsigned long res;
+	struct ub953_clkout_data clkout_data;
 
-	fc_rate = ub953_get_fc_rate(priv);
+	ub953_calc_clkout_params(priv, rate, &clkout_data);
 
-	if (priv->hw_data->is_ub971) {
-		res = ub953_calc_clkout_ub971(priv, rate, fc_rate, &m, &n);
+	dev_dbg(&priv->client->dev, "%s %lu (requested %lu)\n", __func__,
+		clkout_data.rate, rate);
 
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL0, m);
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL1, n);
-	} else {
-		res = ub953_calc_clkout_ub953(priv, rate, fc_rate, &hs_div, &m, &n);
-
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL0, (__ffs(hs_div) << 5) | m);
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL1, n);
-	}
-
-	dev_dbg(&priv->client->dev, "%s %lu (requested %lu)\n", __func__, res,
-		rate);
+	ub953_write_clkout_regs(priv, &clkout_data);
 
 	return 0;
 }
@@ -1021,32 +1059,6 @@ static const struct clk_ops ub953_clkout_ops = {
 	.set_rate	= ub953_clkout_set_rate,
 };
 
-static void ub953_init_clkout_ub953(struct ub953_data *priv)
-{
-	u64 fc_rate;
-	u8 hs_div, m, n;
-
-	fc_rate = ub953_get_fc_rate(priv);
-
-	ub953_calc_clkout_ub953(priv, 25000000, fc_rate, &hs_div, &m, &n);
-
-	ub953_write(priv, UB953_REG_CLKOUT_CTRL0, (__ffs(hs_div) << 5) | m);
-	ub953_write(priv, UB953_REG_CLKOUT_CTRL1, n);
-}
-
-static void ub953_init_clkout_ub971(struct ub953_data *priv)
-{
-	u64 fc_rate;
-	u8 m, n;
-
-	fc_rate = ub953_get_fc_rate(priv);
-
-	ub953_calc_clkout_ub971(priv, 25000000, fc_rate, &m, &n);
-
-	ub953_write(priv, UB953_REG_CLKOUT_CTRL0, m);
-	ub953_write(priv, UB953_REG_CLKOUT_CTRL1, n);
-}
-
 static int ub953_register_clkout(struct ub953_data *priv)
 {
 	struct device *dev = &priv->client->dev;
@@ -1055,16 +1067,15 @@ static int ub953_register_clkout(struct ub953_data *priv)
 				  priv->hw_data->model, dev_name(dev)),
 		.ops = &ub953_clkout_ops,
 	};
+	struct ub953_clkout_data clkout_data;
 	int ret;
 
 	if (!init.name)
 		return -ENOMEM;
 
 	/* Initialize clkout to 25MHz by default */
-	if (priv->hw_data->is_ub971)
-		ub953_init_clkout_ub971(priv);
-	else
-		ub953_init_clkout_ub953(priv);
+	ub953_calc_clkout_params(priv, UB953_DEFAULT_CLKOUT_RATE, &clkout_data);
+	ub953_write_clkout_regs(priv, &clkout_data);
 
 	priv->clkout_clk_hw.init = &init;
 

-- 
2.34.1

