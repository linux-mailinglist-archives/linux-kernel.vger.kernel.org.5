Return-Path: <linux-kernel+bounces-12041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BEC81EF43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CFC1F21FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529AE4502A;
	Wed, 27 Dec 2023 13:54:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A264500F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35f8dc26895so51131015ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 05:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703685258; x=1704290058;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjFsV7ylngU8qwYy9JYFmprL6NBBIeRKiiwsTgEIsys=;
        b=YUeOJPx0pTAaqVzBCXiwCFSPupCRHlcGPZDOscEmefC+isTSFaBdvOF84LifanYch8
         Zm8irmoqq2gKGhifnjFMkNEkxlWuKgdqTpBjsO75PWSHJh1WOK0zxh7dSlQMu2NS8P0w
         UNaYfpabHZasqQNi0dgp6YQbxwhK06QTyLbezM8K+YB9WME/sJbNom9Uw74Pl5v2Plq1
         xuwe2FaOJNe3PNmow7eJfNyfxz7dkjnWEr1H2sYebSTBs6JZCmaU1/sKfznjpSZI+5wv
         b0J23Nykei16ppzTmaI0r/FEIcHJ5yChLcA/0P01YPOhvgr+eTSZsZ9WjN3NQT/dd8Mc
         iMuQ==
X-Gm-Message-State: AOJu0YyGUy+zSx69UzekTUf9eZshxvhz8A+kT+LVP/f5hrE87teDhxFF
	HCKs67NLHEu9gChdBxy9DG0qEkJqh1HkTSYaYNFumnBW3Bc3
X-Google-Smtp-Source: AGHT+IGeW0v6iW6rqzh1GbjMVdMj1xo1HyDKf4ckt7i0a7zioi/qlkFz0z73iApFwdNYFQ1vKyw9XT/alHkr64wpdNMpQMe7yjnW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d06:b0:35f:e976:32b1 with SMTP id
 db6-20020a056e023d0600b0035fe97632b1mr860315ilb.0.1703685258414; Wed, 27 Dec
 2023 05:54:18 -0800 (PST)
Date: Wed, 27 Dec 2023 05:54:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3123d060d7e22bd@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in fq_pie_timer (2)
From: syzbot <syzbot+15c3ba3f7ca8ced0914d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, gautamramk@gmail.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, lesliemonis@gmail.com, 
	linux-kernel@vger.kernel.org, mohitbhasi1998@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdp.sachin@gmail.com, 
	syzkaller-bugs@googlegroups.com, tahiliani@nitk.edu.in, 
	vsaicharan1998@gmail.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c5e046bdcb2 Merge tag 'net-6.7-rc7' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17a0abbee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=15c3ba3f7ca8ced0914d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11232ecee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1127e71ae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52f67fb04584/disk-7c5e046b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b385b087cb3d/vmlinux-7c5e046b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4cf3e554b44/bzImage-7c5e046b.xz

The issue was bisected to:

commit ec97ecf1ebe485a17cd8395a5f35e6b80b57665a
Author: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
Date:   Wed Jan 22 18:22:33 2020 +0000

    net: sched: add Flow Queue PIE packet scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154a70cee80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174a70cee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=134a70cee80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15c3ba3f7ca8ced0914d@syzkaller.appspotmail.com
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=9389, q=958 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10498 (4294962885-4294952387), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10499 jiffies! g9389 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28752 pid:17    tgid:17    ppid:2      flags:0x00004008
Call Trace:
 <IRQ>
 sched_show_task kernel/sched/core.c:9146 [inline]
 sched_show_task+0x42e/0x650 kernel/sched/core.c:9120
 rcu_check_gp_kthread_starvation+0x19f/0x450 kernel/rcu/tree_stall.h:548
 print_other_cpu_stall kernel/rcu/tree_stall.h:656 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:796 [inline]
 rcu_pending kernel/rcu/tree.c:3891 [inline]
 rcu_sched_clock_irq+0x2269/0x3150 kernel/rcu/tree.c:2259
 update_process_times+0x17b/0x220 kernel/time/timer.c:2071
 tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:255
 tick_nohz_highres_handler+0xe9/0x110 kernel/time/tick-sched.c:1516
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x647/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1076
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
RIP: 0010:pie_calculate_probability+0x284/0x850 net/sched/sch_pie.c:345
Code: 89 c5 48 89 6c 24 38 e8 fa 47 e6 f8 47 8d 24 a4 31 d2 4c 89 ff 43 8d 0c 24 49 c1 ee 02 48 b8 ff ff ff ff ff ff ff 00 48 f7 f1 <48> 89 c5 48 89 c6 48 c1 eb 02 49 89 cc e8 da 42 e6 f8 49 39 ef 73
RSP: 0018:ffffc900001f0bb8 EFLAGS: 00000207
RAX: 0000068db8bac710 RBX: 000000002af31dc4 RCX: 0000000000002710
RDX: 0000000000001eff RSI: ffffffff88a129d6 RDI: 0000000000000000
RBP: 00004189374bc6a7 R08: 0000000000000005 R09: 00000000000f4240
R10: 00000000000003e8 R11: 0000000000000002 R12: 0000000000001388
R13: 0000000000000004 R14: 000000000112e0be R15: 0000000000000000
 fq_pie_timer+0x215/0x5a0 net/sched/sch_fq_pie.c:391
 call_timer_fn+0x193/0x590 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb20 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:finish_task_switch.isra.0+0x223/0xca0 kernel/sched/core.c:5250
