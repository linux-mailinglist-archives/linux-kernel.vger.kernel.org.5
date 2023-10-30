Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8577DB99D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjJ3MIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjJ3MHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17937D6;
        Mon, 30 Oct 2023 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667665; x=1730203665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5cdWff1MO3MQZk6AB3MuOmGXf176ljN1rFllbrcQ2s=;
  b=WP70fKgqL8R773CHESXR2CNXEtSJ6+VTBxtSe6mqccG4ogor6k4vjatS
   hdioV+g7vL0+g4uYrGIziY/UYe9iFrTUiGi0cw9ULwAkIE8kw5HwmHzpq
   jcvjg3otL2ChJaIvCEoZcMcSOmpaztyOs5LQB9jg3HqDer8OSExRLGXLK
   YuYXKkAym+lKVgorOmsHJyixelg5jt8naYyVv65dIiemA9wSdjr3BN06n
   6ChS5YlQ39CC31hi28vkYmb9P45RFslIuj/e/cvCMckIp30CUXYyJyPGa
   VXolxpmZBXXOJjOpZJgmy8BBziyni1SpcFMVwA7tc7pkNnpoAZOllBlZF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107381"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107381"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771409"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771409"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75B934A0; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 14/17] pinctrl: meteorlake: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:31 +0200
Message-Id: <20231030120734.2831419-15-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-meteorlake.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-meteorlake.c b/drivers/pinctrl/intel/pinctrl-meteorlake.c
index 7ced2b402dce..cc44890c6699 100644
--- a/drivers/pinctrl/intel/pinctrl-meteorlake.c
+++ b/drivers/pinctrl/intel/pinctrl-meteorlake.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -589,14 +590,12 @@ static const struct acpi_device_id mtl_pinctrl_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, mtl_pinctrl_acpi_match);
 
-static INTEL_PINCTRL_PM_OPS(mtl_pinctrl_pm_ops);
-
 static struct platform_driver mtl_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_hid,
 	.driver = {
 		.name = "meteorlake-pinctrl",
 		.acpi_match_table = mtl_pinctrl_acpi_match,
-		.pm = &mtl_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(mtl_pinctrl_driver);
-- 
2.40.0.1.gaa8946217a0b

