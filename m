Return-Path: <linux-kernel+bounces-46172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7843B843B91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E444B1F27680
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6F69977;
	Wed, 31 Jan 2024 10:00:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60869D05
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695209; cv=none; b=QbmT7Ag2WxF2MYr8XQ14FR6dOkkIf0Ee5Hy2iYN+Ax2s/bXuiPn+cPs4DgAjuxzXALa+4qU0FzGQt5oi4rmElPh1kfxkMDJOA7u8CA5Osio9HsITNyeeHEbjChNY5abhBAYjFTj22o5vpsgOwPIt8w2jftQ/GWcneJ5+v4KH9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695209; c=relaxed/simple;
	bh=nLiioAjPu/xHNd5QHtlaHdV/+5JRpcUNjZnd/lfoLGA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vAtGHOHOVuQ++G392N68xtLpTD+sxxSoiy8lGAqWsc5hR8R+Oxnl9K6Sq+puXFUOWT391G5zgNMUUhJ0ntAMtLTUTKVuWn34MHiTQW6vUNyrFVlWrEZxedUCEGPhp2fGnEVRHjFNnTC4wrxaQzOUW5Nf6g+9i6860Rrxr0+4spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36387e7abccso16368575ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706695206; x=1707300006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo4v/PvlS3JPu4myCBV8k0S3VIVJyAp9dhojxDzT+xE=;
        b=silGyG6x+pv/clH8WZkdwHUTeEEqOoAzocP1cXAYalar2UgCEzt3W8/NWc2GgRE1yU
         ru9whuz1HmuaG38KJ6UFpMn3tZ4dCFydxlK6uPnXB8HPq9DWEjXSXfSHMIJzokerHrHF
         MQuCd8ROomwhEiWN3/MkpWJ533xhHWKt09dxyUJAVrOugwaDrNDExEGzLlMAqhaHaGJy
         FM/1CPwg7GJ/0bIFf3zpWl5JBPXS4zkqI+uBbLxfzDnXpLelQZsYJWwHfpj9V1oQIrln
         M/dQ25CqwtPgps2ZD1EPzaKqV6fkh5zQg+vh1fobGWAimsiUBrN7hqsTDBI1viz3fqpr
         jwVA==
X-Gm-Message-State: AOJu0YzDrio220Ua/4828if2VHMgMmwuolEYAZ2GkkfjgWA3s7z5tF4J
	hUpcR0IWWDuVSHkXPMuJClA7vdVuuEb+tU9Q03N7S0nzdOVqvmQwYtnEUGjOds+lGi9UzgssDzr
	ocVWa4AnZhnViK8JXZFDaqm/Jhn5uC+o9Ht9Mo8OjYNoJn8weTAY0V6U=
X-Google-Smtp-Source: AGHT+IGRUTddubrLcdonsRycjpp0Amhohs49u5fN4HMfCAxeb6umUO52iztS+Fnx7qFyJ7BV8uBIQj9wtg0LLiInHvvSBA8cKW+a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:363:92e5:ab47 with SMTP id
 j15-20020a056e02218f00b0036392e5ab47mr107650ila.5.1706695205990; Wed, 31 Jan
 2024 02:00:05 -0800 (PST)
Date: Wed, 31 Jan 2024 02:00:05 -0800
In-Reply-To: <tencent_EBBB1833609E1E1BFE4B201B0B259BBA3308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e38ce06103af14f@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_setup

INFO: task syz-executor.1:5676 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:27776 pid:5676  tgid:5675  ppid:5434   flags:0x00000006
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
RIP: 0033:0x7faf0ce7cda9
RSP: 002b:00007faf0db790c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faf0cfabf80 RCX: 00007faf0ce7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007faf0cec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007faf0cfabf80 R15: 00007fff4f06f188
 </TASK>
INFO: task syz-executor.1:5679 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:29536 pid:5679  tgid:5675  ppid:5434   flags:0x00000006
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
RIP: 0033:0x7faf0ce7cda9
RSP: 002b:00007faf0db580c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007faf0cfac050 RCX: 00007faf0ce7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007faf0cec947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007faf0cfac050 R15: 00007fff4f06f188
 </TASK>
