Return-Path: <linux-kernel+bounces-129922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E07897212
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B8128D253
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F51149018;
	Wed,  3 Apr 2024 14:13:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718E148305
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153609; cv=none; b=QlEScdxzptFds0nhHYAIWXhKBWZzit8GP5f0dgbrVq9ieZ6WvvmzAQ4W7ydfCXuBF+fvwEpEc8O39S7Vv3cYAhz4uJVSJE6/QVAXLVTDcS0pEnvziBK3UbGfyDeaXNmuG+rAJ+//6a/KU2I6G3dcMnFXAU9LJIXuRXrGJg0FeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153609; c=relaxed/simple;
	bh=5DR/t+BsaDUCVW5prg2iwvZWIXMUfk6LhbxcZ3ijnrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SKWuBasNEZTtmZYxBIFpp/k9fTgrMuzbrhTPcqy0PANsjI4U01SoD15s0JEPtmtjl8N7HU/vKmxEoCuvg/ZAtWGKMdNwEBKE0kL26ET4XAwchqcJI1mCu63pb5mM09xEChK4KVZozs1bxC3VoeLb/8AV6n8np7lTG4E7MqvfSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso744981939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153607; x=1712758407;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/LC2AfzSgMN/aIrxG5qCbuvNJ5E86gGDFwmj4kDzNc=;
        b=qalIEj+eh9dZFk/jkx32FaUxpsUfE7MPE4brmP2wIe8NUgwsWXTCTcbPzUOYWQg+W1
         s81trbZbiEWLDaAYIC25igPztQMI1PBsiU21tD3BYKApErX13+qisMf+6AZawtI1M6Wg
         1VcVi8SAUWHMQgm3gCAf7z9nTRiqSRdY3jmgMFSmOuX6hcCW08xaIR1rHtKxcSHu33Cf
         6/P6O6jNVGTF5HCBCHBdsyab6rcBkDmcPQS3h/fnUEqXKbhn51sOwjLi4zufkc4e53rT
         9eZX5mQJZFLqrLTEbqjjH597/fp/AF73r7r8vbrF4SBuo07eWk43xfeG1hOYr5bI3dxK
         qAlw==
X-Forwarded-Encrypted: i=1; AJvYcCVJPot0znDhL0zTmDCsf/UMDeqSSiZMi9BVACaf4Iez+WQNDKOPqYsszNhAzaPQiySlxukMjQdb8YO3M6v57o+4pXM6q0hK1Fc4NWLm
X-Gm-Message-State: AOJu0Yy+bzgQGKiYlTXjXpmIQAXjZ6gKyJNxGpSgN8W2k5LxYqCone4V
	fqMt+l++V1yCpnJgIGQ0+oZtnO0vUiO7sfShUhJT3xDnhHDkeX9qHIoCBUoxXVOUSd20x6NfIW9
	BC2ci+tVzqLHQOCLTzeUUxlecWjG3pybEfSbHo9YWT6HP2scGuZynp8U=
X-Google-Smtp-Source: AGHT+IG8phdUlgV6M4xc4LFRG2yKRIoRM1We8PHkXQgRRGKFa0cGdJOLCHWmbpSc6I1+20iiAE5xfiD9wV6GCiuAwOAgbOPZad0i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b0b:b0:47e:cfc4:319e with SMTP id
 fm11-20020a0566382b0b00b0047ecfc4319emr1158749jab.4.1712153606980; Wed, 03
 Apr 2024 07:13:26 -0700 (PDT)
Date: Wed, 03 Apr 2024 07:13:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bbf19061531d31a@google.com>
Subject: [syzbot] [jffs2?] kernel BUG in jffs2_del_ino_cache
From: syzbot <syzbot+44664704c1494ad5f7a0@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f5f003180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=44664704c1494ad5f7a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166276c5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12049423180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44664704c1494ad5f7a0@syzkaller.appspotmail.com

jffs2: notice: (5072) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
------------[ cut here ]------------
kernel BUG at fs/jffs2/nodelist.c:462!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 5072 Comm: syz-executor610 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:jffs2_del_ino_cache+0x2c6/0x2d0 fs/jffs2/nodelist.c:462
Code: ff e9 64 ff ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 51 fe ff ff 4c 89 e7 e8 25 54 06 ff e9 44 fe ff ff e8 2b 05 a3 fe 90 <0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004527958 EFLAGS: 00010293
RAX: ffffffff82f1f025 RBX: ffff88807ca31000 RCX: ffff888011a50000
RDX: 0000000000000000 RSI: ffff88807ca31000 RDI: ffff88802283a000
RBP: ffff88807ca31020 R08: ffff88802283a36b R09: 1ffff1100450746d
R10: dffffc0000000000 R11: ffffed100450746e R12: ffff88807ca31000
R13: ffff888077a080b8 R14: dffffc0000000000 R15: ffff88802283a000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000760e0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 jffs2_do_clear_inode+0x33c/0x3b0 fs/jffs2/readinode.c:1443
 evict+0x2aa/0x630 fs/inode.c:667
 dispose_list fs/inode.c:700 [inline]
 evict_inodes+0x5f9/0x690 fs/inode.c:750
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:626
 kill_mtd_super+0x23/0x70 drivers/mtd/mtdsuper.c:174
 jffs2_kill_sb+0x96/0xb0 fs/jffs2/super.c:349
 deactivate_locked_super+0xc6/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x251/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7ffb6a6c11c9
Code: Unable to access opcode bytes at 0x7ffb6a6c119f.
RSP: 002b:00007ffe45c941f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ffb6a6c11c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007ffb6a73c370 R08: ffffffffffffffb8 R09: 00007ffb6a7365f0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffb6a73c370
R13: 0000000000000000 R14: 00007ffb6a73cdc0 R15: 00007ffb6a68f330
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jffs2_del_ino_cache+0x2c6/0x2d0 fs/jffs2/nodelist.c:462
Code: ff e9 64 ff ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 51 fe ff ff 4c 89 e7 e8 25 54 06 ff e9 44 fe ff ff e8 2b 05 a3 fe 90 <0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004527958 EFLAGS: 00010293
RAX: ffffffff82f1f025 RBX: ffff88807ca31000 RCX: ffff888011a50000
RDX: 0000000000000000 RSI: ffff88807ca31000 RDI: ffff88802283a000
RBP: ffff88807ca31020 R08: ffff88802283a36b R09: 1ffff1100450746d
R10: dffffc0000000000 R11: ffffed100450746e R12: ffff88807ca31000
R13: ffff888077a080b8 R14: dffffc0000000000 R15: ffff88802283a000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffb6a73d1d0 CR3: 000000007c154000 CR4: 0000000000350ef0


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

