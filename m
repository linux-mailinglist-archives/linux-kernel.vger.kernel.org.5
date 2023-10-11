Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CB7C5E58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376439AbjJKU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjJKU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:26:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18293;
        Wed, 11 Oct 2023 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697056009; x=1728592009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRyQlSHpeOLdYLvwN2SQBQmioztVBGvZYUmThNk322Y=;
  b=Qe1ut4p615zXxS5m9Y2RkWTU9HIeiLG6pQBt4cKi8/hAunDHyCr6XkF+
   aWHlflxAOG48R4FhFVjPnRqIC+nxVvwfMudJm4BFo02wZXomg8btxNQxB
   vdKofhx1tK1pDkoabkA/XkuRi0x4tntCl6EvZacijLVGasnJvW/1T8pcp
   i4pW85tauzMHCvVyOaXAcl14ZfA3FzYJnGU8n/dBHNGoU6FjhEugcEf3H
   TMnZcPq5mV4fZvhr+WClvE2XaJx33aKcZZwbX0cowAbpOMGkMFsPCSsj4
   +V4Z7kH/2TVpdlCCpa5YXBWNmtKVrqP4tjdtCVt97ykKluhTAhxLxWU24
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="471015140"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="471015140"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 13:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783393504"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783393504"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2023 13:26:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0BA25345; Wed, 11 Oct 2023 23:26:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 1/4] gpiolib: provide gpio_device_find_by_fwnode()
Date:   Wed, 11 Oct 2023 23:26:35 +0300
Message-Id: <20231011202638.372382-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
References: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the ways of looking up GPIO devices is using their fwnode.
Provide a helper for that to avoid every user implementing their
own matching function.

Reviewed-by: Dipen Patel <dipenp@nvidia.com>
Tested-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20231010151709.4104747-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c      | 20 ++++++++++++++++++++
 include/linux/gpio/driver.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7b4d12b714a3..31c06a32cb8a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1142,6 +1142,26 @@ struct gpio_device *gpio_device_find_by_label(const char *label)
 }
 EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
 
+static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, void *fwnode)
+{
+	return device_match_fwnode(&gc->gpiodev->dev, fwnode);
+}
+
+/**
+ * gpio_device_find_by_fwnode() - wrapper around gpio_device_find() finding
+ *                                the GPIO device by its fwnode
+ * @fwnode: Firmware node to lookup
+ *
+ * Returns:
+ * Reference to the GPIO device or NULL. Reference must be released with
+ * gpio_device_put().
+ */
+struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handle *fwnode)
+{
+	return gpio_device_find((void *)fwnode, gpio_chip_match_by_fwnode);
+}
+EXPORT_SYMBOL_GPL(gpio_device_find_by_fwnode);
+
 /**
  * gpio_device_get() - Increase the reference count of this GPIO device
  * @gdev: GPIO device to increase the refcount for
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index f8ad7f40100c..ae4162d3f1d3 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -611,6 +611,7 @@ struct gpio_chip *gpiochip_find(void *data,
 struct gpio_device *gpio_device_find(void *data,
 				int (*match)(struct gpio_chip *gc, void *data));
 struct gpio_device *gpio_device_find_by_label(const char *label);
+struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handle *fwnode);
 
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
-- 
2.40.0.1.gaa8946217a0b

