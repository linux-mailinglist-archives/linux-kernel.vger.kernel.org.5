Return-Path: <linux-kernel+bounces-157078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BD8B0C93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BCB1C23BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A31143878;
	Wed, 24 Apr 2024 14:30:39 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F1915EFA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969038; cv=none; b=ituqHCIx6cVrOwfiWrYLdlMKcXbDYDUSP2w8Uq71+4jXcxduIDssnSLbKN3q6bGhbiK/DjdP/KW2EY3WuBdW0wnlD5kD8e284xrYr1ZwlE/nhLR7Vd9gaZxrMkSe3eFLhscbLye+Ui2I+ZNwOEAo3x/mpL5JjOjBESI+V4vA1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969038; c=relaxed/simple;
	bh=RRYczo61DKfwox/IZZwkcuhLSiGOKb5E9N3mdAb4v9A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hfBQpnXc0/ITgsj9eHHVHU56Ql8tPS95rtwM1lBZnWqQioAH6uJBOUy5/nJ3JgOLIjWT/vmpFyA7T7qapIcvmXGlBFWmhkREIkvZyx3pjzdwrvjknRDJRhAj1GFOYiuZ+ICx3p513L1tIDHYKYDa/NrYx7NMPiy3Uusg38K1mSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d6bf30c9e3so870094839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969036; x=1714573836;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Bxh+v1QEHdGeL/W1U++CTQKILrpMJ/B7+jPozfFTLM=;
        b=tDGKUQhaAsHbeptX7MB0Rl8JPfCLqjFy1fLITPhc2bI8Fme4N7Jpp0Co+9azyPODjd
         VDskuFCwgArM0DGWYDAmaCZzDUTHR6mHOw/LxD9nFfJl4wXbYX+J0fcVHBsaNh2QxPKh
         zrFMrkQRkkwujIWURHk5aIjp6sY/RcxIj10mHgT0ILGFhqL56lyoErrFHfnFngAI7vl4
         fBOhPvaV0HZLi/HAkDczQfTvrVynR4OkeA2bG7yGi6ObqtckmdBN1L0yZi6H7aTB1fx3
         5seWVaQGdZJeqL0Ja8lzA1U2f4KjjPLp/0uWpx7rtxcFwW/13948J9jBXezYTI+rneTp
         2Uow==
X-Forwarded-Encrypted: i=1; AJvYcCV9AibqyfZqPVfFUg0CYfN/6KX3P6IG9nT6Xp3MG2xmFJnc2iGk5ZvibrgsYKzGHJJTsnFw5riYUMctawhpMIR3NF7r52J2yT1fX4F7
X-Gm-Message-State: AOJu0YwQm8xpZ3rMyk/GT1PnCEe7dg6pCUM7WvyqdCDPmE94Wo8co7lf
	1t/zZ6hYyAUynM3aWH3GOGB/Ucr3qZ1PNCJ6yz33F0rRS36F+Qa68djMHNI/c0BXQ/LoIvlFUu/
	LqP3Qy6ZlKedqCDT1rPdaLFpGFWJOYzJUDjmTFZ3uzjswOxsbXQplg6I=
X-Google-Smtp-Source: AGHT+IFp7bpSB5L0XnxC/4nNsZjF8MLb7zlHsxmaNw0MNvLvm6oeRmUw9P5rjpoemtfOE41sJ+OhcpR0KV2xar6m82Ij8TvjjCV9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d4:b0:485:67be:97d0 with SMTP id
 y20-20020a05663824d400b0048567be97d0mr349993jat.1.1713969036190; Wed, 24 Apr
 2024 07:30:36 -0700 (PDT)
Date: Wed, 24 Apr 2024 07:30:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ef08f0616d88373@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_journal_check_start
From: syzbot <syzbot+3325329a0e08fe68bace@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1469d1fd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=3325329a0e08fe68bace
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123c72bf180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8423191c8b73/mount_9.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3325329a0e08fe68bace@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 10063 at fs/ext4/ext4_jbd2.c:73 ext4_journal_check_start+0x1ed/0x250 fs/ext4/ext4_jbd2.c:73
Modules linked in:
CPU: 1 PID: 10063 Comm: syz-executor.3 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:ext4_journal_check_start+0x1ed/0x250 fs/ext4/ext4_jbd2.c:73
Code: 41 bf e2 ff ff ff 44 89 f8 5b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 b1 e4 43 ff 41 bf fb ff ff ff eb e2 e8 a4 e4 43 ff 90 <0f> 0b 90 eb d1 e8 99 e4 43 ff 90 0f 0b 90 43 80 7c 25 00 00 0f 85
RSP: 0018:ffffc90003e976a0 EFLAGS: 00010293
RAX: ffffffff825278ec RBX: 0000000000000001 RCX: ffff888027b01e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff825277c0 R09: 1ffff1100f837070
R10: dffffc0000000000 R11: ffffed100f837071 R12: dffffc0000000000
R13: 1ffff1100c880cc7 R14: ffff888064406000 R15: ffff888064406638
FS:  00007f52763386c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff27a379198 CR3: 00000000796d6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_journal_start_sb+0x181/0x600 fs/ext4/ext4_jbd2.c:105
 ext4_sample_last_mounted fs/ext4/file.c:837 [inline]
 ext4_file_open+0x53e/0x760 fs/ext4/file.c:866
 do_dentry_open+0x95a/0x1720 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f527567dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f52763380c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f52757ac050 RCX: 00007f527567dea9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 00007f52756ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f52757ac050 R15: 00007ffda916c8d8
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

