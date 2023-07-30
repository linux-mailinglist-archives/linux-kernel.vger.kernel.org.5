Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8182A768534
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjG3MGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3MGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:06:48 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EAB198B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 05:06:47 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3a1bcdd0966so7345959b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 05:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690718806; x=1691323606;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTMAaKeEAOO9DuEhcqlyUmnqzeQDlUFNrBiZiQB1GNg=;
        b=E3Iw84odJnQYbf1ip6qqni9UxIXJ9CdHHOVJG/bsSDJnpl/jXiibIF1HyJ89sNQpcj
         MlaxG+nEZQwUBFnFaeoWng9tBCvQ9WAihsNnbdERLeG6PlCEJQyJGlB5C6kv+4XOg/dn
         6HjzwMmnWQtAYwVUaS5y5aiZNB3Ex8XsX18ZWTG+bpD+Mt2cMcbj8nQEHvATnCzal2J+
         xVwhDs2QQknQUhz+cQHCfcSIanP0ko6Lk6jxxIojPsa5MsVRLQg7Rmkns4f03eYbc34X
         3mSScDh2xSZeXqMqCKgqF6+IB7Bhw/ikV/R91B05G0kTS1SWR8fyDlOOdwAV0ohuBdbw
         CSqA==
X-Gm-Message-State: ABy/qLZ28ILlWyU95nWrjySzHsl/FFmlSNqhmznFOTuKrGaJdBw+kupI
        iEsROwRx81aeMyePko4iBs3Al/2BxCCKV3PYukozjqXe4+0l
X-Google-Smtp-Source: APBJJlEJ6qabICT29ZCo5LlKsNEs0OHhWuTkZiuEn1Z5xffTFZQRXQuFC21BgKRknyBzFvjGb+oJFmyiyjBTM6KV89aIW3vRQVl+
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1888:b0:3a4:1082:9e5 with SMTP id
 bi8-20020a056808188800b003a4108209e5mr13443587oib.2.1690718806773; Sun, 30
 Jul 2023 05:06:46 -0700 (PDT)
