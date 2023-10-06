Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB97BBD6B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjJFRCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjJFRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:02:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7385AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:02:06 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5056ca2b6d1so2884001e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696611725; x=1697216525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NpEemiWViboQRLEteZ7S4m4qM1WTeD7Vt/riE2+tgxU=;
        b=nLI+HsxxctfyNINMbwUGslqOCAUoEj/Oz1T6nyquEfTOzd45EsvJwjp/7TdMLTVDaa
         F9Qj75vsaRdSYgf6t2CLHY5og+p4DlXsD+6vF68pnioFCcDMUOgGubl3GaFuc2pJSxC/
         BIvNFJmC7y35nwztb1Tw66N/WHoYjKiwDoTB3CyXiDKtXQbpqzbaJ1LfTdfCzYqLSY4m
         916nNRdHQaX9lSLfT+akYa2vUP3NJAV84E+qEkWX/Ovs3/MDS5OGbx58QEq03kfW9mUc
         u2crkDxwL21A3O8Xg4WwzV5EWRXYQQHsyiv1iZD8YPTaOXFDL0sZDOJqw/5s8E8ybhny
         tozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611725; x=1697216525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpEemiWViboQRLEteZ7S4m4qM1WTeD7Vt/riE2+tgxU=;
        b=Z1ae9wwmYkO0O9ZZ6VqYXglkDC/q5rfsjH2dBaOeq8zxJtzwT3uOEMCnVFrggOGTou
         gBb/bLtwzQg1nZPADixOYA16h/TtHUisG81ChxoLALTzQDdDiHgQhPO8LP1PPYkhjDST
         OQLzOfVJ8mTKvEGcm05vhGV2ORCD7ShHFPljX+90gAyZQv5vDOtNuFzPCav0/Dos+k+2
         XjZtqAg+fWTfurU22gt/MBBlFu2UOVx1CJZiMkPeC6kErPG/1xI9D5SX+oggMszs/8vs
         LtWNH0n5SNehAz1TEjP40/IX/hE8wJENkhrpgpm2LQdNhmHJhmJT+xTFlCZnyN2n8Jim
         HYOg==
X-Gm-Message-State: AOJu0Yy8IebbaA95IJBdN6+L3Rr/OY3qRCgAY91tfWrtBe82MLSPpLzk
        VYoppf2I2Y01Wn9WCFZbGgF/fGxs2Bi8VdO9AP0=
X-Google-Smtp-Source: AGHT+IGpgyIYbUYr1q07Ewq7VZ1D+MCvK+ROlqmYGQ59gkhEuBDu364dw5gAUXppZKeZ0j4KGcwo2yw0LgV6mqRRi00=
X-Received: by 2002:a05:6512:12cb:b0:500:7bf0:2b91 with SMTP id
 p11-20020a05651212cb00b005007bf02b91mr3673618lfg.13.1696611724416; Fri, 06
 Oct 2023 10:02:04 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Sat, 7 Oct 2023 01:01:52 +0800
Message-ID: <CALcu4rZOs3sbXBWARhjM6d8UngPUF3bU1CPmSZBugUpgaP_0WA@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in try_to_wake_up
To:     brauner@kernel.org, linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, "keescook@chromium.org" <keescook@chromium.org>,
        mingo@redhat.com, peterz@infradead.org,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel,  the following crash
was triggered.

