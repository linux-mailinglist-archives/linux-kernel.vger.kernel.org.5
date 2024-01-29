Return-Path: <linux-kernel+bounces-42600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFBC84039E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FC01F22EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D35BAD2;
	Mon, 29 Jan 2024 11:15:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7395BAD8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526941; cv=none; b=o2zLPdc01dUFYhzWq2el26Kg9pSSlw5qnOltDMSsjR9kZqeojCAgMky2lsP0uzq5lZcnfdLevPWufoTDHUnVr7P9iUG82iyKNUsmFWAC2DQauv4Q3CEeTynMWf/3enk9cLrnnLRUFnxHx0xDR6at5IGlZrORKbDFrhmAsmlC9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526941; c=relaxed/simple;
	bh=kOUlYic7Fn4tmPG/QHZOYrN/pkry6BjIpcGyJkSF12E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K6MUyrCyGsjW0Iq2aA7hJU3xET7gWmWOjfGfzqPBoPnjbb9igzyh4i8mwyxG8MLjkbopiQKxhBj/fqmiE+FJHR4rmclFCPiglIEInHhHt4v9w3jYcudd83JTYPIv1pDdUpwP+ptTY8d1cTQC5YeiO8h4soT4EVm4RKKNfFUjSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363887f15c2so284835ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526938; x=1707131738;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycDQ6Z9P2JkRi6wLH7pT3fZX69qKnXMvwBk2WNT/alY=;
        b=nyMh6gBYj4dpJaFhq+9Bzkh/ByAyLh6UrV7wlvHwA3AgH8gsLEjYMMy/2ltKd13hlU
         MaEEo1qYMocrTrTZa53dUq6Cb2EdKlh3n9omDyy3mmgJyWPsY3UnsB9HVHvTwYH9gCh4
         0mp4bcEsajWpLonTc6FRjexPcjFcpx7SAnjTliVh3FppuBA9uPos80JygpEPMywpey3L
         bFql9LEeQAU2ZfI+IzsUxV/k/v0rDDjCd6ipCYQp0ciG/ZVZ32Jw3o+9Ws+3Ul1tI+LW
         hUcOjzfKqeUXKwOZ93WPXaVBQ0rcbbNFUsdSbac5AEXJTRokTXwX7BuEHYG9/uKKd1u6
         jwiQ==
X-Gm-Message-State: AOJu0YwDIQLH+kWUy+OaGzX31uXWiP/ZQOcwv3TRVBJbLWjrsAzEBNsB
	ON3zVha60TuPfWSfofD6PW3M+xsh98guiWWsPU6zb9CELtRJY/Vm5CwmLPkO+KrRv71J+zSKHOD
	r4B9JaQI/85bbrd5H/0ErFJCMbCMbHg6xpXec1Bz8dfrt/9MvFifIoiU=
X-Google-Smtp-Source: AGHT+IFQIkVLb54/9JdZ/Ho960jFLmVYI3EuhujB8GBn5vCDmVPYpcBM+vVYMoO3oGrw4zD61NfxpGSpEaiszqEySMhxQLtEcO5v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170a:b0:363:820f:72b8 with SMTP id
 u10-20020a056e02170a00b00363820f72b8mr208755ill.1.1706526938621; Mon, 29 Jan
 2024 03:15:38 -0800 (PST)
Date: Mon, 29 Jan 2024 03:15:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9f23d061013c383@google.com>
Subject: [syzbot] [mm?] kernel BUG in validate_mm (3)
From: syzbot <syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    596764183be8 Add linux-next specific files for 20240129
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=142042f3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=584144ad19f381aa
dashboard link: https://syzkaller.appspot.com/bug?extid=39a72b995ba73633c1a7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11844ba7e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bd01efe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b647c038857b/disk-59676418.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/729e26c3ac55/vmlinux-59676418.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15aa5e287059/bzImage-59676418.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com

arg_start 7fffd9277efb arg_end 7fffd9277f14 env_start 7fffd9277f14 env_end 7fffd9277fdf
binfmt ffffffff8d9c5c00 flags 80007fd
ioctx_table 0000000000000000
owner ffff88802c0cda00 exe_file ffff88801ff60500
notifier_subscriptions 0000000000000000
numa_next_scan 0 numa_scan_offset 0 numa_scan_seq 0
tlb_flush_pending 0
def_flags: 0x0()
------------[ cut here ]------------
kernel BUG at mm/mmap.c:328!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5058 Comm: syz-executor310 Not tainted 6.8.0-rc1-next-20240129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:validate_mm+0x3f3/0x4b0 mm/mmap.c:328
Code: 0f 84 a4 fd ff ff e9 47 ff ff ff e8 77 91 b9 ff 44 89 f2 89 de 48 c7 c7 e0 af 19 8b e8 56 69 9b ff 4c 89 ff e8 ce c4 fa ff 90 <0f> 0b e8 56 91 b9 ff 0f b6 15 1f dd b1 0d 31 ff 89 d6 88 14 24 e8
RSP: 0018:ffffc900035df958 EFLAGS: 00010282
RAX: 000000000000032a RBX: 000000000000000d RCX: ffffffff816e2f59
RDX: 0000000000000000 RSI: ffffffff816eb7e6 RDI: 0000000000000005
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 00007fffd92ff000
R13: 0000000000000000 R14: 000000000000000e R15: ffff88802c6b8000
FS:  0000555557046380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10ada208a0 CR3: 000000007b434000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_merge+0x16a9/0x3d70 mm/mmap.c:1033
 vma_merge_new_vma mm/mmap.c:2465 [inline]
 mmap_region+0x206b/0x2760 mm/mmap.c:2841
 do_mmap+0x8ae/0xf10 mm/mmap.c:1380
 vm_mmap_pgoff+0x1ab/0x3c0 mm/util.c:573
 ksys_mmap_pgoff+0x425/0x5b0 mm/mmap.c:1426
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f10ad9e52a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd9276338 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fffd9276518 RCX: 00007f10ad9e52a9
RDX: 0000000000000001 RSI: 0000000000002000 RDI: 0000000020ffc000
RBP: 00007f10ada58610 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffd9276508 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:validate_mm+0x3f3/0x4b0 mm/mmap.c:328
Code: 0f 84 a4 fd ff ff e9 47 ff ff ff e8 77 91 b9 ff 44 89 f2 89 de 48 c7 c7 e0 af 19 8b e8 56 69 9b ff 4c 89 ff e8 ce c4 fa ff 90 <0f> 0b e8 56 91 b9 ff 0f b6 15 1f dd b1 0d 31 ff 89 d6 88 14 24 e8
RSP: 0018:ffffc900035df958 EFLAGS: 00010282
RAX: 000000000000032a RBX: 000000000000000d RCX: ffffffff816e2f59
RDX: 0000000000000000 RSI: ffffffff816eb7e6 RDI: 0000000000000005
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 00007fffd92ff000
R13: 0000000000000000 R14: 000000000000000e R15: ffff88802c6b8000
FS:  0000555557046380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000664740 CR3: 000000007b434000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