Date:   Sun, 30 Jul 2023 05:06:46 -0700
In-Reply-To: <0000000000008c5b8c05ff934a6c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4969c0601b3257d@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_rx_handlers
From:   syzbot <syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, glider@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    12214540ad87 Merge tag 'loongarch-fixes-6.5-1' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e82519a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6271275e6c8ac3e0
dashboard link: https://syzkaller.appspot.com/bug?extid=be9c824e6f269d608288
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a5f4eea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143b7009a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e436d64cced/disk-12214540.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/100ff4913bc4/vmlinux-12214540.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a1e5a392dce/bzImage-12214540.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_rx_h_action net/mac80211/rx.c:3735 [inline]
BUG: KMSAN: uninit-value in ieee80211_rx_handlers+0xc12c/0x10c00 net/mac80211/rx.c:4129
 ieee80211_rx_h_action net/mac80211/rx.c:3735 [inline]
 ieee80211_rx_handlers+0xc12c/0x10c00 net/mac80211/rx.c:4129
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4164 [inline]
 ieee80211_prepare_and_rx_handle+0x563e/0x9640 net/mac80211/rx.c:5006
 ieee80211_rx_for_interface+0x88d/0x990 net/mac80211/rx.c:5091
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5248 [inline]
 ieee80211_rx_list+0x5753/0x6580 net/mac80211/rx.c:5383
 ieee80211_rx_napi+0x87/0x350 net/mac80211/rx.c:5406
 ieee80211_rx include/net/mac80211.h:4949 [inline]
 ieee80211_tasklet_handler+0x1a0/0x310 net/mac80211/main.c:316
 tasklet_action_common+0x391/0xd30 kernel/softirq.c:780
 tasklet_action+0x26/0x30 kernel/softirq.c:805
 __do_softirq+0x1b7/0x78f kernel/softirq.c:553
 do_softirq+0x9a/0xf0 kernel/softirq.c:454
 __local_bh_enable_ip+0x99/0xa0 kernel/softirq.c:381
 local_bh_enable+0x28/0x30 include/linux/bottom_half.h:33
 __ieee80211_tx_skb_tid_band+0x276/0x560 net/mac80211/tx.c:6060
 ieee80211_tx_skb_tid+0x203/0x290 net/mac80211/tx.c:6087
 ieee80211_mgmt_tx+0x1cff/0x2070 net/mac80211/offchannel.c:965
 rdev_mgmt_tx net/wireless/rdev-ops.h:758 [inline]
 cfg80211_mlme_mgmt_tx+0x133b/0x1ba0 net/wireless/mlme.c:815
 nl80211_tx_mgmt+0x1297/0x1840 net/wireless/nl80211.c:12633
 genl_family_rcv_msg_doit net/netlink/genetlink.c:970 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
 genl_rcv_msg+0x1328/0x13c0 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2549
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1078
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg net/socket.c:748 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
 __sys_sendmsg net/socket.c:2577 [inline]
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2584
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was stored to memory at:
 skb_copy_from_linear_data_offset include/linux/skbuff.h:4068 [inline]
 skb_copy_bits+0x149/0xd30 net/core/skbuff.c:2744
 skb_copy+0x47f/0xa00 net/core/skbuff.c:1936
 mac80211_hwsim_tx_frame_no_nl+0x18db/0x2130 drivers/net/wireless/virtual/mac80211_hwsim.c:1836
 mac80211_hwsim_tx+0x1baa/0x2ce0 drivers/net/wireless/virtual/mac80211_hwsim.c:2054
 drv_tx net/mac80211/driver-ops.h:37 [inline]
 ieee80211_tx_frags+0x5e7/0xd90 net/mac80211/tx.c:1737
 __ieee80211_tx+0x46e/0x630 net/mac80211/tx.c:1791
 ieee80211_tx+0x52e/0x570 net/mac80211/tx.c:1971
 ieee80211_xmit+0x54a/0x5b0 net/mac80211/tx.c:2063
 __ieee80211_tx_skb_tid_band+0x271/0x560 net/mac80211/tx.c:6059
 ieee80211_tx_skb_tid+0x203/0x290 net/mac80211/tx.c:6087
 ieee80211_mgmt_tx+0x1cff/0x2070 net/mac80211/offchannel.c:965
 rdev_mgmt_tx net/wireless/rdev-ops.h:758 [inline]
 cfg80211_mlme_mgmt_tx+0x133b/0x1ba0 net/wireless/mlme.c:815
 nl80211_tx_mgmt+0x1297/0x1840 net/wireless/nl80211.c:12633
 genl_family_rcv_msg_doit net/netlink/genetlink.c:970 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
 genl_rcv_msg+0x1328/0x13c0 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2549
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1078
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg net/socket.c:748 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
 __sys_sendmsg net/socket.c:2577 [inline]
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2584
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3470 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3515
 kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:644
 __netdev_alloc_skb+0x11a/0x6f0 net/core/skbuff.c:708
 netdev_alloc_skb include/linux/skbuff.h:3212 [inline]
 dev_alloc_skb include/linux/skbuff.h:3225 [inline]
 ieee80211_mgmt_tx+0x1316/0x2070 net/mac80211/offchannel.c:907
 rdev_mgmt_tx net/wireless/rdev-ops.h:758 [inline]
 cfg80211_mlme_mgmt_tx+0x133b/0x1ba0 net/wireless/mlme.c:815
 nl80211_tx_mgmt+0x1297/0x1840 net/wireless/nl80211.c:12633
 genl_family_rcv_msg_doit net/netlink/genetlink.c:970 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1050 [inline]
 genl_rcv_msg+0x1328/0x13c0 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2549
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1078
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg net/socket.c:748 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
 __sys_sendmsg net/socket.c:2577 [inline]
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2584
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 1 PID: 4993 Comm: syz-executor798 Not tainted 6.5.0-rc3-syzkaller-00283-g12214540ad87 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
