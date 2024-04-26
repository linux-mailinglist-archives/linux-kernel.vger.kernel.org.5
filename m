Return-Path: <linux-kernel+bounces-159967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCA8B36EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C6E1F22E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC4145B3E;
	Fri, 26 Apr 2024 12:10:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6702145355
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133434; cv=none; b=bBEbeN+73R/G/l2ooVNR50lVgifYdXnG/QtQBLgTGOKQC6NG2GLZDfvEFeWuAUHxOcag6wRKZFMWuc/URGOgr1MGRPQxI3z6xFl3djd67JHZUNUH/7MHATNvmLLz/tsaNjNjfwzJ+bFDG0lZXiH+6j1mve9MPWkIuRjrguaF2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133434; c=relaxed/simple;
	bh=VDak55zfLn9yH98huhlZNYU5hK4qGuSisAUpSY2QKnc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kgo4ErXA+KuRI5Xp1L0xZoZuhMDpTfxC7AHr+JEC9lrxLdvvU9aOtiP80zcVWjVJJeQWtVrqQaT/X13C4ZpidLPLwfha7wBXdh/bskOE1fK1w+jyGbeiQVMmUyM+Ny2s/de/MQIxxfI86In9gYhske9YAO1OkPYY9nd2A6HIJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d667dd202cso208113539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714133432; x=1714738232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UdzRBinvaLIUGUBa8Qs3FzTYEcAEXl0i7GmgW4GMdE=;
        b=E/8H94ZBmdVjSQESKjStGovJBsYeTKFytqprpXZjY3Awn+JKxwbB8N37EwyWVVSRqV
         xzw0AvF9KNamqsBoYZQckEAZzwIliDCeLZpm0lImCPrqfpWa/WUvnvPyr84BLQJn1J1p
         aZmgUIXhFSkmdGCwk64vzI6P5F5yHrJ2sb1d0PFGDcdlg2q5zig9SHwV6Xxrc12V/QXN
         lvuJ8ZCHI1/tV5WSOzI3eeRFABCJIN+PB0Uv45SsikBf6FP+5NGy45H3yFOIuzr+SS2l
         2Re0Zd8aZmIwQA1eD8WCIUaGV7ecLMSWGDTfKypJPgkdxQ8vtBHHtm6LL0uVJWCS89yS
         +wdw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ073VkbkYZdom71dfw1ll+QNh7TjMFoUwge9jazFk+ml/SHElsZdJYt0hDVMmAIMjIuXcy01SCFz1mxfnvVIGYmexbcft0PIxIN1B
X-Gm-Message-State: AOJu0YzQw75atyrzD7bjmEDLikTjr8J6GOOxfVkGwl8zUukeV2FdmQjY
	lWE4RyOgF1wc2M7pf1oIPqvztiBE/Bt3fQDSGeGYvvCynuZFyRHVDeGgJbMeVskiHh+U4wLvHKY
	AVduwsXsX0F9gc3myIEDt0PVMbus9WKtFwVLcg04eA7MXuEZ/338iYPQ=
X-Google-Smtp-Source: AGHT+IFavDCbEhFNVt/bk1n8KNjEVZOqlg4ILJAKbnXFWR+MljzAEqiFXZY+t1oxmWtl55qVTgM50Xik79tvs3G0NHE7Gk1Td9gd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:36b:26df:cce0 with SMTP id
 u15-20020a056e02170f00b0036b26dfcce0mr151937ill.0.1714133432185; Fri, 26 Apr
 2024 05:10:32 -0700 (PDT)
Date: Fri, 26 Apr 2024 05:10:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052c1d00616feca15@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_recv_frame
From: syzbot <syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2bd87951de65 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1655ccef180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ced800a6af0f5b0
dashboard link: https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/167fa7ed263b/disk-2bd87951.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5451b036870/vmlinux-2bd87951.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0d784e076f2/bzImage-2bd87951.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 14307 at kernel/workqueue.c:2322 __queue_work+0xc6c/0xef0 kernel/workqueue.c:2321
Modules linked in:
CPU: 0 PID: 14307 Comm: syz-executor.2 Not tainted 6.9.0-rc5-syzkaller-01160-g2bd87951de65 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__queue_work+0xc6c/0xef0 kernel/workqueue.c:2321
Code: ff e8 48 38 36 00 90 0f 0b 90 e9 20 fd ff ff e8 3a 38 36 00 eb 13 e8 33 38 36 00 eb 0c e8 2c 38 36 00 eb 05 e8 25 38 36 00 90 <0f> 0b 90 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc900034f78a0 EFLAGS: 00010093
RAX: ffffffff815fc90d RBX: ffff88802a579e00 RCX: ffff88802a579e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815fbdd3 R09: 1ffff1100f64b9ac
R10: dffffc0000000000 R11: ffffed100f64b9ad R12: ffff888068ebd9c0
R13: dffffc0000000000 R14: ffff888068ebd800 R15: 0000000000000008
FS:  000055557f1bb480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0909aba170 CR3: 0000000079f8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
 queue_work include/linux/workqueue.h:605 [inline]
 hci_recv_frame+0x489/0x610 net/bluetooth/hci_core.c:2998
 vhci_get_user drivers/bluetooth/hci_vhci.c:521 [inline]
 vhci_write+0x35a/0x480 drivers/bluetooth/hci_vhci.c:617
 do_iter_readv_writev+0x5a4/0x800
 vfs_writev+0x395/0xbb0 fs/read_write.c:971
 do_writev+0x1b1/0x350 fs/read_write.c:1018
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0909a7dc9d
Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 0a 70 02 00 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 5e 70 02 00 48
RSP: 002b:00007fffb04b4630 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0909a7dc9d
RDX: 0000000000000003 RSI: 00007fffb04b4670 RDI: 00000000000000ca
RBP: 000055557f1bb430 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0909bac9d8 R15: 000000000000000c
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

