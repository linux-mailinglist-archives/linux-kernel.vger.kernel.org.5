Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCB275D03F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGURAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGURAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7426A0;
        Fri, 21 Jul 2023 10:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958821; x=1721494821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFTy3k5fjmzvEVapIibfwY9OKXik6UjBLw7ZmKrmWGc=;
  b=mujet7A7G3cW9RxjpJlxrLBXPxjpvfvbbNyXEUS9B7UDoMPOlJIpwUW3
   PcLMSKN73OoIPB1yv2tNMiv4ohaH4J9wbufRWLtqyZedbcAm0fkumTmiZ
   KWICt0RDZFOSx/mVlxFKuFVDhmdQl4NfbZxQH4BqENv2he2Y5pil368K5
   KeD1yFT1w/7CjthkQh1AOSi51025Ke/nNBy9cdVmhGmTQjYv15xBOPI39
   eYf2Rp/ToISCDt5xiQdzPbVxtGumbFJevh1phIKmT+nk7MYTcd7Bs7OhE
   YiNWQgmlckpcCFQFDBgz5QJBBwutxA6c3oeHqXnujyF79eZR8zpavQivx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453443965"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="453443965"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675106536"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="675106536"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2023 10:00:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D2F866C; Fri, 21 Jul 2023 20:00:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 7/8] iio: core: Move initcalls closer to the respective calls
Date:   Fri, 21 Jul 2023 20:00:21 +0300
Message-Id: <20230721170022.3461-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
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

Move subsys_initcall() and module_exit() closer to the respective calls.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a9b9804097ab..5c9c68d69fc6 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -354,6 +354,7 @@ static int __init iio_init(void)
 error_nothing:
 	return ret;
 }
+subsys_initcall(iio_init);
 
 static void __exit iio_exit(void)
 {
@@ -362,6 +363,7 @@ static void __exit iio_exit(void)
 	bus_unregister(&iio_bus_type);
 	debugfs_remove(iio_debugfs_dentry);
 }
+module_exit(iio_exit);
 
 #if defined(CONFIG_DEBUG_FS)
 static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
@@ -2118,9 +2120,6 @@ int iio_device_get_current_mode(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_device_get_current_mode);
 
-subsys_initcall(iio_init);
-module_exit(iio_exit);
-
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Industrial I/O core");
 MODULE_LICENSE("GPL");
-- 
2.40.0.1.gaa8946217a0b

