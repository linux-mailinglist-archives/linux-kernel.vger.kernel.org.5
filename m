Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3C7C45F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjJKATz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJKATy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:19:54 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884299
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:19:51 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-57b708ce1c1so503237eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983591; x=1697588391;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNj+IC7+eBa0Nr500LxCGZt1jLSuBIDY8+33et+uWbQ=;
        b=sAljhTD2xjIustv9bUIEuNP1HaaGkOkTIDZm+aWr+vIj3UIC3zFgrLb/kWhrmfcjrJ
         dJz5c40fxbzoctZEHB9sXLoi15FJFVBGB6t3S+I15sb1h1UXMpdqqs5HSW0cZdRYIw3J
         Pl32kAC5BIfKqFefSLEy8XNAUZnE+TXNDBUgy2eiLNkUYRoYTVE6ehHbUUbDQGSund7b
         AWxBefSLMWJjnc3uJGAesd1TJuuKEQyFLUuFCgNqrshOvt4evsN29PzfrmuP10PXmYOM
         mWZEjyKbtAhi8Iq4YDVQCHAzoKw169pSmDgdE/v1v9pr/fRLE3RYNeJx4jBntdztIQws
         afpA==
X-Gm-Message-State: AOJu0YxspVMZMif+myG2QA5tN4LpkNtf4J/h4YNn4seZPEfglTwUj6aX
        bofqNq+M/wP+HIX2fIBnPJLRd/uSV42w9GN+uICGcFqM4giv
X-Google-Smtp-Source: AGHT+IHgTvs0kAh83CYpwK+Qt4QqGbbn+G3n2RUJfYngVP6YVN7vzhAZalWdsifqT0A4ttWTc3qatwv3dYUFc781bo029n1sWwF/
MIME-Version: 1.0
X-Received: by 2002:a05:6820:612:b0:56d:72ca:c4dc with SMTP id
 e18-20020a056820061200b0056d72cac4dcmr8103734oow.0.1696983591092; Tue, 10 Oct
 2023 17:19:51 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:19:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000230b04060765c8d0@google.com>
Subject: [syzbot] [wireless?] [net?] memory leak in ieee80211_add_key
From:   syzbot <syzbot+c7f9b4282ce793ea2456@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    af95dc6fdc25 Merge tag 'pci-v6.6-fixes-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111f9141680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92fc678f64486a09
dashboard link: https://syzkaller.appspot.com/bug?extid=c7f9b4282ce793ea2456
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12874a7e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17eba911680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8bc195198bd8/disk-af95dc6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/769216d795c4/vmlinux-af95dc6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ceb9e44a618/bzImage-af95dc6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7f9b4282ce793ea2456@syzkaller.appspotmail.com

executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881419b3000 (size 1024):
  comm "syz-executor294", pid 5023, jiffies 4294944772 (age 13.090s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 18 30 9b 41 81 88 ff ff  .........0.A....
  backtrace:
    [<ffffffff8157491b>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff8157491b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff848575dc>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff848575dc>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff848575dc>] ieee80211_key_alloc+0x5c/0x590 net/mac80211/key.c:603
    [<ffffffff8482b0d2>] ieee80211_add_key+0x162/0x540 net/mac80211/cfg.c:500
    [<ffffffff8477c375>] rdev_add_key net/wireless/rdev-ops.h:87 [inline]
    [<ffffffff8477c375>] nl80211_new_key+0x315/0x540 net/wireless/nl80211.c:4764
    [<ffffffff84033bb6>] genl_family_rcv_msg_doit+0x116/0x180 net/netlink/genetlink.c:971
    [<ffffffff840347dd>] genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
    [<ffffffff840347dd>] genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1066
    [<ffffffff84032191>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2545
    [<ffffffff840335f8>] genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
    [<ffffffff84031092>] netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
    [<ffffffff84031092>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1368
    [<ffffffff840315b5>] netlink_sendmsg+0x3a5/0x740 net/netlink/af_netlink.c:1910
    [<ffffffff83e96c12>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83e96c12>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83e97265>] ____sys_sendmsg+0x365/0x470 net/socket.c:2558
    [<ffffffff83e9b6d9>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2612
    [<ffffffff83e9b886>] __sys_sendmsg+0xa6/0x120 net/socket.c:2641
    [<ffffffff84b38548>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b38548>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881419b3400 (size 1024):
  comm "syz-executor294", pid 5025, jiffies 4294945317 (age 7.640s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 18 34 9b 41 81 88 ff ff  .........4.A....
  backtrace:
    [<ffffffff8157491b>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff8157491b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff848575dc>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff848575dc>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff848575dc>] ieee80211_key_alloc+0x5c/0x590 net/mac80211/key.c:603
    [<ffffffff8482b0d2>] ieee80211_add_key+0x162/0x540 net/mac80211/cfg.c:500
    [<ffffffff8477c375>] rdev_add_key net/wireless/rdev-ops.h:87 [inline]
    [<ffffffff8477c375>] nl80211_new_key+0x315/0x540 net/wireless/nl80211.c:4764
    [<ffffffff84033bb6>] genl_family_rcv_msg_doit+0x116/0x180 net/netlink/genetlink.c:971
    [<ffffffff840347dd>] genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
    [<ffffffff840347dd>] genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1066
    [<ffffffff84032191>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2545
    [<ffffffff840335f8>] genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
    [<ffffffff84031092>] netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
    [<ffffffff84031092>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1368
    [<ffffffff840315b5>] netlink_sendmsg+0x3a5/0x740 net/netlink/af_netlink.c:1910
    [<ffffffff83e96c12>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83e96c12>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83e97265>] ____sys_sendmsg+0x365/0x470 net/socket.c:2558
    [<ffffffff83e9b6d9>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2612
    [<ffffffff83e9b886>] __sys_sendmsg+0xa6/0x120 net/socket.c:2641
    [<ffffffff84b38548>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b38548>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



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
