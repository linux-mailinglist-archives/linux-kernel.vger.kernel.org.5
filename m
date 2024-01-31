Return-Path: <linux-kernel+bounces-46197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0478843C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3FD28C058
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B86997B;
	Wed, 31 Jan 2024 10:17:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706E6996F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696227; cv=none; b=n2I3aTJcXFhyG4SLke0R0ZmLOY3BDi9J95ISXerlJjt4rouxPlyd2ySTy7w0xbgoUNCWqk8Vb+coM8DwkfFw0NqencrI2hWgM+n7a09Hf23pBGAySNXpQXxylHsUMT9i4l5BaqplUIxkSWYGAemjQ6dDFtAybd1im9Mo7CRexe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696227; c=relaxed/simple;
	bh=fYXU+vaxY4MYAKi1jimq2JPsXykhFs4MRBOSGlCROYQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VqKZRKirxQtUH7090zAjXj8vTZHbwBmWZyMqBlumC95mF7Fg3j8ucDJRzMVWZ+wj9k9z1/Qv6tSEF5YD1Xl8yw45DW9HD+tSREB9eSvouYFyNfVeOBK+o13ACpL5pbNx9zSx0H/KZfhb2rUh4E14WxI/c3taKcz8XXugVatD8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so345940139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696224; x=1707301024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB5Tqhzy9DVW1NVra4xMj63nNk3l6X7TSo3FcDDbykk=;
        b=gnaCI/EbHdSm7FMn7lKQXDwavrF+XCs7uaPg0SlhV1aAVo4VWM8s5GGu5kVRxTGc3P
         DfFVzgdYLMJ4joiMNVxAXTvgbX6Q4SAu3kUz+baUrcYqAiWNYnvDP9CORTLmC/5a3O+x
         u41jcZh4Dy8gfnLr59KCtocp6TalBjEZSlpKyFEnuVfPyl6IU5aFn1ZcM4cezw/bPhgd
         rNJQRVDhVgtFWICKIiTcIngTB5grxHgMFTOCUtooSaFsWpZz948bjGMbX5dQd+4Nk/3R
         V5kVV+fjoiZAAaYauMFHdXZH3sEn5B6Bg4HMLG2LU/JQ5bojCbTnCLRSSd9G4jNhY+y1
         1B6A==
X-Gm-Message-State: AOJu0YxjQZKZtVn5FLRf00FUYpMMMQJGoewjDfaO6eYEP6ScK+C5UX1U
	77HWIzMUVEPbpn58XR0MhMJ+/QmObCJe3I4LOnTpjOa9GZQGAZ4kvkjzAXYimimWnb8wPrkw6I1
	jxiMvPXfj97OJZyrrn6gCrIVqpUduu90GY48bNQWOCC4ERKct1fCOYi4=
X-Google-Smtp-Source: AGHT+IGXI6zbj6Z72yOwEQtK0/IbTKjL1JGbNEo+o9rHlmPsLuKaMRz89O4GZ5t1r33aYN08EuePeLO1hRWwtuWfmKXCIJQNoVSA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:363:7b21:c860 with SMTP id
 a12-20020a92c54c000000b003637b21c860mr101014ilj.4.1706696224608; Wed, 31 Jan
 2024 02:17:04 -0800 (PST)
Date: Wed, 31 Jan 2024 02:17:04 -0800
In-Reply-To: <tencent_48D4BAEFBB2133B89EC81B974B4A1B242508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000351a3606103b2eae@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_setup

INFO: task syz-executor.4:5645 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27776 pid:5645  tgid:5644  ppid:5439   flags:0x00000006
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
RIP: 0033:0x7f142fa7cda9
RSP: 002b:00007f142f5ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f142fbabf80 RCX: 00007f142fa7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f142fac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f142fbabf80 R15: 00007ffe08407bc8
 </TASK>
INFO: task syz-executor.4:5647 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28384 pid:5647  tgid:5644  ppid:5439   flags:0x00000006
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
RIP: 0033:0x7f142fa7cda9
RSP: 002b:00007f142f5de0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f142fbac050 RCX: 00007f142fa7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f142fac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f142fbac050 R15: 00007ffe08407bc8
 </TASK>
INFO: task syz-executor.0:5655 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27776 pid:5655  tgid:5654  ppid:5433   flags:0x00000006
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
RIP: 0033:0x7f6155a7cda9
RSP: 002b:00007f615670b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6155babf80 RCX: 00007f6155a7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f6155ac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6155babf80 R15: 00007ffcf00f40b8
 </TASK>
INFO: task syz-executor.0:5656 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29536 pid:5656  tgid:5654  ppid:5433   flags:0x00000006
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
RIP: 0033:0x7f6155a7cda9
RSP: 002b:00007f61555ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6155bac050 RCX: 00007f6155a7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f6155ac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f6155bac050 R15: 00007ffcf00f40b8
 </TASK>
INFO: task syz-executor.3:5675 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:27776 pid:5675  tgid:5674  ppid:5431   flags:0x00000006
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
RIP: 0033:0x7ff9d207cda9
RSP: 002b:00007ff9d2d8d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff9d21abf80 RCX: 00007ff9d207cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007ff9d20c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff9d21abf80 R15: 00007ffce595a448
 </TASK>
INFO: task syz-executor.3:5678 blocked for more than 146 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:29536 pid:5678  tgid:5674  ppid:5431   flags:0x00000006
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
RIP: 0033:0x7ff9d207cda9
RSP: 002b:00007ff9d2d6c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff9d21ac050 RCX: 00007ff9d207cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007ff9d20c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007ff9d21ac050 R15: 00007ffce595a448
 </TASK>
