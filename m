Return-Path: <linux-kernel+bounces-125565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA58928C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2069283868
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407D187F;
	Sat, 30 Mar 2024 01:29:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1D1860
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711762164; cv=none; b=I8B6o/r35ChAIQUKPezpIz0mZhXzqupns1Y1WAow3dI5Zm2yz9sCJ6NXHSk3ZvXLsfVVpA6d2ObsWWCuxiIvO3cvAIWm6KpRtlIp0S627bRYYjaYtYdv+fVvcwm/j9gFK+lgAliJ9W3z37ezzJfdQV5b3Md6I+8IWhTICVFFBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711762164; c=relaxed/simple;
	bh=IjSBM+uXjKiBCu+yKAxKLyGwFCLDz0lWY2d7H0Amq9E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bv+Y9sqS2FUH58nO7G7Vssr1rTD/HfIXzZhd2ZIzVx3LvkYT0i1GvjxNprtaD74Tp3oN3Z52RW7E2WDRlwIptGgcYbIuiX0gGT2iRWEu0cuVWpNM+uga/KL16l33mW28fh3s8CznK+am85aVK2MMxLPmA6A/kNRUPL6Gd1sHiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so184435439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711762162; x=1712366962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kQrU1bQ/LODeQo16FbQE2Dz4aGmc8+6AVxyILQVj8U=;
        b=t5d7zDAGT/9xJQUX8ju31mRj7q85zByG1UEeKQlQb4wS1WrnAOb9rP8CDYlN+HMAAj
         I6nQvGaPurMMCuG1LMpZ821JQmzCh9UPZxTwUU/PlUjqxT10FTQGFi6duey/MO+RbS4c
         QVwgshHU83cnDzhYCNiYXa4BydNZNLW5xROs2tkueYWZ9J5pXvYf//sIMIhg6s4jFz6P
         2BPpIIA5ynKxGWlVtjtBHhxjB/XcHsjibw+Bwn7H2WjeMWnuYYebexrTN4MUgySNSoxX
         YvnRgbVfnl0uqJa3olxjvCg7lbaE3ChwxsjlYUqbUQYpNScI0XCDCvy9bNQwscxaJGCd
         C3OA==
X-Forwarded-Encrypted: i=1; AJvYcCVSXc4ZTJSP+JfDJlXhkOOt1t4nFo8sMP+sHWEyt614IYlCZ0ZaOVI52BDFGOlLPCgUfn5amDJLxQwCedLonlo+5mIVVlEcN62o0/id
X-Gm-Message-State: AOJu0Yyg3PJ/Q3zmZFde3VIjmXzoVPUZREbHEvsE6obhtMif5GChmM/G
	vtycGjGzyfMRMa1o5Kjp8vWcH9IA5JBjq0Kb5MWdr7lz0tDyMTGRHG4RiC0GgwlncFPaKKHubHx
	iu0jaN06c0QNabap33JWXBTvbI7tSBUr74iXAKKmHbFdHEEgw2beRfkY=
X-Google-Smtp-Source: AGHT+IHheq7bSHBl8EU3v9cUQC4IwLMvT9cdG1ogxYZgOCFOvrBMO/7QNa/8SVrDfxLA9RhUfz6ApvxofAtpUyRRQTckyCG/ymxU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410d:b0:47c:1840:ad8 with SMTP id
 ay13-20020a056638410d00b0047c18400ad8mr237459jab.1.1711762162159; Fri, 29 Mar
 2024 18:29:22 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:29:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009da21f0614d6af2e@google.com>
Subject: [syzbot] [kernel?] WARNING in switch_mm_irqs_off (2)
From: syzbot <syzbot+6096471e27db19305af0@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4535e1a4174c x86/bugs: Fix the SRSO mitigation on Zen3/4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103340c5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=6096471e27db19305af0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-4535e1a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af9b780d5ab6/vmlinux-4535e1a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca7710536ebc/bzImage-4535e1a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6096471e27db19305af0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4685 at arch/x86/mm/tlb.c:515 switch_mm_irqs_off+0x890/0xbc0 arch/x86/mm/tlb.c:515
Modules linked in:
CPU: 0 PID: 4685 Comm: udevd Not tainted 6.9.0-rc1-syzkaller-00206-g4535e1a4174c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:switch_mm_irqs_off+0x890/0xbc0 arch/x86/mm/tlb.c:515
Code: ff 44 8d 6b 02 48 63 d3 49 8d 8e 18 06 00 00 4d 63 ed 49 c1 e5 04 4d 8d 8d 80 d8 03 00 49 81 c5 88 d8 03 00 e9 75 fd ff ff 90 <0f> 0b 90 e9 e3 f7 ff ff 90 0f 0b 90 e8 df f5 ff ff e9 20 f8 ff ff
RSP: 0018:ffffc90006f27918 EFLAGS: 00010202
RAX: 0000000000000282 RBX: ffff88802a820000 RCX: ffff88802ce84280
RDX: 1ffff110059d092a RSI: ffffffff8b8f4760 RDI: ffffffff8b8f47a0
RBP: ffff888026402f80 R08: 0000000000000000 R09: ffffed10059d0869
R10: ffff88802ce8434b R11: 0000000000000002 R12: ffff88806b03f500
R13: ffff88804841a440 R14: ffff88802ce84280 R15: ffff88806b03ea40
FS:  00007f7782acf280(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc60856070 CR3: 000000002a050000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5393 [inline]
 __schedule+0xd2b/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_hrtimeout_range_clock+0x20f/0x430 kernel/time/hrtimer.c:2312
 ep_poll fs/eventpoll.c:2026 [inline]
 do_epoll_wait+0x13d4/0x1ae0 fs/eventpoll.c:2428
 __do_sys_epoll_wait fs/eventpoll.c:2440 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2435 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2435
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f7782723457
Code: 73 01 c3 48 8b 0d d1 d9 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 76 48 8b 15 a2 d9 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc9442f898 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffc9442f998 RCX: 00007f7782723457
RDX: 0000000000000008 RSI: 00007ffc9442f998 RDI: 000000000000000b
RBP: 000000000000000b R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000bb8 R11: 0000000000000246 R12: 0000000000000bb8
R13: 0000000200000001 R14: 0000000000000000 R15: 0000000000000000
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