INFO: task syz-executor.3:5686 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:27776 pid:5686  tgid:5685  ppid:5428   flags:0x00000006
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
RIP: 0033:0x7f558c67cda9
RSP: 002b:00007f558d3d30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f558c7abf80 RCX: 00007f558c67cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f558c6c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f558c7abf80 R15: 00007fff93ec0c98
 </TASK>
INFO: task syz-executor.3:5687 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:29536 pid:5687  tgid:5685  ppid:5428   flags:0x00004006
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
RIP: 0033:0x7f558c67cda9
RSP: 002b:00007f558d3b20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f558c7ac050 RCX: 00007f558c67cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f558c6c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f558c7ac050 R15: 00007fff93ec0c98
 </TASK>
INFO: task syz-executor.5:5695 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26608 pid:5695  tgid:5692  ppid:5441   flags:0x00000006
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
RIP: 0033:0x7fda7f47cda9
RSP: 002b:00007fda800ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fda7f5abf80 RCX: 00007fda7f47cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007fda7f4c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fda7f5abf80 R15: 00007fff85183bd8
 </TASK>
INFO: task syz-executor.5:5696 blocked for more than 146 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:29536 pid:5696  tgid:5692  ppid:5441   flags:0x00000006
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
RIP: 0033:0x7fda7f47cda9
RSP: 002b:00007fda7efff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fda7f5ac050 RCX: 00007fda7f47cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007fda7f4c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fda7f5ac050 R15: 00007fff85183bd8
 </TASK>
INFO: task syz-executor.4:5701 blocked for more than 146 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:27616 pid:5701  tgid:5700  ppid:5438   flags:0x00000006
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
RIP: 0033:0x7f576747cda9
RSP: 002b:00007f57682830c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f57675abf80 RCX: 00007f576747cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f57674c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f57675abf80 R15: 00007fff90f5ca68
 </TASK>
INFO: task syz-executor.4:5703 blocked for more than 147 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:29536 pid:5703  tgid:5700  ppid:5438   flags:0x00004006
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
RIP: 0033:0x7f576747cda9
RSP: 002b:00007f57682620c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f57675ac050 RCX: 00007f576747cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f57674c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f57675ac050 R15: 00007fff90f5ca68
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/0:0/8:
3 locks held by kworker/1:0/23:
 #0: ffff888013088d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900001d7d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:281
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
3 locks held by kworker/u4:3/49:
2 locks held by kworker/1:2/924:
 #0: ffff88801308a938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90004eafd80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
2 locks held by getty/4814:
 #0: ffff8880298f20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
5 locks held by kworker/u5:2/5068:
 #0: ffff88801d20a538 ((wq_completion)hci7){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003c4fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff88807c465060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff88807c464078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
6 locks held by kworker/u5:3/5431:
 #0: ffff88802360cd38 ((wq_completion)hci8){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900055c7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff8882052a1060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff8882052a0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
5 locks held by kworker/u5:7/5439:
 #0: ffff888078793138 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90005707d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888205ca1060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888205ca0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
3 locks held by kworker/0:6/5528:
 #0: ffff88802917dd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90005cafd80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
3 locks held by kworker/0:7/5533:
 #0: ffff888013088d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90005cdfd80 (deferred_process_work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:75
1 lock held by syz-executor.0/5646:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_cleanup kernel/trace/blktrace.c:406 [inline]
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: __blk_trace_remove+0x109/0x250 kernel/trace/blktrace.c:418
3 locks held by syz-executor.2/5664:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
 #1: ffffffff8d22fa28 (blk_probe_mutex){+.+.}-{3:3}, at: put_probe_ref+0x14/0x1b0 kernel/trace/blktrace.c:353
 #2: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #2: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
