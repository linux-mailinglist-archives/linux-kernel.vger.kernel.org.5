Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC82B77F30A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbjHQJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349522AbjHQJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:15:28 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20E2D69
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:15:08 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bf0b05bbbeso12168105ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263707; x=1692868507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaAEoaqZiKgdatVqeSM6rwKu+YRM0SW+qEnc7EKsc7A=;
        b=gw5y/Fu0vCHwEXDoIGCgO7ou7k6K4raV0PgRNFRp3siMjlU5ZY9rnNIP1x754pg25i
         nbsY2d6KPXnXdj6Kzu4FB+UyYhWK2L5i1rbDhOqBl6ledJ9649vbXzxC53+k1eiPQpEV
         WnLsxWxA6YN3JNpuIX6hidaVRoNXY8DxN6fOBMN5iJ4PNV4s+SfXXwcvOyBxGDDVa6Cp
         wER92zrudQlCHkGd00AUVEcr+nBhQae9g37SshH0XEgAi8UFgQIoTrDPaCG+/26y538H
         SZK4oeWDJIHblZXUAx/GYQWkvVDfHqLgUJeSj6W2G2SlToGNFR4VYa0zidHI7Fb/tf3X
         S6uA==
X-Gm-Message-State: AOJu0YyjCA5Tz4rMkpuYD5846evL6FStOe0KXsEY1x5rKzD1VJ7BfrRa
        BOL45bh8tLkaEpPCsXuZo+aYbXegt4dDqliw+VSY8xIc4mim
X-Google-Smtp-Source: AGHT+IEBGTiaTahQVxmEjCY2+VkgLpeBeP0bwIw7K41J6xrN6u3JZwXK6cS9ZFnywTkAFP3y1MWGMvTR+Wq4Qf4XEzvpxH+ErLWu
MIME-Version: 1.0
X-Received: by 2002:a17:903:41ca:b0:1b8:9eca:d6a7 with SMTP id
 u10-20020a17090341ca00b001b89ecad6a7mr1486530ple.7.1692263707666; Thu, 17 Aug
 2023 02:15:07 -0700 (PDT)
Date:   Thu, 17 Aug 2023 02:15:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029708206031ad94a@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in toggle_allocation_gate
From:   syzbot <syzbot+52d2f6feb48dc7328968@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
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

HEAD commit:    950fe35831af Merge branch 'ipv6-expired-routes'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13cc856ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=52d2f6feb48dc7328968
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d34703a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a9a040680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3d4f3ce986f/disk-950fe358.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5afd9c7f284/vmlinux-950fe358.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a203c65f0ae/bzImage-950fe358.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52d2f6feb48dc7328968@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (1128 ticks this GP) idle=7504/1/0x4000000000000000 softirq=9033/9035 fqs=2245
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:    33937      18602         3669   ==> 52480(ms)
rcu: 	(t=10500 jiffies g=8777 q=327 ncpus=2)
CPU: 0 PID: 2848 Comm: kworker/u4:6 Not tainted 6.5.0-rc5-syzkaller-01605-g950fe35831af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__sanitizer_cov_trace_pc+0x60/0x70 kernel/kcov.c:225
Code: 82 e0 15 00 00 83 f8 02 75 20 48 8b 8a e8 15 00 00 8b 92 e4 15 00 00 48 8b 01 48 83 c0 01 48 39 d0 73 07 48 89 01 48 89 34 c1 <c3> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 41 57
RSP: 0018:ffffc90000007cf8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888067717000 RCX: 0000000000000100
RDX: ffff888029910000 RSI: ffffffff885ba5a0 RDI: ffff8880677938d8
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffffc90000007ff8 R12: ffff888067793800
R13: 0000000000000000 R14: ffff88806b62a000 R15: ffff888067793818
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5e85f05748 CR3: 0000000021fc2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 taprio_dequeue_from_txq+0x3c0/0x8d0 net/sched/sch_taprio.c:726
 taprio_dequeue_tc_priority+0x289/0x4b0 net/sched/sch_taprio.c:798
 taprio_dequeue+0x12e/0x5f0 net/sched/sch_taprio.c:868
 dequeue_skb net/sched/sch_generic.c:292 [inline]
 qdisc_restart net/sched/sch_generic.c:397 [inline]
 __qdisc_run+0x1c4/0x19d0 net/sched/sch_generic.c:415
 qdisc_run include/net/pkt_sched.h:125 [inline]
 qdisc_run include/net/pkt_sched.h:122 [inline]
 net_tx_action+0x71e/0xc80 net/core/dev.c:5183
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__sanitizer_cov_trace_pc+0x3b/0x70 kernel/kcov.c:207
Code: 81 e1 00 01 00 00 65 48 8b 14 25 80 b9 03 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 04 16 00 00 85 c0 74 2b 8b 82 e0 15 00 00 <83> f8 02 75 20 48 8b 8a e8 15 00 00 8b 92 e4 15 00 00 48 8b 01 48
RSP: 0018:ffffc9000c5af920 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc9000c5afa70 RCX: 0000000000000000
RDX: ffff888029910000 RSI: ffffffff8a2aa9a3 RDI: 0000000000000005
RBP: ffffc9000c5afa94 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000c5afabc
R13: 0000000000000000 R14: 000000000000b000 R15: ffffffff903ba200
 insn_get_modrm+0x203/0x730 arch/x86/lib/insn.c:363
 insn_get_sib+0x1ad/0x320 arch/x86/lib/insn.c:421
 insn_get_displacement+0x23a/0x680 arch/x86/lib/insn.c:464
 insn_get_immediate+0x550/0x1c50 arch/x86/lib/insn.c:632
 insn_get_length arch/x86/lib/insn.c:707 [inline]
 insn_decode+0x2ae/0x340 arch/x86/lib/insn.c:747
 text_poke_loc_init+0xc2/0x4d0 arch/x86/kernel/alternative.c:2315
 arch_jump_label_transform_queue+0x97/0x100 arch/x86/kernel/jump_label.c:138
 __jump_label_update+0x125/0x420 kernel/jump_label.c:475
 jump_label_update+0x32e/0x410 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b5/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:831 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:823
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
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
