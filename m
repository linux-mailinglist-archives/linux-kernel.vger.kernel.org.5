Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF257B5474
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbjJBN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbjJBN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:56:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E83AD;
        Mon,  2 Oct 2023 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254994; x=1727790994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iB27Y3GxWfGv0KsgGx2AoqPZrJKjVCm9lyDtEfzmT+4=;
  b=m3LD9SquWZVsMqUOe9Rwhe2X2oKx7QUiJmfs4g2cy0FYS5GBVhyWVb6J
   0nRLl0HsSax0RDU52YYLdZbPJLbsTZmdkBpreNggX0VDFrcLncYC8+kRo
   KcSc4RbMxgWpYHs4MagiK8vU29HQR7CSMuXTKIi287VWNuP/xfvsQDF0S
   G9aPTH46Sk53+OY+/NoGxDydAp58d4VIGtvcSBt5g7qzT3Dyhp/mDeAYg
   nug1WOjlkJzlhB3JZeCoEwyaVIEvwLHDD7kTjQZObsPqt+RPWjf4WYdmw
   9+uAnsjfBY4nXEH9pfhSxh2yL1rkBjxrU1u3nWkR+fsWJrVjFaBGGa8Ew
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362912072"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362912072"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="785782661"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="785782661"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Oct 2023 06:56:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2CBB14AF; Mon,  2 Oct 2023 16:56:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] leds: tca6507: Don't use fixed GPIO base
Date:   Mon,  2 Oct 2023 16:56:29 +0300
Message-Id: <20231002135629.2605462-1-andriy.shevchenko@linux.intel.com>
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

First of all, the fixed GPIO base is source of troubles and
it doesn't scale. Second, there is no in-kernel user of this
base, so drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-tca6507.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index aab861771210..e19074614095 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -92,9 +92,6 @@
 
 struct tca6507_platform_data {
 	struct led_platform_data leds;
-#ifdef CONFIG_GPIOLIB
-	int gpio_base;
-#endif
 };
 
 #define	TCA6507_MAKE_GPIO 1
@@ -636,7 +633,7 @@ static int tca6507_probe_gpios(struct device *dev,
 
 	tca->gpio.label = "gpio-tca6507";
 	tca->gpio.ngpio = gpios;
-	tca->gpio.base = pdata->gpio_base;
+	tca->gpio.base = -1;
 	tca->gpio.owner = THIS_MODULE;
 	tca->gpio.direction_output = tca6507_gpio_direction_output;
 	tca->gpio.set = tca6507_gpio_set_value;
@@ -715,9 +712,6 @@ tca6507_led_dt_init(struct device *dev)
 
 	pdata->leds.leds = tca_leds;
 	pdata->leds.num_leds = NUM_LEDS;
-#ifdef CONFIG_GPIOLIB
-	pdata->gpio_base = -1;
-#endif
 
 	return pdata;
 }
-- 
2.40.0.1.gaa8946217a0b

