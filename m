Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75577F72F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351263AbjHQNBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351297AbjHQNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:00:42 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055592D7E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:00:41 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-565aee6e925so4779086a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692277240; x=1692882040;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWo7MxOGhc7hQCJfRcwJ00l1VtdSduaAYcuqgD3WIkY=;
        b=iPhpxHXR198Y1bEnIZ8hA4u5Q8t3+ye3YfCC1NiCJ4GNW/FHHHJFYdl3ruMnwNlCe4
         Yv49a4RtlKIPKH8My3joD4xlH02y60B9udwZxd/4TIqIgwa42lVHG2FwDzE0TwSUg1LY
         1WNMFhS9YldXNSGBsKoJC3uqXEHsrt5q51gEqyV6dft3WA93zc6YrM5JjiJ6n9iVSxwc
         VIAHdVJmtTAmgQM4J4/ssEqJ9h2jgN3yx+Ws07D4kjtUPSpTxdvyz0Bj4kSkLNGOwP1O
         Yci50OqS+EV+G9zzT5dHd08QMEQHZ9NrZPbVUTfycIeMNRPiHd8ALotFkKdv7Jy0Bq4V
         Ckvw==
X-Gm-Message-State: AOJu0YyBKIXDGqW5kgfztmo5B2nxq/8SMmhljihdDqlc8ULAqaVZ2HGC
        skMGoBoGhJLEL1LawjnXHO5pnQod3JBteISq/Z5q8g98IwCz
X-Google-Smtp-Source: AGHT+IGH26m7p9PL4zG8SvFHSYQWPVfwm+ectpa+36z9YoyhxaSkwl/QTuUbBI7Q4UoCXhmwfifnFkDFuMLzUk+vN4HukHVILChD
MIME-Version: 1.0
X-Received: by 2002:a63:3e4c:0:b0:565:5e77:d112 with SMTP id
 l73-20020a633e4c000000b005655e77d112mr978338pga.3.1692277240495; Thu, 17 Aug
 2023 06:00:40 -0700 (PDT)
Date:   Thu, 17 Aug 2023 06:00:40 -0700
In-Reply-To: <20230817111049.1936-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c808a206031dfffc@google.com>
Subject: Re: [syzbot] [net?] WARNING in dev_index_reserve
From:   syzbot <syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in dev_index_reserve

netlink: 24 bytes leftover after parsing attributes in process `syz-executor.0'.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5446 at net/core/dev.c:9593 dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
Modules linked in:
CPU: 1 PID: 5446 Comm: syz-executor.0 Not tainted 6.5.0-rc5-syzkaller-01605-g950fe35831af-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
Code: 00 31 d2 4d 8d 45 50 b9 ff ff ff 7f 48 8d 74 24 20 e8 f2 05 02 02 4c 89 e7 89 c3 e8 48 01 11 02 e9 48 ff ff ff e8 5e 1a 5e f9 <0f> 0b bb ea ff ff ff e9 52 ff ff ff e8 cd 4f 0d 02 66 66 2e 0f 1f
RSP: 0018:ffffc90005a4efa8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff888028b83b80 RSI: ffffffff88280632 RDI: 0000000000000005
RBP: 1ffff92000b49df5 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: ffffffff8a40008b R12: ffff88802c1f6010
R13: ffff88807bd89d40 R14: ffff88802c1f6000 R15: ffff88802c1f60f8
FS:  00007ffad37b86c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000002c10f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_netdevice+0x69a/0x1490 net/core/dev.c:10081
 veth_newlink+0x521/0xa50 drivers/net/veth.c:1938
 rtnl_newlink_create net/core/rtnetlink.c:3475 [inline]
 __rtnl_newlink+0x115e/0x18c0 net/core/rtnetlink.c:3692
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3705
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6431
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
RIP: 0033:0x7ffad2a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffad37b80c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffad2b9bf80 RCX: 00007ffad2a7cae9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007ffad2ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ffad2b9bf80 R15: 00007ffc858ed2f8
 </TASK>


Tested on:

commit:         950fe358 Merge branch 'ipv6-expired-routes'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1341e265a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5ba06978f34abb058571
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1224279ba80000

