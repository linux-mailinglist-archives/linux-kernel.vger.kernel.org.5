Return-Path: <linux-kernel+bounces-3854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992508173FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5A31C24AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193373D577;
	Mon, 18 Dec 2023 14:43:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A83A1A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b711ddbf1aso373479039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910607; x=1703515407;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAtVa/cvMWKWtkc7fS76yx599wTk67rVxkUu75EVfkM=;
        b=PJSmY+L9HBWo9+3BRECYiez6da6upNQAswfJxxeAdmwZaS6K8k4qV8CLr0fYLBOhkU
         zYOvoEFCUwSzViPkrpFHYOru1efNi6HY8Uyj1hU6p3b8L1D6BSRieQL5ueAmUIjCnkEV
         EKMa31EniwzR8LRfRHOBx8DAtSd4neMWQiG332A9LKGL8MzGfHu9Lb+Dm6MA5MZSNKyG
         zxHIEpeU5h7LtzVMqu7/diIWf7ZM5gKxSG8SiOzGxIXfdPqwAh5n2bLZIWq0OZGj0YEb
         aq8Gq3d+nij7bnPJKpkXhUE86rTBQCk+2AbR9wXgSCwnTagpYLypzZt98eXMfJGsyop9
         qHow==
X-Gm-Message-State: AOJu0Ywi4VCghmMQnTLS6KSOHpT9qPsAUybk7Ly60s9wSH9CiDjy+5g6
	DC8bipHd3iGMVKmGpo/B7dKwYURTdU6EuoJK3A/HfIBWjzxX
X-Google-Smtp-Source: AGHT+IFb+Z3JNS0QXI0IOSlUUQvYK9ZHj3+Zgfo3Wxld6iDFnBdd5Ui4GqCmKNXIjBorNxD88cDw1Aiah9mXHVYHUQBQxWNeu+m8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:35f:b447:8e92 with SMTP id
 k8-20020a056e021a8800b0035fb4478e92mr190513ilv.4.1702910607303; Mon, 18 Dec
 2023 06:43:27 -0800 (PST)
Date: Mon, 18 Dec 2023 06:43:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d52e14060cc9c551@google.com>
Subject: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17cb8a20bde6 Add linux-next specific files for 20231215
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1129f3b6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d23c01e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cfe021e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae1915546a0a/disk-17cb8a20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0f2ec7a35f4/vmlinux-17cb8a20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/619edb9cb864/bzImage-17cb8a20.xz

The issue was bisected to:

commit 47309ea1359115125d9cab17a279c8df72b47235
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Nov 28 06:52:57 2023 +0000

    crypto: arc4 - Add internal state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130bb292e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=108bb292e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=170bb292e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Fixes: 47309ea13591 ("crypto: arc4 - Add internal state")

"syz-executor161" (5061) uses obsolete ecb(arc4) skcipher
==================================================================
BUG: KASAN: slab-out-of-bounds in arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
Read of size 4 at addr ffff888079f44ee0 by task syz-executor161/5061

