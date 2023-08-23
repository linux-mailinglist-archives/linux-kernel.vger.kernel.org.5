Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741F7852A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHWIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjHWIWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:22:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5310C2;
        Wed, 23 Aug 2023 01:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692778743; x=1724314743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8VGHBXydLPE3MC5NdTIE4LrW+tQQYjYZljdXLkryB8A=;
  b=mCu63mKdPSh9bKPBLcF641b5NHq3BhfySnilE/XDQ7wHh1YiwEIG/lOc
   aZZQGkY4ZT7UVddy/qRigoedDZRHnhjJqBvOK7gYqwJmgOocfjf30oWw2
   ueOCa+YBo7Vc1LlzkiCE6P2VGkkXzif7erlQS9CSKaExrgqObRNYO/EHx
   tTILizUFvtzj9yuBidf0C/EkEgLtrCyv8Wwv23DSVNroP+pJdUb20yRxU
   esx1my/oKuqiOVdmbf8aB2smaoO/C5N7gEJNtoauCccY5ofyOv+zAARQl
   4AWCXnG6VoDOcT2npd56+OHD5XC4oxVabkYRGYDYkr+3RYiaj00Yhjo0W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372990795"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="372990795"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 01:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="1067390623"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1067390623"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2023 01:19:01 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chenzhou Feng <chenzhoux.feng@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
Subject: [PATCH] PM: hibernate: Fix the exclusive get block device in test_resume mode
Date:   Thu, 24 Aug 2023 00:13:29 +0800
Message-Id: <20230823161329.7348-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5904de0d735b ("PM: hibernate: Do not get block device exclusively
in test_resume mode") fixes a hibernation issue under test_resume mode.
That commit is supposed to open the block device in non-exclusive mode
when in test_resume. However the code did the opposite, which is against
its description.

Fix this by really disabling exclusive mode under test_resume.

Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000761f5f0603324129@google.com/
Fixes: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f6ebcd00c410..c12b34dd529c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1518,7 +1518,7 @@ static void *swsusp_holder;
 
 int swsusp_check(bool snapshot_test)
 {
-	void *holder = snapshot_test ? &swsusp_holder : NULL;
+	void *holder = snapshot_test ? NULL : &swsusp_holder;
 	int error;
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
@@ -1573,7 +1573,7 @@ void swsusp_close(bool snapshot_test)
 		return;
 	}
 
-	blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
+	blkdev_put(hib_resume_bdev, snapshot_test ? NULL : &swsusp_holder);
 }
 
 /**
-- 
2.25.1

