Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976CF7CA975
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjJPNb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjJPNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:31:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D165130
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697463101; x=1728999101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4roMkrTkBxn5M4KrWiiG+UKPCzazaRQ4mwiu9FhhIQM=;
  b=c4Obzebx+22ek0tTzWqTdZ6SDlbcc4z010e8tysMxRi3YLNXIXXGRqv4
   gJL0bQAGdxB+RqzG78A0fM9M/NMz+YLscXvf2gjHXhoh2UZWk86bx/i9A
   Mdp/zEZqGey2396OtzKkbrmlH6a+wmTMbu1y+jk7sVSW7CEMzik6SxJ/x
   QtDzaTTet6Iwnfo1ac0J8YXwz+x4Z6nAIVNWr0fLPbevlja2ioLeN1ifN
   4j4Pxg9L7rLQn/DUhb1tsrGz4inu+qGz6xvLeu+2TvhDFiUzbkcQR1n5n
   SZulLF1eRGyL2EvN2cHu95BpinXrB7nQ0+bzkYfV5okYQy/+lzjvpqX+O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375892089"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="375892089"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1002934884"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1002934884"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2023 06:31:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 566CE81C; Mon, 16 Oct 2023 16:31:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [resend, PATCH v1 2/3] parport: Use list_for_each() helper
Date:   Mon, 16 Oct 2023 16:31:34 +0300
Message-Id: <20231016133135.1203643-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016133135.1203643-1-andriy.shevchenko@linux.intel.com>
References: <20231016133135.1203643-1-andriy.shevchenko@linux.intel.com>
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

Convert hard to read custom code to list_for_each().
No functional changes intended.

Note, we may not use list_for_each_entry() as at the end of the list
the iterator will point to an invalid entry and may not be dereferenced.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/share.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 8037bcd07bcf..38780f6a9119 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -469,9 +469,11 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	/* Search for the lowest free parport number. */
 
 	spin_lock(&full_list_lock);
-	for (l = all_ports.next, num = 0; l != &all_ports; l = l->next, num++) {
+	num = 0;
+	list_for_each(l, &all_ports) {
 		struct parport *p = list_entry(l, struct parport, full_list);
-		if (p->number != num)
+
+		if (p->number != num++)
 			break;
 	}
 	tmp->portnum = tmp->number = num;
-- 
2.40.0.1.gaa8946217a0b

