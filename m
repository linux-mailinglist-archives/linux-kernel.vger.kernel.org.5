Return-Path: <linux-kernel+bounces-101341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A6487A5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B1A282A24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC13BBF0;
	Wed, 13 Mar 2024 10:23:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616A3A292
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325408; cv=none; b=qts2tHTh1K6K24PPZmWyyJWU7JXwDmvJuHnDTJ5WvMDHxcZzt/Hy+S59ffioA/WppSiXxmOm3xuU+ghKnV06+V93JOsH9I9aWiJ5Ji7CjHQvis+XN3AtiLQR+n5TrtxXqp42xallqZvoVVUa3tk9w8tUTgz3+Foa/RPuh4brw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325408; c=relaxed/simple;
	bh=gxNUi5JOhIBKz4JZ7h0Xc0lDv+cP7TG6n/WSHrDEO20=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uY1MrEF4RpC4SmgUM5MUAJMKBGmzFJ+vBtaNnvkOgbPVafDecl+DQkGWsHoAuwppgL367YdGw42yXBKS9Gudbz4doWtM3HmONRwLoxhRJvkL/UWvZD1/f1j8mi/Hts0Oo+xi4QtjVzoFdo28r/s79BBTStAQGDVwQD+t1lG6sBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3665283d42cso10735175ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325406; x=1710930206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZLwqqlJE+5HGJf4mXsjYm3BkGH4mIvyOCTpLxs/VCg=;
        b=jNjb0TZRHem1xHN6BhvFWVkiqY/C6n32Sy3NIyYgiB6twRwpAZdEbpw7E45O3LYsJC
         FhQ2URplG8B40ooahqNdR4oJjjznkndIQxAa6xihHyQeP1xeE8sqnkB/dZc8UpzC533R
         O/ZRTw/FTdLvy2ZYtwN1dVI5d0+3FJ3nPoAgVxfXJOPMVSnFnkDyYKWewQEnbFH0eoAD
         aWoY5wyU9sn7d0zf0QpEZUWmciyfSW8qWKzA+3uwcVBVfq19Bt2eXOS4kMMu1imm1ZkP
         b2iWYSkOMpLt8oPKa2HJW/1oSuztKLbNa9VVOF8DSwu9/tuGPJa18++u9wyyRyWtdsiT
         2Lhg==
X-Forwarded-Encrypted: i=1; AJvYcCWfueeFE6XNHyX8sjo9EXfU6r4fzXlpjcm/ShmO7KWgykQYIvNMhd48aVNQ31wuqZH1GsdCUlnBPDwFNllIlwQLCjackuGm1JEVWgEr
X-Gm-Message-State: AOJu0YyuEdKYLkI/K7c7OlKJ+O1n8y2gnfyutcBZGBVIl8PdWmQXc0t3
	g8O/SA0jLdwmdEnhuF7nhxj7EoyC6eW3fH5z4NxkyFbdm16H/VJeaVl7zgdteBhWaLJ1464eUjY
	4xChsuH3WBDqUBewBhcBCGexQf/l/gVZf6OD7EpSS41DHQHbqALLzFoI=
X-Google-Smtp-Source: AGHT+IH0VEwwmBny+J6rfV/6R0AANdqIP4Jrq6CA23rSQWZ0qT4XcllMQySk1L+aa9dIvUBT/++8YwwYn0lo/rYqKOXLt5RRZohw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:366:4cdc:7053 with SMTP id
 i1-20020a056e0212c100b003664cdc7053mr160152ilm.4.1710325405824; Wed, 13 Mar
 2024 03:23:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 03:23:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043c5e70613882ad1@google.com>
Subject: [syzbot] [overlayfs?] WARNING in ovl_copy_up_file
From: syzbot <syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1785a859180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=3abd99031b42acf367ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1115ada6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1626870a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com

evm: overlay not supported
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6187 at fs/overlayfs/copy_up.c:239 ovl_copy_up_file+0x624/0x674 fs/overlayfs/copy_up.c:330
Modules linked in:
CPU: 0 PID: 6187 Comm: syz-executor136 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ovl_copy_up_file+0x624/0x674 fs/overlayfs/copy_up.c:330
lr : ovl_verify_area fs/overlayfs/copy_up.c:239 [inline]
lr : ovl_copy_up_file+0x620/0x674 fs/overlayfs/copy_up.c:330
sp : ffff800097997180
x29: ffff800097997280 x28: 00000000fffffffb x27: ffff700012f32e3c
x26: 0000000000800000 x25: 0000000000800000 x24: ffff800097997240
x23: ffff800097997220 x22: ffffffffffa64000 x21: ffffffffffa64000
x20: ffff0000d9fc1900 x19: dfff800000000000 x18: 1ffff00012f32dee
x17: ffff80008ec9d000 x16: ffff80008ad6b1c0 x15: 0000000000000001
x14: 1fffe0001b9177f2 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7568000 x7 : ffff80008108d924 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008031a200
x2 : 00000ffffffff000 x1 : ffffffffffa64000 x0 : ffffffffffffffff
Call trace:
 ovl_copy_up_file+0x624/0x674 fs/overlayfs/copy_up.c:330
 ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:863 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:976 [inline]
 ovl_copy_up_one fs/overlayfs/copy_up.c:1168 [inline]
 ovl_copy_up_flags+0x16d0/0x3694 fs/overlayfs/copy_up.c:1223
 ovl_copy_up+0x24/0x34 fs/overlayfs/copy_up.c:1263
 ovl_setattr+0xfc/0x4e4 fs/overlayfs/inode.c:41
 notify_change+0x9d4/0xc8c fs/attr.c:499
 chmod_common+0x23c/0x418 fs/open.c:648
 do_fchmodat fs/open.c:696 [inline]
 __do_sys_fchmodat fs/open.c:715 [inline]
 __se_sys_fchmodat fs/open.c:712 [inline]
 __arm64_sys_fchmodat+0x118/0x1dc fs/open.c:712
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 862
hardirqs last  enabled at (861): [<ffff8000831abcb4>] percpu_counter_add_batch+0x210/0x30c lib/percpu_counter.c:102
hardirqs last disabled at (862): [<ffff80008ad66988>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (62): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (62): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (53): [<ffff80008002ab48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---


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

