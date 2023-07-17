Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C32756A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGQR3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGQR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5AE49;
        Mon, 17 Jul 2023 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614948; x=1721150948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F9KIcHfjcwmjCFthAgRpS39XfNA7at7pJaXPVBuC4kg=;
  b=QWUAm4bkTf+O+dy5waaVyTAutx+EdCSUjBJqqVsaJyxJGbgpatwJR0kM
   zfgoVCmn1Lp+m0nBC5/6bGKo9fuuZwsDOryvSInmaF1JJH8SaEh2TJ/13
   tTFRw7f8epHkcm0D8CqXNthQcQoZmBaLpxY7MHNfCaDvL5lnpe5vAB659
   1mbspXk5lnKpAGkWDcyssnJnDkHV43oaX4PR6UVomLLjG3qwwlc9/Rmqs
   7y1K/rAT0uWbVp4/TnEdF/NlgKQnwwP9y/GttCibfDd6Gj2sdQxPlh2n9
   CSTBB7RR0TeWz/RWz9w4N4AmW3qegAdHgrfgyTryoKqkLRaC1lsv7pa8S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="355926938"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355926938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673604201"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="673604201"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2023 10:28:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37B4B6B9; Mon, 17 Jul 2023 20:28:40 +0300 (EEST)
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
Subject: [PATCH v2 08/10] pinctrl: mvebu: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Mon, 17 Jul 2023 20:28:19 +0300
Message-Id: <20230717172821.62827-9-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 67c6751a6f06..46351c00ee73 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -1013,7 +1013,6 @@ static int armada_37xx_pinctrl_register(struct platform_device *pdev,
 	return 0;
 }
 
-#if defined(CONFIG_PM)
 static int armada_3700_pinctrl_suspend(struct device *dev)
 {
 	struct armada_37xx_pinctrl *info = dev_get_drvdata(dev);
@@ -1107,15 +1106,8 @@ static int armada_3700_pinctrl_resume(struct device *dev)
  * Since pinctrl is an infrastructure module, its resume should be issued prior
  * to other IO drivers.
  */
-static const struct dev_pm_ops armada_3700_pinctrl_pm_ops = {
-	.suspend_noirq = armada_3700_pinctrl_suspend,
-	.resume_noirq = armada_3700_pinctrl_resume,
-};
-
-#define PINCTRL_ARMADA_37XX_DEV_PM_OPS (&armada_3700_pinctrl_pm_ops)
-#else
-#define PINCTRL_ARMADA_37XX_DEV_PM_OPS NULL
-#endif /* CONFIG_PM */
+static DEFINE_NOIRQ_DEV_PM_OPS(armada_3700_pinctrl_pm_ops,
+			       armada_3700_pinctrl_suspend, armada_3700_pinctrl_resume);
 
 static const struct of_device_id armada_37xx_pinctrl_of_match[] = {
 	{
@@ -1182,7 +1174,7 @@ static struct platform_driver armada_37xx_pinctrl_driver = {
 	.driver = {
 		.name = "armada-37xx-pinctrl",
 		.of_match_table = armada_37xx_pinctrl_of_match,
-		.pm = PINCTRL_ARMADA_37XX_DEV_PM_OPS,
+		.pm = pm_sleep_ptr(&armada_3700_pinctrl_pm_ops),
 	},
 };
 
-- 
2.40.0.1.gaa8946217a0b

