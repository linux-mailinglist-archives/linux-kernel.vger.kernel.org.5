Return-Path: <linux-kernel+bounces-43764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA48418A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5A71F2306A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49033612E;
	Tue, 30 Jan 2024 01:48:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC93611F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579286; cv=none; b=AR2gI4Yn339jFZAGJSmHhS+vGQp/BcGjxf2vJ/NcptkauwmPeaG5hQq4Y88dhRFxiWQxrFS++5RQuM3blmbhTpLeUCZNykmCayaLZvPJ5yqcFME87WtsfpABXwgnq5MtghqpHKuUZMzeiwSKOZsfX6FLdDAr3HwYiL7HCTrbveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579286; c=relaxed/simple;
	bh=4u+A1vQXpr16vYEqK2FuqaqCZzPchr/V9rpzw6NpGY0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j0dqaIUH7pFT3UH4oGvxO1kFxZ6VBHr45TihtHuBp7wyX3f8ls7HOUnYyQOuynqd5/4JzMq3BoVLiAAI6x0iigz82lsqwI5gM1RojSIBX/yfXO605ydjDTDVZlqHk99hWSxLVSh/d0EzECDPbF9SydINnur4s5q4CO6zzQH5a+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3637bd89021so11714745ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706579284; x=1707184084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQyehiTqsPD9QmO/MWn0IJufomXJMjnEivAbX3Ruiqo=;
        b=BdHMjL6tpQqUs4hlP93ohfNvKdEo1ovH8gIQkHJGwXCdZ5m8fVsQYe8THf1w3625D3
         K2SbFv/ihdHRMEcK4A8hsHvm3eioZuKsujZWmq4skVaGetvJQGZH7hy6F4c6IBXz037x
         mCJzvH9tuNF5au40il7qIw9ILMjUGoyuo8f6RGqQeELyHtIsjOUfDxtLLXD5wM4+rxRT
         9BDTt+wb03CEEp/VgIkcNfMIs/PUrBy8e/jOlmXHtoD20oBTN0ePRBHEEzBmXjW0MGUM
         lyWsPsQR1G3RyE0C9w7FDhbY7i+bgXDLZfJgv/1lUGevLr7mbT/IZHs8HO8q/dzFTP6Y
         E7tQ==
X-Gm-Message-State: AOJu0Yyi5Xhew6IhT1oDFocPKLH75+aNIBcjdURwo5CqlHeTu7J5ENG7
	OfB8SzRtitfh7inte+Zh7VXtoGm8ZyjpkJ/RdlQ9S+wUJ7vOVOEfT4Z3XnOPcdYkww8IR7cEJ50
	e2GBbtybgFsphc41Yr6sVuCq6OYzshzGfZqFyb1TActC87Xtc4Pmybv0=
X-Google-Smtp-Source: AGHT+IH72akUDYw3Q7B6G283Lu8nClq5LgJB4sXHKMFl+waRbRNnr8fpih/Kzq0xDykoIeJ31PVWb9JbHroa4rxpQBu5UxhLl+hI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:363:7de8:ea1c with SMTP id
 i12-20020a056e021b0c00b003637de8ea1cmr571387ilv.2.1706579283889; Mon, 29 Jan
 2024 17:48:03 -0800 (PST)
