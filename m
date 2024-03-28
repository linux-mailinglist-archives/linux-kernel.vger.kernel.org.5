Return-Path: <linux-kernel+bounces-123058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309089018E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76E51C2BA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF048565D;
	Thu, 28 Mar 2024 14:20:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3080C11
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635632; cv=none; b=MwgUYXi7qA3mfwS4+RPGUbbTNPGQtYS1zTYZ3j05597D0p2NwtNnyusaZarAYc51/9CQ2JojxTcQ8ovpEYznVowVXkFhd0j+/uhgZYESy/cnp3UuUGOIN3bVUpr6e+jsFunKzaUASD/X4W392W+MYQS8brjneWCW3DjKzlg9dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635632; c=relaxed/simple;
	bh=T8DLcIMd2SwGMGXpo5o6c1OWUqQbagaVQM/hTLTTZaM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uRWQyBEjps7u5RBEEY/Tw9THu6BQvi4DxYYjy2r0PjxqtU7zJI7GVHm98pocyAqQHudJsTbATB1t1F6wTb2yk+ruCsBJ9GkRHkrScl3Aa23d4aoLQndWVddHUxK5O9GhUztklbCLtE4Wmhu9CvLoeaeQWq3qqS7+CLs7k6TQ6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d096c4d663so11328439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635630; x=1712240430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kehk7qvxJZP+l6TvYnKQNOGXzfsQSvUSobZ1QiEcyr4=;
        b=VwjQ/I4o6OCMmGDWJH4V1WvN1yi9GWkkyubK2wz6z4FouBh/zPOujI/udPrGKpudCN
         609jG51pXKjhtN1UJ6dFElbu09tOH3BCrd/oM7IEDD8Z1DJ0zGp0D38SJMX6AZohIACa
         tWm+aZgfmcsNi3f0gKA2Z5liqutlJnU1fmVc8GFJ6ykm4F/DpYA92CW9kLo3Iz5wFbPs
         g12cijWQ+AV5zdw7wb6fdD2GBiBE2FCcr+vkj8gRHrWhW2/V/5Nl132RTeqKBq1/ccCM
         XKk9xMkmu24aO34qn+SYd6GSeoY1jirf3jlzfaM2vA9o7i3+htiRlMa8Thz/xRezeVQp
         DqLA==
X-Forwarded-Encrypted: i=1; AJvYcCVPXKk1PupbYY+H/PywfQJdCc9J5FkN+UwRdqYffNL25ph7jtuuDl3YWzkmXKLFeRzDYMZqZQe1ORkaREL3ob8swQSS8dstngZwS/DU
X-Gm-Message-State: AOJu0YxqZJNYdv8xxO+ZQBgeg/BrwNM7VqawkeUGAHdggKPo5m4f0Rww
	AJsgTM0ox2mfTgaa0W1dJjJaP7smUNME/CWity30THo6VgneHDxhy3INZqiu49pRTnFnOrh5VTa
	PA3ne9j0mGVOra7PtQPoJtN9Zv3avBKoS1bV0KftK9jKKwub2XEJHqzk=
X-Google-Smtp-Source: AGHT+IHOQEDKEzHMPEyNia95LF4eqnhBYXOxv4nISoba8zmXfetT82PhsR/uf4+tnT3yCeFM1un4zFCaMoHGDCSRlqr6DT6N/wv0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:506:b0:366:a77e:62dc with SMTP id
 d6-20020a056e02050600b00366a77e62dcmr53014ils.2.1711635629257; Thu, 28 Mar
 2024 07:20:29 -0700 (PDT)
Date: Thu, 28 Mar 2024 07:20:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aacdcb0614b939ad@google.com>
Subject: [syzbot] [fs?] WARNING: ODEBUG bug in bdev_super_lock
From: syzbot <syzbot+9c0a93c676799fdf466c@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d1c4f9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9c0a93c676799fdf466c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16577eb1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106fa941180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c0a93c676799fdf466c@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 5462 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 5462 Comm: syz-executor454 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Code: e8 0b ce 4a fd 4c 8b 0b 48 c7 c7 c0 dc fe 8b 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 fb 52 aa fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 1c f7 d9 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000909f918 EFLAGS: 00010286
RAX: a857c73db866d400 RBX: ffffffff8babd760 RCX: ffff888026321e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8bfede40 R08: ffffffff8157cc12 R09: 1ffff92001213ec0
R10: dffffc0000000000 R11: fffff52001213ec1 R12: 0000000000000001
R13: ffffffff8bfedd58 R14: dffffc0000000000 R15: ffff8880267c6880
FS:  000055555d3d6380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2334c3f130 CR3: 000000002c7fe000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 debug_object_activate+0x357/0x510 lib/debugobjects.c:732
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common kernel/rcu/tree.c:2719 [inline]
 call_rcu+0x97/0xa70 kernel/rcu/tree.c:2838
 put_super fs/super.c:424 [inline]
 bdev_super_lock+0x1ea/0x360 fs/super.c:1384
 fs_bdev_sync+0x17/0x50 fs/super.c:1419
 blkdev_flushbuf block/ioctl.c:380 [inline]
 blkdev_common_ioctl+0x88e/0x2880 block/ioctl.c:512
 blkdev_ioctl+0x532/0x740 block/ioctl.c:634
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:890
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2334bc5b69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe40c66978 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2334bc5b69
RDX: 0000000000000000 RSI: 0000000000001261 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00000000000000a0 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000014ed2
R13: 00007ffe40c6698c R14: 00007ffe40c669a0 R15: 00007ffe40c66990
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

