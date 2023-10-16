Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4B7CA8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjJPNKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjJPNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4931EB;
        Mon, 16 Oct 2023 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461788; x=1728997788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSDxuqmZzlGLTaad8H323ocWfeLLf3evwalEGIIxd/4=;
  b=XOM8812jA4R+p9xmnk0se/VFY7u06lCigl4tLDe980crf/LroXAHGAkk
   xaqZNghZ9L5TRtsVqA76O6zAHslYIdND4Zo5m5WWC/dCSusvUcClLtZad
   22GvtseLLgvagfLQHW1VSUoXoHqOMAVKZftOXpxeCoPN6RzllsO0hyacB
   LIOhAk6QJASSaX+ng259I5vmQTj3/39nFWjVGqS+9dK5SIE//pE21sGMP
   N6i35D1lVTrK7Kv/rwxvev9uKaP7Sz21BpqUt8VlQNUWMFaT/YQEYp43l
   TgH2SydHlqM9Y3Es37RtBpdO4TV+/iGk4ZpAlnmavf6j7M38N4ZTAW+o9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416590164"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="416590164"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="759385520"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="759385520"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2023 06:09:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30EBE9CE; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 05/10] xhci: dbc: Check for errors first in xhci_dbc_stop()
Date:   Mon, 16 Oct 2023 16:09:29 +0300
Message-Id: <20231016130934.1158504-6-andriy.shevchenko@linux.intel.com>
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

The usual patter is to check for errors and then continue if none.
Apply that pattern to xhci_dbc_stop() code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 660e3ee31dc6..6b9f4b839270 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -646,11 +646,11 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
 	spin_lock_irqsave(&dbc->lock, flags);
 	ret = xhci_do_dbc_stop(dbc);
 	spin_unlock_irqrestore(&dbc->lock, flags);
+	if (ret)
+		return;
 
-	if (!ret) {
-		xhci_dbc_mem_cleanup(dbc);
-		pm_runtime_put_sync(dbc->dev); /* note, was self.controller */
-	}
+	xhci_dbc_mem_cleanup(dbc);
+	pm_runtime_put_sync(dbc->dev); /* note, was self.controller */
 }
 
 static void
-- 
2.40.0.1.gaa8946217a0b

