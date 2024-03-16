Return-Path: <linux-kernel+bounces-105074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD5987D8C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 05:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275AC1F21B50
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045595C89;
	Sat, 16 Mar 2024 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1ft/4G9"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0C4C6D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710564513; cv=none; b=jRdFgM4aJ5sh5jGq9LOqrPjQwix0deFQI0SpZKcw6QkIBBn9O1mKZX6eJLCHKeSdaGXNtT239dEnaWsNZTYs6vkGIZzk3f/5vAmCzXDu1IFjeAgMGOKh4c4fUM78ZY5bC+aKEUPOCzaps3ixNDQShBLWyvalJx21bLDwtDULxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710564513; c=relaxed/simple;
	bh=A9hk1W1hEejsz85UL/C3UiKd3XP2pb5e7Mvr0G8jeKw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kAr/vNL1eg6wjvkkgP2UaOZJ35CLrojzGzaGufV6df4vMhP7UnhlWuCsfX+YUdSHclORthwUtUe45VlUYobCtONVcnEw5ihYjrMUlo23WvcEVUbA3ceYyxxSCb6pAGrK8xe9BXKsl+aVYaTDenSiNWGdncksjUVMJ63qv0HBuJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1ft/4G9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46807a7d3fso287859066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710564509; x=1711169309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XVm4AOTNkTiNhIKbYBdl6S/8X+dggdTy33orcYroaac=;
        b=Q1ft/4G9JFomJ6FAvxVYZRQ+BObEtcRFmCfkbJBluVEIc3ceX+uB8DEMYMIQWe025H
         XkyvbNOcLK7WN7lcDosFCsQ/Tmb6iyacuVVRi/EYHeKWoS8QAvQVUzahV/ValJEJ0SAL
         h1uFKqMGkBmA7z/5OTwORayBHmFcQQH5yuN4J8hW5rw8paSroyPaz9el5ihXS2WCj0sD
         OyUcHx7nkrNKFTz/FnhZ1ktpEEE616wdEyI/emSxrG6QvZNzOfgOlO1dt9FTn40W8qah
         YIyE6vY1HlUx7AdR9nHNcPeyzIEbHpk5ylalM0pp+5jQcVYVCQ+ztNLNiowhjKewfGSq
         tJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710564509; x=1711169309;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVm4AOTNkTiNhIKbYBdl6S/8X+dggdTy33orcYroaac=;
        b=Piz1zs3GxAGn7QHbEUj91CoCmd7YwPTskK2VPvU+jmWlN68hyEkfEAURgoyb5QHtx2
         IrQdC7YZvsOZN00Z8knSZiv0xoIlmGfgSfGunPQmY854iAcBqe4uapwAu5kTZ6nFKRXa
         zO4zd5jCg6aikfd07mROUcAxLISmcMlSP/r1Ny/b8ZVRD1qLb7JPnasIcwG3lSjHNgwW
         5LvMd/x13idGle3/bQ64gXNAKxXnPD8wkpM/oS7Nf2Kx7lin/NSc7meukpGIgVMU51Lv
         aSsACbnl2ezJv1pjFVgTuXRxgiVuoz1Hscycwel8bXFJRsjFjcUYO7kUDKfScFiJHTLq
         3UmA==
X-Forwarded-Encrypted: i=1; AJvYcCV6INBl2CsTP/Tivl+PVoME3tW4aJXiSMSQuSPyFLaJoEuizsNQTvDBUW1VFFu+FGoHw0T4EUffxH1qMuJrTQdc797IeaXThbKAY3Tq
X-Gm-Message-State: AOJu0YwWH3kmTUNwOCSCwkAjAFvPP+BGLImC9u/Go40OMbkIVfevGT0I
	7MKElk3dnkdr4gwFCLQlGi8FbSSK/+cXaZcYNVpaqex9lJTaceDhFJDCmp0GwuZMGx0RuQoY5ZQ
	P0epgBINQIGl24qYJQp4nb01opbo=
