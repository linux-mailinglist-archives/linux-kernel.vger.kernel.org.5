Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFE77B10F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjHNGEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjHNGEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:04:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF851129;
        Sun, 13 Aug 2023 23:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691993053; x=1723529053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BPpmaoshcMt6goKsPUPVpZaxcfTUVVBLgBqsePBBad0=;
  b=je8x6t67Y7ZBiwxk70ZgHjUC83FhQKqo7jfSGuOm6ThXy8+FxB99JkU4
   GRfBtRKjR1t10o9pxHlrJ+/tVP9B5Wnie81Em0lgfHg7L2KFE/3arP+mF
   R25wnCa8ug19KAN+ZdnMF1jcTrzMeAgWOLMF66rCWnjn4pQFW7EZ2wHKS
   Fgo7e1C3aqKXEonMqnWdPKQ3AtHbAMKnXZk7qD5Q8Rh/ASof7Wq0RMKZR
   kiryM+19UzWvQTjjqzWmRMBL+qfhZIdbXEActQEqxlgHAG9ZNkYOMJdjE
   CaJaxyMbRxy2BPwKMPpzkWy7EwjNQz5JOEihTyrVoukC6kANsunjGKJ8I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371970764"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="371970764"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 23:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798702983"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="798702983"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2023 23:04:11 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 4/4] pinctrl: lynxpoint: reuse common functions from pinctrl-intel
Date:   Mon, 14 Aug 2023 11:33:11 +0530
Message-Id: <20230814060311.15945-5-raag.jadav@intel.com>
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
While at it, select pinctrl-intel for Intel Lynxpoint driver.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/Kconfig             |  6 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 86 +++--------------------
 2 files changed, 9 insertions(+), 83 deletions(-)

diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
index eaa45ebfd1c1..f42a83e29b8b 100644
--- a/drivers/pinctrl/intel/Kconfig
+++ b/drivers/pinctrl/intel/Kconfig
@@ -26,11 +26,7 @@ config PINCTRL_CHERRYVIEW
 config PINCTRL_LYNXPOINT
 	tristate "Intel Lynxpoint pinctrl and GPIO driver"
 	depends on ACPI
-	select PINMUX
-	select PINCONF
-	select GENERIC_PINCONF
-	select GPIOLIB
-	select GPIOLIB_IRQCHIP
+	select PINCTRL_INTEL
 	help
 	  Lynxpoint is the PCH of Intel Haswell. This pinctrl driver
 	  provides an interface that allows configuring of PCH pins and
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index cdace55aaeac..780c9ab79d85 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -206,21 +206,6 @@ static const struct intel_pinctrl_soc_data lptlp_soc_data = {
  * IOxAPIC redirection map applies only for gpio 8-10, 13-14, 45-55.
  */
 
-static struct intel_community *lp_get_community(struct intel_pinctrl *lg,
-						unsigned int pin)
-{
-	struct intel_community *comm;
-	int i;
-
-	for (i = 0; i < lg->ncommunities; i++) {
-		comm = &lg->communities[i];
-		if (pin < comm->pin_base + comm->npins && pin >= comm->pin_base)
-			return comm;
-	}
-
-	return NULL;
-}
-
 static void __iomem *lp_gpio_reg(struct gpio_chip *chip, unsigned int offset,
 				 int reg)
 {
@@ -228,7 +213,7 @@ static void __iomem *lp_gpio_reg(struct gpio_chip *chip, unsigned int offset,
 	struct intel_community *comm;
 	int reg_offset;
 
-	comm = lp_get_community(lg, offset);
+	comm = intel_get_community(lg, offset);
 	if (!comm)
 		return NULL;
 
@@ -272,34 +257,6 @@ static bool lp_gpio_ioxapic_use(struct gpio_chip *chip, unsigned int offset)
 	return false;
 }
 
-static int lp_get_groups_count(struct pinctrl_dev *pctldev)
-{
-	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
-
-	return lg->soc->ngroups;
-}
-
-static const char *lp_get_group_name(struct pinctrl_dev *pctldev,
-				     unsigned int selector)
-{
-	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
-
-	return lg->soc->groups[selector].grp.name;
-}
-
-static int lp_get_group_pins(struct pinctrl_dev *pctldev,
-			     unsigned int selector,
-			     const unsigned int **pins,
-			     unsigned int *num_pins)
-{
-	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
-
-	*pins		= lg->soc->groups[selector].grp.pins;
-	*num_pins	= lg->soc->groups[selector].grp.npins;
-
-	return 0;
-}
-
 static void lp_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 			    unsigned int pin)
 {
@@ -323,40 +280,12 @@ static void lp_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 }
 
 static const struct pinctrl_ops lptlp_pinctrl_ops = {
-	.get_groups_count	= lp_get_groups_count,
-	.get_group_name		= lp_get_group_name,
-	.get_group_pins		= lp_get_group_pins,
+	.get_groups_count	= intel_get_groups_count,
+	.get_group_name		= intel_get_group_name,
+	.get_group_pins		= intel_get_group_pins,
 	.pin_dbg_show		= lp_pin_dbg_show,
 };
 
-static int lp_get_functions_count(struct pinctrl_dev *pctldev)
-{
-	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
-
-	return lg->soc->nfunctions;
-}
-
-static const char *lp_get_function_name(struct pinctrl_dev *pctldev,
-					unsigned int selector)
-{
-	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
-
-	return lg->soc->functions[selector].func.name;
-}
-
-static int lp_get_function_groups(struct pinctrl_dev *pctldev,
-				  unsigned int selector,
-				  const char * const **groups,
-				  unsigned int *ngroups)
-{
-	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
-
-	*groups		= lg->soc->functions[selector].func.groups;
-	*ngroups	= lg->soc->functions[selector].func.ngroups;
-
-	return 0;
-}
-
 static int lp_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			     unsigned int function, unsigned int group)
 {
@@ -481,9 +410,9 @@ static int lp_gpio_set_direction(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinmux_ops lptlp_pinmux_ops = {
-	.get_functions_count	= lp_get_functions_count,
-	.get_function_name	= lp_get_function_name,
-	.get_function_groups	= lp_get_function_groups,
+	.get_functions_count	= intel_get_functions_count,
+	.get_function_name	= intel_get_function_name,
+	.get_function_groups	= intel_get_function_groups,
 	.set_mux		= lp_pinmux_set_mux,
 	.gpio_request_enable	= lp_gpio_request_enable,
 	.gpio_disable_free	= lp_gpio_disable_free,
@@ -987,3 +916,4 @@ MODULE_AUTHOR("Andy Shevchenko (Intel)");
 MODULE_DESCRIPTION("Intel Lynxpoint pinctrl driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:lp_gpio");
+MODULE_IMPORT_NS(PINCTRL_INTEL);
-- 
2.17.1

