Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C24C7584B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjGRSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjGRSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:23:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04361E47
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:23:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-cc4f4351ac7so4320296276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689704581; x=1692296581;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrXIQiLnup5yfOLx/RI9/ZoU6LQnhRsoYQ3tqgvM6xY=;
        b=zw2+8c4rAfngr7c5Im07MSU5gXMXHp820wNHy8G3Hf/btzV0zoupFX5iaYhDdPlnaK
         jFp202Nj5H0Wry9hFY99oUDa4PBIHpyEvsreaStSwbqNaCrjja2TMwxebBhxum4Yjuwv
         riC3IsnkEbVNGxOP4SGOZy/wLJiKAYPdT9O1ZZE37zZFkCYCZ6YBWa0aF8QSR4Cf82H0
         Vecj2kD+3+BO3cni/5wd3ofLloS85EnKmjjuvAQrnktaJkvDcvbxUCvpHJPLB+LXYuoO
         XLdAV59I+4eoHg7m7bvwzEnEHS7Z0RqcV4crpm7vZiPdDxVz07cqsbrA4xc8cjxfTJ49
         JFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689704581; x=1692296581;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrXIQiLnup5yfOLx/RI9/ZoU6LQnhRsoYQ3tqgvM6xY=;
        b=ahurHzzvPlJj9REkOuhzwHNC2a0Qs+CtLLOWdSKIRxm9TCU2gsrpHhoFQOWIZM6DC+
         0AdAhFN0z2VvjHr1GoO8Vm30gnevJNZZt2VYQvWUoEfjgksQmtVRTHT6aeJPdsjDSTMt
         PCBQiZ96fBbLgEt/mumYo3PWC2BnrD3acSoyo9XXYboCb2mL4rv3WCkRqZCHgUljocuU
         SO2d1kfdnvQUJnm3uIIqsei8asXHDjXJnhb2voCzXKYJqlXrwpKuu72HyD1B3aOXEvId
         4UHon2wCEdc7F2kRNXNmoLKwG9lQCtfYp1mL9xsGOs94fcTyVIv8ndtAf1qjec/pcZbQ
         luGQ==
X-Gm-Message-State: ABy/qLacES7lg7FvQ81NdcQcG8RtuPNzQKdo2VeAmBKdVnf9t9S9oBvg
        rxF1rYW0+xjwFb51JU8kuwgYnw==
X-Google-Smtp-Source: APBJJlEM7tW9KeC9hGyEDukjnwh06miksBE1Vu5b7cUJ6QC3mQq5C4GRYZq6YI9mEc6UoOOrrM7S6A==
X-Received: by 2002:a25:c9c2:0:b0:ce8:2856:2b0b with SMTP id z185-20020a25c9c2000000b00ce828562b0bmr576401ybf.37.1689704581407;
        Tue, 18 Jul 2023 11:23:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 81-20020a251954000000b00c5fc63686f1sm543691ybz.16.2023.07.18.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:23:01 -0700 (PDT)
Date:   Tue, 18 Jul 2023 11:22:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Carlos Maiolino <cem@kernel.org>
cc:     syzbot <syzbot+38ca19393fb3344f57e6@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, cmaiolino@redhat.com, hughd@google.com,
        jack@suse.cz, lczerner@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] possible deadlock in shmem_uncharge (2)
In-Reply-To: <0000000000008e62f40600bfe080@google.com>
Message-ID: <f37e93d7-4313-b4b8-9c59-d0b129e6ac49@google.com>
References: <0000000000008e62f40600bfe080@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:

Yes, this doesn't require any syzbot trickery, it showed up as soon as
I tried a shmem quota linux-next with lockdep and shmem huge last week.

There's some other things wrong with the accounting there (in the non-
quota case anyway): I have been working up a patch to fix them, but need
to consider what must go in quickly, and what should wait until later.

