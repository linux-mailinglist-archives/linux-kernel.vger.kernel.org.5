Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2417D00B3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbjJSRfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjJSRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:35:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A7138;
        Thu, 19 Oct 2023 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736906; x=1729272906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OK+wrv+DMOQXPBESi5xHEfknrZptJg8C/cIK0m+tQ50=;
  b=Oc8uynhBrgzTo2ujIVSkfTn6dxW8SwfreV1tEfMYV7p0WXwm1QR6/bl8
   lFIzSo9bBeM+K8Cz7dDJ7eScjN1rdclmkqjF5ToNQV7zLpeH1xOjdkKRO
   2m4Ayhml04s2j2qpBRdd6BWE+I/XC1uxspe0F45SVEjlbLi/ZK4pbCv2y
   1dCaHwvalGBNWtSPOIs588KJIJVff5ZZ2uiZGvMYhH3CAgTCL53gpdIx6
   wmKyVX/R7O0v4AetmQoT6hYQ8CViftb+VvW4pilX2N8k0uVZGNegvmUj/
   XX8BE7w72RlbtDnWC4fKsZrHdku0qMrFS3iAyVI+c4GDEPI9JTYxi7jHr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389184246"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389184246"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760723566"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760723566"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2023 10:35:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47B19F4; Thu, 19 Oct 2023 20:35:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 1/3] gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()
Date:   Thu, 19 Oct 2023 20:34:55 +0300
Message-Id: <20231019173457.2445119-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When refactoring the acpi_get_gpiod_from_data() the change missed
cleaning up the variable on stack. Add missing memset().

Reported-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 16ba046e86e9 ("gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fbda452fb4d6..51e41676de0b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -951,6 +951,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
 	if (!propname)
 		return ERR_PTR(-EINVAL);
 
+	memset(&lookup, 0, sizeof(lookup));
 	lookup.index = index;
 
 	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
-- 
2.40.0.1.gaa8946217a0b

