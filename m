Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE078F440
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347425AbjHaUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjHaUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:47:47 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAE04CFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:47:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="174635229"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 05:47:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 474AB402951B;
        Fri,  1 Sep 2023 05:47:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/2] ASoC: ak4642: Minor cleanups in probe()
Date:   Thu, 31 Aug 2023 21:47:33 +0100
Message-Id: <20230831204734.104954-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831204734.104954-1-biju.das.jz@bp.renesas.com>
References: <20230831204734.104954-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor cleanups:
 Replace local variable np with dev_fwnode()
 Replace dev_err()->dev_err_probe().
 Remove comma in the terminator entry for OF table.
 Drop a space in the terminator entry for ID table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 sound/soc/codecs/ak4642.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 2a8984c1fa9c..901014909c0f 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -633,13 +633,12 @@ static const struct i2c_device_id ak4642_i2c_id[];
 static int ak4642_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
-	struct device_node *np = dev->of_node;
 	const struct ak4642_drvdata *drvdata = NULL;
 	struct regmap *regmap;
 	struct ak4642_priv *priv;
 	struct clk *mcko = NULL;
 
-	if (np) {
+	if (dev_fwnode(dev)) {
 		const struct of_device_id *of_id;
 
 		mcko = ak4642_of_parse_mcko(dev);
@@ -655,10 +654,8 @@ static int ak4642_i2c_probe(struct i2c_client *i2c)
 		drvdata = (const struct ak4642_drvdata *)id->driver_data;
 	}
 
-	if (!drvdata) {
-		dev_err(dev, "Unknown device type\n");
-		return -EINVAL;
-	}
+	if (!drvdata)
+		return dev_err_probe(dev, -EINVAL, "Unknown device type\n");
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -681,7 +678,7 @@ static const struct of_device_id ak4642_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4642",	.data = &ak4642_drvdata},
 	{ .compatible = "asahi-kasei,ak4643",	.data = &ak4643_drvdata},
 	{ .compatible = "asahi-kasei,ak4648",	.data = &ak4648_drvdata},
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, ak4642_of_match);
 
@@ -689,7 +686,7 @@ static const struct i2c_device_id ak4642_i2c_id[] = {
 	{ "ak4642", (kernel_ulong_t)&ak4642_drvdata },
 	{ "ak4643", (kernel_ulong_t)&ak4643_drvdata },
 	{ "ak4648", (kernel_ulong_t)&ak4648_drvdata },
-	{ }
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, ak4642_i2c_id);
 
-- 
2.25.1