Date: Mon, 29 Jan 2024 17:48:03 -0800
In-Reply-To: <tencent_96923BDDBADDD4195E4FA18DB525DB8D9407@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff5f5606101ff366@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in relay_close

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5650, name: syz-executor.4
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by syz-executor.4/5650:
 #0: ffff88801f37c3d0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:661
 #1: ffffffff8d19a1c0 (console_lock){+.+.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1923 [inline]
 #1: ffffffff8d19a1c0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2302
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:303 [inline]
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: console_flush_all+0x12d/0xd60 kernel/printk/printk.c:2959
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_core+0x7bd/0x1680 kernel/rcu/tree.c:2465
Preemption disabled at:
[<ffffffff816b4ebd>] vprintk_emit+0x15d/0x5f0 kernel/printk/printk.c:2295
CPU: 0 PID: 5650 Comm: syz-executor.4 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb79-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10176
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0xe2/0x9d0 kernel/locking/mutex.c:752
 relay_close kernel/relay.c:760 [inline]
 relay_close+0x36/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x190 kernel/trace/blktrace.c:316
 blk_trace_rcu_free+0x22/0x30 kernel/trace/blktrace.c:388
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:console_flush_all+0xa11/0xd60 kernel/printk/printk.c:2973
Code: e8 84 c1 23 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 c2 db 1c 00 48 85 db 0f 85 7c 01 00 00 e8 24 e0 1c 00 fb 48 8b 04 24 <4c> 89 fa 83 e2 07 0f b6 00 38 d0 7f 08 84 c0 0f 85 55 02 00 00 41
RSP: 0018:ffffc90009d478d0 EFLAGS: 00000293
RAX: fffff520013a8f41 RBX: 0000000000000000 RCX: ffffffff816b466e
RDX: ffff888029055940 RSI: ffffffff816b467c RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000004 R12: 0000000000000000
R13: ffffffff8dda6a58 R14: ffffffff8dda6a00 R15: ffffc90009d47a08
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 do_blk_trace_setup+0x888/0xaa0 kernel/trace/blktrace.c:590
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:644
 blk_trace_setup+0x47/0x60 kernel/trace/blktrace.c:662
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f70eba7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f70ec73a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f70ebbabf80 RCX: 00007f70eba7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f70ebac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f70ebbabf80 R15: 00007ffdbca452f8
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.8.0-rc2-syzkaller-g41bccc98fb79-dirty #0 Tainted: G        W         
-----------------------------
syz-executor.4/5650 is trying to lock:
ffffffff8d21c348 (relay_channels_mutex){+.+.}-{3:3}, at: relay_close kernel/relay.c:760 [inline]
ffffffff8d21c348 (relay_channels_mutex){+.+.}-{3:3}, at: relay_close+0x36/0x5d0 kernel/relay.c:752
other info that might help us debug this:
context-{2:2}
4 locks held by syz-executor.4/5650:
 #0: ffff88801f37c3d0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:661
 #1: ffffffff8d19a1c0 (console_lock){+.+.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1923 [inline]
 #1: ffffffff8d19a1c0 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2302
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:303 [inline]
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
 #2: ffffffff8d19a230 (console_srcu){....}-{0:0}, at: console_flush_all+0x12d/0xd60 kernel/printk/printk.c:2959
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #3: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_core+0x7bd/0x1680 kernel/rcu/tree.c:2465
stack backtrace:
CPU: 0 PID: 5650 Comm: syz-executor.4 Tainted: G        W          6.8.0-rc2-syzkaller-g41bccc98fb79-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4751 [inline]
 check_wait_context kernel/locking/lockdep.c:4821 [inline]
 __lock_acquire+0x821/0x3b30 kernel/locking/lockdep.c:5087
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9d0 kernel/locking/mutex.c:752
 relay_close kernel/relay.c:760 [inline]
 relay_close+0x36/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x190 kernel/trace/blktrace.c:316
 blk_trace_rcu_free+0x22/0x30 kernel/trace/blktrace.c:388
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:console_flush_all+0xa11/0xd60 kernel/printk/printk.c:2973
Code: e8 84 c1 23 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 c2 db 1c 00 48 85 db 0f 85 7c 01 00 00 e8 24 e0 1c 00 fb 48 8b 04 24 <4c> 89 fa 83 e2 07 0f b6 00 38 d0 7f 08 84 c0 0f 85 55 02 00 00 41
RSP: 0018:ffffc90009d478d0 EFLAGS: 00000293
RAX: fffff520013a8f41 RBX: 0000000000000000 RCX: ffffffff816b466e
RDX: ffff888029055940 RSI: ffffffff816b467c RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000004 R12: 0000000000000000
R13: ffffffff8dda6a58 R14: ffffffff8dda6a00 R15: ffffc90009d47a08
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 do_blk_trace_setup+0x888/0xaa0 kernel/trace/blktrace.c:590
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:644
 blk_trace_setup+0x47/0x60 kernel/trace/blktrace.c:662
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f70eba7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f70ec73a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f70ebbabf80 RCX: 00007f70eba7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f70ebac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f70ebbabf80 R15: 00007ffdbca452f8
 </TASK>
