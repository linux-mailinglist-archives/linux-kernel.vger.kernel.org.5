Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2577B10C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjHNGET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjHNGEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:04:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4653129;
        Sun, 13 Aug 2023 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691993045; x=1723529045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zMDA+didh0MVfZqHCFkYIlUXtN0gsB/nuvcifkiqleI=;
  b=gPiLoIRTnhVEFIyyy26o4enRWplUVyJqrqJaUJfS31HOjISVIv4WsIdS
   9+8DjRtWr8DSE3vdqJDXurFNfm2nW8xxwIrwU9t6GPuBc06h8WT11wYB7
   Xm4SFCwLUHw0J/x6SVnXDkjvXa56skQ+VL1FddE8egwER/7ugL8k44qSG
   nJLkNMNbBJFj8rMhrtWNjAse8H7udac4aWsYvfWtzypRtpbxnA3/KqpQ1
   NKy9K5URmJN+liuZ9b7asTqR7FAIxeO0sVOm2seG/ttsn28ZjR9mlzqQw
   BUI5gt6kW+5m1iOzKvEZgEtCIUg8qa0BrR83THpFKkuA6wx23GmS2mM1M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371970750"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="371970750"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 23:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798702908"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="798702908"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2023 23:04:03 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/4] pinctrl: intel: export common pinctrl functions
Date:   Mon, 14 Aug 2023 11:33:08 +0530
Message-Id: <20230814060311.15945-2-raag.jadav@intel.com>
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

Export common pinctrl functions that are used across Intel specific
platform drivers, so that they can be reused.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 30 ++++++++++++++-------------
 drivers/pinctrl/intel/pinctrl-intel.h | 12 +++++++++++
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 64c3e62b4348..4e019c2cb27a 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -107,8 +107,7 @@ struct intel_community_context {
 #define pin_to_padno(c, p)	((p) - (c)->pin_base)
 #define padgroup_offset(g, p)	((p) - (g)->base)
 
-static struct intel_community *intel_get_community(struct intel_pinctrl *pctrl,
-						   unsigned int pin)
+struct intel_community *intel_get_community(struct intel_pinctrl *pctrl, unsigned int pin)
 {
 	struct intel_community *community;
 	int i;
@@ -123,6 +122,7 @@ static struct intel_community *intel_get_community(struct intel_pinctrl *pctrl,
 	dev_warn(pctrl->dev, "failed to find community for pin %u\n", pin);
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(intel_get_community, PINCTRL_INTEL);
 
 static const struct intel_padgroup *
 intel_community_get_padgroup(const struct intel_community *community,
@@ -276,23 +276,24 @@ static bool intel_pad_usable(struct intel_pinctrl *pctrl, unsigned int pin)
 	return intel_pad_owned_by_host(pctrl, pin) && intel_pad_is_unlocked(pctrl, pin);
 }
 
-static int intel_get_groups_count(struct pinctrl_dev *pctldev)
+int intel_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
 	return pctrl->soc->ngroups;
 }
+EXPORT_SYMBOL_NS_GPL(intel_get_groups_count, PINCTRL_INTEL);
 
-static const char *intel_get_group_name(struct pinctrl_dev *pctldev,
-				      unsigned int group)
+const char *intel_get_group_name(struct pinctrl_dev *pctldev, unsigned int group)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
 	return pctrl->soc->groups[group].grp.name;
 }
+EXPORT_SYMBOL_NS_GPL(intel_get_group_name, PINCTRL_INTEL);
 
-static int intel_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
-			      const unsigned int **pins, unsigned int *npins)
+int intel_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
+			 const unsigned int **pins, unsigned int *npins)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
@@ -300,6 +301,7 @@ static int intel_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
 	*npins = pctrl->soc->groups[group].grp.npins;
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_get_group_pins, PINCTRL_INTEL);
 
 static void intel_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 			       unsigned int pin)
@@ -359,25 +361,24 @@ static const struct pinctrl_ops intel_pinctrl_ops = {
 	.pin_dbg_show = intel_pin_dbg_show,
 };
 
-static int intel_get_functions_count(struct pinctrl_dev *pctldev)
+int intel_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
 	return pctrl->soc->nfunctions;
 }
+EXPORT_SYMBOL_NS_GPL(intel_get_functions_count, PINCTRL_INTEL);
 
-static const char *intel_get_function_name(struct pinctrl_dev *pctldev,
-					   unsigned int function)
+const char *intel_get_function_name(struct pinctrl_dev *pctldev, unsigned int function)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
 	return pctrl->soc->functions[function].func.name;
 }
+EXPORT_SYMBOL_NS_GPL(intel_get_function_name, PINCTRL_INTEL);
 
-static int intel_get_function_groups(struct pinctrl_dev *pctldev,
-				     unsigned int function,
-				     const char * const **groups,
-				     unsigned int * const ngroups)
+int intel_get_function_groups(struct pinctrl_dev *pctldev, unsigned int function,
+			      const char * const **groups, unsigned int * const ngroups)
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
@@ -385,6 +386,7 @@ static int intel_get_function_groups(struct pinctrl_dev *pctldev,
 	*ngroups = pctrl->soc->functions[function].func.ngroups;
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_get_function_groups, PINCTRL_INTEL);
 
 static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 				unsigned int function, unsigned int group)
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 1faf2ada480a..cee512f97b56 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -266,4 +266,16 @@ const struct dev_pm_ops _name = {					\
 				      intel_pinctrl_resume_noirq)	\
 }
 
+struct intel_community *intel_get_community(struct intel_pinctrl *pctrl, unsigned int pin);
+
+int intel_get_groups_count(struct pinctrl_dev *pctldev);
+const char *intel_get_group_name(struct pinctrl_dev *pctldev, unsigned int group);
+int intel_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
+			 const unsigned int **pins, unsigned int *npins);
+
+int intel_get_functions_count(struct pinctrl_dev *pctldev);
+const char *intel_get_function_name(struct pinctrl_dev *pctldev, unsigned int function);
+int intel_get_function_groups(struct pinctrl_dev *pctldev, unsigned int function,
+			      const char * const **groups, unsigned int * const ngroups);
+
 #endif /* PINCTRL_INTEL_H */
-- 
2.17.1

