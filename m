Return-Path: <linux-kernel+bounces-11711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962B81EA61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AFCB221F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3195C9C;
	Tue, 26 Dec 2023 22:45:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEA5240
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7018c9476so414577939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 14:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703630725; x=1704235525;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nke+NuDTG3SF317vq2MpQrzWpq09bUxj2nkltl846bc=;
        b=olSlONT2b9iyQ3BgMCHgO4baCcLHRghvo6DVfMW4fVg+pbvfJab6bsvqNrItQFQ52T
         rJmnFp0/HvJIbIM/3QjWGD1mJtYDd9nEhAHhDyUbx5aL/Ok4d3j9LAl6/cB8nYKtP8S2
         YEiy7chQpBDIZ8NoDOVmapn/t5DKx6eMzfVVEvIv4RdgKigtTi4bfufDHY1qEVeyF5WA
         aerhuLJ9AWdnjQhyS5gJrcQkqEVos8ujv4x8p/hvWz3W/giSntdUJ6v8bZ0pVfjGPuzJ
         NCWaOYDOzO6uo7sqhqiFt+Ij6hcAUdYmLAedv6cPWivBIc9EaQmE7fpiDFElHKpj5ctQ
         P/vA==
X-Gm-Message-State: AOJu0YxhWr/+NQwiEkXmo/T4VzOZ/NkDe3Kw/W+1POR2WTAvB/+bapE4
	9WlQgpy9NcrqC7kduS5i+gG4e7DnspX7A0bWTMbUKiOJeiLS
X-Google-Smtp-Source: AGHT+IHuDTZsqnd8xy0l8/SU3PH28hBPLvDTkA5IVQOxEtIABO7SSMUTpcBWlotQB4YReZyDtGyEUuqdGt3j7sQXcPROD490VNu+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be1:b0:35f:e864:f6f with SMTP id
 y1-20020a056e021be100b0035fe8640f6fmr1084863ilv.0.1703630725497; Tue, 26 Dec
 2023 14:45:25 -0800 (PST)
Date: Tue, 26 Dec 2023 14:45:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038cf2f060d7170a9@google.com>
Subject: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in ntfs_listxattr (2)
From: syzbot <syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aafe7ad77b91 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15412f76e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23ce86eb3d78ef4d
dashboard link: https://syzkaller.appspot.com/bug?extid=65e940cfb8f99a97aca7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10627f76e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1400171ae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23845238c49b/disk-aafe7ad7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1144b0f74104/vmlinux-aafe7ad7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6db20df213a2/Image-aafe7ad7.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4f0ec668b8cf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
ntfs3: loop0: Failed to initialize $Extend/$Reparse.
ntfs3: loop0: Mark volume as dirty due to NTFS errors
==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_list_ea fs/ntfs3/xattr.c:232 [inline]
BUG: KASAN: slab-out-of-bounds in ntfs_listxattr+0x354/0x50c fs/ntfs3/xattr.c:733
Read of size 48 at addr ffff0000d0125c30 by task syz-executor346/6095

CPU: 1 PID: 6095 Comm: syz-executor346 Not tainted 6.7.0-rc6-syzkaller-gaafe7ad77b91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 kasan_check_range+0x254/0x294 mm/kasan/generic.c:187
 __asan_memcpy+0x3c/0x84 mm/kasan/shadow.c:105
 ntfs_list_ea fs/ntfs3/xattr.c:232 [inline]
 ntfs_listxattr+0x354/0x50c fs/ntfs3/xattr.c:733
 vfs_listxattr fs/xattr.c:494 [inline]
 listxattr+0x108/0x368 fs/xattr.c:841
 path_listxattr fs/xattr.c:865 [inline]
 __do_sys_llistxattr fs/xattr.c:883 [inline]
 __se_sys_llistxattr fs/xattr.c:880 [inline]
 __arm64_sys_llistxattr+0x13c/0x21c fs/xattr.c:880
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Allocated by task 6095:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0xcc/0x1b8 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 ntfs_read_ea+0x3c0/0x808 fs/ntfs3/xattr.c:118
 ntfs_list_ea fs/ntfs3/xattr.c:204 [inline]
 ntfs_listxattr+0x14c/0x50c fs/ntfs3/xattr.c:733
 vfs_listxattr fs/xattr.c:494 [inline]
 listxattr+0x108/0x368 fs/xattr.c:841
 path_listxattr fs/xattr.c:865 [inline]
 __do_sys_llistxattr fs/xattr.c:883 [inline]
 __se_sys_llistxattr fs/xattr.c:880 [inline]
 __arm64_sys_llistxattr+0x13c/0x21c fs/xattr.c:880
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

The buggy address belongs to the object at ffff0000d0125c00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 48 bytes inside of
 allocated 60-byte region [ffff0000d0125c00, ffff0000d0125c3c)

The buggy address belongs to the physical page:
page:000000003d4f3554 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x110125
ksm flags: 0x5ffc00000000800(slab|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000800 ffff0000c0001640 fffffc0003376b40 dead000000000003
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d0125b00: 00 00 00 00 00 00 02 fc fc fc fc fc fc fc fc fc
 ffff0000d0125b80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff0000d0125c00: 00 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc
                                        ^
 ffff0000d0125c80: 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc fc
 ffff0000d0125d00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
==================================================================


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

