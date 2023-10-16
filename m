Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1627CA8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjJPNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjJPNJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144CA107;
        Mon, 16 Oct 2023 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461791; x=1728997791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgxldMpH8a+wqMFSf6j151qigeL3anjzob39MFArgC4=;
  b=jv86L3BTnRvMD2N6nBGInbbsfrt6di4lwmFZqht8utFyVkY2w/dKB/6z
   8IQDG0eAxpzIc95lP8tgAeEEzFqRmBI8srTmVImeioqUvwpANi5qTqCv0
   xgSyfCQHsTwky2GJBvzhLRMNk8WAyeoIcW8gdVZh5/tas/CdWb+j1AfyN
   74UhKxxdcsqplI/n/T/RBVBBP/CKHudNqym2U3yrvSJ62HO9Cu8nhw8OA
   0viHAGNMR2Zb4MvCetWGGD+HZq8sLo+wLKBvacZFcVBSz1ykLX9OFag5W
   iqYbgqj2+I2rquCcFSgVEvB/8exT2vFxk/F0yrriGVLhO2a7z07R0/TDj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4133295"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4133295"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1087067134"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087067134"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 06:09:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C14495B; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 03/10] xhci: dbc: Use sysfs_emit() to instead of scnprintf()
Date:   Mon, 16 Oct 2023 16:09:27 +0300
Message-Id: <20231016130934.1158504-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
References: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/usb/host/xhci-dbgcap.c | 44 +++++++++++++---------------------
 drivers/usb/host/xhci-dbgcap.h |  1 +
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index f505b79afe53..df14e336370d 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -910,41 +910,29 @@ static void xhci_dbc_handle_events(struct work_struct *work)
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
 {
-	const char		*p;
 	struct xhci_dbc		*dbc;
 	struct xhci_hcd		*xhci;
 
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
@@ -977,7 +965,7 @@ static ssize_t dbc_idVendor_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	return sprintf(buf, "%04x\n", dbc->idVendor);
+	return sysfs_emit(buf, "%04x\n", dbc->idVendor);
 }
 
 static ssize_t dbc_idVendor_store(struct device *dev,
@@ -1017,7 +1005,7 @@ static ssize_t dbc_idProduct_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	return sprintf(buf, "%04x\n", dbc->idProduct);
+	return sysfs_emit(buf, "%04x\n", dbc->idProduct);
 }
 
 static ssize_t dbc_idProduct_store(struct device *dev,
@@ -1056,7 +1044,7 @@ static ssize_t dbc_bcdDevice_show(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	return sprintf(buf, "%04x\n", dbc->bcdDevice);
+	return sysfs_emit(buf, "%04x\n", dbc->bcdDevice);
 }
 
 static ssize_t dbc_bcdDevice_store(struct device *dev,
@@ -1096,7 +1084,7 @@ static ssize_t dbc_bInterfaceProtocol_show(struct device *dev,
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

