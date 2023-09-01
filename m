Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584478FE78
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbjIANlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349796AbjIANky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49705E77;
        Fri,  1 Sep 2023 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575652; x=1725111652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMwGS+8lGtRWIaPNiZ03JumXEZIRADTdH+9Q2up/8o0=;
  b=PuxT5Y7wvA7d4UpmKryOGa+RgZhs6vGAcp7XknxMdpZ4SSAKc4a0iiCJ
   dAGGDeHV6vIUD6bRiTm34iRGjiVWPske5tUiV/0qf+7KjJaghx+HSLjed
   PJqZRq2bOs+GQdnbBauIovVnv3pOPeXEVW9mrT0MRiM4vzoQiwGEvwD47
   H151o4+TfqIf4v7ZjP1Tb/GUUnqNLdABJ+dZNdk7QQ/GGStStjUuC2kYL
   sfs19kRmv8KKd6MumE934hKbAYV/DKaR1sr/REtH0+fSAcp9JxkM35Lky
   YGeAbZpIyfDsJsshLmXhOFJE9xyaAmKu4GVdMCIwr5BjVdpv4/pSCGGSo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373617954"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373617954"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986684301"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="986684301"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2023 06:40:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3E36B7A4; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 06/10] gpio: pca953x: Utilise temporary variable for struct device
Date:   Fri,  1 Sep 2023 16:40:37 +0300
Message-Id: <20230901134041.1165562-6-andriy.shevchenko@linux.intel.com>
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

We have a temporary variable to keep pointer to struct device.
Utilise it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 99379ee98749..4aa15128c91f 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -779,11 +779,11 @@ static int pca953x_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
+	struct device *dev = &chip->client->dev;
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	if (!(type & IRQ_TYPE_EDGE_BOTH)) {
-		dev_err(&chip->client->dev, "irq %d: unsupported type %d\n",
-			d->irq, type);
+		dev_err(dev, "irq %d: unsupported type %d\n", d->irq, type);
 		return -EINVAL;
 	}
 
@@ -919,7 +919,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	int ret;
 
 	if (dmi_first_match(pca953x_dmi_acpi_irq_info)) {
-		ret = pca953x_acpi_get_irq(&client->dev);
+		ret = pca953x_acpi_get_irq(dev);
 		if (ret > 0)
 			client->irq = ret;
 	}
@@ -957,10 +957,9 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	girq->threaded = true;
 	girq->first = irq_base; /* FIXME: get rid of this */
 
-	ret = devm_request_threaded_irq(&client->dev, client->irq,
-					NULL, pca953x_irq_handler,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&client->dev), chip);
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, pca953x_irq_handler,
+					IRQF_ONESHOT | IRQF_SHARED, dev_name(dev),
+					chip);
 	if (ret)
 		return dev_err_probe(dev, client->irq, "failed to request irq\n");
 
@@ -968,13 +967,13 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 }
 
 #else /* CONFIG_GPIO_PCA953X_IRQ */
-static int pca953x_irq_setup(struct pca953x_chip *chip,
-			     int irq_base)
+static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 {
 	struct i2c_client *client = chip->client;
+	struct device *dev = &client->dev;
 
 	if (client->irq && irq_base != -1 && (chip->driver_data & PCA_INT))
-		dev_warn(&client->dev, "interrupt support not compiled in\n");
+		dev_warn(dev, "interrupt support not compiled in\n");
 
 	return 0;
 }
@@ -1065,11 +1064,11 @@ static int pca953x_probe(struct i2c_client *client)
 	int ret;
 	const struct regmap_config *regmap_config;
 
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
-	pdata = dev_get_platdata(&client->dev);
+	pdata = dev_get_platdata(dev);
 	if (pdata) {
 		irq_base = pdata->irq_base;
 		chip->gpio_start = pdata->gpio_base;
@@ -1086,8 +1085,7 @@ static int pca953x_probe(struct i2c_client *client)
 		 * using "reset" GPIO. Otherwise any of those platform
 		 * must use _DSD method with corresponding property.
 		 */
-		reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
-						     GPIOD_OUT_LOW);
+		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 		if (IS_ERR(reset_gpio))
 			return PTR_ERR(reset_gpio);
 	}
@@ -1106,10 +1104,10 @@ static int pca953x_probe(struct i2c_client *client)
 	pca953x_setup_gpio(chip, chip->driver_data & PCA_GPIO_MASK);
 
 	if (NBANK(chip) > 2 || PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
-		dev_info(&client->dev, "using AI\n");
+		dev_info(dev, "using AI\n");
 		regmap_config = &pca953x_ai_i2c_regmap;
 	} else {
-		dev_info(&client->dev, "using no AI\n");
+		dev_info(dev, "using no AI\n");
 		regmap_config = &pca953x_i2c_regmap;
 	}
 
-- 
2.40.0.1.gaa8946217a0b

