Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC47A1891
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjIOIXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjIOIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:23:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00232449C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:22:29 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rn6XB5N3gzMlNh;
        Fri, 15 Sep 2023 16:18:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 16:22:03 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] static_call: Fix a wild-memory-access bug in static_call_del_module()
Date:   Fri, 15 Sep 2023 16:21:25 +0800
Message-ID: <20230915082126.4187913-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject fault while probing btrfs.ko, if the first kzalloc() fails
in __static_call_init(), key->mods will no be initialized. And then
in static_call_del_module() the site_mod->mod will cause
wild-memory-access as below:

So assign key->mods to NULL in __static_call_init() if it fails
to fix the issue. And if kzalloc fails, it will just return in init
func, so it should break if it the key->mods is NULL in exit func.

 general protection fault, probably for non-canonical address 0xeb800159c89f94a0: 0000 [#1] PREEMPT SMP KASAN
 KASAN: maybe wild-memory-access in range [0x5c002ace44fca500-0x5c002ace44fca507]
 CPU: 2 PID: 1843 Comm: modprobe Tainted: G        W        N 6.6.0-rc1+ #60
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 RIP: 0010:static_call_del_module+0x113/0x280
 Code: 3c 20 00 0f 85 ef 00 00 00 49 8b 6e 08 48 85 ed 75 0d eb 75 48 85 db 74 70 49 89 ef 48 89 dd 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 75 78 48 89 e8 4c 8b 6d 08 48 c1 e8 03 42 80 3c 20
 RSP: 0018:ffff888101d3f860 EFLAGS: 00010206
 RAX: 0b800559c89f94a0 RBX: 5c002ace44fca4f8 RCX: ffffffffa0210f00
 RDX: ffffffffa0210ed4 RSI: ffffffffa0210edc RDI: 5c002ace44fca500
 RBP: 5c002ace44fca4f8 R08: 0000000000000000 R09: ffffed10233e4eea
 R10: ffffed10233e4ee9 R11: ffff888119f2774b R12: dffffc0000000000
 R13: 80002ace3cfca4f8 R14: ffffffff85196de0 R15: ffffffff84ee9f99
 FS:  00007f4ff6faa540(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ffc3d1f19e8 CR3: 0000000109fa6001 CR4: 0000000000170ee0
 DR0: ffffffff8faefce8 DR1: ffffffff8faefce9 DR2: ffffffff8faefcea
 DR3: ffffffff8faefceb DR6: 00000000ffff0ff0 DR7: 0000000000000600
 Call Trace:
  <TASK>
  ? __die_body+0x1b/0x60
  ? die_addr+0x43/0x70
  ? exc_general_protection+0x121/0x210
  ? asm_exc_general_protection+0x22/0x30
  ? static_call_del_module+0x113/0x280
  ? __SCT__tp_func_ipi_exit+0x8/0x8
  static_call_module_notify+0x27f/0x390
  ? rcu_segcblist_inc_len+0x17/0x20
  notifier_call_chain+0xbf/0x280
  notifier_call_chain_robust+0x7f/0xe0
  ? notifier_call_chain+0x280/0x280
  ? kasan_quarantine_put+0x46/0x160
  blocking_notifier_call_chain_robust+0x5b/0x80
  load_module+0x4d1d/0x69f0
  ? module_frob_arch_sections+0x20/0x20
  ? update_cfs_group+0x10c/0x2a0
  ? __wake_up_common+0x10b/0x5d0
  ? kernel_read_file+0x3ca/0x510
  ? __x64_sys_fsconfig+0x650/0x650
  ? __schedule+0xa0b/0x2a60
  ? init_module_from_file+0xd2/0x130
  init_module_from_file+0xd2/0x130
  ? __ia32_sys_init_module+0xa0/0xa0
  ? _raw_spin_lock_irqsave+0xe0/0xe0
  ? ptrace_stop+0x487/0x790
  idempotent_init_module+0x32d/0x6a0
  ? init_module_from_file+0x130/0x130
  ? __fget_light+0x57/0x500
  __x64_sys_finit_module+0xbb/0x130
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 RIP: 0033:0x7f4ff691b839
 Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffc07b09718 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 RAX: ffffffffffffffda RBX: 000055978f13e070 RCX: 00007f4ff691b839
 RDX: 0000000000000000 RSI: 000055978da1bc2e RDI: 0000000000000003
 RBP: 000055978da1bc2e R08: 0000000000000000 R09: 000055978f13ddb0
 R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
 R13: 000055978f13e020 R14: 0000000000040000 R15: 000055978f13ddb0
  </TASK>
 Modules linked in: tifm_core(+)
 Dumping ftrace buffer:
    (ftrace buffer empty)
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:static_call_del_module+0x113/0x280
 Code: 3c 20 00 0f 85 ef 00 00 00 49 8b 6e 08 48 85 ed 75 0d eb 75 48 85 db 74 70 49 89 ef 48 89 dd 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 75 78 48 89 e8 4c 8b 6d 08 48 c1 e8 03 42 80 3c 20
 RSP: 0018:ffff888101d3f860 EFLAGS: 00010206
 RAX: 0b800559c89f94a0 RBX: 5c002ace44fca4f8 RCX: ffffffffa0210f00
 RDX: ffffffffa0210ed4 RSI: ffffffffa0210edc RDI: 5c002ace44fca500
 RBP: 5c002ace44fca4f8 R08: 0000000000000000 R09: ffffed10233e4eea
 R10: ffffed10233e4ee9 R11: ffff888119f2774b R12: dffffc0000000000
 R13: 80002ace3cfca4f8 R14: ffffffff85196de0 R15: ffffffff84ee9f99
 FS:  00007f4ff6faa540(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ffc3d1f19e8 CR3: 0000000109fa6001 CR4: 0000000000170ee0
 DR0: ffffffff8faefce8 DR1: ffffffff8faefce9 DR2: ffffffff8faefcea
 DR3: ffffffff8faefceb DR6: 00000000ffff0ff0 DR7: 0000000000000600
 Kernel panic - not syncing: Fatal exception
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Kernel Offset: disabled
 Rebooting in 1 seconds..

Fixes: 8fd4ddda2f49 ("static_call: Don't make __static_call_return0 static")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/static_call_inline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 639397b5491c..e7aa70d33530 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -256,8 +256,10 @@ static int __static_call_init(struct module *mod,
 			}
 
 			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
-			if (!site_mod)
+			if (!site_mod) {
+				key->mods = NULL;
 				return -ENOMEM;
+			}
 
 			/*
 			 * When the key has a direct sites pointer, extract
@@ -422,7 +424,7 @@ static void static_call_del_module(struct module *mod)
 			;
 
 		if (!site_mod)
-			continue;
+			break;
 
 		*prev = site_mod->next;
 		kfree(site_mod);
-- 
2.34.1

