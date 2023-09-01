Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB178FE6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbjIANkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIANkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A9E4C;
        Fri,  1 Sep 2023 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575648; x=1725111648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X802rapkkzG+OIN/1IPRinaaVSGUEdf+mOn5B1PZ3jw=;
  b=PaL6oHuaQfXVOi59wv4DQb8dysb2RSSCRpeEzK8ZihsN5UseUJ7co3Xb
   x8iVn/KlsH01AcRZ5zIRpiCAXE4NSRHEfHsdwE1mJbVomgMrwDHHcJPA0
   92rU8laXNmP6G/7UqxeiXo1ZlPAMbTLCT4JsSLOLcOVa3VTlD3yYMCv4z
   7qyn28SEkVws9P9DjGpXbi3QUpNh0J9212hkaGI/DTjSHx/XnSzwzyzir
   ckHYts/WsgsJdLwrzW+M7RSFLrnC0qqdEOPAsb4jgBAEIWFALehB6JeZD
   iTAKLPCtE723pkWMtGYarMtJ2BR7/w69sMD3MZqN6sHJ5xXHj/Hz1DTCi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355718594"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="355718594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854711311"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="854711311"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2023 06:40:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00200761; Fri,  1 Sep 2023 16:40:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 01/10] gpio: pca953x: Drop unused fields in struct pca953x_platform_data
Date:   Fri,  1 Sep 2023 16:40:32 +0300
Message-Id: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

New code should solely use firmware nodes for the specifics and
not any callbacks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c           | 37 ++++++---------------------
 include/linux/platform_data/pca953x.h | 13 ----------
 2 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index bdd50a78e414..02695abd0eb1 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -211,7 +211,6 @@ struct pca953x_chip {
 
 	struct i2c_client *client;
 	struct gpio_chip gpio_chip;
-	const char *const *names;
 	unsigned long driver_data;
 	struct regulator *regulator;
 
@@ -712,7 +711,6 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 	gc->label = dev_name(&chip->client->dev);
 	gc->parent = &chip->client->dev;
 	gc->owner = THIS_MODULE;
-	gc->names = chip->names;
 }
 
 #ifdef CONFIG_GPIO_PCA953X_IRQ
@@ -998,7 +996,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
 }
 #endif
 
-static int device_pca95xx_init(struct pca953x_chip *chip, u32 invert)
+static int device_pca95xx_init(struct pca953x_chip *chip)
 {
 	DECLARE_BITMAP(val, MAX_LINE);
 	u8 regaddr;
@@ -1016,24 +1014,21 @@ static int device_pca95xx_init(struct pca953x_chip *chip, u32 invert)
 	if (ret)
 		goto out;
 
-	/* set platform specific polarity inversion */
-	if (invert)
-		bitmap_fill(val, MAX_LINE);
-	else
-		bitmap_zero(val, MAX_LINE);
+	/* clear polarity inversion */
+	bitmap_zero(val, MAX_LINE);
 
 	ret = pca953x_write_regs(chip, chip->regs->invert, val);
 out:
 	return ret;
 }
 
-static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
+static int device_pca957x_init(struct pca953x_chip *chip)
 {
 	DECLARE_BITMAP(val, MAX_LINE);
 	unsigned int i;
 	int ret;
 
-	ret = device_pca95xx_init(chip, invert);
+	ret = device_pca95xx_init(chip);
 	if (ret)
 		goto out;
 
@@ -1054,9 +1049,8 @@ static int pca953x_probe(struct i2c_client *client)
 {
 	struct pca953x_platform_data *pdata;
 	struct pca953x_chip *chip;
-	int irq_base = 0;
+	int irq_base;
 	int ret;
-	u32 invert = 0;
 	struct regulator *reg;
 	const struct regmap_config *regmap_config;
 
@@ -1068,8 +1062,6 @@ static int pca953x_probe(struct i2c_client *client)
 	if (pdata) {
 		irq_base = pdata->irq_base;
 		chip->gpio_start = pdata->gpio_base;
-		invert = pdata->invert;
-		chip->names = pdata->names;
 	} else {
 		struct gpio_desc *reset_gpio;
 
@@ -1158,10 +1150,10 @@ static int pca953x_probe(struct i2c_client *client)
 	 */
 	if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
 		chip->regs = &pca957x_regs;
-		ret = device_pca957x_init(chip, invert);
+		ret = device_pca957x_init(chip);
 	} else {
 		chip->regs = &pca953x_regs;
-		ret = device_pca95xx_init(chip, invert);
+		ret = device_pca95xx_init(chip);
 	}
 	if (ret)
 		goto err_exit;
@@ -1174,13 +1166,6 @@ static int pca953x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_exit;
 
-	if (pdata && pdata->setup) {
-		ret = pdata->setup(client, chip->gpio_chip.base,
-				   chip->gpio_chip.ngpio, pdata->context);
-		if (ret < 0)
-			dev_warn(&client->dev, "setup failed, %d\n", ret);
-	}
-
 	return 0;
 
 err_exit:
@@ -1190,14 +1175,8 @@ static int pca953x_probe(struct i2c_client *client)
 
 static void pca953x_remove(struct i2c_client *client)
 {
-	struct pca953x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct pca953x_chip *chip = i2c_get_clientdata(client);
 
-	if (pdata && pdata->teardown) {
-		pdata->teardown(client, chip->gpio_chip.base,
-				chip->gpio_chip.ngpio, pdata->context);
-	}
-
 	regulator_disable(chip->regulator);
 }
 
diff --git a/include/linux/platform_data/pca953x.h b/include/linux/platform_data/pca953x.h
index 96c1a14ab365..3c3787c4d96c 100644
--- a/include/linux/platform_data/pca953x.h
+++ b/include/linux/platform_data/pca953x.h
@@ -11,21 +11,8 @@ struct pca953x_platform_data {
 	/* number of the first GPIO */
 	unsigned	gpio_base;
 
-	/* initial polarity inversion setting */
-	u32		invert;
-
 	/* interrupt base */
 	int		irq_base;
-
-	void		*context;	/* param to setup/teardown */
-
-	int		(*setup)(struct i2c_client *client,
-				unsigned gpio, unsigned ngpio,
-				void *context);
-	void		(*teardown)(struct i2c_client *client,
-				unsigned gpio, unsigned ngpio,
-				void *context);
-	const char	*const *names;
 };
 
 #endif /* _LINUX_PCA953X_H */
-- 
2.40.0.1.gaa8946217a0b

