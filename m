Return-Path: <linux-kernel+bounces-122582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C188F9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C792936B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E955769;
	Thu, 28 Mar 2024 08:26:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C21DDD5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614383; cv=none; b=RcZPtQ9RCweU72nY8pZubjdnWQCuu217wweMRhhvhjGGipZIDrRPf72QltnGI/uvvlA3I1KUu0IBBBBOZQqgWvwCECIjh6dgqooC/fn1JXXSf3hp3wiBNpEhq6CiyjOTY7Y9jr0hm7Nfcbfigkz1DP2j8aZ+GFhr+GtLfEH5BhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614383; c=relaxed/simple;
	bh=MFs4na4sL+FUvZ0Dm7UY4YPmYNJejcDkKRGL8VyoNns=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SzjxoVICbrKKnG15BXYai5AWge7gOX2pfBsOFk0kaisH+AT4hpEG8oNxqxAf2Mv/ZjoIdn/petK5yYSIEAGIQUl4XdcEjbp4CzcvBjWMTXHPBieozyhT2WfHRd2rEZGpaYyfKlYiN5UbytXbBUhROamdjI3jJsRmQ3RMn9JIEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-368a72042b9so14043295ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711614381; x=1712219181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAoSgmgvBXbxtYx8pCIlrNKsK43NOKCP92pCO6ltbP4=;
        b=pOm4SufxPstO5pqqtNOusTXablxza/6Hfd/GqxKaTHuyq6LYc3CqSpNLjBWKKvxKvd
         IspHa3aMIrZRsd6PA6Cjto8JUoSRBqf/YgVDicSoVkCglKDlTWSIR2nP2QyBuebXwKQ/
         IjlarUMDBVwVRfKnGqdUBCiF0Bbn2DHupjQxYvaS+J67c2ma8O2sYlbCUikj6lX7xGwx
         6r9edFsf7sVOszF5cHPsRGeQ4nIiAEWEl/rqCWznime3ZPszWxyvBb4p3LJsiD+CFcjn
         2F59Of0czgPnIhLlOijwbJC+q1xNgj02YLpAUvFJiI3IxDy9F6xRqzwPteHCAgYvD8ve
         r4dA==
X-Forwarded-Encrypted: i=1; AJvYcCXhnvZXSHhSRz9aW7CDFhYpMOkWYs0QgmPtMo7ahePHgTrx+zUST1XMPOqzYYpIHnXRonO0xOno2+fn/NtVJeLdbwBYIemZoeTJEL55
X-Gm-Message-State: AOJu0YzgWdTw/fzuWTrzOjtDwlsO0g7KfXAaWmO1d4iYLCN4Z1JFOprb
	Ng7jbxTswvDv9Ba56xnX1wwVZ14jmEmGcESmEagGNCvw8Xdf12wBTUpsuOYakDYC8DygBhPRmjM
	J01qlfvikDdLveObGGO+yEP78cvGrUX/Zb58s/34n9kCIYTswXVavPMU=
X-Google-Smtp-Source: AGHT+IHgK5viOd0F+bDHqRYdcaYQ6s8+oCcIoWMtxdMcRU+n/HwfVQ5of75lvk5RAQ44Nz4GNM99q0PodqUqNOfhVuEhp/lNFdgN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d744:0:b0:368:72f7:a102 with SMTP id
 e4-20020a92d744000000b0036872f7a102mr39355ilq.0.1711614381036; Thu, 28 Mar
 2024 01:26:21 -0700 (PDT)
Date: Thu, 28 Mar 2024 01:26:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002cabeb0614b447e9@google.com>
Subject: [syzbot] [jfs?] kernel BUG in txLock (2)
From: syzbot <syzbot+a843f6ae2130a987d63b@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130728b5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=a843f6ae2130a987d63b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1068ec51180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c6f0ce180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/60c8566d11a7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a843f6ae2130a987d63b@syzkaller.appspotmail.com

Locker's tblock: ffffc90002631850: 8be235c0 ffffffff 00000200 00000000
Locker's tblock: ffffc90002631860: 02631860 ffffc900 02631860 ffffc900
Locker's tblock: ffffc90002631870: 00000004 0000001c 00000008 00000000
Tlock: ffffc900028522d0: 0003000e 20208040 229bc9b0 ffff8880
Tlock: ffffc900028522e0: 775896b0 ffff8880 03140000 05002000
Tlock: ffffc900028522f0: 06030a00 0000020d 00000000 00000000
Tlock: ffffc90002852300: 00000000 00000000 00000000 00000000
Tlock: ffffc90002852310: 00000000 00000000
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:834!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5076 Comm: syz-executor283 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:txLock+0x1ed3/0x21a0 fs/jfs/jfs_txnmgr.c:834
Code: 48 c7 c6 00 3c e2 8b ba 01 00 00 00 b9 10 00 00 00 41 b8 04 00 00 00 4c 8b 4c 24 20 6a 00 6a 48 e8 52 e6 7a 01 48 83 c4 10 90 <0f> 0b e8 56 4e 72 fe 4c 89 f7 48 c7 c6 00 44 e2 8b e8 67 33 b8 fe
RSP: 0018:ffffc900045070c0 EFLAGS: 00010286
RAX: 30bbfa8826d96700 RBX: 0000000000000010 RCX: ffff888028011e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004507210 R08: ffffffff8175c06c R09: fffffbfff1bf9650
R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: 1ffff9200050a45a
R13: ffff888077586f00 R14: 000000000000005a R15: ffffc900028522d2
FS:  00007f6aa27586c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6aa2758d58 CR3: 000000007b84e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dtInsert+0xb0a/0x6b00 fs/jfs/jfs_dtree.c:881
 jfs_create+0x7ba/0xb90 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3497 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x1425/0x3240 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f6aa27c2879
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6aa2758218 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6aa284f6d8 RCX: 00007f6aa27c2879
RDX: 000000000000275a RSI: 00000000200010c0 RDI: 00000000ffffff9c
RBP: 00007f6aa284f6d0 R08: 00007fff5a3c9dc7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6aa281c190
R13: 0030656c69662f2e R14: 00007f6aa281607e R15: 3d6469672c647261
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txLock+0x1ed3/0x21a0 fs/jfs/jfs_txnmgr.c:834
Code: 48 c7 c6 00 3c e2 8b ba 01 00 00 00 b9 10 00 00 00 41 b8 04 00 00 00 4c 8b 4c 24 20 6a 00 6a 48 e8 52 e6 7a 01 48 83 c4 10 90 <0f> 0b e8 56 4e 72 fe 4c 89 f7 48 c7 c6 00 44 e2 8b e8 67 33 b8 fe
RSP: 0018:ffffc900045070c0 EFLAGS: 00010286
RAX: 30bbfa8826d96700 RBX: 0000000000000010 RCX: ffff888028011e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004507210 R08: ffffffff8175c06c R09: fffffbfff1bf9650
R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: 1ffff9200050a45a
R13: ffff888077586f00 R14: 000000000000005a R15: ffffc900028522d2
FS:  00007f6aa27586c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6aa2758d58 CR3: 000000007b84e000 CR4: 00000000003506f0
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

