Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29E7D737D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJYSnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYSnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:43:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B898DC;
        Wed, 25 Oct 2023 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259387; x=1729795387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T1sOH8MzD7ijqC2IX92sIk4YyeSEBbdujMf4a6IQTo0=;
  b=hpnolXxbUnhqliba/zRd5Kq7TqHBo9QG2rVe0DUEYI9NYknDTF8L9NhT
   w9UgrPaKeBzpIeKOFxNz/DyyN/UF+gG9VIjZXlXLOuVFLRz153x02Weuv
   ueBBRv5zvsEqrizUG+Izc8nk+cma87X5C8rXsNdXdnDWea1mWa9Ah1aVF
   SqPnwXn+wgQaIZuQnAHh5j5xcsj8qClexLf1NWbBDnjNXOrd8cwn8z10j
   vK2zIYYWHB6x/nbDM66W6qImUr9n8pb9+hKByZBtvonzIxv5wXBdyKJyC
   X+sPW0h/m6Y4y3MYXgGI3clFaM2yuNgHa5nS9G/vSYx7wI0rpzU6/dOd5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390233006"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390233006"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932458246"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932458246"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2023 11:43:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2142FF; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Date:   Wed, 25 Oct 2023 21:42:57 +0300
Message-Id: <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
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

Some users want to use the struct device pointer to see if the
device is big endian in terms of Open Firmware specifications,
i.e. if it has a "big-endian" property, or if the kernel was
compiled for BE *and* the device has a "native-endian" property.

Provide inline helper for the users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 2b8f07fc68a9..d1400a477b0a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -80,12 +80,38 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
 
+static inline bool fwnode_device_is_big_endian(const struct fwnode_handle *fwnode)
+{
+	if (fwnode_property_present(fwnode, "big-endian"))
+		return true;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+	    fwnode_property_present(fwnode, "native-endian"))
+		return true;
+	return false;
+}
+
 static inline
 bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char *compat)
 {
 	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
 }
 
+/**
+ * device_is_big_endian - check if a device has BE registers
+ * @dev: Pointer to the struct device
+ *
+ * Returns: true if the device has a "big-endian" property, or if the kernel
+ * was compiled for BE *and* the device has a "native-endian" property.
+ * Returns false otherwise.
+ *
+ * Callers would nominally use ioread32be/iowrite32be if
+ * device_is_big_endian() == true, or readl/writel otherwise.
+ */
+static inline bool device_is_big_endian(const struct device *dev)
+{
+	return fwnode_device_is_big_endian(dev_fwnode(dev));
+}
+
 /**
  * device_is_compatible - match 'compatible' property of the device with a given string
  * @dev: Pointer to the struct device
-- 
2.40.0.1.gaa8946217a0b

