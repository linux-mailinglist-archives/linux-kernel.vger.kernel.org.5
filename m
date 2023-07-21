Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FA75C768
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGUNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGUNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:13:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F9CE68
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689945185; x=1721481185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vg8rWD7w0qiY2FAJ7+yQ72xVtJTy03qbBGWXgMhMiaU=;
  b=J9pyo7NeNF7pWoYNilppok7F9GUXhTBQ9t5VfdpKfv8Nc+RMIJV8we49
   +eAjlDaEbySj8qdEVT5EoxIOMrXxOH0/B32e+BRcyoFrcPFDbdc+vlVfL
   B3J7hSo1MdqjcGjNPeKa5CqD6aVovOzVYSfA66iZ9wdZzOQwTRh4l2Lzl
   C4DWb/LHAEdT7kO7U0S8U6dkkfZqxaJP+PhRVon7StqZbzsRdZrH2SBM5
   62xvVs8wqTfbVVbwM2Yj7jwQBsqUOzRUCEz14zcvkQHSEeARRf3wiOWWo
   bsWfSV4x+wYhghHQFKIJjgDrQafcfqQsfNO+REBFXDLqRlNOYzzNg8nHk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364481804"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="364481804"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724867908"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724867908"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2023 06:13:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 98012370; Fri, 21 Jul 2023 16:13:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 1/1] driver core: Move dev_err_probe() to where it belogs
Date:   Fri, 21 Jul 2023 16:13:09 +0300
Message-Id: <20230721131309.16821-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() belongs to the printing API, hence
move the definition from device.h to dev_printk.h.

There is no change to the callers at all, since:
1) implementation is located in the same core.c;
2) dev_printk.h is guaranteed to be included by device.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dev_printk.h | 2 ++
 include/linux/device.h     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 8904063d4c9f..6bfe70decc9f 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -274,4 +274,6 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+__printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+
 #endif /* _DEVICE_PRINTK_H_ */
diff --git a/include/linux/device.h b/include/linux/device.h
index 6731d7dc1a2a..2ee6023b427a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1241,8 +1241,6 @@ void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
-__printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
-
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.40.0.1.gaa8946217a0b

