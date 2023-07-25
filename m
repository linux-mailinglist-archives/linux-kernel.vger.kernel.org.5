Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9FF76234F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGYU1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGYU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:27:47 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA6E4F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:27:44 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1b789515871so11144744fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316864; x=1690921664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlqGNncxRU4scrz3VsUwhOqenmsYgS5YkGeTubF5kEw=;
        b=lOmb8deI8OceYDrY7uKTsnSJOKEsYLaV7S64ApiTnLDxIe3qMA1FCWRwC/OzhejYFG
         0eQV8VVj/hQSkOJEvt4brqZjma9G6ZH8vEq9egRWasOpYvMzYmP9fJ6EltWCIJyE+ZsF
         1sK6k3Pjpd8NoQW4GRaY7h9GKUiFz6Djnt8yhhvbG4xPKCJfwMcBsmXf1wYdqLRpXLpf
         sME2XmIvfv1eCdByZ0BzCMQ4dXO8LVdahPFN9U9TNWif1rZyIR86wNTXhQvoYSeJ3dS0
         +igS6cofJf/jAs7WdQkxllekfmD6cU53pSpyeIibzcdbcC3YR2nXjuuYQYdF3tv+LkmZ
         5Qsg==
X-Gm-Message-State: ABy/qLZWv14+PciULIub5j6R3rpwB0QfnkRXj1uzQnvtdn4fEZcLymqE
        2ADvZkEQtoTFxnmQU+S8eaY31a2ME+A7NnmazdmgJr4vb1xX
X-Google-Smtp-Source: APBJJlE1z4JFr+/hI0gNNxegYDi7Kqt1pMPfnI4niVCtr7ejtkygXDOQez4yQV1reGKG5Y2t0AXFt9i5s2DDFRVKtAWEP1/graD2
MIME-Version: 1.0
X-Received: by 2002:a05:6870:954e:b0:1bb:6ec5:1009 with SMTP id
 v14-20020a056870954e00b001bb6ec51009mr193347oal.11.1690316864214; Tue, 25 Jul
 2023 13:27:44 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:27:44 -0700
In-Reply-To: <000000000000607ff905ffc8e477@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fdcc506015590d6@google.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
From:   syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    1e25dd777248 Add linux-next specific files for 20230725
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10ce2c31a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481ab36ce878b84
dashboard link: https://syzkaller.appspot.com/bug?extid=8645fe63c4d22c8d27b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1697cec9a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1566986ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0c7408382e8/disk-1e25dd77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4b0f14b8c88/vmlinux-1e25dd77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b38cfdfd7db8/bzImage-1e25dd77.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.5.0-rc3-next-20230725-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:839 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor244/5034:
 #0: ffff88802b3f0148 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:654 [inline]
 #0: ffff88802b3f0148 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x201/0x950 mm/memory.c:5585

stack backtrace:
CPU: 0 PID: 5034 Comm: syz-executor244 Not tainted 6.5.0-rc3-next-20230725-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6719
 mas_root lib/maple_tree.c:839 [inline]
 mas_root lib/maple_tree.c:837 [inline]
 mas_start lib/maple_tree.c:1381 [inline]
 mas_state_walk lib/maple_tree.c:3832 [inline]
 mas_walk+0x55e/0x7d0 lib/maple_tree.c:4973
 find_mergeable_anon_vma+0x102/0x890 mm/mmap.c:1085
 __anon_vma_prepare+0x7d/0x550 mm/rmap.c:200
 anon_vma_prepare include/linux/rmap.h:159 [inline]
 wp_page_copy mm/memory.c:3202 [inline]
 do_wp_page+0x1bbf/0x2e10 mm/memory.c:3579
 handle_pte_fault mm/memory.c:5133 [inline]
 __handle_mm_fault+0x1704/0x4030 mm/memory.c:5257
 handle_mm_fault+0x47a/0xa00 mm/memory.c:5422
 do_user_addr_fault+0x2e7/0xfe0 arch/x86/mm/fault.c:1342
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x5c/0xd0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7fbc6b3fd6e5
Code: 6a 00 41 b8 12 10 01 00 be 00 00 00 20 4c 8b 0d 21 9a 0a 00 bf 09 00 00 00 e8 37 2a 03 00 b9 00 04 00 20 ba 46 ae 20 40 31 c0 <c7> 04 25 00 04 00 20 00 00 00 00 be ff ff ff ff bf 10 00 00 00 c7
RSP: 002b:00007ffd68c881f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007ffd68c883c8 RCX: 0000000020000400
RDX: 000000004020ae46 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007fbc6b4a3610 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000011012 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd68c883b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

=============================
WARNING: suspicious RCU usage
6.5.0-rc3-next-20230725-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:795 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor244/5034:
 #0: ffff88802b3f0148 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:654 [inline]
 #0: ffff88802b3f0148 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x201/0x950 mm/memory.c:5585

stack backtrace:
CPU: 0 PID: 5034 Comm: syz-executor244 Not tainted 6.5.0-rc3-next-20230725-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20c/0x3b0 kernel/locking/lockdep.c:6719
 mt_slot lib/maple_tree.c:795 [inline]
 mt_slot lib/maple_tree.c:792 [inline]
 mtree_range_walk+0x6c5/0x9b0 lib/maple_tree.c:2946
 mas_state_walk lib/maple_tree.c:3839 [inline]
 mas_walk+0x389/0x7d0 lib/maple_tree.c:4973
 find_mergeable_anon_vma+0x102/0x890 mm/mmap.c:1085
 __anon_vma_prepare+0x7d/0x550 mm/rmap.c:200
 anon_vma_prepare include/linux/rmap.h:159 [inline]
 wp_page_copy mm/memory.c:3202 [inline]
 do_wp_page+0x1bbf/0x2e10 mm/memory.c:3579
 handle_pte_fault mm/memory.c:5133 [inline]
 __handle_mm_fault+0x1704/0x4030 mm/memory.c:5257
 handle_mm_fault+0x47a/0xa00 mm/memory.c:5422
 do_user_addr_fault+0x2e7/0xfe0 arch/x86/mm/fault.c:1342
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x5c/0xd0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7fbc6b3fd6e5
Code: 6a 00 41 b8 12 10 01 00 be 00 00 00 20 4c 8b 0d 21 9a 0a 00 bf 09 00 00 00 e8 37 2a 03 00 b9 00 04 00 20 ba 46 ae 20 40 31 c0 <c7> 04 25 00 04 00 20 00 00 00 00 be ff ff ff ff bf 10 00 00 00 c7
RSP: 002b:00007ffd68c881f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007ffd68c883c8 RCX: 0000000020000400
RDX: 000000004020ae46 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007fbc6b4a3610 R08: 0000000000000003 R09: 0000000000000000
R10: 000000000001101


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
