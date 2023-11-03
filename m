Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55E27E09C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjKCUDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKCUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:03:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB1AD53;
        Fri,  3 Nov 2023 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699041809; x=1730577809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHEKAZwFkfBPaWXKiUvpj74KxQIC1qIeU1pZ07Sbhuk=;
  b=ka5Ntg+C7w4STO2qIpzuQFROo4DFF88qtg3GH56S9UtrlFwmoQPoxKLQ
   pzMD6vgeXBG7cbFntiBgtu2tOxS08LdLaEYXcu+G4NI0wUZdFmUdpCI44
   MfkgsoqTGXCGEnyUVEVdUbzRj3chiMb3Gi4O/MaSIcuXIpCj2a65gMOH9
   5s5NKgCxtkjnKzWdDGszJFlk+KHMhm85ftX0B6it+/hoIKYuuiDG4dq9s
   YRr0pcAMa6/F3+FRDassWoPl2S8jbK/MJ4XbrdD84DABk5dBTVfjz9G4z
   iRV6qlAkQg5X8tKfo4hUZWvuhNaiVUJggtHhtJi/fHXzJyAqmixmvFwWW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="420130012"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="420130012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="905446864"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="905446864"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2023 13:03:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5BE05E5; Fri,  3 Nov 2023 21:53:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 4/4] leds: trigger: gpio: Convert to DEVICE_ATTR_RW()
Date:   Fri,  3 Nov 2023 21:53:10 +0200
Message-Id: <20231103195310.948327-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom wrapper, use DEVICE_ATTR_RW() directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/trigger/ledtrig-gpio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index 8824be19881f..7f6a2352b0ac 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -41,7 +41,7 @@ static irqreturn_t gpio_trig_irq(int irq, void *_led)
 	return IRQ_HANDLED;
 }
 
-static ssize_t gpio_trig_brightness_show(struct device *dev,
+static ssize_t desired_brightness_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
@@ -49,7 +49,7 @@ static ssize_t gpio_trig_brightness_show(struct device *dev,
 	return sysfs_emit(buf, "%u\n", gpio_data->desired_brightness);
 }
 
-static ssize_t gpio_trig_brightness_store(struct device *dev,
+static ssize_t desired_brightness_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t n)
 {
 	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
@@ -64,8 +64,7 @@ static ssize_t gpio_trig_brightness_store(struct device *dev,
 
 	return n;
 }
-static DEVICE_ATTR(desired_brightness, 0644, gpio_trig_brightness_show,
-		gpio_trig_brightness_store);
+static DEVICE_ATTR_RW(desired_brightness);
 
 static struct attribute *gpio_trig_attrs[] = {
 	&dev_attr_desired_brightness.attr,
-- 
2.40.0.1.gaa8946217a0b

