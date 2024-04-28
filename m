Return-Path: <linux-kernel+bounces-161230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FDB8B4945
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B584A1C20C85
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 03:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13FA1877;
	Sun, 28 Apr 2024 03:03:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818A15A4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273407; cv=none; b=I0KZBMpaG6C0BUInQ4BjW2iuNgjULEdgIGDojJuzH50k0zPWb7Vgu4+KSMCzcG9ljB5fmyW82ND1UexjTya3ep1TJUxGhyeqrHjepWGcunnk2pX62SPkf3JOvPRqRGqL6byq71y13T0IKxS0/e+xQk9IQJVKL+Lv6H6H1+70GHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273407; c=relaxed/simple;
	bh=1sTqxZAPmzlMlpmipOg25Hhn1FE0/2zcr1bHXUevv9A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qPNv/TA6j5bGDg+bGPbu4w8wTMB6u7JRxWOTh37oR54ZKcpCGaO8Q2RIWvyXjUj/0PkIk8FpWA+yqK3UQuHwihZnsnbc2yrEf9XMuq4EPmqtHXdYHxUjm7Oa1b6KbEUP1fCzIE7Gu1zUyBAASqvd+NAtBd/n5H1JFGrR8JE4mG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da42114485so395339339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714273404; x=1714878204;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNr8BmD8SlNSCQ3i2htAE1RUyCUOUOAfIvb44k9epz0=;
        b=D0PkLWMnaoSRzAfOK9qQwGda9Pc7aMqqRXIDOSdjun/mBOZmcZwQ3eYiGFbtLkxbEP
         vT5v2NUccZjN1ZrH79b9krfHmxk+26TVk8f3ZcqLq7stVcGDspIlw4Wie93E3HDNKHHO
         zsMcAU5cWJ/U3BsksF9uuyKiRLMqHIeOeSY01gOXQOo1op7jKkw5WjVSlui07wcNosWV
         ib7LYFBCSOMaqIHyCGrF1vNk7p9VjoPAyDAHmU/Yv9mnXrNLw81GULcJxO3s68WtWM/I
         1Xz25pwjQAC5oiKDjQHPtOW3JZq8IvUSp82h/SsecioQ1i0uPVa8SZU28mrHoDmiOzLq
         5h5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0JMU55nlbZYFqb6GR2uq4ALiJM4mZfCcAs26g+IcHyzkUm2hPRBdtkV21kipC1JmjAP8rz534Vl1VQILg7Ifd5zfGYX4P9ysGheYW
X-Gm-Message-State: AOJu0YyXxRUz/NIahiBaruphMEEyDCj+87XUtVkmfcRl874DuoDjeYhG
	nGOwz9RAVKeDhDwRL9lpIspLTu+kGvFzVDajBtTmwwEjNNSBPwhawPkz/tBXAzcZMweV5aMYEhw
	0r81mGjK248Oh56GedBzizTqzjnOpoyp5jkCvUOpq8CVaIarYYYK7BWQ=
X-Google-Smtp-Source: AGHT+IERLI03EDun2PGW42T5v1uJRPATSNhQOfM1C4M7k4lnclB05o6FMa3pFJfsS9BcFQGbAf1iEvsOG+PGVsIkTyjTlIbST/Rz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:450b:b0:487:4ac1:3c77 with SMTP id
 bs11-20020a056638450b00b004874ac13c77mr474466jab.1.1714273404396; Sat, 27 Apr
 2024 20:03:24 -0700 (PDT)
Date: Sat, 27 Apr 2024 20:03:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051348606171f61a1@google.com>
Subject: [syzbot] [kernel?] possible deadlock in __change_pid
From: syzbot <syzbot+e7d7533fd9113a64a564@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d1ddab261f3 Merge tag '6.9-rc5-smb-client-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cc40d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=e7d7533fd9113a64a564
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24066cfb82f5/disk-9d1ddab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa4650a1c17d/vmlinux-9d1ddab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb19a356e69f/bzImage-9d1ddab2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7d7533fd9113a64a564@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0 Not tainted
------------------------------------------------------
syz-executor.0/12118 is trying to acquire lock:
ffff8880b953d998 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x39e/0x1020 kernel/workqueue.c:2360

