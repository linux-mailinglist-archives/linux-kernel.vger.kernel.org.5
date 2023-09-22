Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D87AA6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjIVB4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjIVB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:56:00 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0057118F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:55:52 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3ab3059eb0cso2104641b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695347752; x=1695952552;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMGcT7azSmaIpI7Mr5U/Wl+GeL1wdTGUzossfsv3VgA=;
        b=n7riwTNS7Y/FeiOhxpVcXAsOZiSJ71eV22NWXaQwHnNqsMjTWje9JENN5gw83jH3qw
         B6Agms54qUCHef3oZ4awXcSTydQWi15OgW6TCWlT+ztJscJDu4taO20LH/fGUdVBeZw0
         Mb1PGFGfO4T+K7fP/9Ga2Ljk/T9pfDjHwJm393zb30B0HIAZxdT+tgQ9eDFvSB8SFrY2
         SfyApEM3hnTSjVsmYSdai44PmhGuepHmrS6HOjn3wxJneKUQC3BoOqsAHVho6MglQKYZ
         zT+mvFSLFUBX/U9h2PpPHKqVdKCpcDomzfKuxVhCkk2yU7WqSK3rnL6PpKrTHmvOa+V+
         LFLQ==
X-Gm-Message-State: AOJu0YyNsFisWd8R2H/Qe4PMhJ2JYfGUOVpPUtVBI9WSCvOf7W75PfNc
        sU/IK0TbxKyurXX/K4c33i6J10arUZRF1DKSHDVNh+pdpSIa
X-Google-Smtp-Source: AGHT+IG7C+7JIRSlG/ocN4yRtFdfHebIRpyMNTtFV9qU88kUAUQkPjJe3iVwBDRaTkLiGd18g1q711Iton0ri/WRyLjPVIwKI5xa
MIME-Version: 1.0
X-Received: by 2002:a05:6808:308e:b0:3ae:16a8:f441 with SMTP id
 bl14-20020a056808308e00b003ae16a8f441mr489962oib.11.1695347752268; Thu, 21
 Sep 2023 18:55:52 -0700 (PDT)
