Return-Path: <linux-kernel+bounces-132508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F288899605
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25281C21ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2680B2C842;
	Fri,  5 Apr 2024 06:56:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CE1773D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300190; cv=none; b=qANxXiE8Ld5u7Hy60nrPZTMgM9IhYgVdcuvftUFQnQzhGyKoauHIMqQ18u1F0Q8ybTrSQwYKQRLBx+GHdfzHTtzSLorPFUtPtuGHcaeY0cbsmFA2pfhss4JwVOFVLjW9MFcHh7GDO+N6G0O3j7FvhSdtuXs2B3upVJSaCr+SNQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300190; c=relaxed/simple;
	bh=gDMVllhnT932TOSdLK/u+zi4hxHD4N3fx2nq0/sOx88=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cog3TM9dXyeWkrVUGVEoX/WLJCc/yyTcr+5VS/BZDiNxn7v38L4zHO1YUYFl1yF1TnmMnWpa4RDDqcGT8+AE1xY9YMhRVRu+XWuJJ83VuhoXMQxgC0vpPxFQRjipSOyVjesUF084DCT746ES6w6AX24Mf1OvE6iXmHCGj/az2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a110aa753so572645ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300188; x=1712904988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYjKx/HLC8a6QBEcbZBi8JtVjp7e8Bp3kfPi4+LZysU=;
        b=Zqr1AEVUS7lB1Xm1RhyZrAve3Fx5X6zpRuPjfG4Y0XOyEwPIE0v5V+sV7x8nzePVmt
         bsluRxyb6+AoZS2iNO+1QlWu0+efhWKJPQdObiABJtOIlo/JzOb6R6XzL5txSwhvVavk
         dWhZoBDw573WQQcVEVvCaA+MQjR0ZbfWjtXalkv5hE5rCQaFSZfbROmidRe+WbvKIT92
         VCzyCXSvekbgPg0wVo8xf0VKT2J0jvu6CeidGv/lb/IqbME3gyFqY8ry0cTYL0f7XCmt
         xB8GXXLO74hTell5eMSTiDPfJeTl+0R+Ck7TIuailaA6KVkqpB0HyxsO2VogBSYAU6aD
         +cLw==
X-Forwarded-Encrypted: i=1; AJvYcCWTapXxyRYkQ7+tdP3ZQSuRRMFiIAbtXSaSUNNem/EKZ0GIbRQcqZ+igrXtz1KfKpBrqo/Q4atHTg/AL0AAkrF6LRda+zo6LeBhkVVr
X-Gm-Message-State: AOJu0YxCdeOMReBOEIkSAimLKGwARlFUhBwFHUC7OGkO+1VPTYRg5C5i
	kLrLGoJVDxLOGNp12t+qDsGlpqTDbjkPGBHzd7RU+JXnhPXOuqG1peIhGiFp61+3saNUUs1onW9
	KhPB0zXOBofOiD8CZ+AQb59U9NB9KQldfd9qPkYi8gbz6PC+PRVXLez8=
X-Google-Smtp-Source: AGHT+IG7NzM9H65HaU3CG5QdeJ6qpOanxZrLWfFsP9tTlCpOYEifcVWamCgALv3y5D21sSZ0K79EUeZElMqdEbYHk1mqmTj6FAc/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:369:b802:d3e5 with SMTP id
 k15-20020a056e02156f00b00369b802d3e5mr34477ilu.4.1712300188059; Thu, 04 Apr
 2024 23:56:28 -0700 (PDT)
Date: Thu, 04 Apr 2024 23:56:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007558ae061553f41b@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_sock_setsockopt
From: syzbot <syzbot+837ba09d9db969068367@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ee9103180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=837ba09d9db969068367
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15807005180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1777929d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in hci_sock_setsockopt_old net/bluetooth/hci_sock.c:1949 [inline]
BUG: KASAN: slab-out-of-bounds in hci_sock_setsockopt+0xe28/0xf70 net/bluetooth/hci_sock.c:2024
Read of size 4 at addr ffff88801979fec3 by task syz-executor243/5060

CPU: 1 PID: 5060 Comm: syz-executor243 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 copy_from_sockptr include/linux/sockptr.h:55 [inline]
 hci_sock_setsockopt_old net/bluetooth/hci_sock.c:1949 [inline]
 hci_sock_setsockopt+0xe28/0xf70 net/bluetooth/hci_sock.c:2024
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1e9e9add89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff645fbe38 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1e9e9add89
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5060:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x233/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
 do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff88801979fec0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff88801979fec0, ffff88801979fec2)

The buggy address belongs to the physical page:
page:ffffea000065e7c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1979f
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 26, tgid 26 (kdevtmpfs), ts 7021029367, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node_track_caller+0x2d6/0x4e0 mm/slub.c:3986
 kstrdup+0x3a/0x80 mm/util.c:62
 smack_inode_init_security+0x5d7/0x740 security/smack/smack_lsm.c:1053
 security_inode_init_security+0x1a2/0x440 security/security.c:1722
 shmem_mknod+0xc5/0x1d0 mm/shmem.c:3282
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4001
 handle_create drivers/base/devtmpfs.c:219 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x95c/0x1030 drivers/base/devtmpfs.c:399
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801979fd80: 06 fc fc fc 05 fc fc fc 06 fc fc fc 06 fc fc fc
 ffff88801979fe00: 06 fc fc fc 05 fc fc fc 06 fc fc fc 06 fc fc fc
>ffff88801979fe80: 06 fc fc fc 05 fc fc fc 02 fc fc fc 06 fc fc fc
                                           ^
 ffff88801979ff00: 06 fc fc fc 06 fc fc fc 05 fc fc fc fa fc fc fc
 ffff88801979ff80: 06 fc fc fc 06 fc fc fc 06 fc fc fc 05 fc fc fc
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

