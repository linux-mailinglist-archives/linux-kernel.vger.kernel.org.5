Return-Path: <linux-kernel+bounces-136221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F789D165
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6689F1C247C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA155772;
	Tue,  9 Apr 2024 04:04:21 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504255C36
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712635461; cv=none; b=BdmXSGQN4RZT6bO/8f+CcVtjsxFMfwJpLDJOBQFRqIJ3OdcEAbE722QoyfPHQorEUXh9yQJkvXDOa2Ye9iFxtStrCXkQUPR7Ezyuo960nWMpxNT0PH9J1qn1lXbavAkiQ/5KacOgZV8foaw1+ppja2QVX3hbmY/ArXQst+6PDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712635461; c=relaxed/simple;
	bh=M88hh0q5nz4CB3joHjJWVyNvXan1l7fMRD3dEb26YdQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uVBmYGfOqosKAGPE2HZTrNnXfaVAtm5nKJQulLTBJ3t/Avo8ArM8KuuHJEW++RyvIFQE5ux5fNiC7X6WWdrN15aI7HiJ53hq+emESu6z7ZD+8Kq1a1OmMduPk6CTgPZpMsEJaGuKu+0nhwi9R/FZleCnVhHPSjhFpij5Rx5sTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5ea080228so121355139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 21:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712635458; x=1713240258;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWlkGwpCS4AEREx1qQsF66IuZx2lwVJxUADQIFWOP1o=;
        b=gpo94DSKKBQUneLqw6VZdVjhQCRwkROcmHaP8xQXAUj6NuWFl8hKc0s0UrLbIu8aq1
         SlQKOUMIEUKP7xW9O7x38Lec37ZidLt+eIF/egEcEAfB14oUxYRVodH65nKbg9UJms7H
         W4MdvVKAtWQEkXtBjGek1Sn5vEpxYcrfg6a2nmHyAVSdvHyEGHxF9sSkwXSf1aNY5kpf
         FMiHHfAkpD3MYgczvpVv33G7TSzJVVO8/iaHCawQrJPDeUl+s1uxKSD0KLZ3XLwWDMaj
         novf0iKlxShvjsfbpcM0rL9LlNAkbm4jT0a6nwlBacsdovL8hSu0mMceocK2q/sWU5Pg
         b+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUXvTo+pW45cCgxqkHrR2DuYaiyGYNSWRJvdcgaPt+PkXLTCr+h87uTDWOJVmbh/UYrWzCuzTl/OKIDLU79q9wz0NMsjxa9JiWRtzDO
X-Gm-Message-State: AOJu0YyszDrmWVd81OiymoRpc/pgWpsMw8wj9jGmVWK9bramHtFIRlwk
	qs0Cu9b23V7VUfm+0XmNczlgXWl3Zt8JTYimsoSHuCEkyPqH+0QcQHdt6Nb7FHyyey5TXx6vaCi
	Ry3sw0wWt6MLwpsso6/kKNzbIK/KGHezWGFJjysUycCGQV+Ix1q4/sNQ=
X-Google-Smtp-Source: AGHT+IEKKNuE7uGXVopRlEK/WgQ3IzzUb5gH0u8X5ebF1E23ig+B7en/1YIkUdeLGtseRsTlWyTVYi0vy4dt/QawnTilU7i6MnPl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3419:b0:7c8:56ec:ac1 with SMTP id
 n25-20020a056602341900b007c856ec0ac1mr76532ioz.2.1712635458629; Mon, 08 Apr
 2024 21:04:18 -0700 (PDT)
Date: Mon, 08 Apr 2024 21:04:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002444e20615a20456@google.com>
Subject: [syzbot] [ext4?] [jffs2?] [xfs?] kernel BUG in unrefer_xattr_datum
From: syzbot <syzbot+b417f0468b73945887f0@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, dwmw2@infradead.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1562c52d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=b417f0468b73945887f0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e74805180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1613cca9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/f039597bec42/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/b3fe5cff7c96/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b417f0468b73945887f0@syzkaller.appspotmail.com

jffs2: nextblock 0x0001d000, expected at 0001f000
jffs2: argh. node added in wrong place at 0x0001e03c(2)
jffs2: nextblock 0x0001d000, expected at 0001f000
------------[ cut here ]------------
kernel BUG at fs/jffs2/xattr.c:411!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6173 Comm: syz-executor110 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : unrefer_xattr_datum+0x3a8/0x3ac fs/jffs2/xattr.c:411
lr : unrefer_xattr_datum+0x3a8/0x3ac fs/jffs2/xattr.c:411
sp : ffff8000978575f0
x29: ffff800097857600 x28: 1fffe0001aaffe23 x27: 1fffe0001aaffe28
x26: dfff800000000000 x25: 1fffe0001aaffe24 x24: ffff0000d57ff120
x23: 0000000000000001 x22: ffff0000d57ff118 x21: ffff0000d7d3a000
x20: ffff0000d57ff100 x19: ffff0000d7d3a638 x18: 1fffe000367fff96
x17: ffff80008ec9d000 x16: ffff80008032116c x15: 0000000000000001
x14: 1ffff00011ea7bfa x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d5131e00 x7 : ffff80008005fa20 x6 : ffff80008005fc1c
x5 : ffff0000d6092c08 x4 : ffff800097857368 x3 : 0000000000000000
x2 : ffff0000d57ff118 x1 : 0000000000000001 x0 : 00000000000000ff
Call trace:
 unrefer_xattr_datum+0x3a8/0x3ac fs/jffs2/xattr.c:411
 do_jffs2_setxattr+0xde0/0x1158
 jffs2_trusted_setxattr+0x4c/0x64 fs/jffs2/xattr_trusted.c:33
 __vfs_setxattr+0x3d8/0x400 fs/xattr.c:201
 __vfs_setxattr_noperm+0x110/0x528 fs/xattr.c:235
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:296
 vfs_setxattr+0x1a8/0x344 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x208/0x29c fs/xattr.c:653
 path_setxattr+0x17c/0x258 fs/xattr.c:672
 __do_sys_lsetxattr fs/xattr.c:695 [inline]
 __se_sys_lsetxattr fs/xattr.c:691 [inline]
 __arm64_sys_lsetxattr+0xbc/0xd8 fs/xattr.c:691
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: aa1803e0 97c66b4c 17ffff47 97b31b25 (d4210000) 
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

