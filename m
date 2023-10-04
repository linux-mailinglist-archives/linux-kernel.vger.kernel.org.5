Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5687B8038
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjJDNGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:06:33 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DCA98
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:06:28 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c4ecdd6dc9so2331298a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424788; x=1697029588;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLyJhP+ORC+rv+hdB+CIAaXPBxtRM8q5VeD3BGguRPM=;
        b=H+nwBjOfbMOGvpdTsPZ/QTCS3OTOFJgItB1heKrBKU/hs9M7/mR7BEGY/bzOzDcFl8
         Wt3pmFcn5MsfrnOKgpuAk07oyeHQS7pmkTO3Ksh+quB3V9iMqTzZOy5NksMKi1HwatJ4
         Q2ewu2qzhyR9tGuuyF0mnP/7F8pxVhJtn+ZhGBkp5PhsLQVMX5GSd/5mdnRwiAxjRyr7
         flabzeczmFNDx74kT1tidtXV1fAn6nB7n9R0RH7to7hatZCKS2s59oJ26DncDbbWElnd
         bwu95TSuEqPYoLy2/r34UeJs8K8jt6IN3D4WkFbjF4zedjWucVLvZKsh0mlKE0smALQY
         wQMw==
X-Gm-Message-State: AOJu0YzAS9CZZIosLPs7MEzdmaAsiYXo33Cs6yXyHbbDT71qb0O/lqt3
        Z09MLEmf/UUgZtIv7caqoNaJlgnPd3sPge/PJ9e4oRI1GJqp
X-Google-Smtp-Source: AGHT+IHIp9bumRSZ3qTrk/VN6evc7OuwP2uNG/0x3s20Ozej4cboVPKaK5fWG7okezS8Kx+7yzgdb4l4sIVvovO9ouCv1OhjWDeE
MIME-Version: 1.0
X-Received: by 2002:a9d:7f8c:0:b0:6c4:e41c:6e6a with SMTP id
 t12-20020a9d7f8c000000b006c4e41c6e6amr534385otp.4.1696424788181; Wed, 04 Oct
 2023 06:06:28 -0700 (PDT)
Date:   Wed, 04 Oct 2023 06:06:28 -0700
In-Reply-To: <20231004105010.1901-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e349310606e3ace2@google.com>
Subject: Re: [syzbot] [mm?] WARNING in page_vma_mapped_walk
From:   syzbot <syzbot+dcf3f48f4bfe47a2f80a@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in try_to_migrate_one

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc4-next-20231003-syzkaller-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/5480 is trying to acquire lock:
ffff8880156a0df8 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:847 [inline]
ffff8880156a0df8 (mapping.invalidate_lock#3){++++}-{3:3}, at: try_to_migrate_one+0x4ac/0x29e0 mm/rmap.c:1950

but task is already holding lock:
ffff88807f7f58f8 (&anon_vma->rwsem){++++}-{3:3}, at: folio_lock_anon_vma_read+0x187/0xb20 mm/rmap.c:555

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&anon_vma->rwsem){++++}-{3:3}:
       down_write+0x93/0x200 kernel/locking/rwsem.c:1579
       anon_vma_lock_write include/linux/rmap.h:121 [inline]
       __anon_vma_prepare+0xbd/0x550 mm/rmap.c:210
       anon_vma_prepare include/linux/rmap.h:164 [inline]
       hugetlb_no_page mm/hugetlb.c:5812 [inline]
       hugetlb_fault+0x1d04/0x24a0 mm/hugetlb.c:5999
       handle_mm_fault+0x905/0xa00 mm/memory.c:5430
       do_user_addr_fault+0x3d1/0x1000 arch/x86/mm/fault.c:1413
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x5c/0xd0 arch/x86/mm/fault.c:1561
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (mapping.invalidate_lock#3){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       down_write+0x93/0x200 kernel/locking/rwsem.c:1579
       filemap_invalidate_lock include/linux/fs.h:847 [inline]
       try_to_migrate_one+0x4ac/0x29e0 mm/rmap.c:1950
       rmap_walk_anon+0x225/0x570 mm/rmap.c:2526
       rmap_walk mm/rmap.c:2603 [inline]
       rmap_walk mm/rmap.c:2598 [inline]
       try_to_migrate+0x2b6/0x300 mm/rmap.c:2255
       unmap_and_move_huge_page mm/migrate.c:1421 [inline]
       migrate_hugetlbs mm/migrate.c:1547 [inline]
       migrate_pages+0xa42/0x27c0 mm/migrate.c:1901
       migrate_to_node mm/mempolicy.c:1097 [inline]
       do_migrate_pages+0x2e9/0x670 mm/mempolicy.c:1196
       kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1681
       __do_sys_migrate_pages mm/mempolicy.c:1700 [inline]
       __se_sys_migrate_pages mm/mempolicy.c:1696 [inline]
       __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1696
       do_syscall_x64 arch/x86/entry/common.c:51 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&anon_vma->rwsem);
                               lock(mapping.invalidate_lock#3);
                               lock(&anon_vma->rwsem);
  lock(mapping.invalidate_lock#3);

 *** DEADLOCK ***

2 locks held by syz-executor.0/5480:
 #0: ffff888025bd1e20 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:146 [inline]
 #0: ffff888025bd1e20 (&mm->mmap_lock){++++}-{3:3}, at: do_migrate_pages+0xc8/0x670 mm/mempolicy.c:1121
 #1: ffff88807f7f58f8 (&anon_vma->rwsem){++++}-{3:3}, at: folio_lock_anon_vma_read+0x187/0xb20 mm/rmap.c:555

stack backtrace:
CPU: 0 PID: 5480 Comm: syz-executor.0 Not tainted 6.6.0-rc4-next-20231003-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_write+0x93/0x200 kernel/locking/rwsem.c:1579
 filemap_invalidate_lock include/linux/fs.h:847 [inline]
 try_to_migrate_one+0x4ac/0x29e0 mm/rmap.c:1950
 rmap_walk_anon+0x225/0x570 mm/rmap.c:2526
 rmap_walk mm/rmap.c:2603 [inline]
 rmap_walk mm/rmap.c:2598 [inline]
 try_to_migrate+0x2b6/0x300 mm/rmap.c:2255
 unmap_and_move_huge_page mm/migrate.c:1421 [inline]
 migrate_hugetlbs mm/migrate.c:1547 [inline]
 migrate_pages+0xa42/0x27c0 mm/migrate.c:1901
 migrate_to_node mm/mempolicy.c:1097 [inline]
 do_migrate_pages+0x2e9/0x670 mm/mempolicy.c:1196
 kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1681
 __do_sys_migrate_pages mm/mempolicy.c:1700 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1696 [inline]
 __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1696
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fce6d67cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fce6e47d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
RAX: ffffffffffffffda RBX: 00007fce6d79bf80 RCX: 00007fce6d67cae9
RDX: 0000000020000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 00007fce6d6c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fce6d79bf80 R15: 00007ffe82a8ede8
 </TASK>


Tested on:

commit:         c9f2baaa Add linux-next specific files for 20231003
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135c1b8a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe9c462fee1649f
dashboard link: https://syzkaller.appspot.com/bug?extid=dcf3f48f4bfe47a2f80a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1712a3f6680000

