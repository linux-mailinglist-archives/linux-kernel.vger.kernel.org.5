Return-Path: <linux-kernel+bounces-157984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609AB8B19CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81D71F24ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F32B9DE;
	Thu, 25 Apr 2024 04:00:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163721AACB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714017622; cv=none; b=CtCx4Vf9ArvzbezPjRfXiHkRxCwX7dMenGMZ7/H++octCVLypmGoD5rf046uuZ3thpmhRA4Tw686HZy9OODDnBS9LJL5q6hdw4AOeLN6fNVebzQe/O8dhP2VKFo5tw1W1bWHmsGFDcWs4H6nFIg14F8+PeENcM2/yDSmsyGttQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714017622; c=relaxed/simple;
	bh=TPNPxwZ9vL4N9SlZkEDreRETsvDf83ZwbjXXy9p5hrs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jIwdvLgUHw1rXKGIPYCHaXEnDM5/L44pH9XSwuIbA2BAECdMdnfDn2Nokt5ufACjSYpNjlplgBYl9mZ6vdNGXOxF1Q7Svj/EkW/gdj5TtuC369XOMTNgrw6r/Ngv35+MUCAqDYnJd0/eY1mIIaediLZn1gXWQCROjeSY5fdZXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c1af8f2f3so6543515ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714017620; x=1714622420;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkkHSSSTB0CocaopvtpYuNr0ZoJmuQtEpepwrvwJ4s4=;
        b=nxFf1Vq17oh0+ok+YY5t+gws07DBRneIvOGBp4m9/8faTptkXc1tG7aLwEbk+v3kUZ
         DH+77haMuXOvyo1S/aM5s5xU5Kr97tLiRkvV3A29qqDnlmmZx7pEK3bZhl5PNjzbwhBJ
         q8ILskdSCgOoPR8vCIgUIGoUjNAkq0frKXSwPs+1VXSNauaGfS6I9fS1eYj38d9GdzBq
         2FoEhBu1CRy14+unXOnKdfJhoXlFA75kIqaGm9DNN50wdkTY0AVPJAnG7i6s+ZjdCGQ3
         hQHpZh8Jw72kSXP+sbDVRA330WWs6Sy1cwdSXCkAvRlWYht6/X+WoQtDLyhTBTNqTh3q
         PLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOfVJ1bGkxASfN6PCaOxT6EmSEVdKr/9tVAMpR3Sd4bxR8Po4/BiSy1uv91eT0i3Lju6K7kGFYxigPddNC6hHCNMd7d8Xw8DGVbKCs
X-Gm-Message-State: AOJu0YzJkg/MuZPqHG0jvTTC2rW6yemekDbEPM6/PLgg8R8YCZkBNxeK
	bxZPssGaOPFT+KPNH2UcnIO3aeZ9cAdrFwKFmujl2AjY9OQmkCDdC54pg+k3CpWeE0k0kjwQlwj
	xp5utIMh2u+ivSpiVrGZNuY6fGjZ/wF32hGfchIvaUHSHa/44MuCufhA=
X-Google-Smtp-Source: AGHT+IHrZq+kGFtTQ+1wukUqwCFCkw/wL0DXgKMlBF50iVi/vAbI/MAb/zcLavaIOjPGgmiqQtDhFYOrBTCIuv06relNkA+1CFMV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:369:fba0:e97d with SMTP id
 k11-20020a056e021a8b00b00369fba0e97dmr239258ilv.3.1714017620291; Wed, 24 Apr
 2024 21:00:20 -0700 (PDT)
Date: Wed, 24 Apr 2024 21:00:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006588730616e3d3d8@google.com>
Subject: [syzbot] [serial?] possible deadlock in uart_write (2)
From: syzbot <syzbot+57cc2f20a84cb4346354@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15db8e10980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=57cc2f20a84cb4346354
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57cc2f20a84cb4346354@syzkaller.appspotmail.com

sp0: Synchronizing with TNC
------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-next-20240418-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/6662 is trying to acquire lock:
ffffffff8e327d60 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1994 [inline]
ffffffff8e327d60 (console_owner){....}-{0:0}, at: vprintk_emit+0x3cf/0x770 kernel/printk/printk.c:2344

but task is already holding lock:
ffffffff94aa1878 (&port_lock_key){-.-.}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
ffffffff94aa1878 (&port_lock_key){-.-.}-{2:2}, at: uart_write+0x10e/0x320 drivers/tty/serial/serial_core.c:604

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&port_lock_key){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
       serial8250_console_write+0x1a8/0x1770 drivers/tty/serial/8250/8250_port.c:3352
       console_emit_next_record kernel/printk/printk.c:2928 [inline]
       console_flush_all+0x867/0xfd0 kernel/printk/printk.c:2994
       console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3063
       vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2345
       _printk+0xd5/0x120 kernel/printk/printk.c:2370
       register_console+0x722/0xce0 kernel/printk/printk.c:3596
       univ8250_console_init+0x49/0x50 drivers/tty/serial/8250/8250_core.c:723
       console_init+0x1b8/0x6f0 kernel/printk/printk.c:3742
       start_kernel+0x2d3/0x500 init/main.c:1034
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       console_trylock_spinning kernel/printk/printk.c:1994 [inline]
       vprintk_emit+0x3ec/0x770 kernel/printk/printk.c:2344
       _printk+0xd5/0x120 kernel/printk/printk.c:2370
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x346/0x500 lib/bug.c:219
       handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       uart_write+0x2b0/0x320 drivers/tty/serial/serial_core.c:605
       tnc_init drivers/net/hamradio/6pack.c:531 [inline]
       sixpack_open+0x790/0xa80 drivers/net/hamradio/6pack.c:628
       tty_ldisc_open drivers/tty/tty_ldisc.c:432 [inline]
       tty_ldisc_reinit+0x2d4/0x4a0 drivers/tty/tty_ldisc.c:661
       tty_reopen+0x20b/0x2d0 drivers/tty/tty_io.c:1366
       tty_open_by_driver drivers/tty/tty_io.c:2082 [inline]
       tty_open+0xa26/0xdf0 drivers/tty/tty_io.c:2135
       chrdev_open+0x5b0/0x630 fs/char_dev.c:414
       do_dentry_open+0x95a/0x1720 fs/open.c:955
       do_open fs/namei.c:3650 [inline]
       path_openat+0x289f/0x3280 fs/namei.c:3807
       do_filp_open+0x235/0x490 fs/namei.c:3834
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_openat fs/open.c:1436 [inline]
       __se_sys_openat fs/open.c:1431 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port_lock_key);
                               lock(console_owner);
                               lock(&port_lock_key);
  lock(console_owner);

 *** DEADLOCK ***

