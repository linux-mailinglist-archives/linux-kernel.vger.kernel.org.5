Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97EB7D2919
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJWDa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjJWDaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:30:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517C10D3;
        Sun, 22 Oct 2023 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698031815; x=1729567815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KyMoHWShCcyV3MRbZKpVC/E1DYBRT6LqwzkBXptqrAo=;
  b=MVYBsTvjipWSPUfEAWKwEazuwuFGsD9t8K10AxLyA567jfWDB0D2+rnb
   4qndguMndfcI8U+nOsc700nL0kRL+3tn4EUVpfYflNSMKzQVXij6Fhn0M
   cSjQbYCQCrRaovgoZi9bnOoKV+ZKjEyiFCL9xlRl9k9LU+kwl742LIjVe
   UVAK/oxeax8xlOdQ0FZ48jzOm/SJOERgHgIWpDqnF5TKGRUjz1YUIklJo
   n3hQxii/pOxwVbwpuOqBvZCPido/E1OgiFDropS5OIkdyVgA4YBLaZx8t
   xA7Bjsn+4vEmq3jSq+TXyzZgo8HqJ5eQRxMfuqJcYDm11g8zlm0v1WDcp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="5380110"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5380110"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 20:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="881617680"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881617680"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2023 20:30:13 -0700
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     gregkh@linuxfoundation.org
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com
Subject: [RESEND PATCH 2/2] fpga: Fix memory leak for fpga_region_test_class_find()
Date:   Mon, 23 Oct 2023 11:28:57 +0800
Message-Id: <20231023032857.902699-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023032857.902699-1-yilun.xu@linux.intel.com>
References: <20231023032857.902699-1-yilun.xu@linux.intel.com>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

fpga_region_class_find() in fpga_region_test_class_find() will call
get_device() if the data is matched, which will increment refcount for
dev->kobj, so it should call put_device() to decrement refcount for
dev->kobj to free the region, because fpga_region_unregister() will call
fpga_region_dev_release() only when the refcount for dev->kobj is zero
but fpga_region_test_init() call device_register() in
fpga_region_register_full(), which also increment refcount.

So call put_device() after calling fpga_region_class_find() in
fpga_region_test_class_find(). After applying this patch, the following
memory leak is never detected.

unreferenced object 0xffff88810c8ef000 (size 1024):
  comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
  hex dump (first 32 bytes):
    b8 d1 fb 05 81 88 ff ff 08 f0 8e 0c 81 88 ff ff  ................
    08 f0 8e 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff817ebad7>] kmalloc_trace+0x27/0xa0
    [<ffffffffa02385e1>] fpga_region_register_full+0x51/0x430 [fpga_region]
    [<ffffffffa0228e47>] 0xffffffffa0228e47
    [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
    [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81238b85>] kthread+0x2b5/0x380
    [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
    [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888105fbd1b8 (size 8):
  comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
  hex dump (first 8 bytes):
    72 65 67 69 6f 6e 30 00                          region0.
  backtrace:
    [<ffffffff817ec023>] __kmalloc_node_track_caller+0x53/0x150
    [<ffffffff82995590>] kvasprintf+0xb0/0x130
    [<ffffffff83f713b1>] kobject_set_name_vargs+0x41/0x110
    [<ffffffff8304ac1b>] dev_set_name+0xab/0xe0
    [<ffffffffa02388a2>] fpga_region_register_full+0x312/0x430 [fpga_region]
    [<ffffffffa0228e47>] 0xffffffffa0228e47
    [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
    [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81238b85>] kthread+0x2b5/0x380
    [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
    [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff88810b3b8a00 (size 256):
  comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 8a 3b 0b 81 88 ff ff  ..........;.....
    08 8a 3b 0b 81 88 ff ff e0 ac 04 83 ff ff ff ff  ..;.............
  backtrace:
    [<ffffffff817ebad7>] kmalloc_trace+0x27/0xa0
    [<ffffffff83056d7a>] device_add+0xa2a/0x15e0
    [<ffffffffa02388b1>] fpga_region_register_full+0x321/0x430 [fpga_region]
    [<ffffffffa0228e47>] 0xffffffffa0228e47
    [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
    [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
    [<ffffffff81238b85>] kthread+0x2b5/0x380
    [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
    [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20

Fixes: 64a5f972c93d ("fpga: add an initial KUnit suite for the FPGA Region")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20231007094321.3447084-1-ruanjinjie@huawei.com
[yilun.xu@intel.com: slightly changes the commit message]
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/fpga/tests/fpga-region-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index 9f9d50ee7871..baab07e3fc59 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -93,6 +93,8 @@ static void fpga_region_test_class_find(struct kunit *test)
 
 	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
 	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
+
+	put_device(&region->dev);
 }
 
 /*
-- 
2.25.1

