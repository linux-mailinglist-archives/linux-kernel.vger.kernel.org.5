Return-Path: <linux-kernel+bounces-40392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527083DF6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7108EB22E02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41A1EA71;
	Fri, 26 Jan 2024 17:03:46 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFD1D54B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288626; cv=none; b=aqDfoP6W9ZNsBLZ0Zfwv+N3YoULE6r6Wr7uwcv2kn7wEaRT685wGbwSDokYxKdowJyMSUMGjTBcEjeSdXT5j3tiB0ySbv4BlRWD5zf0L2JWR6o3A81r/eq/AiWkZpY2S6zfYiOwdy7EVSptkrbCTiik4Cpv+CEyVVW8uazFvY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288626; c=relaxed/simple;
	bh=BCsqXyGBB0OBeYF5RzKqwptg36ifxg03y/vHm/BgdkQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oTGR8eLjEKTj0nwbHEsYyF4IxjWIXFN3f3LK9RNNZHhaPbSUnGtlYgpkORgresRAsXqb91v2UDYCHCgoXz4M+5lbKa18/EkCPLY4FONMKk/m1gNU5kSBmWzya77/NjksgMAVGdwWVmUt1hHvHDqIwNR57kf2TIkzuYFrQXraTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bed8faf6a6so48889339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706288624; x=1706893424;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbuS6iDKomx2eTaC6CYYzJMQavSAmq9nmQbi/dTbIw4=;
        b=ErB/UleHVrlabMAzSqtwIlzGdDc6uZa05r0zdjULT3obaXQ25R8zCRmqDSpkLkyZH6
         iz2/3uHruqXP0dEaqrmK7BMvWm8g3wXoxyMAuUuuQNu8LI2fowPIBVp2bJAQIlNXXyLz
         HTBua1899m1+OKbbwmREAHpkqbCqZmZc1ikwqHTYiURGn0SardM3Za+Dv+SOaYeC7Mop
         biNxt28sI/hprE3bi2W1qDMHZg884hyVgpOyPLgoIX8+Tw/tMEiInJPsxmtp7p1Purup
         JB2aLPbH1w2+xxlGXyHrXk4WFZzvgEZmyfTt7HHfpLEVTdNw+q7BrkKgkuiKvyGdp6My
         iOZg==
X-Gm-Message-State: AOJu0YxTRgLpUlewjGUW6HaAtYTSJqaYFLv3CX0xMGj2m5C67sTFHlBs
	Yop/Z+AFVmf+ZFskhQiW39YA3GqFMLeqO+pQS6DWIdGitM5p8b83BC0E2LmliY5iwcpapsn1nq0
	1Sr5L2Vy7o+hXbL1PRWtvT7XBcCgIe5sAD6n+Hye4MdhCEiHx0V4e0aI=
X-Google-Smtp-Source: AGHT+IH28TS6pIcoKl5j9sPON6/cuvuVNyorbxvL7zrKR2odpGUYagrRyGbfVMpAjxBgz6aqQM3cgEQindSpHGVg0Aw+pdPv99r6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1526:b0:360:d7:186b with SMTP id
 i6-20020a056e02152600b0036000d7186bmr4933ilu.0.1706288623950; Fri, 26 Jan
 2024 09:03:43 -0800 (PST)
Date: Fri, 26 Jan 2024 09:03:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050a2fb060fdc478c@google.com>
Subject: [syzbot] [mm?] kernel BUG in resv_map_release
From: syzbot <syzbot+26dcc7b3798d5bfdfbc3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, leitao@debian.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bf1262c53f5 Add linux-next specific files for 20240124
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1267004be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4b59a824278780
dashboard link: https://syzkaller.appspot.com/bug?extid=26dcc7b3798d5bfdfbc3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166d5c80180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e89b27e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7696d711072d/disk-8bf1262c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92cd47c28072/vmlinux-8bf1262c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/add5c7493418/bzImage-8bf1262c.xz

The issue was bisected to:

commit 947b031634e7af3d265275c26ec17e2f96fdb5a1
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Jan 17 17:10:57 2024 +0000

    mm/hugetlb: restore the reservation if needed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177c4fc3e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14fc4fc3e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10fc4fc3e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26dcc7b3798d5bfdfbc3@syzkaller.appspotmail.com
Fixes: 947b031634e7 ("mm/hugetlb: restore the reservation if needed")

------------[ cut here ]------------
kernel BUG at mm/hugetlb.c:1129!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5066 Comm: syz-executor406 Not tainted 6.8.0-rc1-next-20240124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:resv_map_release mm/hugetlb.c:1129 [inline]
RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1114
Code: ab ff 48 85 db 75 1d e8 eb 37 ab ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c3 07 fb ff e8 ce 37 ab ff 90 <0f> 0b 4c 89 ef e8 83 76 05 00 e9 3d ff ff ff 48 89 ef e8 86 75 05
RSP: 0018:ffffc900033f7b40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e0f3fb
RDX: ffff88802b4e9dc0 RSI: ffffffff81e0f422 RDI: 0000000000000007
RBP: ffff88807faaa060 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8ae000e6 R12: ffff88807faaa060
R13: ffff88807faaa060 R14: ffff88801ea1e788 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2783df930 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kref_put include/linux/kref.h:65 [inline]
 hugetlb_vm_op_close+0x4f5/0x5d0 mm/hugetlb.c:5165
 remove_vma+0x8b/0x180 mm/mmap.c:141
 exit_mmap+0x511/0xbe0 mm/mmap.c:3282
 __mmput+0x12a/0x4d0 kernel/fork.c:1343
 mmput+0x62/0x70 kernel/fork.c:1365
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2ac0 kernel/exit.c:858
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fd2783fdc39
Code: Unable to access opcode bytes at 0x7fd2783fdc0f.
RSP: 002b:00007ffd48dc35f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd2783fdc39
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fd278478270 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000002012 R11: 0000000000000246 R12: 00007fd278478270
R13: 0000000000000000 R14: 00007fd278478cc0 R15: 00007fd2783cfa30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:resv_map_release mm/hugetlb.c:1129 [inline]
RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1114
Code: ab ff 48 85 db 75 1d e8 eb 37 ab ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c3 07 fb ff e8 ce 37 ab ff 90 <0f> 0b 4c 89 ef e8 83 76 05 00 e9 3d ff ff ff 48 89 ef e8 86 75 05
RSP: 0018:ffffc900033f7b40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e0f3fb
RDX: ffff88802b4e9dc0 RSI: ffffffff81e0f422 RDI: 0000000000000007
RBP: ffff88807faaa060 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8ae000e6 R12: ffff88807faaa060
R13: ffff88807faaa060 R14: ffff88801ea1e788 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2783df930 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

