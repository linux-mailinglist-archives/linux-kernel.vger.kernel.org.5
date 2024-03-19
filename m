Return-Path: <linux-kernel+bounces-107328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F400587FB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C69B2184C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286E7D3F8;
	Tue, 19 Mar 2024 09:52:19 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B62548F9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841939; cv=none; b=PfqH24/PKSuYaf3BOny1Fe6gYpCL93ZJh0oLP8k+cjcfQHtouRj0+2VV3QN4Z8/miGCmM/d1A7/SjIrpRiYwZRJu/P3yrPn8vciMxO2FT0XcWR8Ex1FpSh1FkKfTGSgtNax22L+rJyN0+oUFy1/SPVGcejMN68Vhb9iExR5Z4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841939; c=relaxed/simple;
	bh=k9ED3JABZ9/AicJU9OpDJZpqgPKd5rQqK4qkYcWgpbM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R6FrtuTS40FT4eOcCqy4LMJdoaQuBgxc3ZRXL1RcEXLJLGCUsiZMX378+AeB76uT0axp0BGxdM5Sp9nmzA0bOIR33e5h5I0Sn1e0d1wz278rHQRVRt6we1rvrcM7gJEQcAlHzkSRMDK2KENpI3HLAZDrMJa3BwirIdzdqpLT9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3684e275874so2303195ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841937; x=1711446737;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgksWobu6Y4B5YtXN/SFJIBHO1gc/F7nv1xG78u++sk=;
        b=eDEAG9CV7h3zzQt6W0IKumSJiJ59ZLiIVfZGnb1qN3sXDzvouedsoNlH1kKgjC0UDA
         gZ7u2LzUMRTWJBeX0l6LvN3/R+bdvF8GaVb41xz+wMF4aJZRpQPWuFeupAjxWU/hUjG2
         FYYq5kojw2sViidAwq11LZb0gIANEOaKpvYDv61vZl1V8Kbqc36SHKbQBdEgahj99aIz
         hRILAjGUTy6eVw2WCYxlTsZW1WanCPU2ZQ3EMU6IIxvatYKyM6bx1ZcS7y8FzEgzFhwk
         0l1cWLeHRzvYgDurQQ/k/pujCQBVVPuFks0BANLVQSfjakRMkQzVK31zZ3IeV8XO6xRV
         jumA==
X-Forwarded-Encrypted: i=1; AJvYcCXOvfAGFgRYsggYH0DhoVb5zJXHOvgp9ON0e8chWc1zgJK4PO6BSU8IZxiV88fer8DPHw3lthU8wp9X/R6xYpUhPUhCeOLcYdAvmXac
X-Gm-Message-State: AOJu0YysHi2vqzUIV05kWG60fJDx9ftETWfsaPRsCkfxYRkh5+ySJxcX
	MvHw+FY9hkymXGuf3eCkiJ8fDkQ8JycmB8xUXvuxxn6onia2skRH8T1Wf/9AwJzKOfmC1YL7gxB
	BUF8GOvc6hRQQodogKI4LRepkouRQH3wEZXEpHQDX+XdO3/L/zlDFp6o=
X-Google-Smtp-Source: AGHT+IG/wGs4aWlyM2S68c62kL+A3QQGcB9D+htUYVkg+wDZ/gF2SIPxTnc0Tf8OPyAnTxwviiqLVBAUZlbJ0S22lA0F8J5qX2Im
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:3601:0:b0:368:4f35:92d8 with SMTP id
 d1-20020a923601000000b003684f3592d8mr51852ila.0.1710841936832; Tue, 19 Mar
 2024 02:52:16 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:52:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e97f090614006d76@google.com>
Subject: [syzbot] [mm?] possible deadlock in move_pages
From: syzbot <syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160dc26e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ffb854606e658d
dashboard link: https://syzkaller.appspot.com/bug?extid=49056626fe41e01f2ba7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f467b9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173b7ac9180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e5eb28f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5c7ad05d6b2/vmlinux-e5eb28f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/531cb1917612/bzImage-e5eb28f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-09791-ge5eb28f6d1af #0 Not tainted
--------------------------------------------
syz-executor258/5169 is trying to acquire lock:
ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1447 [inline]
ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xbab/0x4970 mm/userfaultfd.c:1583

but task is already holding lock:
ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1445 [inline]
ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xb6f/0x4970 mm/userfaultfd.c:1583

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&vma->vm_lock->lock);
  lock(&vma->vm_lock->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor258/5169:
 #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:146 [inline]
 #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1438 [inline]
 #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: move_pages+0x8df/0x4970 mm/userfaultfd.c:1583
 #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1445 [inline]
 #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xb6f/0x4970 mm/userfaultfd.c:1583

stack backtrace:
CPU: 2 PID: 5169 Comm: syz-executor258 Not tainted 6.8.0-syzkaller-09791-ge5eb28f6d1af #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
 uffd_move_lock mm/userfaultfd.c:1447 [inline]
 move_pages+0xbab/0x4970 mm/userfaultfd.c:1583
 userfaultfd_move fs/userfaultfd.c:2008 [inline]
 userfaultfd_ioctl+0x5e1/0x60e0 fs/userfaultfd.c:2126
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fd48da20329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1244f8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd1244fab8 RCX: 00007fd48da20329
RDX: 00000000200000c0 RSI: 00000000c028aa05 RDI: 0000000000000003
RBP: 00007fd48da93610 R08: 00007ffd1244fab8 R09: 00007ffd1244fab8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd1244faa8 R14: 0000000000000001 R15: 0000000000000001
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

