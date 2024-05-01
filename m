Return-Path: <linux-kernel+bounces-165280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15E8B8A88
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411ED1C20E82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3A8565D;
	Wed,  1 May 2024 12:51:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABB12A15B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567888; cv=none; b=JttkNfBni+cnMx60VtY4pSAMxOvgHIQ9VON5luxaAhXeCR8OOjAuZcTurp4Dt+ZYqg60Z68DT0FVarcy3F0oEe0IYzJIJGpqPlVdq3cfffHD3WGj36JxH+AbLVAlGve254ZbujIh50kzl6HpCd5pvCcEQGS5M94kiELsASkAkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567888; c=relaxed/simple;
	bh=9gjkchFMJwUjpF/uchEYtIcWsr1hiGH0tVbUVogWLfY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EAfwlWMNtj5mwbGgfqT9iXjzI4WPyJYClF/wRaOQ2ebggAN7uZAPyWzSIz5lSiF0Jcd43sEiUfhR3GdWYUAWu59jAcS3xFvcVgGnsO6M+GyO3YILC+AfMYZ+oNTz4HAfyjRKkxsLg56FoX5tXLWRHGN2gFaX2KGH77M3W8sCu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dab89699a8so747252739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714567885; x=1715172685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wnNbmWU078woIxMllctBTvqWvHXn4tL8L+Wpu7svmM=;
        b=fU0jT7cu+JdwR6ko1DCbAxf37ngYDOdNjZtUJkD8M2LscDau7+Zk2mPllscgORgxyt
         MwLN96Cbc4OwTZoIA3HBthvFmZV+D86mPjPKcCzRnypiqTlzGlOygmO0JgCEr5pGmrLx
         T+2NbYNtHAmNI2VReQNPio6PfjDCRS1EX4Cm2636AYWPAkOooIMJiefdSF1njqiHnIiH
         Qe2IbFpAPKJPdvWdLmcUTB/Mq1wCz1JWsUgriVfAuELdhMvvYTpRD6oAsQk4XKKvsKKU
         Fo7HDVpGXKnrZ3rVwzAQ/vFGLx9TeK2iwl6oKMEGR4azwl9IO4FCiN/mfznApriQgPlT
         bbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXjxYD4YK5j23hGOmVcao5J0sN4ijtDSt9/K1HDQBQJmgj4v6daAkZtrwZu+HHpk3cREhJ9P+kPVsqWKfyZLjYET7UO+B6L2+SfVNvz
X-Gm-Message-State: AOJu0YykKjEgygElQ7mSGVmAEaTZIAsqHakBWX8u7xNwoikC8bfs9r47
	u02OoziGQWsxlVahmOKtcSTn6KfhWxjsgVbMRQzgiI/u35lXtj2MBh9VHuN20L1C4iqSFWCKtPA
	OeeyWvayKHMhr1uDO5JNZwxlKHWnEKxeyDR6QhHJhH8pmnwphC2DuVO8=
X-Google-Smtp-Source: AGHT+IFwqIAlIAaPoqZ9mYyeoyOw68HsY4uzYc7329qvgtFI9BPVks0/KISy/dNE+mk1ZQwyS76jJ6VBeW00aiQyGUD66Qjed4jE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:36c:5029:1925 with SMTP id
 m10-20020a056e021c2a00b0036c50291925mr119176ilh.0.1714567885259; Wed, 01 May
 2024 05:51:25 -0700 (PDT)
Date: Wed, 01 May 2024 05:51:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be9914061763f17a@google.com>
Subject: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bb7a2467e6be Add linux-next specific files for 20240426
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16152fd8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=5b6ed16da1077f45bc8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1425307f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129b956b180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5175af7dda64/disk-bb7a2467.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70db0462e868/vmlinux-bb7a2467.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3217fb825698/bzImage-bb7a2467.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5f3094e29bc3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 8000000078309067 P4D 8000000078309067 PUD 7b739067 PMD 0 
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 10600 Comm: syz-executor757 Not tainted 6.9.0-rc5-next-20240426-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000df7f698 EFLAGS: 00010282
RAX: 1ffffffff17f906b RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffea0001dd3440 RDI: ffff8880785f9a98
RBP: ffffc9000df7f800 R08: ffffffff81cfce8a R09: 1ffffd40003ba688
R10: dffffc0000000000 R11: 0000000000000000 R12: ffff888022288170
R13: ffff888022288188 R14: ffffea0001dd3440 R15: 1ffff92001befee8
FS:  00007fb8369ff6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000007c042000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 attr_make_nonresident+0xa49/0xe80 fs/ntfs3/attrib.c:301
 attr_set_size_res fs/ntfs3/attrib.c:371 [inline]
 attr_set_size+0x711/0x4290 fs/ntfs3/attrib.c:432
 ntfs_set_size+0x161/0x200 fs/ntfs3/inode.c:851
 ntfs_extend+0x16d/0x4a0 fs/ntfs3/file.c:335
 ntfs_file_write_iter+0x3ea/0x770 fs/ntfs3/file.c:1124
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb837280a29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb8369ff168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb8373276f8 RCX: 00007fb837280a29
RDX: 000000000000fea7 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007fb8373276f0 R08: 00007ffc182e95a7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb8373276fc
R13: 000000000000006e R14: 00007ffc182e94c0 R15: 00007ffc182e95a8
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000df7f698 EFLAGS: 00010282
RAX: 1ffffffff17f906b RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffea0001dd3440 RDI: ffff8880785f9a98
RBP: ffffc9000df7f800 R08: ffffffff81cfce8a R09: 1ffffd40003ba688
R10: dffffc0000000000 R11: 0000000000000000 R12: ffff888022288170
R13: ffff888022288188 R14: ffffea0001dd3440 R15: 1ffff92001befee8
FS:  00007fb8369ff6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000007c042000 CR4: 00000000003506f0
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

