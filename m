Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24CD7AE4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjIZFUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjIZFUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:20:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79821120;
        Mon, 25 Sep 2023 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705625; x=1727241625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbE19XBFoeQsTwGAJN998UHeoS6jXenyajr7Dybr/A4=;
  b=GfCkes340mSo6zWeejPwvvdkXhS6tIoMiLioOMVARO0N/t8mrnrXjsMU
   FWjg7u22teNHMSQDsQJOw4OGilZbUc8IIZM1LtFwo/sAujghyjfPOoN5F
   NADAiiRjfC9cf+WLYBFQ3h1hEyQ3O0kkW9lI8gL4ZBLj8ShR3BN9H+L+d
   eJwlfy/a3Hi71+OOaHPAfEL7rGEeFADSAIWO9dY5NKiy97ZySk//BFRAm
   BtN0UcN2a1tTdi3YDflLBLyh9qDjTGFYwgrcqzsa6MV4cmveIG0/3vmwU
   GcnXs4rJoO0PhsJydM7J8xsSM8Yf66jAXVmjcGPMUmdG8I+f36BpR9f7f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371820585"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="371820585"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783824217"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="783824217"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Sep 2023 22:20:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 06CAD919; Tue, 26 Sep 2023 08:20:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v1 4/5] gpio: xilinx: Replace bitmap_bitremap() calls
Date:   Tue, 26 Sep 2023 08:20:06 +0300
Message-Id: <20230926052007.3917389-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have sparse and dence masks of the line mappings based on
the view point (Linux numbering or hardware numbering). Since
the Linux side uses sequential bits for the mask, we can simply
convert a Linux number to the hardware one and vise versa by
counting set bits in the respective mask. Hence replace
bitmap_bitremap() calls by simpler equivalents.

With this done the dence mask is not needed and thus dropped.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-xilinx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index f103c30cc74f..14ca3097563a 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -46,7 +46,6 @@
  * @gc: GPIO chip
  * @regs: register block
  * @hw_map: GPIO pin mapping on hardware side
- * @sw_map: GPIO pin mapping on software side
  * @state: GPIO write state shadow register
  * @last_irq_read: GPIO read state register from last interrupt
  * @dir: GPIO direction shadow register
@@ -62,7 +61,6 @@ struct xgpio_instance {
 	struct gpio_chip gc;
 	void __iomem *regs;
 	DECLARE_BITMAP(hw_map, 64);
-	DECLARE_BITMAP(sw_map, 64);
 	DECLARE_BITMAP(state, 64);
 	DECLARE_BITMAP(last_irq_read, 64);
 	DECLARE_BITMAP(dir, 64);
@@ -76,12 +74,12 @@ struct xgpio_instance {
 
 static inline int xgpio_from_bit(struct xgpio_instance *chip, int bit)
 {
-	return bitmap_bitremap(bit, chip->hw_map, chip->sw_map, 64);
+	return bitmap_weight(chip->hw_map, bit + 1);
 }
 
 static inline int xgpio_to_bit(struct xgpio_instance *chip, int gpio)
 {
-	return bitmap_bitremap(gpio, chip->sw_map, chip->hw_map, 64);
+	return find_nth_bit(chip->hw_map, 64, gpio);
 }
 
 static inline u32 xgpio_get_value32(const unsigned long *map, int bit)
@@ -619,9 +617,6 @@ static int xgpio_probe(struct platform_device *pdev)
 	if (width[1] > 32)
 		return -EINVAL;
 
-	/* Setup software pin mapping */
-	bitmap_set(chip->sw_map, 0, width[0] + width[1]);
-
 	/* Setup hardware pin mapping */
 	bitmap_set(chip->hw_map,  0, width[0]);
 	bitmap_set(chip->hw_map, 32, width[1]);
-- 
2.40.0.1.gaa8946217a0b

