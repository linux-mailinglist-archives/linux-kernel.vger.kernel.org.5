Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6B7E09CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378142AbjKCUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKCUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:03:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448DD53;
        Fri,  3 Nov 2023 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699041813; x=1730577813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nsq+DlizAAeSWWNzWMj45TaDhpGuvaTz6ItsP0chKHM=;
  b=UNnN/AiPim/QbC6K9V3TJSTv/fHdm3MgCDdkEQmgxzoBoDgES3ZGEAKz
   qPM3qgJxCR3OYErmgVuvZQNnzwZQuvtdp69stzuyMOJ2Ni2BfQcbhBiIW
   rq3Vs7zDixiHxZDTdSo4bwajL8jHl7SjcANnEKWXRRhtn1IzIG+XJjNw3
   AndQPAbH1G143BI7KvZuDHHul7h9FnNkHGbvcPYhYHAGBwqWuigIJbOlM
   HulBxIzA6YKUiEqVaZ1GsBllI5ZXYch+gJ0X/gVCOw5kuc0abQyl7heHp
   4SKM1jjb+7o/pCt2eN2wsINNi9rOoBTDS92Df4wx4pYPLfarmZHlVx688
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1894389"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1894389"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832126756"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="832126756"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 13:03:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C26B82A6; Fri,  3 Nov 2023 21:53:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/4] leds: trigger: gpio: Convert to use kstrtox()
Date:   Fri,  3 Nov 2023 21:53:08 +0200
Message-Id: <20231103195310.948327-2-andriy.shevchenko@linux.intel.com>
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

sscanf() is a heavy one and moreover requires additional boundary checks.
Convert driver to use kstrtou8() in gpio_trig_inverted_store().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/trigger/ledtrig-gpio.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index d91ae7fde3cf..8a30f9228186 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -53,14 +53,12 @@ static ssize_t gpio_trig_brightness_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t n)
 {
 	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
-	unsigned desired_brightness;
+	u8 desired_brightness;
 	int ret;
 
-	ret = sscanf(buf, "%u", &desired_brightness);
-	if (ret < 1 || desired_brightness > 255) {
-		dev_err(dev, "invalid value\n");
-		return -EINVAL;
-	}
+	ret = kstrtou8(buf, 10, &desired_brightness);
+	if (ret)
+		return ret;
 
 	gpio_data->desired_brightness = desired_brightness;
 
-- 
2.40.0.1.gaa8946217a0b

