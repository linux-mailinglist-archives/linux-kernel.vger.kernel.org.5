Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585217CAE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPQKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:10:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482AE6;
        Mon, 16 Oct 2023 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697472613; x=1729008613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8k8DrgrN+0Ylm+kKwsZKCjBoAC5iHc0h68Upva4lbg=;
  b=W3XBeBwP0RCbyD6FFJ4ceCkk822Bpj/04V+aN8hVF/zFR15tlSy5va8j
   Mm/SGAmt6uMwlOZWm9ROhZ7kmwjp7hQEp4ks6RnzS1EsIRQUKmCWEG80v
   nDrCG6t2w2qDXrjJvKQ6Mq7B9EE9FC9ZLFqsKZSAZcMQqTlNTAJjmVssc
   ffL3WMxdibM+w+pvIOnDFiAepyghe4R171MYYrAbwugZxiA1tl1BskwK6
   iA+NnfrgGu976NKCUJbecXFsw0/+GMsrySpTQXKcz9L9HM0gjJszxMNua
   yLU9yZkPu1b/c9Zy0ZCz5d/AEaI8CQ4klq1WeanQIwKWgmUa8ZrgFpX59
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4175724"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4175724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087124867"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087124867"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 09:10:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 164EF85E; Mon, 16 Oct 2023 19:10:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 3/6] leds: gpio: Refactor code to use devm_gpiod_get_index_optional()
Date:   Mon, 16 Oct 2023 19:10:02 +0300
Message-Id: <20231016161005.1471768-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
References: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
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

Instead of checking for the specific error codes, replace
devm_gpiod_get_index() with devm_gpiod_get_index_optional().
In this case we just return all errors to the caller and
simply check for NULL in case if legacy GPIO is being used.
As the result the code is easier to read and maintain.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 4071cb9eefec..7c9c6a93dfd7 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -218,13 +218,13 @@ static struct gpio_desc *gpio_led_get_gpiod(struct device *dev, int idx,
 	 * device, this will hit the board file, if any and get
 	 * the GPIO from there.
 	 */
-	gpiod = devm_gpiod_get_index(dev, NULL, idx, GPIOD_OUT_LOW);
-	if (!IS_ERR(gpiod)) {
+	gpiod = devm_gpiod_get_index_optional(dev, NULL, idx, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod))
+		return gpiod;
+	if (gpiod) {
 		gpiod_set_consumer_name(gpiod, template->name);
 		return gpiod;
 	}
-	if (PTR_ERR(gpiod) != -ENOENT)
-		return gpiod;
 
 	/*
 	 * This is the legacy code path for platform code that
-- 
2.40.0.1.gaa8946217a0b

