Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60486799C67
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbjIJD3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjIJD3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:29:34 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF16E18F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:29:28 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c08a3f7270so52882655ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 20:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694316568; x=1694921368;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDHdMqcHNswMgQCi/+F9CwcO3F8EBlq0C6b1JcQ714U=;
        b=NM+Rp3cBxglbNmWhgT7Sp30Ozdul8w0hOa8jeLLtPaN1W6atKmQqUWeDKUVsgIw+4c
         MQavy38LVcUm99AP+C88zcUXaG15IanOyD+9seoQCMV9LmrdaxLXhyrdWIOtUeCm03JU
         rEhi8HTYZpL/S2FP123b5nEwtDsh2vxHOJ28Gz6iFwGwCeG5J4FAh9uqIvGfltPVI2x0
         T3y8kyRZhefvZa6ieId7wJMueP0WyCsWxs4MWVMhtvXB4NmDCGvQt9orEYiVihRpgFMV
         YBHHBYdaQ0XYSdWR8TLpBWZWcbVrGeJa+BL+nnY2C5FR8UJTXnCJKjXimXWGxcefJcRb
         bJSQ==
X-Gm-Message-State: AOJu0Ywc5f68uUwhLynFCFt3LKLmu8mtYkIL+gyWyhlp65qlNJ7hr1vM
        /+fpoaAVJ/E2i+tQmaSFRuG2a/vKFOcOZ8NPndSlflROgdJ3
X-Google-Smtp-Source: AGHT+IGyYnRt97i5SMVmV2sB4rOE1qow3rOxyUC0QZvOgXR0y9C5+7w18rCV4O9IfFIVUXuIBYu9nkpMNX+fnXn9FZeTI/9+rcnP
MIME-Version: 1.0
X-Received: by 2002:a17:903:32cb:b0:1c0:760b:b5b2 with SMTP id
 i11-20020a17090332cb00b001c0760bb5b2mr2679392plr.6.1694316568367; Sat, 09 Sep
 2023 20:29:28 -0700 (PDT)
Date:   Sat, 09 Sep 2023 20:29:28 -0700
In-Reply-To: <ZP0xyFnnghM42GcW@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031d9e80604f8d176@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad page map

BUG: Bad page map in process syz-executor.0  pte:fffff9b7dc120 pmd:1ce8f067
page:ffffea00019208c0 refcount:9 mapcount:-1 mapping:ffff8880766e5190 index:0x3 pfn:0x64823
head:ffffea0001920800 order:2 entire_mapcount:0 nr_pages_mapped:8388607 pincount:0
memcg:ffff88801d8b4000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001920801 dead000000000122 dead000000000400
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea0001a08288 ffff88807acd1030 ffff8880766e5190
head: 0000000000000000 ffff888019789200 00000009ffffffff ffff88801d8b4000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5453, tgid 5452 (syz-executor.0), ts 76204282340, free_ts 15924727179
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:976
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3291
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
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6342
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020006000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff8880766e5190 index:5
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 1 PID: 5453 Comm: syz-executor.0 Not tainted 6.5.0-syzkaller-12921-ga3c57ab79a06-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
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
RIP: 0033:0x7f4cbf47cae9
Code: Unable to access opcode bytes at 0x7f4cbf47cabf.
RSP: 002b:00007f4cc01920c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 00007f4cbf59bf80 RCX: 00007f4cbf47cae9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 00007f4cbf4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4cbf59bf80 R15: 00007fff582f4a98
 </TASK>
BUG: Bad page map in process syz-executor.0  pte:fffff9b7dd120 pmd:1ce8f067
page:ffffea0001920880 refcount:9 mapcount:-1 mapping:ffff8880766e5190 index:0x2 pfn:0x64822
head:ffffea0001920800 order:2 entire_mapcount:0 nr_pages_mapped:8388606 pincount:0
memcg:ffff88801d8b4000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001920801 ffffea0001920890 ffffea0001920890
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea0001a08288 ffff88807acd1030 ffff8880766e5190
head: 0000000000000000 ffff888019789200 00000009ffffffff ffff88801d8b4000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5453, tgid 5452 (syz-executor.0), ts 76204282340, free_ts 15924721374
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:976
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3291
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
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6342
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020007000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff8880766e5190 index:6
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 0 PID: 5453 Comm: syz-executor.0 Tainted: G    B              6.5.0-syzkaller-12921-ga3c57ab79a06-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
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
RIP: 0033:0x7f4cbf47cae9
Code: Unable to access opcode bytes at 0x7f4cbf47cabf.
RSP: 002b:00007f4cc01920c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 00007f4cbf59bf80 RCX: 00007f4cbf47cae9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 00007f4cbf4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4cbf59bf80 R15: 00007fff582f4a98
 </TASK>
BUG: Bad page map in process syz-executor.0  pte:fffff9b7de120 pmd:1ce8f067
page:ffffea0001920840 refcount:9 mapcount:-1 mapping:ffff8880766e5190 index:0x1 pfn:0x64821
head:ffffea0001920800 order:2 entire_mapcount:0 nr_pages_mapped:8388605 pincount:0
memcg:ffff88801d8b4000
aops:xfs_address_space_operations ino:244a dentry name:"bus"
flags: 0xfff0000000816c(referenced|uptodate|lru|active|private|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000202 ffffea0001920801 dead000000000122 fffffffdffffffff
raw: 0000000400000000 0000000000000000 00000000fffffffe 0000000000000000
head: 00fff0000000816c ffffea0001a08288 ffff88807acd1030 ffff8880766e5190
head: 0000000000000000 ffff888019789200 00000009ffffffff ffff88801d8b4000
page dumped because: bad pte
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5453, tgid 5452 (syz-executor.0), ts 76204282340, free_ts 15924715505
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2308
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:976
 ra_alloc_folio mm/readahead.c:468 [inline]
 page_cache_ra_order+0x423/0xcc0 mm/readahead.c:524
 do_sync_mmap_readahead+0x444/0x850
 filemap_fault+0x7d3/0x1710 mm/filemap.c:3291
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
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6342
 destroy_args+0x95/0x7c0 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ac/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x23d/0x7d0 init/main.c:1232
 do_initcall_level+0x157/0x210 init/main.c:1294
 do_initcalls+0x3f/0x80 init/main.c:1310
 kernel_init_freeable+0x440/0x5d0 init/main.c:1547
 kernel_init+0x1d/0x2a0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
addr:0000000020008000 vm_flags:080000d0 anon_vma:0000000000000000 mapping:ffff8880766e5190 index:7
file:bus fault:xfs_filemap_fault mmap:xfs_file_mmap read_folio:xfs_vm_read_folio
CPU: 1 PID: 5453 Comm: syz-executor.0 Tainted: G    B              6.5.0-syzkaller-12921-ga3c57ab79a06-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
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
RIP: 0033:0x7f4cbf47cae9
Code: Unable to access opcode bytes at 0x7f4cbf47cabf.
RSP: 002b:00007f4cc01920c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffe5 RBX: 00007f4cbf59bf80 RCX: 00007f4cbf47cae9
RDX: 0000000000000002 RSI: 0000000020000300 RDI: 0000000000000007
RBP: 00007f4cbf4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4cbf59bf80 R15: 00007fff582f4a98
 </TASK>


Tested on:

commit:         a3c57ab7 iov_iter: Kunit tests for page extraction
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a308d8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50ac7dadde9e1c0e
dashboard link: https://syzkaller.appspot.com/bug?extid=55cc72f8cc3a549119df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1037a92c680000