but task is already holding lock:
ffff88805e1e16d8 (&pid->wait_pidfd){....}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:105 [inline]
ffff88805e1e16d8 (&pid->wait_pidfd){....}-{2:2}, at: __wake_up+0x1c/0x60 kernel/sched/wait.c:127

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&pid->wait_pidfd){....}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock kernel/sched/wait.c:105 [inline]
       __wake_up+0x1c/0x60 kernel/sched/wait.c:127
       __change_pid+0x199/0x5a0 kernel/pid.c:360
       __unhash_process kernel/exit.c:130 [inline]
       __exit_signal kernel/exit.c:202 [inline]
       release_task+0xb96/0x1b10 kernel/exit.c:259
       exit_notify kernel/exit.c:774 [inline]
       do_exit+0x1680/0x2c10 kernel/exit.c:898
       call_usermodehelper_exec_async+0x379/0x4c0 kernel/umh.c:123
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&____s->seqcount#5){....}-{0:0}:
       seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
       read_seqbegin include/linux/seqlock.h:772 [inline]
       read_seqbegin_or_lock_irqsave include/linux/seqlock.h:1133 [inline]
       thread_group_cputime+0x164/0x820 kernel/sched/cputime.c:336
       thread_group_start_cputime kernel/time/posix-cpu-timers.c:311 [inline]
       cpu_clock_sample_group+0x44b/0x800 kernel/time/posix-cpu-timers.c:348
       set_process_cpu_timer kernel/time/posix-cpu-timers.c:1470 [inline]
       update_rlimit_cpu+0xc4/0x1b0 kernel/time/posix-cpu-timers.c:49
       do_prlimit+0x3d1/0x6d0 kernel/sys.c:1512
       __do_sys_prlimit64+0x4be/0xb60 kernel/sys.c:1718
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sighand->siglock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __lock_task_sighand+0xc2/0x340 kernel/signal.c:1414
       lock_task_sighand include/linux/sched/signal.h:746 [inline]
       do_send_sig_info kernel/signal.c:1300 [inline]
       group_send_sig_info+0x290/0x300 kernel/signal.c:1453
       bpf_send_signal_common+0x2e8/0x3a0 kernel/trace/bpf_trace.c:881
       ____bpf_send_signal_thread kernel/trace/bpf_trace.c:898 [inline]
       bpf_send_signal_thread+0x16/0x20 kernel/trace/bpf_trace.c:896
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
       __bpf_trace_mmap_lock_acquire_returned+0x134/0x180 include/trace/events/mmap_lock.h:52
       trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
       __mmap_lock_do_trace_acquire_returned+0x456/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       get_mmap_lock_carefully mm/memory.c:5633 [inline]
       lock_mm_and_find_vma+0xeb/0x580 mm/memory.c:5693
       do_user_addr_fault+0x29c/0x1080 arch/x86/mm/fault.c:1385
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #1 (lock#12){+.+.}-{2:2}:
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0x97/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       stack_map_get_build_id_offset+0x5df/0x7d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x6bf/0x700 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
       bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1975
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run3+0x167/0x440 kernel/trace/bpf_trace.c:2421
       __bpf_trace_workqueue_queue_work+0x101/0x140 include/trace/events/workqueue.h:23
       trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inline]
       __queue_work+0x627/0x1020 kernel/workqueue.c:2382
       queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
       bpf_prog_load+0x19bb/0x2660 kernel/bpf/syscall.c:2944
       __sys_bpf+0x9b4/0x4b40 kernel/bpf/syscall.c:5660
       __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
       __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x39e/0x1020 kernel/workqueue.c:2360
       queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
       queue_work include/linux/workqueue.h:605 [inline]
       schedule_work include/linux/workqueue.h:666 [inline]
       p9_pollwake+0xc1/0x1d0 net/9p/trans_fd.c:538
       __wake_up_common+0x131/0x1e0 kernel/sched/wait.c:89
       __wake_up_common_lock kernel/sched/wait.c:106 [inline]
       __wake_up+0x31/0x60 kernel/sched/wait.c:127
       exit_notify kernel/exit.c:747 [inline]
       do_exit+0x1448/0x2c10 kernel/exit.c:898
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
       __do_sys_exit_group kernel/exit.c:1038 [inline]
       __se_sys_exit_group kernel/exit.c:1036 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &____s->seqcount#5 --> &pid->wait_pidfd

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pid->wait_pidfd);
                               lock(&____s->seqcount#5);
                               lock(&pid->wait_pidfd);
  lock(&pool->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.0/12118:
 #0: ffffffff8d40a098 (tasklist_lock){.+.+}-{2:2}, at: exit_notify kernel/exit.c:735 [inline]
 #0: ffffffff8d40a098 (tasklist_lock){.+.+}-{2:2}, at: do_exit+0xac2/0x2c10 kernel/exit.c:898
 #1: ffff88805e1e16d8 (&pid->wait_pidfd){....}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:105 [inline]
 #1: ffff88805e1e16d8 (&pid->wait_pidfd){....}-{2:2}, at: __wake_up+0x1c/0x60 kernel/sched/wait.c:127
 #2: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xf2/0x1020 kernel/workqueue.c:2324

stack backtrace:
CPU: 1 PID: 12118 Comm: syz-executor.0 Not tainted 6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x39e/0x1020 kernel/workqueue.c:2360
 queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
 queue_work include/linux/workqueue.h:605 [inline]
 schedule_work include/linux/workqueue.h:666 [inline]
 p9_pollwake+0xc1/0x1d0 net/9p/trans_fd.c:538
 __wake_up_common+0x131/0x1e0 kernel/sched/wait.c:89
 __wake_up_common_lock kernel/sched/wait.c:106 [inline]
 __wake_up+0x31/0x60 kernel/sched/wait.c:127
 exit_notify kernel/exit.c:747 [inline]
 do_exit+0x1448/0x2c10 kernel/exit.c:898
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efff107dea9
Code: Unable to access opcode bytes at 0x7efff107de7f.
RSP: 002b:00007ffd878c11c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007efff107dea9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000419 R09: 0000000000000000
R10: 0000001b33920000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

