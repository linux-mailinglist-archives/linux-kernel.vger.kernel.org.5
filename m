Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF83780CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377231AbjHRNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377320AbjHRNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:42:34 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F28F358D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:42:29 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b10a6dbcaso1164011a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692366148; x=1692970948;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AszqvWeHhKnepSLsnBG/OSKIVL9J/R0fn/tTtojmtJU=;
        b=IYKQFDTZlYmTYUWYxWf6rBYq8cOuIx+ObM4xC/hdtcs9psRf2Lxv60PLDmHJDh3mdh
         ZOCnP6dxNU3NYCmGLGe9TrC4e0cR2FCe87hM8qXPVFgwIbusbGhPmkocTNZGGpWLkFyj
         UviKkmtZJUtD9wX9PyPP5g2sh2G1mCD+W7PSOMnft7HpnIE9ntkNytIIG3Ya3mDjbnrQ
         IljZY0YOIB7vj7ji5RT51lRzQjqS+H6BrkLV2w9VvjONgqMq1yipe4lgXW7po2oSXnNC
         NySyh3dsMeWpL7soNe/j1jDcVLfxmLqvrg0EFKOxMZv7Kr3JZspGVxJbuBmNiRnOE5vA
         LZjg==
X-Gm-Message-State: AOJu0YwR+NDC5R7zfJGmPPpPzL80rWOXmzeGuzG180OVjew4P3NkJH6F
        aP5ZSl5YoYR4vznUIOvLAZ+8JtFS3VMPdIlRUPveR0OaulaZ
X-Google-Smtp-Source: AGHT+IHmhaXgiCysxy9VIhhZOyg7wbkYjrbRc8r9tIwSBvFYqcNDLdXNFwJ/Lw6V1BpUpSCYh2g2H+ahXzYxusTFGJVNjg2RjmLy
MIME-Version: 1.0
X-Received: by 2002:a17:903:120a:b0:1bb:b30e:436d with SMTP id
 l10-20020a170903120a00b001bbb30e436dmr1110127plh.4.1692366148750; Fri, 18 Aug
 2023 06:42:28 -0700 (PDT)
Date:   Fri, 18 Aug 2023 06:42:28 -0700
In-Reply-To: <20230818105540.1995-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020544f060332b307@google.com>
Subject: Re: [syzbot] [net?] WARNING in dev_index_reserve
From:   syzbot <syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
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
WARNING: CPU: 0 PID: 5448 at net/core/dev.c:9593 dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
Modules linked in:
CPU: 0 PID: 5448 Comm: syz-executor.0 Not tainted 6.5.0-rc5-syzkaller-01605-g950fe35831af-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
Code: 00 31 d2 4d 8d 45 50 b9 ff ff ff 7f 48 8d 74 24 20 e8 f2 05 02 02 4c 89 e7 89 c3 e8 48 01 11 02 e9 48 ff ff ff e8 5e 1a 5e f9 <0f> 0b bb ea ff ff ff e9 52 ff ff ff e8 cd 4f 0d 02 66 66 2e 0f 1f
RSP: 0018:ffffc9000623efa8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff888029d59dc0 RSI: ffffffff88280632 RDI: 0000000000000005
RBP: 1ffff92000c47df5 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: ffffffff8a40008b R12: ffff88802cd68010
R13: ffff888024e91d40 R14: ffff88802cd68000 R15: ffff88802cd680f8
FS:  00007f5beb1a96c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000028632000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_netdevice+0x69a/0x1490 net/core/dev.c:10081
 veth_newlink+0x521/0xa50 drivers/net/veth.c:1938
 rtnl_newlink_create net/core/rtnetlink.c:3476 [inline]
 __rtnl_newlink+0x115e/0x18c0 net/core/rtnetlink.c:3693
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3706
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6432
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
RIP: 0033:0x7f5bea47cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5beb1a90c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5bea59bf80 RCX: 00007f5bea47cae9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f5bea4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5bea59bf80 R15: 00007ffd991b5b58
 </TASK>


Tested on:

commit:         950fe358 Merge branch 'ipv6-expired-routes'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16e89097a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe63ad15dded26b6
dashboard link: https://syzkaller.appspot.com/bug?extid=5ba06978f34abb058571
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17974440680000

