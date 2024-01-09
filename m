Return-Path: <linux-kernel+bounces-21231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C7828C55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3292E289D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0B43C47B;
	Tue,  9 Jan 2024 18:17:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F23C067
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fcba1d1caso24583175ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824254; x=1705429054;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9q9BQ0S8Z7KHiPZJPX58CFOxs6oGvr+J2FtFtceRXv0=;
        b=CCyxd8Eju8ybFeAeUe32RwgDEnA98Km0SEzJfNnhjYK3bmIKmLJdv4eJGfaKzDIV5L
         tANjzd86h/tS59rXCbH4jo3XlcZHRGFGbNGZjtIOcJI/VaH2x+jLKUCc3n4kVNz0onu8
         wPLdY6kxVL3Dbk6wtyAJ2P99kIRwNlYqP2hp2spUJ3jLLpVq4meMp/gw92fpiYxNimOo
         WojO0WtZ5PvhYcnHiPg9on+1ihHYT4+acMm2yF3Fma4rTI6mXzogd7nAPLc/9NeuCEfm
         69QIQjIcoq85ZIMo56RnE3zVYGP+KusFFl5fGV599m/tVCjC1pceEk6G3G3J/2KEUGow
         DjPg==
X-Gm-Message-State: AOJu0Yy8475f+FerGMud2brg3is6UhayVebc3DPLimryBAoxT5K8nlxu
	Jpz8HZVOdO/QRFAfkqiNyU5APYRCi1OXinaIOZXh4tUaeuSi
X-Google-Smtp-Source: AGHT+IECh7dq0OJhdu8BR4nOMYRpySyGF6OM/CdT6o9s8bEHo6jBLQw5MJf6QeztWdaW1EZtQb1wH5mfqwa7rqayCf9EC4qZfJKz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:35f:affb:bd7b with SMTP id
 s3-20020a056e02216300b0035faffbbd7bmr663388ilv.2.1704824254628; Tue, 09 Jan
 2024 10:17:34 -0800 (PST)
Date: Tue, 09 Jan 2024 10:17:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a0a38060e875458@google.com>
Subject: [syzbot] [ntfs3?] KMSAN: uninit-value in longest_match_std (2)
From: syzbot <syzbot+08d8956768c96a2c52cf@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11a0f711e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e51fe20c3e51ba7f
dashboard link: https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141f845ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1413cf11e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/28ecdd56de1e/disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c5afc17c174/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96ff79b2992d/bzImage-610a9b8f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/689e00cd89ff/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08d8956768c96a2c52cf@syzkaller.appspotmail.com

ntfs3: loop0: Failed to initialize $Extend/$ObjId.
=====================================================
BUG: KMSAN: uninit-value in longest_match_std+0x5d9/0xe00 fs/ntfs3/lznt.c:60
 longest_match_std+0x5d9/0xe00 fs/ntfs3/lznt.c:60
 compress_chunk fs/ntfs3/lznt.c:170 [inline]
 compress_lznt+0x41b/0xef0 fs/ntfs3/lznt.c:336
 ni_write_frame+0xf89/0x1c80 fs/ntfs3/frecord.c:2839
 ntfs_compress_write+0x2521/0x3b70 fs/ntfs3/file.c:995
 ntfs_file_write_iter+0x89b/0xd30 fs/ntfs3/file.c:1081
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
 pagecache_get_page+0x4a/0x1a0 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:740 [inline]
 ntfs_get_frame_pages+0xdc/0x9f0 fs/ntfs3/file.c:794
 ntfs_compress_write+0x1b0b/0x3b70 fs/ntfs3/file.c:944
 ntfs_file_write_iter+0x89b/0xd30 fs/ntfs3/file.c:1081
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 4999 Comm: syz-executor227 Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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

