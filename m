Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8177B10D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjHNGEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjHNGEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:04:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678E129;
        Sun, 13 Aug 2023 23:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691993049; x=1723529049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WcdGtChIm1EcfRxknsGqjMYwaa75wWP0SVoFIOs0nSI=;
  b=k4SiMj6lkVCqQoowyNLmbVjWTuN2TO2DmWY6CUETYfJDERqMsqKYnsJm
   aw6AXg1ng5W0f5ts6dIHWjWdW9eN1LNsZW8t7mzAck2qgumJ/wbgR1Jy8
   OjAFpbSF6YbQXQvdIHx6r+nOlDxbAtzRztK30B83c2H8R4dpXYYESjKS6
   YqiKxhBF4ctjSk9yL2VbmPqWrpapRYS9Xo25PMwqsVemovuYNBPT0BvEg
   eSYsKTD5zJkwdIDCK5B7kWjn+G+3Hqx2wRt/HQMGQadIKsVmHZkLtwbUU
   TMfi7Jb0xwUYZEpVhZiSN0yWIvDHlDC5p0uhuPXxRO+KHxI6rCqmDFd2F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371970755"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="371970755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 23:04:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798702943"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="798702943"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2023 23:04:05 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/4] pinctrl: baytrail: reuse common functions from pinctrl-intel
Date:   Mon, 14 Aug 2023 11:33:09 +0530
Message-Id: <20230814060311.15945-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814060311.15945-1-raag.jadav@intel.com>
References: <20230814060311.15945-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse common functions from pinctrl-intel driver.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 90 +++---------------------
 1 file changed, 11 insertions(+), 79 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 02ab5fd7cbd5..85f1aea2ca89 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -551,25 +552,10 @@ static const struct intel_pinctrl_soc_data *byt_soc_data[] = {
 
 static DEFINE_RAW_SPINLOCK(byt_lock);
 
-static struct intel_community *byt_get_community(struct intel_pinctrl *vg,
-						 unsigned int pin)
-{
-	struct intel_community *comm;
-	int i;
-
-	for (i = 0; i < vg->ncommunities; i++) {
-		comm = vg->communities + i;
-		if (pin < comm->pin_base + comm->npins && pin >= comm->pin_base)
-			return comm;
-	}
-
-	return NULL;
-}
-
 static void __iomem *byt_gpio_reg(struct intel_pinctrl *vg, unsigned int offset,
 				  int reg)
 {
-	struct intel_community *comm = byt_get_community(vg, offset);
+	struct intel_community *comm = intel_get_community(vg, offset);
 	u32 reg_offset;
 
 	if (!comm)
@@ -591,68 +577,12 @@ static void __iomem *byt_gpio_reg(struct intel_pinctrl *vg, unsigned int offset,
 	return comm->pad_regs + reg_offset + reg;
 }
 
-static int byt_get_groups_count(struct pinctrl_dev *pctldev)
-{
-	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
-
-	return vg->soc->ngroups;
-}
-
-static const char *byt_get_group_name(struct pinctrl_dev *pctldev,
-				      unsigned int selector)
-{
-	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
-
-	return vg->soc->groups[selector].grp.name;
-}
-
-static int byt_get_group_pins(struct pinctrl_dev *pctldev,
-			      unsigned int selector,
-			      const unsigned int **pins,
-			      unsigned int *num_pins)
-{
-	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
-
-	*pins		= vg->soc->groups[selector].grp.pins;
-	*num_pins	= vg->soc->groups[selector].grp.npins;
-
-	return 0;
-}
-
 static const struct pinctrl_ops byt_pinctrl_ops = {
-	.get_groups_count	= byt_get_groups_count,
-	.get_group_name		= byt_get_group_name,
-	.get_group_pins		= byt_get_group_pins,
+	.get_groups_count	= intel_get_groups_count,
+	.get_group_name		= intel_get_group_name,
+	.get_group_pins		= intel_get_group_pins,
 };
 
-static int byt_get_functions_count(struct pinctrl_dev *pctldev)
-{
-	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
-
-	return vg->soc->nfunctions;
-}
-
-static const char *byt_get_function_name(struct pinctrl_dev *pctldev,
-					 unsigned int selector)
-{
-	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
-
-	return vg->soc->functions[selector].func.name;
-}
-
-static int byt_get_function_groups(struct pinctrl_dev *pctldev,
-				   unsigned int selector,
-				   const char * const **groups,
-				   unsigned int *ngroups)
-{
-	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
-
-	*groups		= vg->soc->functions[selector].func.groups;
-	*ngroups	= vg->soc->functions[selector].func.ngroups;
-
-	return 0;
-}
-
 static void byt_set_group_simple_mux(struct intel_pinctrl *vg,
 				     const struct intel_pingroup group,
 				     unsigned int func)
@@ -851,9 +781,9 @@ static int byt_gpio_set_direction(struct pinctrl_dev *pctl_dev,
 }
 
 static const struct pinmux_ops byt_pinmux_ops = {
-	.get_functions_count	= byt_get_functions_count,
-	.get_function_name	= byt_get_function_name,
-	.get_function_groups	= byt_get_function_groups,
+	.get_functions_count	= intel_get_functions_count,
+	.get_function_name	= intel_get_function_name,
+	.get_function_groups	= intel_get_function_groups,
 	.set_mux		= byt_set_mux,
 	.gpio_request_enable	= byt_gpio_request_enable,
 	.gpio_disable_free	= byt_gpio_disable_free,
@@ -1261,7 +1191,7 @@ static void byt_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		val = readl(val_reg);
 		raw_spin_unlock_irqrestore(&byt_lock, flags);
 
-		comm = byt_get_community(vg, pin);
+		comm = intel_get_community(vg, pin);
 		if (!comm) {
 			seq_printf(s, "Pin %i: can't retrieve community\n", pin);
 			continue;
@@ -1848,3 +1778,5 @@ static int __init byt_gpio_init(void)
 	return platform_driver_register(&byt_gpio_driver);
 }
 subsys_initcall(byt_gpio_init);
+
+MODULE_IMPORT_NS(PINCTRL_INTEL);
-- 
2.17.1

