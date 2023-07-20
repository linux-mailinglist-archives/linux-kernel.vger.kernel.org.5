Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48875B8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGTUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGTUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:53:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3627271D;
        Thu, 20 Jul 2023 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689886405; x=1721422405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gvmEe3/mK3F1A2VhT834ZdAXT1htPyMLu4MYEFgzHY=;
  b=CraRJbn9hXjdDioAnzg2J1C7xgaeA1PGgO9Q/hhAWsG4oIBfziMrQvdE
   VJpVj/UKpLN34dvMSeSLq+zxX9ibl43ajxvs3ZBsECyqSkW7ElRQQHzvt
   8BeCUh+wI/yU7g9GAG70utcCRMInvJfOyx+z8fauHwMe6d+c0ZrjvHjwT
   vapl8Bb6LbLncQRhIPN/wZPoIbxwBRpkW+1v6X9i0w1BbIPcsKh7BDnLH
   L477mo04hshLMuBcpSCxrTorgZMZi7ZQlUoZ78a3CkHjV0noAK42B8Ly/
   4QtR/yRPwkdT7kTlQk7mhpb43/k+SSNIlkW65zHgpz2/K8v/HCnVhsZ9W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356846054"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="356846054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838273950"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="838273950"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 13:53:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E85069A; Thu, 20 Jul 2023 23:53:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 7/8] iio: core: Move initcalls closer to the respective calls
Date:   Thu, 20 Jul 2023 23:53:23 +0300
Message-Id: <20230720205324.58702-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move subsys_initcall() and module_exit() closer to the respective calls.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e29772940886..202a1a67ba98 100644
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

