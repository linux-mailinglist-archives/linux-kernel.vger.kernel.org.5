Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556C78DF58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbjH3TUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243166AbjH3KN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:13:58 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59742CC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:13:53 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-26d63b60934so6244774a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693390433; x=1693995233;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3Qza2QmkIc+BI/YstCDtC90QrYZHsfYuMQhNOBLYRU=;
        b=A4Gr1TjHOYTUfZdgFxnjH8tHmAnAhxs0PrY6ORgZF1x3QdbWFtbUB3OlMgMLHPM65T
         Mcn1XtAvttqjjm8+qwT0/cX0qop+vJomeZFMIrFxxO+UNSmRDC2vAYdChxRw13al9Y1o
         wGMGARxGGBXPzwZnLVNE5W0KGFyxphLL6piQLbnynotjgW60DYUEI+hev73f0Hjlkn0w
         2TsfD6pyXC1TRmsyxJIYgnWC/pYPGA6DCBMIAcOrRjcttUPbTIr7Yqr/agO1oV4BndDD
         7cqOk6GXUvtvJ6V2qF6hlfdvcttrutGVTQ78eBNGMe/DtGODcBeeJ4Bp3dNS00802D2Y
         Dw8Q==
X-Gm-Message-State: AOJu0Yz0MYjrE6D/NcGE9FPpZtn7LCt2IHrMX1FD2REd1PsGfE2TWPAp
        VjFn2HCAnWGdzoOAnB+TdYj+byzKbUFU+slcnCowwexmeQxO
X-Google-Smtp-Source: AGHT+IHM/Vw54IX+vEGvHjDUVX4CtvKF+9RewV7RT1f05sLZyWr+8W3r3PrOYJC4LcroLQs0aun5XqZC4lvnwJD6GeNlKQVNfwLu
MIME-Version: 1.0
X-Received: by 2002:a17:90a:fe8b:b0:26b:4c47:eeae with SMTP id
 co11-20020a17090afe8b00b0026b4c47eeaemr439553pjb.5.1693390432891; Wed, 30 Aug
 2023 03:13:52 -0700 (PDT)
Date:   Wed, 30 Aug 2023 03:13:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037f8720604212f9c@google.com>
Subject: [syzbot] [net?] [wireless?] INFO: rcu detected stall in
 request_firmware_work_func (2)
From:   syzbot <syzbot+1425ba65f01a5682a1a2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    382d4cd18475 lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b7dfcfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4a882f77ed77bd
dashboard link: https://syzkaller.appspot.com/bug?extid=1425ba65f01a5682a1a2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bd9bcfa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148070dba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f77bf610e28/disk-382d4cd1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63cde1098a7f/vmlinux-382d4cd1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa910d4c94be/bzImage-382d4cd1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1425ba65f01a5682a1a2@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (1 GPs behind) idle=6dac/0/0x3 softirq=8535/8539 fqs=0
rcu: 	(t=10500 jiffies g=5401 q=100 ncpus=2)
rcu: rcu_preempt kthread starved for 10500 jiffies! g5401 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:29008 pid:16    ppid:2      flags:0x00004000
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
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.5.0-rc7-syzkaller-00164-g382d4cd18475 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events request_firmware_work_func
RIP: 0010:write_comp_data+0x7/0x90 kernel/kcov.c:230
Code: 81 e2 00 01 ff 00 75 10 65 48 8b 04 25 80 b9 03 00 48 8b 80 f8 15 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 65 8b 05 c1 b6 7d 7e <49> 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25
RSP: 0018:ffffc90000007bb8 EFLAGS: 00000246
RAX: 0000000000000102 RBX: ffffc9000e151ea0 RCX: ffffffff88587d2c
RDX: 0000000000000000 RSI: 0019999999999998 RDI: 0000000000000007
RBP: ffff88807d071b00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000015798ee228
R13: 0000000000000000 R14: 0000000225c17d04 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555640eca8 CR3: 0000000027cca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 pie_calculate_probability+0x1fc/0x850 net/sched/sch_pie.c:340
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
RIP: 0010:console_flush_all+0x9b6/0xf50 kernel/printk/printk.c:2939
Code: 90 1b 23 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 8e 66 1c 00 48 85 db 0f 85 94 03 00 00 e8 f0 6a 1c 00 fb 48 8b 44 24 08 <48> 8b 14 24 0f b6 00 83 e2 07 38 d0 7f 08 84 c0 0f 85 9d 04 00 00
RSP: 0018:ffffc900000c7920 EFLAGS: 00000293
RAX: fffff52000018f4f RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801664bb80 RSI: ffffffff81699db0 RDI: 0000000000000007
RBP: ffffffff8d4cb1a0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 205d375420202020 R12: 0000000000000001
R13: ffffffff8d4cb1f8 R14: dffffc0000000000 R15: 0000000000000001
 console_unlock+0xc6/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1c5/0x640 kernel/printk/printk.c:2307
 vprintk+0x89/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 regdb_fw_cb+0x155/0x270 net/wireless/reg.c:1008
 request_firmware_work_func+0x13a/0x240 drivers/base/firmware_loader/main.c:1162
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.097 msecs
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc7-syzkaller-00164-g382d4cd18475 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data+0x32/0x90 kernel/kcov.c:236
Code: 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 a9 00 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 <85> c0 74 4f 8b 82 e0 15 00 00 83 f8 03 75 44 48 8b 82 e8 15 00 00
RSP: 0018:ffffc900001e0bb8 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000abcc77 RCX: ffffffff88587ddd
RDX: ffff888017261dc0 RSI: 0000000000000100 RDI: 0000000000000005
RBP: 00000010c6f7a0b5 R08: 0000000000000005 R09: 00000000000f4240
R10: 00000000000f4240 R11: 0000000000000000 R12: 00000000000f4240
R13: 0000000000000002 R14: 0000000000112e0b R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000020b50000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 pie_calculate_probability+0x2ad/0x850 net/sched/sch_pie.c:345
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
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 80 b9 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d 97 a6 a0 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
RSP: 0018:ffffc90000177d60 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8a328aae
RDX: 0000000000000001 RSI: ffff888145e5c000 RDI: ffff888145e5c064
RBP: ffff888145e5c064 R08: 0000000000000001 R09: ffffed1017326d9d
R10: ffff8880b9936ceb R11: 0000000000000000 R12: ffff888013727000
R13: ffffffff8d4509c0 R14: 0000000000000001 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x315/0x3f0 kernel/sched/idle.c:282
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
 start_secondary+0x200/0x290 arch/x86/kernel/smpboot.c:326
 secondary_startup_64_no_verify+0x167/0x16b
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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
