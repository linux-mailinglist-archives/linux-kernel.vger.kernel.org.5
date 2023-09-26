Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25E7AE4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjIZFUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjIZFUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:20:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B312A;
        Mon, 25 Sep 2023 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705625; x=1727241625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/0/YnXJEcB9BbLqlQjSk46oBKNZtRMAfDcTDuka6q4c=;
  b=jBwODYqCk5oXJDf6s7w2mXj+RnNta6A7XAjkFwKDOSN+ust9W8v2ITS/
   SBJFeLzFF9j/non28Nc5pjBhjrY9eg1CxzzDTJsDhD+FaxIr52bSLZgww
   UZSLgbkbrU6ABpD2friyG9PPfO7CyWnO7ip3i8vWkHWXxGp+OSl0D+sCV
   cHSx604LAF4SJ/g+0kD1l6x/zSCGbqmHlenbY/fu+eZSeUGOhaXTTdKMy
   HTHd5HWyHXOzCGb/e0iu5mHz7HF3tKUzyUyDq/02YPD5gsxnGBCrSOeci
   xFkCMtFLVpl0ImU4edxgUD+K91nyxrYAEmyZZEBPb8F3IthuW0HjNyqsb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360865691"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360865691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748689668"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="748689668"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2023 22:20:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F04B91C7; Tue, 26 Sep 2023 08:20:18 +0300 (EEST)
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
Subject: [PATCH v1 3/5] gpio: xilinx: Switch to use new bitmap_scatter() helper
Date:   Tue, 26 Sep 2023 08:20:05 +0300
Message-Id: <20230926052007.3917389-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmaps_scatter() produces a sparse bitmap based on the dense one
and a given mask. In this driver the given mask is hw_map, while
sw_map is of sequential bits. We may use the bitmap_scatter() helper
instead of bitmap_remap(), because it's optimized for our case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-xilinx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index a16945e8319e..f103c30cc74f 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -208,8 +208,8 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	unsigned long flags;
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
 
-	bitmap_remap(hw_mask, mask, chip->sw_map, chip->hw_map, 64);
-	bitmap_remap(hw_bits, bits, chip->sw_map, chip->hw_map, 64);
+	bitmap_scatter(hw_mask, mask, chip->hw_map, 64);
+	bitmap_scatter(hw_bits, bits, chip->hw_map, 64);
 
 	spin_lock_irqsave(&chip->gpio_lock, flags);
 
-- 
2.40.0.1.gaa8946217a0b

