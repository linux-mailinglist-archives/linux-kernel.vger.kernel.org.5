Return-Path: <linux-kernel+bounces-11177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045781E28D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A3B28226C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0953E25;
	Mon, 25 Dec 2023 22:15:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4DD53E17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc8389a58so51577935ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703542518; x=1704147318;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rip215w0utwJlp3VMvtrLmUA6SkvTi1xwwz2HP57p2U=;
        b=DEiH49D+jabDEXKaBF3qQg3NUh2RBX6tZeWMxkT12yAqEbjAbP1Y7Xkno/aFnv06M9
         Cy3UBshzyqfguBupTQt38jSCmYBYVbBOKprakWy91TDuz8v/g9A3yVYdaKvbJebSHYvL
         vwi1ff3QC/4Jd5gAMe7ZA6o8908h915eJJUT3jPEGKSFFBfwgHkrNvf+IdVXnWbzmMSh
         znhG+dGPks9j5RljpdfO6gltt5EXZ7jf3AL9vS8MW2i9i+H93Ld2dBiAV1s7puYz0mG9
         ZFVOrVT8t/Evq87LAN8D11kUKIj9wBvi1WsHJN+JC1XxtC4rbWZLoFlNXirP0IHiGbgQ
         qESA==
X-Gm-Message-State: AOJu0Ywzc8J/15TAns97NYASyP+IrRIwBkLWn5W0fvGPbW7vbfMFoKIp
	nOtpeUZ/eKcCIG7xHp7flnIzKvJGCdDMk1ecaa4YGqkbOMfaThw=
X-Google-Smtp-Source: AGHT+IHR4WNc32meWLBXWnBUSZ3hMug44THXbrA+1/f46yL0yWmiQjIF67ZFz7j+Cinu8Z7cRyruOpnjrYN5XArSok6z+szYozhI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174c:b0:35f:bea3:c041 with SMTP id
 y12-20020a056e02174c00b0035fbea3c041mr1136770ill.4.1703542518304; Mon, 25 Dec
 2023 14:15:18 -0800 (PST)
Date: Mon, 25 Dec 2023 14:15:18 -0800
In-Reply-To: <0000000000008fcf9806083e7405@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9d761060d5ce6cf@google.com>
Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak-after-free in
 copy_siginfo_to_user (2)
From: syzbot <syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15826ec9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=cfc08744435c4cf94a40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ea5231e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 copy_siginfo_to_user+0x40/0x130 kernel/signal.c:3374
 ptrace_request+0xfa6/0x36d0 kernel/ptrace.c:1066
 arch_ptrace+0x435/0x680 arch/x86/kernel/ptrace.c:848
 __do_sys_ptrace kernel/ptrace.c:1305 [inline]
 __se_sys_ptrace+0x2d8/0x750 kernel/ptrace.c:1278
 __x64_sys_ptrace+0xbd/0x110 kernel/ptrace.c:1278
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 copy_siginfo include/linux/signal.h:17 [inline]
 ptrace_getsiginfo kernel/ptrace.c:705 [inline]
 ptrace_request+0xf32/0x36d0 kernel/ptrace.c:1064
 arch_ptrace+0x435/0x680 arch/x86/kernel/ptrace.c:848
 __do_sys_ptrace kernel/ptrace.c:1305 [inline]
 __se_sys_ptrace+0x2d8/0x750 kernel/ptrace.c:1278
 __x64_sys_ptrace+0xbd/0x110 kernel/ptrace.c:1278
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 copy_siginfo include/linux/signal.h:17 [inline]
 collect_signal kernel/signal.c:596 [inline]
 __dequeue_signal+0x548/0xa00 kernel/signal.c:625
 dequeue_signal+0x14b/0xb10 kernel/signal.c:648
 get_signal+0xc3f/0x2d10 kernel/signal.c:2784
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x2a/0x140 kernel/entry/common.c:296
 do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_free_hook mm/slub.c:1770 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0x66f/0x1250 mm/slub.c:3831
 __sigqueue_free kernel/signal.c:460 [inline]
 collect_signal kernel/signal.c:603 [inline]
 __dequeue_signal+0x998/0xa00 kernel/signal.c:625
 dequeue_signal+0x14b/0xb10 kernel/signal.c:648
 get_signal+0xc3f/0x2d10 kernel/signal.c:2784
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x2a/0x140 kernel/entry/common.c:296
 do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 12-15 of 48 are uninitialized
Memory access of size 48 starts at ffff888115d6bc80
Data copied to user address 00000000016164e0

CPU: 1 PID: 5004 Comm: strace-static-x Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

