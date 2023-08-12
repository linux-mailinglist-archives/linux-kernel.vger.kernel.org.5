Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC04779E23
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjHLIWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjHLIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:22:30 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211D26A0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 01:22:29 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-686d924d215so3328257b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 01:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691828548; x=1692433348;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUIebhqbageVkkdtJsCydeAuNfXegkifC3mNGUEkmAY=;
        b=B7uILGuLW9Dn1zm/zpdWtku34P6CrvNQEpxiEwPt3fLFBR17baca5wNHKvBDRuTP3x
         MJoWhjcQE01ALlHKJakT24p7/kYS4bzYhhjmhZt/BpDfM55c4np9NG2i5h+CaaLLhcOU
         EhivYZ5GtCZrZqQq38+qtSh1L8vpL/xIbb2yW4OS6PtoBOIbXsg4ppuebJma9FNwtcb1
         zK+9hXuQ/9Qb26Zn3nAuh0n6wWcMs1Il1ujdxAIwgWaZXSz98l3gVLwFmCiWTAr0WcEe
         IHeFOFoiwphXbi1nuuvfMuJ4zbriZeOGxsjO5QsCLTVH6K9pSqZO1EoPnSgovBw4TfIO
         doBg==
X-Gm-Message-State: AOJu0YyTcSpeig1WV0gSfL6bYyo6FAZI2EpztgkZsKGlvTe9+Pj0Z5p8
        DXF3Fl4YoA/Q6e+CjweX4RC+MlzlLJ9eh99tIOWUq2lZe+wn
X-Google-Smtp-Source: AGHT+IH33snyIia76gXsadIZzHU9BpNnGy0N+4krldbtD6sjDl2pTO0v3YkTYKjfCMiqJ87oHD5OTAsLNiK5gUws/xspKvmsog7a
MIME-Version: 1.0
X-Received: by 2002:a17:90a:b798:b0:262:de4e:3967 with SMTP id
 m24-20020a17090ab79800b00262de4e3967mr877658pjr.0.1691828548586; Sat, 12 Aug
 2023 01:22:28 -0700 (PDT)
Date:   Sat, 12 Aug 2023 01:22:28 -0700
In-Reply-To: <20230812072830.610-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8d4820602b587cc@google.com>
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
WARNING: CPU: 1 PID: 5782 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Modules linked in:
CPU: 1 PID: 5782 Comm: syz-executor.0 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
RSP: 0018:ffffc90006607158 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000020f52401 RCX: 0000000000000000
RDX: ffff88807e16bb80 RSI: ffffffff8829a7b8 RDI: 0000000000000001
RBP: ffff88802c5be000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000094000 R12: ffff88802a2c6b00
R13: 0000000000000000 R14: 0000000000000002 R15: ffff88802a2c6b00
FS:  00007f3f392a36c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000002a22d000 CR4: 0000000000350ee0
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
RIP: 0033:0x7f3f3847cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3f392a30c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3f3859bf80 RCX: 00007f3f3847cae9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f3f384c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000004d R14: 00007f3f3859bf80 R15: 00007ffe1ecc54b8
 </TASK>


Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1401a3aba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f06495414e92701d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161a6017a80000