INFO: task syz-executor.5:5682 blocked for more than 146 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:27776 pid:5682  tgid:5681  ppid:5441   flags:0x00000006
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
RIP: 0033:0x7f489387cda9
RSP: 002b:00007f48945760c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f48939abf80 RCX: 00007f489387cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f48938c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f48939abf80 R15: 00007fff7affaad8
 </TASK>
INFO: task syz-executor.5:5684 blocked for more than 147 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:29536 pid:5684  tgid:5681  ppid:5441   flags:0x00000006
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
RIP: 0033:0x7f489387cda9
RSP: 002b:00007f48945550c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f48939ac050 RCX: 00007f489387cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f48938c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f48939ac050 R15: 00007fff7affaad8
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u4:0/11:
3 locks held by kworker/1:1/27:
 #0: ffff888013088d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90000a2fd80 ((work_completion)(&(&devlink->rwork)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #2: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
3 locks held by kworker/1:2/781:
 #0: ffff8880293f9138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003b17d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
2 locks held by getty/4820:
 #0: ffff88802daca0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002efe2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
5 locks held by kworker/u5:2/5069:
 #0: ffff88806d9d5d38 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003a77d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888067ff5060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888067ff4078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
3 locks held by kworker/1:4/5080:
 #0: ffff888013088d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003b37d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:281
2 locks held by kworker/1:5/5081:
2 locks held by kworker/1:6/5082:
 #0: ffff88801308a938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003b57d80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
4 locks held by kworker/u5:3/5435:
 #0: ffff88802083c538 ((wq_completion)hci9){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90004d1fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888204551060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888204550078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
6 locks held by kworker/u5:4/5438:
 #0: ffff88820592c538 ((wq_completion)hci10){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90004d5fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888205929060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888205928078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
3 locks held by kworker/0:6/5519:
 #0: ffff8880293f9138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900054b7d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
3 locks held by syz-executor.1/5639:
1 lock held by syz-executor.4/5645:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/5647:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/5655:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/5656:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/5675:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/5678:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/5682:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/5684:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/5960:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/5961:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.1/5987:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/5988:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/5996:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/5998:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/6004:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/6005:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/6007:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/6008:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/6011:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/6012:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/6031:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/6032:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.1/6101:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/6102:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/6110:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/6111:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/6116:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/6117:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/6122:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/6123:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/6131:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/6132:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/6150:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/6151:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/6165:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
7 locks held by syz-executor.0/6175:
 #0: ffff888029680420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12f/0x250 fs/read_write.c:643
 #1: ffff8881b7959888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27d/0x500 fs/kernfs/file.c:325
 #2: ffff88802036fe90 (kn->active#51){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a0/0x500 fs/kernfs/file.c:326
 #3: ffffffff8e356208 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x183/0x730 drivers/net/netdevsim/bus.c:166
 #4: ffff88806de8b0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #4: ffff88806de8b0e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffff88808c6d7250 (&devlink->lock_key#23){+.+.}-{3:3}, at: nsim_drv_probe+0xd5/0x1490 drivers/net/netdevsim/dev.c:1534
 #6: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: fib_seq_sum+0x30/0x2e0 net/core/fib_notifier.c:46
4 locks held by syz-executor.3/6180:
 #0: ffff888029680420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12f/0x250 fs/read_write.c:643
 #1: ffff888092264c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27d/0x500 fs/kernfs/file.c:325
 #2: ffff88802036c008 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a0/0x500 fs/kernfs/file.c:326
 #3: ffffffff8e356208 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
1 lock held by syz-executor.5/6194:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.2/6203:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.1/6207:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/6208:
 #0: ffff88801f454c60 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427

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
CPU: 0 PID: 5645 Comm: syz-executor.4 Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:rcu_lockdep_current_cpu_online+0x24/0x140 kernel/rcu/tree.c:4269
Code: 00 00 00 0f 1f 00 f3 0f 1e fa 65 8b 15 0d 4a 93 7e 81 e2 00 00 f0 00 b8 01 00 00 00 75 0a 8b 15 66 88 ca 0d 85 d2 75 01 c3 55 <53> 65 ff 05 ec 49 93 7e e8 ef 00 1e 09 48 c7 c3 c0 db 03 00 83 f8
RSP: 0018:ffffc900055a75b0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 000000000005637c RCX: ffffffff81ea9084
RDX: 0000000000000001 RSI: ffffffff8b2fdb80 RDI: ffffffff8ca99a60
RBP: ffff88813fff9140 R08: 0000000000000007 R09: 000000000007ffff
R10: 000000000000000a R11: 0000000000000002 R12: ffff888014300000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f142f5ff6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea2813f98 CR3: 000000005b0c1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_read_lock_held_common kernel/rcu/update.c:113 [inline]
 rcu_read_lock_held+0x23/0x40 kernel/rcu/update.c:349
 lookup_page_ext mm/page_ext.c:240 [inline]
 page_ext_get+0x132/0x310 mm/page_ext.c:509
 __set_page_owner+0x2a/0x60 mm/page_owner.c:197
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 relay_alloc_buf kernel/relay.c:121 [inline]
 relay_create_buf kernel/relay.c:162 [inline]
 relay_open_buf.part.0+0x27d/0xba0 kernel/relay.c:384
 relay_open_buf kernel/relay.c:536 [inline]
 relay_open+0x641/0xab0 kernel/relay.c:517
 do_blk_trace_setup+0x4ad/0xc80 kernel/trace/blktrace.c:612
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:652
 blk_trace_setup+0x47/0x60 kernel/trace/blktrace.c:670
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f142fa7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f142f5ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f142fbabf80 RCX: 00007f142fa7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f142fac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f142fbabf80 R15: 00007ffe08407bc8
 </TASK>


Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=106b00afe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d4f940180000


