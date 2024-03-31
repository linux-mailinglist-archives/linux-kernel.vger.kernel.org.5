Return-Path: <linux-kernel+bounces-126083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF608931D5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7495E1F21BCD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA7144D32;
	Sun, 31 Mar 2024 14:03:40 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E21E89D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893819; cv=none; b=i2HMyVoyvhE9VCbZ+A99vKsaDlyQ5iMT/klaAfpWMLVihMtMqiY4bSS9Ow4bDpO/zjjQ1BDmg8aSkFM8yhrhXq/28UsZMrhOCibnx25K3Otd0pvCEpM5UFyd5+SKXLLAKnbQ02/wUmWEvI8QMIq2kR5LcwjXtGFZdYgEQevS5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893819; c=relaxed/simple;
	bh=wUSW9LqsrSAUirjrhNY5njzAOVEfjesshfnxele6fVo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pefoeg/oujzybsZaZ8yQHJYwV6yMYRg0ZMCkn95X718URyHUY0vAd9NOxYYlPaCF12JkSlH524IcjmKM7vmXl1vze5cDHP+3SGNSyTmLus7msEERTNN4biUS1C0pVHIvQwX/ScWNh/7YckUuncoczYQ2eBizS18WVBT0meGQuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so373539539f.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 07:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711893816; x=1712498616;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzeZFeJOoWqOq3H/iqGThuQgA4nu8lolb31b+7mSRYE=;
        b=iiCEjkixU2CQB5rwi1qwVIQdeDXIKqWfUrD9BanX0yNRZKberw/s7jJbCQ1wwFy7UO
         4EDVUOStV0TbMmK2IXqd48mdwpiYlYF24TXA/pP9G/8q/vws3rlxpNoy9PT4kiaTWZ9o
         yFT02KHKbwtYvmWQl9VcKoBC5aZT5LvszBGpo2mbsSUB+NKzrGQwqT31wXaZGWXG0qPg
         M0av7MmzkQI1NP5NnB+zRi3/8jRMbWMyLC0t28kGYBOO9E2WbjruxBvQGRW2c7BQYBgz
         dxSNvHXRmhiysXrsSax8eZ3MkBbtvNzxcINXCPyPMeAie3l1m9+1x9s49P9j28S6gxPq
         B5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVjI9j9XQCAm/a66gjVZGcrSUUFdOuh6wOVqvckf16cLCu0TEm+hkCbOe1+ZZAg32lkFdfnAZM4oibDGKxaf7UPPmmkXx4w4VvmcEdu
X-Gm-Message-State: AOJu0Yw85S5h5cHIa79A6ntwdHJAeozmIoc10jKtXk+/8+AWNhjvumvy
	5siJzsBwJUIQ0tpxK46NFyUTntA4LvkOKsq0XW/HQJRApAwqOcX0zX1eVw8rF1sdZqZtycjztpx
	QP7L1eNqKs51l1ANkvv6JAxa6xsSC+xa8hSWoRPnIxNgMpRJuiBwCj94=
X-Google-Smtp-Source: AGHT+IGqn+NPemPvC+MYYH5SobrE+soYgZw4OQfVWD89IxCSHPuK1TcUjPFTYZqB4aAD0fQEkC7FzvqKqzri7lcDPCu+WviptI9e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:340f:b0:7cc:66b1:fa95 with SMTP id
 n15-20020a056602340f00b007cc66b1fa95mr162643ioz.3.1711893816083; Sun, 31 Mar
 2024 07:03:36 -0700 (PDT)
Date: Sun, 31 Mar 2024 07:03:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd1b930614f5568f@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_iget (2)
From: syzbot <syzbot+c2275f11e063b8f99825@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10a6d421180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=c2275f11e063b8f99825
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155b2029180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129bead9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8e035569ef03/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2275f11e063b8f99825@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ea_inode->i_rwsem" with key ext4_fs_type, but found a different class "&sb->s_type->i_mutex_key" with the same key
WARNING: CPU: 0 PID: 9266 at kernel/locking/lockdep.c:935 look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 0 PID: 9266 Comm: syz-executor362 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:932
lr : look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:932
sp : ffff80009cd170e0
x29: ffff80009cd170e0 x28: dfff800000000000 x27: ffff7000139a2ea0
x26: ffff80009341f300 x25: ffff80009341f000 x24: 0000000000000000
x23: ffff7000139a2e58 x22: 0000000000000000 x21: ffff80008f027b98
x20: ffff0000de282200 x19: ffff800092024890 x18: 1ffff000139a2e5c
x17: 0000000000000000 x16: ffff80008ad6b09c x15: 0000000000000001
x14: 1fffe00036800002 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : a911bda9a52fff00
x8 : a911bda9a52fff00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009cd169d8 x4 : ffff80008ed822c0 x3 : ffff8000805ba130
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 look_up_lock_class+0xec/0x158 kernel/locking/lockdep.c:932
 register_lock_class+0x8c/0x6ac kernel/locking/lockdep.c:1284
 __lock_acquire+0x184/0x763c kernel/locking/lockdep.c:5014
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:804 [inline]
 ext4_xattr_inode_iget+0x344/0x4dc fs/ext4/xattr.c:461
 ext4_xattr_inode_get+0x12c/0x37c fs/ext4/xattr.c:535
 ext4_xattr_block_get fs/ext4/xattr.c:613 [inline]
 ext4_xattr_get+0x5d0/0x6f4 fs/ext4/xattr.c:714
 ext4_xattr_trusted_get+0x40/0x54 fs/ext4/xattr_trusted.c:27
 __vfs_getxattr+0x394/0x3c0 fs/xattr.c:424
 vfs_getxattr+0x268/0x2c4 fs/xattr.c:457
 do_getxattr+0x1e4/0x480 fs/xattr.c:739
 getxattr fs/xattr.c:772 [inline]
 path_getxattr+0x29c/0x388 fs/xattr.c:788
 __do_sys_lgetxattr fs/xattr.c:806 [inline]
 __se_sys_lgetxattr fs/xattr.c:803 [inline]
 __arm64_sys_lgetxattr+0xa0/0xb8 fs/xattr.c:803
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 57
hardirqs last  enabled at (57): [<ffff8000809fe3d0>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:234
hardirqs last disabled at (56): [<ffff8000809fe268>] kasan_quarantine_put+0x38/0x1c8 mm/kasan/quarantine.c:207
softirqs last  enabled at (8): [<ffff80008003165c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6): [<ffff800080031628>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---

======================================================


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

