Return-Path: <linux-kernel+bounces-100529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38987992D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96182843AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E507EEED;
	Tue, 12 Mar 2024 16:41:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B187E119
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261688; cv=none; b=gSZqsfweoGhNANYxUXw3t/5wOE6rHRLjO/4Y0JLhYGNh1qc+HVPtQUd6mnoKFXAhH9DtI+5cDrh5tueZKViLNhGPVC/Nabi94B3BI8fS7pCGX7e8+b5hWGulfuQryQe9bJKS5Ik6U9dKPS0KUsCyrl8QyB/sjCiJq/xPllbmRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261688; c=relaxed/simple;
	bh=Ia/g7gpINNg1xSYQR5fZ/mdVyEIzl5Oml3hHMK0dNQ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NtpvX24HuNow8zsOgx5f5QKsx52SmqzwGTQoHh3PrbJnAuGG9mEBYH+OoruO1Lnlhkh+lbeVFYyUaRSl8Qda30PTlghi3GibwwTwbfuJSJ321wdGrYd2jooJisItqEg1/pp8G7vFN4FJlkec1HI3gVcf1muU8qo+Yw067Agj+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8bcaf249aso175313639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710261686; x=1710866486;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BguXlgsVtvypY7Tu4G0mFoycCRJNmFBusc/imnjbyPM=;
        b=tmZJwAWEl98fM0JmuX8iBTZG8yZxirSddU1UNklgmd35BVJHhZkWbOEBSLvP3k/Amj
         b3b9huor3NWMRjnweS9TDPOIGcG/ez6SXx7ex2i+chO3JHc8zKqR6jraZQA9J7I2ESnc
         C1RUH97JN/QUMOoWxi35XuMY0YVeLLSeTxXV0XP/Qi6NOARdNFi9pEqlSRWBCVaSTCb/
         QNfFDNnzidr786tXqkMzp7VPEkSa+zs01jW4OANfsrdrtjiuXM475358gFqthfqfqLv7
         1Sm+wNlrfKPNyLUEG+xBw6o30TJh9MSfAGOtFBOfdxzopHjObVy+yZrxCQrbVujUc6rM
         wU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW10Tc0OQccldMoetgOkLRjrHy9PwaGx9hDC9+uN6HJfssdya5cpNUBPDq6IZtghTBwO0o28fxoyqI/WuBWOLpQ5acybOEAs2P7ihnI
X-Gm-Message-State: AOJu0YyzcvjP9SNMLheSK2GaCSG9FNGAfI7kOHXjSzVUHhacvAv7Rb61
	whtBRoGHL6ZPx5wxMDS7sGQf0KOOYYIqT+LlcgGFzirt6p8Ump1traz0JdwjlHisqsEGyYyEs5M
	W+UP1dt0TjOShwcReNyo1pRnW8VUXWte4I79d1zW/39fqE9YGoKZXzo8=
X-Google-Smtp-Source: AGHT+IFAYgwq6zkOJm8YlnnDQkKflTW5gxeK0NaExGE0yzvzCuGBdS8akXQB2L3FYqdbNdeQl2/HK8nbPxnZgv7/bD9cQwOlJGsd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3419:b0:7c8:c7ec:2b71 with SMTP id
 n25-20020a056602341900b007c8c7ec2b71mr81804ioz.3.1710261686407; Tue, 12 Mar
 2024 09:41:26 -0700 (PDT)
Date: Tue, 12 Mar 2024 09:41:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004aa700061379547e@google.com>
Subject: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
From: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df4793505abd Merge tag 'net-6.8-rc8' of git://git.kernel.o..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fd0092180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1509c4ae180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10babc01180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d2e80ee1112b/disk-df479350.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b35ea54cd190/vmlinux-df479350.xz
kernel image: https://storage.googleapis.com/syzbot-assets/59f69d999ad2/bzImage-df479350.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-rc7-syzkaller-gdf4793505abd #0 Not tainted
--------------------------------------------
strace-static-x/5063 is trying to acquire lock:
ffffc900096f10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424

but task is already holding lock:
ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rb->spinlock);
  lock(&rb->spinlock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by strace-static-x/5063:
 #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:103 [inline]
 #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x1cc/0x1a40 fs/pipe.c:465
 #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
 #2: ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
 #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 0 PID: 5063 Comm: strace-static-x Not tainted 6.8.0-rc7-syzkaller-gdf4793505abd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
 ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
 bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
 bpf_prog_9efe54833449f08e+0x2d/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x271/0x370 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
 ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
 bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
 bpf_prog_9efe54833449f08e+0x2d/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
 __mutex_lock_common kernel/locking/mutex.c:617 [inline]
 __mutex_lock+0x2e4/0xd70 kernel/locking/mutex.c:752
 __pipe_lock fs/pipe.c:103 [inline]
 pipe_write+0x1cc/0x1a40 fs/pipe.c:465
 call_write_iter include/linux/fs.h:2087 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa81/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x4e8593
Code: c7 c2 a8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007ffeda768928 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00000000004e8593
RDX: 0000000000000012 RSI: 0000000000817140 RDI: 0000000000000002
RBP: 0000000000817140 R08: 0000000000000010 R09: 0000000000000090
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
R13: 000000000063f460 R14: 0000000000000012 R15: 0000000000000001
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

