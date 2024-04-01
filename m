Return-Path: <linux-kernel+bounces-126869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05230894238
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60020B2143B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D411DFF4;
	Mon,  1 Apr 2024 16:50:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602B8F5C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990234; cv=none; b=rPMU/puHrL2UmtuKW3AxXRxYZGq3E79DK8iN3C6KjxZvHNu6ko91yg3hFGXbdb6Eyq2j3JpKyYrBFNQVXg3UixcnwK55jN5AkDBC5MwHmkMEadgOPmtJtPA7x/RithD+qoUUMBUVdAeix8NKAhaJx30AYzwfCjfkGBevGVuM+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990234; c=relaxed/simple;
	bh=NFz6uX3N7nspx/s7UIoJTX1mmT74lzGz+t+yOrtAoow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=apL0pMkb4K5AKENIKKFhAbg5Ap2xdRQJUieIxIvePOQfWhLTXHqqrxYAxP67t/oSKEDOIVTZRFAGTaxE3WOKldlTagFxEEu3n7UUMhap9WFG+ipw/ZHmkvj397nusfmdakNHhqHazm8blASLqK+HVSMeHK0RRUl7psDy9L2j9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso458162639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 09:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990232; x=1712595032;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96XoJ68f1pPqwTDxiK/2e2U+1D+SyMpCFNl1YhjT6fQ=;
        b=GopEzppx9vJGCtORXYo992R/W8ueC2L4vZESEx0UGLvBG+/fnDmE7ycD/0SAWCiBZR
         ZiLrT2/4r09fHPCMtk1NUfEtjJUlcNz9HScvSk+GPwmP2/hXvglli1s8MsemtsAbwaU8
         wJ+6e9aND9VdfhnmYgDkXFyNXsxmdCpXV1N6vEKT5udhPSQIYZdrBDeisFXC7Hr/9DTS
         v3Eapr7A5xDrMDq/mI/3gMmTPAR8Z2+0QrVXINCw7auq2eUhtf751YZzUcgHK4HDhXe/
         9YjaKaC9XbYacPoicM1tVQzvQr8z5zWSqIclkx1V55FKBfsvwHr7A+HVW3xUD/MoNJTU
         pGdA==
X-Forwarded-Encrypted: i=1; AJvYcCUEB2NrGtIiw9MErr1AXr7gKC0dnp1KbTRhIs9TU/6FQ0K9iSZYOp3YbrPFqFM8yitpATBJzuwNsUK/aUbE8U1k7RBwFouoyoZZX5Ln
X-Gm-Message-State: AOJu0YxIdCFsC2ygw8N17RVV6ttG1J00CdzE/mtsj/b6NtDERuZqSycd
	JmuIbP/gr6osm//YMMMu7aNX4n0rc8QIKflK1hN0buSVMcajFXaXGiYrOJVOWRDb4TolCR+e9dN
	CocuM3S0rK1kRkSp7cb9+6PPympi8yHVKoJA4n1jsW+gMpsgYqJkS+58=
X-Google-Smtp-Source: AGHT+IHR6c+wQHslbg0c7R9/cPyUhDGzVcOXV8UfRmOHW/ICv4OnBfWeEfxxSqh3v6VjgZj15PfPmNOOOR1vcwQ2JZ0EPcNlVhMT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:368:9aaa:2920 with SMTP id
 cd7-20020a056e02320700b003689aaa2920mr593010ilb.6.1711990232310; Mon, 01 Apr
 2024 09:50:32 -0700 (PDT)
Date: Mon, 01 Apr 2024 09:50:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7f84306150bc9d5@google.com>
Subject: [syzbot] [mtd?] WARNING: zero-size vmalloc in ubi_read_volume_table
From: syzbot <syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com>
To: chengzhihao1@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, richard@nod.at, 
	syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10223ae5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=f516089d7815b10197c9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13668b21180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a6e21d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com

ubi0: scanning is finished
ubi0: empty MTD device detected
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5062 at mm/vmalloc.c:3319 __vmalloc_node_range+0x1065/0x1540 mm/vmalloc.c:3319
Modules linked in:
CPU: 0 PID: 5062 Comm: syz-executor167 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__vmalloc_node_range+0x1065/0x1540 mm/vmalloc.c:3319
Code: 48 8b 7d 08 e8 bc db ff ff 48 39 c5 0f 85 f3 02 00 00 e8 5e 9e b2 ff 48 89 ef e8 26 8f 02 00 e9 c2 f9 ff ff e8 4c 9e b2 ff 90 <0f> 0b 90 31 db e8 41 9e b2 ff 48 b8 00 00 00 00 00 fc ff df 4d 8d
RSP: 0018:ffffc900033df918 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81da4ac2
RDX: ffff88801976da00 RSI: ffffffff81da5a64 RDI: 0000000000000007
RBP: ffffffff85f10bf9 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8ae00126 R12: 0000000000000000
R13: 1ffff9200067bf3e R14: 0000000000000000 R15: ffff88802ef1a600
FS:  000055556b89e380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045e620 CR3: 0000000022954000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __vmalloc_node mm/vmalloc.c:3457 [inline]
 vzalloc+0x6b/0x90 mm/vmalloc.c:3530
 create_empty_lvol drivers/mtd/ubi/vtbl.c:490 [inline]
 ubi_read_volume_table+0x639/0x2a30 drivers/mtd/ubi/vtbl.c:812
 ubi_attach+0x1a2f/0x4af0 drivers/mtd/ubi/attach.c:1601
 ubi_attach_mtd_dev+0x1659/0x3950 drivers/mtd/ubi/build.c:1000
 ctrl_cdev_ioctl+0x339/0x3d0 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fbab2531369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb56bd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcb56bd298 RCX: 00007fbab2531369
RDX: 0000000020000504 RSI: 0000000040186f40 RDI: 0000000000000003
RBP: 00007fbab25a4610 R08: 0000000000000000 R09: 00007ffcb56bd298
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcb56bd288 R14: 0000000000000001 R15: 0000000000000001
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

