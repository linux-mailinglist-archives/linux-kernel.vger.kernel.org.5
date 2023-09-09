Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FD799A30
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjIIRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjIIRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:12:53 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9A9C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 10:12:48 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-5703b4e92b7so3595130a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 10:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694279568; x=1694884368;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vG8Oz99hAjukMma/eMitLYTlr/IlrcVtbWBUoENWVeU=;
        b=MtG7XZtAlfvzXIUfAEWa49ekaFqZOCH4gvBROtY6yaM//8nos66qOT6bsvU4uCyj6j
         epJd7YydmZpemkNwrgX6kQFoCgSk/N47g6Xs2C6au90vVO0W5sMGkct+fqNSc665sihT
         0UKSZ73XCIRY5fr5oyVnjo+1DDkyzhBvrem1lF2AdSJIWIOZlbcMaoyqTrzds9/z6mbl
         KTLWmOOswxvRH+96rpJ1mO7QLz2DuK43p++JQAEOr0+fxePJBAVSg0zFOmKmA7xGDSgc
         3iRUzhBEuz9YhfvaO/K5YRb6X8J9giaAeJC0EDZly/J5YHCWiYHJmOKPcerdJG8xo+dI
         dwlg==
X-Gm-Message-State: AOJu0Ywor5BPHIh/BezwLVTsn9bYG0tllx8AGpM5c9q98uHrSl1kwlZk
        Ix7oMEXrg/9wnB2VMfdvZSfFFjhAqayPXH3haAt9UPZr8fAY
X-Google-Smtp-Source: AGHT+IHKlJlL6AOMGujpNfCeB+H9axh4gpfZ79VzhaLl6kE9WYDwTbP/HpX+66B2nZ7hO8vUPZ7mmREkaxykvU0MYzj2cWONzk75
MIME-Version: 1.0
X-Received: by 2002:a63:724e:0:b0:573:ff6d:d463 with SMTP id
 c14-20020a63724e000000b00573ff6dd463mr1086877pgn.8.1694279568232; Sat, 09 Sep
 2023 10:12:48 -0700 (PDT)
Date:   Sat, 09 Sep 2023 10:12:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d099fa0604f03351@google.com>
Subject: [syzbot] [mm?] BUG: Bad page map (7)
From:   syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fengwei.yin@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=142a0e00680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=55cc72f8cc3a549119df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ff1fa8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1445ba2fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/15ea526c030f/disk-3f86ed6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8f0baca67e5/vmlinux-3f86ed6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e39fafbb687d/bzImage-3f86ed6e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f82bb81a1d50/mount_0.gz

The issue was bisected to:

commit 617c28ecab22d98a3809370eb6cb50fa24b7bfe1
Author: Yin Fengwei <fengwei.yin@intel.com>
Date:   Wed Aug 2 15:14:05 2023 +0000

    filemap: batch PTE mappings

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c37c58680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10237c58680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c37c58680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com
Fixes: 617c28ecab22 ("filemap: batch PTE mappings")

BUG: Bad page map in process syz-executor332  pte:fffff8ce8c120 pmd:79462067
page:ffffea0001cc5cc0 refcount:9 mapcount:-1 mapping:ffff8880774b1b50 index:0x3 pfn:0x73173
head:ffffea0001cc5c00 order:2 entire_mapcount:0 nr_pages_mapped:8388607 pincount:0
memcg:ffff888015e5a000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001cc5c01 dead000000000122 dead000000000400
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea00007c9948 ffff888013245030 ffff8880774b1b50
head: 0000000000000000 ffff888027450e00 00000009ffffffff ffff888015e5a000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5036, tgid 5036 (syz-executor332), ts 61415422939, free_ts 21789924659
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31ec/0x3370 mm/page_alloc.c:3183
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4439
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:979
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3294
 __xfs_filemap_fault+0x286/0x960 fs/xfs/xfs_file.c:1354
 __do_fault+0x133/0x4e0 mm/memory.c:4204
 do_read_fault mm/memory.c:4568 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x48d2/0x6200 mm/memory.c:5284
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x6bd/0x15e0 mm/gup.c:1239
 __get_user_pages_locked mm/gup.c:1504 [inline]
 get_dump_page+0x146/0x2b0 mm/gup.c:2018
 dump_user_range+0x126/0x910 fs/coredump.c:913
 elf_core_dump+0x3b75/0x4490 fs/binfmt_elf.c:2142
 do_coredump+0x1b73/0x2ab0 fs/coredump.c:764
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6355
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020006000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff8880774b1b50 index:5
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 1 PID: 5036 Comm: syz-executor332 Not tainted 6.5.0-syzkaller-11704-g3f86ed6ec0b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_bad_pte+0x581/0x5c0 mm/memory.c:535
 zap_pte_range mm/memory.c:1458 [inline]
 zap_pmd_range mm/memory.c:1573 [inline]
 zap_pud_range mm/memory.c:1602 [inline]
 zap_p4d_range mm/memory.c:1623 [inline]
 unmap_page_range+0x1a76/0x3300 mm/memory.c:1644
 unmap_vmas+0x209/0x3a0 mm/memory.c:1731
 exit_mmap+0x297/0xc50 mm/mmap.c:3210
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x612/0x2290 kernel/exit.c:861
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff93b1d0eb9
Code: Unable to access opcode bytes at 0x7ff93b1d0e8f.
RSP: 002b:00007ffc50f66f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 0000000000000003 RCX: 00007ff93b1d0eb9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007ffc50f67188 R14: 0000000000000001 R15: 00007ffc50f66f50
 </TASK>
