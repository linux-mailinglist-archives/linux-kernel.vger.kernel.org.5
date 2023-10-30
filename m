Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE07DB997
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjJ3MIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJ3MHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC5DB;
        Mon, 30 Oct 2023 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667665; x=1730203665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0vUL7V1SFJx6uAwoQ+SfYs4Wur92WJhuHwbMwyARaco=;
  b=L3jjXhHo3qdLyXzUPCDwgNzl9buoXGJRoCXJqvGvX9D3eDjLL7AkN/06
   sDqVxp2bXGOtm/+Ix/Ab42+D9pCZGlmaOe6z2yM6gk1fSPxt0nSu7qN68
   R7Q/6jwhYNlp0jXiuEW6ICBx+zBKBjrhiN5xDSEqCEVOychAGUqQ8of+p
   VtbclOLR7sEHtI41F2WakxdK7PUCDMDsHxpzRpQiRfrG/hfgh0H/y529o
   k+pWpCAz5jtVutQJiPJXsIcbBVYacgrHimxyTd4+GE1O6mTbBR/zgycTX
   jYKdYROe27daX5pLOQdiN1oaIFf4EnHpvNjRLOvbT1jXHz1HWz7jkcrH2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6691292"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6691292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="826036530"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826036530"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 05:07:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 42227403; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 08/17] pinctrl: emmitsburg: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:25 +0200
Message-Id: <20231030120734.2831419-9-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-emmitsburg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-emmitsburg.c b/drivers/pinctrl/intel/pinctrl-emmitsburg.c
index 099ec8351d5f..e4798d32492c 100644
--- a/drivers/pinctrl/intel/pinctrl-emmitsburg.c
+++ b/drivers/pinctrl/intel/pinctrl-emmitsburg.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -358,14 +359,12 @@ static const struct acpi_device_id ebg_pinctrl_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ebg_pinctrl_acpi_match);
 
-static INTEL_PINCTRL_PM_OPS(ebg_pinctrl_pm_ops);
-
 static struct platform_driver ebg_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_hid,
 	.driver = {
 		.name = "emmitsburg-pinctrl",
 		.acpi_match_table = ebg_pinctrl_acpi_match,
-		.pm = &ebg_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(ebg_pinctrl_driver);
-- 
2.40.0.1.gaa8946217a0b

