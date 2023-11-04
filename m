Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C177E0DED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 06:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjKDFRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 01:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjKDFRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 01:17:07 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59B18B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 22:17:03 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3e82429edso3831957b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 22:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699075023; x=1699679823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N30kyK/tQm6qLAOseB+Wu/B8cFwZHT6A7EO+rKSE0oY=;
        b=fPFJIK7lPb14JoGwMJVFAFpPkWthUBM+q0xXzh/XkjK7W0c/8t76mJc/J74VaucZh0
         eSUo162vTLKIBF7sWCIVoS8EY76hhLlPXfzyO8IqyfiBtfbYej6sq98Qkyc4ODSHxL4r
         7oQy+Kja6axLYJfo/n7opR8hxKJwixfTdsLDR0DeQLdA7ijo9qidGeCVgipLDtyDkkCr
         fEUwkOyRATgchyTpM4IC60yfvhRQ19ptX8VR46ZjjnG2+gsCutSE056YLPw4ekc5qglX
         E5DzVQhhYCiUejrVuxF963gQneqeWncZdeLdfHuV01rWMlVjX6nwZzyGW3J1PTDSBYbA
         i+Qg==
X-Gm-Message-State: AOJu0Yy2QfiY2/6SncJksO6TTd8JPyGm4H7HAZb0DDm4WJRsJpedqW2A
        sp0u2YjMEZKsYaCTbN0Txe7tVyAQ/8ZBEqWNifDkcvEF1mwgVD8=
X-Google-Smtp-Source: AGHT+IHW0GRTz6u3mf+Hm5hp78qtlWRXzaMCxkjDvyeZCpG591AKwLrQpGg9zZHZpc4Q/+KC1a6PjqZJnm2h01G6CbN3pzy/Px9v
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1801:b0:3b5:9545:cbbb with SMTP id
 bh1-20020a056808180100b003b59545cbbbmr849973oib.5.1699075023353; Fri, 03 Nov
 2023 22:17:03 -0700 (PDT)
