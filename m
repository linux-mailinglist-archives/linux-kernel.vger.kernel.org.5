Return-Path: <linux-kernel+bounces-163459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083698B6B56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CF9282136
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68FD3AC34;
	Tue, 30 Apr 2024 07:19:25 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AC33EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461565; cv=none; b=DNnyhiwFTT0NZPzZLPwBD4DAiXX28f1SgUWCHBsP8bcDqexdNHMXQzJEhuaRIca51eKJAnZwGw7f1E7lZjsuQMkE9vj5wJrU1G7XQDTwod07w1NVeQWnz6PsJmUn2N9RlnAVLQIJJVIM9Iz3YpIM++P/xJKMe9rKK2qci+2r9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461565; c=relaxed/simple;
	bh=hxT/zLuKhrvHe7RPN8WZzTXZWdbXsb/k35ynlb8Z3Pg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ofC+GLZCl4A4nWNwKix1U2mpb6cG6CG7Vo9JPtBsRzuQn5PqK3EfFzlgE4HlTbatVRZw2UDmkbMg9yCgtO11e8jvdV4aryvrKDBRHXV6rIPWw+Z5Tdp1ewAUxSmzAXXudfcZkdbZ4cYrLWcxR4H5B5Cyr2UFsR9RgLNFqqLzA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dec39bc0a4so247338339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461563; x=1715066363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MilV/OT5yB6oxIhM5AEKqTMjTfTZzcUIfcce2zIqJ1c=;
        b=C9NL5HT9/G5/0r+LQlFDkDnFkH2QyucVkm1mTbj74tqo+KkPI2Xf6wYKxZET46sVLp
         D8sS0UnOO0d4Evey8wsZrA6AXW0tsUbV3AnqH5+NGtzJXFTgbsO/zfrKFm/r8VxHwFGJ
         +tyc98iqKPeqvzUrCvCkXHMULs6eUzksBeAqgE369GJpQ6rHmqBBNIrZ7UK5GbehoaO1
         qy2YK6WPZEsuv98DafA5vngrO5szwJwzEwIwVLP1u9b2PG3D7MBWoJNSoyq54Jgf3w1Z
         DO3fhYdOX3tsDpNjNyhQcJT13JV2OJEblFQB4G5Q8yChQ4bEK6TZQxBLObsqEDrJYQhK
         XhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2XxQRQDeOHY8Po+MTrXJKOjj+57iD+RDpNwNi3yHbcbxs2y/j72b/E6hlSXJ1Ts5ivkxCrJNdFn00sb14i0M61x0V/fjmIEH8Fclk
X-Gm-Message-State: AOJu0Yxb1fgUWtxTwmOqEM7j9zCOAQKOfsIHUtVgfxc1AT0nPFpo1QK9
	RkBVzzGvzCLlAje4nWxX+wrF01IaBg5P8U/nmS3g9wKOucPTo2At0PB5Vvv6A4ipcVxl9Cam4pI
	++ZMTZsewPdM4chRbMfcAPFpiw5UeI5EeVILXxGbzd/mOMvAnk8BqTSs=
X-Google-Smtp-Source: AGHT+IGgQeMK7yo6qNA9ufhuJLGl26ukQfJcIw3uhyA5Onhx9759iNoff+GML/M45UsGCt5soJ+8qvuc7a8V64pq4N2jOgVdP4h0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd4:b0:7da:b30e:df80 with SMTP id
 j20-20020a0566022cd400b007dab30edf80mr104935iow.0.1714461563073; Tue, 30 Apr
 2024 00:19:23 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:19:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072c6ba06174b30b7@google.com>
Subject: [syzbot] [ext4?] WARNING in mb_cache_destroy
From: syzbot <syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b947cc5bf6d7 Merge tag 'erofs-for-6.9-rc7-fixes' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11175d5f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=dd43bd0f7474512edc47
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d2957f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1620ca40980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7318118d629d/disk-b947cc5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88b2ce2fc8ea/vmlinux-b947cc5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f3ffc239871/bzImage-b947cc5b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/224b657d209f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com

loop0: detected capacity change from 512 to 64
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5075 at fs/mbcache.c:419 mb_cache_destroy+0x224/0x290 fs/mbcache.c:419
Modules linked in:
CPU: 0 PID: 5075 Comm: syz-executor199 Not tainted 6.9.0-rc6-syzkaller-00005-gb947cc5bf6d7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:mb_cache_destroy+0x224/0x290 fs/mbcache.c:419
Code: 24 08 4c 89 f6 e8 9c e6 ff ff eb 05 e8 45 3b 6e ff 4c 8b 34 24 49 39 ee 74 33 e8 37 3b 6e ff e9 6a fe ff ff e8 2d 3b 6e ff 90 <0f> 0b 90 eb 83 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 58 ff ff ff
RSP: 0018:ffffc90003677a88 EFLAGS: 00010293
RAX: ffffffff8227d393 RBX: 0000000000000002 RCX: ffff88807c9ebc00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff88801aeb3858 R08: ffffffff8227d312 R09: 1ffff1100dd2e204
R10: dffffc0000000000 R11: ffffed100dd2e205 R12: 1ffff1100dd2e200
R13: ffff88806e971020 R14: ffff88806e971000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ec96f85460 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_put_super+0x6d4/0xcd0 fs/ext4/super.c:1375
 generic_shutdown_super+0x136/0x2d0 fs/super.c:641
 kill_block_super+0x44/0x90 fs/super.c:1675
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7327
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4207bbec89
Code: Unable to access opcode bytes at 0x7f4207bbec5f.
RSP: 002b:00007ffd518b18c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4207bbec89
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f4207c3b390 R08: ffffffffffffffb8 R09: 00007ffd518b19a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4207c3b390
R13: 0000000000000000 R14: 00007f4207c3c100 R15: 00007f4207b8cf60
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

