Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390C479B4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbjIKVhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbjIKQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:50:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905BCE74;
        Mon, 11 Sep 2023 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694451005; x=1725987005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rnth3nk9w2P6WubF+nrU/c+EVNi8f/hUpA3i3yINb04=;
  b=P4HbMeKEWkOQ/2ZuZqCtjUatg6h1B5ykXsrJKeZFKPERscVXuVxlUo5X
   zegcQvnlXzepE2ZFIaR2Zg3w7V0G9jK8iPoSoHP3cIAKaQz0pIQVERzRg
   c/rGIzHDn+LnTa1NECse6pxigkmdzYINV8jNK+Fr/6kxHCQeT0rQ7oqIs
   nqJZyvG0DDlUO7l9yoChPVAXHBFCAddzJOPPHHaybnd05iEIfoC1wggT0
   oUgVmc2Tea798DkZ4RrMH/n2u+oownu22yORzjpRIkv1ODxKQtCkWlC9U
   +GQYSc50Hb42IOee1dS3dL8x088Nmpyx15W2JbgvwrkemPHYLAeiK9NTZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444568878"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444568878"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833563832"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="833563832"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2023 09:27:21 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] usb: typec: ucsi: Release debugfs only if it has been allocated
Date:   Tue, 12 Sep 2023 00:27:06 +0800
Message-Id: <20230911162706.2856910-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following NULL pointer exception was found during boot up:

 calling  ucsi_acpi_platform_driver_init+0x0/0xff0 [ucsi_acpi] @ 394
 initcall mac_hid_init+0x0/0xff0 [mac_hid] returned 0 after 5 usecs
 BUG: kernel NULL pointer dereference, address: 0000000000000020
 Call Trace:
  ? ucsi_debugfs_unregister+0x15/0x30 [typec_ucsi]
  ucsi_destroy+0x17/0x30 [typec_ucsi]
  ucsi_acpi_probe+0x1d5/0x230 [ucsi_acpi]

It is possible that ucsi_acpi_probe() fails to install the notifier,
and calls ucsi_destroy() to release the resource. However at that
moment the debugfs has not been registered yet, thus the NULL pointer
exception is triggered. Add the check for debugfs pointer.

Fixes: Commit df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/usb/typec/ucsi/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
index 0c7bf88d4a7f..55533dc3d539 100644
--- a/drivers/usb/typec/ucsi/debugfs.c
+++ b/drivers/usb/typec/ucsi/debugfs.c
@@ -84,7 +84,8 @@ void ucsi_debugfs_register(struct ucsi *ucsi)
 
 void ucsi_debugfs_unregister(struct ucsi *ucsi)
 {
-	debugfs_remove_recursive(ucsi->debugfs->dentry);
+	if (ucsi->debugfs)
+		debugfs_remove_recursive(ucsi->debugfs->dentry);
 	kfree(ucsi->debugfs);
 }
 
-- 
2.25.1