Date:   Fri, 03 Nov 2023 22:17:03 -0700
In-Reply-To: <20231104044729.2716748-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036bf8706094cbb13@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in bt_link_release

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: 00000000bd9772ee object type: work_struct hint: hci_conn_timeout+0x0/0x1e8 net/bluetooth/hci_conn.c:928
WARNING: CPU: 0 PID: 6604 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 6604 at lib/debugobjects.c:517 __debug_check_no_obj_freed lib/debugobjects.c:1032 [inline]
WARNING: CPU: 0 PID: 6604 at lib/debugobjects.c:517 debug_check_no_obj_freed+0x41c/0x534 lib/debugobjects.c:1063
Modules linked in:
CPU: 0 PID: 6604 Comm: syz-executor.0 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : __debug_check_no_obj_freed lib/debugobjects.c:1032 [inline]
pc : debug_check_no_obj_freed+0x41c/0x534 lib/debugobjects.c:1063
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : __debug_check_no_obj_freed lib/debugobjects.c:1032 [inline]
lr : debug_check_no_obj_freed+0x41c/0x534 lib/debugobjects.c:1063
sp : ffff800097087960
x29: ffff8000970879b0 x28: ffff80008a8710a0 x27: dfff800000000000
x26: ffff0000dc530348 x25: 0000000000000000 x24: ffff800092a6dc78
x23: ffff80008a8710a0 x22: ffff0000dc530348 x21: ffff800092a6dc70
x20: ffff80008ad65078 x19: ffff0000dc530000 x18: ffff800097086e60
x17: 626f206565323737 x16: ffff80008a71b27c x15: 0000000000000001
x14: 1fffe0003682f032 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000000 x9 : 267892341ff5f000
x8 : 267892341ff5f000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800097087258 x4 : ffff80008e4210a0 x3 : ffff8000805a359c
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:514 [inline]
 __debug_check_no_obj_freed lib/debugobjects.c:1032 [inline]
 debug_check_no_obj_freed+0x41c/0x534 lib/debugobjects.c:1063
 slab_free_hook mm/slub.c:1775 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x250/0x480 mm/slub.c:3822
 kfree+0xb8/0x19c mm/slab_common.c:1075
 bt_link_release+0x20/0x30 net/bluetooth/hci_sysfs.c:16
 device_release+0x8c/0x1ac
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c4/0x3c4 lib/kobject.c:733
 put_device+0x28/0x40 drivers/base/core.c:3732
 hci_conn_put include/net/bluetooth/hci_core.h:1506 [inline]
 __sco_sock_close+0x3dc/0x7e4 net/bluetooth/sco.c:445
 sco_sock_close net/bluetooth/sco.c:470 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1247
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1419
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 16004
hardirqs last  enabled at (16003): [<ffff800080355dd4>] __up_console_sem kernel/printk/printk.c:347 [inline]
hardirqs last  enabled at (16003): [<ffff800080355dd4>] __console_unlock kernel/printk/printk.c:2718 [inline]
hardirqs last  enabled at (16003): [<ffff800080355dd4>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3037
hardirqs last disabled at (16004): [<ffff80008a716da0>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (15988): [<ffff800080021894>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (15988): [<ffff800080021894>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (15963): [<ffff80008002aadc>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
BUG: sleeping function called from invalid context at kernel/workqueue.c:3344
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6604, name: syz-executor.0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor.0/6604:
 #0: ffff0000dcb18810 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #0: ffff0000dcb18810 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release net/socket.c:658 [inline]
 #0: ffff0000dcb18810 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: sock_close+0x80/0x1e8 net/socket.c:1419
 #1: ffff0000c1fbe130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1720 [inline]
 #1: ffff0000c1fbe130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_sock_close net/bluetooth/sco.c:468 [inline]
 #1: ffff0000c1fbe130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_sock_release+0x60/0x2c0 net/bluetooth/sco.c:1247
 #2: ffff0000d9e40e20 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff0000d9e40e20 (&conn->lock#2){+.+.}-{2:2}, at: __sco_sock_close+0x378/0x7e4 net/bluetooth/sco.c:443
Preemption disabled at:
[<ffff800089996cf8>] spin_lock include/linux/spinlock.h:351 [inline]
[<ffff800089996cf8>] __sco_sock_close+0x378/0x7e4 net/bluetooth/sco.c:443
CPU: 0 PID: 6604 Comm: syz-executor.0 Tainted: G        W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 __might_resched+0x374/0x4d0 kernel/sched/core.c:10187
 __might_sleep+0x90/0xe4 kernel/sched/core.c:10116
 start_flush_work+0x44/0x7bc kernel/workqueue.c:3344
 __flush_work+0x11c/0x1c0 kernel/workqueue.c:3406
 __cancel_work_timer+0x3e4/0x540 kernel/workqueue.c:3494
 cancel_work_sync kernel/workqueue.c:3530 [inline]
 work_fixup_free+0x40/0x70 kernel/workqueue.c:554
 debug_object_fixup lib/debugobjects.c:530 [inline]
 __debug_check_no_obj_freed lib/debugobjects.c:1033 [inline]
 debug_check_no_obj_freed+0x464/0x534 lib/debugobjects.c:1063
 slab_free_hook mm/slub.c:1775 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x250/0x480 mm/slub.c:3822
 kfree+0xb8/0x19c mm/slab_common.c:1075
 bt_link_release+0x20/0x30 net/bluetooth/hci_sysfs.c:16
 device_release+0x8c/0x1ac
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c4/0x3c4 lib/kobject.c:733
 put_device+0x28/0x40 drivers/base/core.c:3732
 hci_conn_put include/net/bluetooth/hci_core.h:1506 [inline]
 __sco_sock_close+0x3dc/0x7e4 net/bluetooth/sco.c:445
 sco_sock_close net/bluetooth/sco.c:470 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1247
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1419
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1314c787680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17eaf6cf680000

