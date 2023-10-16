Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A361F7CAE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjJPQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:10:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2BAB;
        Mon, 16 Oct 2023 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697472612; x=1729008612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yOQZfIm040lvmUe2O+DKvT56T78+nm6brIphWp/oItE=;
  b=cUW8pk80y+3RVyF2reTjUK0cZQ/eEVQZx9bpLrGm4HCPjQq4ACx9QHyx
   1u1GXvX7FqRpRnO1cVkZ9ieaUW5KnOdK+ymVRROhfFPBgVIfvRXRpcKEl
   lhzo5K2D6fHgh8U/JafKsydheZr86jKw0/eAEAIn83bbTBarrc7T+qRro
   JsB1vS1VvbhojUHkLs9p5FmSwMxBaYDXhrUs1lSFMDCOTtQooWNgSAHV6
   ZUg24PvcsgJrdWO0JY5IwWOJRf3cpsp0HnFEPxrkP+T9ZSJD7160sTLwB
   KWrWECe2OERkRYSBh31xGEoFClDeo8yjt7GmM1kDg3wTuI0hDMeQTsSMG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4175721"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4175721"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087124866"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087124866"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 09:10:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA49781C; Mon, 16 Oct 2023 19:10:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/6] leds: gpio: Keep driver firmware interface agnostic
Date:   Mon, 16 Oct 2023 19:10:00 +0300
Message-Id: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of.h is used as a proxy to mod_devicetable, replace former by
latter.

The commit 2d6180147e92 ("leds: gpio: Configure per-LED pin control")
added yet another unneeded OF APIs. Replace with direct use of fwnode.

Altogether this makes driver agnostic to the firmware interface in use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-gpio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index a6597f0f3eb4..debadb48ceda 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -11,8 +11,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -129,8 +129,8 @@ static int create_gpio_led(const struct gpio_led *template,
 		ret = PTR_ERR(pinctrl);
 		if (ret != -ENODEV) {
 			dev_warn(led_dat->cdev.dev,
-				 "Failed to select %pOF pinctrl: %d\n",
-				 to_of_node(fwnode), ret);
+				 "Failed to select %pfw pinctrl: %d\n",
+				 fwnode, ret);
 		} else {
 			/* pinctrl-%d not present, not an error */
 			ret = 0;
-- 
2.40.0.1.gaa8946217a0b