------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:2864!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5650 Comm: syz-executor.4 Tainted: G        W          6.8.0-rc2-syzkaller-g41bccc98fb79-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:vunmap+0x77/0xa0 mm/vmalloc.c:2864
Code: 48 89 ef e8 bb fb ff ff 48 85 c0 48 89 c3 74 1c e8 3e d4 b4 ff 48 89 df e8 76 97 02 00 5b 5d e9 2f d4 b4 ff e8 2a d4 b4 ff 90 <0f> 0b e8 22 d4 b4 ff 90 48 c7 c7 80 e8 d9 8a 48 89 ee e8 d2 c4 7a
RSP: 0018:ffffc90000007d18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000100 RCX: ffffffff81d35224
RDX: ffff888029055940 RSI: ffffffff81d35276 RDI: 0000000000000005
RBP: ffffc9000cea1000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000100 R11: ffffffff8a9228aa R12: ffff88802d70c4a8
R13: fffffbfff1e75f73 R14: ffffed100d9dd408 R15: ffff88806ceea000
FS:  00007f70ec73a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc1e7739a0 CR3: 000000006a156000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 relay_destroy_buf+0x6e/0x3e0 kernel/relay.c:199
 relay_remove_buf kernel/relay.c:221 [inline]
 kref_put include/linux/kref.h:65 [inline]
 relay_close_buf+0x153/0x1b0 kernel/relay.c:430
 relay_close kernel/relay.c:766 [inline]
 relay_close+0x3a8/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x190 kernel/trace/blktrace.c:316
 blk_trace_rcu_free+0x22/0x30 kernel/trace/blktrace.c:388
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:console_flush_all+0xa11/0xd60 kernel/printk/printk.c:2973
Code: e8 84 c1 23 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 c2 db 1c 00 48 85 db 0f 85 7c 01 00 00 e8 24 e0 1c 00 fb 48 8b 04 24 <4c> 89 fa 83 e2 07 0f b6 00 38 d0 7f 08 84 c0 0f 85 55 02 00 00 41
RSP: 0018:ffffc90009d478d0 EFLAGS: 00000293
RAX: fffff520013a8f41 RBX: 0000000000000000 RCX: ffffffff816b466e
RDX: ffff888029055940 RSI: ffffffff816b467c RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000004 R12: 0000000000000000
R13: ffffffff8dda6a58 R14: ffffffff8dda6a00 R15: ffffc90009d47a08
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 do_blk_trace_setup+0x888/0xaa0 kernel/trace/blktrace.c:590
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:644
 blk_trace_setup+0x47/0x60 kernel/trace/blktrace.c:662
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f70eba7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f70ec73a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f70ebbabf80 RCX: 00007f70eba7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f70ebac947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f70ebbabf80 R15: 00007ffdbca452f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vunmap+0x77/0xa0 mm/vmalloc.c:2864
Code: 48 89 ef e8 bb fb ff ff 48 85 c0 48 89 c3 74 1c e8 3e d4 b4 ff 48 89 df e8 76 97 02 00 5b 5d e9 2f d4 b4 ff e8 2a d4 b4 ff 90 <0f> 0b e8 22 d4 b4 ff 90 48 c7 c7 80 e8 d9 8a 48 89 ee e8 d2 c4 7a
RSP: 0018:ffffc90000007d18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000100 RCX: ffffffff81d35224
RDX: ffff888029055940 RSI: ffffffff81d35276 RDI: 0000000000000005
RBP: ffffc9000cea1000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000100 R11: ffffffff8a9228aa R12: ffff88802d70c4a8
R13: fffffbfff1e75f73 R14: ffffed100d9dd408 R15: ffff88806ceea000
FS:  00007f70ec73a6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc1e7739a0 CR3: 000000006a156000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 84 c1 23 00       	call   0x23c189
   5:	9c                   	pushf
   6:	5b                   	pop    %rbx
   7:	81 e3 00 02 00 00    	and    $0x200,%ebx
   d:	31 ff                	xor    %edi,%edi
   f:	48 89 de             	mov    %rbx,%rsi
  12:	e8 c2 db 1c 00       	call   0x1cdbd9
  17:	48 85 db             	test   %rbx,%rbx
  1a:	0f 85 7c 01 00 00    	jne    0x19c
  20:	e8 24 e0 1c 00       	call   0x1ce049
  25:	fb                   	sti
  26:	48 8b 04 24          	mov    (%rsp),%rax
* 2a:	4c 89 fa             	mov    %r15,%rdx <-- trapping instruction
  2d:	83 e2 07             	and    $0x7,%edx
  30:	0f b6 00             	movzbl (%rax),%eax
  33:	38 d0                	cmp    %dl,%al
  35:	7f 08                	jg     0x3f
  37:	84 c0                	test   %al,%al
  39:	0f 85 55 02 00 00    	jne    0x294
  3f:	41                   	rex.B


Tested on:

commit:         41bccc98 Linux 6.8-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=101b23a0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c61befe80000


