Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548F57D4C79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjJXJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjJXJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:33:01 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5081726
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:31:55 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1dcdb642868so6682226fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139915; x=1698744715;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WvjhLNa8d2oEwSVAmtTQ9INn0GqgmohbDh5F5AEOmk=;
        b=NzufHrXnsy3w9PJnpzOSR5uQw0AhDq1rbMrPBHXqAMtgMa9HPJpE8u4L777CDkRQda
         wb1nuWd1/79ntF9rBOVGjW6GrwR93OeDylqMFAn64cHMB6J/LI2tbbs4QzvBswknCMUv
         irAYq4Cy/8WI3gmdmuScb9gP7iZbM5wVQhPvNPQ240nKDHPfXXiLxRAR37Mod095DN5/
         b34vfWXBTfUg5vN4j1S9OGMZm+hhrlICv6cZDSJeHvNFfsDxOYsZC6e0nyGnBdTN2ufd
         Kzm6fJ2xTPDJBIP6X1C4jQ+XR0L8B/8cF5N+D9tzTBL4H9GH9S+M9yc5Xxg0+mURFt/G
         Pl1g==
X-Gm-Message-State: AOJu0YyeImrtZSV62/NyKI7YgpAVTeDYbXYvejlOUEJYWgewvgLRSdfg
        MGjIukXirRlxO+gLo5WbeN7qKWO4GHpo3+GX/G/iTV8DvMD0
X-Google-Smtp-Source: AGHT+IFughUpyRw+6yKUOu+n83Xwe4zpBla6bRfnTg2ykJ553IEHzVGgWSAuKzk2twJU7b5PD4scRcbbUurHT8ef5PfCqkIiRG9l
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9215:b0:1e9:92d7:47d2 with SMTP id
 e21-20020a056870921500b001e992d747d2mr5438769oaf.10.1698139915199; Tue, 24
 Oct 2023 02:31:55 -0700 (PDT)
Date:   Tue, 24 Oct 2023 02:31:55 -0700
In-Reply-To: <000000000000985ef90607610b0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cab1e06087302dd@google.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (3)
From:   syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, postmaster@duagon.onmicrosoft.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e8361b005d7c Add linux-next specific files for 20231023
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1535f3a3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39bda8753f457952
dashboard link: https://syzkaller.appspot.com/bug?extid=79fcba037b6df73756d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13714705680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1236430b680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6e9b9de3681/disk-e8361b00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5aadf3761d05/vmlinux-e8361b00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/704f56d3327c/bzImage-e8361b00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.6.0-rc6-next-20231023-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor445/16542.

stack backtrace:
CPU: 1 PID: 16542 Comm: syz-executor445 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20b/0x3a0 kernel/locking/lockdep.c:6711
 mas_root lib/maple_tree.c:856 [inline]
 mas_root lib/maple_tree.c:854 [inline]
 mas_start lib/maple_tree.c:1385 [inline]
 mas_state_walk lib/maple_tree.c:3705 [inline]
 mas_walk+0x4d1/0x7d0 lib/maple_tree.c:4888
 mas_find_setup lib/maple_tree.c:5948 [inline]
 mas_find+0x1e6/0x400 lib/maple_tree.c:5989
 vma_find include/linux/mm.h:952 [inline]
 do_mbind+0xc8f/0x1010 mm/mempolicy.c:1328
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f384f7bd229
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f384f753158 EFLAGS: 00000212 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f384f8413f8 RCX: 00007f384f7bd229
RDX: 0000000000000003 RSI: 0000000000005000 RDI: 0000000020182000
RBP: 00007f384f8413f0 R08: 000000000000007f R09: 0000000000000003
R10: 0000000020000040 R11: 0000000000000212 R12: 00007f384f8413fc
R13: 000000000000006e R14: 00007ffdafb5ca20 R15: 00007ffdafb5cb08
 </TASK>

=============================
WARNING: suspicious RCU usage
6.6.0-rc6-next-20231023-syzkaller #0 Not tainted
-----------------------------
lib/maple_tree.c:812 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor445/16542.

stack backtrace:
CPU: 0 PID: 16542 Comm: syz-executor445 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x20b/0x3a0 kernel/locking/lockdep.c:6711
 mt_slot lib/maple_tree.c:812 [inline]
 mt_slot lib/maple_tree.c:809 [inline]
 mtree_range_walk+0x6c5/0x9b0 lib/maple_tree.c:2827
 mas_state_walk lib/maple_tree.c:3712 [inline]
 mas_walk+0x374/0x7d0 lib/maple_tree.c:4888
 mas_find_setup lib/maple_tree.c:5948 [inline]
 mas_find+0x1e6/0x400 lib/maple_tree.c:5989
 vma_find include/linux/mm.h:952 [inline]
 do_mbind+0xc8f/0x1010 mm/mempolicy.c:1328
 kernel_mbind+0x1d4/0x1f0 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f384f7bd229
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f384f753158 EFLAGS: 00000212 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f384f8413f8 RCX: 00007f384f7bd229
RDX: 0000000000000003 RSI: 0000000000005000 RDI: 0000000020182000
RBP: 00007f384f8413f0 R08: 000000000000007f R09: 0000000000000003
R10: 0000000020000040 R11: 0000000000000212 R12: 00007f384f8413fc
R13: 000000000000006e R14: 00007ffdafb5ca20 R15: 00007ffdafb5cb08
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
