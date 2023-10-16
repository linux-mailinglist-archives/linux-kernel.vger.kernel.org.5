Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F917CA8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjJPNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjJPNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836BF5;
        Mon, 16 Oct 2023 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461787; x=1728997787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5wFq2LWIAxkbz3owrFJUzWLLHVZI7rE5EIksKjGKEtQ=;
  b=dfok7jafci87ko77G726DMhHigZPsbaTky0XT2Ty5RmmAqX4eGd/tCYq
   PDFXk8uRZ4JndD5CZa1XwuYAiTmJEk/L8wX+GfMT0Co7C5MYWoHJ5pSEM
   1l/2MsvRg1P/uMW3M9DkG0NEO+uM3D+xqxxLFO+AIJuQ+ph49IJmfuVaq
   vm/kS8GnKCWpS+ejtKjQGQ/9M4Xc7haJ8UPTGOeQ8Lc34IFl+2YZdaKwV
   p56L/Ogj/OwYMhYYX1qG8kdmhQNq0I/NX2uTMiQZYkI60C6CT8dxmVER/
   97o/7WdwuIbL1FFK3DHum3kWIPDOR3nCmjkv1J1acZbX9ggvL5TQ4FQWp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416590139"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="416590139"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="759385503"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="759385503"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2023 06:09:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 10A7285E; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 02/10] xhci: dbc: Convert to use sysfs_streq()
Date:   Mon, 16 Oct 2023 16:09:26 +0300
Message-Id: <20231016130934.1158504-3-andriy.shevchenko@linux.intel.com>
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

It's standard approach to parse values from user space by using
sysfs_streq(). Make driver use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 9e9ce3711813..f505b79afe53 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -957,9 +957,9 @@ static ssize_t dbc_store(struct device *dev,
 	xhci = hcd_to_xhci(dev_get_drvdata(dev));
 	dbc = xhci->dbc;
 
-	if (!strncmp(buf, "enable", 6))
+	if (sysfs_streq(buf, "enable"))
 		xhci_dbc_start(dbc);
-	else if (!strncmp(buf, "disable", 7))
+	else if (sysfs_streq(buf, "disable"))
 		xhci_dbc_stop(dbc);
 	else
 		return -EINVAL;
-- 
2.40.0.1.gaa8946217a0b