BUG: Bad page map in process syz-executor332  pte:fffff8ce8d120 pmd:79462067
page:ffffea0001cc5c80 refcount:9 mapcount:-1 mapping:ffff8880774b1b50 index:0x2 pfn:0x73172
head:ffffea0001cc5c00 order:2 entire_mapcount:0 nr_pages_mapped:8388606 pincount:0
memcg:ffff888015e5a000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001cc5c01 ffffea0001cc5c90 ffffea0001cc5c90
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea00007c9948 ffff888013245030 ffff8880774b1b50
head: 0000000000000000 ffff888027450e00 00000009ffffffff ffff888015e5a000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5036, tgid 5036 (syz-executor332), ts 61415422939, free_ts 21789914922
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31ec/0x3370 mm/page_alloc.c:3183
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4439
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:979
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3294
 __xfs_filemap_fault+0x286/0x960 fs/xfs/xfs_file.c:1354
 __do_fault+0x133/0x4e0 mm/memory.c:4204
 do_read_fault mm/memory.c:4568 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x48d2/0x6200 mm/memory.c:5284
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x6bd/0x15e0 mm/gup.c:1239
 __get_user_pages_locked mm/gup.c:1504 [inline]
 get_dump_page+0x146/0x2b0 mm/gup.c:2018
 dump_user_range+0x126/0x910 fs/coredump.c:913
 elf_core_dump+0x3b75/0x4490 fs/binfmt_elf.c:2142
 do_coredump+0x1b73/0x2ab0 fs/coredump.c:764
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6355
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020007000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff8880774b1b50 index:6
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 0 PID: 5036 Comm: syz-executor332 Tainted: G    B              6.5.0-syzkaller-11704-g3f86ed6ec0b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_bad_pte+0x581/0x5c0 mm/memory.c:535
 zap_pte_range mm/memory.c:1458 [inline]
 zap_pmd_range mm/memory.c:1573 [inline]
 zap_pud_range mm/memory.c:1602 [inline]
 zap_p4d_range mm/memory.c:1623 [inline]
 unmap_page_range+0x1a76/0x3300 mm/memory.c:1644
 unmap_vmas+0x209/0x3a0 mm/memory.c:1731
 exit_mmap+0x297/0xc50 mm/mmap.c:3210
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x612/0x2290 kernel/exit.c:861
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff93b1d0eb9
Code: Unable to access opcode bytes at 0x7ff93b1d0e8f.
RSP: 002b:00007ffc50f66f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 0000000000000003 RCX: 00007ff93b1d0eb9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007ffc50f67188 R14: 0000000000000001 R15: 00007ffc50f66f50
 </TASK>
BUG: Bad page map in process syz-executor332  pte:fffff8ce8e120 pmd:79462067
page:ffffea0001cc5c40 refcount:9 mapcount:-1 mapping:ffff8880774b1b50 index:0x1 pfn:0x73171
head:ffffea0001cc5c00 order:2 entire_mapcount:0 nr_pages_mapped:8388605 pincount:0
memcg:ffff888015e5a000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000202 ffffea0001cc5c01 dead000000000122 fffffffdffffffff
raw: 0000000400000000 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea00007c9948 ffff888013245030 ffff8880774b1b50
head: 0000000000000000 ffff888027450e00 00000009ffffffff ffff888015e5a000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5036, tgid 5036 (syz-executor332), ts 61415422939, free_ts 21789904946
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31ec/0x3370 mm/page_alloc.c:3183
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4439
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:979
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3294
 __xfs_filemap_fault+0x286/0x960 fs/xfs/xfs_file.c:1354
 __do_fault+0x133/0x4e0 mm/memory.c:4204
 do_read_fault mm/memory.c:4568 [inline]
 do_fault mm/memory.c:4705 [inline]
 do_pte_missing mm/memory.c:3669 [inline]
 handle_pte_fault mm/memory.c:4978 [inline]
 __handle_mm_fault mm/memory.c:5119 [inline]
 handle_mm_fault+0x48d2/0x6200 mm/memory.c:5284
 faultin_page mm/gup.c:956 [inline]
 __get_user_pages+0x6bd/0x15e0 mm/gup.c:1239
 __get_user_pages_locked mm/gup.c:1504 [inline]
 get_dump_page+0x146/0x2b0 mm/gup.c:2018
 dump_user_range+0x126/0x910 fs/coredump.c:913
 elf_core_dump+0x3b75/0x4490 fs/binfmt_elf.c:2142
 do_coredump+0x1b73/0x2ab0 fs/coredump.c:764
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6355
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020008000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff8880774b1b50 index:7
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 1 PID: 5036 Comm: syz-executor332 Tainted: G    B              6.5.0-syzkaller-11704-g3f86ed6ec0b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_bad_pte+0x581/0x5c0 mm/memory.c:535
 zap_pte_range mm/memory.c:1458 [inline]
 zap_pmd_range mm/memory.c:1573 [inline]
 zap_pud_range mm/memory.c:1602 [inline]
 zap_p4d_range mm/memory.c:1623 [inline]
 unmap_page_range+0x1a76/0x3300 mm/memory.c:1644
 unmap_vmas+0x209/0x3a0 mm/memory.c:1731
 exit_mmap+0x297/0xc50 mm/mmap.c:3210
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x612/0x2290 kernel/exit.c:861
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff93b1d0eb9
Code: Unable to access opcode bytes at 0x7ff93b1d0e8f.
RSP: 002b:00007ffc50f66f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 0000000000000003 RCX: 00007ff93b1d0eb9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007ffc50f67188 R14: 0000000000000001 R15: 00007ffc50f66f50
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
