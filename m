Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9886A7B63E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbjJCIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbjJCIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:16:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F42110;
        Tue,  3 Oct 2023 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696320934; x=1727856934;
  h=from:to:cc:subject:date:message-id;
  bh=8IPj628lYH5qp+6t3Y6GHjDxORB0xZJN4BO5loU4DaE=;
  b=NYuxprR9qQf5hOF9VS2GGfdActOyr4XeLUVUeiZx/H249KbDH9OfkpjJ
   n2ucotGwwBJ6g8dh+3DnYe6IExoVnW8RIGm45C9nPcXFjgG4FpGlHVn0M
   fBv6NX/ZJDWHXCzzD/rvMCBH+EMrYXqbPxnHLLLv0SK+BMaJH3UDwDpYB
   Mf7eSonfGXX6ZdB+TTaJtoe9pmstGn7AiuaClQ+XXp0UFc35SI7yCL1Pz
   i5BL6POW4Q4V6Lq8vur6k1pon31D8RoFDPJu6w6vUOrYT+GBo1glfCF3X
   CjbFvfTNJR/uaGchM+DPqJqOr1mg3GV3Y3z5b5n+4S3Ftcy83LWQcWEWo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="469094756"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="469094756"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="786020426"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="786020426"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2023 01:15:31 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/2] pinctrl: baytrail: drop runtime PM support
Date:   Tue,  3 Oct 2023 13:45:18 +0530
Message-Id: <20231003081519.27524-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Baytrail pinctrl device is not attached to acpi_lpss_pm_domain,
runtime PM serves no purpose here. Drop it and switch to pm_sleep_ptr()
as now we only have suspend and resume handles in place.

No functional impact.

TODO:
Consider moving to DEFINE_LATE_DEV_PM_OPS() in the future once we have
enough users to account for its introduction.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index ec76e43527c5..14a61a262be1 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/string_helpers.h>
@@ -722,8 +721,6 @@ static int byt_gpio_request_enable(struct pinctrl_dev *pctl_dev,
 
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
 
-	pm_runtime_get(vg->dev);
-
 	return 0;
 }
 
@@ -734,7 +731,6 @@ static void byt_gpio_disable_free(struct pinctrl_dev *pctl_dev,
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctl_dev);
 
 	byt_gpio_clear_triggering(vg, offset);
-	pm_runtime_put(vg->dev);
 }
 
 static void byt_gpio_direct_irq_check(struct intel_pinctrl *vg,
@@ -1661,7 +1657,6 @@ static int byt_pinctrl_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, vg);
-	pm_runtime_enable(dev);
 
 	return 0;
 }
@@ -1750,26 +1745,15 @@ static int byt_gpio_resume(struct device *dev)
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

