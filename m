Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DC7C003D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjJJPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:18:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3226AA7;
        Tue, 10 Oct 2023 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696951129; x=1728487129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w1u+oz+TxHGbO6VqcwI4Fu7bojupIN05OR98eU3NVvk=;
  b=k6YKOrzTcWraLLYtcZGaCknOPXiLRdTgnEN3Q+PiVGgJnLSnl4ra4Keu
   k2aU3hWbjAsQl8xvd2lAkuiOJXm2xycJwwn+ScK76Gh61g1j9rqONSoyD
   8m42ZYcErBooFAora60pJE6C+/Gac134ueCZYCw++Uw9xnYp8wHwlTCtX
   rvTcOmEOcYU+4L7l0lR35aNpgDQ7h2zWnr623cawIlAGJs1CUz5MEfPjS
   Q4KunvwkPsqdYBG51ta0c/kErq/UC5JQiGjH9GH9yEL4+S5lE2x/M4EbK
   zUSMb0v4OwtFRlY6fM1gO8htLNsztS20wQP4K41lR9TPpzZ6HmciRsQ4G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415439396"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="415439396"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1084830070"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1084830070"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2023 08:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 33E8D93; Tue, 10 Oct 2023 18:17:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 1/4] gpiolib: provide gpio_device_find_by_fwnode()
Date:   Tue, 10 Oct 2023 18:17:06 +0300
Message-Id: <20231010151709.4104747-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the ways of looking up GPIO devices is using their fwnode.
Provide a helper for that to avoid every user implementing their
own matching function.

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

