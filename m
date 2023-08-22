Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343ED7837B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHVB6S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 21:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjHVB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:58:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57611B0;
        Mon, 21 Aug 2023 18:57:55 -0700 (PDT)
Received: from kwepemm000018.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVC8V3d08zLpCW;
        Tue, 22 Aug 2023 09:54:50 +0800 (CST)
Received: from dggpeml500007.china.huawei.com (7.185.36.75) by
 kwepemm000018.china.huawei.com (7.193.23.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:57:53 +0800
Received: from dggpeml500007.china.huawei.com ([7.185.36.75]) by
 dggpeml500007.china.huawei.com ([7.185.36.75]) with mapi id 15.01.2507.031;
 Tue, 22 Aug 2023 09:57:53 +0800
From:   mengkanglai <mengkanglai2@huawei.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "Hideaki YOSHIFUJI" <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: [BUGREPORT] slab-out-of-bounds in do_csum
Thread-Topic: [BUGREPORT] slab-out-of-bounds in do_csum
Thread-Index: AdnUm/VAZf2B9C9RR7G7ByDo5PkE8A==
Date:   Tue, 22 Aug 2023 01:57:53 +0000
Message-ID: <bfb7e812fb9043e78e88bbe65334b9ef@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.115.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:
  I am doing some fuzz test for kernel, the following bug was triggered.
  My kernel version is 5.10.0.Have you encountered similar problems?
  If there is a fix, please let me know. 
  Thank you very much.

----------------------------------------------
BUG: KASAN: slab-out-of-bounds in do_csum+0x3e9/0x400 usr/src/kernels/linux-5.10.0-136.12.0.86/arch/x86/lib/csum-partial_64.c:103
Read of size 4 at addr ffff88801f183aa0 by task syz-executor.2/19784

CPU: 0 PID: 19784 Comm: syz-executor.2 Tainted: G        W  OE     5.10.0-136.12.0.86.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack usr/src/kernels/linux-5.10.0-136.12.0.86/lib/dump_stack.c:77 [inline]
 dump_stack+0xbe/0xfd usr/src/kernels/linux-5.10.0-136.12.0.86/lib/dump_stack.c:118
 print_address_description.constprop.0+0x19/0x170 usr/src/kernels/linux-5.10.0-136.12.0.86/mm/kasan/report.c:382
 __kasan_report.cold+0x6c/0x84 usr/src/kernels/linux-5.10.0-136.12.0.86/mm/kasan/report.c:542
 kasan_report+0x3a/0x50 usr/src/kernels/linux-5.10.0-136.12.0.86/mm/kasan/report.c:559
 do_csum+0x3e9/0x400 usr/src/kernels/linux-5.10.0-136.12.0.86/arch/x86/lib/csum-partial_64.c:103
 csum_partial+0x21/0x30 usr/src/kernels/linux-5.10.0-136.12.0.86/arch/x86/lib/csum-partial_64.c:136
 gso_make_checksum usr/src/kernels/linux-5.10.0-136.12.0.86/./include/linux/skbuff.h:4527 [inline]
 __skb_udp_tunnel_segment+0xcd9/0x1710 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv4/udp_offload.c:135
 skb_udp_tunnel_segment+0x192/0x240 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv4/udp_offload.c:177
 udp6_ufo_fragment+0x9a5/0xd20 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/udp_offload.c:37
 ipv6_gso_segment+0x485/0xfc0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip6_offload.c:115
 skb_mac_gso_segment+0x22e/0x400 usr/src/kernels/linux-5.10.0-136.12.0.86/net/core/dev.c:3348
 __skb_gso_segment+0x331/0x6f0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/core/dev.c:3445
 skb_gso_segment usr/src/kernels/linux-5.10.0-136.12.0.86/./include/linux/netdevice.h:4799 [inline]
 ip6_finish_output_gso_slowpath_drop.constprop.0+0x3f/0x170 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip6_output.c:169
 __ip6_finish_output.part.0+0x6a5/0x7c0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip6_output.c:203
 __ip6_finish_output usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip6_output.c:225 [inline]
 ip6_finish_output+0x25c/0x310 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip6_output.c:220
 NF_HOOK_COND usr/src/kernels/linux-5.10.0-136.12.0.86/./include/linux/netfilter.h:293 [inline]
 ip6_output+0x1f3/0x3f0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip6_output.c:243
 dst_output usr/src/kernels/linux-5.10.0-136.12.0.86/./include/net/dst.h:453 [inline]
 ip6_local_out+0x94/0xc0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/output_core.c:161
 ip6tunnel_xmit usr/src/kernels/linux-5.10.0-136.12.0.86/./include/net/ip6_tunnel.h:160 [inline]
 udp_tunnel6_xmit_skb+0x695/0xa90 usr/src/kernels/linux-5.10.0-136.12.0.86/net/ipv6/ip6_udp_tunnel.c:109
 geneve6_xmit_skb+0xaf8/0x1b50 usr/src/kernels/linux-5.10.0-136.12.0.86/drivers/net/geneve.c:1051
 geneve_xmit+0x2f5/0x4f0 usr/src/kernels/linux-5.10.0-136.12.0.86/drivers/net/geneve.c:1080
 __netdev_start_xmit usr/src/kernels/linux-5.10.0-136.12.0.86/./include/linux/netdevice.h:4849 [inline]
 netdev_start_xmit usr/src/kernels/linux-5.10.0-136.12.0.86/./include/linux/netdevice.h:4863 [inline]
 xmit_one.constprop.0+0x142/0x490 usr/src/kernels/linux-5.10.0-136.12.0.86/net/core/dev.c:3615
 dev_hard_start_xmit+0x8e/0x1b0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/core/dev.c:3631
 __dev_queue_xmit+0x1935/0x2100 usr/src/kernels/linux-5.10.0-136.12.0.86/net/core/dev.c:4198
 packet_snd+0x1992/0x2a40 usr/src/kernels/linux-5.10.0-136.12.0.86/net/packet/af_packet.c:3031
 packet_sendmsg+0x9f/0xd0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/packet/af_packet.c:3063
 sock_sendmsg_nosec usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:658 [inline]
 sock_sendmsg usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:678 [inline]
 sock_sendmsg+0x165/0x1a0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:673
 __sys_sendto+0x21b/0x320 usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:1993
 __do_sys_sendto usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:2005 [inline]
 __se_sys_sendto usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:2001 [inline]
 __x64_sys_sendto+0xe2/0x1c0 usr/src/kernels/linux-5.10.0-136.12.0.86/net/socket.c:2001
 do_syscall_64+0x33/0x40 usr/src/kernels/linux-5.10.0-136.12.0.86/arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7f6bf67ac74d
Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6bf4d19bf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f6bf68e7f80 RCX: 00007f6bf67ac74d
RDX: 0000000000002378 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f6bf681ad95 R08: 0000000000000000 R09: 00000000000002ff
R10: 0000000004000002 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe99543bff R14: 00007ffe99543da0 R15: 00007f6bf4d19d80
