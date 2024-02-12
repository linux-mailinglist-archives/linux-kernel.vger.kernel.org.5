Return-Path: <linux-kernel+bounces-61325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EEA851108
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B426B2597D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8C2B9DA;
	Mon, 12 Feb 2024 10:36:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AE2575F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734186; cv=none; b=rWdUGiu4rIXxptseIMZFIJYHGu3NHDKs3Gr9gL4aKlItR/zfywpPJn2Bhsxi78u/Mrlc+WvlI22AU6zpj25baGg/0ABrdZBI9uyJJ7TcnCZZ5iarfsDxtI/o7U0q+7emH/tNeCgXsXdYmC1HH8XXZgkxnPov+4o+k+FUdwzz1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734186; c=relaxed/simple;
	bh=XgBeXlxzyxENPKM0phJQ2DOLEQhtvy3i7sWOZwQU7Hs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DL0gQhsCPdOcyj+w3C4+iaiCOwqfCw8+N6ucvrQ5M0xwMLyUFl9BJyRV3kK73KS91HNyWK3Ot3BgEWtkQZ/nvYUNr7j+U4A2Rkhch7PxOWAdwtqkhxGQOkLr+t7Oo8mMwKGdyyY6oPpwWNUMl4ddOGOZcnMBTh3Jb6ktX9NvBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363c88eff5aso26558845ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734183; x=1708338983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcAZJy4DlbXdryo7e17UK1Z9B9l9LAm7zSOtqPj6VWI=;
        b=RTdmwp82e2EkmtHlYqBQXUB0RuBwvJom+2odjJMze66UJTfaRtlTSA5PQ7i8IQaXuO
         6QeJd/EzZuoPYs1NEl8UQesOlqt0pPRXHkWssdgQiiSrZOZPMJsnM7W/uMwo9IeK8Jtg
         A51EpYAYoqwXMi8XLZ8iZ4Dnjd/ekNDztnjs65fGZIXeBdLJPdn4UGaJb6ceE9aEWtDz
         sU5jymIMK2gpPbSsH9i3zrgQpl6EmmQDTviTipgGsLvYh3RN70z22PluO8LUebQ1NAwi
         k2kJc53jpZ2E2eR0EMTOVo44+wzymlOrvgkdRM+/PgWjctSTflS1yCZRvXqUviKuhaCh
         UHAg==
X-Gm-Message-State: AOJu0YyXmUj2HDeofLJt/Kx0gnMNX1O+WXnwyJCTbJKvi9FdzQvNjMcH
	f/QOzkRlT4FdpWvoF1uDar866YLyWAN14MDaaiCijhcayec9cM56e8AOxUnWgfesGaGGMxVf5f8
	JXaa8DLiKQBP81gJjT9xq/FBQJJ7yC6K0bwpmNtlGe0JHBarYpmhVTwE=
X-Google-Smtp-Source: AGHT+IFgUu1kKNz+kizPomTdh//ehK7fDS3zmiYjhrrX2+PxpWm/qB6rlGdmysbiOYRLhvVXOYUWzAxFCxVZSuqc5a+dg0/9gX3y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4707:b0:471:6214:bc1e with SMTP id
 cs7-20020a056638470700b004716214bc1emr53988jab.1.1707734182950; Mon, 12 Feb
 2024 02:36:22 -0800 (PST)
