Return-Path: <linux-kernel+bounces-97865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AD8770A6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED16AB2108C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94596364DC;
	Sat,  9 Mar 2024 11:25:36 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8E2C6A3
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709983536; cv=none; b=tpyUFMUmCUEvn5EAJ58kVl+U4/R/TsjEt2fpi/1/tvYh8NxyOSMPf75lPaIaS1q32uv+4GeZ1/83+r75aqSa8VA+CUhG0yn057WchZVMwb3phIKulMJ8W5aZFaEpMQxktZO01YaTMjouKby4yiDdqS9Bc5Wsa8kJSCoPkpO0qiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709983536; c=relaxed/simple;
	bh=IMgy7favakKGMQPGrWMEeCE5+QNhxZqqEey+cmotPDU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W4TpAFeJjkyg6oBHbQSVfJ41KIuX5ITTug0mkWM+J1rKdRXX0aL3HXCbZ+G1sFTP94ubvA0u0zsnJ3up/Zm8YpPdA20SIFd3908BmbY0/tG0pGrumqLB8RyhpdcGaaYbvYbZUZWloLoHgzzXpGw0CToQ1E/7cfkzn5uDArcvtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so3220039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 03:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709983533; x=1710588333;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGfTQVcsfAY5sUTLMth5hoocCpnPkeA5YUdNBAg4i9s=;
        b=PfcoGYNBRmfSDBMfxneQu4/AYylHbhGYdpGXH3LDNk5yWoCb0Nt4GlquaP1XmfqU0L
         2ykae8R/JoaEuoN63+V0X4w4T0RoGJlBKIQjeM0Ace7Muixa7b5RRZAUp//HsPt8mXv4
         qpw91QgpqkF7Z0VOXLajLHFu1E+7ZMvJtstkFNIp9lOXMibCtUyFNwqqIFFzEV/m8LO5
         6iqbfwrrfnSSMVPdmxQd+ENX5YFpmyc2T2a7aILfnWS+j0/lNmLZmrUWDAMu9u9Ng8sP
         QjdqSccYnJjPwMT4bonVmrpUQGwX6L82yA6bIc9HUprilXzeyA3+N26AbWbMjlaaFBx6
         UtVg==
X-Forwarded-Encrypted: i=1; AJvYcCUHUw3WM54MUQpCuYQwdbHgVdQ5r7NPRlizCJGdfte8oTBHcCP6WzB9PdqVaC9yyzJCNN3AXweq8uQlqBjmo7r8ntLI9jOBdI0CRXDC
X-Gm-Message-State: AOJu0YwWlwpxqf2V2OZpi44hziTeQmVdt2RKKG2/MI1YwWeksJrQTcSF
	3O5W9/w3Klk75azjh5SF/u0X2GPYFPLDkDkbCnQGfmKv4GFrl5lBhOEDNOyGMoNJD9Xfhk+XCB0
	3KAeS/lZoBWk7NNSnD+47bSTYLB7fWz82poJ7QXHdaIblZwHBFNzAAOg=
X-Google-Smtp-Source: AGHT+IGRN+Y9mmSBbQG+b0majzKFdfAZdfOCedOt2HS09yAQpFI8my+pM8j4OoLi+rytOVJf3KgzZ+R/tCdZVutWkkXjN6IYT7li
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:365:3e12:3eb1 with SMTP id
 j13-20020a056e02218d00b003653e123eb1mr88271ila.1.1709983533790; Sat, 09 Mar
 2024 03:25:33 -0800 (PST)
Date: Sat, 09 Mar 2024 03:25:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a87b90613389171@google.com>
Subject: [syzbot] [mm?] WARNING in try_to_migrate_one (2)
From: syzbot <syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3aaa8ce7a335 Merge tag 'mm-hotfixes-stable-2024-03-07-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1289abde180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74a95eee532b237a
dashboard link: https://syzkaller.appspot.com/bug?extid=ddf4b4c0005944105a9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3aaa8ce7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/84038f5e2c04/vmlinux-3aaa8ce7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc9d60eea301/bzImage-3aaa8ce7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddf4b4c0005944105a9e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 43 at arch/x86/include/asm/pgtable.h:404 pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
WARNING: CPU: 2 PID: 43 at arch/x86/include/asm/pgtable.h:404 try_to_migrate_one+0x19d4/0x36b0 mm/rmap.c:2256
Modules linked in:
CPU: 2 PID: 43 Comm: kcompactd0 Not tainted 6.8.0-rc7-syzkaller-00142-g3aaa8ce7a335 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
RIP: 0010:try_to_migrate_one+0x19d4/0x36b0 mm/rmap.c:2256
Code: 89 e7 e8 4f dd 0e 00 e9 16 f8 ff ff e8 d5 47 b4 ff 31 ff 4c 89 ee e8 db 42 b4 ff 4d 85 ed 0f 84 e4 09 00 00 e8 bd 47 b4 ff 90 <0f> 0b 90 e8 b4 47 b4 ff 48 83 cd 04 e9 65 f7 ff ff e8 a6 47 b4 ff
RSP: 0018:ffffc9000069f330 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000a02d80 RCX: ffffffff81d79d15
RDX: ffff888018728000 RSI: ffffffff81d79d23 RDI: 0000000000000007
RBP: d7ffe7fffafe9202 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000003 R12: 0000000000000400
R13: 0000000000000002 R14: dffffc0000000000 R15: 0000000000000800
FS:  0000000000000000(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00f07b020 CR3: 000000000d378000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rmap_walk_anon+0x228/0x580 mm/rmap.c:2599
 rmap_walk mm/rmap.c:2676 [inline]
 rmap_walk mm/rmap.c:2671 [inline]
 try_to_migrate+0x2ba/0x300 mm/rmap.c:2328
 migrate_folio_unmap mm/migrate.c:1244 [inline]
 migrate_pages_batch+0x10c7/0x2c60 mm/migrate.c:1675
 migrate_pages_sync mm/migrate.c:1841 [inline]
 migrate_pages+0x1b31/0x27d0 mm/migrate.c:1950
 compact_zone+0x1dcb/0x3f90 mm/compaction.c:2554
 proactive_compact_node+0x118/0x1d0 mm/compaction.c:2814
 kcompactd+0x712/0xd80 mm/compaction.c:3130
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
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

