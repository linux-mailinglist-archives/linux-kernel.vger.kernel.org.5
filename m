Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9E7DB9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjJ3MI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjJ3MIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:08:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA6ED;
        Mon, 30 Oct 2023 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667668; x=1730203668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZBuupFLaswcQ6rjSTSVB/ntkS6l460Cr5/0l0Mopvs=;
  b=Rbtqz+Wg5zyGBViMkYr4xebbbYx1WOd0ry6CidzOdH84DKlsd1jxDbl/
   cvsrM+TUsZ99iVYFo5h/FfelaNw4c+ayNsJhSps2SrAf9QNic9rFZ3xDd
   RKIByol/Gw2u5fu1eCuVgW224cZcXvesORu9hXHMOVEcWja9BIH8zCx+O
   UQTG7mefr1+p3Ls7QepnDLfGYMlqao1ZVtFOWqd4gfszIMnJH76UgOJfD
   oDdR0cicIYWg3wd0jnFEXKJlklUB7VP9BpFPoOI0hGeaUDIaLhYkKIPqn
   w/jHo8OEwGe6HW4c37K7o/easJUNIKu8kZCBm6yCfrF+0mYE1cI6xqC3L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6691344"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6691344"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="826036557"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826036557"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 05:07:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 88F464F0; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 16/17] pinctrl: tigerlake: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:33 +0200
Message-Id: <20231030120734.2831419-17-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-tigerlake.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tigerlake.c b/drivers/pinctrl/intel/pinctrl-tigerlake.c
index 4768a69a9258..80cd7a06fe5a 100644
--- a/drivers/pinctrl/intel/pinctrl-tigerlake.c
+++ b/drivers/pinctrl/intel/pinctrl-tigerlake.c
@@ -10,6 +10,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -743,14 +744,12 @@ static const struct acpi_device_id tgl_pinctrl_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, tgl_pinctrl_acpi_match);
 
-static INTEL_PINCTRL_PM_OPS(tgl_pinctrl_pm_ops);
-
 static struct platform_driver tgl_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_hid,
 	.driver = {
 		.name = "tigerlake-pinctrl",
 		.acpi_match_table = tgl_pinctrl_acpi_match,
-		.pm = &tgl_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(tgl_pinctrl_driver);
-- 
2.40.0.1.gaa8946217a0b

