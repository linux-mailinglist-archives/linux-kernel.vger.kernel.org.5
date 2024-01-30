Return-Path: <linux-kernel+bounces-44897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565618428AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB3F1C25FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B382D93;
	Tue, 30 Jan 2024 16:03:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE786AEB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630587; cv=none; b=usijF7mF8jp3e0L2awuflpZttpwxagKjCy98rqX7dfLMTHBhsspbypjqrFQC4TZb7tW6cxuhr5Vmr7g+6cUHNyt0a51rKhSLtmDkhtSj8stRULC6iOBTVr+LA9vwFoGcOmzqq5aOd27dU2AYiO8S0ZzeduS6g+zXNY8ni2iRQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630587; c=relaxed/simple;
	bh=avby7nCDpL1C/rCDU9NnOvoYqDV5ui9SzsxkCMg/yzA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e8bwgyBr/5E835HZYVyF0gE3Bxu+z5KhY8+aFFEFVLnzug9SC05dWCj8V7QJtLzB8KRQEvl8zUmdwhzroTyaFaVkWQOqAA9Yyrfzk73YY9zuG0AHFb2m3pMjypYzRrD2U5qh3+hXINRO//R3GxkjEUX6SVTYSktS2uTOPa6wxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc6976630so26232165ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630584; x=1707235384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3Tq/fVAuyXThv1r/542mNzWM71O2DAdAgXn/fYRAU0=;
        b=klXQXieOcDVq7ysX7jWv3Rxmhb9Uymx8xPr1LYmuozDxobsOkA932jm+3civpiMbEA
         CnDnvK3HSxKseHkl2/paPkUoCKs1XUyupiRHI5R87nkPuLoJNRQuUOX461DitcD9o8HA
         iagHgIKZo+dS8Tjm3+otkdUpySnDyxC/SUpq7cA6AYltYfmxXMz5FSo2pOtrdaFI2XeB
         r47iUFQU6b4E+CVL7YGe+9Tgj8v81+Fs/UwEeLIYr9KmU2K5Ov58+ReHnPNsj5dc/Mps
         +M9pTDV5QKXw4XIUGQipzvMGVMULJlAREg0y+H8lvyUqpQVK0PY5ydWLXHhDXTCNAUh3
         ZgZw==
X-Gm-Message-State: AOJu0YxxXi8iT7f0ttroCg4d9O4zCk7K8JRk7qQR+70PmxnVPCMrdjHc
	ReTyzAqLP9eJ5YP1cAK7urxUuhNTvE50fDFicTLCi5CPnrbGElU+BH2tm6PRerrWifcdiUZkkEp
	wpZ/CaiAlqL46Sj2nm+BWlc8BEKpoQuz4D0Z/IuLsDq8obD6fd0+XNbA=
X-Google-Smtp-Source: AGHT+IEUt0e/uKLOd6N7pew3MM57ClvUSYLTOfvbo4K6X1WqtqQau6CyETpKpn5cM2GfJQxX14dErlujcmQYdU2FRmaYZNXfUJ6h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1524:b0:363:8b04:6e01 with SMTP id
 i4-20020a056e02152400b003638b046e01mr262431ilu.3.1706630584369; Tue, 30 Jan
 2024 08:03:04 -0800 (PST)
Date: Tue, 30 Jan 2024 08:03:04 -0800
In-Reply-To: <tencent_74C670C985EED9EEF68C8927DA06EDD2DD06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be8c1906102be5fe@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_setup

INFO: task syz-executor.4:5650 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27776 pid:5650  tgid:5649  ppid:5434   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f406fc7cda9
RSP: 002b:00007f4070a040c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f406fdabf80 RCX: 00007f406fc7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f406fcc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f406fdabf80 R15: 00007ffc9ad00358
 </TASK>
INFO: task syz-executor.4:5651 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:28480 pid:5651  tgid:5649  ppid:5434   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f406fc7cda9
RSP: 002b:00007f40709e30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f406fdac050 RCX: 00007f406fc7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f406fcc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f406fdac050 R15: 00007ffc9ad00358
 </TASK>
INFO: task syz-executor.1:5653 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:27776 pid:5653  tgid:5652  ppid:5428   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f76ba07cda9
RSP: 002b:00007f76baed70c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f76ba1abf80 RCX: 00007f76ba07cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f76ba0c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f76ba1abf80 R15: 00007fffb67c90d8
 </TASK>
