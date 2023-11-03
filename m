Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6F7E0A88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjKCUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjKCTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7EDD4E;
        Fri,  3 Nov 2023 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699041198; x=1730577198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eUuuyUtQ+5betVlsnj9MIgKiK2+aM4+nMSQ8mwzd6Uk=;
  b=lZFvyC883EjBfQLF5PjSpJENPYHWPQCcvP1e5dyGvpzGxDj+WSFsdOJY
   Gu4nhdI+CqlYri2Vo2kZ5mX84YgPOPPbjRIdDsWCpUxBY/qSBtdROg65+
   iHz/a3qALjcVOQEjEyia2yyKp+MApfUOc+zZf8IJIkK00iNW2KAS+aJKH
   H7M5Uu9OAK4oDJ0ky1AKxC3cihsNvmSB83Ym3TXqlimP8d7NkzsNbozcf
   dh3JPzpGXpY3XHviZoRs756vBYrJj4budD5wnhzVPOXrX2sNOraIBFIMJ
   ybIERmqSKZtbt7SEQRFck4yV34s4OqyhN9SIEByHA7GPuHFE7W740W7jK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1962960"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1962960"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 12:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="761719315"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="761719315"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Nov 2023 12:53:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1E775E2; Fri,  3 Nov 2023 21:53:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/4] leds: trigger: gpio: Replace custom code for gpiod_get_optional()
Date:   Fri,  3 Nov 2023 21:53:07 +0200
Message-Id: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

gpiod_get_optional() and currently used fwnode_gpiod_get_index()
are both wrappers against the same engine internally. Since we
have a pointer to struct device there is no reason to use fwnode
type of GPIO call. So, replace the current fwnode call by respective
gpiod ones.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/trigger/ledtrig-gpio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index 9b7fe5dd5208..d91ae7fde3cf 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -89,10 +89,7 @@ static int gpio_trig_activate(struct led_classdev *led)
 	 * The generic property "trigger-sources" is followed,
 	 * and we hope that this is a GPIO.
 	 */
-	gpio_data->gpiod = fwnode_gpiod_get_index(dev->fwnode,
-						  "trigger-sources",
-						  0, GPIOD_IN,
-						  "led-trigger");
+	gpio_data->gpiod = gpiod_get_optional(dev, "trigger-sources", GPIOD_IN);
 	if (IS_ERR(gpio_data->gpiod)) {
 		ret = PTR_ERR(gpio_data->gpiod);
 		kfree(gpio_data);
@@ -104,6 +101,8 @@ static int gpio_trig_activate(struct led_classdev *led)
 		return -EINVAL;
 	}
 
+	gpiod_set_consumer_name(gpio_data->gpiod, "led-trigger");
+
 	gpio_data->led = led;
 	led_set_trigger_data(led, gpio_data);
 
-- 
2.40.0.1.gaa8946217a0b

