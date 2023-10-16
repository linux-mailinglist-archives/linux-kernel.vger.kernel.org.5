Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FD77CA0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJPHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjJPHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:38:53 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9F95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:38:51 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-57be11d32b3so5646714eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697441930; x=1698046730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8g99juWcJTqTeMSyy1bsF9gaqm6LFQOJvxpxegCqoiw=;
        b=aHPPrDLjOPuHObkh1rgn03E540CCcs51yXsST77DiOxJ94UvsEvMoosn90u+cHpzI4
         6XFA2R0yK6Pq/bTeRQ/FKgC2WVfpggnfDO8ls08BzASzF4UR0HiZcof+7lSojLpSmXOM
         vAuqV/E+FCszKbk/aYiNsS+GIS/5IhgHdfxLsvenhaLl2cF1d9UaZNY9EQA7gFi3Hbq7
         BF6ngShEMLyqJ++cHfeXhHc/n+nGj/AuB1q1S64soq9pe1kbVGo9Ij8ZgPY0dDtbSekL
         tWtVAbw7pLtiovNWCBlefam3fZIczPJgSmFO8zi7JynuM3wNtryCW1P+7r3ubk4iKcGq
         Nrhw==
X-Gm-Message-State: AOJu0YxLZd27bH40tKKDB8COc1/R34DhP0YoQb2V8Jr+/258GX9eX+lS
        pFIrsU6muUSYqMzwAbJQB4NzPkkkwY5grdOAzUO1c4QM6EFU
X-Google-Smtp-Source: AGHT+IF2UBL9Yf/vk7BFXTZ6uuuDwFrx+8XbhXZeHlDERo8phshNKyvPy0NkhSUDPopa+YBvS4/HyHIJP1Rr6ZJ28QKW6OGNKq6l
MIME-Version: 1.0
X-Received: by 2002:a4a:2c41:0:b0:57b:6b2a:df8 with SMTP id
 o62-20020a4a2c41000000b0057b6b2a0df8mr13699409ooo.1.1697441930501; Mon, 16
 Oct 2023 00:38:50 -0700 (PDT)
Date:   Mon, 16 Oct 2023 00:38:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b632f0607d07fb0@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in reweight_entity
From:   syzbot <syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com>
To:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9a3dad63edbe Merge tag '6.6-rc5-ksmbd-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1413e691680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d83dadac33c08b7
dashboard link: https://syzkaller.appspot.com/bug?extid=3908cdfd655fd839c82f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a055f9680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103ef619680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9a3dad63.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98467f6633b7/vmlinux-9a3dad63.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93b5cb4a26b0/bzImage-9a3dad63.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __update_min_deadline kernel/sched/fair.c:805 [inline]
BUG: KASAN: slab-use-after-free in min_deadline_update kernel/sched/fair.c:819 [inline]
BUG: KASAN: slab-use-after-free in min_deadline_cb_propagate kernel/sched/fair.c:825 [inline]
BUG: KASAN: slab-use-after-free in reweight_entity+0x8e3/0xa60 kernel/sched/fair.c:3660
Read of size 8 at addr ffff888022a59a70 by task syz-executor206/5331

CPU: 3 PID: 5331 Comm: syz-executor206 Not tainted 6.6.0-rc5-syzkaller-00267-g9a3dad63edbe #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 __update_min_deadline kernel/sched/fair.c:805 [inline]
 min_deadline_update kernel/sched/fair.c:819 [inline]
 min_deadline_cb_propagate kernel/sched/fair.c:825 [inline]
 reweight_entity+0x8e3/0xa60 kernel/sched/fair.c:3660
 entity_tick kernel/sched/fair.c:5317 [inline]
 task_tick_fair+0xee/0xcd0 kernel/sched/fair.c:12392
 scheduler_tick+0x210/0x650 kernel/sched/core.c:5657
 update_process_times+0x19f/0x220 kernel/time/timer.c:2076
 tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:254
 tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1492
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
RIP: 0010:rcu_is_watching+0x39/0xb0 kernel/rcu/tree.c:699
Code: a5 cf 08 48 c7 c3 e8 6d 03 00 83 f8 07 89 c5 77 7a 48 8d 3c ed 40 ba 5c 8c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 54 48 03 1c ed 40 ba 5c 8c 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90003cc73d8 EFLAGS: 00000a06
RAX: dffffc0000000000 RBX: 0000000000036de8 RCX: 1ffffffff1d9a7c0
RDX: 1ffffffff18b974b RSI: ffffffff8ae90aa0 RDI: ffffffff8c5cba58
RBP: 0000000000000003 R08: 0000000000000007 R09: ffffffffff600000
R10: 00007fcac0348000 R11: dffffc0000000000 R12: ffffc90003cc7488
R13: ffffffff81747dc0 R14: ffffc90003cc7500 R15: ffff88802787c780
 kernel_text_address kernel/extable.c:113 [inline]
 kernel_text_address+0x62/0xd0 kernel/extable.c:94
 __kernel_text_address+0xd/0x30 kernel/extable.c:79
 unwind_get_return_address+0x78/0xe0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xbe/0x170 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 slab_alloc mm/slab.c:3246 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
 kmem_cache_alloc+0x159/0x400 mm/slab.c:3432
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 alloc_buffer_head+0x21/0x140 fs/buffer.c:3023
 folio_alloc_buffers+0x2e7/0x7f0 fs/buffer.c:935
 folio_create_empty_buffers+0x36/0x470 fs/buffer.c:1648
 ext4_block_write_begin+0xcc4/0xf10 fs/ext4/inode.c:1024
 ext4_da_write_begin+0x40a/0x8c0 fs/ext4/inode.c:2890
 generic_perform_write+0x278/0x600 mm/filemap.c:3969
 ext4_buffered_write_iter+0x11f/0x3c0 fs/ext4/file.c:299
 ext4_file_write_iter+0x7f7/0x1860 fs/ext4/file.c:717
 call_write_iter include/linux/fs.h:1956 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcac0348789
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff03860d58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fcac0348789
RDX: 000000000208e24b RSI: 0000000020000100 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff03860d7c
R13: 00007fff03860d90 R14: 00007fff03860dd0 R15: 0000000000000015
 </TASK>

