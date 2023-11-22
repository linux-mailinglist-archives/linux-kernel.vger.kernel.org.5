Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47887F445B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjKVKyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKVKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:54:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0700ED8;
        Wed, 22 Nov 2023 02:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700650453; x=1732186453;
  h=from:to:cc:subject:date:message-id;
  bh=L6bHYCHdpbaSIiykCkw+XvZL0tDlt0dAm6zfnBSOkH4=;
  b=R701NI3FN2a/a53VP7VD5zOpFbAB2cPL4WBcvOlBOrKYcWlfE6rgIfja
   13myN08Xj0sbAP8W09WXVZY7f3bSnXALrBsS+RD717sof98JtMy+jcQwA
   O+DWBV6q6i63ol/HWHp/q9MMa0Qu3TCGyWk7rUNw+5DPqzekrjUVD1u1a
   fc8QNQcxXhaWWZHcF++9mUiG7j3nVJQiybS849k5Ulob4AVkgDH+FSnvk
   xlq0svEzeikqmbhZLv9aj+nxdWPkk0pGuHA2eLB1lv7qHxJbWQ3VGG5qj
   6eG+9OaDzAghZAc0+Ye/kjXr6DTRv1WO5ZuCoc3gxRLSotyH9FuCO5MrO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372207210"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="372207210"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="8393146"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2023 02:54:10 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: intel: use the correct _PM_OPS() export macro
Date:   Wed, 22 Nov 2023 16:24:01 +0530
Message-Id: <20231122105401.11006-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we don't have runtime PM handles here, we should be using
EXPORT_NS_GPL_DEV_SLEEP_PM_OPS() macro, so that the compiler can
discard it in case CONFIG_PM_SLEEP=n.

Fixes: b10a74b5c0c1 ("pinctrl: intel: Provide Intel pin control wide PM ops structure")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 2367c2747a83..d6f29e6faab7 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1879,7 +1879,7 @@ static int intel_pinctrl_resume_noirq(struct device *dev)
 	return 0;
 }
 
-EXPORT_NS_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops, PINCTRL_INTEL) = {
+EXPORT_NS_GPL_DEV_SLEEP_PM_OPS(intel_pinctrl_pm_ops, PINCTRL_INTEL) = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)
 };
 

base-commit: c5860e4a2737a8b29dc426c800d01c5be6aad811
-- 
2.17.1

