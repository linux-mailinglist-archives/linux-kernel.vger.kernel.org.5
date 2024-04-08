Return-Path: <linux-kernel+bounces-135030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97A89BA2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133331F21F2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A223BB20;
	Mon,  8 Apr 2024 08:26:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97948383BF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564779; cv=none; b=LnADyD+xF6P3gx20KC5nUwwhbgjcy0V3ijXGOBm+nanYHA3+/t0iI+cWIYLQdDw9pPnGZRy5rr4qWrryAudjnpm+9PdqvYTUL9u42y+43YY53dqMOFD17E2GNFvvHT7NIwz6E/Z1VHCaZg6vGPTut59wIT8Y4bvK+WTu2xjrGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564779; c=relaxed/simple;
	bh=ahM4sKjAO5edlda9Nas7d9FHNATVhvUe8SVagNj7Ljc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eB3K9lcLashrw3jKUt+gO1m+VIkqgUf7MT57fDZVUTKac5EL9ByJ6/3rLtJGkSFUl4Dz9iDjqWVMhfIopvts/vlTlkYtG6pCQLA8KGSmqBUTjL23FzjRluwu+PQmiM7B+bG5RGdR05rl8pc+FYU4d261Ypj6XKQIdOc88Fwtpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5db4db530so155006639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564776; x=1713169576;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfdopbNRnLcAIOo/lZmMzRZy7zUBvqfghCeWaQ4eHOc=;
        b=qIZ4Pz1PWGE1273+zNW1Qc3gh6oNmDohV0E00Vyy+HlSICLpXSThjzL93E5igcSCKt
         bz7VTd+STz6h4St4Plt5i3s9smnCqKmshyBBR46zeY24Lg5if6cHtkgGSuCC438W3ssk
         38wSIMFGiIY5pVK9PVy9/kfRhvD9s/LOGol7AVSH2q1K2vI05THdgiYp7jUBmSnt2RhK
         2QuMGaK6lrqFycyAdQJ86Ko6XratXGXe/ZxhAwkqkO3JK+iRJ9+yRAqQq4LcuNn4TMFW
         w60+zyPAs3K8FV3P+nX3sRCKi8/WWkusb77NBIlsHBH9/NQglKB1tCTZmRXkQrNIaU4V
         BRhw==
X-Forwarded-Encrypted: i=1; AJvYcCU6mBNnY98+bNmcQAE6QHeh3SEmmzc85ajFh9Tnpz6PcKFz7fT81OzaYN61H4q3IotB7xlRAxVFxybLis6lsYtBv+pqrBmGQOwg9mDx
X-Gm-Message-State: AOJu0Yzkreo7qoeobkRVuYnkj41vagMbRL7zqrEfncNM2+iXGVxQ8FzH
	8J5ngbE2tbmqiAuZVHv21EQmXsrMnzpyOBKJyrCYyha2jHPvuh74QGNxfjzuFxFqqV1Fwn4vif3
	/mD26dX5HvUqIcSLONcRcu1DyEvCJg5e9ezXT23yguP9cnB8hUcXXO9o=
X-Google-Smtp-Source: AGHT+IEpeVW55jmEl2YOLeVKfr7DvxEny6izV9a/c9NTXptaDyenFLwYqqno/aa2269MRFFfRh58WqOwclGdY8YNj9gpkev6O3Re
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a86:b0:36a:2a29:5b46 with SMTP id
 k6-20020a056e021a8600b0036a2a295b46mr43661ilv.5.1712564776816; Mon, 08 Apr
 2024 01:26:16 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:26:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d631f0615918f1e@google.com>
Subject: [syzbot] [fs?] [io-uring?] general protection fault in __ep_remove
From: syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, io-uring@vger.kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f55413180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=045b454ab35fd82a35fb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101db623180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10801175180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5075 Comm: syz-executor119 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__ep_remove+0x13a/0x780 fs/eventpoll.c:825
Code: 89 e7 49 c1 ef 03 41 80 3c 2f 00 74 08 4c 89 e7 e8 8b 81 d9 ff 4d 8b 34 24 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 68 81 d9 ff 49 8b 1e 48 8b 04 24 48
RSP: 0018:ffffc90003b6fa78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: dffffc0000000000
RDX: ffff88807a310000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff821ec2a4 R09: fffff5200076df40
R10: dffffc0000000000 R11: fffff5200076df40 R12: ffff88802916cbb8
R13: ffff88802916ca00 R14: 0000000000000000 R15: 1ffff1100522d977
FS:  00007f034c6ff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000004 CR3: 00000000775ec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 eventpoll_release_file+0xdb/0x1c0 fs/eventpoll.c:1071
 eventpoll_release include/linux/eventpoll.h:53 [inline]
 __fput+0x6d7/0x8a0 fs/file_table.c:413
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 get_signal+0x1673/0x1850 kernel/signal.c:2683
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:212
 do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f034c84c059
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f034c6ff178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f034c8f0038 RCX: 00007f034c84c059
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f034c8f0038
RBP: 00007f034c8f0030 R08: 00007f034c6ff6c0 R09: 00007f034c6ff6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f034c8f003c
R13: 0000000000000002 R14: 00007f034c9ffc40 R15: 00007f034c9ffd28
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__ep_remove+0x13a/0x780 fs/eventpoll.c:825
Code: 89 e7 49 c1 ef 03 41 80 3c 2f 00 74 08 4c 89 e7 e8 8b 81 d9 ff 4d 8b 34 24 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 68 81 d9 ff 49 8b 1e 48 8b 04 24 48
RSP: 0018:ffffc90003b6fa78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: dffffc0000000000
RDX: ffff88807a310000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff821ec2a4 R09: fffff5200076df40
R10: dffffc0000000000 R11: fffff5200076df40 R12: ffff88802916cbb8
R13: ffff88802916ca00 R14: 0000000000000000 R15: 1ffff1100522d977
FS:  00007f034c6ff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000004 CR3: 00000000775ec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 e7                	mov    %esp,%edi
   2:	49 c1 ef 03          	shr    $0x3,%r15
   6:	41 80 3c 2f 00       	cmpb   $0x0,(%r15,%rbp,1)
   b:	74 08                	je     0x15
   d:	4c 89 e7             	mov    %r12,%rdi
  10:	e8 8b 81 d9 ff       	call   0xffd981a0
  15:	4d 8b 34 24          	mov    (%r12),%r14
  19:	4c 89 f0             	mov    %r14,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 68 81 d9 ff       	call   0xffd981a0
  38:	49 8b 1e             	mov    (%r14),%rbx
  3b:	48 8b 04 24          	mov    (%rsp),%rax
  3f:	48                   	rex.W


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