CPU: 1 PID: 5061 Comm: syz-executor161 Not tainted 6.7.0-rc5-next-20231215-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
 crypto_arc4_crypt+0x61/0x70 crypto/arc4.c:37
 crypto_lskcipher_crypt_sg+0x28c/0x460 crypto/lskcipher.c:229
 crypto_skcipher_decrypt+0xda/0x160 crypto/skcipher.c:693
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0xc2b/0x1040 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1066
 ____sys_recvmsg+0x21f/0x5c0 net/socket.c:2801
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2843
 __sys_recvmsg+0x114/0x1e0 net/socket.c:2873
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7effab449b79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6c0657f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007effab449b79
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000004
RBP: 0000000000003a28 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 78:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 ____kasan_kmalloc mm/kasan/common.c:375 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:384
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slub.c:3985 [inline]
 __kmalloc+0x1f9/0x440 mm/slub.c:3998
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 kobject_get_path+0xce/0x2b0 lib/kobject.c:159
 kobject_uevent_env+0x26b/0x1800 lib/kobject_uevent.c:529
 kset_register+0x1b6/0x2a0 lib/kobject.c:873
 bus_register+0x1bf/0x6a0 drivers/base/bus.c:868
 gpiolib_dev_init+0x1b/0x1c0 drivers/gpio/gpiolib.c:4684
 do_one_initcall+0x128/0x680 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x692/0xc30 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 ____kasan_kmalloc mm/kasan/common.c:375 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:384
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slub.c:3985 [inline]
 __kmalloc+0x1f9/0x440 mm/slub.c:3998
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 acpi_os_allocate_zeroed include/acpi/platform/aclinuxex.h:57 [inline]
 acpi_ns_internalize_name+0x149/0x220 drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked+0x164/0x310 drivers/acpi/acpica/nsutils.c:666
 acpi_ns_get_node+0x4c/0x70 drivers/acpi/acpica/nsutils.c:726
 acpi_ns_evaluate+0x6eb/0xca0 drivers/acpi/acpica/nseval.c:62
 acpi_ut_evaluate_object+0xda/0x490 drivers/acpi/acpica/uteval.c:60
 acpi_ut_execute_HID+0x8e/0x3b0 drivers/acpi/acpica/utids.c:45
 acpi_ns_get_device_callback+0x182/0x510 drivers/acpi/acpica/nsxfeval.c:679
 acpi_ns_walk_namespace+0x3fe/0x5a0 drivers/acpi/acpica/nswalk.c:233
 acpi_get_devices+0x135/0x160 drivers/acpi/acpica/nsxfeval.c:805
 acpi_ec_dsdt_probe+0x4b/0x160 drivers/acpi/ec.c:1769
 acpi_bus_init drivers/acpi/bus.c:1372 [inline]
 acpi_init+0x2c5/0xb70 drivers/acpi/bus.c:1430
 do_one_initcall+0x128/0x680 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x692/0xc30 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slub.c:3817 [inline]
 slab_alloc_node mm/slub.c:3864 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3871
 kmem_cache_zalloc include/linux/slab.h:701 [inline]
 acpi_os_acquire_object include/acpi/platform/aclinuxex.h:67 [inline]
 acpi_ut_allocate_object_desc_dbg drivers/acpi/acpica/utobject.c:359 [inline]
 acpi_ut_create_internal_object_dbg+0x7b/0x400 drivers/acpi/acpica/utobject.c:69
 acpi_ds_create_buffer_field+0x389/0x610 drivers/acpi/acpica/dsfield.c:214
 acpi_ds_load2_end_op+0x5d8/0x1070 drivers/acpi/acpica/dswload2.c:475
 acpi_ds_exec_end_op+0xbb7/0x1460 drivers/acpi/acpica/dswexec.c:542
 acpi_ps_parse_loop+0x429/0x1ce0 drivers/acpi/acpica/psloop.c:525
 acpi_ps_parse_aml+0x3c1/0xca0 drivers/acpi/acpica/psparse.c:475
 acpi_ps_execute_table+0x37b/0x4c0 drivers/acpi/acpica/psxface.c:295
 acpi_ns_execute_table+0x3ee/0x550 drivers/acpi/acpica/nsparse.c:116
 acpi_ns_load_table+0x5b/0x130 drivers/acpi/acpica/nsload.c:71
 acpi_tb_load_namespace+0x435/0x700 drivers/acpi/acpica/tbxfload.c:186
 acpi_load_tables+0x2c/0x110 drivers/acpi/acpica/tbxfload.c:59
 acpi_bus_init drivers/acpi/bus.c:1321 [inline]
 acpi_init+0x123/0xb70 drivers/acpi/bus.c:1430
 do_one_initcall+0x128/0x680 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x692/0xc30 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888079f44800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 1024 bytes to the right of
 allocated 736-byte region [ffff888079f44800, ffff888079f44ae0)

The buggy address belongs to the physical page:
page:ffffea0001e7d000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79f40
head:ffffea0001e7d000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041dc0 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4686, tgid 4686 (udevd), ts 39444184156, free_ts 23975115080
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1540
 prep_new_page mm/page_alloc.c:1547 [inline]
 get_page_from_freelist+0xa19/0x3740 mm/page_alloc.c:3355
 __alloc_pages+0x22e/0x2410 mm/page_alloc.c:4611
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:2191 [inline]
 allocate_slab mm/slub.c:2358 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2411
 ___slab_alloc+0x4ab/0x1990 mm/slub.c:3544
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3629
 __slab_alloc_node mm/slub.c:3682 [inline]
 slab_alloc_node mm/slub.c:3854 [inline]
 __do_kmalloc_node mm/slub.c:3984 [inline]
 __kmalloc+0x3b4/0x440 mm/slub.c:3998
 kmalloc include/linux/slab.h:594 [inline]
 load_elf_phdrs+0x103/0x210 fs/binfmt_elf.c:526
 load_elf_binary+0x14ca/0x4e10 fs/binfmt_elf.c:955
 search_binary_handler fs/exec.c:1736 [inline]
 exec_binprm fs/exec.c:1778 [inline]
 bprm_execve fs/exec.c:1853 [inline]
 bprm_execve+0x7ef/0x1a80 fs/exec.c:1809
 do_execveat_common.isra.0+0x679/0x8e0 fs/exec.c:1974
 do_execve fs/exec.c:2048 [inline]
 __do_sys_execve fs/exec.c:2124 [inline]
 __se_sys_execve fs/exec.c:2119 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2119
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x51f/0xb10 mm/page_alloc.c:2390
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2530
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6579
 destroy_args+0xa69/0xe40 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x16fc/0x3250 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x128/0x680 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x692/0xc30 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888079f44d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888079f44e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888079f44e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff888079f44f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888079f44f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

