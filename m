Return-Path: <linux-kernel+bounces-76345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981D85F5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1470286559
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AB3F9E2;
	Thu, 22 Feb 2024 10:40:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E217C7C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598421; cv=none; b=iL6A00EIF1nmAOb4DYDtScq3KX2vpfX4nvlli3sAgUCJKzz85x4Phgk6P/DvcAR5JcageBAjk1QNT0zIDv4K62i5ZL8E0gF/wShqck+4NhxK4o+4hHuju75SDlZVdXiw12XbgoWXkK67ZSyEApZO6Wv4CSCeowaBEKf6rqW9DB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598421; c=relaxed/simple;
	bh=yOq/F5lrHLbv8kTb1NmnZwZhvg4kJr/2pUJpVytSurA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tgXLZiMXpS9nwDcIaGuQtogcSo/8wwgFGXefDPOwgLjdFQ7QB/0pDHPzoNWOwS8lyE1+dO7iEinkkxypJLRZPvZrqFv9+Moz2Mo0BOjjv+mMwTu+u7ZNdOtxwP35d4Z5lhPV12ICHwFPMuEZhrRfc/VKpKjvB5O+tyOGyfe/VSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36541324e57so28242635ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598418; x=1709203218;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGZmgCGQPYg+enOxdJBtbBRxSgvIs5n8H5eEy4TMjOA=;
        b=tTMcP/yM8o1i7FXJtbJD4zB3UimJq7YB9FTlfkjpFvWxtwJ59EpN+iMPcpbdFq923o
         elQj1OdHLJ8L+P+GwutYAfYCKDxRgPazuYKPnDaEiRtLqrK8VOXTSdEfyBBjkvAj8F/k
         ykxqLPTjEnoGJa4PVUpSM1Nvs47+sUW3YtHgNWhdQ37fSEFy4fw8POgzVHwO+wovgcpJ
         3mTiLLZWyP9Vd2HMvIXKXzGpPPzayvOWyhlTysyWI1+d+3PA13pWoyS+/r+Ie6nHIq28
         N+9LpTL8I5WB2aydrwzMAwoI0ERuLmlW5LrBRrvsGfmBc5kMhhhFXBO6wRMC1ETmdw3H
         LSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7pItFUeMZazaVD+abivkLHB2LX/yNxKuBzf5xCOXG6eRj+ADu/mzFBKty+pW7+D4l0OmNYk8n7Xx6CB3ou05dVIjp0Q2nTmo4dob8
X-Gm-Message-State: AOJu0YyyMpttDYhfOF3wPcSrZUsDDwvpYQT3aLjZ7fAc/Gy/YUsTzwsd
	QpB169lHapRx+84qYQZeEoxLyArKklJhNkA4h3fjHYYJgVSQDOKJ/SqjGmC2xKUPZydTZNpScFI
	rmAsCEbIY2aRSYnoCr3hQUAs4APYS0WX8cf7C4kMEoacK6uV1amAZkrU=
X-Google-Smtp-Source: AGHT+IEU6uJv3gWErXDvxmoghtLwMWZ9rKcAN+gJTcytMv80TE4WiA4y6tWQUIBsSj2HJ5orkMmqp9pnytxE8M4Y0ymku/FiqZ6C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d09:b0:365:26e3:6e47 with SMTP id
 i9-20020a056e021d0900b0036526e36e47mr920061ila.0.1708598418451; Thu, 22 Feb
 2024 02:40:18 -0800 (PST)
Date: Thu, 22 Feb 2024 02:40:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbb7860611f61147@google.com>
Subject: [syzbot] [keyrings?] [lsm?] KASAN: slab-out-of-bounds Read in
 key_task_permission (2)
From: syzbot <syzbot+5b415c07907a2990d1a3@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ced590523156 Merge tag 'driver-core-6.8-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141f44b4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa42dd2796e3ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=5b415c07907a2990d1a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b9d2a78bf6dc/disk-ced59052.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebca9790f4fc/vmlinux-ced59052.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8c19c4f852d/bzImage-ced59052.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b415c07907a2990d1a3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in key_task_permission+0x3eb/0x4f0 security/keys/permission.c:54
Read of size 4 at addr ffff88801e9cc5e0 by task syz-executor.0/3778

