Return-Path: <linux-kernel+bounces-152166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C578ABA22
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30DC1F2152C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F87175A9;
	Sat, 20 Apr 2024 07:35:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F51758D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713598508; cv=none; b=qDBlMJHC2VgL927kxHk2EcyuyV8rLt4kN+vpOix3weiXK414f7Z2jeV2mGXVqT9C0NtGsEGjc8vl0RJssN9pV3KMEOPGCIiZvcRNaBve41uvLVIDaAaaRYgQQwRlPYNNkzpzbOx6jiAAjabgRMNJPtnS7xUkGqWW43uti80c62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713598508; c=relaxed/simple;
	bh=rJa1zqQTehwszhU3guJpV8qirjfg6qBrAfkPooYZQrk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GI6SoX+cbxaziQuPtQaUHRD8Ui714A2bjaxvkI+yCpoGZdFfBEyoX7JpVkyYXMm8Hj8yOi9CyuUN0dQerJWNAoigSeRQwOhFupNe16DcuTDukdgqjZ71zFSHzZZBmqpp9Q9Dmjn+n08OYF6PzOhh18bMIBD/oTURH7sGWOoUdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so312758039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713598506; x=1714203306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72xKqI6vzEo+jOVEQEBjEFhWtMFP+09XKytZowCNN7E=;
        b=Q3fKHIet543y7Rxw1gcu+tXpsGtoyaq1tc/sSQRn7ZZ3qVHU5ixnHpd9oL0WkgutbV
         z5GX9zS7fY+KYpDPJWujV9wg/Utzw+ymYv7i+nKmJlorLpcxpV5sXT5x8XjXO22x0VEw
         US8ak8CRF6d/ifj8gVRMkhcd+mzp6/jfgg4/DMvVUwf9zi2thmaAEQ68EBTSicdGdkh4
         76hLV+xBMKVdBUWOzdjENIaUcJyW9J7Z6gVfF5bo9fzOua9OQ/UHGkd3lqyzhpmT2jDi
         cpEZg+8wSCQ9thxM5hHPtIovyEn/QAdLzGptl0h5wGptDkE3nIvf7D+NOtYqsVlQ5JOx
         YXkA==
X-Forwarded-Encrypted: i=1; AJvYcCXpTXY0nTXARpMeTfM8GR6WF/8eIdWf4XGd+vUYDVjryXDY42nBo6ti+LoDmhFhnjQYkfHvmV6P24rERcm6T7tDFmDI8zM0OR91lSlj
X-Gm-Message-State: AOJu0YxTA/SXlJU27GBFBjYkGM8PTsOnJGVIV3UX6DjO7WzJxOiRXPNS
	4paUxNyuerz1aYc6jGLLXyxnk8nG5R/O34iNl2y6ZLbgcloDTIY1nAry+qcrhXy+/bavxBAX+ee
	65r44yx/Qar3GOe9ybmx5WH085RQYtTXhbac2HCTd107IbjBGaQcZAA4=
X-Google-Smtp-Source: AGHT+IGsFThg3k7uOXkuYeAj69Ugj+pIw1FgWN0vu2TkM6Z91Hl+V9VbsbFOcni1YmHRqItZTfiJCSd54yfr7a9Jwfqo1O0ogyH7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fcc:b0:7da:70f1:b3fa with SMTP id
 fc12-20020a0566023fcc00b007da70f1b3famr24990iob.3.1713598506080; Sat, 20 Apr
 2024 00:35:06 -0700 (PDT)
Date: Sat, 20 Apr 2024 00:35:06 -0700
In-Reply-To: <20240420061505.62849-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e2cbe0616823e60@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in input_event (2)
From: syzbot <syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
inconsistent lock state in valid_state

