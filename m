Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D2C7B5877
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbjJBQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbjJBQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:18:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0559493;
        Mon,  2 Oct 2023 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696263529; x=1727799529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CY4OM5esL8i/3kUHybBmDSjRpzOpgGo+r8iIQDCl14A=;
  b=BDKy8ml9CK0ISKHn6ltB8qkcW1vsU4Lb6LFS4B/NJ1JHTBfXzHLEmA8a
   HCyOfrm1fvCVwd88SyK9xDq0KR7/KnxE0VrnAUgIxuamPkAfpuT6TUkbP
   qWY6/AQhR5mPVd4mFETgcX6XISHZ5M0cXpPm4A86+6K5GXm2QkxRWKo2C
   NkhAnn8r6gSxeDfQ0TSDxkWHqJX7Jk3zlDILrfpyPd9oCH+bNqJ5cZEVi
   0PJD306z4UUOGfSRJOi36jdNt1B8EZfQYvXDrHwbqKmoSKqTy5e6auMqa
   QlRJiG/tpnt2et69ieBWaTaQJo2vapNYdq67d2YfPDVYlAVbheUtUPNAx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362949511"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362949511"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816339768"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816339768"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2023 09:16:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3069B2FF; Mon,  2 Oct 2023 19:16:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 03/10] xhci: dbc: Use sysfs_emit() to instead of scnprintf()
Date:   Mon,  2 Oct 2023 19:16:03 +0300
Message-Id: <20231002161610.2648818-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
References: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
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

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 43 +++++++++++++---------------------
 drivers/usb/host/xhci-dbgcap.h |  1 +
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index f505b79afe53..92869c67a430 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -910,6 +910,15 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 	mod_delayed_work(system_wq, &dbc->event_work, 1);
 }
 
+static const char * const dbc_state_strings[DS_MAX] = {
+	[DS_DISABLED] = "disabled",
+	[DS_INITIALIZED] = "initialized",
+	[DS_ENABLED] = "enabled",
+	[DS_CONNECTED] = "connected",
+	[DS_CONFIGURED] = "configured",
+	[DS_STALLED] = "stalled",
+};
+
 static ssize_t dbc_show(struct device *dev,
 			struct device_attribute *attr,
 			char *buf)
@@ -921,30 +930,10 @@ static ssize_t dbc_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	switch (dbc->state) {
-	case DS_DISABLED:
-		p = "disabled";
-		break;
-	case DS_INITIALIZED:
-		p = "initialized";
-		break;
-	case DS_ENABLED:
-		p = "enabled";
-		break;
-	case DS_CONNECTED:
-		p = "connected";
-		break;
-	case DS_CONFIGURED:
-		p = "configured";
-		break;
-	case DS_STALLED:
-		p = "stalled";
-		break;
-	default:
-		p = "unknown";
-	}
+	if (dbc->state >= ARRAY_SIZE(dbc_state_strings))
+		return sysfs_emit(buf, "unknown\n");
 
-	return sprintf(buf, "%s\n", p);
+	return sysfs_emit(buf, "%s\n", dbc_state_strings[dbc->state]);
 }
 
 static ssize_t dbc_store(struct device *dev,
@@ -977,7 +966,7 @@ static ssize_t dbc_idVendor_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	return sprintf(buf, "%04x\n", dbc->idVendor);
+	return sysfs_emit(buf, "%04x\n", dbc->idVendor);
 }
 
 static ssize_t dbc_idVendor_store(struct device *dev,
@@ -1017,7 +1006,7 @@ static ssize_t dbc_idProduct_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	return sprintf(buf, "%04x\n", dbc->idProduct);
+	return sysfs_emit(buf, "%04x\n", dbc->idProduct);
 }
 
 static ssize_t dbc_idProduct_store(struct device *dev,
@@ -1056,7 +1045,7 @@ static ssize_t dbc_bcdDevice_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	return sprintf(buf, "%04x\n", dbc->bcdDevice);
+	return sysfs_emit(buf, "%04x\n", dbc->bcdDevice);
 }
 
 static ssize_t dbc_bcdDevice_store(struct device *dev,
@@ -1096,7 +1085,7 @@ static ssize_t dbc_bInterfaceProtocol_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	return sprintf(buf, "%02x\n", dbc->bInterfaceProtocol);
+	return sysfs_emit(buf, "%02x\n", dbc->bInterfaceProtocol);
 }
 
 static ssize_t dbc_bInterfaceProtocol_store(struct device *dev,
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 51a7ab3ba0ca..e39e3ae1677a 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -82,6 +82,7 @@ enum dbc_state {
 	DS_CONNECTED,
 	DS_CONFIGURED,
 	DS_STALLED,
+	DS_MAX
 };
 
 struct dbc_ep {
-- 
2.40.0.1.gaa8946217a0b

