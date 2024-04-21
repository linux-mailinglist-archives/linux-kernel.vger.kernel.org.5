Return-Path: <linux-kernel+bounces-152440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE08ABE75
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3491C208F5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA2D4C8F;
	Sun, 21 Apr 2024 03:14:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42F23C9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713669264; cv=none; b=uVgmvqD5flCnl6nts/ulhdRTuJO2zkgmT1kFGbs9Y0p+1VC9x3Q5KxFDMsP+gIp8XN1u0pSsrCyG6JKGCIyhUsw8BHEqL4Z8IMlD1SkSQBD6K6Go/IhA24FpjLxDuxwcI47Fr6Z/OIxEofxXLfWRC9Xva00OS0esjNNLeni9H5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713669264; c=relaxed/simple;
	bh=EC/5UkuctPT22vaYV7HAx8bKIHShT4rZIulxbH31yoQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E2le/VucuS7Cq2EZ3rWHaQ2htkw44PweE2AINobDOus9aAey2offQ2HZdQ6hZBhVa94+eC2qQ6VaPIlrG+QgiaKqWRoWDpQ8SShzz3WlfA1NeWgy/ktfp4Ynvt7m3tz9KPrHOCU49q8UcQF98oLjOQC+oXUaRYZKeVmoyVqgx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d66a30a83aso325707739f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 20:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713669258; x=1714274058;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0dIUOyf9BJ8NEnHNMqH1eOkFQZzFXRLnhyIEX26rYY=;
        b=e1e/Tuzzq35pbj3XNQtjRZoRe4lmD3zP3lMBIZ5EGPKRixf6b8dFlvVqeAt6LJvtNU
         cIuYH0R2nbUSadT7t7HpJDlJtIfAgtMdl84dJfsy1xuLrL27ntp3ru22tw2ADy4Gy3zg
         YY3urRD605Y5pUMTFdnUteeItqzmHpzcM/HPq5yQecPk7XiQitqBPyKPLIJQyCHdgacp
         5e34Y/0QdxmQ2h1Eg8mwiriu+2JgntwgT5VLY1zoO6/varlSGIld88QhS+Omg6Lazf2A
         aJsWk2tm8RthCgW11HSdQbHVZZt3lwrG71gQ+8xCjfTv2rWtw0TDOEGbVRr/aEEu4Ys/
         7AKg==
X-Forwarded-Encrypted: i=1; AJvYcCXElaW61St4YCFWMLoM/W9w6wgTl0BGKig/pjwE9DR7nHw6xCG0I8fOYzn+oI6emnnOQCGXdv1wWiS0kLN75nvixLkFTPLuedtQTv7I
X-Gm-Message-State: AOJu0YyLRqE716MZMCKwScDnHU+Cxs9/nA2iMqzhsuyD+nyW+BDI7Mzq
	sXgBfTi7Gsd+Nz9tCE/JEYGa+VnnOiPG2afhrfu8OA6VHxBK++4oTBnSF8dG6dVbyASNSzDhDrt
	Y1uj7YAklbBisG+SIoGGWGXoDnKUE41yF348TDAz6A9Ho3ORE4lRo/bM=
X-Google-Smtp-Source: AGHT+IFaO8JHB8boo0dhjOL7kZZUE1L2ICumqaY0L5U4Ep3ddVao4LM3AQh0iH4+1cKXZ8QSujSJPcq4XvsBaAS6FleO7jR5LnQe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1405:b0:484:dd72:a148 with SMTP id
 k5-20020a056638140500b00484dd72a148mr359399jad.1.1713669258591; Sat, 20 Apr
 2024 20:14:18 -0700 (PDT)
Date: Sat, 20 Apr 2024 20:14:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bca48061692b790@google.com>
Subject: [syzbot] [mm?] possible deadlock in gup_fast_fallback
From: syzbot <syzbot+63ba90b81c16b86379bd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66e4190e92ce Add linux-next specific files for 20240416
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1526f44f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c247afaa437e6409
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86891dae5f9c/disk-66e4190e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ca383660bf2/vmlinux-66e4190e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf6ff37d3fcc/bzImage-66e4190e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63ba90b81c16b86379bd@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-next-20240416-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/9254 is trying to acquire lock:
ffff88802c2f0b18 (&mm->mmap_lock){++++}-{3:3}, at: gup_fast_fallback+0x233/0x2b40 mm/gup.c:3442

