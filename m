Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1972B756A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGQRaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGQR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD8C172C;
        Mon, 17 Jul 2023 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614972; x=1721150972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwITHSBVrDyfYa+oKiF5RDbSxhBhmfNuKbxoQ4tvU/c=;
  b=HdQDqBFYiZGGrmrJnq66emuqCjoX9KjIR+cwPI25LzOsdNdoUteBcONZ
   Db3sV9Chv86gFY/hVUI7O/Rot/S01Xsqg7WhiLbDrv9h3VLlT7EZuGD23
   Yh2OfjbXdTC9jjMPS9n2IKDcA+d/qCiJj5ZmuVSRabjnc2MXg9+REv9k/
   LlNa5MhYHoI7jFDPBk9wPQSrbX+uCpCz2vM5yTmMvhwj+ltvrj9G5mkrC
   3jodeg64zx4ky6Zpuf7Ft2LJ8rjyPrrt5IWeeUqci6C8XNxerwna3L4g/
   2/JXKo4kI17+HTcX++83xzuc9VZbF72UZ14FA4vMf3H8dCGSfvpbG2zLP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="355927001"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355927001"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673604213"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="673604213"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2023 10:28:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 22B3869A; Mon, 17 Jul 2023 20:28:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2 06/10] pinctrl: at91: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Mon, 17 Jul 2023 20:28:17 +0300
Message-Id: <20230717172821.62827-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pm.h provides a helper for system no-IRQ PM callbacks,
switch the driver to use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-at91.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 39956d821ad7..608f55c5ba5f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1657,7 +1657,7 @@ static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
 	return 0;
 }
 
-static int __maybe_unused at91_gpio_suspend(struct device *dev)
+static int at91_gpio_suspend(struct device *dev)
 {
 	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
 	void __iomem *pio = at91_chip->regbase;
@@ -1675,7 +1675,7 @@ static int __maybe_unused at91_gpio_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused at91_gpio_resume(struct device *dev)
+static int at91_gpio_resume(struct device *dev)
 {
 	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
 	void __iomem *pio = at91_chip->regbase;
@@ -1903,15 +1903,13 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct dev_pm_ops at91_gpio_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(at91_gpio_suspend, at91_gpio_resume)
-};
+static DEFINE_NOIRQ_DEV_PM_OPS(at91_gpio_pm_ops, at91_gpio_suspend, at91_gpio_resume);
 
 static struct platform_driver at91_gpio_driver = {
 	.driver = {
 		.name = "gpio-at91",
 		.of_match_table = at91_gpio_of_match,
-		.pm = pm_ptr(&at91_gpio_pm_ops),
+		.pm = pm_sleep_ptr(&at91_gpio_pm_ops),
 	},
 	.probe = at91_gpio_probe,
 };
-- 
2.40.0.1.gaa8946217a0b

