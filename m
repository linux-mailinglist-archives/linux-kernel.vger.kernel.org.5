Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F96C7DB992
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjJ3MIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJ3MHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A7FDA;
        Mon, 30 Oct 2023 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667664; x=1730203664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlO/Nxi27PDJ1XDwDRDGXslxz8DRDC17jyhnCMcvik4=;
  b=JRMg/U3WnurXCZBj3D+Q/mp+BP7/CSZ6NC3Gi5UNJfxlVO/WhEfp1acU
   PP+AGXMhx6f4bbqAQouSPhmRYpdk2JhwQ/DrHqWGaSPnHKvSD/ZDWr+p7
   VbiYDcSd3JUqhV0pNIqXPbWfFvr8KWe2KsEYqaulC8q85FupBcIiZEMya
   w6uFwQmhQ4JeNb/4NgB6qLinlx3TIeo/iyZnwmLBK5/fyhnOoSqTRXlmM
   G6mxdudxNv8UCsTgs8LeODONDt1+p3VzsHUS7ulkOtyy8Xq4vueNgZC7m
   ovIymvRgIx6sFPXVnrhXO9kV5A56GYGnxj6JOOAG9TRE/jBpN/GzgMIfl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107368"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107368"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771404"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771404"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2AF373B8; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 06/17] pinctrl: denverton: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:23 +0200
Message-Id: <20231030120734.2831419-7-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-denverton.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-denverton.c b/drivers/pinctrl/intel/pinctrl-denverton.c
index 562a4f9188e4..666507f54f27 100644
--- a/drivers/pinctrl/intel/pinctrl-denverton.c
+++ b/drivers/pinctrl/intel/pinctrl-denverton.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -249,8 +250,6 @@ static const struct intel_pinctrl_soc_data dnv_soc_data = {
 	.ncommunities = ARRAY_SIZE(dnv_communities),
 };
 
-static INTEL_PINCTRL_PM_OPS(dnv_pinctrl_pm_ops);
-
 static const struct acpi_device_id dnv_pinctrl_acpi_match[] = {
 	{ "INTC3000", (kernel_ulong_t)&dnv_soc_data },
 	{ }
@@ -268,7 +267,7 @@ static struct platform_driver dnv_pinctrl_driver = {
 	.driver = {
 		.name = "denverton-pinctrl",
 		.acpi_match_table = dnv_pinctrl_acpi_match,
-		.pm = &dnv_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 	.id_table = dnv_pinctrl_platform_ids,
 };
-- 
2.40.0.1.gaa8946217a0b

