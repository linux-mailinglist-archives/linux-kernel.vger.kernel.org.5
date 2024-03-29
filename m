Return-Path: <linux-kernel+bounces-123868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C577890F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA441C21861
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D61FA3;
	Fri, 29 Mar 2024 00:16:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02B241E7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671381; cv=none; b=Sbbx3g4DOCOQr1nyLa3wR8yERIVlnt+dlor5fpDD1qznJaxliLIL2MrtGBQy6IU560ngn3HVJHRFFCWHP6urX/J7z8UL/dtqgZTr+taljUzXAkasmgBzEA8R+7TnOaMYTsLQbi5eadCuWIxPzlCzL4glEnACY/eC76ZdVxFsU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671381; c=relaxed/simple;
	bh=bbYWLAyhJGcSgUbzU7pFYODwd8ep6SnhxyrnvyBWbT4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VBj5gZIk2iJpbG+v+ifcs5GOLoXx3v9ld/x2Yjrwuu04JKl/iE3O9gu13YVsw3doSiLtD8/eQkCgp+OWFoo2v9w7Tw/C9GsccTXkOFItnvqOLmftkTuSJPDir5ZeGTiloP9EFesEOnKM4+0HV3yWmZsy8oAkhKIUlg1jaLw/uDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc7a930922so159675539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711671379; x=1712276179;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyJKZJ7QSyTsVWqpXwUK9Yt9jyKTIuZpLergjzXuS1I=;
        b=L9foTzBXHZS8MkuZIQPSD71LBv44igg8uu2qC9jPczPkB29s6ebk+8Ky872wpvaiGl
         9opWuJVVv85emsgjZM88M5nMZ+WikWE4eCypA7n557QbttiovOKy4Bh/vFhWQIlvJHdG
         Nwuoc9oEyAtfEaXfKL36MeYpNcd4XZQhxjnXfWWk5fGvMsjKH/klsBezAReU3hi2+Avp
         ipYkfhuT77kHB5IHAHRwqECYPeV/B7sufoA3eNhSl0nA86cEpC+MtuhAzx3HPBG3CKh9
         AsbwYHUkgjqz838ulV7AJNaBMOK3vNgMJkkVLzXMq5FP5kpKpqcrfJMisvSYs0yfzoe7
         Zfuw==
X-Gm-Message-State: AOJu0Yw9Ul27WuE3GRRK4TM4Tmu0/wxJNvFwkrFfEi3EaWZNU+LvFzi9
	rkZzZvlCjJSpzkpZ5rLjE1mlDIA0nVws91mXXQMBNp3JzjqvIM6nmwN11UyhLkNRfFVT8eK8Fpm
	VPyQyiwmb2rFO4fbi625uUuaKjI9GYFo2YlVzkGO1Y12X0UE6t3+DsCX76Q==
X-Google-Smtp-Source: AGHT+IFcKsw5h2xgkwRIAJ1vQh7vcyNTtBhQ24Mvfg4NcMrZ8LaDwlr17iqymGXugIRENixEj+SxokrEkCi3mQhAVQRzd3Vh/Kmj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:350d:b0:368:ba38:9671 with SMTP id
 bu13-20020a056e02350d00b00368ba389671mr30390ilb.0.1711671379305; Thu, 28 Mar
 2024 17:16:19 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:16:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089427c0614c18cf4@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_clone (8)
From: syzbot <syzbot+c4c6c3dc10cc96bcf723@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12163769180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d023a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a54006180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4c6c3dc10cc96bcf723@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 ticks this GP) idle=f744/1/0x4000000000000000 softirq=6822/6822 fqs=0
rcu: 	(detected by 0, t=10503 jiffies, g=8373, q=658 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4736 Comm: dhcpcd Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:122 [inline]
RIP: 0010:lock_release+0x124/0x9d0 kernel/locking/lockdep.c:5767
Code: 00 65 48 8b 04 25 80 ce 03 00 48 89 44 24 18 48 8d 98 d4 0a 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 38 84 c0 0f 85 c3 05 00 00 <83> 3b 00 0f 85 f1 04 00 00 4c 8d b4 24 b0 00 00 00 4c 89 f3 48 c1
RSP: 0018:ffffc90000a08a60 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff888018308ad4 RCX: ffffffff8171c080
RDX: 0000000000000000 RSI: ffffffff8bfec640 RDI: ffffffff8bfec600
RBP: ffffc90000a08b90 R08: ffffffff8f86ae6f R09: 1ffffffff1f0d5cd
R10: dffffc0000000000 R11: fffffbfff1f0d5ce R12: 1ffff92000141158
R13: ffffffff84ac5555 R14: ffffc90000a08bc0 R15: dffffc0000000000
FS:  00007f8e49f9b740(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8e4a140b10 CR3: 0000000028508000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
 _raw_spin_unlock_irqrestore+0x79/0x140 kernel/locking/spinlock.c:194
 debug_object_deactivate+0x2d5/0x390 lib/debugobjects.c:778
 debug_hrtimer_deactivate kernel/time/hrtimer.c:428 [inline]
 debug_deactivate+0x1b/0x200 kernel/time/hrtimer.c:484
 __run_hrtimer kernel/time/hrtimer.c:1660 [inline]
 __hrtimer_run_queues+0x30f/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:184 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_cmp8+0x35/0x90 kernel/kcov.c:284
Code: 0c 25 80 ce 03 00 65 8b 05 a0 db 6e 7e a9 00 01 ff 00 74 10 a9 00 01 00 00 74 57 83 b9 14 16 00 00 00 74 4e 8b 81 f0 15 00 00 <83> f8 03 75 43 48 8b 91 f8 15 00 00 44 8b 89 f4 15 00 00 49 c1 e1
RSP: 0018:ffffc900035ff500 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff81000000 RCX: ffff888018308000
RDX: ffffc900035ff615 RSI: ffffffff81000000 RDI: ffffffff81ecc4e1
RBP: ffffffff81ecc4e1 R08: ffffffff81409149 R09: ffffc900035ff6d0
R10: 0000000000000003 R11: ffffffff8180dbc0 R12: ffffc900035ff5e0
R13: ffffc900035ff630 R14: dffffc0000000000 R15: ffffffff81ecc4e2
 orc_find arch/x86/kernel/unwind_orc.c:206 [inline]
 unwind_next_frame+0x1d9/0x2a00 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x192/0x380 mm/slub.c:3903
 alloc_task_struct_node kernel/fork.c:176 [inline]
 dup_task_struct+0x57/0x7d0 kernel/fork.c:1106
 copy_process+0x5d1/0x3df0 kernel/fork.c:2219
 kernel_clone+0x21e/0x8d0 kernel/fork.c:2796
 __do_sys_clone kernel/fork.c:2939 [inline]
 __se_sys_clone kernel/fork.c:2923 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2923
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f8e4a04ba12
Code: 41 5d 41 5e 41 5f c3 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 e7 43 0f 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff3d31e228 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00005624b41b1601 RCX: 00007f8e4a04ba12
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fff3d33e798 R08: 0000000000000000 R09: 00005624b41b15d0
R10: 00007f8e49f9ba10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00005624b41b1604
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10502 jiffies! g8373 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=4283
rcu: rcu_preempt kthread starved for 10503 jiffies! g8373 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:24656 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2572
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

