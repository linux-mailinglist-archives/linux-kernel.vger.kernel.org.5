Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A67CE091
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345127AbjJRO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjJRO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:59:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E503DBA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697641166; x=1729177166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=efWEYbNSPrNMZw5ETi6i0i2V6S/DkOB90d/QiicL5io=;
  b=iO68uudAKL04XHbvl9/MnIJEEBcn1e2njJOUZeJTYKGQgF6YuM4LkplH
   ro8UAUFC0fAiogQrQ/l9jI7OXQdu0tMjHNDdrKnKsrSpxOGFhCNGLazCm
   1TdMZN9fRdeOm95w7NHYIyoWwpqiio3OgZLiyAWMisRzkwMbIJseDWN12
   tpdyY0MJUydljB6Pc0M2rMAZw7LOtpnDcRbyitVu3AO6aoGYHS2OcFaz7
   +fjiRzJ9u3sVP8Z1yAmAk0V7QPnSmxKApMM5EjyPOLR2H9RvRBkkQlU2L
   wnbQ9ac3YBEJVpP/JSFhHEauc1+sHVMIVYZcesk0IrcfQSWHkbe3MzZpM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417140771"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="417140771"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:59:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="873046332"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="873046332"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2023 07:59:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 97E3317F; Wed, 18 Oct 2023 17:58:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1 1/2] parport: Clean up resources correctly when parport_register_port() fails
Date:   Wed, 18 Oct 2023 17:58:55 +0300
Message-Id: <20231018145856.1367607-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

The smatch warns about uncleaned resources in case the
parport_register_port() fails:

  parport_register_port() warn: '&tmp->full_list' not removed from list

This is indeed an issue introduced when converting code to use
kasprintf(). However, the whole kasprintf() dance in this case
is not needed as dev_set_name() can handle the formatted input
and produces the same result. So, the solution is to delegate
name forming to the dev_set_name() and make device_register()
error path to deal with error handling (via put_device() call).

Fixes: 8d8ae17eb0de ("parport: Use kasprintf() instead of fixed buffer formatting")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202310180809.hepZB9k6-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/share.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index a9a9cb0477ea..048a459ce4b0 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -361,7 +361,6 @@ static void free_port(struct device *dev)
 		kfree(port->probe_info[d].description);
 	}
 
-	kfree(port->name);
 	kfree(port);
 }
 
@@ -479,16 +478,13 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	/*
 	 * Now that the portnum is known finish doing the Init.
 	 */
-	tmp->name = kasprintf(GFP_KERNEL, "parport%d", tmp->portnum);
-	if (!tmp->name) {
-		kfree(tmp);
-		return NULL;
-	}
-	dev_set_name(&tmp->bus_dev, tmp->name);
+	dev_set_name(&tmp->bus_dev, "parport%d", tmp->portnum);
 	tmp->bus_dev.bus = &parport_bus_type;
 	tmp->bus_dev.release = free_port;
 	tmp->bus_dev.type = &parport_device_type;
 
+	tmp->name = dev_name(&tmp->bus_dev);
+
 	for (device = 0; device < 5; device++)
 		/* assume the worst */
 		tmp->probe_info[device].class = PARPORT_CLASS_LEGACY;
-- 
2.40.0.1.gaa8946217a0b

