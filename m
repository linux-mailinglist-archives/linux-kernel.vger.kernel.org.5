Return-Path: <linux-kernel+bounces-109640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250E0881BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C981C210DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903F8D533;
	Thu, 21 Mar 2024 04:04:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA53C8DD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993866; cv=none; b=al36C1quxa+xV72K1Aj39UxhSVBFww8RtB7h6rlDu4LhWtlKkEQYa6zhfotdkIzNb2wv+PMY1egAsuUw7S/ft/7nMZbgjkikRdrKQQ5QVjSGFDgKtGIpjdxIjMPq9nlkOl1MCLSSEFIvqHMU+7WCjbwMLIeNjWqktZbSb97NzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993866; c=relaxed/simple;
	bh=z8kelRcQLfPHXxdv8BDjPeC6bTlw3ySDChzBqljKi+s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QkA1eWkPeTxaOjSc9IPRIxVJL1rF8HfmHP726ZbcTSh6Hnn4jcSx/pW/lsTAbUWI/SMAy+kGRtAlIH7XwDB65/X0+YD+OlXvpDGRh4gNiSjQ84gR3NaIzWkPrGijiK3ELK+vUwdvnAkqzIFqJLQwt+rjFHbI69sl3vJBg6l9HzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so45428839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710993863; x=1711598663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze7pScqmttd08u401NsE35waZFhqUwBemOvcE4kIuZo=;
        b=IpiHKAisa9dWaQncUwO8L3xuOgdUGIZqnpVm6VPi/ZsTYwMidFpET7K5OVqNbZXYVT
         FTwMukHhlq1+5fVdNLiyrGA3YWTYjfmXmS2/1zS1zYqOU4e69lb2DRK7Upqwb2lmDENF
         4dVm6H1bh2IA3gFb92JPxgFY+rbez4XL5zDyVrWDuXJ49wymy9wcGpigkzOzQVM1JgfR
         wC5okJN7Tpc9X7L7GYDS2WOc4iOBs+GBSGVe877R/9dncR2JwwUMCrQggWQ973cTqYik
         jpHXy2wA7LzFvgG7uMESv1ZGWNmwRQS4mZMjeeagthvK55HynKNtYgLpf2gx2eTazx1z
         AELQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPKqC6FMn5D6xCD44JIM3KuudAXtai946nCzd4ogx7A8pVFLNxmJUHMEAyIue4Rdd7VEDkXtyhLBYyAKmZngTCC0PsF6iD6Bk0QScr
X-Gm-Message-State: AOJu0Yzn/8qX7wPl/o1z1hU+TvADN2JYSB2C8iKVPmtgh4r1HPLqP7F2
	cDGjO/nkaBETgOaJwzgi6IbONoaZpSGhVQBxKGEaJ2uYS+PpuHJQtXbIZpaZ6inJMTeFykzQj6t
	wMfe1PlED4PH89nfcxEtMbqV89Kalbf3MuP5szQOIalfPm21hvh/Qp2w=
X-Google-Smtp-Source: AGHT+IGHnZr9WAy0fXFR+27NR+3TxjGd0osQBBaXNa8QNrDvyJsx7hXAy+HAonpm4PQLBwJkQwFwsUK7gYaO1SeprY9/VWyn4Ic+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2409:b0:474:c3b5:a8b7 with SMTP id
 z9-20020a056638240900b00474c3b5a8b7mr1330109jat.6.1710993863141; Wed, 20 Mar
 2024 21:04:23 -0700 (PDT)
Date: Wed, 20 Mar 2024 21:04:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cfe98061423cde7@google.com>
Subject: [syzbot] [mm?] kernel BUG in const_folio_flags
From: syzbot <syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78c3925c048c Merge tag 'soc-late-6.9' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1267d879180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3c2635ded15fbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=3b9148f91b7869120e81
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-78c3925c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf2bceeccde3/vmlinux-78c3925c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc938dfaea6d/bzImage-78c3925c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com

 veth_newlink+0x627/0xa10 drivers/net/veth.c:1895
 rtnl_newlink_create net/core/rtnetlink.c:3494 [inline]
 __rtnl_newlink+0x119c/0x1960 net/core/rtnetlink.c:3714
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3727
 rtnetlink_rcv_msg+0x3c7/0xe60 net/core/rtnetlink.c:6595
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:315!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 42 Comm: kcompactd0 Not tainted 6.8.0-syzkaller-11725-g78c3925c048c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:const_folio_flags+0x1bd/0x1f0 include/linux/page-flags.h:315
Code: 41 83 e4 01 44 89 e6 e8 b1 e6 a9 ff 45 84 e4 0f 85 c4 fe ff ff e8 23 ec a9 ff 48 c7 c6 e0 07 1b 8b 48 89 ef e8 34 2e ed ff 90 <0f> 0b e8 8c 6b 06 00 e9 66 fe ff ff 48 89 ef e8 7f 6b 06 00 eb b6
RSP: 0018:ffffc9000068f7f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9000068f698
RDX: ffff88801744c880 RSI: ffffffff81e4265c RDI: ffffffff8b6f0060
RBP: ffffea0000a04c00 R08: 0000000000000000 R09: fffffbfff1f3deca
R10: ffffffff8f9ef657 R11: 0000000000000000 R12: 0000000000000000
R13: ffffea0000a04dc0 R14: 0000000000028137 R15: ffffc9000068fbe8
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe623b9138 CR3: 000000001c22c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_test_hugetlb include/linux/page-flags.h:875 [inline]
 PageHuge+0x219/0x2b0 mm/hugetlb.c:2174
 isolate_migratepages_block+0x4a0/0x5110 mm/compaction.c:1004
 isolate_migratepages mm/compaction.c:2182 [inline]
 compact_zone+0x1a5c/0x4280 mm/compaction.c:2629
 kcompactd_do_work+0x340/0x720 mm/compaction.c:3100
 kcompactd+0x8d7/0xde0 mm/compaction.c:3199
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:const_folio_flags+0x1bd/0x1f0 include/linux/page-flags.h:315
Code: 41 83 e4 01 44 89 e6 e8 b1 e6 a9 ff 45 84 e4 0f 85 c4 fe ff ff e8 23 ec a9 ff 48 c7 c6 e0 07 1b 8b 48 89 ef e8 34 2e ed ff 90 <0f> 0b e8 8c 6b 06 00 e9 66 fe ff ff 48 89 ef e8 7f 6b 06 00 eb b6
RSP: 0018:ffffc9000068f7f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc9000068f698
RDX: ffff88801744c880 RSI: ffffffff81e4265c RDI: ffffffff8b6f0060
RBP: ffffea0000a04c00 R08: 0000000000000000 R09: fffffbfff1f3deca
R10: ffffffff8f9ef657 R11: 0000000000000000 R12: 0000000000000000
R13: ffffea0000a04dc0 R14: 0000000000028137 R15: ffffc9000068fbe8
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe623b9138 CR3: 000000001c22c000 CR4: 0000000000350ef0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

