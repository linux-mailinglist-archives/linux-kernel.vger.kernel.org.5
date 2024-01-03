Return-Path: <linux-kernel+bounces-15555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D4822E18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092FFB22FCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC2B199A2;
	Wed,  3 Jan 2024 13:15:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950819471
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fcbe27a7fso120502455ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704287722; x=1704892522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpxS33OS4Cy74wKzZhoRykmxOK5FKGoeC7eiT7+tsPw=;
        b=OeMTcg/NKaHLBWOOzEyKrDiHgpF8zHCxsj+0lhe7NUi+QN9ZpD0h4OYIMy4HjPUV3M
         0lSOiwvNEG4UfTKI66izAm19tWThJi0YmFnQWK2hgSfrS+xSIbR8ndlwv+f+Zn5UKmV2
         jHOLyCqZe23FESD30vtXckyDI36Sh8elmQMIPWmjdGA0wLSwS94TUigbD5HQLUlEz7YL
         OZ0Ih5aRjIsLae40UrUojhIjgcXn9UkWmGO34YSoasTv7pZvZ6ym2Fst/gyd+j9DgA7z
         g8P5JCJ1JXs3SomrN61yot+lCXnp3K1GXPlAW6w6BKKXcwVE0NAu9BdVYXwjQCpPG249
         cIrQ==
X-Gm-Message-State: AOJu0YzWWHau21coBdG4wwvZgUzMgQndpF/6dHK64D0K7UQhWPpepboy
	ml3abtwUMYGIv2YpYlpTjNWIEwJMpaUAbnTJ6/5mfsk3lCF3
X-Google-Smtp-Source: AGHT+IEzYt9Z2PfkKreq04xGevK4vzXp4vmlRdDdO4tODa/ALD6V/+yb8YwSKBAijp4T1/7JaymaM3WwX7CLGPJbpYaDCZv9ZmVk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:35f:d5ea:8a86 with SMTP id
 15-20020a056e0216cf00b0035fd5ea8a86mr2725617ilx.5.1704287722790; Wed, 03 Jan
 2024 05:15:22 -0800 (PST)
Date: Wed, 03 Jan 2024 05:15:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fe821060e0a68d1@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in ipv6_rcv (4)
From: syzbot <syzbot+d9b3e95a78490389cfb7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1757cc21e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d9b3e95a78490389cfb7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1487fc06e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e5b4d6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e0793332378/disk-2cf4f94d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2600cb694c/vmlinux-2cf4f94d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f500d17840a0/bzImage-2cf4f94d.xz

The issue was bisected to:

