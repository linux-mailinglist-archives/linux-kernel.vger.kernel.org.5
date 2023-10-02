Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B47B5860
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbjJBQTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbjJBQTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:19:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE5BCD6;
        Mon,  2 Oct 2023 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696263548; x=1727799548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5wFq2LWIAxkbz3owrFJUzWLLHVZI7rE5EIksKjGKEtQ=;
  b=PpFW3mKAiAIUu2fzvk8U0OGsGAiZ1zEf0lfKQdCsCXM/SvSOawp4DSSm
   gBr0CkqT9xF/MMkhcnaQHit8mha54gqe+6ArH+fpaPycYhX9Osk6raeMP
   LfQP62lcRDkFspccQpxX14dkVHTGIIZDB3lD727ML9hp2u3oKf5YjIfi1
   PUS4C7UuRhmV3U52uneuKxZwLsbOXPg/vNqijZu6u9/xCzV+DkBN5CTpS
   xt1kWslJIJFQQ8zmgPIOlh1apUK5icYWqzgBXc2EZqhjVOqrqtZYzuZUz
   blcC/29iGAdPU16Z/nV7ff3d8xvLXfqmJFvcTailbg/q65fSYjppj5dkX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382588645"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382588645"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841031505"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="841031505"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2023 09:16:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2AAC894; Mon,  2 Oct 2023 19:16:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 02/10] xhci: dbc: Convert to use sysfs_streq()
Date:   Mon,  2 Oct 2023 19:16:02 +0300
Message-Id: <20231002161610.2648818-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
References: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

