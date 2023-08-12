Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BEE779F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjHLLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjHLLRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:17:21 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B542E6D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:17:25 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-686ef3d5ab8so3411597b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839045; x=1692443845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbkmr8WK2UbRN9zEyMyVriCvchGoUJQUR5ZHVHP3RMg=;
        b=DROLuMIPZpIJpUrlHXLlvwc/ktPfqLxqV8DYeBYWJfohvLaRpYCyjOjrHKWS18wwi+
         ibHKK8Eh+b9ieX/i5XjIgb6vwKYOI/hdrR86Gare8VKPJGCH55DaDOtQXGwUguzazxXP
         N3GKQy8x1vOKu15I8IX3xDN8hvohQxvZoEkri1suiQ+KN8slrvBXz9AjVvllczMTtPhz
         z3iuIygL61g4LYeL75C77fiGr5gSRJHsW3v9Ws944TFwldnynbjvcyVYR4PH/pk3eLUW
         4WtbCUEmD/GiDWQ5mOMFySQQua+HpsRJ+W+eAfV3ZLJjK5dAruo0jBEoXRCK57DVbbzO
         3xpA==
X-Gm-Message-State: AOJu0Yz/QF+T7TfJTScVqIURvzRVD/3w11cVYtytP3bldJQSjNXQ4GDx
        S8xC8QAK4AHxL4Yt4yPsNkiR37fYUxK/fovsyaOTYJu6u4CD
X-Google-Smtp-Source: AGHT+IHEEimHGNDAfIWfocHKD9Mia4OYUpU6XSmGuv8OcxXVgYjZ8+oYopgXdMOfELwiKqU+c+Q0N+bg++D4Foc86Hok2okrWOI2
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:10cd:b0:668:5d38:25f3 with SMTP id
 d13-20020a056a0010cd00b006685d3825f3mr1849507pfu.2.1691839044801; Sat, 12 Aug
 2023 04:17:24 -0700 (PDT)
Date:   Sat, 12 Aug 2023 04:17:24 -0700
In-Reply-To: <20230812103448.728-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004859380602b7f94a@google.com>
Subject: Re: [syzbot] [net?] WARNING in rtnl_dellink (3)
From:   syzbot <syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com>
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
WARNING in rtnl_dellink

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5783 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Modules linked in:
CPU: 1 PID: 5783 Comm: syz-executor.0 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
RSP: 0018:ffffc9000594f158 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000002b3eb101 RCX: 0000000000000000
RDX: ffff8880244fbb80 RSI: ffffffff8829a7b8 RDI: 0000000000000001
RBP: ffff88801f5cc000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000094000 R12: ffff88802998fa00
R13: 0000000000000000 R14: 0000000000000002 R15: ffff88802998fa00
FS:  00007f7724c956c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000077189000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 rtnl_delete_link net/core/rtnetlink.c:3214 [inline]
 rtnl_dellink+0x3c1/0xae0 net/core/rtnetlink.c:3266
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7723e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7724c950c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7723f9bf80 RCX: 00007f7723e7cae9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f7723ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000004d R14: 00007f7723f9bf80 R15: 00007ffec7033f18
 </TASK>


Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11b78d73a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f06495414e92701d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17752973a80000

