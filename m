Return-Path: <linux-kernel+bounces-159612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61568B310A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE7B28120A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AAD13B787;
	Fri, 26 Apr 2024 07:05:35 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDB613A898
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115135; cv=none; b=JQHVbpYufBLe+WtbAV/PK014AxlYVaByaPo7CokqEd5vrTjTfoMmR+qCxpKJ7SjhjgqFL8z16fbwV0SPUXfE0/fRPwN9/hn5agjgrQuYz5hZT9yc7sBhrmI8HQu7X4m7mvhBTkPXLZlkeaaTBT41d9RH04cyxvugTyznFtkna/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115135; c=relaxed/simple;
	bh=IUefkBgStsG7qjLmmT8ad5p3b9i11cao4Up/IlYc9JM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XxMgu0z8tn6puoFQalECM7z6x5P0o9qQ+s1LVI2Rnb0G4BeZOvZiV0zr9422NSIAfznxDZQGgbujc2odFg0V03Ln3lHEL9wSg59B23huoFcdgF8BqQUw+9NqQeEWgJKchIzDFuGXiYtZebGJe+bzNmxGwJDpgZEWTtv8qEIuuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dabcf2a2e8so188453039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115133; x=1714719933;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PArObN4zKmDbTvV+luiqqQTRhkPV3ibzp4yiWJM63tE=;
        b=cmq3mNb00WLjdwlVrEB35EAYqPW/R1NkP2a1cLVSAnneOysVHe99dDulndps4Cgy15
         jl0hg4rIl86y5Oa/k5wVQplEBABt9b6hCmq2KxLNi7B40vMmgZU3tweosq/IxdYsZ41L
         8PGZ1zNFQ6LgOgJEA+ogO2A1nmRHp0en1GJk5IMUI/OGlMmIP6o8IlTFBq5m0n/hV6bj
         5RzqpvtZv9nk5e6FHmYTj/0WOjK+SmnjmMGE0ugA/cJaZqXlYt4K70InnGv397NNV7vw
         /ZGC7kJtFoiEkNoFINN9S7CnPlxHLUINgF3LVFdAS3K296RbQeicyEVl2oEafsgmZXVV
         5ozg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Wi2vcm7ErSwErMjiEQTjgOQ6jwBmxk2cuw15856XsPM0ULfVXzFjmWWjdz8zW2dszkZJ9mJNTJAEVbFvJcbisAkssyPuWLz5zXcH
X-Gm-Message-State: AOJu0YxMJ0E0QS1s+TneiMvRSPi6AeBuTXhMr8fOocgXHBAiDxurTnGK
	c4csPgAqls+/gQCoAbkXErp61F6oyelq3FpFvAXwH1npKF8qcAa8vrM09wqB+WYtZ5i6KYStE5u
	W1jmTIlglieoc1+vJIYWBhMnvyvDAjLAKfnC8q2YKK+m5vM4aLfrwlPA=
X-Google-Smtp-Source: AGHT+IFi0NFn8CoqocSjUPB0lKpshpVbe0NF0TpUfTZdjsjNRKMBZ/Xxz6dtkeT3Yyl/JcU3kLHa/CriPBkEyHtMS1TGFNVC/iPw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1506:b0:485:5afc:d45d with SMTP id
 b6-20020a056638150600b004855afcd45dmr95977jat.4.1714115132974; Fri, 26 Apr
 2024 00:05:32 -0700 (PDT)
Date: Fri, 26 Apr 2024 00:05:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009afb860616fa87cf@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in rt_sigreturn
From: syzbot <syzbot+f87fd2bd13a4c9c5af8a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48cf398f15fc Merge tag 'char-misc-6.9-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117cb06b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=f87fd2bd13a4c9c5af8a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152c59fd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112d3227180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5eb781b74b25/disk-48cf398f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c1169bc73d7/vmlinux-48cf398f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/532b0a6ae362/bzImage-48cf398f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f87fd2bd13a4c9c5af8a@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=7773, q=24 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10499 (4294970269-4294959770), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10500 jiffies! g7773 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27664 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:1862
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5122 Comm: syz-executor760 Not tainted 6.9.0-rc4-syzkaller-00329-g48cf398f15fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__update_load_avg_cfs_rq+0x36e/0x940 kernel/sched/pelt.c:333
Code: 00 89 db be 08 00 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 90 30 9f 8f e8 30 f8 81 00 48 0f a3 1d 08 36 38 0e 0f 82 f3 00 00 00 <48> 83 c4 20 b8 01 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc
RSP: 0018:ffffc90000a08de0 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff8166fa80
RDX: 0000000000000000 RSI: ffffffff8b6f56a0 RDI: ffffffff8d260b48
RBP: 000000000000ba11 R08: 0000000000000000 R09: fffffbfff1f3e612
R10: ffffffff8f9f3097 R11: 0000000000000001 R12: 000000000003d78c
R13: 0000000000000029 R14: ffff8880b953eb88 R15: 0000000000000012
FS:  000055557ed5a3c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002006b000 CR3: 0000000076636000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 update_cfs_rq_load_avg kernel/sched/fair.c:4634 [inline]
 __update_blocked_fair kernel/sched/fair.c:9325 [inline]
 update_blocked_averages+0x729/0x2160 kernel/sched/fair.c:9431
 run_rebalance_domains+0x123/0x1a0 kernel/sched/fair.c:12427
 __do_softirq+0x218/0x922 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:write_comp_data+0x34/0x90 kernel/kcov.c:236
Code: 48 8b 15 ff 1b 76 7e 65 8b 05 00 1c 76 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 14 16 00 00 85 c0 74 4f 8b 82 f0 15 00 00 <83> f8 03 75 44 48 8b 82 f8 15 00 00 8b 92 f4 15 00 00 48 8b 38 48
RSP: 0018:ffffc9000338fb00 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8133a8dc
RDX: ffff88802935bc00 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00007ffca8b0d5c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffca8b0d5c0
R13: 0000000000000000 R14: ffffc9000338fbb0 R15: 0000000000000007
 __fpu_restore_sig+0x23c/0x1430 arch/x86/kernel/fpu/signal.c:357
 fpu__restore_sig+0x102/0x180 arch/x86/kernel/fpu/signal.c:493
 restore_sigcontext+0x4ca/0x6a0 arch/x86/kernel/signal_64.c:95
 __do_sys_rt_sigreturn+0x138/0x230 arch/x86/kernel/signal_64.c:263
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f6dcbce79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca8b0d998 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f6f6dcbce79
RDX: 000000002006b000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055557ed5a370
R13: 0000000000000001 R14: 00007ffca8b0da10 R15: 00007ffca8b0da00
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.954 msecs


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

