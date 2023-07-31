Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4C769785
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjGaNZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjGaNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:25:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB21713;
        Mon, 31 Jul 2023 06:25:37 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C94A72E4;
        Mon, 31 Jul 2023 15:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690809868;
        bh=vtei7NXd+I1IEzwPdAa7WkQkNRkfuQphMPBcmKMItug=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Rtk99JKIY6VpbmfKxaH8JnhSxvUHMB6WPe9+5CkRVBxS+CfiN+HVmGwfjDNb3vN11
         P0PgJZ4IMKfZLZ6Xbha7lTObGQW7Fj8+brwCCRB/8jf33tm/P7MIWX+gkTMiB0bm7C
         rhug2IknXeRt+g4M+l9JxiOe8Y+FUeI4KkcnmUTU=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Mon, 31 Jul 2023 16:24:42 +0300
Subject: [PATCH v3 8/9] media: i2c: ds90ub953: Support non-sync mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-fpdlink-additions-v3-8-8acfc49c215a@ideasonboard.com>
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
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=vtei7NXd+I1IEzwPdAa7WkQkNRkfuQphMPBcmKMItug=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkx7ZAM29qGUdd4UIvtZBQzT3jVGP1/rrtTIW/o
 QrNAwqmC7WJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMe2QAAKCRD6PaqMvJYe
 9baDD/wLAwMWF7BQWC6WfEYlcN5XHzdeBo7/yrl3KbHcIh03HJ8k6EPYbEHrt80hPiNidFmBwjo
 N2/9i8J/N0lUFbNKoE07hyFztFkkpWu7nQoACikbDBuJoRforoidGYDtVwoCeJ0+hh54ThGqMms
 DIjeRm4rmuCv5O3BYCkAx8995kCx2bcJsMzuqR/q2DgR5HkhIq47Bt/3XeQXutY4VlFZmYYNDwd
 ZEF7WdtCbT7jOMFZnVqsLn1NFoTRYP+b0ir9YwfkjVrnZiaCjxQM1n8fpAybGEN5225FK+ryKSd
 ehyBpK0CSD5vqqs4npcOlIvo5k5ymhFluWH+7Tld23IxKwResMXyRww+J44cMqh6KHmsvFcxp2b
 cHM87nUHio0LE5OCF5hYLdsSjdEdheKPMlqTFWuj1x+H57Ahtb7j26qDXqX69I1ykuldsAP9Zx/
 jtf1gRX4TGIjGmYcLBST0rA+8FWO7sE/PruWjRNR+d1z0heALfqBBOQMmBf/t9kEwWW1zXyH5Eo
 PKj4RuuUDb5vPH8xphY2EVL0wenLxatSzcjX0s6Ejx1DveIhhOoplG8SJwy82/GgMSfSpatMyE6
 a4m63D7xs0fa8oHyKQJwLXj/y5+TIb3LNXhS7k+66rG6iImbirOUPs6Yn0uZZQgf8l1HF1acygS
 GgiWV7DJaliLdHQ==
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

Add support for FPD-Link non-sync mode with external clock. The only
thing that needs to be added is the calculation for the clkout.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ds90ub953.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ds90ub953.c b/drivers/media/i2c/ds90ub953.c
index e1bd33e91eff..d56c1dda89b3 100644
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -145,6 +145,7 @@ struct ub953_data {
 
 	struct i2c_client	*client;
 	struct regmap		*regmap;
+	struct clk		*clkin;
 
 	u32			num_data_lanes;
 	bool			non_continous_clk;
@@ -844,15 +845,21 @@ static int ub953_i2c_master_init(struct ub953_data *priv)
 
 static u64 ub953_get_fc_rate(struct ub953_data *priv)
 {
-	if (priv->mode != UB953_MODE_SYNC) {
+	switch (priv->mode) {
+	case UB953_MODE_SYNC:
+		if (priv->hw_data->is_ub971)
+			return priv->plat_data->bc_rate * 160ull;
+		else
+			return priv->plat_data->bc_rate / 2 * 160ull;
+
+	case UB953_MODE_NONSYNC_EXT:
+		/* CLKIN_DIV = 1 always */
+		return clk_get_rate(priv->clkin) * 80ull;
+
+	default:
 		/* Not supported */
 		return 0;
 	}
-
-	if (priv->hw_data->is_ub971)
-		return priv->plat_data->bc_rate * 160ull;
-	else
-		return priv->plat_data->bc_rate / 2 * 160ull;
 }
 
 static unsigned long ub953_calc_clkout_ub953(struct ub953_data *priv,
@@ -1195,9 +1202,15 @@ static int ub953_hw_init(struct ub953_data *priv)
 	dev_dbg(dev, "mode from %s: %#x\n", mode_override ? "reg" : "strap",
 		priv->mode);
 
-	if (priv->mode != UB953_MODE_SYNC)
+	if (priv->mode != UB953_MODE_SYNC &&
+	    priv->mode != UB953_MODE_NONSYNC_EXT)
 		return dev_err_probe(dev, -ENODEV,
-				     "Only synchronous mode supported\n");
+				     "Unsupported mode selected: %u\n",
+				     priv->mode);
+
+	if (priv->mode == UB953_MODE_NONSYNC_EXT && !priv->clkin)
+		return dev_err_probe(dev, -EINVAL,
+				     "clkin required for non-sync ext mode\n");
 
 	ret = ub953_read(priv, UB953_REG_REV_MASK_ID, &v);
 	if (ret)
@@ -1314,6 +1327,13 @@ static int ub953_probe(struct i2c_client *client)
 		goto err_mutex_destroy;
 	}
 
+	priv->clkin = devm_clk_get_optional(dev, "clkin");
+	if (IS_ERR(priv->clkin)) {
+		ret = PTR_ERR(priv->clkin);
+		dev_err_probe(dev, ret, "failed to parse 'clkin'\n");
+		goto err_mutex_destroy;
+	}
+
 	ret = ub953_parse_dt(priv);
 	if (ret)
 		goto err_mutex_destroy;

-- 
2.34.1

