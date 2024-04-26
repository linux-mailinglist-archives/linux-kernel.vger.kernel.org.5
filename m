Return-Path: <linux-kernel+bounces-159921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1828B3646
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3A8B22FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD36144D3A;
	Fri, 26 Apr 2024 11:04:38 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490461448DF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129477; cv=none; b=eImbGe51mPQKyBmlF7HdIA7O8vEIxiPcXtbi5NuGKt6j7nRJiN/z0lx2sBl3Tzsf+lPGCpx78i09J9E8B9WNYuIoW6m+iEHfsT7+4gvMYXX/rMeYUL68tWbYox8gKaj0rcF7hQk0s2w+wRx1dh6wZQthy5jR+3ngtgClcInd+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129477; c=relaxed/simple;
	bh=sfsJoZxQSWFGO6YIL6j+F7W4VxJutQawHdKEFeIlViw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jXednFJzzKZcvoGKViEvcB33+Dzd7Qq7Kgf0QFd/5C7ecSvPXs553uRkdg/cgBz00LomVq0e0Wien4ffPXkkIZS5F6HggS7zBGQtU7xw21pOxZ5QpoQADo/5X45TPoaTy586ti4LGDSEiw64h25w2RAJGVnZv/b7PP68wikZHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dabc125bddso208403539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714129475; x=1714734275;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96T6G7j+muiVvyjfPfVvzJDF6bpN9IPMSCr5jHjhvOs=;
        b=HWdRwhgyjOiOf42B3hxMr+XkNzrA6OgXpxQPO+ZbAcUShnva34XokCwpHLS2znOuAl
         CRQibcq6L9l5KwrvjUXN4YGIoJ7yKnts2adprF9hmql3lkGGfV33he3WdbPlMdFrNUzA
         IG0PIldFcXxN22CxGYaqObRxU3ut9NqaJPJtDOLK0o5NRl7E7brHq9BHK2lNq3DVgiZK
         CiJDAU/rIyKrttZiWJ+ukGnhIkY79TqArqAzU82VRACKQ2gHWFLMe5LsDAanO844sb9n
         4SO2hEhHK4uTUTfj6RvtsiyN+AsCmlZF0fp4zIu7Q0G4T19Ck6jIZbdqgvzaj/6DGMuR
         C5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFlOO8YyQWAeffndbT4ggixifstmXUUj30gvpLc0kVDeV5yswzGGRUiJACuN5ddAhRoR4cDhCkXk1K8ZYj8yGZ476nrEsgwSBPwH0V
X-Gm-Message-State: AOJu0Yw8rcCsBLHdzfZB5DM1LHGkuR3CRwA7pgfAj8opBr0TIl6o2Jnp
	PvW07PMkckBjAk5NbROp6oVeRzhoa0EE3/JC+csiQ8zV6pSwUQSPRI27V/D+fhAze4p+pbropxk
	vPVF8ErLPIC87LCyJp5JBMR4mMmFTt5Elh9Rw6oRo3///HgRfsWl/Uo0=
X-Google-Smtp-Source: AGHT+IGoQ4c4DdmeTiZMXV1mYTYQaKlTpqspTYrkcz9bVOL/1K8bYZn04qTheMtGMhqnGm642xOW5wuLD1KWvqM8J6lRBFh22ELf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:851e:b0:485:54ea:1d58 with SMTP id
 is30-20020a056638851e00b0048554ea1d58mr152555jab.5.1714129475614; Fri, 26 Apr
 2024 04:04:35 -0700 (PDT)
Date: Fri, 26 Apr 2024 04:04:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e4a2e0616fdde23@google.com>
Subject: [syzbot] [can?] KMSAN: kernel-infoleak in raw_recvmsg
From: syzbot <syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    71b1543c83d6 Merge tag '6.9-rc5-ksmbd-fixes' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1784bdd7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
dashboard link: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b440d3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b00907180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14813ccfbcb3/disk-71b1543c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7b88b42cf07/vmlinux-71b1543c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a64a5abfbba/bzImage-71b1543c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
 copy_to_iter include/linux/uio.h:196 [inline]
 memcpy_to_msg include/linux/skbuff.h:4113 [inline]
 raw_recvmsg+0x2b8/0x9e0 net/can/raw.c:1008
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x2c4/0x340 net/socket.c:1068
 ____sys_recvmsg+0x18a/0x620 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 x64_sys_call+0xf6c/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1313 [inline]
 alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
 sock_alloc_send_skb include/net/sock.h:1842 [inline]
 j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
 j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 x64_sys_call+0xc4b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 12-15 of 16 are uninitialized
Memory access of size 16 starts at ffff888120969690
Data copied to user address 00000000200017c0

CPU: 1 PID: 5050 Comm: syz-executor198 Not tainted 6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

