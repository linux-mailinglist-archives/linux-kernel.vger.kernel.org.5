Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FCA78FE6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349798AbjIANkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241501AbjIANkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C9E7E;
        Fri,  1 Sep 2023 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575649; x=1725111649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8+gi9RZSVemWuYdaDyNHmLqYCbZ6+8ecKs+zs0OFVsY=;
  b=DGl1F8AVx5g2Nw1EqR5arM8dJv86swvP59zFTchfYQy8i3D4q9nfic2N
   Md6N7jg3wWjvP+d8GXq1rgvOjO34n5grmVPux0OZtZ2BeY514rF1VWlxa
   P246DuKtdUf2AXf3eSu2cDp/Zxn+YGK+FCBl4EQmbeHKyw8ydWojhE3RC
   Jyc+53Am8EHPzYpHMg+aGw+lEizje0V72I8GxgNc09z3V6P5aGDA1kZhN
   d7dM0ali9uIvHSPJusafeSx8y6xUhI6B38/0upVO178VQ20oWXLckHtLk
   76Mj7G1V+r6LPtv0d4CN3reSArYQOIr9K0UQEqgklIiXk35SDHuolHWKa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355718589"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="355718589"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854711312"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="854711312"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2023 06:40:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0F2AD71E; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 02/10] gpio: pca953x: Fully convert to device managed resources
Date:   Fri,  1 Sep 2023 16:40:33 +0300
Message-Id: <20230901134041.1165562-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Curtrently the error path is unsynchronised with removal due to
regulator being disabled before other device managed resources
are handled. Correct that by wrapping regulator enablement in
the respective call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 68 +++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 02695abd0eb1..0dedb2265744 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1045,13 +1045,40 @@ static int device_pca957x_init(struct pca953x_chip *chip)
 	return ret;
 }
 
+static void pca953x_disable_regulator(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static int pca953x_get_and_enable_regulator(struct pca953x_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct regulator *reg = chip->regulator;
+	int ret;
+
+	reg = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(reg))
+		return dev_err_probe(dev, PTR_ERR(reg), "reg get err\n");
+
+	ret = regulator_enable(reg);
+	if (ret)
+	        return dev_err_probe(dev, ret, "reg en err\n");
+
+	ret = devm_add_action_or_reset(dev, pca953x_disable_regulator, reg);
+	if (ret)
+		return ret;
+
+	chip->regulator = reg;
+	return 0;
+}
+
 static int pca953x_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct pca953x_platform_data *pdata;
 	struct pca953x_chip *chip;
 	int irq_base;
 	int ret;
-	struct regulator *reg;
 	const struct regmap_config *regmap_config;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
@@ -1086,16 +1113,9 @@ static int pca953x_probe(struct i2c_client *client)
 	if (!chip->driver_data)
 		return -ENODEV;
 
-	reg = devm_regulator_get(&client->dev, "vcc");
-	if (IS_ERR(reg))
-		return dev_err_probe(&client->dev, PTR_ERR(reg), "reg get err\n");
-
-	ret = regulator_enable(reg);
-	if (ret) {
-		dev_err(&client->dev, "reg en err: %d\n", ret);
+	ret = pca953x_get_and_enable_regulator(chip);
+	if (ret)
 		return ret;
-	}
-	chip->regulator = reg;
 
 	i2c_set_clientdata(client, chip);
 
@@ -1118,10 +1138,8 @@ static int pca953x_probe(struct i2c_client *client)
 	}
 
 	chip->regmap = devm_regmap_init_i2c(client, regmap_config);
-	if (IS_ERR(chip->regmap)) {
-		ret = PTR_ERR(chip->regmap);
-		goto err_exit;
-	}
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
 
 	regcache_mark_dirty(chip->regmap);
 
@@ -1156,28 +1174,13 @@ static int pca953x_probe(struct i2c_client *client)
 		ret = device_pca95xx_init(chip);
 	}
 	if (ret)
-		goto err_exit;
+		return ret;
 
 	ret = pca953x_irq_setup(chip, irq_base);
 	if (ret)
-		goto err_exit;
+		return ret;
 
-	ret = devm_gpiochip_add_data(&client->dev, &chip->gpio_chip, chip);
-	if (ret)
-		goto err_exit;
-
-	return 0;
-
-err_exit:
-	regulator_disable(chip->regulator);
-	return ret;
-}
-
-static void pca953x_remove(struct i2c_client *client)
-{
-	struct pca953x_chip *chip = i2c_get_clientdata(client);
-
-	regulator_disable(chip->regulator);
+	return devm_gpiochip_add_data(dev, &chip->gpio_chip, chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1345,7 +1348,6 @@ static struct i2c_driver pca953x_driver = {
 		.acpi_match_table = pca953x_acpi_ids,
 	},
 	.probe		= pca953x_probe,
-	.remove		= pca953x_remove,
 	.id_table	= pca953x_id,
 };
 
-- 
2.40.0.1.gaa8946217a0b

