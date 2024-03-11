Return-Path: <linux-kernel+bounces-98559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D71877BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD42A1F219C2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D0613FFA;
	Mon, 11 Mar 2024 08:55:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B412E49
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147322; cv=none; b=OfIRUwoNRowY8eRJTMkhFir3lSUfRA9ZmC4XC/AgwyxUP7OJSQ5/rU8/aYKzDikD76RFjjF3xDztWhWGB0LZE8I2S4m4ImdOkvvcbt6qvvTLdGntsYG0ppKTViIiAa3l7YA/O+8lkORu4kZh5TOe4RoVE1Z3JxBNHaixJwyrSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147322; c=relaxed/simple;
	bh=8wT68q1TYMxPEpLP5LnUlApCuSCX+jvJHuHIzeP9f3A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y8t+sTo7o5RR5aJdiovHmIGMRwDFzmFCd8J/wtn0PZiKXr2jM8KY6Y4jGgyeGkAOjiw5IHZp165ORXZA3wrkVDLuWHr/VxELJMGqijxqq7dluj9UUZdI1dWy72/iSxa3MehF6ST4MZwGHXAqZp/QkNAniq+BUT7u3f6AqUDNAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3662592dc1dso28208765ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710147319; x=1710752119;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOKPCvThGqAC+f156TSQivNkMqtCEPswf3dFD1qqtco=;
        b=qaNW5GqHcyiigwkltBFnRtD+8MOB5ZxrL3mOzLzTtSZL2J07NQ6d5W/e4n3Biz4PS+
         NZz+jQcreNDbKcfvez+9z58vyO/2GhPQwbHsTaxT6s3aHuHNdhsp6X+fpmFHQTOskU1g
         fyC7533srSRkxuG4+qEdJfQ/s3ZlfpfujOblkgrFxSU/xGmD/DMGLZzYMf1G/2SHzS16
         KdCt263JyxG8vGxnQvl2X+gnnPlKmRK3PXqYfI319ss8qxJxkYv01k4G9aIDLFk0hu1H
         erlf3Tmg2wDc6DeF/P42e8793umiBEVj70p/v7Dq9zqGqcBKMQQYyKERdBNI7xoJW0UT
         Tw7g==
X-Forwarded-Encrypted: i=1; AJvYcCU5f1z32jNkh3oP10uIgz47TFLOoELRFdW6+5sBG3tbEVAJ4FWTClByl+KA/NPXdpu2Fvcgoh2G5FPRcEZL+JM5p0+vBKiIdSgv/PVm
X-Gm-Message-State: AOJu0YwbSBi4ccAQzqzUkD9l6YRpcy0Ky+sWElFfBRMKMpKn3PfoaoJT
	5nmoHc135QSPHWZREXRJ+13gZYW0EJgpSjhAQHjcRTfKYza+Md3Rru5ghElQBtigN9tST1JjVVo
	SgWl3MTHZoqGn0/5+YH0NOILL6PcYmkYgrI4/wmAnzPFWDlscH1MWJvE=
X-Google-Smtp-Source: AGHT+IFVKZJr0Sr1+jrboWTudsa6kF06Fva7xocy+Vl6XSlLAJWsnWBx/ULpNxzATAV9Ydyu1B4R8+j5D1FVHr4BzK9ZauhNVIe8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:366:2f1c:2b94 with SMTP id
 x1-20020a056e021ca100b003662f1c2b94mr316075ill.5.1710147319753; Mon, 11 Mar
 2024 01:55:19 -0700 (PDT)
Date: Mon, 11 Mar 2024 01:55:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081fb0d06135eb3ca@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
From: syzbot <syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e63985ecd226 bpf, riscv64/cfi: Support kCFI + BPF on riscv64
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=159eabde180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92e06b597766606e
dashboard link: https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e10da6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f4152a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7eeb66f7ba3c/disk-e63985ec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2600d790d1c/vmlinux-e63985ec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c348a22f682/bzImage-e63985ec.xz

The issue was bisected to:

commit bd70a8fb7ca4fcb078086f4d96b048aaf1aa4786
Author: Eduard Zingerman <eddyz87@gmail.com>
Date:   Wed Mar 6 10:45:28 2024 +0000

    bpf: Allow all printable characters in BTF DATASEC names

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1610b97a180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1510b97a180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1110b97a180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc32304f6487ebff9b70@syzkaller.appspotmail.com
Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC names")

