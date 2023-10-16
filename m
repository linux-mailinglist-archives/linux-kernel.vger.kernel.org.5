Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9014A7CA8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjJPNKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJPNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B3115;
        Mon, 16 Oct 2023 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461792; x=1728997792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0s6SJFl6EojiT5uelJ/E8mqMVnAxTbxFEfT6I0A+Yko=;
  b=XIQViUqaUkxTSJtkmExSMurd8hYWpg470aQbp4W7QfjD9UaDYG1EFdM9
   erhPOvRO0zxFjoXJXPJLpiWsQ9G6TJJCN+oaKVvpZLkleYC8KcDTFM15p
   r5C9Q1yDF4kWMJSrqRJtXYv2vkmK+PVMFTlwx9QxehRL9OEtMCa+wA4ku
   IRJFFBNQYAzgvzhSFbhWF7tB2KJfbbKteUp0hWCOGDAoOGEz2D4Sgl4Wq
   9WjcfX2/hPnDzjjDxyzek02vQTUag9xt/lqFkLwzUtln2bfMcJJ7fomR+
   udcwlwl1MBVx0Q02N4E7cwetWHDxf+nABwCzNmggt22IljJdgIAOM/RSn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416590161"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="416590161"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="759385518"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="759385518"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2023 06:09:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 401CDA4A; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 07/10] xhci: dbc: Replace custom return value with proper Linux error code
Date:   Mon, 16 Oct 2023 16:09:31 +0300
Message-Id: <20231016130934.1158504-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
References: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the custom return value with proper Linux error code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index c211c69e8041..779a564ad698 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -593,7 +593,7 @@ static int xhci_do_dbc_start(struct xhci_dbc *dbc)
 static int xhci_do_dbc_stop(struct xhci_dbc *dbc)
 {
 	if (dbc->state == DS_DISABLED)
-		return -1;
+		return -EINVAL;
 
 	writel(0, &dbc->regs->control);
 	dbc->state = DS_DISABLED;
-- 
2.40.0.1.gaa8946217a0b