HEAD commit: f291209eca5eba0b4704fa0832af57b12dbc1a02 (  Merge tag
'net-6.6-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net=EF=BC=89
git tree: upstream

console output:
https://drive.google.com/file/d/1Tm8J2Yc3ziJdhJ2BQtsYOVVSb1_VDQIw/view?usp=
=3Ddrive_link
kernel config:
C reproducer:https://drive.google.com/file/d/1DILSzuO8NVktVBafoAd_mcQgvNAe8=
Lpo/view?usp=3Ddrive_link
Syzlang reproducer:https://drive.google.com/file/d/11hb2CdlWpg8er66lcQnrv1L=
-Smqp5WXm/view?usp=3Ddrive_link
https://drive.google.com/file/d/1sMG483D2ZVg2mZzC72_gTIQhBmuHtO4K/view?usp=
=3Ddrive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in __lock_acquire+0x432a/0x5b90
kernel/locking/lockdep.c:5004
Read of size 8 at addr ffff888021444600 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc4-gf291209eca5e #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xba/0xf0 mm/kasan/report.c:588
 __lock_acquire+0x432a/0x5b90 kernel/locking/lockdep.c:5004
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ad/0x520 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inlin=
e]
 try_to_wake_up+0xa8/0x1510 kernel/sched/core.c:4230
 call_timer_fn+0x19e/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers.part.0+0x682/0xa00 kernel/time/timer.c:2022
 __run_timers kernel/time/timer.c:2000 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:2035
 __do_softirq+0x1d0/0x8eb kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb3/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:=
645
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline=
]
RIP: 0010:default_idle+0x1a/0x20 arch/x86/kernel/process.c:743
Code: c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc 0f 1f 44 00 00
eb 0c 0f 1f 44 00 00 0f 00 2d ed a2 31 00 0f 1f 44 00 00 fb f4 <fa> c3
0f 1f 40 00 55 53 0f 1f 44 00 00 65 48 8b 2c 25 80 ac 03 00
RSP: 0018:ffffffff8be07e08 EFLAGS: 00000206
RAX: 0000000000382ebd RBX: 0000000000000000 RCX: ffffffff89b52186
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed100c786bbd
R10: ffff888063c35deb R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8e184dd0 R14: 0000000000000000 R15: 0000000000000000
 default_idle_call+0x63/0x90 kernel/sched/idle.c:97
 cpuidle_idle_call kernel/sched/idle.c:170 [inline]
 do_idle+0x317/0x3c0 kernel/sched/idle.c:282
 cpu_startup_entry+0x4c/0x60 kernel/sched/idle.c:380
 rest_init+0x16b/0x2b0 init/main.c:726
 arch_call_rest_init+0xf/0x20 init/main.c:823
 start_kernel+0x395/0x470 init/main.c:1068
 x86_64_start_reservations+0x14/0x30 arch/x86/kernel/head64.c:556
 x86_64_start_kernel+0xaf/0xc0 arch/x86/kernel/head64.c:537
 secondary_startup_64_no_verify+0x166/0x16b
 </TASK>