==================================================================
BUG: KASAN: slab-out-of-bounds in btf_name_valid_section kernel/bpf/btf.c:822 [inline]
BUG: KASAN: slab-out-of-bounds in btf_datasec_check_meta+0x2c9/0x9a0 kernel/bpf/btf.c:4564
Read of size 1 at addr ffff88802c6cf6b7 by task syz-executor419/5072

CPU: 0 PID: 5072 Comm: syz-executor419 Not tainted 6.8.0-rc6-syzkaller-ge63985ecd226 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 btf_name_valid_section kernel/bpf/btf.c:822 [inline]
 btf_datasec_check_meta+0x2c9/0x9a0 kernel/bpf/btf.c:4564
 btf_check_meta kernel/bpf/btf.c:5046 [inline]
 btf_check_all_metas+0x3a1/0xaf0 kernel/bpf/btf.c:5070
 btf_parse_type_sec+0x148/0x1a80 kernel/bpf/btf.c:5206
 btf_parse kernel/bpf/btf.c:5598 [inline]
 btf_new_fd+0x469/0xad0 kernel/bpf/btf.c:7450
 __sys_bpf+0x6ef/0x810 kernel/bpf/syscall.c:5618
 __do_sys_bpf kernel/bpf/syscall.c:5680 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5678 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5678
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fa1bbc623a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1e453658 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffc1e453838 RCX: 00007fa1bbc623a9
RDX: 0000000000000020 RSI: 0000000020000300 RDI: 0000000000000012
RBP: 00007fa1bbcd5610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc1e453828 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5072:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc_node+0x24e/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x72/0x190 mm/util.c:617
 kvmalloc include/linux/slab.h:728 [inline]
 btf_parse kernel/bpf/btf.c:5574 [inline]
 btf_new_fd+0x28f/0xad0 kernel/bpf/btf.c:7450
 __sys_bpf+0x6ef/0x810 kernel/bpf/syscall.c:5618
 __do_sys_bpf kernel/bpf/syscall.c:5680 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5678 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5678
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff88802c6cf680
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes to the right of
 allocated 55-byte region [ffff88802c6cf680, ffff88802c6cf6b7)

The buggy address belongs to the physical page:
page:ffffea0000b1b3c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2c6cf
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41640 ffffea0000b06980 dead000000000008
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4517, tgid 4517 (S02sysctl), ts 16721648499, free_ts 16711509714
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x2e0/0x490 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2023 [inline]
 tomoyo_supervisor+0xe0a/0x11f0 security/tomoyo/common.c:2095
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission+0x243/0x360 security/tomoyo/file.c:587
 tomoyo_path_perm+0x480/0x740 security/tomoyo/file.c:838
 security_inode_getattr+0xd8/0x130 security/security.c:2238
 vfs_getattr+0x45/0x430 fs/stat.c:173
 vfs_fstat fs/stat.c:198 [inline]
 vfs_fstatat+0xd6/0x190 fs/stat.c:300
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat fs/stat.c:462 [inline]
 __x64_sys_newfstatat+0x117/0x190 fs/stat.c:462
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
page last free pid 4517 tgid 4517 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2532
 release_pages+0x2744/0x2a80 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu+0x34c/0x4e0 mm/mmu_gather.c:300
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:392
 exit_mmap+0x4b6/0xd40 mm/mmap.c:3292
 __mmput+0x115/0x3c0 kernel/fork.c:1343
 exec_mmap+0x69c/0x730 fs/exec.c:1051
 begin_new_exec+0x119a/0x1ce0 fs/exec.c:1310
 load_elf_binary+0x961/0x2590 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1783 [inline]
 exec_binprm fs/exec.c:1825 [inline]
 bprm_execve+0xaf7/0x1790 fs/exec.c:1877
 do_execveat_common+0x552/0x6f0 fs/exec.c:1984
 do_execve fs/exec.c:2058 [inline]
 __do_sys_execve fs/exec.c:2134 [inline]
 __se_sys_execve fs/exec.c:2129 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2129
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff88802c6cf580: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff88802c6cf600: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff88802c6cf680: 00 00 00 00 00 00 07 fc fc fc fc fc fc fc fc fc
                                     ^
 ffff88802c6cf700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff88802c6cf780: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
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