3 locks held by syz-executor.4/6662:
 #0: ffff88805f95e1c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_lock_interruptible+0x68/0xc0 drivers/tty/tty_mutex.c:27
 #1: ffff88805f95e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: __tty_ldisc_lock drivers/tty/tty_ldisc.c:289 [inline]
 #1: ffff88805f95e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock+0x6c/0xc0 drivers/tty/tty_ldisc.c:313
 #2: ffffffff94aa1878 (&port_lock_key){-.-.}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
 #2: ffffffff94aa1878 (&port_lock_key){-.-.}-{2:2}, at: uart_write+0x10e/0x320 drivers/tty/serial/serial_core.c:604

stack backtrace:
CPU: 0 PID: 6662 Comm: syz-executor.4 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
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
 console_trylock_spinning kernel/printk/printk.c:1994 [inline]
 vprintk_emit+0x3ec/0x770 kernel/printk/printk.c:2344
 _printk+0xd5/0x120 kernel/printk/printk.c:2370
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x346/0x500 lib/bug.c:219
 handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:uart_write+0x2b0/0x320 drivers/tty/serial/serial_core.c:605
Code: 74 08 48 89 df e8 a0 9e be fc 48 83 3b 00 74 74 e8 05 4e 59 fc eb 97 e8 fe 4d 59 fc 45 31 e4 eb 08 e8 f4 4d 59 fc 45 31 ed 90 <0f> 0b 90 45 84 e4 74 0a e8 e3 4d 59 fc 45 31 f6 eb 84 e8 d9 4d 59
RSP: 0018:ffffc90009fcf4b8 EFLAGS: 00010046
RAX: ffffffff853d0f92 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: ffffc90013601000 RSI: 000000000001ba5f RDI: 000000000001ba60
RBP: ffff88801f720f48 R08: 0000000000000003 R09: fffff520013f9e74
R10: dffffc0000000000 R11: fffff520013f9e74 R12: 0000000000000000
R13: 0000000000000246 R14: ffff88801f720be8 R15: ffffffff94aa1860
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x790/0xa80 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open drivers/tty/tty_ldisc.c:432 [inline]
 tty_ldisc_reinit+0x2d4/0x4a0 drivers/tty/tty_ldisc.c:661
 tty_reopen+0x20b/0x2d0 drivers/tty/tty_io.c:1366
 tty_open_by_driver drivers/tty/tty_io.c:2082 [inline]
 tty_open+0xa26/0xdf0 drivers/tty/tty_io.c:2135
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x95a/0x1720 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd50cc7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd50d96c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd50cdabf80 RCX: 00007fd50cc7dea9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007fd50ccca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd50cdabf80 R15: 00007ffeacd13b38
 </TASK>
WARNING: CPU: 0 PID: 6662 at drivers/tty/serial/serial_core.c:605 uart_write+0x2b0/0x320 drivers/tty/serial/serial_core.c:605
Modules linked in:
CPU: 0 PID: 6662 Comm: syz-executor.4 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:uart_write+0x2b0/0x320 drivers/tty/serial/serial_core.c:605
Code: 74 08 48 89 df e8 a0 9e be fc 48 83 3b 00 74 74 e8 05 4e 59 fc eb 97 e8 fe 4d 59 fc 45 31 e4 eb 08 e8 f4 4d 59 fc 45 31 ed 90 <0f> 0b 90 45 84 e4 74 0a e8 e3 4d 59 fc 45 31 f6 eb 84 e8 d9 4d 59
RSP: 0018:ffffc90009fcf4b8 EFLAGS: 00010046
RAX: ffffffff853d0f92 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: ffffc90013601000 RSI: 000000000001ba5f RDI: 000000000001ba60
RBP: ffff88801f720f48 R08: 0000000000000003 R09: fffff520013f9e74
R10: dffffc0000000000 R11: fffff520013f9e74 R12: 0000000000000000
R13: 0000000000000246 R14: ffff88801f720be8 R15: ffffffff94aa1860
FS:  00007fd50d96c6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd65b98000 CR3: 0000000011650000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x790/0xa80 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open drivers/tty/tty_ldisc.c:432 [inline]
 tty_ldisc_reinit+0x2d4/0x4a0 drivers/tty/tty_ldisc.c:661
 tty_reopen+0x20b/0x2d0 drivers/tty/tty_io.c:1366
 tty_open_by_driver drivers/tty/tty_io.c:2082 [inline]
 tty_open+0xa26/0xdf0 drivers/tty/tty_io.c:2135
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x95a/0x1720 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd50cc7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd50d96c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd50cdabf80 RCX: 00007fd50cc7dea9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007fd50ccca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd50cdabf80 R15: 00007ffeacd13b38
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

