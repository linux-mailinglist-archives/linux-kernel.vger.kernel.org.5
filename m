Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8F761E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjGYQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjGYQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:22:55 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068CEC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:22:52 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6b9c744df27so8937512a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302172; x=1690906972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RUjeoNU1GLoQKADl/ixw/TxZx18p8HttwKhB2hjIa0=;
        b=ST6IpgM7/GfyK0s/btcZyUyQAMQxqLbqV2Oneokusg3hqCVfI9xzNVUh1L5VVAzVDx
         RE+ooMd7XUCi1TP5cNlzTzcjQHHocixss4x2e8q5xrYgRXT2aUoZDpJmE6NHIQYwWjsG
         s9a7H4Z8L2oNUp24EqpsgGvuvDlAqzZMoUIyEgcy9NzVp4h1Kzsemq7In+aK3NHm1dx2
         uK+WIVuxmtCzK1scC7LkDfxiA8mBhjGXxrHsaZdcTJ8m/2ChVDrPllX2ch0hHVwed7yY
         0M0U1b2oObp0/8nIiZ/1ho5EWHQbHBWQecNLZIIk5yq0cBtpbtCgqPEklgpYxHJDaQWL
         QJrw==
X-Gm-Message-State: ABy/qLZkmOctnoP2XW5l3Y8Rlp3MAdpaFqu2twpu3GIuMux9tqbDbPCk
        x3NggjgIZxlO/VTrgEDFI1my7KJK+E4jU+9lELm4fwqoGOHf
X-Google-Smtp-Source: APBJJlFbnOcag6iqozo/+3f7QhqH65++VpMbTZmqwxmmBPhLzlYAYBE4kKMY5PXMCc9Dl8z7QqfTtO37VZSOlRKe2SHEI6OYcIP1
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1287:b0:6b7:1e75:18e with SMTP id
 z7-20020a056830128700b006b71e75018emr13263178otp.2.1690302172226; Tue, 25 Jul
 2023 09:22:52 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:22:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089e8b806015224ff@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in addrconf_rs_timer (3)
From:   syzbot <syzbot+521990714fbdf5ffce04@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13fb9fd1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
dashboard link: https://syzkaller.appspot.com/bug?extid=521990714fbdf5ffce04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1049c776a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/disk-e40939bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vmlinux-e40939bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b52/Image-e40939bb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+521990714fbdf5ffce04@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:16445]
Modules linked in:
irq event stamp: 5993
hardirqs last  enabled at (5992): [<ffff80008a44626c>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (5992): [<ffff80008a44626c>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (5993): [<ffff80008a443ea4>] __el1_irq arch/arm64/kernel/entry-common.c:470 [inline]
hardirqs last disabled at (5993): [<ffff80008a443ea4>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (14): [<ffff800080034380>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (677): [<ffff80008002b660>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
CPU: 0 PID: 16445 Comm: syz-executor.1 Not tainted 6.4.0-rc7-syzkaller-ge40939bbfc68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : find_entry_to_transmit+0x4e0/0x6d0
lr : find_entry_to_transmit+0x4c4/0x6d0
sp : ffff800080007000
x29: ffff8000800070c0 x28: ffff800080007230 x27: ffff0000e7bb1940
x26: ffff0000e7bb1800 x25: 0000000000000000 x24: 0000000000000080
x23: 04c978811b43be81 x22: 04c978811b43bec0 x21: 04c978811b43bf01
x20: dfff800000000000 x19: 7fffffffffffffff x18: ffff800096460080
x17: 0000000000000000 x16: ffff80008050b28c x15: 0000000000000100
x14: 1ffff00011bde0ac x13: ffffffff80000040 x12: 0000000080000040
x11: 0000000000000301 x10: 0000000000000100 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff800080007210
x5 : ffff800080007230 x4 : 04c978809b43bf5d x3 : ffff80008898bde8
x2 : 0000000000000000 x1 : 7fffffffffffffff x0 : 04c978811b43bf01
Call trace:
 find_entry_to_transmit+0x4e0/0x6d0 net/sched/sch_taprio.c:382
 get_packet_txtime net/sched/sch_taprio.c:505 [inline]
 taprio_enqueue_one+0xdb0/0x146c net/sched/sch_taprio.c:574
 taprio_enqueue+0x328/0x544 net/sched/sch_taprio.c:655
 dev_qdisc_enqueue+0x60/0x35c net/core/dev.c:3773
 __dev_xmit_skb net/core/dev.c:3862 [inline]
 __dev_queue_xmit+0xb24/0x3318 net/core/dev.c:4210
 dev_queue_xmit include/linux/netdevice.h:3088 [inline]
 neigh_resolve_output+0x518/0x618 net/core/neighbour.c:1552
 neigh_output include/net/neighbour.h:544 [inline]
 ip6_finish_output2+0xd60/0x1a1c net/ipv6/ip6_output.c:134
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x538/0x8c8 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:292 [inline]
 ip6_output+0x270/0x594 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:458 [inline]
 NF_HOOK include/linux/netfilter.h:303 [inline]
 ndisc_send_skb+0xc30/0x1790 net/ipv6/ndisc.c:508
 ndisc_send_rs+0x47c/0x5d4 net/ipv6/ndisc.c:718
 addrconf_rs_timer+0x300/0x58c net/ipv6/addrconf.c:3936
 call_timer_fn+0x19c/0x8cc kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x55c/0x734 kernel/time/timer.c:2022
 run_timer_softirq+0x7c/0x114 kernel/time/timer.c:2035
 __do_softirq+0x2d0/0xd54 kernel/softirq.c:571
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:882
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:85
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0x28c/0x534 kernel/softirq.c:650
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:474 [inline]
 el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:488
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:493
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:587
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:33 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:55 [inline]
 lookup_bh_lru fs/buffer.c:1340 [inline]
 __find_get_block+0x1a4/0xe8c fs/buffer.c:1352
 __getblk_gfp+0x48/0xa50 fs/buffer.c:1378
 sb_getblk include/linux/buffer_head.h:365 [inline]
 __ext4_get_inode_loc+0x3b4/0xb90 fs/ext4/inode.c:4376
 ext4_get_inode_loc fs/ext4/inode.c:4504 [inline]
 ext4_reserve_inode_write+0x130/0x2e0 fs/ext4/inode.c:5734
 __ext4_mark_inode_dirty+0x1c4/0x848 fs/ext4/inode.c:5911
 ext4_ext_tree_init+0xc0/0x184 fs/ext4/extents.c:879
 __ext4_new_inode+0x2ce0/0x39fc fs/ext4/ialloc.c:1335
 ext4_symlink+0x328/0x9a0 fs/ext4/namei.c:3393
 vfs_symlink+0x138/0x260 fs/namei.c:4475
 do_symlinkat+0x364/0x6b0 fs/namei.c:4501
 __do_sys_symlinkat fs/namei.c:4517 [inline]
 __se_sys_symlinkat fs/namei.c:4514 [inline]
 __arm64_sys_symlinkat+0xa4/0xbc fs/namei.c:4514
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
