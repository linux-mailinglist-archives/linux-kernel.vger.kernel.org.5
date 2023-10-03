Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF367B6829
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbjJCLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjJCLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:41:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8374E8E;
        Tue,  3 Oct 2023 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696333269; x=1727869269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6ECANrpp4u5z6HDFw4QXczpMZs1noUZtFRrG2VlLV6g=;
  b=ZLZslXWROapxFILa+DWPs/6zrmLEGjvF3lDbGpYPs5NodvbmIn60kWFz
   Jf+DPKLq/M0u1qj+O3pNM3Naals4ztYhuJuKdEqC7qj0H8cZ0Kb7B6pcA
   fbqtojgVLJbzPxwl9UqbSjaH8SuhcW8szGtKPng59G6n8arfmG8Kp7VMS
   80YU/zkNPN5QpPAsZjiopU/Cec0nkm3ItT24Hc7e9vbOY4L/AnlzrIeIM
   +ZAMGJqsDaAK46lqXEWPxPeOKtwCV2G8rnzzHQD+mLcG1Cz8GIn5H/Np+
   53n3nca/hZ2f4AIbWpm2qzIH3KB4i/EJlcnJOgXYHKG5EsNYucLQ9px99
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1444137"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1444137"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 04:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="786070236"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="786070236"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2023 04:41:00 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/2] pinctrl: lynxpoint: drop runtime PM support
Date:   Tue,  3 Oct 2023 17:10:36 +0530
Message-Id: <20231003114036.27674-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003114036.27674-1-raag.jadav@intel.com>
References: <20231003114036.27674-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Lynxpoint pinctrl device is not attached to acpi_lpss_pm_domain,
runtime PM serves no purpose here. Drop it and switch to pm_sleep_ptr()
as now we only have resume handle in place.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 32 +++--------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index c3732a9f0658..068cfd27f97f 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -337,8 +337,6 @@ static int lp_gpio_request_enable(struct pinctrl_dev *pctldev,
 	unsigned long flags;
 	u32 value;
 
-	pm_runtime_get(lg->dev);
-
 	raw_spin_lock_irqsave(&lg->lock, flags);
 
 	/*
@@ -373,8 +371,6 @@ static void lp_gpio_disable_free(struct pinctrl_dev *pctldev,
 	lp_gpio_disable_input(conf2);
 
 	raw_spin_unlock_irqrestore(&lg->lock, flags);
-
-	pm_runtime_put(lg->dev);
 }
 
 static int lp_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -841,24 +837,6 @@ static int lp_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_enable(dev);
-
-	return 0;
-}
-
-static int lp_gpio_remove(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
-	return 0;
-}
-
-static int lp_gpio_runtime_suspend(struct device *dev)
-{
-	return 0;
-}
-
-static int lp_gpio_runtime_resume(struct device *dev)
-{
 	return 0;
 }
 
@@ -876,10 +854,7 @@ static int lp_gpio_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops lp_gpio_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(NULL, lp_gpio_resume)
-	RUNTIME_PM_OPS(lp_gpio_runtime_suspend, lp_gpio_runtime_resume, NULL)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(lp_gpio_pm_ops, NULL, lp_gpio_resume);
 
 static const struct acpi_device_id lynxpoint_gpio_acpi_match[] = {
 	{ "INT33C7", (kernel_ulong_t)&lptlp_soc_data },
@@ -890,10 +865,9 @@ MODULE_DEVICE_TABLE(acpi, lynxpoint_gpio_acpi_match);
 
 static struct platform_driver lp_gpio_driver = {
 	.probe          = lp_gpio_probe,
-	.remove         = lp_gpio_remove,
 	.driver         = {
 		.name   = "lp_gpio",
-		.pm	= pm_ptr(&lp_gpio_pm_ops),
+		.pm	= pm_sleep_ptr(&lp_gpio_pm_ops),
 		.acpi_match_table = lynxpoint_gpio_acpi_match,
 	},
 };
-- 
2.17.1