Date: Mon, 12 Feb 2024 02:36:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000587e0f06112cd973@google.com>
Subject: [syzbot] [dri?] divide error in drm_mode_convert_to_umode
From: syzbot <syzbot+0d7a3627fb6a42cf0863@syzkaller.appspotmail.com>
To: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    445a555e0623 Add linux-next specific files for 20240209
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175fa6ec180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=0d7a3627fb6a42cf0863
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d4bd48180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106ae642180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9188bb84c998/disk-445a555e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ce0c98eabb2/vmlinux-445a555e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab801b1c1d6d/bzImage-445a555e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d7a3627fb6a42cf0863@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5068 Comm: syz-executor201 Not tainted 6.8.0-rc3-next-20240209-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1303 [inline]
RIP: 0010:drm_mode_convert_to_umode+0x36a/0xc30 drivers/gpu/drm/drm_modes.c:2594
Code: 0f b7 03 66 83 f8 02 b9 01 00 00 00 0f 43 c8 0f b7 c1 44 0f af f8 44 89 f0 48 69 c8 e8 03 00 00 44 89 f8 d1 e8 48 01 c8 31 d2 <49> f7 f7 48 89 c3 eb 1a e8 19 a2 47 fc eb 05 e8 12 a2 47 fc 48 8b
RSP: 0018:ffffc900034ff660 EFLAGS: 00010246
RAX: 0000000000001f40 RBX: ffff8880176d9016 RCX: 0000000000001f40
RDX: 0000000000000000 RSI: ffffc900034ff720 RDI: dffffc0000000000
RBP: 0000000000000200 R08: ffffffff854c389a R09: ffff8880176d900a
R10: dffffc0000000000 R11: ffffed100366d143 R12: 1ffff11002edb202
R13: ffff8880176d9000 R14: 0000000000000008 R15: 0000000000000000
FS:  0000555555c18380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000011012000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_atomic_set_mode_for_crtc+0x14a/0x4a0 drivers/gpu/drm/drm_atomic_uapi.c:82
 __drm_atomic_helper_set_config+0x255/0xf80 drivers/gpu/drm/drm_atomic.c:1679
 drm_atomic_helper_set_config+0x8b/0x150 drivers/gpu/drm/drm_atomic_helper.c:3263
 drm_mode_setcrtc+0xbae/0x17c0 drivers/gpu/drm/drm_crtc.c:886
 drm_ioctl_kernel+0x33a/0x440 drivers/gpu/drm/drm_ioctl.c:744
 drm_ioctl+0x63a/0xb10 drivers/gpu/drm/drm_ioctl.c:841
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fd888e1b7e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd99378a68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd99378c38 RCX: 00007fd888e1b7e9
RDX: 0000000020000400 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00007fd888e8e610 R08: 0000000000000005 R09: 00007ffd99378c38
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd99378c28 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_mode_vrefresh drivers/gpu/drm/drm_modes.c:1303 [inline]
RIP: 0010:drm_mode_convert_to_umode+0x36a/0xc30 drivers/gpu/drm/drm_modes.c:2594
Code: 0f b7 03 66 83 f8 02 b9 01 00 00 00 0f 43 c8 0f b7 c1 44 0f af f8 44 89 f0 48 69 c8 e8 03 00 00 44 89 f8 d1 e8 48 01 c8 31 d2 <49> f7 f7 48 89 c3 eb 1a e8 19 a2 47 fc eb 05 e8 12 a2 47 fc 48 8b
RSP: 0018:ffffc900034ff660 EFLAGS: 00010246
RAX: 0000000000001f40 RBX: ffff8880176d9016 RCX: 0000000000001f40
RDX: 0000000000000000 RSI: ffffc900034ff720 RDI: dffffc0000000000
RBP: 0000000000000200 R08: ffffffff854c389a R09: ffff8880176d900a
R10: dffffc0000000000 R11: ffffed100366d143 R12: 1ffff11002edb202
R13: ffff8880176d9000 R14: 0000000000000008 R15: 0000000000000000
FS:  0000555555c18380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd888e95270 CR3: 0000000011012000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f b7 03             	movzwl (%rbx),%eax
   3:	66 83 f8 02          	cmp    $0x2,%ax
   7:	b9 01 00 00 00       	mov    $0x1,%ecx
   c:	0f 43 c8             	cmovae %eax,%ecx
   f:	0f b7 c1             	movzwl %cx,%eax
  12:	44 0f af f8          	imul   %eax,%r15d
  16:	44 89 f0             	mov    %r14d,%eax
  19:	48 69 c8 e8 03 00 00 	imul   $0x3e8,%rax,%rcx
  20:	44 89 f8             	mov    %r15d,%eax
  23:	d1 e8                	shr    %eax
  25:	48 01 c8             	add    %rcx,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	49 f7 f7             	div    %r15 <-- trapping instruction
  2d:	48 89 c3             	mov    %rax,%rbx
  30:	eb 1a                	jmp    0x4c
  32:	e8 19 a2 47 fc       	call   0xfc47a250
  37:	eb 05                	jmp    0x3e
  39:	e8 12 a2 47 fc       	call   0xfc47a250
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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

