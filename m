Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5EF75663E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGQOV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:21:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23013A1;
        Mon, 17 Jul 2023 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689603712; x=1721139712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cSbqnQ+KJlnBJR+x/ss6MxnkaW9bhGHE3u8QWcW2wjY=;
  b=CS0ddeF4vbH1kCi0ztTsm4tGGaobb5vbJ4pmqXnuFPUACdszBpCJB/uc
   DB5XsNRYrHRSZWCpysil1VsUxYQP/5ZzxzLlu6WvkUYsGS9Or/WWolwsa
   fCSA5zM7eZq7B1xa+YO1d0WlqvWoWws1ZS66rS7gsf2GTP6USj6Go8CuY
   +EaNIoMVrHRogyZZJJWoe/bJbhFRr5qg38z7MOXqevE7IsY82w3AIRFEY
   Khe8q3xR8K47kY7Ok3ET9vPQCQFAZW2PARfUYDLA1OEB07mn0kn15pF44
   9vkPs3XaBO8il7ypTJzocx1I07Jvev57xSSlQpbcDT0q2kVQXj4fGO5b7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432112874"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432112874"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 07:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="717257682"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="717257682"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2023 07:18:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20C72256; Mon, 17 Jul 2023 17:18:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v2 1/3] gpio: bcm-kona: Make driver OF-independent
Date:   Mon, 17 Jul 2023 17:18:43 +0300
Message-Id: <20230717141845.41415-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing in the driver that requires OF APIs,
make the driver OF independent.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/gpio/Kconfig         |  2 +-
 drivers/gpio/gpio-bcm-kona.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 638f0e771105..a70622d32a3b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -191,7 +191,7 @@ config GPIO_RASPBERRYPI_EXP
 
 config GPIO_BCM_KONA
 	bool "Broadcom Kona GPIO"
-	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
+	depends on ARCH_BCM_MOBILE || COMPILE_TEST
 	help
 	  Turn on GPIO support for Broadcom "Kona" chips.
 
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 70770429ba48..0aa7d710509d 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -8,12 +8,13 @@
 
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/io.h>
 #include <linux/gpio/driver.h>
-#include <linux/of_device.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #define BCM_GPIO_PASSWD				0x00a5a501
 #define GPIO_PER_BANK				32
@@ -556,19 +557,12 @@ static void bcm_kona_gpio_reset(struct bcm_kona_gpio *kona_gpio)
 static int bcm_kona_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	struct bcm_kona_gpio_bank *bank;
 	struct bcm_kona_gpio *kona_gpio;
 	struct gpio_chip *chip;
 	int ret;
 	int i;
 
-	match = of_match_device(bcm_kona_gpio_of_match, dev);
-	if (!match) {
-		dev_err(dev, "Failed to find gpio controller\n");
-		return -ENODEV;
-	}
-
 	kona_gpio = devm_kzalloc(dev, sizeof(*kona_gpio), GFP_KERNEL);
 	if (!kona_gpio)
 		return -ENOMEM;
@@ -601,10 +595,10 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 	chip->parent = dev;
 	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
 
-	kona_gpio->irq_domain = irq_domain_add_linear(dev->of_node,
-						      chip->ngpio,
-						      &bcm_kona_irq_ops,
-						      kona_gpio);
+	kona_gpio->irq_domain = irq_domain_create_linear(dev_fwnode(dev),
+							 chip->ngpio,
+							 &bcm_kona_irq_ops,
+							 kona_gpio);
 	if (!kona_gpio->irq_domain) {
 		dev_err(dev, "Couldn't allocate IRQ domain\n");
 		return -ENXIO;
-- 
2.40.0.1.gaa8946217a0b

