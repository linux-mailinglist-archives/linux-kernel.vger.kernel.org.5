Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5067D77F62D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350723AbjHQMOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350766AbjHQMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:13:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA62D5F;
        Thu, 17 Aug 2023 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274432; x=1723810432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YdKvmJkx0taZIMmCDlV5XFyXWw83oS68W0jEx0NbmOI=;
  b=YH/BigJTsqjUyNShP4rKFlXcg0almWj2k3BZNejbu9mRKtxvVvZ922oR
   GZXK6wDQ7+zgv+CpqQ3pJU0hZ6Z4Z7oe9amMo+e57RL/HUTQGYMdt652E
   PMK+onaiA1lDJeQcm7xjYhy882HIAHMywytwapKPOY4uIN8hhrAQr7aEI
   mSbRsogKQuQbDYl85RyecRsRDHawqx8mR+z2tp12iVb+UF0HMMml4Pbal
   re1Lt18GSwWri7y8UnNLiIlQriDTg3hQF9TrzS3jfrfGHh29bI+W+oTii
   cb6OPu5NIjDLmbGNQ8aJgwZaPpAOA4K1daZvqFaybac6LIFxRuLN3Byy9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371697383"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371697383"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="684403101"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="684403101"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2023 05:13:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4D59ADE4; Thu, 17 Aug 2023 15:13:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] usbip: Use platform_device_register_full()
Date:   Thu, 17 Aug 2023 15:13:00 +0300
Message-Id: <20230817121300.501637-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to create the child platform device is essentially the same as
what platform_device_register_full() does, so change over to use
that same function to reduce duplication.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/usbip/vhci_hcd.c | 42 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 37d1fc34e8a5..101700c89461 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1493,13 +1493,10 @@ static struct platform_driver vhci_driver = {
 
 static void del_platform_devices(void)
 {
-	struct platform_device *pdev;
 	int i;
 
 	for (i = 0; i < vhci_num_controllers; i++) {
-		pdev = vhcis[i].pdev;
-		if (pdev != NULL)
-			platform_device_unregister(pdev);
+		platform_device_unregister(vhcis[i].pdev);
 		vhcis[i].pdev = NULL;
 	}
 	sysfs_remove_link(&platform_bus.kobj, driver_name);
@@ -1519,45 +1516,32 @@ static int __init vhci_hcd_init(void)
 	if (vhcis == NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < vhci_num_controllers; i++) {
-		vhcis[i].pdev = platform_device_alloc(driver_name, i);
-		if (!vhcis[i].pdev) {
-			i--;
-			while (i >= 0)
-				platform_device_put(vhcis[i--].pdev);
-			ret = -ENOMEM;
-			goto err_device_alloc;
-		}
-	}
-	for (i = 0; i < vhci_num_controllers; i++) {
-		void *vhci = &vhcis[i];
-		ret = platform_device_add_data(vhcis[i].pdev, &vhci, sizeof(void *));
-		if (ret)
-			goto err_driver_register;
-	}
-
 	ret = platform_driver_register(&vhci_driver);
 	if (ret)
 		goto err_driver_register;
 
 	for (i = 0; i < vhci_num_controllers; i++) {
-		ret = platform_device_add(vhcis[i].pdev);
+		struct platform_device_info pdevinfo = {
+			.name = driver_name,
+			.id = i,
+			.data = &vhcis[i],
+			.size_data = sizeof(void *),
+		};
+
+		vhcis[i].pdev = platform_device_register_full(&pdevinfo);
+		ret = PTR_ERR_OR_ZERO(vhcis[i].pdev);
 		if (ret < 0) {
-			i--;
-			while (i >= 0)
-				platform_device_del(vhcis[i--].pdev);
+			while (i--)
+				platform_device_unregister(vhcis[i].pdev);
 			goto err_add_hcd;
 		}
 	}
 
-	return ret;
+	return 0;
 
 err_add_hcd:
 	platform_driver_unregister(&vhci_driver);
 err_driver_register:
-	for (i = 0; i < vhci_num_controllers; i++)
-		platform_device_put(vhcis[i].pdev);
-err_device_alloc:
 	kfree(vhcis);
 	return ret;
 }
-- 
2.40.0.1.gaa8946217a0b

