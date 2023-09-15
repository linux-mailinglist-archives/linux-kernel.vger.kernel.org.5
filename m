Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD96A7A1ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjIOMhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjIOMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:37:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA62C1A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:36:58 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RnD9W4BswztS29;
        Fri, 15 Sep 2023 20:32:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 20:36:56 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <peterz@infradead.org>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <mingo@kernel.org>, <jpoimboe@kernel.org>,
        <christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2 2/2] static_call: Fix a wild-memory-access bug when static_call_key_sites(key) is true
Date:   Fri, 15 Sep 2023 20:36:05 +0800
Message-ID: <20230915123605.3732345-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915123605.3732345-1-ruanjinjie@huawei.com>
References: <20230915123605.3732345-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject fault while probing btrfs.ko, when static_call_key_sites(key) is
true, if the first kzalloc() succeeds but the second kzalloc() fails in
__static_call_init() in the for loop, the key->mods will not be
initialized in the subsequent sites. And then in static_call_del_module()
the site_mod->mod will cause wild-memory-access as below.

So assign key->mods to NULL in __static_call_init() if it fails and break
if key->mods is NULL in exit func to fix the issue.

Free the just allocated site_mod in key->mods because site_mod->mod
will be NULL without a site_mod->mod = mod head node, so it will not be
found in static_call_del_module().

 general protection fault, probably for non-canonical address 0xfec001628a9f8a82: 0000 [#1] PREEMPT SMP KASAN
 KASAN: maybe wild-memory-access in range [0xf6002b1454fc5410-0xf6002b1454fc5417]
 CPU: 2 PID: 1812 Comm: modprobe Tainted: G        W        N 6.6.0-rc1+ #96
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 RIP: 0010:static_call_del_module+0x11a/0x2a0
 Code: 00 00 49 8b 6e 08 48 85 ed 75 14 e9 8c 00 00 00 48 85 db 0f 84 83 00 00 00 49 89 ef 48 89 dd 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 87 00 00 00 48 89 e8 4c 8b 6d 08 48 c1 e8 03
 RSP: 0018:ffff888101e97860 EFLAGS: 00010a06
 RAX: 1ec005628a9f8a82 RBX: f6002b1454fc540b RCX: ffffffffa05b1880
 RDX: ffffffffa05acd84 RSI: 0000000000000000 RDI: f6002b1454fc5413
 RBP: f6002b1454fc540b R08: ffffffffa05adb3c R09: ffffed10203d2eda
 R10: ffffed10203d2ed9 R11: ffff888101e976cf R12: dffffc0000000000
 R13: 68002b144cfe8871 R14: ffffffff851958a0 R15: ffffffff84ee4449
 FS:  00007f20cb75f540(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ffe945e1bb8 CR3: 000000010c3d6003 CR4: 0000000000170ee0
 DR0: ffffffff8faefce8 DR1: ffffffff8faefce9 DR2: ffffffff8faefcea
 DR3: ffffffff8faefceb DR6: 00000000ffff0ff0 DR7: 0000000000000600
 Call Trace:
  <TASK>
  ? __die_body+0x1b/0x60
  ? die_addr+0x43/0x70
  ? exc_general_protection+0x121/0x210
  ? asm_exc_general_protection+0x22/0x30
  ? static_call_del_module+0x11a/0x2a0
  ? __SCT__cond_resched+0x8/0x8
  static_call_module_notify+0x2a6/0x3c0
  notifier_call_chain+0xbf/0x280
  ? stack_trace_save+0x91/0xc0
  notifier_call_chain_robust+0x7f/0xe0
  ? notifier_call_chain+0x280/0x280
  ? alloc_covered_add+0x30/0x60
  blocking_notifier_call_chain_robust+0x5b/0x80
  load_module+0x4d1d/0x69f0
  ? module_frob_arch_sections+0x20/0x20
  ? uprobe_apply+0x100/0x100
  ? rwsem_down_write_slowpath+0x11c0/0x11c0
  ? kernel_read_file+0x3ca/0x510
  ? __x64_sys_fsconfig+0x650/0x650
  ? init_module_from_file+0xd2/0x130
  init_module_from_file+0xd2/0x130
  ? __ia32_sys_init_module+0xa0/0xa0
  ? userfaultfd_unmap_prep+0x3d0/0x3d0
  ? _raw_spin_lock_irqsave+0xe0/0xe0
  idempotent_init_module+0x32d/0x6a0
  ? init_module_from_file+0x130/0x130
  ? __fget_light+0x57/0x500
  __x64_sys_finit_module+0xbb/0x130
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: a945c8345ec0 ("static_call: Allow early init")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/static_call_inline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index e7aa70d33530..a8ade6208237 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -274,8 +274,11 @@ static int __static_call_init(struct module *mod,
 				key->mods = site_mod;
 
 				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
-				if (!site_mod)
+				if (!site_mod) {
+					kfree(key->mods);
+					key->mods = NULL;
 					return -ENOMEM;
+				}
 			}
 
 			site_mod->mod = mod;
-- 
2.34.1

