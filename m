Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E57DB9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjJ3MIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjJ3MIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:08:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E4C6;
        Mon, 30 Oct 2023 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667667; x=1730203667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycY3v4mV/M6Ughxu1dnMZI+MOMU09AyF0kMqJ9pNwL0=;
  b=NIfCpT10/2C91CMX2+B4AB8bTtG+iabD47D3hKXDI0pUYfvUqm47WKkT
   WEq3+6BL2052E+t1h6adYgJp128vWlkOknVibs/UcfPN0MWzNF4ug7Ud3
   JJL/BLtrZADnzzYOLK2d1pnAthSDLLqosyaxzeqInyYTAKiK71599yfus
   IZyHXPbv6LdoU1kq1n8d1Ibt/ZHknviynSwOhCPh/4mhUny9k0FFmePWh
   8rZ1ImJmrTVcp9sgKSmSApnsuVjAjvoAMhZF7euGNDbBKM86L6OtLESkT
   67KtuXiuEMLM2YfUGP8SYVwkEZZfdgAn9zLmVHhA7mHa/3/BrG+7VtF3s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6691339"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6691339"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="826036558"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826036558"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 05:07:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D0184B8; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 15/17] pinctrl: sunrisepoint: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:32 +0200
Message-Id: <20231030120734.2831419-16-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
index b7a40ab0bca8..55df9d2cfb1b 100644
--- a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
+++ b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
@@ -10,6 +10,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -579,14 +580,12 @@ static const struct acpi_device_id spt_pinctrl_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, spt_pinctrl_acpi_match);
 
-static INTEL_PINCTRL_PM_OPS(spt_pinctrl_pm_ops);
-
 static struct platform_driver spt_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_hid,
 	.driver = {
 		.name = "sunrisepoint-pinctrl",
 		.acpi_match_table = spt_pinctrl_acpi_match,
-		.pm = &spt_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 
-- 
2.40.0.1.gaa8946217a0b

