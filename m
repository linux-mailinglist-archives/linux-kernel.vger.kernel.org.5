Return-Path: <linux-kernel+bounces-46124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30243843AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30B91F2B01D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04169D13;
	Wed, 31 Jan 2024 09:18:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA869D09
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692687; cv=none; b=J4U1j0HW3G8EbKa/Wqt7JmJvgI/y9qF9k4aXePsvCxfNkw8vg+WNkS1cb4hAmDdLS8A/bHtRFaEWzsKGER5nOWGSHZR/uX+zuPIRdsp5YZpYUPsZJhqXmO4N/y/ME53yTJtGMXpsH/nlS+p//eYDRD0sll++xvF6BRclaM1ZIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692687; c=relaxed/simple;
	bh=JlRIUUaFiSTz2KMD2p3Gzm0qVfI+zBn88cFNi0c4+zE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KJCwHYnHzBQV17OWynSa4pT605Gv8k49t965LGtL48aNPrjugi/UDNSP/wBJYD9S5482gKJkDLjE27cn7t2QqfhK3Iuqj9l+B7ET1RVXHjVspcAObmfbsOsEnm7bsKrwJW0OpG7hBcfggUFHEpNxtLryYats2831BnAA+NQqaG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363930ba977so10939465ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692684; x=1707297484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq0H4o4P1WbOL5vGEXPpe6xpAZKT6MdAwE5/Gsu5Eq4=;
        b=U0jy+HHUjF4oRCHme3L8lY/nqpcIdAUGY/tWzKH9hSqamDCAShcKLF/8r92FtJiIMv
         XvuZ3kf8ptS3a93p7MdhYe20+AkeMkw7Bgj8TgUCvuEGCOK5U+/uU2lPMPmTAStCVHVN
         2K4XaJjEmjJ3OmYSWL50767BWQLtp9o0F4vKMY/ruhHKwSbRICTtUAk0PDxi+pIGST3U
         a+1020v0aATeRnSFLzHfLGpvTgzohz3mPD25nRY+kBi8X8K4e/BZmuQ1GSCyikIASwDO
         dUvZfmFbuY1LGeeEUx7bMGdUyMwjlYeJyHK1W/rmbJkuwEViStFwz5omahAVTumSP1ko
         ezqQ==
X-Gm-Message-State: AOJu0Yzcq6+Oc2OTh4Y/sCtvl2k4qZ2eScA0AUA8amCUhcSztFwTj/In
	X9fi2ZdqbikzFTvgcX8EED72TwRnox/SxS0K/+MGRNzIMwCAcprKDMrW9QpPhQHTwFAfD7WevZx
	C/j3BwIQO0DcWn5jf2Q4yzrLewIrIKWwOJRluyikOSwdwEo6qn/XXT7U=
X-Google-Smtp-Source: AGHT+IHqO7nCoTkBdk8xkrdek2MmgoJp8E615Qf4wQ6Kd2nQ+REwF7nAImMtzqHdAusmTBX6wZ7lyCPj9AeQZQb701CQDwgguWrQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:35f:c187:ea04 with SMTP id
 j15-20020a056e02154f00b0035fc187ea04mr114272ilu.3.1706692683972; Wed, 31 Jan
 2024 01:18:03 -0800 (PST)
Date: Wed, 31 Jan 2024 01:18:03 -0800
In-Reply-To: <tencent_248437564B1275D376C967E03D4336389609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b4ac906103a5bba@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_setup

INFO: task syz-executor.4:5637 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27776 pid:5637  tgid:5635  ppid:5428   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f92fce7cda9
RSP: 002b:00007f92fdcc30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92fcfabf80 RCX: 00007f92fce7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f92fcec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f92fcfabf80 R15: 00007ffd5e0ef4b8
 </TASK>
INFO: task syz-executor.4:5639 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28480 pid:5639  tgid:5635  ppid:5428   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f92fce7cda9
RSP: 002b:00007f92fdca20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92fcfac050 RCX: 00007f92fce7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f92fcec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f92fcfac050 R15: 00007ffd5e0ef4b8
 </TASK>
INFO: task syz-executor.2:5650 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27776 pid:5650  tgid:5649  ppid:5430   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f63a947cda9
RSP: 002b:00007f63aa2680c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f63a95abf80 RCX: 00007f63a947cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f63a94c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f63a95abf80 R15: 00007ffeba8b3558
 </TASK>
INFO: task syz-executor.2:5651 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:29536 pid:5651  tgid:5649  ppid:5430   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f63a947cda9
RSP: 002b:00007f63aa2470c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f63a95ac050 RCX: 00007f63a947cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f63a94c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f63a95ac050 R15: 00007ffeba8b3558
 </TASK>
INFO: task syz-executor.0:5660 blocked for more than 146 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27776 pid:5660  tgid:5658  ppid:5431   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f574aa7cda9
RSP: 002b:00007f574b8b00c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f574ababf80 RCX: 00007f574aa7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f574aac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f574ababf80 R15: 00007ffd7a97ed28
 </TASK>
INFO: task syz-executor.0:5661 blocked for more than 147 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29536 pid:5661  tgid:5658  ppid:5431   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f574aa7cda9
RSP: 002b:00007f574b88f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f574abac050 RCX: 00007f574aa7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f574aac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f574abac050 R15: 00007ffd7a97ed28
 </TASK>