commit 6ca6a6654225f3cd001304d33429c817e0c0b85f
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Mon Apr 29 22:48:32 2019 +0000

    taprio: Add support for setting the cycle-time manually

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10af6e26e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12af6e26e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14af6e26e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9b3e95a78490389cfb7@syzkaller.appspotmail.com
Fixes: 6ca6a6654225 ("taprio: Add support for setting the cycle-time manually")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 ticks this GP) idle=cd7c/1/0x4000000000000000 softirq=6575/6575 fqs=2
rcu: 	(detected by 0, t=10502 jiffies, g=7213, q=67 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 23 Comm: kworker/1:0 Not tainted 6.7.0-rc6-syzkaller-00010-g2cf4f94d8e86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: mld mld_ifc_work
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5756 [inline]
RIP: 0010:lock_acquire+0x1cb/0x520 kernel/locking/lockdep.c:5719
Code: 8b 4c 24 2c 8b 74 24 28 e8 82 af ff ff 48 c7 c7 c0 b1 cc 8a 48 83 c4 28 e8 92 fe 17 09 b8 ff ff ff ff 65 0f c1 05 3d 87 9a 7e <83> f8 01 0f 85 b4 02 00 00 9c 58 f6 c4 02 0f 85 9f 02 00 00 48 85
RSP: 0018:ffffc900001f0288 EFLAGS: 00000057
RAX: 0000000000000001 RBX: 1ffff9200003e053 RCX: ffffffff8167118e
RDX: 0000000000000001 RSI: ffffffff8accb1c0 RDI: ffffffff8b2efbe0
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff23e35d1
R10: ffffffff91f1ae8f R11: 0000000000000006 R12: 0000000000000001
R13: 0000000000000000 R14: ffff8880b992b958 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 000000001c711000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x2bd/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1076
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x2a/0x60 kernel/kcov.c:207
Code: f3 0f 1e fa 65 48 8b 14 25 c0 bc 03 00 65 8b 05 e4 4d 7c 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74 35 8b 82 fc 15 00 00 <85> c0 74 2b 8b 82 d8 15 00 00 83 f8 02 75 20 48 8b 8a e0 15 00 00
RSP: 0018:ffffc900001f0608 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffc900001f0690 RCX: ffffffff8139f812
RDX: ffff888017e5d940 RSI: ffffffff8139f824 RDI: 0000000000000006
RBP: 0000000000000001 R08: 0000000000000006 R09: ffffffff814f94fb
R10: ffffffff81000000 R11: 0000000000000006 R12: ffffffff814f94fb
R13: 0000000000000000 R14: ffffc900001f0750 R15: ffffc900001f06c5
 orc_find arch/x86/kernel/unwind_orc.c:206 [inline]
 unwind_next_frame+0x1e4/0x2390 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0xf8/0x350 mm/slub.c:3831
 kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:1015
 __kfree_skb net/core/skbuff.c:1073 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1108
 kfree_skb include/linux/skbuff.h:1234 [inline]
 ip6_mc_input+0x7a9/0xf40 net/ipv6/ip6_input.c:589
 dst_input include/net/dst.h:461 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ipv6_rcv+0x24e/0x380 net/ipv6/ip6_input.c:310
 __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5529
 __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5643
 process_backlog+0x101/0x6b0 net/core/dev.c:5971
 __napi_poll.constprop.0+0xb4/0x540 net/core/dev.c:6533
 napi_poll net/core/dev.c:6602 [inline]
 net_rx_action+0x956/0xe90 net/core/dev.c:6735
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 do_softirq kernel/softirq.c:454 [inline]
 do_softirq+0xaa/0xe0 kernel/softirq.c:441
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xfc/0x120 kernel/softirq.c:381
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:817 [inline]
 __dev_queue_xmit+0x87c/0x3d60 net/core/dev.c:4373
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip6_finish_output2+0x10ba/0x1830 net/ipv6/ip6_output.c:137
 __ip6_finish_output net/ipv6/ip6_output.c:211 [inline]
 ip6_finish_output+0x3c7/0xf80 net/ipv6/ip6_output.c:222
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x1e2/0x530 net/ipv6/ip6_output.c:243
 dst_output include/net/dst.h:451 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 mld_sendpack+0x9d1/0xe80 net/ipv6/mcast.c:1818
 mld_send_cr net/ipv6/mcast.c:2119 [inline]
 mld_ifc_work+0x756/0xcd0 net/ipv6/mcast.c:2650
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.447 msecs
rcu: rcu_preempt kthread starved for 10498 jiffies! g7213 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28752 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
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
CPU: 0 PID: 59 Comm: kworker/u4:4 Not tainted 6.7.0-rc6-syzkaller-00010-g2cf4f94d8e86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x508/0x1550 kernel/smp.c:855
Code: 3e b7 0b 00 f3 90 41 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 24 0e 00 00 8b 43 08 31 ff 83 e0 01 41 89 c5 89 c6 e8 88 b2 0b 00 <45> 85 ed 75 d0 e8 0e b7 0b 00 e8 09 b7 0b 00 44 8b 2c 24 bf 07 00
RSP: 0018:ffffc900015a7930 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b9941a60 RCX: ffffffff817bb7b8
RDX: ffff88801a280000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffffed101732834d
R13: 0000000000000001 R14: ffff8880b9941a68 R15: ffff8880b983d8c0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d61e6ff000 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2006 [inline]
 text_poke_bp_batch+0x22b/0x750 arch/x86/kernel/alternative.c:2216
 text_poke_flush arch/x86/kernel/alternative.c:2407 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2404 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2414
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:830 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:822
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
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

