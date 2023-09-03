Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E77790B0F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 08:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjICGZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 02:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbjICGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 02:25:06 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09521B8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 23:25:00 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5646e695ec1so513816a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 23:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693722300; x=1694327100;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtQlgYaN5h5scBxcyLgeIOU/wc5H0N3hvOs2LDfWnTY=;
        b=SJZ7M/OME+pWdPJVy4MnP6NdnQwA1kTFukWWrXF3n6rAl18V6mdQ0a+EfpnozXKRti
         XyL7ii/ATvMvzDQCOM9MwjWpnNcVBF8Fuy4hKE+BsT9TaDkNhMInLPSbESDzSeY3igj2
         kFKqpV5y1Z6E9aBTE081vKz0P7CmJodwuyY3xqYV3tERkw9EW/wxnp6gBT9IUmwn/WFS
         yr0MyhPVkWuAp1ha9r8JLbTCB32grpSBCn4rKtwTXNdtROEvbw0tuhJU/WelXMtrYPgT
         vEy1NGONiFzKLUVWAeBN2Hrmo9fffUfg0QinO0huajW7KxblM82Y5yL3sB97i64wWurj
         n6zQ==
X-Gm-Message-State: AOJu0Yzn5LtSJxuAW8xIX9WE51/qOSvQ5HsJhiT9lQt41knyrpxTlIUg
        xNsWj4QR/1R5xeQ9DhO94rchUWHOAnZVnagm0FMdFh8Z6qC6
X-Google-Smtp-Source: AGHT+IGSWE6qXNaCNZ6MUpjPpwLY/kJAvx9/WYdoYmOcc9Oigv0OQd089tilLLnSJ1f2tfQDiip2EDn4GQNvn2dhnxzJqS4dNffT
MIME-Version: 1.0
X-Received: by 2002:a17:902:d48c:b0:1b7:d4d2:c385 with SMTP id
 c12-20020a170902d48c00b001b7d4d2c385mr2555815plg.1.1693722300369; Sat, 02 Sep
 2023 23:25:00 -0700 (PDT)
Date:   Sat, 02 Sep 2023 23:25:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fd01206046e7410@google.com>
Subject: [syzbot] [bluetooth?] memory leak in hci_conn_add (2)
From:   syzbot <syzbot+b6678ec6b1772e54ee6e@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    0468be89b3fa Merge tag 'iommu-updates-v6.6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e2d447a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3544ee7492950dd3
dashboard link: https://syzkaller.appspot.com/bug?extid=b6678ec6b1772e54ee6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a86513a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a3f977a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/961bf23596d0/disk-0468be89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d9431ec0107c/vmlinux-0468be89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb5d1f6d7aad/bzImage-0468be89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6678ec6b1772e54ee6e@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810dcfd000 (size 2048):
  comm "syz-executor249", pid 5023, jiffies 4294943992 (age 23.130s)
  hex dump (first 32 bytes):
    d8 4c ce 0d 81 88 ff ff 22 01 00 00 00 00 ad de  .L......".......
    00 00 00 00 00 00 00 00 00 00 00 aa aa aa aa aa  ................
  backtrace:
    [<ffffffff81573855>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff84519e7f>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff84519e7f>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff84519e7f>] hci_conn_add+0x4f/0x5e0 net/bluetooth/hci_conn.c:957
    [<ffffffff8451a678>] hci_connect_acl+0x198/0x1b0 net/bluetooth/hci_conn.c:1632
    [<ffffffff8451d4db>] hci_connect_sco+0x4b/0x520 net/bluetooth/hci_conn.c:1685
    [<ffffffff8458f6b3>] sco_connect net/bluetooth/sco.c:266 [inline]
    [<ffffffff8458f6b3>] sco_sock_connect+0x1c3/0x520 net/bluetooth/sco.c:591
    [<ffffffff83e89281>] __sys_connect_file+0x91/0xb0 net/socket.c:2032
    [<ffffffff83e89386>] __sys_connect+0xe6/0x110 net/socket.c:2049
    [<ffffffff83e893cc>] __do_sys_connect net/socket.c:2059 [inline]
    [<ffffffff83e893cc>] __se_sys_connect net/socket.c:2056 [inline]
    [<ffffffff83e893cc>] __x64_sys_connect+0x1c/0x20 net/socket.c:2056
    [<ffffffff84b23fa8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b23fa8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810b503600 (size 512):
  comm "kworker/u5:1", pid 4429, jiffies 4294944492 (age 18.130s)
  hex dump (first 32 bytes):
    00 d0 cf 0d 81 88 ff ff 80 7b 7f 0b 81 88 ff ff  .........{......
    fd 03 00 00 00 00 00 00 00 06 0c 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573855>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff845547dd>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff845547dd>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff845547dd>] l2cap_conn_add.part.0+0x3d/0x340 net/bluetooth/l2cap_core.c:7845
    [<ffffffff845623b4>] l2cap_conn_add net/bluetooth/l2cap_core.c:71 [inline]
    [<ffffffff845623b4>] l2cap_connect_cfm+0x264/0x740 net/bluetooth/l2cap_core.c:8242
    [<ffffffff8451da53>] hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
    [<ffffffff8451da53>] hci_conn_failed+0xa3/0x120 net/bluetooth/hci_conn.c:1251
    [<ffffffff84586cc6>] hci_abort_conn_sync+0x4d6/0x6d0 net/bluetooth/hci_sync.c:5435
    [<ffffffff8451761d>] abort_conn_sync+0x7d/0xa0 net/bluetooth/hci_conn.c:2894
    [<ffffffff8457d3ad>] hci_cmd_sync_work+0xcd/0x150 net/bluetooth/hci_sync.c:306
    [<ffffffff812c8e0d>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c99b7>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c99b7>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6e8b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149875>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
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