INFO: task syz-executor.1:5655 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:29536 pid:5655  tgid:5652  ppid:5428   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f76ba07cda9
RSP: 002b:00007f76baeb60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f76ba1ac050 RCX: 00007f76ba07cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f76ba0c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f76ba1ac050 R15: 00007fffb67c90d8
 </TASK>
INFO: task syz-executor.2:5662 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:27776 pid:5662  tgid:5660  ppid:5443   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7efebe87cda9
RSP: 002b:00007efebf5ca0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007efebe9abf80 RCX: 00007efebe87cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007efebe8c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efebe9abf80 R15: 00007ffd09f13438
 </TASK>
INFO: task syz-executor.2:5663 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:29536 pid:5663  tgid:5660  ppid:5443   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7efebe87cda9
RSP: 002b:00007efebf5a90c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007efebe9ac050 RCX: 00007efebe87cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007efebe8c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007efebe9ac050 R15: 00007ffd09f13438
 </TASK>
INFO: task syz-executor.0:5665 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27776 pid:5665  tgid:5664  ppid:5435   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f640727cda9
RSP: 002b:00007f640802c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f64073abf80 RCX: 00007f640727cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f64072c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f64073abf80 R15: 00007fff0e30aa68
 </TASK>
INFO: task syz-executor.0:5667 blocked for more than 146 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29536 pid:5667  tgid:5664  ppid:5435   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f640727cda9
RSP: 002b:00007f640800b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f64073ac050 RCX: 00007f640727cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f64072c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f64073ac050 R15: 00007fff0e30aa68
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by kworker/u4:2/38:
3 locks held by kworker/0:2/922:
 #0: ffff888029122d38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90004167d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
5 locks held by kworker/u5:1/4459:
 #0: ffff88802168a538 ((wq_completion)hci8){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc9000d8f7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff8882053c5060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff8882053c4078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #4: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
2 locks held by getty/4816:
 #0: ffff888029b910a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
2 locks held by kworker/0:5/5076:
 #0: ffff88801308a938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900042e7d80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
3 locks held by kworker/1:7/5518:
 #0: ffff888029122d38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900097a7d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
3 locks held by syz-executor.5/5642:
1 lock held by syz-executor.4/5650:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.4/5651:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.1/5653:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.1/5655:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.2/5662:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.2/5663:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.0/5665:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.0/5667:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.3/5951:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.3/5952:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.5/5979:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.5/5980:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.1/5983:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.1/5986:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.4/5993:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.4/5994:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.0/5997:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.0/5998:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.2/6000:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.2/6001:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.3/6019:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.3/6020:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.5/6093:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.5/6094:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.1/6105:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.1/6106:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.4/6109:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.4/6110:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.2/6120:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.2/6121:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.0/6127:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.0/6128:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.3/6138:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.3/6139:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.1/6165:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.4/6168:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.2/6184:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
2 locks held by syz-executor.0/6187:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
 #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
1 lock held by syz-executor.5/6191:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:647
1 lock held by syz-executor.5/6192:
 #0: ffff88801f9a1070 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:405
1 lock held by syz-executor.3/6199:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
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
CPU: 0 PID: 59 Comm: kworker/u4:4 Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:check_preemption_disabled+0x2/0xe0 lib/smp_processor_id.c:13
Code: ac 04 85 c0 74 1a 65 8b 05 b3 22 74 75 85 c0 75 0f 65 8b 05 bc 1f 74 75 85 c0 74 04 90 0f 0b 90 e9 83 fc ff ff 0f 1f 00 41 54 <55> 53 48 83 ec 08 65 8b 1d cd 59 75 75 65 8b 05 c2 59 75 75 a9 ff
RSP: 0018:ffffc900015a7a48 EFLAGS: 00000082
RAX: 0000000000000001 RBX: 1ffff920002b4f4d RCX: 00000000154dd6e4
RDX: 0000000000000001 RSI: ffffffff8accb300 RDI: ffffffff8b2fdc00
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff242afe8
R10: ffffffff92157f47 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8d1acbe0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ae8684eb68 CR3: 000000006b120000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
 lock_acquire kernel/locking/lockdep.c:5756 [inline]
 lock_acquire+0x1be/0x520 kernel/locking/lockdep.c:5719
 rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 rcu_read_lock include/linux/rcupdate.h:750 [inline]
 batadv_nc_process_nc_paths.part.0+0xe4/0x3e0 net/batman-adv/network-coding.c:687
 batadv_nc_process_nc_paths net/batman-adv/network-coding.c:679 [inline]
 batadv_nc_worker+0xded/0x10e0 net/batman-adv/network-coding.c:735
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=175259dfe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cf4860180000


