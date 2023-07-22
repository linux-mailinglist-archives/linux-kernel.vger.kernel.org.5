Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679BC75DBD3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGVLEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVLEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:04:48 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F3E50
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:04:46 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1ba989d1c79so5176871fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690023886; x=1690628686;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81+PWZ4ODiooF7CePsI9i4OVrhy6OCAjMlJBUtUjeuU=;
        b=De0ygyxSD+XJWxfXOMWiK3qfV9Hd17F5Dnx1iParjwZg9I0Rpd44zEv1vvMC2c1484
         LfuQ9ytxWmttmsgEaMGrC+slmINyDx3Xd1H8/f6XA+Ym8rX+3qNhCY4M0Z1kcce2YZoV
         svKQ9iTKuZymeOlBGkvW67BkmkYIjj4N2EahSjZ5c4jzmNUgJ2yhaez9x9t2g+Jgv7+D
         jv+/tw41FWO4MvDynQcFcKIlFVNM/uNU4yAJ3j6tBq4m5nzK3gch9x8rrxQDun8tt9mA
         cV8Qx2wT7cGD9IqnYwCuri79i2FRunPSwJY6XlGXGHWXzbQyBiQlwre8bw1DmMs/6H/6
         Qfug==
X-Gm-Message-State: ABy/qLajjsBTC83dVxpam2fy4hiAYmORbgWRvn7ojh0eEf662958UOX2
        EaNBxrwU6ORCU2ha4+BqKNDDme2vIiWrTHLQ1yIgkQj53DtH
X-Google-Smtp-Source: APBJJlGgurByjHJoA0xXdZVDBtJKzvWcHLS+sx93xz8idlNOWMA2bOr+b3DxSvLvx0dzat4t/R7IklZqaFVmnUiWcNElxZpjOm8f
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76a9:b0:1b7:25d2:f5e5 with SMTP id
 dx41-20020a05687076a900b001b725d2f5e5mr6006079oab.8.1690023886080; Sat, 22
 Jul 2023 04:04:46 -0700 (PDT)
Date:   Sat, 22 Jul 2023 04:04:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006452210601115981@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in drain_vmap_area_work
From:   syzbot <syzbot+fc9127d4bfa8ef129f7d@syzkaller.appspotmail.com>
To:     bp@alien8.de, brauner@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fdf0eaf11452 Linux 6.5-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12906af4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=fc9127d4bfa8ef129f7d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103a7aaaa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177aa662a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ce0bc2f96ef/disk-fdf0eaf1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/413a60715bfa/vmlinux-fdf0eaf1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88ce39fe3bff/bzImage-fdf0eaf1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc9127d4bfa8ef129f7d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (1 GPs behind) idle=3564/1/0x4000000000000000 softirq=24687/24689 fqs=0
rcu: 	(t=10501 jiffies g=30009 q=312 ncpus=2)
rcu: rcu_preempt kthread starved for 10502 jiffies! g30009 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28896 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1609
 rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1808
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5065 Comm: syz-executor114 Not tainted 6.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:kvm_wait+0xa8/0x110 arch/x86/kernel/kvm.c:1064
Code: fa 83 e2 07 38 d0 7f 04 84 c0 75 66 0f b6 07 40 38 c6 74 1b 48 83 c4 10 c3 c3 e8 93 bd 53 00 eb 07 0f 00 2d 9a 2d 30 09 fb f4 <48> 83 c4 10 c3 eb 07 0f 00 2d 8a 2d 30 09 f4 48 83 c4 10 c3 89 74
RSP: 0018:ffffc90003d6f6e8 EFLAGS: 00000206
RAX: 0000000000371c1b RBX: ffffffff8cb062e0 RCX: 1ffffffff2309bca
RDX: 0000000000000000 RSI: ffffffff8a6c7700 RDI: ffffffff8ac80660
RBP: ffff8880b983d240 R08: 0000000000000001 R09: fffffbfff23093d1
R10: ffffffff91849e8f R11: 0000000000094000 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: fffffbfff1960c5c
FS:  00005555572063c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f02090198 CR3: 000000007418e000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 pv_wait arch/x86/include/asm/paravirt.h:598 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x959/0xc70 kernel/locking/qspinlock.c:511
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:586 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x20e/0x2b0 kernel/locking/spinlock_debug.c:115
 spin_lock include/linux/spinlock.h:351 [inline]
 preload_this_cpu_lock mm/vmalloc.c:1572 [inline]
 alloc_vmap_area+0xda2/0x2060 mm/vmalloc.c:1614
 __get_vm_area_node+0x132/0x3d0 mm/vmalloc.c:2595
 __vmalloc_node_range+0x27a/0x1540 mm/vmalloc.c:3276
 __vmalloc_node mm/vmalloc.c:3381 [inline]
 vzalloc+0x6b/0x80 mm/vmalloc.c:3454
 alloc_counters net/ipv4/netfilter/arp_tables.c:660 [inline]
 copy_entries_to_user net/ipv4/netfilter/arp_tables.c:681 [inline]
 get_entries net/ipv4/netfilter/arp_tables.c:867 [inline]
 do_arpt_get_ctl+0x654/0x960 net/ipv4/netfilter/arp_tables.c:1453
 nf_getsockopt+0x76/0xe0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x186/0x1d0 net/ipv4/ip_sockglue.c:1825
 tcp_getsockopt+0x97/0xf0 net/ipv4/tcp.c:4301
 __sys_getsockopt+0x220/0x6a0 net/socket.c:2307
 __do_sys_getsockopt net/socket.c:2322 [inline]
 __se_sys_getsockopt net/socket.c:2319 [inline]
 __x64_sys_getsockopt+0xbd/0x150 net/socket.c:2319
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8f02010c5a
Code: c4 c1 e0 1a 0d 00 00 04 00 89 01 e9 e0 fe ff ff e8 0b 05 00 00 66 2e 0f 1f 84 00 00 00 00 00 90 49 89 ca b8 37 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 b0 ff ff ff f7
RSP: 002b:00007fffc77bf048 EFLAGS: 00000212 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8f02010c5a
RDX: 0000000000000061 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fffc77bf060 R08: 00007fffc77bf05c R09: 0000000000000001
R10: 00007fffc77bf150 R11: 0000000000000212 R12: 00007fffc77bf05c
R13: 00007f8f02093d00 R14: 00007fffc77bf930 R15: 0000000000000813
 </TASK>
