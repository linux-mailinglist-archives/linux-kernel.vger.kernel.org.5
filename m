Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB457BD3B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345318AbjJIGoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345353AbjJIGnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:43:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62DF1;
        Sun,  8 Oct 2023 23:43:49 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S3qCC59t0z17HcH;
        Mon,  9 Oct 2023 14:39:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 14:43:46 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jose.exposito89@gmail.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2 1/2] HID: uclogic: Fix user-memory-access bug in uclogic_params_ugee_v2_init_event_hooks()
Date:   Mon, 9 Oct 2023 14:42:44 +0800
Message-ID: <20231009064245.3573397-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009064245.3573397-1-ruanjinjie@huawei.com>
References: <20231009064245.3573397-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HID_UCLOGIC=y and CONFIG_KUNIT_ALL_TESTS=y, launch kernel and
then the below user-memory-access bug occurs.

In hid_test_uclogic_params_cleanup_event_hooks(),it call
uclogic_params_ugee_v2_init_event_hooks() with the first arg=NULL, so
when it calls uclogic_params_ugee_v2_has_battery(), the hid_get_drvdata()
will access hdev->dev with hdev=NULL, which will cause below
user-memory-access.

So add a fake_device with quirks member and call hid_set_drvdata()
to assign hdev->dev->driver_data which avoids the null-ptr-def bug
for drvdata->quirks in uclogic_params_ugee_v2_has_battery(). After applying
this patch, the below user-memory-access bug never occurs.

 general protection fault, probably for non-canonical address 0xdffffc0000000329: 0000 [#1] PREEMPT SMP KASAN
 KASAN: probably user-memory-access in range [0x0000000000001948-0x000000000000194f]
 CPU: 5 PID: 2189 Comm: kunit_try_catch Tainted: G    B   W        N 6.6.0-rc2+ #30
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:uclogic_params_ugee_v2_init_event_hooks+0x87/0x600
 Code: f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa c7 44 24 30 00 00 00 00 48 c7 44 24 28 02 f8 02 01 48 c1 ea 03 <80> 3c 02 00 0f 85 2c 04 00 00 48 8b 9d 48 19 00 00 48 b8 00 00 00
 RSP: 0000:ffff88810679fc88 EFLAGS: 00010202
 RAX: dffffc0000000000 RBX: 0000000000000004 RCX: 0000000000000000
 RDX: 0000000000000329 RSI: ffff88810679fd88 RDI: 0000000000001948
 RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed1020f639f0
 R10: ffff888107b1cf87 R11: 0000000000000400 R12: 1ffff11020cf3f92
 R13: ffff88810679fd88 R14: ffff888100b97b08 R15: ffff8881030bb080
 FS:  0000000000000000(0000) GS:ffff888119e80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000005286001 CR4: 0000000000770ee0
 DR0: ffffffff8fdd6cf4 DR1: ffffffff8fdd6cf5 DR2: ffffffff8fdd6cf6
 DR3: ffffffff8fdd6cf7 DR6: 00000000fffe0ff0 DR7: 0000000000000600
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? die_addr+0x3d/0xa0
  ? exc_general_protection+0x144/0x220
  ? asm_exc_general_protection+0x22/0x30
  ? uclogic_params_ugee_v2_init_event_hooks+0x87/0x600
  ? sched_clock_cpu+0x69/0x550
  ? uclogic_parse_ugee_v2_desc_gen_params+0x70/0x70
  ? load_balance+0x2950/0x2950
  ? rcu_trc_cmpxchg_need_qs+0x67/0xa0
  hid_test_uclogic_params_cleanup_event_hooks+0x9e/0x1a0
  ? uclogic_params_ugee_v2_init_event_hooks+0x600/0x600
  ? __switch_to+0x5cf/0xe60
  ? migrate_enable+0x260/0x260
  ? __kthread_parkme+0x83/0x150
  ? kunit_try_run_case_cleanup+0xe0/0xe0
  kunit_generic_run_threadfn_adapter+0x4a/0x90
  ? kunit_try_catch_throw+0x80/0x80
  kthread+0x2b5/0x380
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x2d/0x70
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
 Modules linked in:
 Dumping ftrace buffer:
    (ftrace buffer empty)
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:uclogic_params_ugee_v2_init_event_hooks+0x87/0x600
 Code: f3 f3 65 48 8b 14 25 28 00 00 00 48 89 54 24 60 31 d2 48 89 fa c7 44 24 30 00 00 00 00 48 c7 44 24 28 02 f8 02 01 48 c1 ea 03 <80> 3c 02 00 0f 85 2c 04 00 00 48 8b 9d 48 19 00 00 48 b8 00 00 00
 RSP: 0000:ffff88810679fc88 EFLAGS: 00010202
 RAX: dffffc0000000000 RBX: 0000000000000004 RCX: 0000000000000000
 RDX: 0000000000000329 RSI: ffff88810679fd88 RDI: 0000000000001948
 RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed1020f639f0
 R10: ffff888107b1cf87 R11: 0000000000000400 R12: 1ffff11020cf3f92
 R13: ffff88810679fd88 R14: ffff888100b97b08 R15: ffff8881030bb080
 FS:  0000000000000000(0000) GS:ffff888119e80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000005286001 CR4: 0000000000770ee0
 DR0: ffffffff8fdd6cf4 DR1: ffffffff8fdd6cf5 DR2: ffffffff8fdd6cf6
 DR3: ffffffff8fdd6cf7 DR6: 00000000fffe0ff0 DR7: 0000000000000600
 PKRU: 55555554
 Kernel panic - not syncing: Fatal exception
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Kernel Offset: disabled
 Rebooting in 1 seconds..

Fixes: a251d6576d2a ("HID: uclogic: Handle wireless device reconnection")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: José Expósito <jose.exposito89@gmail.com>
---
v2:
- Use kunit_kzalloc() instead of kzalloc().
- Add KUNIT_ASSERT_NOT_ERR_OR_NULL() for kunit_kzalloc().
- Add Reviewed-by.
---
 drivers/hid/hid-uclogic-params-test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-params-test.c b/drivers/hid/hid-uclogic-params-test.c
index 678f50cbb160..a30121419a29 100644
--- a/drivers/hid/hid-uclogic-params-test.c
+++ b/drivers/hid/hid-uclogic-params-test.c
@@ -174,12 +174,26 @@ static void hid_test_uclogic_parse_ugee_v2_desc(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, params->frame_type, frame_type);
 }
 
+struct fake_device {
+	unsigned long quirks;
+};
+
 static void hid_test_uclogic_params_cleanup_event_hooks(struct kunit *test)
 {
 	int res, n;
+	struct hid_device *hdev;
+	struct fake_device *fake_dev;
 	struct uclogic_params p = {0, };
 
-	res = uclogic_params_ugee_v2_init_event_hooks(NULL, &p);
+	hdev = kunit_kzalloc(test, sizeof(struct hid_device), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hdev);
+
+	fake_dev = kunit_kzalloc(test, sizeof(struct fake_device), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_dev);
+
+	hid_set_drvdata(hdev, fake_dev);
+
+	res = uclogic_params_ugee_v2_init_event_hooks(hdev, &p);
 	KUNIT_ASSERT_EQ(test, res, 0);
 
 	/* Check that the function can be called repeatedly */
-- 
2.34.1

