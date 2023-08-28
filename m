Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0654078A4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjH1CgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjH1Cfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:35:53 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8321AF9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:35:51 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-56c306471ccso1446683a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693190151; x=1693794951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FifDf28yvuZJQzcHb+JuLWl+M8PNz/FpcXOqYTZ6xOA=;
        b=ZPPX5w8gVLpLDBBvjuRipNXq56ZuXrVNxe8t86gn7AkPWZo95648EUHjdVrVNM5iCf
         GXwPNZqgeywEZ7/ZOX6cbsg3J4nRo8mot6sRki9PVyc4H27+JfF4oRX5scmW4iF16O2L
         Z6xxmhAS5wML0JkJRsLq0t8Uu1c+UqAQSjEUTNt68KSiYSOWqHO+h9Q8pWFZr/agsOm/
         9ZmkJ2fjcBYvm7t+K5qFZxiCfUJdxENobiRnWVMGofKrfw2lhsZChwV/7C4ED1HwYlz/
         oKePbzLwRgqUeDCeDlnPAbbMCmnCKvW3Hm5f1N1peqDx25/lDTTZNTnu4AfWnxtdjPbZ
         WgBg==
X-Gm-Message-State: AOJu0YylSn8hN8Sin3qhAEpDZjctPoLEC3PqBQ74RzZv9Yw5pduHkmVd
        KyRDYsL2MSkTjuGS/Nv7uiwlb8Awz3KpQ73vqAaSNElhij4k
X-Google-Smtp-Source: AGHT+IHnbP7U5FzNlZ6kHAL4cMXGliHk4ZBtFiDNRNVosdYIhIsFvl1za+QBfa/p11T90NI7yW3PXMyM8aXKQwlcepCd1ZgOzbWY
MIME-Version: 1.0
X-Received: by 2002:a63:6d0d:0:b0:565:d4f9:dc39 with SMTP id
 i13-20020a636d0d000000b00565d4f9dc39mr4218705pgc.9.1693190150989; Sun, 27 Aug
 2023 19:35:50 -0700 (PDT)
Date:   Sun, 27 Aug 2023 19:35:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007caf3b0603f28d71@google.com>
Subject: [syzbot] [batman?] memory leak in skb_clone (2)
From:   syzbot <syzbot+92f9b5fba2df252a3569@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a5e505a99ca7 Merge tag 'platform-drivers-x86-v6.5-5' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15eea3e3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3c65e06397a9d58
dashboard link: https://syzkaller.appspot.com/bug?extid=92f9b5fba2df252a3569
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13597f90680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c534ce48946f/disk-a5e505a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/724bbdaa3992/vmlinux-a5e505a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47fba0663891/bzImage-a5e505a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92f9b5fba2df252a3569@syzkaller.appspotmail.com

2023/08/24 02:03:48 executed programs: 322
2023/08/24 02:03:54 executed programs: 337
BUG: memory leak
unreferenced object 0xffff888120ea2600 (size 240):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 22 e3 20 81 88 ff ff 00 00 00 00 00 00 00 00  .". ............
    00 80 ed 1c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5e05a>] skb_clone+0xaa/0x190 net/core/skbuff.c:1860
    [<ffffffff8499f31f>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:387 [inline]
    [<ffffffff8499f31f>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f31f>] batadv_iv_send_outstanding_bat_ogm_packet+0x2ef/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888120f36c00 (size 1024):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554a79>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554a79>] __kmalloc_node_track_caller+0x49/0x140 mm/slab_common.c:1005
    [<ffffffff83e54735>] kmalloc_reserve+0x95/0x180 net/core/skbuff.c:575
    [<ffffffff83e5c6c8>] pskb_expand_head+0xd8/0x5f0 net/core/skbuff.c:2042
    [<ffffffff849ccbef>] __skb_cow include/linux/skbuff.h:3571 [inline]
    [<ffffffff849ccbef>] skb_cow_head include/linux/skbuff.h:3605 [inline]
    [<ffffffff849ccbef>] batadv_skb_head_push+0x8f/0x110 net/batman-adv/soft-interface.c:72
    [<ffffffff849ca643>] batadv_send_skb_packet+0x83/0x1c0 net/batman-adv/send.c:86
    [<ffffffff8499f35a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
    [<ffffffff8499f35a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f35a>] batadv_iv_send_outstanding_bat_ogm_packet+0x32a/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff888120ea2000 (size 240):
  comm "kworker/u4:5", pid 5210, jiffies 4295058872 (age 8.300s)
  hex dump (first 32 bytes):
    00 28 ea 20 81 88 ff ff 00 00 00 00 00 00 00 00  .(. ............
    00 80 ec 1c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5e05a>] skb_clone+0xaa/0x190 net/core/skbuff.c:1860
    [<ffffffff83f88552>] netem_enqueue+0xc62/0x1430 net/sched/sch_netem.c:479
    [<ffffffff83e80975>] dev_qdisc_enqueue+0x25/0xf0 net/core/dev.c:3732
    [<ffffffff83e8b217>] __dev_xmit_skb net/core/dev.c:3821 [inline]
    [<ffffffff83e8b217>] __dev_queue_xmit+0xdc7/0x17d0 net/core/dev.c:4169
    [<ffffffff849ca710>] dev_queue_xmit include/linux/netdevice.h:3088 [inline]
    [<ffffffff849ca710>] batadv_send_skb_packet+0x150/0x1c0 net/batman-adv/send.c:108
    [<ffffffff8499f35a>] batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
    [<ffffffff8499f35a>] batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
    [<ffffffff8499f35a>] batadv_iv_send_outstanding_bat_ogm_packet+0x32a/0x370 net/batman-adv/bat_iv_ogm.c:1700
    [<ffffffff812b8d31>] process_one_work+0x2f1/0x640 kernel/workqueue.c:2600
    [<ffffffff812b966c>] worker_thread+0x5c/0x5c0 kernel/workqueue.c:2751
    [<ffffffff812c313b>] kthread+0x12b/0x170 kernel/kthread.c:389
    [<ffffffff81140a5c>] ret_from_fork+0x2c/0x40 arch/x86/kernel/process.c:145
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304



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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
