Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B249975AC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGTKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjGTKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:31:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3410F1;
        Thu, 20 Jul 2023 03:31:46 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8ED4737A2;
        Thu, 20 Jul 2023 12:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689849047;
        bh=voR+HIz/XDavd4wzz+Vp//Iu4A0tNRNWdTZwN65n+JA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qOJTeAAF3tE6iRTT5jV6xxjKztvE1oDRJZ1hno6nioW0QURCwO/dPtFm2yyCbLJZk
         G9w1cVZ8i2avaoSyUBkKm9wV4dL/dixDhpq+EpeV1liYz12gkgWj8Ab/0evs6R+oJ/
         zcLYvA2Hg9rvtMYRUpyjs7+KFCqUfMbaZXke5dUU=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 13:30:37 +0300
Subject: [PATCH v2 6/8] media: i2c: ds90ub953: Restructure clkout
 management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-fpdlink-additions-v2-6-b91b1eca2ad3@ideasonboard.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
In-Reply-To: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6059;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=voR+HIz/XDavd4wzz+Vp//Iu4A0tNRNWdTZwN65n+JA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkuQ0Gh4xXec7JBNHbwWLxEILbCSmxX/r09MWxF
 riAySfG8geJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZLkNBgAKCRD6PaqMvJYe
 9XsZD/4oZvc1In4dU9ecUxJcex96ZAaNC6MyWiaVfKcTQ5tceKRvVcugDEJB3lMiN46aRY6qhtx
 52PbvOESJrTS/V4LU8gIGPebkF7ji+tS4464TunFmeOgd0k9cixziwUOZZ/zDT50GXyu6+qjYkE
 i79F15ZNsHyOFk68iIsenAAgZvf6yBivCQeSjRltHx4ECnvucg9fnS+eWQnaeRWA0puzMCNU4xx
 bqrqoeUvFq/W3ZoxQ5zkuHmZs1EWxO6flcziZPYrGRZHabM1hpEfaRD1WT1jkTa55we4qUoUfzx
 ZHS3xJxpII62k8M8YRqwLKPOQNf/q75IGCiYpe5m4dsatxudLRyaCeO2G4ff2taQf89NT41RJnH
 Tct5ljQ41Ihy0N+69EYjQm5ChS1i2D5lof0Kw+wMecDRF8xR/kOIjEwrFiwD/1CYcft8BzTVbwl
 RIqU9kAK+IwsAfu9ApkujeP5T04dM67rZpHDwuSiitvRyGhZ48mFXA7YmEPT98kvL8NN5UH09cE
 Z1E3Si9lLCqClKjDmuFX98JrNUYfmyo8/0hZdAFOiC8kgYBYreqmmiAeLQIEFkZ4ZVkOjv+RUfv
 sXFqAezX5PFndxr+nY2m2Mr/Lku6YTzWa8b9nLmvqMCYpXxEOWK32uIr7UOU4gJ4TVZfLko+GoP
 v5OR2w2UXWCU4DA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/media/i2c/ds90ub953.c | 135 ++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 65 deletions(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index ad479923d2b4..3a19c6dedd2f 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -131,6 +131,13 @@ struct ub953_hw_data {
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
 
@@ -906,6 +913,58 @@ static unsigned long ub953_calc_clkout_ub971(struct ub953_data *priv,
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
+				    struct ub953_clkout_data *clkout_data)
+{
+	if (priv->hw_data->is_ub971) {
+		ub953_write(priv, UB953_REG_CLKOUT_CTRL0, clkout_data->m);
+		ub953_write(priv, UB953_REG_CLKOUT_CTRL1, clkout_data->n);
+	} else {
+		ub953_write(priv, UB953_REG_CLKOUT_CTRL0,
+			    (__ffs(clkout_data->hs_div) << 5) | clkout_data->m);
+		ub953_write(priv, UB953_REG_CLKOUT_CTRL1, clkout_data->n);
+	}
+}
+
 static unsigned long ub953_clkout_recalc_rate(struct clk_hw *hw,
 					      unsigned long parent_rate)
 {
@@ -965,52 +1024,25 @@ static long ub953_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long *parent_rate)
 {
 	struct ub953_data *priv = container_of(hw, struct ub953_data, clkout_clk_hw);
-	struct device *dev = &priv->client->dev;
-	unsigned long res;
-	u64 fc_rate;
-	u8 hs_div, m, n;
-
-	fc_rate = ub953_get_fc_rate(priv);
+	struct ub953_clkout_data clkout_data;
 
-	if (priv->hw_data->is_ub971) {
-		res = ub953_calc_clkout_ub971(priv, rate, fc_rate, &m, &n);
+	ub953_calc_clkout_params(priv, rate, &clkout_data);
 
-		dev_dbg(dev, "%s %llu * %u / (8 * %u) = %lu (requested %lu)",
-			__func__, fc_rate, m, n, res, rate);
-	} else {
-		res = ub953_calc_clkout_ub953(priv, rate, fc_rate, &hs_div, &m, &n);
-
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
-
-	if (priv->hw_data->is_ub971) {
-		res = ub953_calc_clkout_ub971(priv, rate, fc_rate, &m, &n);
-
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL0, m);
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL1, n);
-	} else {
-		res = ub953_calc_clkout_ub953(priv, rate, fc_rate, &hs_div, &m, &n);
+	ub953_calc_clkout_params(priv, rate, &clkout_data);
 
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL0, (__ffs(hs_div) << 5) | m);
-		ub953_write(priv, UB953_REG_CLKOUT_CTRL1, n);
-	}
+	dev_dbg(&priv->client->dev, "%s %lu (requested %lu)\n", __func__,
+		clkout_data.rate, rate);
 
-	dev_dbg(&priv->client->dev, "%s %lu (requested %lu)\n", __func__, res,
-		rate);
+	ub953_write_clkout_regs(priv, &clkout_data);
 
 	return 0;
 }
@@ -1021,32 +1053,6 @@ static const struct clk_ops ub953_clkout_ops = {
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
@@ -1055,16 +1061,15 @@ static int ub953_register_clkout(struct ub953_data *priv)
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
+	ub953_calc_clkout_params(priv, 25000000, &clkout_data);
+	ub953_write_clkout_regs(priv, &clkout_data);
 
 	priv->clkout_clk_hw.init = &init;
 

-- 
2.34.1