================================
WARNING: inconsistent lock state
6.9.0-rc4-syzkaller-00214-g13a2e429f644-dirty #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.0/5511 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffff88801bbe3230 (&dev->event_lock#2){?...}-{2:2}, at: input_inject_event+0xc5/0x340 drivers/input/input.c:460
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  input_event+0x91/0xd0 drivers/input/input.c:434
  input_report_key include/linux/input.h:425 [inline]
  psmouse_report_standard_buttons drivers/input/mouse/psmouse-base.c:128 [inline]
  psmouse_report_standard_packet+0x54/0x200 drivers/input/mouse/psmouse-base.c:146
  psmouse_process_byte+0x48c/0x680 drivers/input/mouse/psmouse-base.c:237
  psmouse_handle_byte+0x49/0x4c0 drivers/input/mouse/psmouse-base.c:279
  ps2_interrupt+0x17c/0x8e0 drivers/input/serio/libps2.c:613
  serio_interrupt+0x90/0x140 drivers/input/serio/serio.c:998
  i8042_interrupt+0x375/0x770 drivers/input/serio/i8042.c:606
  __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
  handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
  common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
  i8042_command drivers/input/serio/i8042.c:356 [inline]
  i8042_aux_write+0x116/0x1a0 drivers/input/serio/i8042.c:391
  serio_write include/linux/serio.h:125 [inline]
  ps2_do_sendbyte+0x20f/0x730 drivers/input/serio/libps2.c:58
  ps2_sendbyte+0x60/0x120 drivers/input/serio/libps2.c:113
  cypress_ps2_sendbyte drivers/input/mouse/cypress_ps2.c:42 [inline]
  cypress_ps2_read_cmd_status drivers/input/mouse/cypress_ps2.c:116 [inline]
  cypress_send_ext_cmd+0x221/0x910 drivers/input/mouse/cypress_ps2.c:189
  cypress_detect+0x93/0x230 drivers/input/mouse/cypress_ps2.c:205
  psmouse_do_detect drivers/input/mouse/psmouse-base.c:1006 [inline]
  psmouse_try_protocol drivers/input/mouse/psmouse-base.c:1020 [inline]
  psmouse_extensions+0xc2e/0x1560 drivers/input/mouse/psmouse-base.c:1143
  psmouse_switch_protocol+0x308/0x7d0 drivers/input/mouse/psmouse-base.c:1537
  psmouse_connect+0x8e4/0x14b0 drivers/input/mouse/psmouse-base.c:1626
  serio_connect_driver drivers/input/serio/serio.c:44 [inline]
  serio_driver_probe+0x7f/0xa0 drivers/input/serio/serio.c:775
  really_probe+0x2b8/0xad0 drivers/base/dd.c:656
  __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
  driver_probe_device+0x50/0x430 drivers/base/dd.c:828
  __driver_attach+0x45f/0x710 drivers/base/dd.c:1214
  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
  serio_attach_driver drivers/input/serio/serio.c:804 [inline]
  serio_handle_event+0x1c7/0x920 drivers/input/serio/serio.c:224
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
irq event stamp: 1274
hardirqs last  enabled at (1273): [<ffffffff8b8f8b1f>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1273): [<ffffffff8b8f8b1f>] _raw_spin_unlock_irqrestore+0x8f/0x140 kernel/locking/spinlock.c:194
hardirqs last disabled at (1274): [<ffffffff8b8f8820>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (1274): [<ffffffff8b8f8820>] _raw_spin_lock_irqsave+0xb0/0x120 kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffffffff8157a613>] rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
softirqs last  enabled at (0): [<ffffffff8157a613>] rcu_read_lock include/linux/rcupdate.h:781 [inline]
softirqs last  enabled at (0): [<ffffffff8157a613>] copy_process+0xa03/0x3df0 kernel/fork.c:2259
softirqs last disabled at (0): [<0000000000000000>] 0x0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->event_lock#2);
  <Interrupt>
    lock(&dev->event_lock#2);

 *** DEADLOCK ***

5 locks held by syz-executor.0/5511:
 #0: ffff8880249f5110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x272/0x7c0 drivers/input/evdev.c:513
 #1: ffff88801bbe3230 (&dev->event_lock#2){?...}-{2:2}, at: input_inject_event+0xc5/0x340 drivers/input/input.c:460
 #2: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0xd5/0x340 drivers/input/input.c:462
 #3: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: input_pass_values+0x9d/0x1200 drivers/input/input.c:153
 #4: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #4: ffffffff8e334de0 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x6f/0x300 drivers/input/evdev.c:298

stack backtrace:
CPU: 1 PID: 5511 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-00214-g13a2e429f644-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 valid_state+0x13a/0x1c0 kernel/locking/lockdep.c:4013
 mark_lock_irq+0xbb/0xc20 kernel/locking/lockdep.c:4216
 mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
 mark_held_locks kernel/locking/lockdep.c:4274 [inline]
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4292 [inline]
 lockdep_hardirqs_on_prepare+0x282/0x780 kernel/locking/lockdep.c:4359
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:61
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 evdev_pass_values+0xa28/0xad0 drivers/input/evdev.c:281
 evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
 input_to_handler drivers/input/input.c:129 [inline]
 input_pass_values+0x84d/0x1200 drivers/input/input.c:161
 input_event_dispose+0x36c/0x650 drivers/input/input.c:378
 input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
 input_inject_event+0x22f/0x340 drivers/input/input.c:465
 evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
 vfs_write+0x2a4/0xcb0 fs/read_write.c:588
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d3287de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d3363a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2d329abf80 RCX: 00007f2d3287de69
RDX: 0000000000002250 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f2d328ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2d329abf80 R15: 00007fff20752928
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 5511 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 5511 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-00214-g13a2e429f644-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 6f 98 0f 04 00 74 06 90 c3 cc cc cc cc c6 05 60 98 0f 04 01 90 48 c7 c7 a0 b0 ca 8b e8 c8 be d3 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90004a67ab8 EFLAGS: 00010246
RAX: 40581f7928fa8d00 RBX: 1ffff9200094cf5c RCX: ffff888019f00000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004a67b50 R08: ffffffff81588072 R09: fffffbfff1c39b48
R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: dffffc0000000000
R13: 1ffff9200094cf58 R14: ffffc90004a67ae0 R15: 0000000000000246
FS:  00007f2d3363a6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0861c15ff8 CR3: 000000002c376000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:194
 evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
 vfs_write+0x2a4/0xcb0 fs/read_write.c:588
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d3287de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d3363a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2d329abf80 RCX: 00007f2d3287de69
RDX: 0000000000002250 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f2d328ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2d329abf80 R15: 00007fff20752928
 </TASK>


Tested on:

commit:         13a2e429 Merge tag 'perf-tools-fixes-for-v6.9-2024-04-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f2ff0b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6e826cf3c9c6ffc
dashboard link: https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179d4bab180000


