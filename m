Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F437DB987
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjJ3MHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjJ3MHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756EC6;
        Mon, 30 Oct 2023 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667662; x=1730203662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbL/iEqsNQDONV8MfXjxRIG+HFA+vk2CmMB4h+Mspus=;
  b=bzhmOLB95E+2iGN+Ol1Acv8H02R6H5YbQ+dCWa80bZFK8cuU8vpMkwT2
   ZbL7NIy303pJzEAr4FGhFyv500db34/rHg09lIy0lD4e35wmuqXZifpdV
   NrVdDhAcmPUIP7dd0zwO6buoJJN2dBloQhgG21rcCCBzz8J7XIHcuJqlO
   A3MttddKzPfVCe3jRbSshSt9C/sbHyVvHuoiEm5CqGv3U1lpmwKWqZwVb
   VpUo97KGOkJO93nNfYjs4fahlv0/9OnniItijnDC250TUMIm6Fr6blYg/
   7BILYRcKA/B7ALIBWE/cRaMJMTvymTV2Hf/h8jQjyILi84SUMKKXeYtEB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107341"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107341"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771401"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E76D4330; Mon, 30 Oct 2023 14:07:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 02/17] pinctrl: alderlake: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:19 +0200
Message-Id: <20231030120734.2831419-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main driver conditionally exports the PM ops structure.
Switch this driver to use it instead of customly wrapped one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-alderlake.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-alderlake.c b/drivers/pinctrl/intel/pinctrl-alderlake.c
index 4a37dc273d63..7d9948e5f422 100644
--- a/drivers/pinctrl/intel/pinctrl-alderlake.c
+++ b/drivers/pinctrl/intel/pinctrl-alderlake.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -733,14 +734,12 @@ static const struct acpi_device_id adl_pinctrl_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, adl_pinctrl_acpi_match);
 
-static INTEL_PINCTRL_PM_OPS(adl_pinctrl_pm_ops);
-
 static struct platform_driver adl_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_hid,
 	.driver = {
 		.name = "alderlake-pinctrl",
 		.acpi_match_table = adl_pinctrl_acpi_match,
-		.pm = &adl_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(adl_pinctrl_driver);
-- 
2.40.0.1.gaa8946217a0b