CPU: 1 PID: 3778 Comm: syz-executor.0 Not tainted 6.8.0-rc4-syzkaller-00388-gced590523156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 key_task_permission+0x3eb/0x4f0 security/keys/permission.c:54
 search_nested_keyrings+0x94d/0x1190 security/keys/keyring.c:793
 keyring_search_rcu+0x198/0x290 security/keys/keyring.c:922
 search_cred_keyrings_rcu+0x4a1/0x600 security/keys/process_keys.c:501
 search_process_keyrings_rcu+0x1e/0x2b0 security/keys/process_keys.c:544
 request_key_and_link+0x5a6/0x19c0 security/keys/request_key.c:618
 __do_sys_request_key security/keys/keyctl.c:222 [inline]
 __se_sys_request_key+0x271/0x3b0 security/keys/keyctl.c:167
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xbd/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86
RIP: 0023:0xf72d9579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5ed35ac EFLAGS: 00000206 ORIG_RAX: 000000000000011f
RAX: ffffffffffffffda RBX: 0000000020000100 RCX: 0000000020000240
RDX: 0000000020000300 RSI: 00000000fffffffc RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3659:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x22e/0x490 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x69/0x570 security/security.c:2933
 do_dentry_open+0x327/0x15a0 fs/open.c:940
 do_open fs/namei.c:3641 [inline]
 path_openat+0x285f/0x3240 fs/namei.c:3798
 do_filp_open+0x234/0x490 fs/namei.c:3825
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_compat_sys_openat fs/open.c:1479 [inline]
 __se_compat_sys_openat fs/open.c:1477 [inline]
 __ia32_compat_sys_openat+0x23f/0x290 fs/open.c:1477
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xbd/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86

Freed by task 3659:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
 __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x380 mm/slub.c:4409
 tomoyo_check_open_permission+0x376/0x500 security/tomoyo/file.c:786
 security_file_open+0x69/0x570 security/security.c:2933
 do_dentry_open+0x327/0x15a0 fs/open.c:940
 do_open fs/namei.c:3641 [inline]
 path_openat+0x285f/0x3240 fs/namei.c:3798
 do_filp_open+0x234/0x490 fs/namei.c:3825
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_compat_sys_openat fs/open.c:1479 [inline]
 __se_compat_sys_openat fs/open.c:1477 [inline]
 __ia32_compat_sys_openat+0x23f/0x290 fs/open.c:1477
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xbd/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86

The buggy address belongs to the object at ffff88801e9cc580
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 64 bytes to the right of
 allocated 32-byte region [ffff88801e9cc580, ffff88801e9cc5a0)

The buggy address belongs to the physical page:
page:ffffea00007a7300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e9cc
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41500 ffffea0001e6a540 dead000000000005
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5090, tgid 5090 (syz-executor.4), ts 103426494498, free_ts 103421611023
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
 kzalloc include/linux/slab.h:711 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
 security_file_ioctl_compat+0x75/0xb0 security/security.c:2744
 __do_compat_sys_ioctl fs/ioctl.c:923 [inline]
 __se_compat_sys_ioctl+0xd6/0xbf0 fs/ioctl.c:914
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xbd/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86
page last free pid 6815 tgid 6813 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 tlb_batch_list_free mm/mmu_gather.c:114 [inline]
 tlb_finish_mmu+0x11f/0x200 mm/mmu_gather.c:395
 exit_mmap+0x4b6/0xd40 mm/mmap.c:3292
 __mmput+0x115/0x3c0 kernel/fork.c:1343
 exit_mm+0x21f/0x310 kernel/exit.c:569
 do_exit+0x9af/0x2740 kernel/exit.c:858
 do_group_exit+0x206/0x2c0 kernel/exit.c:1020
 get_signal+0x176d/0x1850 kernel/signal.c:2893
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc8/0x370 kernel/entry/common.c:212
 __do_fast_syscall_32+0xcf/0x120 arch/x86/entry/common.c:324
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86

Memory state around the buggy address:
 ffff88801e9cc480: fa fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801e9cc500: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801e9cc580: fa fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff88801e9cc600: fa fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801e9cc680: fa fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