X-Google-Smtp-Source: AGHT+IEYAcObPRZTj1CVlpX7E/OKEi50puWJi8w/GygcKPqvVMBArXtivSE12Zq8oFXiWBcH+dLKQslrgHPYUZKvUrY=
X-Received: by 2002:a17:906:2bd3:b0:a46:268b:228a with SMTP id
 n19-20020a1709062bd300b00a46268b228amr9401674ejg.29.1710564509422; Fri, 15
 Mar 2024 21:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Sat, 16 Mar 2024 12:48:18 +0800
Message-ID: <CAKHoSAtN==vQxdfxzTmVesF_9xdR3h0jsepRFf1Gk7OFWw1nAQ@mail.gmail.com>
Subject: BUG: Bad rss-counter state
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)

git tree: upstream

console output: https://pastebin.com/raw/KYUZrCEa

kernel config: https://pastebin.com/raw/Qa9fj2Ev

C reproducer: https://pastebin.com/raw/pW0J23UU

Syzlang reproducer: https://pastebin.com/raw/8bJrsXLY

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#6] PREEMPT SMP KASAN NOPTI
RIP: 0010:__wake_up_common+0x6f/0x1d0 kernel/sched/wait.c:85
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Code: 00 00 48 8b 5b 08 4c 8d 6b e8 48 3b 1c 24 0f 84 07 01 00 00 e8
f2 ba 1d 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
02 00 0f 85 2d 01 00 00 48 bd 00 00 00 00 00 fc ff df 48 8b
CPU: 2 PID: 137 Comm: systemd-udevd Tainted: G      D            6.8.0 #1
RSP: 0018:ffff88810409fb40 EFLAGS: 00010056
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8268aa3e
RIP: 0010:__wake_up_common+0x6f/0x1d0 kernel/sched/wait.c:85
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888100c9c320
Code: 00 00 48 8b 5b 08 4c 8d 6b e8 48 3b 1c 24 0f 84 07 01 00 00 e8
f2 ba 1d 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
02 00 0f 85 2d 01 00 00 48 bd 00 00 00 00 00 fc ff df 48 8b
RBP: ffff888100c9c320 R08: 0000000000000000 R09: ffffed1020813f63
RSP: 0018:ffff888103537b40 EFLAGS: 00010056
R10: 0000000000000001 R11: ffff88811b238a20 R12: 0000000000000001

RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8268aa3e
R13: ffffffffffffffe8 R14: 0000000000000000 R15: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888100c99320
FS:  0000000000000000(0000) GS:ffff88811af00000(0000) knlGS:0000000000000000
RBP: ffff888100c99320 R08: 0000000000000000 R09: ffffed10206a6f63
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
R10: 0000000000000001 R11: ffff88811b038a20 R12: 0000000000000001
CR2: 0000562ccdf55168 CR3: 00000000856aa006 CR4: 0000000000770ef0
R13: ffffffffffffffe8 R14: 0000000000000000 R15: 0000000000000000
PKRU: 55555554
FS:  0000000000000000(0000) GS:ffff88811b000000(0000) knlGS:0000000000000000
note: systemd-udevd[138] exited with irqs disabled
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
note: systemd-udevd[138] exited with preempt_count 1
CR2: 0000562ccdf55168 CR3: 0000000104a44004 CR4: 0000000000770ef0
Fixing recursive fault but reboot is needed!
PKRU: 55555554
Call Trace:
 <TASK>
 __wake_up_common_lock kernel/sched/wait.c:106 [inline]
 __wake_up+0x39/0x60 kernel/sched/wait.c:127
 netlink_release+0x86a/0x1610 net/netlink/af_netlink.c:785
 __sock_release+0xb3/0x270 net/socket.c:659
 sock_close+0x19/0x30 net/socket.c:1421
 __fput+0x265/0xb70 fs/file_table.c:376
 task_work_run+0x16d/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa2d/0x2670 kernel/exit.c:871
 do_group_exit+0xc8/0x280 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f15f7c24bd9