CPU: 1 PID: 46 Comm: kworker/1:1 Not tainted 6.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events drain_vmap_area_work
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
RIP: 0010:pie_calculate_probability+0x254/0x850 net/sched/sch_pie.c:345
Code: 5c 8f 02 00 4c 89 e7 e8 6a 2e 2e f9 4d 39 fc 0f 82 27 05 00 00 48 89 5c 24 40 48 8b 5c 24 20 b8 05 00 00 00 41 bc 64 00 00 00 <4c> 89 6c 24 30 41 89 c5 48 89 6c 24 38 e8 aa 32 2e f9 47 8d 24 a4
RSP: 0018:ffffc900001e0bc0 EFLAGS: 00000206
RAX: 0000000000000005 RBX: 00000000abcc7711 RCX: ffffffff88583ea6
RDX: ffff8880156a3b80 RSI: 0000000000000100 RDI: 0000000000000007
RBP: ffff88823bdf6300 R08: 0000000000000007 R09: 00028f5c28f5c28e
R10: 0000000000000000 R11: 000000000000004e R12: 0000000000000064
R13: 0000000000000000 R14: 00000000112e0be8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000c776000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 f6 fb 31 f7 48 89 df e8 ae 74 32 f7 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 75 1d 24 f7 65 8b 05 96 3b ce 75 85 c0 74 12 5b
RSP: 0018:ffffc90000b779d8 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff88813fffacc0 RCX: 1ffffffff2309856
RDX: 0000000000000000 RSI: ffffffff8a6c7700 RDI: ffffffff8ac80660
RBP: 0000000000000287 R08: 0000000000000001 R09: fffffbfff23093d0
R10: ffffffff91849e87 R11: dffffc0000000000 R12: 000000000007e652
R13: 0000000000000000 R14: 0000000000000700 R15: ffff88813fffa000
 free_unref_page+0x1c5/0x3b0 mm/page_alloc.c:2466
 kasan_depopulate_vmalloc_pte+0x63/0x80 mm/kasan/shadow.c:427
 apply_to_pte_range mm/memory.c:2596 [inline]
 apply_to_pmd_range mm/memory.c:2640 [inline]
 apply_to_pud_range mm/memory.c:2676 [inline]
 apply_to_p4d_range mm/memory.c:2712 [inline]
 __apply_to_page_range+0x5ed/0xd40 mm/memory.c:2746
 kasan_release_vmalloc+0xa8/0xc0 mm/kasan/shadow.c:544
 __purge_vmap_area_lazy+0x8b9/0x2160 mm/vmalloc.c:1770
 drain_vmap_area_work+0x54/0xd0 mm/vmalloc.c:1804
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 process_scheduled_works kernel/workqueue.c:2664 [inline]
 worker_thread+0x896/0x1110 kernel/workqueue.c:2750
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
