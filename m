Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5F7B6828
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbjJCLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbjJCLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:41:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE439B;
        Tue,  3 Oct 2023 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696333268; x=1727869268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0oH2WuMFS3hMNwVP0Fyc9/MWBSTPyzuobdreAreUTUI=;
  b=NuAwp0gwZNL4JipB8T1y9FfU9vmS42Z1mKerbLcSRBnuyrC/JE8at/bk
   R1qT/nv0DC1eO8K7YfIYuytB6vSxkyuIaglDbWoOq+zMxgoRlNWWDdd20
   p3VVAHnpAjhOvmtFvU4/cV/7LsVKdRDiLjJdECZyDkuPfg1dyUqstcHoS
   zsGeIWKtacVnrCWIeyPjnS0HeVuEF/OZOMljUetj80mPduBo8RNTHJTzO
   +am2M9X0kGbYrFVDc+wIWKChzVJ5xHgdtpty9lSGxqWxBJ+j/yu7MZDYu
   DRd1G4sg6FuLqAxSv87ciX+VmjAZIZgOYx/G3B2uPudOknvg1HUyvobqc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1444124"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1444124"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 04:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="786070230"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="786070230"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2023 04:40:56 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/2] pinctrl: baytrail: drop runtime PM support
Date:   Tue,  3 Oct 2023 17:10:35 +0530
Message-Id: <20231003114036.27674-2-raag.jadav@intel.com>
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

Since Baytrail pinctrl device is not attached to acpi_lpss_pm_domain,
runtime PM serves no purpose here. Drop it and switch to pm_sleep_ptr()
as now we only have suspend and resume handles in place.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index ec76e43527c5..c9a9bc594c63 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
+#include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/string_helpers.h>
@@ -722,8 +722,6 @@ static int byt_gpio_request_enable(struct pinctrl_dev *pctl_dev,
 
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
 
-	pm_runtime_get(vg->dev);
-
 	return 0;
 }
 
@@ -734,7 +732,6 @@ static void byt_gpio_disable_free(struct pinctrl_dev *pctl_dev,
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctl_dev);
 
 	byt_gpio_clear_triggering(vg, offset);
-	pm_runtime_put(vg->dev);
 }
 
 static void byt_gpio_direct_irq_check(struct intel_pinctrl *vg,
@@ -1661,7 +1658,6 @@ static int byt_pinctrl_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, vg);
-	pm_runtime_enable(dev);
 
 	return 0;
 }
@@ -1750,26 +1746,15 @@ static int byt_gpio_resume(struct device *dev)
 	return 0;
 }
 
-static int byt_gpio_runtime_suspend(struct device *dev)
-{
-	return 0;
-}
-
-static int byt_gpio_runtime_resume(struct device *dev)
-{
-	return 0;
-}
-
 static const struct dev_pm_ops byt_gpio_pm_ops = {
 	LATE_SYSTEM_SLEEP_PM_OPS(byt_gpio_suspend, byt_gpio_resume)
-	RUNTIME_PM_OPS(byt_gpio_runtime_suspend, byt_gpio_runtime_resume, NULL)
 };
 
 static struct platform_driver byt_gpio_driver = {
 	.probe          = byt_pinctrl_probe,
 	.driver         = {
 		.name			= "byt_gpio",
-		.pm			= pm_ptr(&byt_gpio_pm_ops),
+		.pm			= pm_sleep_ptr(&byt_gpio_pm_ops),
 		.acpi_match_table	= byt_gpio_acpi_match,
 		.suppress_bind_attrs	= true,
 	},
-- 
2.17.1

