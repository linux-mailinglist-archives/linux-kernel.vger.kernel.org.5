Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C767AE4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjIZFU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjIZFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:20:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279EEF2;
        Mon, 25 Sep 2023 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705629; x=1727241629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2HOZ+oim+zNWe8lFVHeNEs80ZdHaUduFZXUMLCdW3No=;
  b=bqkT8gDq5l9vXOhCHEgLdaTSreExf3hLjWetfKuF5mDvlLkMjzhjBDvg
   AIMYx2wJJMbAk2JE/8R2pey70Yl3Fgtq90qDT8Su8ov8f/CaGJuSVgxPT
   810FWwAgcTLuQnr6P0MBwIHQKfhqfO8EFKuHPSz5cEfKLDCub1TbrMsti
   eg6EknMbrt5BE4zHo745ZXI+t0du5YUZBREMECiDeNlOOssrCM28jd4xp
   +3b7F+2RRrXUiV4Kkr+7EucffQXyrewKB2POEPrOnn9gQvK9mg3Croqz6
   hbom/b3fvi+0NgoR+Dh0grVl2zfLYNnRmikv5uw9gNB2kSRZygzYvMp0x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360865705"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360865705"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748689685"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="748689685"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2023 22:20:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 162DB133D; Tue, 26 Sep 2023 08:20:19 +0300 (EEST)
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
Subject: [PATCH v1 5/5] gpiolib: cdev: Utilize more bitmap APIs
Date:   Tue, 26 Sep 2023 08:20:07 +0300
Message-Id: <20230926052007.3917389-6-andriy.shevchenko@linux.intel.com>
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

Currently we have a few bitmap calls that are open coded in the library
module. Let's convert them to use generic bitmap APIs instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 79 +++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e39d344feb28..a5bbbd44531f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1263,35 +1263,32 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 {
 	struct gpio_v2_line_values lv;
 	DECLARE_BITMAP(vals, GPIO_V2_LINES_MAX);
+	DECLARE_BITMAP(mask, GPIO_V2_LINES_MAX);
+	DECLARE_BITMAP(bits, GPIO_V2_LINES_MAX);
 	struct gpio_desc **descs;
 	unsigned int i, didx, num_get;
-	bool val;
 	int ret;
 
 	/* NOTE: It's ok to read values of output lines. */
 	if (copy_from_user(&lv, ip, sizeof(lv)))
 		return -EFAULT;
 
-	for (num_get = 0, i = 0; i < lr->num_lines; i++) {
-		if (lv.mask & BIT_ULL(i)) {
-			num_get++;
-			descs = &lr->lines[i].desc;
-		}
-	}
+	bitmap_from_arr64(mask, &lv.mask, GPIO_V2_LINES_MAX);
 
+	num_get = bitmap_weight(mask, lr->num_lines);
 	if (num_get == 0)
 		return -EINVAL;
 
-	if (num_get != 1) {
+	if (num_get == 1) {
+		descs = &lr->lines[find_first_bit(mask, lr->num_lines)].desc;
+	} else {
 		descs = kmalloc_array(num_get, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
-		for (didx = 0, i = 0; i < lr->num_lines; i++) {
-			if (lv.mask & BIT_ULL(i)) {
-				descs[didx] = lr->lines[i].desc;
-				didx++;
-			}
-		}
+
+		didx = 0;
+		for_each_set_bit(i, mask, lr->num_lines)
+			descs[didx++] = lr->lines[i].desc;
 	}
 	ret = gpiod_get_array_value_complex(false, true, num_get,
 					    descs, NULL, vals);
@@ -1301,19 +1298,15 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 	if (ret)
 		return ret;
 
-	lv.bits = 0;
-	for (didx = 0, i = 0; i < lr->num_lines; i++) {
-		if (lv.mask & BIT_ULL(i)) {
-			if (lr->lines[i].sw_debounced)
-				val = debounced_value(&lr->lines[i]);
-			else
-				val = test_bit(didx, vals);
-			if (val)
-				lv.bits |= BIT_ULL(i);
-			didx++;
-		}
+	bitmap_scatter(bits, vals, mask, lr->num_lines);
+
+	for_each_set_bit(i, mask, lr->num_lines) {
+		if (lr->lines[i].sw_debounced)
+			__assign_bit(i, bits, debounced_value(&lr->lines[i]));
 	}
 
+	bitmap_to_arr64(&lv.bits, bits, GPIO_V2_LINES_MAX);
+
 	if (copy_to_user(ip, &lv, sizeof(lv)))
 		return -EFAULT;
 
@@ -1324,35 +1317,35 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 					struct gpio_v2_line_values *lv)
 {
 	DECLARE_BITMAP(vals, GPIO_V2_LINES_MAX);
+	DECLARE_BITMAP(mask, GPIO_V2_LINES_MAX);
+	DECLARE_BITMAP(bits, GPIO_V2_LINES_MAX);
 	struct gpio_desc **descs;
 	unsigned int i, didx, num_set;
 	int ret;
 
-	bitmap_zero(vals, GPIO_V2_LINES_MAX);
-	for (num_set = 0, i = 0; i < lr->num_lines; i++) {
-		if (lv->mask & BIT_ULL(i)) {
-			if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
-				return -EPERM;
-			if (lv->bits & BIT_ULL(i))
-				__set_bit(num_set, vals);
-			num_set++;
-			descs = &lr->lines[i].desc;
-		}
-	}
+	bitmap_from_arr64(mask, &lv->mask, GPIO_V2_LINES_MAX);
+	bitmap_from_arr64(bits, &lv->bits, GPIO_V2_LINES_MAX);
+
+	num_set = bitmap_gather(vals, bits, mask, lr->num_lines);
 	if (num_set == 0)
 		return -EINVAL;
 
-	if (num_set != 1) {
+	for_each_set_bit(i, mask, lr->num_lines) {
+		if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
+			return -EPERM;
+	}
+
+	if (num_set == 1) {
+		descs = &lr->lines[find_first_bit(mask, lr->num_lines)].desc;
+	} else {
 		/* build compacted desc array and values */
 		descs = kmalloc_array(num_set, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
-		for (didx = 0, i = 0; i < lr->num_lines; i++) {
-			if (lv->mask & BIT_ULL(i)) {
-				descs[didx] = lr->lines[i].desc;
-				didx++;
-			}
-		}
+
+		didx = 0;
+		for_each_set_bit(i, mask, lr->num_lines)
+			descs[didx++] = lr->lines[i].desc;
 	}
 	ret = gpiod_set_array_value_complex(false, true, num_set,
 					    descs, NULL, vals);
-- 
2.40.0.1.gaa8946217a0b

