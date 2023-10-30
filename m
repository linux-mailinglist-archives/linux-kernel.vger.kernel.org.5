Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C257DB98E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjJ3MH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjJ3MHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EDDD9;
        Mon, 30 Oct 2023 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667664; x=1730203664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ES3oJZhvoo6tpDdEQrliS51CVnx3gk7DgNepd+DgHrw=;
  b=dz+WrMtcu+vpg+n7uB64uBl5lj0o/7oZOxqNPY1tIXxzxrfI6gO1lX3L
   7WvM/aIS7ZlkqFTR5+F6Jtspb8mB6rr2Q9KMhJ4jhG/knu6je6qvHAlkT
   nI95UyZzEeJcbvy4IsPodMpJludHkks519X4mSaZNLL/XgfkFqNBnrLtU
   qVUXxTR/iU6L1Lxtn5ehtjfKfw9E+bh6mjNEBZZn/zsYVj/FwV8gbIJ1w
   3X3h2akarqpxPdlaAGPG+eGeK6M9/Q5FzcqSo4plUmt9hGSAbh0vM93pu
   BLZ0aRwZcjN3Ft6bWDM4jsvkG+MZAKw0cupG/8mrDJR3yOQaYzMt2TuTo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6691286"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6691286"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="826036529"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826036529"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 05:07:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 16DE9304; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 05/17] pinctrl: cedarfork: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:22 +0200
Message-Id: <20231030120734.2831419-6-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-cedarfork.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cedarfork.c b/drivers/pinctrl/intel/pinctrl-cedarfork.c
index a20465eb2dc6..48af8930dd1f 100644
--- a/drivers/pinctrl/intel/pinctrl-cedarfork.c
+++ b/drivers/pinctrl/intel/pinctrl-cedarfork.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -319,8 +320,6 @@ static const struct intel_pinctrl_soc_data cdf_soc_data = {
 	.ncommunities = ARRAY_SIZE(cdf_communities),
 };
 
-static INTEL_PINCTRL_PM_OPS(cdf_pinctrl_pm_ops);
-
 static const struct acpi_device_id cdf_pinctrl_acpi_match[] = {
 	{ "INTC3001", (kernel_ulong_t)&cdf_soc_data },
 	{ }
@@ -332,7 +331,7 @@ static struct platform_driver cdf_pinctrl_driver = {
 	.driver = {
 		.name = "cedarfork-pinctrl",
 		.acpi_match_table = cdf_pinctrl_acpi_match,
-		.pm = &cdf_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 
-- 
2.40.0.1.gaa8946217a0b

