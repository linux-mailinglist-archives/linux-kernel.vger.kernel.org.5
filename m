Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549DD7CA979
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJPNcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjJPNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:31:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2617181
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697463102; x=1728999102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cdkuTO8u3rbVQRk8x8e3eLaDQYXu7b3sptU0SE6tXHc=;
  b=FICsEJgp9MRABfRfCapKVMFU7ahAwT4XPR+8WonqNzRaGtfDVZkzgsmc
   I6uLsKJ6xn88RIfYqLP/e6HR0lUaoGqGkaKcPq8zARkn6p1ptI6Cjt0N9
   Dgstcq2YqHcp5AB6OfIaYR0U0IMoymIxEot7TejeqUnQWXcUWVHC6/LCn
   WEVvsWJcmKKSofYPpEVdyF3UNqPLulHeRmGI6vpM2p7V7djBpBeKtCkdZ
   zzbCKAysFDhhvuVeayUQ+pYdT2uzZbozuXj0SaH2pRdyZ7u0dwbths89u
   ++CAEWP4vZfa1MHDYUDEDJTKhkJUUYMhbexoYEy9lndiwubfS0+BdGJpJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375892095"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="375892095"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1002934885"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1002934885"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2023 06:31:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5BF63385; Mon, 16 Oct 2023 16:31:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [resend, PATCH v1 3/3] parport: Drop unneeded NULL or 0 assignments
Date:   Mon, 16 Oct 2023 16:31:35 +0300
Message-Id: <20231016133135.1203643-4-andriy.shevchenko@linux.intel.com>
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

kzalloc() gives us a zeroed memory, no need to explicitly assing 0 or
NULL or similar to the members of the data structure that has been
allocated with the above mentioned API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/share.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 38780f6a9119..a9a9cb0477ea 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -449,13 +449,9 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	tmp->irq = irq;
 	tmp->dma = dma;
 	tmp->muxport = tmp->daisy = tmp->muxsel = -1;
-	tmp->modes = 0;
 	INIT_LIST_HEAD(&tmp->list);
-	tmp->devices = tmp->cad = NULL;
-	tmp->flags = 0;
 	tmp->ops = ops;
 	tmp->physport = tmp;
-	memset(tmp->probe_info, 0, 5 * sizeof(struct parport_device_info));
 	rwlock_init(&tmp->cad_lock);
 	spin_lock_init(&tmp->waitlist_lock);
 	spin_lock_init(&tmp->pardevice_lock);
-- 
2.40.0.1.gaa8946217a0b