Carlos, in brief: don't worry about this syzbot report, I'm on it (but
there's a risk that any patch I send may turn out to break your quotas).

Hugh

> 
> HEAD commit:    7c2878be5732 Add linux-next specific files for 20230714
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14b77fd8a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3baff2936ac3cefa
> dashboard link: https://syzkaller.appspot.com/bug?extid=38ca19393fb3344f57e6
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153eea12a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1169adeca80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bfdfa043f096/disk-7c2878be.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cf7a97f69e2a/vmlinux-7c2878be.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8366b63af2c6/bzImage-7c2878be.xz
> 
> The issue was bisected to:
> 
> commit 1a93dd24f1bee98ca121e68ce5c0de4a60a0a0b6
> Author: Carlos Maiolino <cem@kernel.org>
> Date:   Thu Jul 13 13:48:47 2023 +0000
> 
>     shmem: quota support
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11af3afaa80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13af3afaa80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15af3afaa80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+38ca19393fb3344f57e6@syzkaller.appspotmail.com
> Fixes: 1a93dd24f1be ("shmem: quota support")
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.5.0-rc1-next-20230714-syzkaller #0 Not tainted
> ------------------------------------------------------
> /5027 is trying to acquire lock:
> ffff88807dbd8758 (&info->lock){....}-{2:2}, at: shmem_uncharge+0x28/0x2b0 mm/shmem.c:450
> 
> but task is already holding lock:
> ffff88801526c068 (&lruvec->lru_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffff88801526c068 (&lruvec->lru_lock){....}-{2:2}, at: folio_lruvec_lock+0x1ba/0x3b0 mm/memcontrol.c:1323
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (&lruvec->lru_lock){....}-{2:2}:
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        spin_lock include/linux/spinlock.h:351 [inline]
>        folio_lruvec_lock+0x1ba/0x3b0 mm/memcontrol.c:1323
>        __split_huge_page mm/huge_memory.c:2538 [inline]
>        split_huge_page_to_list+0x103b/0x49e0 mm/huge_memory.c:2772
>        split_folio_to_list include/linux/huge_mm.h:400 [inline]
>        split_folio include/linux/huge_mm.h:405 [inline]
>        truncate_inode_partial_folio+0x544/0x760 mm/truncate.c:242
>        shmem_undo_range+0x723/0x1190 mm/shmem.c:1026
>        shmem_truncate_range mm/shmem.c:1120 [inline]
>        shmem_setattr+0xd43/0x1050 mm/shmem.c:1205
>        notify_change+0x742/0x11c0 fs/attr.c:485
>        do_truncate+0x15c/0x220 fs/open.c:66
>        do_sys_ftruncate+0x6a2/0x790 fs/open.c:194
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #2 (&xa->xa_lock#7){..-.}-{2:2}:
>        __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
>        _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
>        spin_lock_irq include/linux/spinlock.h:376 [inline]
>        filemap_remove_folio+0xbf/0x250 mm/filemap.c:259
>        truncate_inode_folio+0x49/0x70 mm/truncate.c:195
>        shmem_undo_range+0x363/0x1190 mm/shmem.c:1004
>        shmem_truncate_range mm/shmem.c:1120 [inline]
>        shmem_evict_inode+0x334/0xb10 mm/shmem.c:1250
>        evict+0x2ed/0x6b0 fs/inode.c:665
>        iput_final fs/inode.c:1791 [inline]
>        iput.part.0+0x55e/0x7a0 fs/inode.c:1817
>        iput+0x5c/0x80 fs/inode.c:1807
>        dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
>        __dentry_kill+0x3b8/0x640 fs/dcache.c:607
>        dentry_kill fs/dcache.c:745 [inline]
>        dput+0x703/0xfd0 fs/dcache.c:913
>        do_renameat2+0xc4c/0xdc0 fs/namei.c:5011
>        __do_sys_rename fs/namei.c:5055 [inline]
>        __se_sys_rename fs/namei.c:5053 [inline]
>        __x64_sys_rename+0x81/0xa0 fs/namei.c:5053
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #1 (&sb->s_type->i_lock_key){+.+.}-{2:2}:
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        spin_lock include/linux/spinlock.h:351 [inline]
>        inode_sub_bytes+0x28/0x100 fs/stat.c:816
>        __dquot_free_space+0x8f7/0xaf0 fs/quota/dquot.c:1881
>        dquot_free_space_nodirty include/linux/quotaops.h:379 [inline]
>        dquot_free_block_nodirty include/linux/quotaops.h:390 [inline]
>        shmem_inode_unacct_blocks mm/shmem.c:243 [inline]
>        shmem_recalc_inode+0x196/0x350 mm/shmem.c:420
>        shmem_undo_range+0x558/0x1190 mm/shmem.c:1114
>        shmem_truncate_range mm/shmem.c:1120 [inline]
>        shmem_evict_inode+0x334/0xb10 mm/shmem.c:1250
>        evict+0x2ed/0x6b0 fs/inode.c:665
>        iput_final fs/inode.c:1791 [inline]
>        iput.part.0+0x55e/0x7a0 fs/inode.c:1817
>        iput+0x5c/0x80 fs/inode.c:1807
>        dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
>        __dentry_kill+0x3b8/0x640 fs/dcache.c:607
>        dentry_kill fs/dcache.c:745 [inline]
>        dput+0x703/0xfd0 fs/dcache.c:913
>        do_renameat2+0xc4c/0xdc0 fs/namei.c:5011
>        __do_sys_rename fs/namei.c:5055 [inline]
>        __se_sys_rename fs/namei.c:5053 [inline]
>        __x64_sys_rename+0x81/0xa0 fs/namei.c:5053
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (&info->lock){....}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3142 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3261 [inline]
>        validate_chain kernel/locking/lockdep.c:3876 [inline]
>        __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
>        lock_acquire kernel/locking/lockdep.c:5761 [inline]
>        lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
>        shmem_uncharge+0x28/0x2b0 mm/shmem.c:450
>        __split_huge_page mm/huge_memory.c:2549 [inline]
>        split_huge_page_to_list+0x3832/0x49e0 mm/huge_memory.c:2772
>        split_folio_to_list include/linux/huge_mm.h:400 [inline]
>        split_folio include/linux/huge_mm.h:405 [inline]
>        truncate_inode_partial_folio+0x544/0x760 mm/truncate.c:242
>        shmem_undo_range+0x723/0x1190 mm/shmem.c:1026
>        shmem_truncate_range mm/shmem.c:1120 [inline]
>        shmem_setattr+0xd43/0x1050 mm/shmem.c:1205
>        notify_change+0x742/0x11c0 fs/attr.c:485
>        do_truncate+0x15c/0x220 fs/open.c:66
>        do_sys_ftruncate+0x6a2/0x790 fs/open.c:194
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &info->lock --> &xa->xa_lock#7 --> &lruvec->lru_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&lruvec->lru_lock);
>                                lock(&xa->xa_lock#7);
>                                lock(&lruvec->lru_lock);
>   lock(&info->lock);
> 
>  *** DEADLOCK ***
> 
> 5 locks held by /5027:
>  #0: ffff8880762b4410 (sb_writers#5){.+.+}-{0:0}, at: do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  #0: ffff8880762b4410 (sb_writers#5){.+.+}-{0:0}, at: do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  #1: ffff88807dbd8a50 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
>  #1: ffff88807dbd8a50 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: do_truncate+0x14b/0x220 fs/open.c:64
>  #2: ffff88807dbd8cf0 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:501 [inline]
>  #2: ffff88807dbd8cf0 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: split_huge_page_to_list+0x7d5/0x49e0 mm/huge_memory.c:2712
>  #3: ffff88807dbd8b60 (&xa->xa_lock#7){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #3: ffff88807dbd8b60 (&xa->xa_lock#7){..-.}-{2:2}, at: split_huge_page_to_list+0x980/0x49e0 mm/huge_memory.c:2744
>  #4: ffff88801526c068 (&lruvec->lru_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #4: ffff88801526c068 (&lruvec->lru_lock){....}-{2:2}, at: folio_lruvec_lock+0x1ba/0x3b0 mm/memcontrol.c:1323
> 
> stack backtrace:
> CPU: 0 PID: 5027 Comm:  Not tainted 6.5.0-rc1-next-20230714-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2195
>  check_prev_add kernel/locking/lockdep.c:3142 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3261 [inline]
>  validate_chain kernel/locking/lockdep.c:3876 [inline]
>  __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
>  lock_acquire kernel/locking/lockdep.c:5761 [inline]
>  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
>  shmem_uncharge+0x28/0x2b0 mm/shmem.c:450
>  __split_huge_page mm/huge_memory.c:2549 [inline]
>  split_huge_page_to_list+0x3832/0x49e0 mm/huge_memory.c:2772
>  split_folio_to_list include/linux/huge_mm.h:400 [inline]
>  split_folio include/linux/huge_mm.h:405 [inline]
>  truncate_inode_partial_folio+0x544/0x760 mm/truncate.c:242
>  shmem_undo_range+0x723/0x1190 mm/shmem.c:1026
>  shmem_truncate_range mm/shmem.c:1120 [inline]
>  shmem_setattr+0xd43/0x1050 mm/shmem.c:1205
>  notify_change+0x742/0x11c0 fs/attr.c:485
>  do_truncate+0x15c/0x220 fs/open.c:66
>  do_sys_ftruncate+0x6a2/0x790 fs/open.c:194
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fcc0ae38b99
> Code: 48 83 c4 28 c3 e8 67 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcd4272e58 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> RAX: ffffffffffffffda RBX: 00007ffcd4272e60 RCX: 00007fcc0ae38b99
> RDX: 00007fcc0ae38b99 RSI: 0000000000008979 RDI: 0000000000000003
> RBP: 00007ffcd4272e68 R08: 00007fcc0ae05c10 R09: 00007fcc0ae05c10
> R10: 0000000000000000 R11: 000000
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
