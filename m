Return-Path: <linux-kernel+bounces-159189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91BF8B2A74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B812FB22440
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065811553B9;
	Thu, 25 Apr 2024 21:10:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9C154C02
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079423; cv=none; b=YQuOyd27MliG1x+twuSPbEJKcKdC7GQwIsXyLoHUBRjjItUorFNzbJn2e3U+2Tj706AwVJ4PL9OKVBoP+UExb3xqzBvcOs8b04Jt6mm0h3RRl6HpK+/3jQfFtxaNGlgXHRzR7kK8ep1XNKeZC81lmH9Hw5lXJgUwKAR1kENWjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079423; c=relaxed/simple;
	bh=QTTjtT0JkTkI/yIW75d0zGpEI1BCDBXcREadqzT8Bos=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u2z8pcq0FL8+f7EAVbkGH6CG8Y3oXTsxmjYfJbQOJ7HbtWaDF/Fazc22kFgBI+GjMDePnThdylivwmh/0c4CI9g2AroMihLkvX58ZoaUCvEIBDDsN5CaRIMVNhsJoMrTp8sUBIwIYHDw3YJo4jhbnqy6EbVcrCE5mv+f1Ou1XCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36b3157ffb1so15803665ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079421; x=1714684221;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Awl4G1u/auHXjLB5NOihyiXmRDtZVea07DBWxvT5zMA=;
        b=ml+yFuv9ZnOe54OkkMOitHuELLbSdqNVHMRSJPbARnfK55CvnHOArMRmN6LB+/tlJU
         WgKDSy+uh9ypkYvDOxEHwEYEv3WLvbQVr8YdMAzExtIofZf8KgovkxNa062vjDwf/J9g
         DDIwDPwda6d1/jI5/gAhlHsM8/uMuEx/EJ8UwDRQjbqeDUuN8tgRzMwZVACZE/kqo3FA
         01K+9sj55isOzIQVMIiR6zlfP6Mr9yZWdYFlsrX1ypGgUIm96bUdjyCvb/UmvpxYGDwo
         wJFVWQrthX8SE2eBWExg2X61MZHe+PJx7f2ScQLMBJX37OopEocn9fD5Px5OZzb4JKDM
         NtJA==
X-Forwarded-Encrypted: i=1; AJvYcCUijkPg6wrU+eTYqvtKiNoFpWPCdFAzenau9uJuhhsXDQAIhDNqvsmvq1P+o3nL3tX88o87Gcqg32ESjHZwocgw8/1v4p9MDKMcxcOL
X-Gm-Message-State: AOJu0Yz+/Kwkf2V2PfL/CMP77X6BX0Bezf4MF03N4oGeix/WeQ6gNS69
	I559aiPjcrQeW+Lw3+X6TOw0X8QiO29P1UVsjPEzA/JgfAhzLicqqk0w6kNWxSZce0xk5t94x8A
	0CNuApcFtpfwetAA8AdIorq5DQRgYAhBbPnSxHektoy59fB3+JbLO6lk=
X-Google-Smtp-Source: AGHT+IGJ8AXUicSt79v4XiNYxjpZPaCx+uwJKmj7BiQOLsTnDp6HDz68qIgWNU76R6KyqYS8xao9MyZZIYDndneXHI6f8kYwKT8X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3008:b0:486:ec11:3b8a with SMTP id
 r8-20020a056638300800b00486ec113b8amr40107jak.6.1714079421010; Thu, 25 Apr
 2024 14:10:21 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001ab730616f23768@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-out-of-bounds Write in diWrite
From: syzbot <syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1181b910980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=aa6df9d3b383bf5f047f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108f21c7180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128532bb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b09f946202a4/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10dec06b180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12dec06b180000
console output: https://syzkaller.appspot.com/x/log.txt?x=14dec06b180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: use-after-free in diWrite+0xde3/0x19b0 fs/jfs/jfs_imap.c:750
Write of size 32 at addr ffff888076cee0c0 by task syz-executor949/5083

CPU: 1 PID: 5083 Comm: syz-executor949 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 diWrite+0xde3/0x19b0 fs/jfs/jfs_imap.c:750
 txCommit+0xa1a/0x6a20 fs/jfs/jfs_txnmgr.c:1255
 add_missing_indices fs/jfs/jfs_dtree.c:2661 [inline]
 jfs_readdir+0x28e9/0x4660 fs/jfs/jfs_dtree.c:3009
 wrap_directory_iterator+0x94/0xe0 fs/readdir.c:67
 iterate_dir+0x65e/0x820 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff57c567679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffddcb47e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fffddcb49b8 RCX: 00007ff57c567679
RDX: 000000000000005d RSI: 00000000200002c0 RDI: 0000000000000005
RBP: 00007ff57c5e0610 R08: 0000000000000000 R09: 00007fffddcb49b8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffddcb49a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76cee
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
raw: 00fff80000000000 ffffea0001db3bc8 ffffea0001dcea48 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), pid 5078, tgid 397447660 (sshd), ts 5078, free_ts 51945391130
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1476
 prep_new_page mm/page_alloc.c:1484 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4704
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 pipe_write+0x657/0x1a40 fs/pipe.c:513
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5080 tgid 5080 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1096 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2609
 __folio_put+0x3b9/0x620 mm/swap.c:129
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6f2/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9c4/0xbd0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888076cedf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888076cee000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888076cee080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           ^
 ffff888076cee100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888076cee180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

