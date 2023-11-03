Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A587E0A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKCU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378183AbjKCTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0551BC;
        Fri,  3 Nov 2023 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699041197; x=1730577197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M2LYr3uiwRiw2hfh8eZTwB7i1h0z6rfdmlPTebmD3d0=;
  b=j7XwkUNJ9/9TsLf520/+Oq7tI0HVVk7sYI7K0eruNZwAHHTp5APL7stF
   ZVXqMFPr5J9hxpl56MZqOTuz7X8rVz02qvb7q+JwGhbazGD8vjv9j0Tgm
   BZkbTz6vSK1Q5goHNQWEjetBUCNSR147I8aNDCVlDiOsFgUYGSOZhDPTD
   M3CO2M/HdpYagw0KrFQxAF+UPwueJuYHdDSWEzmEqTPyTYYbQ8GrO38Iq
   bBPMNXOwGsfLszNJ195wjaFfGZqCewALS3ov//dt99aBXUDXqW2AJdZqT
   cXizvIKbCfllAC9U5mKGTWNUVwu1Bc1FhAAwkGk8g0rCK6aW+JzUdtaEp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1962964"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1962964"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 12:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="761719316"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="761719316"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Nov 2023 12:53:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D66EC5E8; Fri,  3 Nov 2023 21:53:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 3/4] leds: trigger: gpio: Use sysfs_emit() to instead of s*printf()
Date:   Fri,  3 Nov 2023 21:53:09 +0200
Message-Id: <20231103195310.948327-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/trigger/ledtrig-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index 8a30f9228186..8824be19881f 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -46,7 +46,7 @@ static ssize_t gpio_trig_brightness_show(struct device *dev,
 {
 	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", gpio_data->desired_brightness);
+	return sysfs_emit(buf, "%u\n", gpio_data->desired_brightness);
 }
 
 static ssize_t gpio_trig_brightness_store(struct device *dev,
-- 
2.40.0.1.gaa8946217a0b

