Return-Path: <linux-kernel+bounces-143929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D758A3FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616CB2821C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8A28EB;
	Sun, 14 Apr 2024 00:26:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934E4689
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713054390; cv=none; b=CQxSCYanxI2oM3V1dDt35nIYMEtkS+Sc23jsal9IZOkU3uy9Qc0ganrIGH9YU5dxd/fiZOueAqjcO5R2eED3TmN2p46Acchc3/109ryhgQaSHBQJqtfA7Gm2u2qmrHBtaYsUqXuqeLNBCFacXSqDnpqFnStgFswpcwMfs3dQvlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713054390; c=relaxed/simple;
	bh=2amr6wG99uO/mIM3nGfbYUX9VWalVE/e1WEzqM/t2oA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZvyXcUH28V18aXkmTAWkFry370btakuuhpaTCoJRCz8PrS9nyILbKjQ4nJ4/W0LeURNoz9UFeHLkHTmnPX+vZgFBWKHyRO2eUjts7+OsST2QxcjHfPtxejJA6esWMgA72zlaPWi8PbCaFeVN5hAWzuag4e5KVmdczoWpRStZ58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a14031548so21422695ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 17:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713054388; x=1713659188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsIqhJuQNmACm2Ng6LAS1JB1TTW5nlMwGw5jr/sCgBA=;
        b=QXYVOYulBmBMME+iMm8R+a/1s9Tqz9xNd5lRzCcvxsnqFAEW6ok9GhPFZ6hma4KQLs
         hskoHRoT4B5C5xuMTnnP9+aYDlBgV2srbVRIf/7dqkoTW6Hs+UA6SjUxAN7gfZydQfMD
         6ekkWCUGLz+UxgXqonfKF1eqJU369rxeUouA1x3PTwxkvQq/c+V78pT8FXmfTTKfYlAt
         uCQQgNGGWK08DuQMm/nhGV9nPhmX81fVccwq8mMx/MHmbGU6bmy2ebAuUw7qBrtVlHpQ
         wztJ6W+BnvehVzWYksfQtJaVeNIBdEEImkkdA+mTooAMEgZ5e5POX6iSNwiL+zs3bR8Y
         htaA==
X-Forwarded-Encrypted: i=1; AJvYcCVZcRTfD43O7bSfsSHzKHXV25jJTxGu/gH5v+t9Aryh7tnqfUpuvzpyIFxSb1yce2++A9kBIVUNAtMdxSWoGK6Kmt34WYONpK6QEMWz
X-Gm-Message-State: AOJu0YwWxR8inQJ9BoGvChP2Xd4oJ607pBuDgLHthyZj90xEu32eZInK
	zZ+bGf96Vnm8bay1kFr8EgtCxwaWz0r33CKmPlpqQjFqG2z+lrGEXv/sOBJ5f1lor+sHTci4p+f
	3LWR2qpBPxWn1HYgFxVVRAdz0koxcz/KM1me24szpde9gr30eb+bSbeg=
X-Google-Smtp-Source: AGHT+IGXSZRjxeasgIby8IVsdEwfLp48enTRZALg+PBa66YzSIy9ESl04YsfvOzSZg4pjfnNcKzkHoVfYcckRShj/tQRyp8YLS2E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6f:b0:369:f7ca:a361 with SMTP id
 w15-20020a056e021a6f00b00369f7caa361mr478849ilv.1.1713054388468; Sat, 13 Apr
 2024 17:26:28 -0700 (PDT)
Date: Sat, 13 Apr 2024 17:26:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e50e40616038e72@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_chan_send
From: syzbot <syzbot+b6919040d9958e2fc1ae@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14f69bd3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=b6919040d9958e2fc1ae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6919040d9958e2fc1ae@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8027 at kernel/workqueue.c:2322 __queue_work+0xc6a/0xec0 kernel/workqueue.c:2321
Modules linked in:
CPU: 1 PID: 8027 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__queue_work+0xc6a/0xec0 kernel/workqueue.c:2321
Code: ff e8 3a e0 35 00 eb 21 e8 33 e0 35 00 eb 1a e8 2c e0 35 00 eb 13 e8 25 e0 35 00 90 0f 0b 90 e9 74 fd ff ff e8 17 e0 35 00 90 <0f> 0b 90 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
RSP: 0018:ffffc9000305f4c0 EFLAGS: 00010083
RAX: ffffffff815f103d RBX: ffff888022ff3c00 RCX: 0000000000040000
RDX: ffffc90012785000 RSI: 0000000000016230 RDI: 0000000000016231
RBP: 0000000000000000 R08: ffffffff815f0513 R09: 1ffff1100d0621be
R10: dffffc0000000000 R11: ffffed100d0621bf R12: dffffc0000000000
R13: ffff88802e5ad9c0 R14: ffff88802e5ad800 R15: 0000000000000008
FS:  00007f9fcf6a96c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001300 CR3: 0000000062a38000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
 l2cap_chan_send+0x3d6/0x2680
 l2cap_sock_sendmsg+0x1b4/0x2c0 net/bluetooth/l2cap_sock.c:1139
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmmsg+0x3b2/0x740 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f9fce87de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9fcf6a90c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f9fce9abf80 RCX: 00007f9fce87de69
RDX: 00000000ffffff80 RSI: 0000000020004100 RDI: 0000000000000006
RBP: 00007f9fce8ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010040 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9fce9abf80 R15: 00007ffd6dcb5768
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

