Return-Path: <linux-kernel+bounces-109831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF81885639
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FA01F2207F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3BB4084A;
	Thu, 21 Mar 2024 09:11:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C994C2E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012289; cv=none; b=cIg/ioGGxCAvaf5pWD8bilfrN4HSFWTMmn5iEmkXGeyPbI1er8zbnwZT5sMHvweO8lmxLNRc9WuymaLXVHVV4k56cLRdK/GF65VqFSykKSjvnKCSSAUIrQrQUMEMp3eH8cDGutfH7Y4qW0AX3Ojr6IM0xC8cfMThEZxBvFZJ3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012289; c=relaxed/simple;
	bh=4p2q6rst3MSLkj/marzYZrBJYnvNL2MkgRCx9XGEW1M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WLp+MRJkBdG1iyEZpqq6BHFJx3EUDK+Vt98yH1mG3usTpvo/uzloZDv7fy8zy3APStRGLw/t6xdanooeT7hdZS6X+Hfuq0sCTzblMyIDUbGNDNwmjdumED6ZlUNv6BwIXf94HflguDPfzt//rnCIEx6YAH+dE/mED/A+Zt3xCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1aea97fso77815339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711012287; x=1711617087;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2nxkyW3QnJtQkkJ/xHRsWAFnQAiQ6b/LmgvW4wXuTI=;
        b=oTeBIWARW1SKHr9mTgjMy3WDL2VnqEzjvBaHP++FjfEKbBnd5UzHNXl1BmCSTiRVZb
         Mietxe4HHsBonAy7Et2dBdc1fPU+9moLUfXyt+RSry06og4HgC3uflxW9Hnpia3ZgVVV
         5ABpLZ3sYo+z9KNfm25oWVCjzL1HjK/nxoQqENM5t/EOjn7E832YyxmmVkE5S8y0AguG
         HNFILer4EQHlU9hjZpy6JInxnY8cliKjNVLvHmMHfmUqjF6eiQYZJjTP+F53plpaYVoj
         TWL1EcjmjffbfvXrOtGIuBetCTgssGLN2bq7dZ5+KO3r4JQ2VFQPlT63kL3FNuaSRU7k
         62PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRsJpi6cGSzv2PdBvxteLf8HpZu/RfEn1VtuYSrPt17h2YGHkSe0nJrAhhmOlemRCW4bXuFIFwiewTNrgwhL272B9TmqO+CYkBnsvq
X-Gm-Message-State: AOJu0YzXb6e/E2ok+npmQUvElCBCjC6n3O55Ah595IO/GkS5X/vqFM+S
	QWNsbd4Uc1M0pjZZPwDcTIDUHjI+MGYSFZOA20BUjUSaxOYrKk/ERMGV8GqB32zvb7k9BO+j9Pa
	sMCfkh88/ZAUQZJQ/6bUSDwp4ytqxAl+hqYWAUM+IZxUuR6NMcM1JMjU=
X-Google-Smtp-Source: AGHT+IGiLoeeCHi6SR3q+Mh4SfPW4HcQeJ2EaF9K7KbAUHSePrFH5jmv1YDzZZEhYE1HOwDvz/2s+y9ErXgGqVmDF6qm8C2yujdd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210d:b0:476:f2bd:d636 with SMTP id
 n13-20020a056638210d00b00476f2bdd636mr842624jaj.2.1711012286809; Thu, 21 Mar
 2024 02:11:26 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:11:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fd9bc061428179e@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfs_find_1st_rec_by_cnid
From: syzbot <syzbot+65f53dd6a0f7ad64c0cb@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a4145ce1e7bc Merge tag 'bcachefs-2024-03-19' of https://ev..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1312764e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c1d7ee7e74661a8
dashboard link: https://syzkaller.appspot.com/bug?extid=65f53dd6a0f7ad64c0cb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737d879180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f5c2a5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce90c7e9c4b9/disk-a4145ce1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc2e82754c55/vmlinux-a4145ce1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfc8b656ea07/bzImage-a4145ce1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/acef21cf3ab0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65f53dd6a0f7ad64c0cb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfs_find_1st_rec_by_cnid+0x27a/0x3f0 fs/hfsplus/bfind.c:78
 hfs_find_1st_rec_by_cnid+0x27a/0x3f0 fs/hfsplus/bfind.c:78
 __hfsplus_brec_find+0x26f/0x7b0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x445/0x970 fs/hfsplus/bfind.c:195
 hfsplus_find_attr+0x30c/0x390
 hfsplus_listxattr+0x586/0x1a60 fs/hfsplus/xattr.c:708
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x6e4/0x1000 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 hfsplus_find_init+0x91/0x250 fs/hfsplus/bfind.c:21
 hfsplus_listxattr+0x44a/0x1a60 fs/hfsplus/xattr.c:695
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x1f3/0x6b0 fs/xattr.c:840
 path_listxattr fs/xattr.c:864 [inline]
 __do_sys_listxattr fs/xattr.c:876 [inline]
 __se_sys_listxattr fs/xattr.c:873 [inline]
 __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 0 PID: 5013 Comm: syz-executor378 Not tainted 6.8.0-syzkaller-11743-ga4145ce1e7bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


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

