Return-Path: <linux-kernel+bounces-139217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C889FFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A001F21EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519C1802C3;
	Wed, 10 Apr 2024 18:45:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC915FA97
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774731; cv=none; b=dQ5HILCLEl3yNs05QzI6c65ZUyTGs7TeGa0kxKaMcMyeot9t7xXeL3biFzZ/ZboIaYSVBuDo8ulYXV05DexM5YdNhFs4Q//+YNFeGUNVzx0S6FYymjdI55DMWKmgcISGyFm8v11TCHZdo/WR+1ts5W/Si4wkeaBGeUca/k7hzEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774731; c=relaxed/simple;
	bh=1eFK+fOGhEHzf3JiINykYDpOAe8hNn/TlLiEqgTGk1c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e0TKe7t8OAZ01VUC+1dnX/ygRIhufq+ul8/qA0ahlkmUS/CeMThnjQpRr2BGJTTrnLgZ73UKA1s7zb+MOZiTvu292vOcSNKe4mT1DWnV/ypTIy/IUpxHi9R0cGO5BsM2cuoQeGqiT+j1bgEqckKYl823uhQQsEdq3MZrRo3NjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a2d2a6d7dso27633745ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712774729; x=1713379529;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nwy23gX5etqdQyBt5QW4m0H7x6nLvEGnJWaKDK439zc=;
        b=hNXgHXyU4W8e4msQupGOcRfxIOzl5y3ccHr7CbfoVkqywMkoGbF9aR+lCRjWwFrs4+
         tdZ4NRIRbh4KOhx1od/WLm7Qd3fepQ33FX0wH6CfsBQrgAiThn8p3uw4DmsCS1Ul0mlf
         iPLEM2LsY5ELJzJq6TR2FdNKwInLL34JjmPAn5U0v2hwEpr57DKS38U0myWd9LvvuElZ
         Yj6a+hIU2CeERr7YKVYQzv3Wwz6H9/R5GD7/dJQ8ptsPSZvpfdXoq6A7UpBDXTS61YME
         uIGLVmfEKI1TUHoYG0y+sFTasgZeKNq2NYchJjUFkkatizdQQEwr/e9hax8HDRy8riEY
         BoEg==
X-Forwarded-Encrypted: i=1; AJvYcCVdIoNAaTFxz4Bt7E9/0QPd4abkL5Teiq+DV5ImPeMyVPVl3JZJeo7v0FhijItbwGbeF4rcaFlaM3N6BMkzKqfixI027qKTwWarqT5V
X-Gm-Message-State: AOJu0YzM2yXl3RZQE/tnZixwwBHdpJVZkev9HgJUKDnFDuSBNGfK0n6X
	rGsjHjJC2Igxq5n0VxwqkafMHeYlZ3F8au/YwCb61JBDzY+s4TrJRDJMDc20eoyqIFT6N6ugK2j
	JoOonJpStihPLwBhZb9cL42ynMnGDmtkOs4Z2yBY346B5Aoo5AvLiJwg=
X-Google-Smtp-Source: AGHT+IFcg8dyj4hUZJuxDdHhZNTsZNlYVCL2R5vGeZYydg+qo9JHRS4NXs7jaFfMi5Ry/qgsaYCNaII5mv6QguKc2FRh4ewJwnsh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:369:f750:5bf1 with SMTP id
 e7-20020a056e020b2700b00369f7505bf1mr194372ilu.5.1712774729524; Wed, 10 Apr
 2024 11:45:29 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:45:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005576ad0615c2710b@google.com>
Subject: [syzbot] [net?] possible deadlock in unix_notinflight
From: syzbot <syzbot+38b3aa8cd529958bd27a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12898aa9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=38b3aa8cd529958bd27a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d693e3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aee305180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38b3aa8cd529958bd27a@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
--------------------------------------------
kworker/u8:0/10 is trying to acquire lock:
ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: unix_notinflight+0x204/0x390 net/unix/garbage.c:140

but task is already holding lock:
ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf10 net/unix/garbage.c:261

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(unix_gc_lock);
  lock(unix_gc_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u8:0/10:
 #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900000f7d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900000f7d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf10 net/unix/garbage.c:261

stack backtrace:
CPU: 1 PID: 10 Comm: kworker/u8:0 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 unix_notinflight+0x204/0x390 net/unix/garbage.c:140
 unix_detach_fds net/unix/af_unix.c:1819 [inline]
 unix_destruct_scm+0x221/0x350 net/unix/af_unix.c:1876
 skb_release_head_state+0x100/0x250 net/core/skbuff.c:1188
 skb_release_all net/core/skbuff.c:1200 [inline]
 __kfree_skb net/core/skbuff.c:1216 [inline]
 kfree_skb_reason+0x15d/0x390 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1267 [inline]
 __unix_gc+0xaf3/0xf10 net/unix/garbage.c:330
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

