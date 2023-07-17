Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64590756A91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGQRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGQRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:30:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E2519B1;
        Mon, 17 Jul 2023 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614987; x=1721150987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WzIdieUjIIIcjkcN9h2WZt4G3gLcBLgRvdk3paxMv94=;
  b=hJrFayGSOoqabwbJUBYQrIG77bKHR6P/OfRciOA9rMcFRsWXM1wbqOqN
   RQbS1ZqGHRs4NH1X9lTJTsNSjSIUQZWf/p3paHZcDcS1X2vLhv1tkuZeh
   g30k6q8cm8wB6n5K4XHXyhHzOCOFYzUplPVmUm3DlTeFE+97YNZRrCbNy
   utjJmj4D4sGEP9hPRB7UJ8LJfNm/iNhUjbNYBA0UlDg2UmTHfOycdudVe
   YlOJO4OFaHQPXeVKqJBbeJqMh0gOrIXb5AHYMzJ4tHWtyasZDn8v3GnJ5
   7svAGBzuLsT3hBuUP1ditS/0P5POsuBAz10DZY7FGK98H/+9eJyA6kSgw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="350854514"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="350854514"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="813426656"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="813426656"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 10:28:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D2A65FC; Mon, 17 Jul 2023 20:28:40 +0300 (EEST)
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
Subject: [PATCH v2 04/10] pinctrl: intel: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Mon, 17 Jul 2023 20:28:15 +0300
Message-Id: <20230717172821.62827-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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
 drivers/pinctrl/intel/pinctrl-intel.c | 5 +----
 drivers/pinctrl/intel/pinctrl-intel.h | 9 ++-------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 64c3e62b4348..40e45c4889ee 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -929,7 +929,7 @@ static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned int offset,
  *
  * Return: a GPIO offset, or negative error code if translation can't be done.
  */
-static __maybe_unused int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
+static int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
 {
 	const struct intel_community *community;
 	const struct intel_padgroup *padgrp;
@@ -1488,7 +1488,6 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
 	if (!communities)
 		return -ENOMEM;
 
-
 	for (i = 0; i < pctrl->ncommunities; i++) {
 		struct intel_community *community = &pctrl->communities[i];
 		u32 *intmask, *hostown;
@@ -1712,7 +1711,6 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 }
 EXPORT_SYMBOL_GPL(intel_pinctrl_get_soc_data);
 
-#ifdef CONFIG_PM_SLEEP
 static bool __intel_gpio_is_direct_irq(u32 value)
 {
 	return (value & PADCFG0_GPIROUTIOXAPIC) && (value & PADCFG0_GPIOTXDIS) &&
@@ -1913,7 +1911,6 @@ int intel_pinctrl_resume_noirq(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
-#endif
 
 MODULE_AUTHOR("Mathias Nyman <mathias.nyman@linux.intel.com>");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 1faf2ada480a..65b1699a2ed5 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -255,15 +255,10 @@ struct intel_pinctrl {
 int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
 int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
 
-#ifdef CONFIG_PM_SLEEP
 int intel_pinctrl_suspend_noirq(struct device *dev);
 int intel_pinctrl_resume_noirq(struct device *dev);
-#endif
 
-#define INTEL_PINCTRL_PM_OPS(_name)					\
-const struct dev_pm_ops _name = {					\
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq,	\
-				      intel_pinctrl_resume_noirq)	\
-}
+#define INTEL_PINCTRL_PM_OPS(_name)								\
+	DEFINE_NOIRQ_DEV_PM_OPS(_name, intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)
 
 #endif /* PINCTRL_INTEL_H */
-- 
2.40.0.1.gaa8946217a0b

