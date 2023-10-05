Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45237BA2DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjJEPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJEPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:04 -0400
Received: from mail-oa1-x4e.google.com (mail-oa1-x4e.google.com [IPv6:2001:4860:4864:20::4e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E94903C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 01:49:46 -0700 (PDT)
Received: by mail-oa1-x4e.google.com with SMTP id 586e51a60fabf-1e12f68563cso907581fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 01:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495784; x=1697100584;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5CT72nr6fyLIM2HBIZewHuJMtsZSdhGCa8W/NlrzdE=;
        b=ZNhmEm0wrbem9KB+I+Yjokt54Nb5XBOSnuSGA57h/y+0PR5mfZ6sKjLCf18I56oirr
         G24w+BW04XXrEBlltSnu0xCf4QeSucm9Ry0WNbtAqKAAvsMyFVcv0RK9Y/pvjsKm4VpI
         BJwxImxxxNY3bprJXDmZdXwtDINtKzupyZLgVLQYqvPVxUf57wkPHYois8hmACvfPu8d
         AnSCAaseNSvKRAz29eK26puYOoly+KWGexp430e19jxlIaLksBx9O7LKsO4TbHVd1rrM
         5hk9y1dKNmbZRdXZVLmCW1EoU+ShfYq9V1KSEX1i2zgrHz6MO7lhE2YWv/Nkhmb+wyUd
         FplQ==
X-Gm-Message-State: AOJu0YziowyKdHV5gtb4PRDjdy6Rj51NuQ6RRiMFsJOdogU6ZVnuvO19
        8rabeMGA4znilv7luOwb9MyErRXG85k2iBmBHJWrFEC1mpOj
X-Google-Smtp-Source: AGHT+IHo2mnMCI10UV5TXKADf/v1RkgnT7tekZCDwNptOcZZfYxVDZ7TggD0WGNuei7CQm9SVjBSkU+Mt7tLm3HnsTxz0UA+JsN/
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1a89:b0:1d6:e8f0:4c47 with SMTP id
 ef9-20020a0568701a8900b001d6e8f04c47mr1782979oab.9.1696495782543; Thu, 05 Oct
 2023 01:49:42 -0700 (PDT)
Date:   Thu, 05 Oct 2023 01:49:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b47270606f43464@google.com>
Subject: [syzbot] [net?] [wireless?] memory leak in regulatory_init_db
From:   syzbot <syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3b517966c561 Merge tag 'dma-mapping-6.6-2023-09-30' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130dac2a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa96152f5a3192e3
dashboard link: https://syzkaller.appspot.com/bug?extid=39ec16ff6cc18b1d066d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1695bd3e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ae8c4e680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb67ab976a91/disk-3b517966.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21326eb3ef67/vmlinux-3b517966.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a95555fe120/bzImage-3b517966.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff888108f880c0 (size 64):
  comm "swapper/0", pid 1, jiffies 4294938895 (age 68.260s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff 00 00 00 00 00 00 00 00 30 30 00 00  ............00..
  backtrace:
    [<ffffffff81574195>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff875a3f05>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff875a3f05>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff875a3f05>] regulatory_hint_core net/wireless/reg.c:3218 [inline]
    [<ffffffff875a3f05>] regulatory_init_db+0xe5/0x1d0 net/wireless/reg.c:4290
    [<ffffffff81001cb6>] do_one_initcall+0x76/0x430 init/main.c:1232
    [<ffffffff874d86ea>] do_initcall_level init/main.c:1294 [inline]
    [<ffffffff874d86ea>] do_initcalls init/main.c:1310 [inline]
    [<ffffffff874d86ea>] do_basic_setup init/main.c:1329 [inline]
    [<ffffffff874d86ea>] kernel_init_freeable+0x25a/0x460 init/main.c:1547
    [<ffffffff84b3928b>] kernel_init+0x1b/0x290 init/main.c:1437
    [<ffffffff81149f25>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff88814490d800 (size 2048):
  comm "syz-executor220", pid 5026, jiffies 4294943369 (age 23.530s)
  hex dump (first 32 bytes):
    d8 4c a8 0d 81 88 ff ff 22 01 00 00 00 00 ad de  .L......".......
    00 00 00 00 ff ff ff ff ff ff 00 aa aa aa aa aa  ................
  backtrace:
    [<ffffffff81574195>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff84527e6f>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff84527e6f>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff84527e6f>] hci_conn_add+0x4f/0x5e0 net/bluetooth/hci_conn.c:957
    [<ffffffff84528668>] hci_connect_acl+0x198/0x1b0 net/bluetooth/hci_conn.c:1632
    [<ffffffff8452b4cb>] hci_connect_sco+0x4b/0x520 net/bluetooth/hci_conn.c:1685
    [<ffffffff8459d6b3>] sco_connect net/bluetooth/sco.c:266 [inline]
    [<ffffffff8459d6b3>] sco_sock_connect+0x1c3/0x520 net/bluetooth/sco.c:591
    [<ffffffff83e96b01>] __sys_connect_file+0x91/0xb0 net/socket.c:2033
    [<ffffffff83e96c06>] __sys_connect+0xe6/0x110 net/socket.c:2050
    [<ffffffff83e96c4c>] __do_sys_connect net/socket.c:2060 [inline]
    [<ffffffff83e96c4c>] __se_sys_connect net/socket.c:2057 [inline]
    [<ffffffff83e96c4c>] __x64_sys_connect+0x1c/0x20 net/socket.c:2057
    [<ffffffff84b33fc8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b33fc8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881091dc400 (size 512):
  comm "kworker/u5:2", pid 5022, jiffies 4294943869 (age 18.530s)
  hex dump (first 32 bytes):
    00 d8 90 44 81 88 ff ff c0 b9 e2 0c 81 88 ff ff  ...D............
    fd 03 00 00 00 00 00 00 00 06 0c 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81574195>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff845627dd>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff845627dd>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff845627dd>] l2cap_conn_add.part.0+0x3d/0x340 net/bluetooth/l2cap_core.c:7845
    [<ffffffff845703b4>] l2cap_conn_add net/bluetooth/l2cap_core.c:71 [inline]
    [<ffffffff845703b4>] l2cap_connect_cfm+0x264/0x740 net/bluetooth/l2cap_core.c:8242
    [<ffffffff8452ba43>] hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
    [<ffffffff8452ba43>] hci_conn_failed+0xa3/0x120 net/bluetooth/hci_conn.c:1251
    [<ffffffff84594cc6>] hci_abort_conn_sync+0x4d6/0x6d0 net/bluetooth/hci_sync.c:5435
    [<ffffffff8452560d>] abort_conn_sync+0x7d/0xa0 net/bluetooth/hci_conn.c:2894
    [<ffffffff8458b3ad>] hci_cmd_sync_work+0xcd/0x150 net/bluetooth/hci_sync.c:306
    [<ffffffff812c8d9d>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c99c7>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c99c7>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6d9b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149f25>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
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