INFO: task syz-executor.5:5666 blocked for more than 147 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:27776 pid:5666  tgid:5664  ppid:5427   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6b7be7cda9
RSP: 002b:00007f6b7cbf80c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6b7bfabf80 RCX: 00007f6b7be7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f6b7bec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6b7bfabf80 R15: 00007ffc5bbb9978
 </TASK>
INFO: task syz-executor.5:5668 blocked for more than 148 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:29536 pid:5668  tgid:5664  ppid:5427   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6b7be7cda9
RSP: 002b:00007f6b7cbd70c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6b7bfac050 RCX: 00007f6b7be7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f6b7bec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f6b7bfac050 R15: 00007ffc5bbb9978
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
 #0: ffff88802887ad38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900000d7d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
3 locks held by kworker/u4:1/12:
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by kworker/0:2/781:
 #0: ffff88801308a938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003e9fd80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
2 locks held by getty/4820:
 #0: ffff88802911a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
5 locks held by kworker/u5:2/5064:
 #0: ffff88807df2ed38 ((wq_completion)hci7){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003ccfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff8881ef9d5060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff8881ef9d4078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
3 locks held by kworker/1:5/5076:
 #0: ffff88802887ad38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003d5fd80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
2 locks held by kworker/0:4/5077:
5 locks held by kworker/u5:4/5435:
 #0: ffff888020c70d38 ((wq_completion)hci6){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900049a7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff8881ed859060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff8881ed858078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
5 locks held by kworker/u5:7/5441:
 #0: ffff88807fa3cd38 ((wq_completion)hci9){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90004a87d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff8881f4771060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff8881f4770078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #4: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
1 lock held by syz-executor.3/5626:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_cleanup kernel/trace/blktrace.c:406 [inline]
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: __blk_trace_remove+0x109/0x250 kernel/trace/blktrace.c:418
3 locks held by syz-executor.1/5633:
1 lock held by syz-executor.4/5637:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/5639:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/5650:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/5651:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/5660:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/5661:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/5666:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/5668:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/5969:
 #0: ffff88801f2e3b40
 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/5970:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.1/5973:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/5975:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/5986:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/5988:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/5998:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/5999:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/6001:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/6002:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/6004:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/6005:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/6075:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/6076:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.1/6099:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/6100:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/6115:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/6116:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/6119:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/6120:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/6122:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/6123:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/6125:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/6126:
 #0: ffff88801f2e3b40 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
3 locks held by syz-executor.3/6128:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
 #1: ffff88802ac793e8 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_open+0x203/0x4e0 drivers/net/wireguard/device.c:50
 #2: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #2: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
7 locks held by syz-executor.1/6139:
 #0: ffff888028d7c420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12f/0x250 fs/read_write.c:643
 #1: ffff888036f8e088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27d/0x500 fs/kernfs/file.c:325
 #2: ffff88802169b6d0 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a0/0x500 fs/kernfs/file.c:326
 #3: ffffffff8e356208 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: ffff88806895e0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #4: ffff88806895e0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88806895e0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffff888068958250 (&devlink->lock_key#15){+.+.}-{3:3}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x39/0x1c0 drivers/net/netdevsim/netdev.c:417
2 locks held by syz-executor.0/6152:
 #0: ffffffff8ecacf50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x2cc/0x660 net/core/net_namespace.c:491
 #1: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: register_netdev+0x13/0x50 net/core/dev.c:10391
2 locks held by syz-executor.4/6158:
 #0: ffffffff8ecacf50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x2cc/0x660 net/core/net_namespace.c:491
 #1: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x225/0x5e0 net/ipv4/ip_tunnel.c:1090
2 locks held by syz-executor.2/6161:
 #0: ffffffff8ecacf50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x2cc/0x660 net/core/net_namespace.c:491
 #1: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x225/0x5e0 net/ipv4/ip_tunnel.c:1090
2 locks held by syz-executor.5/6164:
 #0: ffffffff8ecacf50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x2cc/0x660 net/core/net_namespace.c:491
 #1: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x225/0x5e0 net/ipv4/ip_tunnel.c:1090

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5490 Comm: kworker/0:5 Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:stack_access_ok+0x2/0x270 arch/x86/kernel/unwind_orc.c:389
Code: 89 85 30 ff ff ff e8 cd b9 a5 00 48 8b 95 18 ff ff ff 48 8b 8d 28 ff ff ff 44 8b 85 30 ff ff ff e9 6f fe ff ff 0f 1f 00 41 57 <41> 56 41 55 41 54 55 48 89 f5 53 48 89 fb 4c 8d 63 08 48 83 ec 10
RSP: 0018:ffffc90004e876f8 EFLAGS: 00000097
RAX: 0000000000000000 RBX: ffffc90004e87788 RCX: 0000000000000001
RDX: 0000000000000008 RSI: ffffc90004e87ac0 RDI: ffffc90004e87788
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000004 R12: ffffc90004e87ac0
R13: ffffc90004e87ad8 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5266cd5000 CR3: 000000002147d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 deref_stack_reg arch/x86/kernel/unwind_orc.c:403 [inline]
 unwind_next_frame+0x1a98/0x2390 arch/x86/kernel/unwind_orc.c:648
 arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0x100 mm/kasan/generic.c:586
 insert_work+0x38/0x230 kernel/workqueue.c:1653
 __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
 __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
 queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1989
 queue_delayed_work include/linux/workqueue.h:563 [inline]
 schedule_delayed_work include/linux/workqueue.h:677 [inline]
 nsim_dev_trap_report_work+0x9c0/0xc80 drivers/net/netdevsim/dev.c:842
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1041cb97e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10419e1fe80000


