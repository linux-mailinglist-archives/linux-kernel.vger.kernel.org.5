Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB24279345E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjIFETC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:19:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3233CF4;
        Tue,  5 Sep 2023 21:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693973937; x=1725509937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vkq0HJpPBcsTFGWnVfPGl7DiFWHsoRcOaXJVkK422Ic=;
  b=n7Dd1lSyRjlE8EcIFq2XpDDtNLyTtIFlMqmZQ9XTAmVT8TVgC2cGXBlh
   bDwL2BF8RgO8bqwaaKLZWoNJ5HYbwQZ9SDhb1HTHXmaf22YtG96TfLhBf
   /kenUN7FAfpDjPe89q4y28xWiT30fz2DBLXnkVrRoojaU5je0KhNJwR1V
   ciHhvJuhjghdn4OxgtZN1Tvj9k/jGVB00HqtB/sAT+tGpc63QDRhsxkel
   ggUZymujQjzV1yR6zhyKApN39aEJ97BrCf3AX6nvJxoI3WTqvt9LV/klw
   X9MxiDIaTRhz7KQmYBtSx/HFJqbNxT6rTYNhMWIo5dt9xtvGfs+bAMwVy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407967853"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="407967853"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831483444"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="831483444"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2023 21:18:55 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chenzhou Feng <chenzhoux.feng@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 1/2] PM: hibernate: Rename the function parameter from snapshot_test to exclusive
Date:   Wed,  6 Sep 2023 12:18:41 +0800
Message-Id: <636a8cc785b35bff4f3e03ae8c6a71c05b4841dc.1693972725.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693972725.git.yu.c.chen@intel.com>
References: <cover.1693972725.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions reply on snapshot_test to decide whether to
open the resume device exclusively. However there is no strict
connection between the snapshot_test and the open mode. Rename
the 'snapshot_test' input parameter to 'exclusive' to better reflect
the use case.

No functional change is expected.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/power.h |  4 ++--
 kernel/power/swap.c  | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 46eb14dc50c3..a98f95e309a3 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -168,11 +168,11 @@ extern int swsusp_swap_in_use(void);
 #define SF_HW_SIG		8
 
 /* kernel/power/hibernate.c */
-int swsusp_check(bool snapshot_test);
+int swsusp_check(bool exclusive);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
-void swsusp_close(bool snapshot_test);
+void swsusp_close(bool exclusive);
 #ifdef CONFIG_SUSPEND
 extern int swsusp_unmark(void);
 #endif
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f6ebcd00c410..74edbce2320b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1513,12 +1513,13 @@ int swsusp_read(unsigned int *flags_p)
 static void *swsusp_holder;
 
 /**
- *      swsusp_check - Check for swsusp signature in the resume device
+ * swsusp_check - Check for swsusp signature in the resume device
+ * @exclusive: Open the resume device exclusively.
  */
 
-int swsusp_check(bool snapshot_test)
+int swsusp_check(bool exclusive)
 {
-	void *holder = snapshot_test ? &swsusp_holder : NULL;
+	void *holder = exclusive ? &swsusp_holder : NULL;
 	int error;
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
@@ -1563,17 +1564,18 @@ int swsusp_check(bool snapshot_test)
 }
 
 /**
- *	swsusp_close - close swap device.
+ * swsusp_close - close swap device.
+ * @exclusive: Close the resume device which is exclusively opened.
  */
 
-void swsusp_close(bool snapshot_test)
+void swsusp_close(bool exclusive)
 {
 	if (IS_ERR(hib_resume_bdev)) {
 		pr_debug("Image device not initialised\n");
 		return;
 	}
 
-	blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
+	blkdev_put(hib_resume_bdev, exclusive ? &swsusp_holder : NULL);
 }
 
 /**
-- 
2.25.1

