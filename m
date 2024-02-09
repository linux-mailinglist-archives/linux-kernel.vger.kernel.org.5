Return-Path: <linux-kernel+bounces-59776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C3084FBA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAD6289F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5882884;
	Fri,  9 Feb 2024 18:08:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736782882
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502110; cv=none; b=RxLFwMjhnNRacshSrdnOL5BdednhTtlYxQKW6MBbsmdAjubd4FJntCkQIE7Jf1ciMBIaTgfm3BcKN9X1mTYqt3eMU5nqLYcX/Xl1nuwCZH4sgPiJOA79CiO7SDTquwQyRq2P5S8/4dKjsGN7WjdvlGHPEvAjEdkO1eD+/u2f7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502110; c=relaxed/simple;
	bh=KSBN0A6XYgdQT+iJZm8f+FrWodQSl1aUPVRB+ICJRPs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BwhFTma5+BQqccdbuQS9jNKcW/Ki8NZHj364Buw8fUjCSzRWtPKLrbVRpNMZq34dtI5AflRQll1dMhzjofkM9wqhyecIWpHYZWrmMUsMyL/5vwUiuXP4tr6RfBNXConbCcmMOnDuzw63MgjkpN6mAIAduXI8H02xnGLTPcD2l8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363befae30fso9848965ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707502108; x=1708106908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJUSYsQSiAJ2Q2H05Qa4hh3ptPk68IOnsF68pOtDfKQ=;
        b=hnB9H+QzY4ooyjbsAV7Y5uqwiKNKzcs6xE3d5E1uJ6zVVsDMsC0hCP71MmwVR/1Ecc
         XvTE4FRV8zc5shFk/HivV6abGxW8agLa2lCcQ714Xti8FgylOa6yekMvQkYMdxt/1NRa
         BO0ADy+GhSzCFDPa57IAjjJ5oeVHBzoVzCaIPV/LgVsTzPnXBQ3sNFRsNcS6UxkbPQ74
         +HSIUya5MMLkgEpmZV95wEVCUvy2MFhtcD9cVE9m8nvHzVeCTNk4mymomQbvtpwp2Eoc
         yE4lBajyH8ZXOGIrJBNQJtD7G0T5tw2axQy3R/bqCCD2i097PFJ/ZmDz9DAG4feQ1jRW
         Ueow==
X-Forwarded-Encrypted: i=1; AJvYcCVDHuTKs538D2iJqU3uclCIuHsqEVuJCoPScO5STm3LF2LDBu63hxHAdOnGaq7yoqpSc99k2z9BP08rrauVP35rsbo7nVcQuhlALYf8
X-Gm-Message-State: AOJu0YytezZtinSXlCgjI5n8ZqKKXU53/8ZisjpQXF3BuV4tmk9oWLr0
	c8Ep17f1Mj7nK/nxSdqdUQSLwcpcCGYpIKrahANfuZQ4UVNiYv4TGNa74/uXZnl58HNrQab/0hm
	Kf3Nc1Z6KtCKobeTtIFCUK2NRbBajAzRaVTaG6v+fcosqMPrledunyD0=
X-Google-Smtp-Source: AGHT+IF8HuKhB6LoqTOL0PdMaazN+LWHXQurrc55rZgQlExeXobcInWDHXN3rny7v2s64KMvTN0cd7RQwjvA3Reo1ApyzGSQeUBW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd81:0:b0:363:cc38:db22 with SMTP id
 r1-20020a92cd81000000b00363cc38db22mr148752ilb.3.1707502107138; Fri, 09 Feb
 2024 10:08:27 -0800 (PST)
Date: Fri, 09 Feb 2024 10:08:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ca4ed0610f6d017@google.com>
Subject: [syzbot] [block?] WARNING in bdev_file_open_by_dev
From: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    445a555e0623 Add linux-next specific files for 20240209
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=147c85b8180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=96f61f1ad84e33cee93e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b1e20180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143db9f4180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9188bb84c998/disk-445a555e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ce0c98eabb2/vmlinux-445a555e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab801b1c1d6d/bzImage-445a555e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5075 at block/bdev.c:930 blk_to_file_flags block/bdev.c:930 [inline]
WARNING: CPU: 1 PID: 5075 at block/bdev.c:930 bdev_file_open_by_dev+0x112/0x270 block/bdev.c:963
Modules linked in:
CPU: 1 PID: 5075 Comm: syz-executor215 Not tainted 6.8.0-rc3-next-20240209-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:blk_to_file_flags block/bdev.c:930 [inline]
RIP: 0010:bdev_file_open_by_dev+0x112/0x270 block/bdev.c:963
Code: 04 b2 14 fd 44 89 e8 83 e0 02 75 23 44 89 ee 83 e6 01 45 31 e4 31 ff e8 ec b1 14 fd 44 89 e8 83 e0 01 75 18 e8 9f ad 14 fd 90 <0f> 0b 90 eb 12 e8 94 ad 14 fd 41 bc 01 00 00 00 eb 05 e8 87 ad 14
RSP: 0018:ffffc90003457b58 EFLAGS: 00010293
RAX: ffffffff847f2dc1 RBX: 0000000000000000 RCX: ffff8880786e9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801d0a8000 R08: ffffffff847f2db4 R09: 1ffff11003a1510b
R10: dffffc0000000000 R11: ffffed1003a1510c R12: 0000000000000000
R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555556bbe380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000785f2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 disk_scan_partitions+0x1be/0x2b0 block/genhd.c:369
 blkdev_common_ioctl+0x15cc/0x2880 block/ioctl.c:558
 blkdev_ioctl+0x532/0x740 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f07197090e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd2bd39c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffd2bd3b98 RCX: 00007f07197090e9
RDX: 0000000000000000 RSI: 000000000000125f RDI: 0000000000000003
RBP: 00007f071977c610 R08: 002364626e2f7665 R09: 00007fffd2bd3b98
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffd2bd3b88 R14: 0000000000000001 R15: 0000000000000001
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

