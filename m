Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D927CA8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjJPNKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjJPNJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B76D10E;
        Mon, 16 Oct 2023 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461792; x=1728997792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C2LXIp8aDjt+KK6t7A/TPFPz1sfKbc8zCp7ovuaeChc=;
  b=AyDZbrFeI4AILfaW/oI0CxrSL15v6TqHJfammDH5ah/akitmuh6JdDAZ
   5/V6KEaXVZpE+UYi/GLy721r5ft+Ta2AjlsfCF2sWttbh/INi1g8rQbWV
   RURORGn0F0PP6zNx6Ph8lUbfJUtCMC3wlyW29Kvj31kJz4JJ9NrpG24+H
   fZsZRLysZYyeNgaFpMI+6jKstUk6D6G8c03iLQOC/Q0BtM3Oq+V0a+r/E
   WBLMp6jQW5T5O6YNUVfKtQ1wRCviI9MzeI/O6XsyaF/CD5/MV8JuxbV9m
   +LScTFS+a8obhAiTA3nQBNTxc03WpY/rziwvIMbvM1eG3s72wEgAGH4Dt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4133308"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4133308"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1087067149"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087067149"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 06:09:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 38F76A46; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 06/10] xhci: dbc: Don't shadow error codes in store() functions
Date:   Mon, 16 Oct 2023 16:09:30 +0300
Message-Id: <20231016130934.1158504-7-andriy.shevchenko@linux.intel.com>
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

kstrtox() along with regmap API can return different error codes
based on the circumstances. Don't shadow them when returning to
the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 6b9f4b839270..c211c69e8041 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -977,9 +977,11 @@ static ssize_t dbc_idVendor_store(struct device *dev,
 	void __iomem		*ptr;
 	u16			value;
 	u32			dev_info;
+	int ret;
 
-	if (kstrtou16(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
@@ -1017,9 +1019,11 @@ static ssize_t dbc_idProduct_store(struct device *dev,
 	void __iomem		*ptr;
 	u32			dev_info;
 	u16			value;
+	int ret;
 
-	if (kstrtou16(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
@@ -1056,9 +1060,11 @@ static ssize_t dbc_bcdDevice_store(struct device *dev,
 	void __iomem *ptr;
 	u32 dev_info;
 	u16 value;
+	int ret;
 
-	if (kstrtou16(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
@@ -1098,9 +1104,13 @@ static ssize_t dbc_bInterfaceProtocol_store(struct device *dev,
 	u8 value;
 	int ret;
 
-	/* bInterfaceProtocol is 8 bit, but xhci only supports values 0 and 1 */
+	/* bInterfaceProtocol is 8 bit, but... */
 	ret = kstrtou8(buf, 0, &value);
-	if (ret || value > 1)
+	if (ret)
+		return ret;
+
+	/* ...xhci only supports values 0 and 1 */
+	if (value > 1)
 		return -EINVAL;
 
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
-- 
2.40.0.1.gaa8946217a0b

