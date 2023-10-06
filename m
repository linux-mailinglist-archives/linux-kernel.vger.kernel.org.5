Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6367BBD24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjJFQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJFQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:46:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614DDD58;
        Fri,  6 Oct 2023 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696610676; x=1728146676;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q/fbl8MRoHNlScwMG1/DLFJFN//gIakiG3syYUF579U=;
  b=GOqUp5cKYLZMRlzVJqRWnytlUT7XPLcrt5niy0SJhEe6H4C/KnDPZgcr
   ER/S1xErSYVb5BM/UKqaSjDTirZlxpa+nHdi1JvskQorMS9rJlmp7y7mp
   KmtpfgMfszxGd/KoWGoaTqRyxMarM9IUfz6wkxKTUveLZSg0F8zar8GfG
   jMTZ/rDkfGuNrxyikSCUgr6wO4O0P4ULx7chfn0j6WafwcLa6U8XEb8zH
   M3UT/iEG2bECV9l1ldfoh4DvkU1vxYUyJoSLcrwKgHrrsQJG6vT1Lf2gf
   h1xTCi3oWDQtFDb9QbaiEHseM2bU4uoYwMBsG//kayyZ0tih5NPjctu5J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="383672548"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="383672548"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 09:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="787448487"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="787448487"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2023 09:43:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4506C430; Fri,  6 Oct 2023 19:43:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/1] usbip: Use platform_device_register_full()
Date:   Fri,  6 Oct 2023 19:43:12 +0300
Message-Id: <20231006164312.3528524-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v2: (hopefully) fixed run-time NULL-dereference (LKP)
 drivers/usb/usbip/vhci_hcd.c | 55 +++++++++++++-----------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 37d1fc34e8a5..f845b91848b9 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1139,7 +1139,8 @@ static int hcd_name_to_id(const char *name)
 
 static int vhci_setup(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
+	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
+
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		vhci->vhci_hcd_hs = hcd_to_vhci_hcd(hcd);
 		vhci->vhci_hcd_hs->vhci = vhci;
@@ -1256,7 +1257,7 @@ static int vhci_get_frame_number(struct usb_hcd *hcd)
 /* FIXME: suspend/resume */
 static int vhci_bus_suspend(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
+	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
 	unsigned long flags;
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
@@ -1270,7 +1271,7 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
 
 static int vhci_bus_resume(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
+	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
 	int rc = 0;
 	unsigned long flags;
 
@@ -1337,7 +1338,7 @@ static const struct hc_driver vhci_hc_driver = {
 
 static int vhci_hcd_probe(struct platform_device *pdev)
 {
-	struct vhci             *vhci = *((void **)dev_get_platdata(&pdev->dev));
+	struct vhci             *vhci = dev_get_platdata(&pdev->dev);
 	struct usb_hcd		*hcd_hs;
 	struct usb_hcd		*hcd_ss;
 	int			ret;
@@ -1395,7 +1396,7 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 
 static void vhci_hcd_remove(struct platform_device *pdev)
 {
-	struct vhci *vhci = *((void **)dev_get_platdata(&pdev->dev));
+	struct vhci *vhci = dev_get_platdata(&pdev->dev);
 
 	/*
 	 * Disconnects the root hub,
@@ -1430,7 +1431,7 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 	if (!hcd)
 		return 0;
 
-	vhci = *((void **)dev_get_platdata(hcd->self.controller));
+	vhci = dev_get_platdata(hcd->self.controller);
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -1493,13 +1494,10 @@ static struct platform_driver vhci_driver = {
 
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
@@ -1519,45 +1517,32 @@ static int __init vhci_hcd_init(void)
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

