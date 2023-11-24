Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544747F6A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjKXBc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:32:58 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D5120
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:33:04 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b8d4a559ddso1850403a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700789584; x=1701394384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1rzFH8fuxJuHJ8Ddry/3CxkefRTK/kmByfwUsW7K2M=;
        b=GwGx5OkFRHlTRzZIKnvtYcBUh23z94Xny7BI6vEUqnR2uZwtb7UQZIBLzq2BHxWygM
         DEl07ErzecOQ/M77Zne8wvFAldFMcxUFGJ+RyN4FUYjuEHoaMda+lXAItW9xaxvbqXpR
         PfMkjkAJa05F52/Ne4fvZrbkInwAF04m6juzbUfK21le2Henh7OvMDhjsLylZKrqY6zE
         9Z4o/ZdoBXKijdz+aIxbbRq4ua3i/X2GUvrXo4gJcDdknOZZ7BDDubbFPp4zI34Kb6bw
         MZsAedrHYnd40FFbczV3R17uIAaWiUx0hcyTaMlxwtqridsGMVmv9TazFqjgnI+Ctd9F
         SKNA==
X-Gm-Message-State: AOJu0YysPhKKYvyR8PWRQ9QxY0dgExVxlj///xk3cqFii4WyI4BP4adY
        4CFceGkYinMKPezhm57yC25PKNe7KUgM4jW5ICsaoHPJEabqbj4=
X-Google-Smtp-Source: AGHT+IGJdxEghe6cLH0eQCqtGU2TaofrI/2gNT9bltOM9236IP4M3tn4ap3qEo2gWer38958DofSgBmFImgze7dqMvF6tIHcz9OG
MIME-Version: 1.0
X-Received: by 2002:a63:e310:0:b0:5b9:63f2:e4cc with SMTP id
 f16-20020a63e310000000b005b963f2e4ccmr167928pgh.2.1700789583807; Thu, 23 Nov
 2023 17:33:03 -0800 (PST)
Date:   Thu, 23 Nov 2023 17:33:03 -0800
In-Reply-To: <20231124011216.3062608-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb0bee060adbee80@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: out-of-bounds Write in end_buffer_read_sync

==================================================================
BUG: KASAN: out-of-bounds in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: out-of-bounds in atomic_dec include/linux/atomic/atomic-instrumented.h:592 [inline]
BUG: KASAN: out-of-bounds in put_bh include/linux/buffer_head.h:306 [inline]
BUG: KASAN: out-of-bounds in end_buffer_read_sync+0x8f/0xe0 fs/buffer.c:161
Write of size 4 at addr ffffc900037f7898 by task ksoftirqd/1/26

CPU: 1 PID: 26 Comm: ksoftirqd/1 Not tainted 6.7.0-rc1-syzkaller-00344-g037266a5f723-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:592 [inline]
 put_bh include/linux/buffer_head.h:306 [inline]
 end_buffer_read_sync+0x8f/0xe0 fs/buffer.c:161
 end_bio_bh_io_sync+0xdd/0x130 fs/buffer.c:2775
 bio_endio+0x596/0x6a0 block/bio.c:1603
 req_bio_endio block/blk-mq.c:788 [inline]
 blk_update_request+0x67b/0x1700 block/blk-mq.c:933
 blk_mq_end_request+0x57/0x520 block/blk-mq.c:1056
 lo_complete_rq+0x232/0x2f0 drivers/block/loop.c:370
 blk_complete_reqs+0xb2/0xf0 block/blk-mq.c:1131
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x660/0xa10 kernel/smpboot.c:164
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc900037f0000, ffffc900037f9000) created by:
 kernel_clone+0xfd/0x930 kernel/fork.c:2907

The buggy address belongs to the physical page:
page:ffffea0000810580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20416
memcg:ffff888021062402
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff888021062402
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5624, tgid 5624 (syz-executor.0), ts 88700425268, free_ts 88116212491
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xa25/0x36d0 mm/page_alloc.c:3312
 __alloc_pages+0x22e/0x2420 mm/page_alloc.c:4568
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0xa6e/0x1540 mm/vmalloc.c:3320
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct kernel/fork.c:1118 [inline]
 copy_process+0x138b/0x73f0 kernel/fork.c:2332
 kernel_clone+0xfd/0x930 kernel/fork.c:2907
 __do_sys_clone3+0x1f1/0x260 kernel/fork.c:3208
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x4fa/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2487
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc3/0x110 mm/swap.c:129
 folio_put include/linux/mm.h:1483 [inline]
 put_page include/linux/mm.h:1552 [inline]
 free_page_and_swap_cache+0x25a/0x2d0 mm/swap_state.c:304
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:154 [inline]
 tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:209
 rcu_do_batch kernel/rcu/tree.c:2158 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2431
 __do_softirq+0x21a/0x8de kernel/softirq.c:553

Memory state around the buggy address:
 ffffc900037f7780: 00 00 00 f1 f1 f1 f1 f1 f1 04 f2 00 f3 f3 f3 00
 ffffc900037f7800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1
>ffffc900037f7880: f1 f1 f1 f1 f1 04 f2 00 f3 f3 f3 00 00 00 00 00
                               ^
 ffffc900037f7900: 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2
 ffffc900037f7980: f2 00 f2 f2 f2 00 f3 f3 f3 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15670d9f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11aa257ce80000