Allocated by task 2:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7b/0x80 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x1c0/0x3e0 mm/slub.c:3523
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x3f2/0x73c0 kernel/fork.c:2327
 kernel_clone+0xe7/0x860 kernel/fork.c:2909
 kernel_thread+0xbc/0x100 kernel/fork.c:2971
 create_kthread kernel/kthread.c:411 [inline]
 kthreadd+0x506/0x7b0 kernel/kthread.c:746
 ret_from_fork+0x41/0x70 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Freed by task 0:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x95/0x1d0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0xec/0x480 mm/slub.c:3831
 put_task_struct include/linux/sched/task.h:136 [inline]
 put_task_struct include/linux/sched/task.h:123 [inline]
 delayed_put_task_struct+0x217/0x2b0 kernel/exit.c:226
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x813/0x1bd0 kernel/rcu/tree.c:2403
 __do_softirq+0x1d0/0x8eb kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x99/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user+0x83/0xc0 kernel/exit.c:232
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0xcc5/0x5890 kernel/sched/core.c:6695
 preempt_schedule_common+0x45/0xb0 kernel/sched/core.c:6864
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk_64.S:45
 rmqueue_pcplist mm/page_alloc.c:2741 [inline]
 rmqueue mm/page_alloc.c:2777 [inline]
 get_page_from_freelist+0x1613/0x2c50 mm/page_alloc.c:3167
 __alloc_pages+0x1c7/0x490 mm/page_alloc.c:4426
 __folio_alloc+0x12/0x40 mm/page_alloc.c:4458
 vma_alloc_folio+0x153/0x870 mm/mempolicy.c:2258
 shmem_alloc_folio+0x121/0x1f0 mm/shmem.c:1658
 shmem_alloc_and_acct_folio+0xd2/0x150 mm/shmem.c:1683
 shmem_get_folio_gfp+0x96b/0x18e0 mm/shmem.c:2020
 shmem_get_folio mm/shmem.c:2143 [inline]
 shmem_write_begin+0x146/0x440 mm/shmem.c:2688
 generic_perform_write+0x267/0x5d0 mm/filemap.c:3969
 shmem_file_write_iter+0x10f/0x140 mm/shmem.c:2865
 call_write_iter include/linux/fs.h:1956 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x989/0xdb0 fs/read_write.c:584
 ksys_write+0x11e/0x240 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x99/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user+0x83/0xc0 kernel/exit.c:232
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0xcc5/0x5890 kernel/sched/core.c:6695
 schedule_idle+0x57/0x80 kernel/sched/core.c:6799
 do_idle+0x273/0x3c0 kernel/sched/idle.c:310
 cpu_startup_entry+0x4c/0x60 kernel/sched/idle.c:380
 rest_init+0x16b/0x2b0 init/main.c:726
 arch_call_rest_init+0xf/0x20 init/main.c:823
 start_kernel+0x395/0x470 init/main.c:1068
 x86_64_start_reservations+0x14/0x30 arch/x86/kernel/head64.c:556
 x86_64_start_kernel+0xaf/0xc0 arch/x86/kernel/head64.c:537
 secondary_startup_64_no_verify+0x166/0x16b

The buggy address belongs to the object at ffff888021443c00
 which belongs to the cache task_struct of size 7368
The buggy address is located 2560 bytes inside of
 freed 7368-byte region [ffff888021443c00, ffff8880214458c8)

The buggy address belongs to the physical page:
page:ffffea0000851000 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x21440
head:ffffea0000851000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:=
0
memcg:ffff8880179df641
anon flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff=
)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff88801367c140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff8880179df641
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM=
ALLOC),
pid 2, tgid 2 (kthreadd), ts 26884708343, free_ts 0
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xf09/0x2c50 mm/page_alloc.c:3170
 __alloc_pages+0x1c7/0x490 mm/page_alloc.c:4426
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x261/0x390 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0xbda/0x15e0 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 kmem_cache_alloc_node+0x131/0x3e0 mm/slub.c:3523
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x3f2/0x73c0 kernel/fork.c:2327
 kernel_clone+0xe7/0x860 kernel/fork.c:2909
 kernel_thread+0xbc/0x100 kernel/fork.c:2971
 create_kthread kernel/kthread.c:411 [inline]
 kthreadd+0x506/0x7b0 kernel/kthread.c:746
 ret_from_fork+0x41/0x70 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888021444500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021444580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888021444600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888021444680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021444700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
----------------
Code disassembly (best guess):
   0:   c8 4c 01 c7             enter  $0x14c,$0xc7
   4:   4c 29 c2                sub    %r8,%rdx
   7:   e9 72 ff ff ff          jmp    0xffffff7e
   c:   cc                      int3
   d:   cc                      int3
   e:   cc                      int3
   f:   cc                      int3
  10:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  15:   eb 0c                   jmp    0x23
  17:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  1c:   0f 00 2d ed a2 31 00    verw   0x31a2ed(%rip)        # 0x31a310
  23:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  28:   fb                      sti
  29:   f4                      hlt
* 2a:   fa                      cli <-- trapping instruction
  2b:   c3                      ret
  2c:   0f 1f 40 00             nopl   0x0(%rax)
  30:   55                      push   %rbp
  31:   53                      push   %rbx
  32:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  37:   65 48 8b 2c 25 80 ac    mov    %gs:0x3ac80,%rbp
  3e:   03 00