Date:   Thu, 21 Sep 2023 18:55:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b78c00605e8e8aa@google.com>
Subject: [syzbot] [wpan?] [input?] [usb?] memory leak in hwsim_add_one (2)
From:   syzbot <syzbot+d2aa0f55c4ae66a9b75d@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e789286468a9 Merge tag 'x86-urgent-2023-09-17' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16db487fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=943a94479fa8e863
dashboard link: https://syzkaller.appspot.com/bug?extid=d2aa0f55c4ae66a9b75d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cc8372680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60bec5b60566/disk-e7892864.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/509a449f2ff0/vmlinux-e7892864.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36581da19789/bzImage-e7892864.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2aa0f55c4ae66a9b75d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881042a8940 (size 64):
  comm "swapper/0", pid 1, jiffies 4294937901 (age 1085.750s)
  hex dump (first 32 bytes):
    00 0d 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573dc5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff831b5a6a>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff831b5a6a>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff831b5a6a>] hwsim_add_one+0x14a/0x650 drivers/net/ieee802154/mac802154_hwsim.c:949
    [<ffffffff831b5f93>] hwsim_probe+0x23/0xe0 drivers/net/ieee802154/mac802154_hwsim.c:1022
    [<ffffffff82c14f93>] platform_probe+0x83/0x110 drivers/base/platform.c:1404
    [<ffffffff82c10fc6>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c10fc6>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c113a3>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c1149a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c117f7>] __driver_attach drivers/base/dd.c:1216 [inline]
    [<ffffffff82c117f7>] __driver_attach+0x107/0x1f0 drivers/base/dd.c:1156
    [<ffffffff82c0e2f3>] bus_for_each_dev+0xb3/0x110 drivers/base/bus.c:368
    [<ffffffff82c0fdf6>] bus_add_driver+0x126/0x2a0 drivers/base/bus.c:673
    [<ffffffff82c12ee5>] driver_register+0x85/0x180 drivers/base/driver.c:246
    [<ffffffff8756e3a6>] hwsim_init_module+0xc6/0x110 drivers/net/ieee802154/mac802154_hwsim.c:1073
    [<ffffffff81001cb6>] do_one_initcall+0x76/0x430 init/main.c:1232
    [<ffffffff874d76ea>] do_initcall_level init/main.c:1294 [inline]
    [<ffffffff874d76ea>] do_initcalls init/main.c:1310 [inline]
    [<ffffffff874d76ea>] do_basic_setup init/main.c:1329 [inline]
    [<ffffffff874d76ea>] kernel_init_freeable+0x25a/0x460 init/main.c:1547
    [<ffffffff84b3628b>] kernel_init+0x1b/0x290 init/main.c:1437
    [<ffffffff81149e35>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147

BUG: memory leak
unreferenced object 0xffff8881042a8780 (size 64):
  comm "swapper/0", pid 1, jiffies 4294937902 (age 1085.740s)
  hex dump (first 32 bytes):
    00 0d 00 00 00 00 00 00 ff ff ff ff 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573dc5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff831b5a6a>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff831b5a6a>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff831b5a6a>] hwsim_add_one+0x14a/0x650 drivers/net/ieee802154/mac802154_hwsim.c:949
    [<ffffffff831b5fb6>] hwsim_probe+0x46/0xe0 drivers/net/ieee802154/mac802154_hwsim.c:1022
    [<ffffffff82c14f93>] platform_probe+0x83/0x110 drivers/base/platform.c:1404
    [<ffffffff82c10fc6>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c10fc6>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c113a3>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c1149a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c117f7>] __driver_attach drivers/base/dd.c:1216 [inline]
    [<ffffffff82c117f7>] __driver_attach+0x107/0x1f0 drivers/base/dd.c:1156
    [<ffffffff82c0e2f3>] bus_for_each_dev+0xb3/0x110 drivers/base/bus.c:368
    [<ffffffff82c0fdf6>] bus_add_driver+0x126/0x2a0 drivers/base/bus.c:673
    [<ffffffff82c12ee5>] driver_register+0x85/0x180 drivers/base/driver.c:246
    [<ffffffff8756e3a6>] hwsim_init_module+0xc6/0x110 drivers/net/ieee802154/mac802154_hwsim.c:1073
    [<ffffffff81001cb6>] do_one_initcall+0x76/0x430 init/main.c:1232
    [<ffffffff874d76ea>] do_initcall_level init/main.c:1294 [inline]
    [<ffffffff874d76ea>] do_initcalls init/main.c:1310 [inline]
    [<ffffffff874d76ea>] do_basic_setup init/main.c:1329 [inline]
    [<ffffffff874d76ea>] kernel_init_freeable+0x25a/0x460 init/main.c:1547
    [<ffffffff84b3628b>] kernel_init+0x1b/0x290 init/main.c:1437
    [<ffffffff81149e35>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147

BUG: memory leak
unreferenced object 0xffff8881007cc000 (size 768):
  comm "udevd", pid 4480, jiffies 4295045154 (age 13.270s)
  hex dump (first 32 bytes):
    01 00 00 00 03 00 00 00 08 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e8ff95>] alloc_inode_sb include/linux/fs.h:2909 [inline]
    [<ffffffff83e8ff95>] sock_alloc_inode+0x25/0x90 net/socket.c:308
    [<ffffffff816c39d3>] alloc_inode+0x23/0x100 fs/inode.c:259
    [<ffffffff816c4bf6>] new_inode_pseudo+0x16/0x50 fs/inode.c:1004
    [<ffffffff83e8f2ab>] sock_alloc+0x1b/0x90 net/socket.c:634
    [<ffffffff83e8f8cd>] __sock_create+0xbd/0x2e0 net/socket.c:1516
    [<ffffffff83e92d58>] sock_create net/socket.c:1603 [inline]
    [<ffffffff83e92d58>] __sys_socket_create net/socket.c:1640 [inline]
    [<ffffffff83e92d58>] __sys_socket+0xb8/0x1a0 net/socket.c:1691
    [<ffffffff83e92e5b>] __do_sys_socket net/socket.c:1705 [inline]
    [<ffffffff83e92e5b>] __se_sys_socket net/socket.c:1703 [inline]
    [<ffffffff83e92e5b>] __x64_sys_socket+0x1b/0x20 net/socket.c:1703
    [<ffffffff84b30fc8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30fc8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810c7019a0 (size 32):
  comm "udevd", pid 4480, jiffies 4295045154 (age 13.270s)
  hex dump (first 32 bytes):
    b8 c1 7c 00 81 88 ff ff 70 3d 34 82 ff ff ff ff  ..|.....p=4.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff823457a2>] kmem_cache_zalloc include/linux/slab.h:710 [inline]
    [<ffffffff823457a2>] lsm_inode_alloc security/security.c:633 [inline]
    [<ffffffff823457a2>] security_inode_alloc+0x32/0xd0 security/security.c:1494
    [<ffffffff816c01ad>] inode_init_always+0x1ed/0x230 fs/inode.c:230
    [<ffffffff816c39f0>] alloc_inode+0x40/0x100 fs/inode.c:266
    [<ffffffff816c4bf6>] new_inode_pseudo+0x16/0x50 fs/inode.c:1004
    [<ffffffff83e8f2ab>] sock_alloc+0x1b/0x90 net/socket.c:634
    [<ffffffff83e8f8cd>] __sock_create+0xbd/0x2e0 net/socket.c:1516
    [<ffffffff83e92d58>] sock_create net/socket.c:1603 [inline]
    [<ffffffff83e92d58>] __sys_socket_create net/socket.c:1640 [inline]
    [<ffffffff83e92d58>] __sys_socket+0xb8/0x1a0 net/socket.c:1691
    [<ffffffff83e92e5b>] __do_sys_socket net/socket.c:1705 [inline]
    [<ffffffff83e92e5b>] __se_sys_socket net/socket.c:1703 [inline]
    [<ffffffff83e92e5b>] __x64_sys_socket+0x1b/0x20 net/socket.c:1703
    [<ffffffff84b30fc8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30fc8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

[ 


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
