Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E627E0E0D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 07:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKDGAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 02:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDGAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 02:00:09 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27AD45
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 23:00:06 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2e7b41beaso4298853b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 23:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699077605; x=1699682405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGpgxvdGgjV3fD3btY0cWPiTe8dVTEcTtf7SgXkQz9Q=;
        b=ly+M8qzm4nll6qIY4wl2f9GWIbJGfeyvsnDjxOICw2zXRyB9m++UDNCiBRLMJdpBv8
         C8UwTCjZbNGHF2QhiLH4iMxcvF6eQFzH2FCrZhJ2OkYx44Dx2lE7rTTFUVp1s5cqkEQ0
         1SErDrvSgGrDqXoCvy39DZpFtifYUPnRFrstC64NRTYByNEUMj/PLbVt0fkGGaaKyFAV
         v1ZDqJftCSTL08mpnViOJ5zLxXLOT8wVuzwjEW1T+0SHcyx+Pz9prBZadu3uaF7RiCgL
         WgC39j9Y0MoYUHNqlE1O3AAMXMTpzJI67j5x+zg1jKSaAXCulx0NWfFn4Ek4FNHrzT96
         FY6w==
X-Gm-Message-State: AOJu0YxP5adMh2Q7Z+8MO5VsUryMIpcso0lsAFLZ/cBjAhyzxsv1JPRl
        yez5G7fXHJq3hepNq0dZYNHXPULdA/gSQ7esOHglVshe8nwVxTE=
X-Google-Smtp-Source: AGHT+IFZbLuOi6aC4+6242nVmkjrAohuv5psZPA0sCjZsUMWwxge76J/MNFFL4OvsVjppbJs+/zAkOM5lJxdrN098BpD5+Dx+IhQ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1998:b0:3b2:e7b3:5fc5 with SMTP id
 bj24-20020a056808199800b003b2e7b35fc5mr2034942oib.3.1699077605547; Fri, 03
 Nov 2023 23:00:05 -0700 (PDT)
Date:   Fri, 03 Nov 2023 23:00:05 -0700
In-Reply-To: <20231104054009.3030149-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fe42606094d5524@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in bt_link_release

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: 000000004ad6f07b object type: work_struct hint: hci_conn_timeout+0x0/0x1e8 net/bluetooth/hci_conn.c:928
WARNING: CPU: 1 PID: 6612 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 1 PID: 6612 at lib/debugobjects.c:517 __debug_check_no_obj_freed lib/debugobjects.c:1032 [inline]
WARNING: CPU: 1 PID: 6612 at lib/debugobjects.c:517 debug_check_no_obj_freed+0x41c/0x534 lib/debugobjects.c:1063
Modules linked in:
CPU: 1 PID: 6612 Comm: syz-executor.0 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : __debug_check_no_obj_freed lib/debugobjects.c:1032 [inline]
pc : debug_check_no_obj_freed+0x41c/0x534 lib/debugobjects.c:1063
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : __debug_check_no_obj_freed lib/debugobjects.c:1032 [inline]
lr : debug_check_no_obj_freed+0x41c/0x534 lib/debugobjects.c:1063
sp : ffff800097057960
x29: ffff8000970579b0 x28: ffff80008a8710a0 x27: dfff800000000000
x26: ffff0000c6644348 x25: 0000000000000000 x24: ffff800092a17c98
x23: ffff80008a8710a0 x22: ffff0000c6644348 x21: ffff800092a17c90
x20: ffff80008ad65078 x19: ffff0000c6644000 x18: ffff800097056e60
x17: 626f206237306636 x16: ffff80008a71b27c x15: 0000000000000001
x14: 1fffe00036833432 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000000 x9 : e8b2fd3c26f6bd00
x8 : e8b2fd3c26f6bd00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800097057258 x4 : ffff80008e4210a0 x3 : ffff8000805a359c
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
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
irq event stamp: 15314
hardirqs last  enabled at (15313): [<ffff800080355dd4>] __up_console_sem kernel/printk/printk.c:347 [inline]
hardirqs last  enabled at (15313): [<ffff800080355dd4>] __console_unlock kernel/printk/printk.c:2718 [inline]
hardirqs last  enabled at (15313): [<ffff800080355dd4>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3037
hardirqs last disabled at (15314): [<ffff80008a716da0>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (15298): [<ffff800080021894>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (15298): [<ffff800080021894>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (15287): [<ffff80008002aadc>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
BUG: sleeping function called from invalid context at kernel/workqueue.c:3344
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6612, name: syz-executor.0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor.0/6612:
 #0: ffff0000df81c410 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #0: ffff0000df81c410 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release net/socket.c:658 [inline]
 #0: ffff0000df81c410 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: sock_close+0x80/0x1e8 net/socket.c:1419
 #1: ffff0000c8dca130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1720 [inline]
 #1: ffff0000c8dca130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_sock_close net/bluetooth/sco.c:468 [inline]
 #1: ffff0000c8dca130 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_sock_release+0x60/0x2c0 net/bluetooth/sco.c:1247
 #2: ffff0000c6413620 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffff0000c6413620 (&conn->lock#2){+.+.}-{2:2}, at: __sco_sock_close+0x378/0x7e4 net/bluetooth/sco.c:443
Preemption disabled at:
[<ffff800089996cf8>] spin_lock include/linux/spinlock.h:351 [inline]
[<ffff800089996cf8>] __sco_sock_close+0x378/0x7e4 net/bluetooth/sco.c:443
CPU: 1 PID: 6612 Comm: syz-executor.0 Tainted: G        W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17259c7b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bfc4df680000