but task is already holding lock:
ffff88806a3c3d80 (&sb->s_type->i_mutex_key#29){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
ffff88806a3c3d80 (&sb->s_type->i_mutex_key#29){++++}-{3:3}, at: __blockdev_direct_IO+0x346/0x49b0 fs/direct-io.c:1146

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#29){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:791 [inline]
       exfat_page_mkwrite+0x43a/0xea0 fs/exfat/file.c:629
       do_page_mkwrite+0x19b/0x480 mm/memory.c:3097
       do_shared_fault mm/memory.c:4977 [inline]
       do_fault mm/memory.c:5039 [inline]
       do_pte_missing mm/memory.c:3881 [inline]
       handle_pte_fault+0x1298/0x6dc0 mm/memory.c:5359
       __handle_mm_fault mm/memory.c:5500 [inline]
       handle_mm_fault+0x10e7/0x1bb0 mm/memory.c:5665
       do_user_addr_fault arch/x86/mm/fault.c:1420 [inline]
       handle_page_fault arch/x86/mm/fault.c:1512 [inline]
       exc_page_fault+0x2b9/0x900 arch/x86/mm/fault.c:1570
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #1 (sb_pagefaults#3){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1659 [inline]
       sb_start_pagefault include/linux/fs.h:1824 [inline]
       exfat_page_mkwrite+0x161/0xea0 fs/exfat/file.c:619
       do_page_mkwrite+0x19b/0x480 mm/memory.c:3097
       do_shared_fault mm/memory.c:4977 [inline]
       do_fault mm/memory.c:5039 [inline]
       do_pte_missing mm/memory.c:3881 [inline]
       handle_pte_fault+0x1298/0x6dc0 mm/memory.c:5359
       __handle_mm_fault mm/memory.c:5500 [inline]
       handle_mm_fault+0x10e7/0x1bb0 mm/memory.c:5665
       do_user_addr_fault arch/x86/mm/fault.c:1420 [inline]
       handle_page_fault arch/x86/mm/fault.c:1512 [inline]
       exc_page_fault+0x2b9/0x900 arch/x86/mm/fault.c:1570
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       gup_fast_fallback+0x24c/0x2b40 mm/gup.c:3442
       pin_user_pages_fast+0xcc/0x160 mm/gup.c:3566
       iov_iter_extract_user_pages lib/iov_iter.c:1583 [inline]
       iov_iter_extract_pages+0x3db/0x720 lib/iov_iter.c:1646
       dio_refill_pages fs/direct-io.c:173 [inline]
       dio_get_page fs/direct-io.c:214 [inline]
       do_direct_IO fs/direct-io.c:916 [inline]
       __blockdev_direct_IO+0x150a/0x49b0 fs/direct-io.c:1249
       blockdev_direct_IO include/linux/fs.h:3182 [inline]
       exfat_direct_IO+0x1b4/0x3d0 fs/exfat/inode.c:526
       generic_file_read_iter+0x231/0x430 mm/filemap.c:2783
       aio_read+0x364/0x500 fs/aio.c:1611
       io_submit_one+0x884/0x18b0 fs/aio.c:2061
       __do_sys_io_submit fs/aio.c:2120 [inline]
       __se_sys_io_submit+0x179/0x2f0 fs/aio.c:2090
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> sb_pagefaults#3 --> &sb->s_type->i_mutex_key#29

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#29);
                               lock(sb_pagefaults#3);
                               lock(&sb->s_type->i_mutex_key#29);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.2/9254:
 #0: ffff88806a3c3d80 (&sb->s_type->i_mutex_key#29){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #0: ffff88806a3c3d80 (&sb->s_type->i_mutex_key#29){++++}-{3:3}, at: __blockdev_direct_IO+0x346/0x49b0 fs/direct-io.c:1146

stack backtrace:
CPU: 0 PID: 9254 Comm: syz-executor.2 Not tainted 6.9.0-rc4-next-20240416-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 gup_fast_fallback+0x24c/0x2b40 mm/gup.c:3442
 pin_user_pages_fast+0xcc/0x160 mm/gup.c:3566
 iov_iter_extract_user_pages lib/iov_iter.c:1583 [inline]
 iov_iter_extract_pages+0x3db/0x720 lib/iov_iter.c:1646
 dio_refill_pages fs/direct-io.c:173 [inline]
 dio_get_page fs/direct-io.c:214 [inline]
 do_direct_IO fs/direct-io.c:916 [inline]
 __blockdev_direct_IO+0x150a/0x49b0 fs/direct-io.c:1249
 blockdev_direct_IO include/linux/fs.h:3182 [inline]
 exfat_direct_IO+0x1b4/0x3d0 fs/exfat/inode.c:526
 generic_file_read_iter+0x231/0x430 mm/filemap.c:2783
 aio_read+0x364/0x500 fs/aio.c:1611
 io_submit_one+0x884/0x18b0 fs/aio.c:2061
 __do_sys_io_submit fs/aio.c:2120 [inline]
 __se_sys_io_submit+0x179/0x2f0 fs/aio.c:2090
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f397947dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f397a1670c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f39795abf80 RCX: 00007f397947dea9
RDX: 0000000020000540 RSI: 0000000000003f0a RDI: 00007f397a13d000
RBP: 00007f39794ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f39795abf80 R15: 00007ffd43409678
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

