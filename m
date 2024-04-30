Return-Path: <linux-kernel+bounces-163739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75828B6F06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315AC1F236A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74779129A72;
	Tue, 30 Apr 2024 10:04:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC781292C8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471470; cv=none; b=Ur5dbl1MInUPnDyfx8L1vc2PNVZdf7Z90TUG3OPOMCunZlHV1VA99YSh/YTnVFjPTDoqZQp4pylSkzwoGDX48ncxQA4HzYztXCrP5ofkkteK55nBKTFJTJXPAZh4gAjMHgO2bRHiJmDFylNeOIb2ul/nm1TGWo+MvNgsoW+dVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471470; c=relaxed/simple;
	bh=+1aJrhYQX0AnWwGuptyHgoz4jT9gYXZA7TcVw917ZoU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SgbS8tRJuCpdBtRM10SHy3BmCRpEGO5XxOWVGxl1Cnl48jUP1D0Lv4EC2E0T9qny6kFK8eq1yf2dd04sCCMi1Ww9+5rkzMOAOsd7WFnotm861Zd/jtD0IbQ32NXpatDgilPWQer4tvFpWK+Kf7BJxy0dMl7x7/Zma13O5przCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b3157ffb1so61283745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471468; x=1715076268;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUCPXypqaDI7RZVA4dxNhXYP7Sd0MesVoRSUyJp0RhA=;
        b=OZpfgg9FPMVw4h50PKTlfVIZGQkpJ2golygzSTzal+bG+ArmPFi6QckXEa6EkP53J/
         1YvO0QcPqMNL4VcMM1G37B0vjta7w3jQ+F8REemH9XYB31Plphj4jb0qI54v/ZEIEWyt
         JGCw5TQl0q9YMnK6jzuJvN8mQb1Y8HmcVwVZRA2EP3ix3fh+IPS06CWeJZJcAKi+vKH9
         7ZgVrEmi+YuXX2oY+6RxCYlHyBXMldGyjbqQG2YabUEMee66QI3sk7vn8aYdh8DFrH8w
         sEmwrkB5xqEtELonsWx+Xw76BURkcs7jwGGz8bVM/S6bB9fn9B8a3c+qjMzsJ9ugLtIs
         UDFA==
X-Forwarded-Encrypted: i=1; AJvYcCV5p79HEnrxnVgxyvgIkBA3ajH3qegcysqiXw1yC7M++/wtdi8rSkLX63FMBmdfamoxEDVWX9dDmEVAgnp98N4t+8h66KC05dmvuzXd
X-Gm-Message-State: AOJu0YxEx5hX5QF14EhEXDvBzZJFgJMAjch5yyYAd6McbxxwzlosvaWn
	2lc1ROzGGeDbcvNNEdd5n8Y83YrlgfjYNwADwOS7lbP4O+jK8bonTuXO8mGnRVjaIGxd51WULxe
	ST8K1tyAAsqLABM/LTPQ455ynTFFFIHDuyijGlRv9MXTNBagBxoeoAFk=
X-Google-Smtp-Source: AGHT+IEo04hPMGUrxInQkQx/yfDEgwz6h0WPyzDNg0oyZM5zMoVchRHknLBbO2rLRAo281Gmc6VQ8z3oGoSlRvV/50dMH0ujfhwm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:450b:b0:487:4ad0:def3 with SMTP id
 bs11-20020a056638450b00b004874ad0def3mr531033jab.0.1714471467806; Tue, 30 Apr
 2024 03:04:27 -0700 (PDT)
Date: Tue, 30 Apr 2024 03:04:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d103ce06174d7ec3@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
From: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e4bc4bcae01 Merge tag 'nfs-for-6.9-2' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10937af8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=848062ba19c8782ca5c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b98a742ff5ed/disk-9e4bc4bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/207a8191df7c/vmlinux-9e4bc4bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7dd86c3ad0ba/bzImage-9e4bc4bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/inline.c:258!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 34 Comm: kworker/u8:2 Not tainted 6.9.0-rc6-syzkaller-00012-g9e4bc4bcae01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-7:2)
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 6f a5 0b fe e9 d6 fc ff ff e8 25 33 91 07 e8 f0 05 a7 fd 90 <0f> 0b e8 e8 05 a7 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90000aa68e0 EFLAGS: 00010293
RAX: ffffffff83ef09c0 RBX: 0000000000000001 RCX: ffff888017ebbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000aa6a10 R08: ffffffff83ef0485 R09: 1ffff1100c270ef5
R10: dffffc0000000000 R11: ffffed100c270ef6 R12: ffffc90000aa6968
R13: 1ffff1100c270ef5 R14: ffffc90000aa6960 R15: ffffc90000aa6970
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5425ff000 CR3: 000000000e134000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 f2fs_write_single_data_page+0xb65/0x1d60 fs/f2fs/data.c:2834
 f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3288 [inline]
 f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3315
 do_writepages+0x35b/0x870 mm/page-writeback.c:2612
 __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0x905/0x1260 fs/fs-writeback.c:1941
 wb_writeback+0x457/0xce0 fs/fs-writeback.c:2117
 wb_do_writeback fs/fs-writeback.c:2264 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_write_inline_data+0x781/0x790 fs/f2fs/inline.c:258
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c e3 fc ff ff 48 89 df e8 6f a5 0b fe e9 d6 fc ff ff e8 25 33 91 07 e8 f0 05 a7 fd 90 <0f> 0b e8 e8 05 a7 fd 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90000aa68e0 EFLAGS: 00010293
RAX: ffffffff83ef09c0 RBX: 0000000000000001 RCX: ffff888017ebbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000aa6a10 R08: ffffffff83ef0485 R09: 1ffff1100c270ef5
R10: dffffc0000000000 R11: ffffed100c270ef6 R12: ffffc90000aa6968
R13: 1ffff1100c270ef5 R14: ffffc90000aa6960 R15: ffffc90000aa6970
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e628000 CR3: 0000000049462000 CR4: 0000000000350ef0


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