Allocated by task 2:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 kmem_cache_alloc_node+0x173/0x540 mm/slab.c:3509
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x41c/0x73f0 kernel/fork.c:2327
 kernel_clone+0xfd/0x920 kernel/fork.c:2909
 kernel_thread+0xc0/0x100 kernel/fork.c:2971
 create_kthread kernel/kthread.c:411 [inline]
 kthreadd+0x4fb/0x7d0 kernel/kthread.c:746
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Freed by task 21:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 kmem_cache_free+0x104/0x380 mm/slab.c:3582
 put_task_struct include/linux/sched/task.h:136 [inline]
 put_task_struct include/linux/sched/task.h:123 [inline]
 delayed_put_task_struct+0x21b/0x2b0 kernel/exit.c:226
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x805/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user kernel/exit.c:232 [inline]
 put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:229
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0xee9/0x5a10 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_timeout+0x278/0x2c0 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e0/0x5f0 kernel/sched/completion.c:116
 kthread_stop+0x18e/0x5f0 kernel/kthread.c:709
 kvm_mmu_pre_destroy_vm+0x44/0x60 arch/x86/kvm/mmu/mmu.c:7160
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1313 [inline]
 kvm_put_kvm+0x254/0xad0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1373
 kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1396
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user kernel/exit.c:232 [inline]
 put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:229
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0xee9/0x5a10 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_timeout+0x278/0x2c0 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e0/0x5f0 kernel/sched/completion.c:116
 kthread_stop+0x18e/0x5f0 kernel/kthread.c:709
 kvm_mmu_pre_destroy_vm+0x44/0x60 arch/x86/kvm/mmu/mmu.c:7160
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1313 [inline]
 kvm_put_kvm+0x254/0xad0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1373
 kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1396
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888022a599c0
 which belongs to the cache task_struct of size 8960
The buggy address is located 176 bytes inside of
 freed 8960-byte region [ffff888022a599c0, ffff888022a5bcc0)

The buggy address belongs to the physical page:
page:ffffea00008a9600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22a58
head:ffffea00008a9600 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x1()
raw: 00fff00000000840 ffff88810005a500 ffffea00009ffb10 ffffea0000bf6410
raw: 0000000000000000 ffff888022a599c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 4949, tgid 4949 (dhcpcd-run-hook), ts 26983961004, free_ts 23254563577
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x99/0x3a0 mm/slab.c:2550
 cache_alloc_refill+0x294/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 kmem_cache_alloc_node+0x481/0x540 mm/slab.c:3509
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x41c/0x73f0 kernel/fork.c:2327
 kernel_clone+0xfd/0x920 kernel/fork.c:2909
 __do_sys_clone+0xba/0x100 kernel/fork.c:3052
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 slab_destroy mm/slab.c:1608 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1628
 cache_flusharray mm/slab.c:3341 [inline]
 ___cache_free+0x2b7/0x420 mm/slab.c:3404
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x4c/0x1b0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 kmem_cache_alloc_node+0x173/0x540 mm/slab.c:3509
 __alloc_skb+0x287/0x330 net/core/skbuff.c:640
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6313
 sock_alloc_send_pskb+0x7e4/0x970 net/core/sock.c:2795
 unix_dgram_sendmsg+0x455/0x1c30 net/unix/af_unix.c:1953
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 sock_write_iter+0x29b/0x3d0 net/socket.c:1158
 call_write_iter include/linux/fs.h:1956 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x1f0/0x250 fs/read_write.c:637

Memory state around the buggy address:
 ffff888022a59900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888022a59980: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888022a59a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff888022a59a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888022a59b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	48 c7 c3 e8 6d 03 00 	mov    $0x36de8,%rbx
   7:	83 f8 07             	cmp    $0x7,%eax
   a:	89 c5                	mov    %eax,%ebp
   c:	77 7a                	ja     0x88
   e:	48 8d 3c ed 40 ba 5c 	lea    -0x73a345c0(,%rbp,8),%rdi
  15:	8c
  16:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1d:	fc ff df
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
* 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2b:	75 54                	jne    0x81
  2d:	48 03 1c ed 40 ba 5c 	add    -0x73a345c0(,%rbp,8),%rbx
  34:	8c
  35:	48                   	rex.W
  36:	b8 00 00 00 00       	mov    $0x0,%eax
  3b:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
