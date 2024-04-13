Return-Path: <linux-kernel+bounces-143581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664EC8A3B14
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CF7285C82
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89D1CAB8;
	Sat, 13 Apr 2024 05:14:45 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845E1C6A5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712985285; cv=none; b=A2gAq96pMnrOmCRHv0W8geJDOrr1WZCUAzdhSOWU3kSwYKklsXReUOLP1EZdh2AmDNnbRvfpSqGdf36RDuLiMeELqG9CiwjyIS+uuWHTG2SPa4Qbq3dXua8+L0Si2q4aSrBPh3/y4Rq4UhaTGAhaFyQQ1NyDCZe5ihEV9E7CWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712985285; c=relaxed/simple;
	bh=b6PdiE/obLSOQsJqadtVkGUFa+3lB2V934XtDFSUkbE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CiwlsmD7qVQvcFO7c7Q3E17rr6Vd652r8fL3I0fbK8PDvAK5hUJI9pM76HXtwm1c+mhQivwZ/ekzJJAbeSjeYTHY/WEAi/ZovUmGDO7lT9f9fh4kX3DN++29oZ4dMxmXgTBXjJ0o05mnDQFZ2lwYRc2+5LIZ0Z9LcrXCEBxKLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so171956139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712985283; x=1713590083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaCyk3QclmFG8mk/Yvl9YPI5nFuDCGZkzEfNn9lMiS0=;
        b=vwWg4tbBNHyeIV8oXuvpIB9HMUtHFtGdvq9M8NsP7XVgKQQNkPBBOjm9Dl9b9Ywib/
         zMh9GWy7mLzoHOgrd2f9vKLZ1efBOiPcqRfGMnVDhRDYV/cVmDVUL757OVpeWcfHLNjJ
         y3tCo9xZmco56xYI+LsDgGMIMK44iI01/SrqqI3Med6b1Au5xPGVOW907ZI/FQZSqDZi
         Qrr7BpW0k0okx7NRzs11clQr0grQnJdBWLKV5fxfoit332c6WAs8ii6A3BLsIHjyT6NA
         YNvqY/pxE7fyXNpNeivzxhzXkI8dW8SazQsqgIRYbuJVZ9ZPKCNNBQGELY/8F81OHrsL
         uUOw==
X-Forwarded-Encrypted: i=1; AJvYcCULxCcW0L1TpRBeTvCqWWAgh8j8TAbG/jV58d/Cfq9g2/NMcD6PJy/GOZ0Za50MhK6R3Yat7Y7CZ1yPk/PTIUrnLEjR69+aeJQHajBz
X-Gm-Message-State: AOJu0YyqShD0pGmqqMCWm1UCjJzM6OvWE75jAR8/h3jOcezZ6ycUe7g2
	wdKajD8gwf3+6WIIGEo3W40McwCbu3AJhVt3xmDvlZRS8aVCg+0Qc0es0w7UemlxGYOtbqQx82u
	PkzYfG0iR8QLUizmYRKfsCWzJbvpxAO/UndrrLUg+oK4BLG2/L4Dk/98=
X-Google-Smtp-Source: AGHT+IHuYB6AP31KS2a9Jwk9rB2BnpCot4tMi4ATZvXrPzKrkqeF6u2YaAlSfw34biMPIrS/63KcQXjK7mkxzDG5c2TcMtuGy30z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:367:472c:e7d7 with SMTP id
 y10-20020a056e02174a00b00367472ce7d7mr374864ill.0.1712985282980; Fri, 12 Apr
 2024 22:14:42 -0700 (PDT)
Date: Fri, 12 Apr 2024 22:14:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c3fc90615f37756@google.com>
Subject: [syzbot] [bpf?] possible deadlock in __queue_map_get
From: syzbot <syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=140c3f8d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16975413180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11062cf3180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05271-gf99c5f563c17 #0 Not tainted
--------------------------------------------
strace-static-x/5063 is trying to acquire lock:
ffff8880233421d8 (&qs->lock){-.-.}-{2:2}, at: __queue_map_get+0x14b/0x4d0 kernel/bpf/queue_stack_maps.c:105

but task is already holding lock:
ffff8880233401d8 (&qs->lock){-.-.}-{2:2}, at: __queue_map_get+0x14b/0x4d0 kernel/bpf/queue_stack_maps.c:105

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&qs->lock);
  lock(&qs->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by strace-static-x/5063:
 #0: ffff88807c3d6c68 (&pipe->mutex){+.+.}-{3:3}, at: pipe_write+0x1c9/0x1a40 fs/pipe.c:455
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
 #2: ffff8880233401d8 (&qs->lock){-.-.}-{2:2}, at: __queue_map_get+0x14b/0x4d0 kernel/bpf/queue_stack_maps.c:105
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 0 PID: 5063 Comm: strace-static-x Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __queue_map_get+0x14b/0x4d0 kernel/bpf/queue_stack_maps.c:105
 bpf_prog_bf9a7c5adf7f532a+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 __queue_map_get+0x14b/0x4d0 kernel/bpf/queue_stack_maps.c:105
 bpf_prog_bf9a7c5adf7f532a+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
 __mutex_lock_common kernel/locking/mutex.c:617 [inline]
 __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
 pipe_write+0x1c9/0x1a40 fs/pipe.c:455
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x4e8593
Code: c7 c2 a8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007ffc411c1eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000002c RCX: 00000000004e8593
RDX: 000000000000002c RSI: 000000001b0c0140 RDI: 0000000000000002
RBP: 000000001b0c0140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002c
R13: 000000000063f460 R14: 000000000000002c R15: 0000000000000001
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

