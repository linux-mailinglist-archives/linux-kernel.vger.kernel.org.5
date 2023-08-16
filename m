Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295277E95F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbjHPTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbjHPTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:08:03 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57F02701
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:07:58 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-6887c563b4eso1595136b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692212878; x=1692817678;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHdogJFRX/HOEOhf9V11ILn0TfaNRuouoGFxj473o8g=;
        b=kixFifRaYCn39Bm87ejo2GVAnPPRxAiEZ6YUAJIfaZEgefO74Vhx6r43Kkh5TIQwgX
         shp3AqfFiFJDMLrsjOVF6yJ97yb3miZqdPvx3QAr4yw7v/d7AVBrm5TQfrrkmKryzyw4
         npGhzc7xBbMcto7b4r/hV8hcCJCA+c8ivpegy8YQZx61YtddlpjrGETjIdu4LznRkquk
         S00RIlYzVSwkQRsYRivN8vST3fppiCqN/rayiiL5fgqxtqyXZurjaSFC4ltyYRAOtDiq
         DdeZUf+iuD8n1/BNqAnnen4+nb9RH/YdMmUz04IgptYJ//iobupiW5DGADNXiC9qdPya
         Lp1Q==
X-Gm-Message-State: AOJu0Yz4md8JRqQA6ODk0IcpP/Z2L0lnZcf80fLncGRnylob8eN1VNqU
        06WZwdOvCnQWpcATs2oWStxfR6ATHP85rNo2BoDiM2YCrCBg
X-Google-Smtp-Source: AGHT+IHm/XS7DTLDnrzjhY3z868q0DeHF6IzSL0Ky5sCqQBvZCrA2lQnzYp6z3kkoc2L91nN0HxlkHp6ueSr6nMPU2+WOfunmXtp
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:22cb:b0:687:3110:7faa with SMTP id
 f11-20020a056a0022cb00b0068731107faamr1326078pfj.5.1692212878133; Wed, 16 Aug
 2023 12:07:58 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:07:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c506006030f0332@google.com>
Subject: [syzbot] [net?] WARNING in dev_index_reserve
From:   syzbot <syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
        john.fastabend@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    950fe35831af Merge branch 'ipv6-expired-routes'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13158a4ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5ba06978f34abb058571
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be0117a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14950727a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3d4f3ce986f/disk-950fe358.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5afd9c7f284/vmlinux-950fe358.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a203c65f0ae/bzImage-950fe358.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com

netlink: 24 bytes leftover after parsing attributes in process `syz-executor252'.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5027 at net/core/dev.c:9593 dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
Modules linked in:
CPU: 0 PID: 5027 Comm: syz-executor252 Not tainted 6.5.0-rc5-syzkaller-01605-g950fe35831af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
Code: 00 31 d2 4d 8d 45 50 b9 ff ff ff 7f 48 8d 74 24 20 e8 f2 05 02 02 4c 89 e7 89 c3 e8 48 01 11 02 e9 48 ff ff ff e8 5e 1a 5e f9 <0f> 0b bb ea ff ff ff e9 52 ff ff ff e8 cd 4f 0d 02 66 66 2e 0f 1f
RSP: 0018:ffffc90003a2efa8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff88807d940000 RSI: ffffffff88280632 RDI: 0000000000000005
RBP: 1ffff92000745df5 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: ffffffff8a40008b R12: ffff88823bd20010
R13: ffffffff924d1180 R14: ffff88823bd20000 R15: ffff88823bd200f8
FS:  00005555573a0380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055feb9a33020 CR3: 000000001eaea000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_netdevice+0x69a/0x1490 net/core/dev.c:10081
 veth_newlink+0x521/0xa50 drivers/net/veth.c:1938
 rtnl_newlink_create net/core/rtnetlink.c:3471 [inline]
 __rtnl_newlink+0x115e/0x18c0 net/core/rtnetlink.c:3688
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3701
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6427
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2514
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2568
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2597
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff9080bb329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3ff5b078 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffc3ff5b248 RCX: 00007ff9080bb329
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007ff90812e610 R08: 0000000000000000 R09: 00007ffc3ff5b248
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc3ff5b238 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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