1 lock held by syz-executor.1/5676:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/5679:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/5686:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/5687:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/5695:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/5696:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/5701:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/5703:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/5959:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/5960:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.1/5970:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/5972:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/5980:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/5981:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/5993:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/5994:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/5996:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/5997:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/5999:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/6000:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/6062:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/6063:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.1/6076:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/6077:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/6085:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.2/6087:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.3/6104:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.3/6106:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.5/6112:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.5/6113:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.4/6116:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.4/6117:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.0/6138:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.0/6139:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427
1 lock held by syz-executor.2/6152:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
7 locks held by syz-executor.3/6165:
 #0: ffff88802ecd0420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12f/0x250 fs/read_write.c:643
 #1: ffff8880ae4b7088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27d/0x500 fs/kernfs/file.c:325
 #2: ffff8880210a04e0 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a0/0x500 fs/kernfs/file.c:326
 #3: ffffffff8e356208 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: ffff88801eb6a0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #4: ffff88801eb6a0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88801eb6a0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffff888029be8250 (&devlink->lock_key#17){+.+.}-{3:3}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x39/0x1c0 drivers/net/netdevsim/netdev.c:417
1 lock held by syz-executor.5/6171:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.4/6177:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.1/6189:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:669
1 lock held by syz-executor.1/6190:
 #0: ffff88801f275d80 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:427

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6177 Comm: syz-executor.4 Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:rdtsc_ordered arch/x86/include/asm/msr.h:215 [inline]
RIP: 0010:delay_tsc+0x49/0xb0 arch/x86/lib/delay.c:72
Code: 0f 01 f9 66 90 48 c1 e2 20 48 09 c2 48 89 d5 eb 16 f3 90 bf 01 00 00 00 e8 84 40 d8 f6 e8 8f e0 0b 00 44 39 e0 75 36 0f 01 f9 <66> 90 48 c1 e2 20 48 89 d3 48 09 c3 48 89 d8 48 29 e8 4c 39 e8 73
RSP: 0018:ffffc9000381ec18 EFLAGS: 00000046
RAX: 000000009607868a RBX: 000000939607861e RCX: 0000000000000001
RDX: 0000000000000093 RSI: ffffffff8b2fdb80 RDI: ffffffff8b2fdbc0
RBP: 0000009396077df2 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000000026ea R11: 0000000000000004 R12: 0000000000000001
R13: 0000000000000899 R14: fffffbfff2597ce2 R15: dffffc0000000000
FS:  0000555555bc0480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fadbdbff78 CR3: 000000008ba57000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 wait_for_lsr+0x96/0x180 drivers/tty/serial/8250/8250_port.c:2087
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3366 [inline]
 serial8250_console_write+0xc79/0x1060 drivers/tty/serial/8250/8250_port.c:3444
 console_emit_next_record kernel/printk/printk.c:2901 [inline]
 console_flush_all+0x4d8/0xd60 kernel/printk/printk.c:2967
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 __netdev_printk+0x33c/0x4b0 net/core/dev.c:11489
 netdev_info+0xe5/0x120 net/core/dev.c:11536
 __dev_set_promiscuity+0x177/0x590 net/core/dev.c:8439
 dev_set_promiscuity+0x52/0x150 net/core/dev.c:8477
 br_port_set_promisc net/bridge/br_if.c:108 [inline]
 br_manage_promisc+0x2cf/0x500 net/bridge/br_if.c:157
 nbp_update_port_count net/bridge/br_if.c:242 [inline]
 br_add_if+0xca2/0x1b70 net/bridge/br_if.c:640
 do_set_master+0x1b5/0x220 net/core/rtnetlink.c:2704
 do_setlink+0xae7/0x4080 net/core/rtnetlink.c:2910
 __rtnl_newlink+0xc28/0x1940 net/core/rtnetlink.c:3701
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 __sys_sendto+0x225/0x310 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb90a07ea9c
Code: 1a 51 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 60 51 02 00 48 8b
RSP: 002b:00007ffdc9860bd0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fb90acd4620 RCX: 00007fb90a07ea9c
RDX: 0000000000000028 RSI: 00007fb90acd4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdc9860c24 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fb90acd4670 R15: 0000000000000000
 </TASK>


Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17cfaa67e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125a592fe80000


