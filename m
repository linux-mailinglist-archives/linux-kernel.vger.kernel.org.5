Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8127DB98D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjJ3MHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjJ3MHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC11FC6;
        Mon, 30 Oct 2023 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667663; x=1730203663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kaMTYelFwgGuSlV0Gv80EqaUluoFfXrYzjdVi1fzCJw=;
  b=KhsQJ0tICN8wQ0xd69h3SgzUpMLcg2KaKou/eLJwkO52U96aRDgPl6rK
   vhphdD0FDt9tlADKfyKl+9GWv4dusmw7cpX0WHpk0gzXzVueZy+nBFINL
   KEOBqnnZY277vK2XPJkDMm1vf2nX/wCkZPXv9zt7tbPNfZOHMBy02+0xy
   ocn/b1Em9d4lYGCkQVSCL32homEAXn104CtSfA+U5Xziv1nFC8J/su4Lm
   7WMcogqUzrrRBle9P/jUYyiW7/U3xLDRAJJCYAgv7OCYH+2RuQRKiD6IR
   bzWPPXyv0sLXlzC/JbVxOSokMHwHNbWvniFy8s1da8W0n/Y9yIItWTW4x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107369"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107369"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771405"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771405"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30AC336D; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 07/17] pinctrl: elkhartlake: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:24 +0200
Message-Id: <20231030120734.2831419-8-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-elkhartlake.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-elkhartlake.c b/drivers/pinctrl/intel/pinctrl-elkhartlake.c
index 81581ab85316..1678634ebc06 100644
--- a/drivers/pinctrl/intel/pinctrl-elkhartlake.c
+++ b/drivers/pinctrl/intel/pinctrl-elkhartlake.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -485,14 +486,12 @@ static const struct acpi_device_id ehl_pinctrl_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ehl_pinctrl_acpi_match);
 
-static INTEL_PINCTRL_PM_OPS(ehl_pinctrl_pm_ops);
-
 static struct platform_driver ehl_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_uid,
 	.driver = {
 		.name = "elkhartlake-pinctrl",
 		.acpi_match_table = ehl_pinctrl_acpi_match,
-		.pm = &ehl_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(ehl_pinctrl_driver);
-- 
2.40.0.1.gaa8946217a0b

