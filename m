Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962EA7CDF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjJROSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbjJROSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:18:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEB94483;
        Wed, 18 Oct 2023 07:15:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57F1C433CD;
        Wed, 18 Oct 2023 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638529;
        bh=ggz9rGhG062WHUCbKLhRvzQyIo5V1iEBTyIqXaoStEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvI/mwqZ4IvMZ6yQulno1kTtIBS4ok9oUBj1gT5hisE0c/Ar9pyQCEIE7bnwcEI50
         p0chENc8MJzNO9SamuPA1rQ6iO0+mVdJyBsqnAE0JLyqbY1C78WTJchG7C/LvaAacl
         jEVtFMTBEVi70V0yl8XB3oBjj38+Sw58jfcQAgODDhGKxRzHg1Ah4KPaODY6qrca3A
         R3k9OAj+c33fKWW6xgkKoUHGrSxj8CCZs2jYPhqjGjEZ9ITxnjibX5q+PFR/B2rmBW
         ZLkFR9gIphIzf2KnWNiASTFWTr84NN/mLHCgaCNmsVAvi8a+EJUU+9lZJgK+boZ/Ox
         p85+5K5VWpdvg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zqiang <qiang.zhang1211@gmail.com>,
        syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 2/7] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
Date:   Wed, 18 Oct 2023 10:15:18 -0400
Message-Id: <20231018141525.1335533-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141525.1335533-1-sashal@kernel.org>
References: <20231018141525.1335533-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.258
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 643445531829d89dc5ddbe0c5ee4ff8f84ce8687 ]

Currently, for UNBOUND wq, if the apply_wqattrs_prepare() return error,
the apply_wqattr_cleanup() will be called and use the pwq_release_worker
kthread to release resources asynchronously. however, the kfree(wq) is
invoked directly in failure path of alloc_workqueue(), if the kfree(wq)
has been executed and when the pwq_release_workfn() accesses wq, this
leads to the following scenario:

BUG: KASAN: slab-use-after-free in pwq_release_workfn+0x339/0x380 kernel/workqueue.c:4124
Read of size 4 at addr ffff888027b831c0 by task pool_workqueue_/3

CPU: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 pwq_release_workfn+0x339/0x380 kernel/workqueue.c:4124
 kthread_worker_fn+0x2fc/0xa80 kernel/kthread.c:823
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5054:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_workqueue+0x16f/0x1490 kernel/workqueue.c:4684
 kvm_mmu_init_tdp_mmu+0x23/0x100 arch/x86/kvm/mmu/tdp_mmu.c:19
 kvm_mmu_init_vm+0x248/0x2e0 arch/x86/kvm/mmu/mmu.c:6180
 kvm_arch_init_vm+0x39/0x720 arch/x86/kvm/x86.c:12311
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1222 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:5089 [inline]
 kvm_dev_ioctl+0xa31/0x1c20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5054:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 alloc_workqueue+0xe76/0x1490 kernel/workqueue.c:4746
 kvm_mmu_init_tdp_mmu+0x23/0x100 arch/x86/kvm/mmu/tdp_mmu.c:19
 kvm_mmu_init_vm+0x248/0x2e0 arch/x86/kvm/mmu/mmu.c:6180
 kvm_arch_init_vm+0x39/0x720 arch/x86/kvm/x86.c:12311
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1222 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:5089 [inline]
 kvm_dev_ioctl+0xa31/0x1c20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

This commit therefore flush pwq_release_worker in the alloc_and_link_pwqs()
before invoke kfree(wq).

Reported-by: syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60db9f652c92d5bacba4
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 856188b0681af..a93c0193ce205 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4202,6 +4202,12 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	}
 	put_online_cpus();
 
+	/* for unbound pwq, flush the pwq_release_worker ensures that the
+	 * pwq_release_workfn() completes before calling kfree(wq).
+	 */
+	if (ret)
+		kthread_flush_worker(pwq_release_worker);
+
 	return ret;
 }
 
-- 
2.40.1

