Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EF277B10E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjHNGEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjHNGEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:04:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49D129;
        Sun, 13 Aug 2023 23:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691993051; x=1723529051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dNS6n8ZSNCyYDSi15UaC1jDhjYzXiYjvjoZeqmbL/X8=;
  b=fBFmYCTxEIzhDRH8P2SyvNkiIGPTX2PzCr9xI1OVUk0PIi7O+fDq05u4
   EB2BKWWT5IBz+pYQcaogoHqGiC8zB/LZVD6WVImYnCakpZPPr28TW9uCp
   hIHSR+Yyd0kqGp8g4XUgGEM0lvFLn4S7BO+z7YSzRTr+5Zp0sm/42EqY1
   Yd3fMPQYlhLB7UAhWUkguFoKZ/gqoYDgAiPwjXjgVx78REH6zhuyxFM+T
   fgStJ4aMTgmdApdlkGR8FSB9FLqOXjjynHi0fdy+0/ih8NVXSa0haXTIz
   ufpMYWJYVo+sQgW7tkSJF1QpBJgAdwgQRRfBT15ned19q9le4bCdqHGpu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371970761"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="371970761"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 23:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798702966"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="798702966"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2023 23:04:08 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/4] pinctrl: cherryview: reuse common functions from pinctrl-intel
Date:   Mon, 14 Aug 2023 11:33:10 +0530
Message-Id: <20230814060311.15945-4-raag.jadav@intel.com>
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
 drivers/pinctrl/intel/pinctrl-cherryview.c | 69 +++-------------------
 1 file changed, 9 insertions(+), 60 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index eee0f9bc3d32..7bde3316addf 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -617,31 +617,6 @@ static bool chv_pad_locked(struct intel_pinctrl *pctrl, unsigned int offset)
 	return chv_readl(pctrl, offset, CHV_PADCTRL1) & CHV_PADCTRL1_CFGLOCK;
 }
 
-static int chv_get_groups_count(struct pinctrl_dev *pctldev)
-{
-	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->ngroups;
-}
-
-static const char *chv_get_group_name(struct pinctrl_dev *pctldev,
-				      unsigned int group)
-{
-	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->groups[group].grp.name;
-}
-
-static int chv_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
-			      const unsigned int **pins, unsigned int *npins)
-{
-	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	*pins = pctrl->soc->groups[group].grp.pins;
-	*npins = pctrl->soc->groups[group].grp.npins;
-	return 0;
-}
-
 static void chv_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 			     unsigned int offset)
 {
@@ -676,39 +651,12 @@ static void chv_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 }
 
 static const struct pinctrl_ops chv_pinctrl_ops = {
-	.get_groups_count = chv_get_groups_count,
-	.get_group_name = chv_get_group_name,
-	.get_group_pins = chv_get_group_pins,
+	.get_groups_count = intel_get_groups_count,
+	.get_group_name = intel_get_group_name,
+	.get_group_pins = intel_get_group_pins,
 	.pin_dbg_show = chv_pin_dbg_show,
 };
 
-static int chv_get_functions_count(struct pinctrl_dev *pctldev)
-{
-	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->nfunctions;
-}
-
-static const char *chv_get_function_name(struct pinctrl_dev *pctldev,
-					 unsigned int function)
-{
-	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->functions[function].func.name;
-}
-
-static int chv_get_function_groups(struct pinctrl_dev *pctldev,
-				   unsigned int function,
-				   const char * const **groups,
-				   unsigned int * const ngroups)
-{
-	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	*groups = pctrl->soc->functions[function].func.groups;
-	*ngroups = pctrl->soc->functions[function].func.ngroups;
-	return 0;
-}
-
 static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			      unsigned int function, unsigned int group)
 {
@@ -884,9 +832,9 @@ static int chv_gpio_set_direction(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinmux_ops chv_pinmux_ops = {
-	.get_functions_count = chv_get_functions_count,
-	.get_function_name = chv_get_function_name,
-	.get_function_groups = chv_get_function_groups,
+	.get_functions_count = intel_get_functions_count,
+	.get_function_name = intel_get_function_name,
+	.get_function_groups = intel_get_function_groups,
 	.set_mux = chv_pinmux_set_mux,
 	.gpio_request_enable = chv_gpio_request_enable,
 	.gpio_disable_free = chv_gpio_disable_free,
@@ -1118,7 +1066,7 @@ static int chv_config_group_get(struct pinctrl_dev *pctldev,
 	unsigned int npins;
 	int ret;
 
-	ret = chv_get_group_pins(pctldev, group, &pins, &npins);
+	ret = intel_get_group_pins(pctldev, group, &pins, &npins);
 	if (ret)
 		return ret;
 
@@ -1137,7 +1085,7 @@ static int chv_config_group_set(struct pinctrl_dev *pctldev,
 	unsigned int npins;
 	int i, ret;
 
-	ret = chv_get_group_pins(pctldev, group, &pins, &npins);
+	ret = intel_get_group_pins(pctldev, group, &pins, &npins);
 	if (ret)
 		return ret;
 
@@ -1915,3 +1863,4 @@ module_exit(chv_pinctrl_exit);
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel Cherryview/Braswell pinctrl driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PINCTRL_INTEL);
-- 
2.17.1