Code: 0a 00 00 44 8b 0d 35 8b be 0d 45 85 c9 0f 85 c0 01 00 00 48 89 df e8 cc f8 ff ff e8 57 47 33 00 fb 65 48 8b 1c 25 c0 bc 03 00 <48> 8d bb d8 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc90000167a08 EFLAGS: 00000206
RAX: 000000000001e735 RBX: ffff888017e48000 RCX: 1ffffffff1e320a9
RDX: 0000000000000000 RSI: ffffffff8accaec0 RDI: ffffffff8b2efba0
RBP: ffffc90000167a50 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f1937d7 R11: 0000000000000000 R12: ffff8880b993d478
R13: ffff888026c53b80 R14: 0000000000000000 R15: ffff8880b993c700
 context_switch kernel/sched/core.c:5379 [inline]
 __schedule+0xee3/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 schedule_timeout+0x137/0x290 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1631
 rcu_gp_kthread+0x24b/0x380 kernel/rcu/tree.c:1830
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 17 Comm: rcu_preempt Not tainted 6.7.0-rc6-syzkaller-00157-g7c5e046bdcb2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
RIP: 0010:pie_calculate_probability+0x284/0x850 net/sched/sch_pie.c:345
Code: 89 c5 48 89 6c 24 38 e8 fa 47 e6 f8 47 8d 24 a4 31 d2 4c 89 ff 43 8d 0c 24 49 c1 ee 02 48 b8 ff ff ff ff ff ff ff 00 48 f7 f1 <48> 89 c5 48 89 c6 48 c1 eb 02 49 89 cc e8 da 42 e6 f8 49 39 ef 73
RSP: 0018:ffffc900001f0bb8 EFLAGS: 00000207
RAX: 0000068db8bac710 RBX: 000000002af31dc4 RCX: 0000000000002710
RDX: 0000000000001eff RSI: ffffffff88a129d6 RDI: 0000000000000000
RBP: 00004189374bc6a7 R08: 0000000000000005 R09: 00000000000f4240
R10: 00000000000003e8 R11: 0000000000000002 R12: 0000000000001388
R13: 0000000000000004 R14: 000000000112e0be R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556c89ca8 CR3: 0000000078bae000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 fq_pie_timer+0x215/0x5a0 net/sched/sch_fq_pie.c:391
 call_timer_fn+0x193/0x590 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb20 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:finish_task_switch.isra.0+0x223/0xca0 kernel/sched/core.c:5250
Code: 0a 00 00 44 8b 0d 35 8b be 0d 45 85 c9 0f 85 c0 01 00 00 48 89 df e8 cc f8 ff ff e8 57 47 33 00 fb 65 48 8b 1c 25 c0 bc 03 00 <48> 8d bb d8 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc90000167a08 EFLAGS: 00000206
RAX: 000000000001e735 RBX: ffff888017e48000 RCX: 1ffffffff1e320a9
RDX: 0000000000000000 RSI: ffffffff8accaec0 RDI: ffffffff8b2efba0
RBP: ffffc90000167a50 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f1937d7 R11: 0000000000000000 R12: ffff8880b993d478
R13: ffff888026c53b80 R14: 0000000000000000 R15: ffff8880b993c700
 context_switch kernel/sched/core.c:5379 [inline]
 __schedule+0xee3/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 schedule_timeout+0x137/0x290 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1631
 rcu_gp_kthread+0x24b/0x380 kernel/rcu/tree.c:1830
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

