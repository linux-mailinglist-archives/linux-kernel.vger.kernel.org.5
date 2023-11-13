Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59377E9CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjKMNQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjKMNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:16:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9DD6C;
        Mon, 13 Nov 2023 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699881374; x=1731417374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0W1lXUBGP+iBxAlWICinNyER0ndu/deNSI5T1s1ZuWI=;
  b=UbnIhs5elNDtBzhF84Cix8lCguYE7k+jHZkAjJ3bGViK6+q6FM1tEFYp
   Ifo2zUTTUDfXLECXZVfF1R3LGs/bs4iIqUKUuNq01wf1WCV99qJ5MXrBb
   StF3TlsDv9Z5zSlhn9WF0JR6iqoiTO4IMDC6lxJCyKkLTNNFc6B2e+fHG
   4lXFhv56HFHqR7bkqN04Qgw9jo2mwAMRsoK5NHaGpM5Vw4N8tjlamy6bV
   XzXTgYvKLE17wb4aexiyHwJFeINk5aDvljQ1XFNsswVGJNq3THOM0Pc4z
   89vUdRkUnB+zlkD6YBepCC+9y8vNVvNL8zV/UdtOznn6459PZOtconI/f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="454726902"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="454726902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="5649391"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa002.fm.intel.com with ESMTP; 13 Nov 2023 05:16:12 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/3] gpio: tangier: use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper
Date:   Mon, 13 Nov 2023 18:45:58 +0530
Message-Id: <20231113131600.10828-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231113131600.10828-1-raag.jadav@intel.com>
References: <20231113131600.10828-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper to export pm_ops to
GPIO_TANGIER namespace, so that they can be reused.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpio/gpio-tangier.c | 3 +++
 drivers/gpio/gpio-tangier.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-tangier.c b/drivers/gpio/gpio-tangier.c
index 7ce3eddaed25..52d0868476e1 100644
--- a/drivers/gpio/gpio-tangier.c
+++ b/drivers/gpio/gpio-tangier.c
@@ -19,6 +19,7 @@
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pm.h>
 #include <linux/spinlock.h>
 #include <linux/string_helpers.h>
 #include <linux/types.h>
@@ -531,6 +532,8 @@ int tng_gpio_resume(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(tng_gpio_resume, GPIO_TANGIER);
 
+EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(tng_gpio_pm_ops, tng_gpio_suspend, tng_gpio_resume, GPIO_TANGIER);
+
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
 MODULE_AUTHOR("Raag Jadav <raag.jadav@intel.com>");
diff --git a/drivers/gpio/gpio-tangier.h b/drivers/gpio/gpio-tangier.h
index 16c4f22908fb..333e5f79b908 100644
--- a/drivers/gpio/gpio-tangier.h
+++ b/drivers/gpio/gpio-tangier.h
@@ -13,6 +13,7 @@
 #define _GPIO_TANGIER_H_
 
 #include <linux/gpio/driver.h>
+#include <linux/pm.h>
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
 
@@ -114,4 +115,6 @@ int devm_tng_gpio_probe(struct device *dev, struct tng_gpio *gpio);
 int tng_gpio_suspend(struct device *dev);
 int tng_gpio_resume(struct device *dev);
 
+extern const struct dev_pm_ops tng_gpio_pm_ops;
+
 #endif /* _GPIO_TANGIER_H_ */
-- 
2.17.1

