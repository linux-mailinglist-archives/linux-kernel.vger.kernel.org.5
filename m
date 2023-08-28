Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5E78B6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjH1SAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjH1SAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:00:12 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 372ECF9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:00:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,208,1688396400"; 
   d="scan'208";a="177945066"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2023 03:00:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.234])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A5D5A400A8A4;
        Tue, 29 Aug 2023 03:00:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] ASoC: ak4642: Simplify probe()
Date:   Mon, 28 Aug 2023 19:00:03 +0100
Message-Id: <20230828180003.127896-1-biju.das.jz@bp.renesas.com>
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

Simpilfy probe() by replacing of_device_get_match_data() and id lookup for
retrieving match data by i2c_get_match_data() and replace
dev_err()->dev_err_probe().

While at it, drop local variable np and use dev_fwnode() instead and
remove comma in the terminator entry.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.

v1->v2:
 * Removed forward declaration ak4642_of_match and ak4642_i2c_id.
 * Restored error EINVAL.
 * Used dev_fwnode() and replaced dev->of_node.
 * Removed comma in the terminator entry.
---
 sound/soc/codecs/ak4642.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 2a8984c1fa9c..8a40c6b3f4d8 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -628,37 +628,23 @@ static struct clk *ak4642_of_parse_mcko(struct device *dev)
 #define ak4642_of_parse_mcko(d) 0
 #endif
 
-static const struct of_device_id ak4642_of_match[];
-static const struct i2c_device_id ak4642_i2c_id[];
 static int ak4642_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
-	struct device_node *np = dev->of_node;
-	const struct ak4642_drvdata *drvdata = NULL;
+	const struct ak4642_drvdata *drvdata;
 	struct regmap *regmap;
 	struct ak4642_priv *priv;
 	struct clk *mcko = NULL;
 
-	if (np) {
-		const struct of_device_id *of_id;
-
+	if (dev_fwnode(dev)) {
 		mcko = ak4642_of_parse_mcko(dev);
 		if (IS_ERR(mcko))
 			mcko = NULL;
-
-		of_id = of_match_device(ak4642_of_match, dev);
-		if (of_id)
-			drvdata = of_id->data;
-	} else {
-		const struct i2c_device_id *id =
-			i2c_match_id(ak4642_i2c_id, i2c);
-		drvdata = (const struct ak4642_drvdata *)id->driver_data;
 	}
 
-	if (!drvdata) {
-		dev_err(dev, "Unknown device type\n");
-		return -EINVAL;
-	}
+	drvdata = i2c_get_match_data(i2c);
+	if (!drvdata)
+		return dev_err_probe(dev, -EINVAL, "Unknown device type\n");
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -681,7 +667,7 @@ static const struct of_device_id ak4642_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4642",	.data = &ak4642_drvdata},
 	{ .compatible = "asahi-kasei,ak4643",	.data = &ak4643_drvdata},
 	{ .compatible = "asahi-kasei,ak4648",	.data = &ak4648_drvdata},
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, ak4642_of_match);
 
@@ -689,7 +675,7 @@ static const struct i2c_device_id ak4642_i2c_id[] = {
 	{ "ak4642", (kernel_ulong_t)&ak4642_drvdata },
 	{ "ak4643", (kernel_ulong_t)&ak4643_drvdata },
 	{ "ak4648", (kernel_ulong_t)&ak4648_drvdata },
-	{ }
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, ak4642_i2c_id);
 
-- 
2.25.1

