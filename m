Return-Path: <linux-kernel+bounces-49610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34110846CE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9182946D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1477F05;
	Fri,  2 Feb 2024 09:46:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B87762B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867191; cv=none; b=kODX9NWa1dqKmrwZc/VWmEqjKmCbK2g8cEw7fz1SjxWHtYPb50hSVFMZPX9wg0ippLZfKGD4t6f8g66aiABEvlVjxBTkr2FAGQmRMBckyhK0BFtMDXw3SBv5BLfzzTId+QYvst8rZoc5Qw7U9sKQBBVJi0UAlyQKFJRfHfuL0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867191; c=relaxed/simple;
	bh=R0WbXIzFgamtpd/98Hivr7vsvygtNfxQ2vI/8P0FueE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DuKxf0K9xE0Ku26QLIXRDv3IWxgRWbgTfxd5yDjB/xOHvxDDPx5RUymQ+s0qNtK0MabXTJFXlh2UvWaJxkiQM4YdgB4kVZO+wbQQlHBwjrZeIzS4H0/Eu/A+3jmIeCrshMaTyC5xPQBZ/2wVSt4uo+NsPLwRnwAZC9JuDzj0U4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36384ce5760so16536465ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867189; x=1707471989;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AuTHoZ+b/x+DzfT4xaS12e5HyQ+moNjjakKHgGHztg=;
        b=Z96e2D+7myysnkhBpNjcAx8H0TH/Q8XTkj0pL3m7XqMgd+vVku5LuP1qEAYR+GBFgK
         RynNttP/QuIEp1FKPLeHuL2ZoTwRov5BtvCIwKKETpyUcbV6PSWUkLb6FUOYgjOqjBPn
         dmQSGPBAoTaWczCeY8dunk5jx3uOSYXpZtq+EzEoFQyf6Lp0AI2mrI+LAvXxIhFxn/+w
         EZ5JnPEuCfphE04QGV5VpaDTIMmCUEqxfGaAbG0tOyuAMhinF9ED/oNNS5VH29/IqV/t
         2LDp5Zay160Ey5Tmbwj4/xZnmTLQAMmOZu/mCPMu71X+TGUtvPTecNol0YB+bNeLiynq
         bntw==
X-Gm-Message-State: AOJu0YwqijfTnA+2qhROFQEogLby5qD3FrvKYPBqp4zht5mgrgsmOGJ0
	EnpYB2r9jPNcdHOLG6A/iPl2quLiC8uJvtnqzlkZcpG1QFglfxKy5zQAam3RpfjOiqlglsZxJvx
	6hqRXrwGNc/s0XaXoVSQBgRJhWF3vlahi7LnSgVJtVDgNThpulHHwdV4=
X-Google-Smtp-Source: AGHT+IERpRfLHwPhL3HUUgkcDSUIAkh4KGkp3J1rWFwiwcathIf0wTrl009H4PiV3p+P3vd3zYNEfok2z4fXGvPi/N3Q1pWpIRm5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:363:75a8:56e1 with SMTP id
 l10-20020a056e021aaa00b0036375a856e1mr114456ilv.3.1706867189248; Fri, 02 Feb
 2024 01:46:29 -0800 (PST)
Date: Fri, 02 Feb 2024 01:46:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e7a63061062fcd9@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-use-after-free Write in __fscache_relinquish_cookie
From: syzbot <syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    596764183be8 Add linux-next specific files for 20240129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12643c47e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=584144ad19f381aa
dashboard link: https://syzkaller.appspot.com/bug?extid=a4c1a7875b2babd9e359
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ed937fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17805467e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b647c038857b/disk-59676418.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/729e26c3ac55/vmlinux-59676418.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15aa5e287059/bzImage-59676418.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4c1a7875b2babd9e359@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: wild-memory-access in test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
BUG: KASAN: wild-memory-access in __fscache_relinquish_cookie+0x2a/0x620 fs/netfs/fscache_cookie.c:977
Write of size 8 at addr adacafaea9a8ac9a by task syz-executor410/9304

CPU: 0 PID: 9304 Comm: syz-executor410 Not tainted 6.8.0-rc1-next-20240129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
 __fscache_relinquish_cookie+0x2a/0x620 fs/netfs/fscache_cookie.c:977
 fscache_relinquish_cookie include/linux/fscache.h:308 [inline]
 v9fs_evict_inode+0x102/0x150 fs/9p/vfs_inode.c:356
 evict+0x2ed/0x6c0 fs/inode.c:666
 iput_final fs/inode.c:1740 [inline]
 iput.part.0+0x573/0x7c0 fs/inode.c:1766
 iput+0x5c/0x80 fs/inode.c:1756
 v9fs_fid_iget_dotl+0x1b4/0x260 fs/9p/vfs_inode_dotl.c:96
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0x515/0xa90 fs/9p/vfs_super.c:142
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0b9d2fb899
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6ee450d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0b9d2fb899
RDX: 00000000200001c0 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000020000300 R09: 00007f0b9d200990
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe6ee450fc
R13: 00007ffe6ee45130 R14: 00007ffe6ee45110 R15: 0000000000001086
 </TASK>
==================================================================


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

