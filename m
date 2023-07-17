Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DF756A63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGQR3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGQR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2621720;
        Mon, 17 Jul 2023 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614943; x=1721150943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A3AvUzx2s49E3LPXDYOtdQtMjBaIlG55+jTFghfeQJI=;
  b=h+/Sv9mjS6ZUK0QhqRuq0Ro9lGFrDR6OTAU0FGWHP2AqpoKho/MBMme5
   qJGPml4r8z/gupi/Plhh9b21yMvq0LfD8/PPfFEFWKNeYhs2GIXETG9+W
   L/A1oyGK9mRoXhkNemMIJTAkDyLsLp57eUyj7n9IYp3YcZ9vch4xSJxeL
   FDwPN908E6GlpR5BO9EJpzqSDUMP9JWopzlNwTEPo9HqlRF0wruda9gBg
   TMgtsmZzRH7ziefbwcy6FD+nZF1JhcevgRG9VXFTEso/xnr3tOErfB8Ne
   rgJndV921veHRHO1tnWmuR8oN3bi1UuoY6ZQ0zeW9q3cZ4a+jrNFW3Zqc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="355926889"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355926889"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673604146"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="673604146"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2023 10:28:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7315370; Mon, 17 Jul 2023 20:28:39 +0300 (EEST)
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
Subject: [PATCH v2 02/10] pinctrl: baytrail: Make use of pm_ptr()
Date:   Mon, 17 Jul 2023 20:28:13 +0300
Message-Id: <20230717172821.62827-3-andriy.shevchenko@linux.intel.com>
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

Cleaning up the driver to use pm_ptr() and *_PM_OPS() macros that
make it simpler and allows the compiler to remove those functions
if built without CONFIG_PM and CONFIG_PM_SLEEP support.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 27aef62fc7c0..66aabac6be9c 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1733,7 +1733,6 @@ static int byt_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int byt_gpio_suspend(struct device *dev)
 {
 	struct intel_pinctrl *vg = dev_get_drvdata(dev);
@@ -1817,9 +1816,7 @@ static int byt_gpio_resume(struct device *dev)
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int byt_gpio_runtime_suspend(struct device *dev)
 {
 	return 0;
@@ -1829,19 +1826,17 @@ static int byt_gpio_runtime_resume(struct device *dev)
 {
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops byt_gpio_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(byt_gpio_suspend, byt_gpio_resume)
-	SET_RUNTIME_PM_OPS(byt_gpio_runtime_suspend, byt_gpio_runtime_resume,
-			   NULL)
+	LATE_SYSTEM_SLEEP_PM_OPS(byt_gpio_suspend, byt_gpio_resume)
+	RUNTIME_PM_OPS(byt_gpio_runtime_suspend, byt_gpio_runtime_resume, NULL)
 };
 
 static struct platform_driver byt_gpio_driver = {
 	.probe          = byt_pinctrl_probe,
 	.driver         = {
 		.name			= "byt_gpio",
-		.pm			= &byt_gpio_pm_ops,
+		.pm			= pm_ptr(&byt_gpio_pm_ops),
 		.acpi_match_table	= byt_gpio_acpi_match,
 		.suppress_bind_attrs	= true,
 	},
-- 
2.40.0.1.gaa8946217a0b

