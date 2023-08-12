Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223C0779CA8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjHLCl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHLCl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:41:27 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40A2684
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:41:27 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bc5a54ea4eso39078275ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691808087; x=1692412887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7O0xFy5fyATEsiFCfto5ICycaVR4M2MgtXSOT7hf/o=;
        b=cWDZwUSzGFsQn/O/RLiiC7LGgdFZmTl+rMFxEsZ5yqOCJICkdBTsLRCdU2LAnVCgke
         St2o+JngPfZVsfi2YzslXO3Pts81WkZTfx6Dktg+4xvcXRDNYp6205gvEgqclqiDnxKZ
         LBomEBreAqTFs6+VdTBQFTKBnaXTucmQijyznvCul3X+cZifn7aJhLzTgo2Af1Gb73re
         fwSNxOn4/LLJbaY+L5k1m6MMekAj/z/efAH/uPsZ3JsLEwQxbRBvITpDHyh/NvkAuCnA
         20U6e9h2QOtXoq5zARQdp4lxTeT975uybh3rtWF74QCvLZk1Fl7W/NQgA64ZS+hSpvvq
         VaDQ==
X-Gm-Message-State: AOJu0YyLVsp1f4uGCDvFd4ezsQthNeeSGY1220Bzq6WfgA58pN8vOCr1
        omWrVkqK2GE7wVUJb/sJqkj5NwzjsUfO6Fdm6myBu9d+CNA4
X-Google-Smtp-Source: AGHT+IGOBPngN2gr7eS14OkfM0cS1sDOdXeGPWwbBcCD0ivm0p1YcKUrdb2Gld/cOJNJXZaACynJN+tywKXK0p+NDrdwy+0ERAjX
MIME-Version: 1.0
X-Received: by 2002:a17:903:1208:b0:1bc:1866:fd0f with SMTP id
 l8-20020a170903120800b001bc1866fd0fmr1336445plh.9.1691808087051; Fri, 11 Aug
 2023 19:41:27 -0700 (PDT)
Date:   Fri, 11 Aug 2023 19:41:26 -0700
In-Reply-To: <20230812022028.2480-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e9c340602b0c494@google.com>
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
kernel BUG in vlan_device_event

------------[ cut here ]------------
kernel BUG at net/core/dev.c:10817!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5776 Comm: syz-executor.0 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:unregister_netdevice_many_notify+0x308/0x19a0 net/core/dev.c:10817
Code: 4c 89 fa 48 c7 c6 a0 3e 81 8b 48 c7 c7 40 9a a6 8e e8 3c 49 22 fc e9 0f ff ff ff 4d 8d 67 60 49 8d 5f 68 eb 8b e8 38 72 5c f9 <0f> 0b e8 31 72 5c f9 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48
RSP: 0018:ffffc9000aaeee00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff888022c55940 RSI: ffffffff882995e8 RDI: 0000000000000001
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000002 R11: ffffffff8a40008b R12: ffff88801ed42060
R13: ffffc9000aaeef40 R14: ffffc9000aaeeee0 R15: ffff88801ed42000
FS:  00007f2a6ff536c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000002a534000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:10906 [inline]
 unregister_netdevice_queue+0x2e5/0x3c0 net/core/dev.c:10786
 unregister_netdevice include/linux/netdevice.h:3112 [inline]
 vlan_device_event+0x17e2/0x2070 net/8021q/vlan.c:489
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 unregister_netdevice_many_notify+0x82b/0x19a0 net/core/dev.c:10850
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
RIP: 0033:0x7f2a6f27cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2a6ff530c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2a6f39bf80 RCX: 00007f2a6f27cae9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f2a6f2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000004d R14: 00007f2a6f39bf80 R15: 00007ffdb5205158
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:unregister_netdevice_many_notify+0x308/0x19a0 net/core/dev.c:10817
Code: 4c 89 fa 48 c7 c6 a0 3e 81 8b 48 c7 c7 40 9a a6 8e e8 3c 49 22 fc e9 0f ff ff ff 4d 8d 67 60 49 8d 5f 68 eb 8b e8 38 72 5c f9 <0f> 0b e8 31 72 5c f9 48 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48
RSP: 0018:ffffc9000aaeee00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff888022c55940 RSI: ffffffff882995e8 RDI: 0000000000000001
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000002 R11: ffffffff8a40008b R12: ffff88801ed42060
R13: ffffc9000aaeef40 R14: ffffc9000aaeeee0 R15: ffff88801ed42000
FS:  00007f2a6ff536c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000002a534000 CR4: 0000000000350ef0


Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8e003a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f06495414e92701d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fb00ada80000

