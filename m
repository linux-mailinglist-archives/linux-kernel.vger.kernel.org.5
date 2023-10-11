Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1007C4AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbjJKGmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbjJKGmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:42:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A431A7;
        Tue, 10 Oct 2023 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697006553; x=1728542553;
  h=from:to:cc:subject:date:message-id;
  bh=wvu3qxM6087nS4U3FuNGcwYjdnQTGoTihWl4X0Zrzk4=;
  b=gEPpJQ2LB6j6y+3HjyPxwuF4relYS76N87L2F7gOU0NzoJxMuQXERPxJ
   7a85ScuIrGEZw02V7qQ5SlyC7n+B9By4QSzlxCl2H2v8qBYj13ST/fdhy
   WHidQ8fLpNZUXncFpVK/9QjDL+Mh1d86RUBE1D/QgHPedaJtPshJzpDSe
   bhp2VQcdokKT066QXdJfaW+OFB7Y9PCuPWFD0sQs4TrVKvGRvD6D1GBHw
   EUrD+YRT+I1lcLF+KnbhMCnPO1wjcb7EZGvPC+B+Z77Mx4KR3uvNuys1J
   GVEN9hlvPe+zpGSejzjRNxfS0dv6sXWQUwQ5DF2LkJAQENn3NK8nHrH7x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369656446"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369656446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="870025075"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="870025075"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2023 23:42:30 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: intel: fetch community only when we need it
Date:   Wed, 11 Oct 2023 12:12:18 +0530
Message-Id: <20231011064218.19247-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We check community features only in case PIN_CONFIG_BIAS_PULL_DOWN while
setting/getting pad termination. No need to fetch the community otherwise.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index f9155d94a830..9731a3acb23c 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -534,11 +534,9 @@ static const struct pinmux_ops intel_pinmux_ops = {
 static int intel_config_get_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 				 enum pin_config_param param, u32 *arg)
 {
-	const struct intel_community *community;
 	void __iomem *padcfg1;
 	u32 value, term;
 
-	community = intel_get_community(pctrl, pin);
 	padcfg1 = intel_get_padcfg(pctrl, pin, PADCFG1);
 
 	scoped_guard(raw_spinlock_irqsave, &pctrl->lock)
@@ -576,7 +574,9 @@ static int intel_config_get_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 
 		break;
 
-	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_BIAS_PULL_DOWN: {
+		const struct intel_community *community = intel_get_community(pctrl, pin);
+
 		if (!term || value & PADCFG1_TERM_UP)
 			return -EINVAL;
 
@@ -603,6 +603,7 @@ static int intel_config_get_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		}
 
 		break;
+	}
 
 	default:
 		return -EINVAL;
@@ -673,7 +674,6 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 {
 	unsigned int param = pinconf_to_config_param(config);
 	unsigned int arg = pinconf_to_config_argument(config);
-	const struct intel_community *community;
 	u32 term = 0, up = 0, value;
 	void __iomem *padcfg1;
 
@@ -709,8 +709,8 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		up = PADCFG1_TERM_UP;
 		break;
 
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-		community = intel_get_community(pctrl, pin);
+	case PIN_CONFIG_BIAS_PULL_DOWN: {
+		const struct intel_community *community = intel_get_community(pctrl, pin);
 
 		switch (arg) {
 		case 20000:
@@ -737,6 +737,7 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		}
 
 		break;
+	}
 
 	default:
 		return -EINVAL;

base-commit: 55176feaa4d8f7d07005c6199d7843bc2991773d
-- 
2.17.1