Code: Unable to access opcode bytes at 0x7f15f7c24baf.
RSP: 002b:00007ffdba06ac38 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f15f7c24bd9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000562ccd6f6270 R08: fffffffffffffe00 R09: 0000000000000004
R10: 0000000000000018 R11: 0000000000000202 R12: 0000562ccdf68ec0
R13: 0000562ccdf74f20 R14: 00007ffdba06acb0 R15: 0000562ccdf69720
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__wake_up_common+0x6f/0x1d0 kernel/sched/wait.c:85
Code: 00 00 48 8b 5b 08 4c 8d 6b e8 48 3b 1c 24 0f 84 07 01 00 00 e8
f2 ba 1d 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
02 00 0f 85 2d 01 00 00 48 bd 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffff88810409fb40 EFLAGS: 00010056
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8268aa3e
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888100c9c320
RBP: ffff888100c9c320 R08: 0000000000000000 R09: ffffed1020813f63
R10: 0000000000000001 R11: ffff88811b238a20 R12: 0000000000000001
R13: ffffffffffffffe8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88811b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562ccdf55168 CR3: 0000000104a44004 CR4: 0000000000770ef0
PKRU: 55555554
note: systemd-udevd[137] exited with irqs disabled
note: systemd-udevd[137] exited with preempt_count 1
Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: systemd-udevd/137/0x00000000
Modules linked in:
CPU: 2 PID: 137 Comm: systemd-udevd Tainted: G      D            6.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x72/0xa0 lib/dump_stack.c:106
 __schedule_bug+0xc1/0x100 kernel/sched/core.c:5943
 schedule_debug kernel/sched/core.c:5970 [inline]
 __schedule+0x1bf3/0x2460 kernel/sched/core.c:6620
 do_task_dead+0xa4/0xc0 kernel/sched/core.c:6743
 make_task_dead+0x378/0x3c0 kernel/exit.c:979
 rewind_stack_and_make_dead+0x17/0x20 arch/x86/entry/entry_64.S:1494
RIP: 0033:0x7f15f7c24bd9
Code: Unable to access opcode bytes at 0x7f15f7c24baf.
RSP: 002b:00007ffdba06ac38 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f15f7c24bd9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000562ccd6f6270 R08: fffffffffffffe00 R09: 0000000000000004
R10: 0000000000000018 R11: 0000000000000202 R12: 0000562ccdf68ec0
R13: 0000562ccdf74f20 R14: 00007ffdba06acb0 R15: 0000562ccdf69720
 </TASK>
ata1: found unknown device (class 0)
program syz-executor124 is using a deprecated SCSI ioctl, please
convert it to SG_IO
ata1: found unknown device (class 0)
program syz-executor124 is using a deprecated SCSI ioctl, please
convert it to SG_IO
----------------
Code disassembly (best guess):
   0: 00 00                add    %al,(%rax)
   2: 48 8b 5b 08          mov    0x8(%rbx),%rbx
   6: 4c 8d 6b e8          lea    -0x18(%rbx),%r13
   a: 48 3b 1c 24          cmp    (%rsp),%rbx
   e: 0f 84 07 01 00 00    je     0x11b
  14: e8 f2 ba 1d 00        call   0x1dbb0b
  19: 48 89 da              mov    %rbx,%rdx
  1c: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  23: fc ff df
  26: 48 c1 ea 03          shr    $0x3,%rdx
* 2a: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e: 0f 85 2d 01 00 00    jne    0x161
  34: 48 bd 00 00 00 00 00 movabs $0xdffffc0000000000,%rbp
  3b: fc ff df
  3e: 48                    rex.W
  3f: 8b                    .byte 0x8b

