Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76459792A00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354925AbjIEQaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354813AbjIEOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86A189;
        Tue,  5 Sep 2023 07:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CBF460919;
        Tue,  5 Sep 2023 14:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B90C433C7;
        Tue,  5 Sep 2023 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693924637;
        bh=5z+qovhzpo6/C/xT/TuONLH39TFjv9fG82EZ1l76Paw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQt1ky3JSDCsgNX3pZLjcXfsN02LVSOkka1oK+oGCg2XVUmnR3JY8xR8h0KiJAOCe
         DhPDnhbzgdVIVp+IR4o3IZsMwJbo6rbU0GHaZxax5KZvm9IzAYRsRpUXT7Heev3OLj
         QRQKxyqqpHd20NqzFKTDw6BETXq+LAhixH0pd2xsLXcrdKyqVWhAcdJaKxanY7VqnT
         CW/F02OO/+Lbv8C13c9V5dsF9SCRHPe/CX48AuDH16pn3yuJHUyOU1BCL4as/6f7Wq
         G1wF8ArbCyCJrY0CSoqdayKUlMsgMyCo668BLLRL6W2Y6lX3ArbjNRg4adUNvkDJHC
         6lJae/EOyVMXA==
Date:   Tue, 5 Sep 2023 15:37:12 +0100
From:   Will Deacon <will@kernel.org>
To:     syzbot <syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com>
Cc:     catalin.marinas@arm.com, fw@strlen.de, kadlec@netfilter.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        robin.murphy@arm.com
Subject: Re: [syzbot] [arm?] [netfilter?] KASAN: slab-out-of-bounds Read in
 do_csum
Message-ID: <20230905143711.GB3322@willie-the-truck>
References: <000000000000e0e94c0603f8d213@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e0e94c0603f8d213@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_FAKE_RF_SHORT,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Robin as he's had fun with the checksum code in the past]

On Mon, Aug 28, 2023 at 03:04:44AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    908f31f2a05b Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=155e0463280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c1058fe68f4b7b2c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a9f9820bd8d302e22f7
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc548d280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135bba3b280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/87d095820229/disk-908f31f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a1bf67af9675/vmlinux-908f31f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7784a88b37e8/Image-908f31f2.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com
> 
> netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in do_csum+0x44/0x254 arch/arm64/lib/csum.c:39
> Read of size 4294966928 at addr ffff0000d7ac0170 by task syz-executor412/5975

Judging by the UBSAN errors:

| shift exponent 3008 is too large for 64-bit type 'u64' (aka 'unsigned long long')

We're probably being passed a negative 'len' argument. It looks like the
generic version in lib/checksum.c rejects that early, so maybe we should
do the same in the arch code?

Will

> CPU: 0 PID: 5975 Comm: syz-executor412 Not tainted 6.4.0-rc4-syzkaller-g908f31f2a05b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> Call trace:
>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
>  show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:351 [inline]
>  print_report+0x174/0x514 mm/kasan/report.c:462
>  kasan_report+0xd4/0x130 mm/kasan/report.c:572
>  kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:187
>  __kasan_check_read+0x20/0x30 mm/kasan/shadow.c:31
>  do_csum+0x44/0x254 arch/arm64/lib/csum.c:39
>  csum_partial+0x30/0x58 lib/checksum.c:128
>  gso_make_checksum include/linux/skbuff.h:4928 [inline]
>  __udp_gso_segment+0xaf4/0x1bc4 net/ipv4/udp_offload.c:332
>  udp6_ufo_fragment+0x540/0xca0 net/ipv6/udp_offload.c:47
>  ipv6_gso_segment+0x5cc/0x1760 net/ipv6/ip6_offload.c:119
>  skb_mac_gso_segment+0x2b4/0x5b0 net/core/gro.c:141
>  __skb_gso_segment+0x250/0x3d0 net/core/dev.c:3401
>  skb_gso_segment include/linux/netdevice.h:4859 [inline]
>  validate_xmit_skb+0x364/0xdbc net/core/dev.c:3659
>  validate_xmit_skb_list+0x94/0x130 net/core/dev.c:3709
>  sch_direct_xmit+0xe8/0x548 net/sched/sch_generic.c:327
>  __dev_xmit_skb net/core/dev.c:3805 [inline]
>  __dev_queue_xmit+0x147c/0x3318 net/core/dev.c:4210
>  dev_queue_xmit include/linux/netdevice.h:3085 [inline]
>  packet_xmit+0x6c/0x318 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x376c/0x4c98 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg net/socket.c:747 [inline]
>  __sys_sendto+0x3b4/0x538 net/socket.c:2144
>  __do_sys_sendto net/socket.c:2156 [inline]
>  __se_sys_sendto net/socket.c:2152 [inline]
>  __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2152
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
>  el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> 
> Allocated by task 5975:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
>  kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:510
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
>  kasan_kmalloc include/linux/kasan.h:196 [inline]
>  __do_kmalloc_node mm/slab_common.c:966 [inline]
>  __kmalloc_node_track_caller+0xd0/0x1c0 mm/slab_common.c:986
>  kmalloc_reserve+0x120/0x240 net/core/skbuff.c:585
>  __alloc_skb+0x1c8/0x3d8 net/core/skbuff.c:654
>  skb_segment+0xa80/0x32f0 net/core/skbuff.c:4516
>  __udp_gso_segment+0x5d0/0x1bc4 net/ipv4/udp_offload.c:290
>  udp6_ufo_fragment+0x540/0xca0 net/ipv6/udp_offload.c:47
>  ipv6_gso_segment+0x5cc/0x1760 net/ipv6/ip6_offload.c:119
>  skb_mac_gso_segment+0x2b4/0x5b0 net/core/gro.c:141
>  __skb_gso_segment+0x250/0x3d0 net/core/dev.c:3401
>  skb_gso_segment include/linux/netdevice.h:4859 [inline]
>  validate_xmit_skb+0x364/0xdbc net/core/dev.c:3659
>  validate_xmit_skb_list+0x94/0x130 net/core/dev.c:3709
>  sch_direct_xmit+0xe8/0x548 net/sched/sch_generic.c:327
>  __dev_xmit_skb net/core/dev.c:3805 [inline]
>  __dev_queue_xmit+0x147c/0x3318 net/core/dev.c:4210
>  dev_queue_xmit include/linux/netdevice.h:3085 [inline]
>  packet_xmit+0x6c/0x318 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x376c/0x4c98 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg net/socket.c:747 [inline]
>  __sys_sendto+0x3b4/0x538 net/socket.c:2144
>  __do_sys_sendto net/socket.c:2156 [inline]
>  __se_sys_sendto net/socket.c:2152 [inline]
>  __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2152
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
>  el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> 
> The buggy address belongs to the object at ffff0000d7ac0000
>  which belongs to the cache kmalloc-8k of size 8192
> The buggy address is located 368 bytes inside of
>  allocated 8192-byte region [ffff0000d7ac0000, ffff0000d7ac2000)
> 
> The buggy address belongs to the physical page:
> page:000000002bfc4c52 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x117ac0
> head:000000002bfc4c52 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x5ffc00000010200(slab|head|node=0|zone=2|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 05ffc00000010200 ffff0000c0002c00 fffffc00035e7e00 0000000000000002
> raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff0000d7ac1f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff0000d7ac1f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff0000d7ac2000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff0000d7ac2080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff0000d7ac2100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> ================================================================================
> UBSAN: shift-out-of-bounds in arch/arm64/lib/csum.c:116:15
> shift exponent 3008 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> CPU: 0 PID: 5975 Comm: syz-executor412 Tainted: G    B              6.4.0-rc4-syzkaller-g908f31f2a05b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> Call trace:
>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
>  show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
>  dump_stack+0x1c/0x28 lib/dump_stack.c:113
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:387
>  do_csum+0x238/0x254 arch/arm64/lib/csum.c:116
>  csum_partial+0x30/0x58 lib/checksum.c:128
>  gso_make_checksum include/linux/skbuff.h:4928 [inline]
>  __udp_gso_segment+0xaf4/0x1bc4 net/ipv4/udp_offload.c:332
>  udp6_ufo_fragment+0x540/0xca0 net/ipv6/udp_offload.c:47
>  ipv6_gso_segment+0x5cc/0x1760 net/ipv6/ip6_offload.c:119
>  skb_mac_gso_segment+0x2b4/0x5b0 net/core/gro.c:141
>  __skb_gso_segment+0x250/0x3d0 net/core/dev.c:3401
>  skb_gso_segment include/linux/netdevice.h:4859 [inline]
>  validate_xmit_skb+0x364/0xdbc net/core/dev.c:3659
>  validate_xmit_skb_list+0x94/0x130 net/core/dev.c:3709
>  sch_direct_xmit+0xe8/0x548 net/sched/sch_generic.c:327
>  __dev_xmit_skb net/core/dev.c:3805 [inline]
>  __dev_queue_xmit+0x147c/0x3318 net/core/dev.c:4210
>  dev_queue_xmit include/linux/netdevice.h:3085 [inline]
>  packet_xmit+0x6c/0x318 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x376c/0x4c98 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg net/socket.c:747 [inline]
>  __sys_sendto+0x3b4/0x538 net/socket.c:2144
>  __do_sys_sendto net/socket.c:2156 [inline]
>  __se_sys_sendto net/socket.c:2152 [inline]
>  __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2152
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
>  el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> ================================================================================
> ================================================================================
> UBSAN: shift-out-of-bounds in arch/arm64/lib/csum.c:116:25
> shift exponent 3008 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> CPU: 0 PID: 5975 Comm: syz-executor412 Tainted: G    B              6.4.0-rc4-syzkaller-g908f31f2a05b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> Call trace:
>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
>  show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
>  dump_stack+0x1c/0x28 lib/dump_stack.c:113
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:387
>  do_csum+0x250/0x254 arch/arm64/lib/csum.c:116
>  csum_partial+0x30/0x58 lib/checksum.c:128
>  gso_make_checksum include/linux/skbuff.h:4928 [inline]
>  __udp_gso_segment+0xaf4/0x1bc4 net/ipv4/udp_offload.c:332
>  udp6_ufo_fragment+0x540/0xca0 net/ipv6/udp_offload.c:47
>  ipv6_gso_segment+0x5cc/0x1760 net/ipv6/ip6_offload.c:119
>  skb_mac_gso_segment+0x2b4/0x5b0 net/core/gro.c:141
>  __skb_gso_segment+0x250/0x3d0 net/core/dev.c:3401
>  skb_gso_segment include/linux/netdevice.h:4859 [inline]
>  validate_xmit_skb+0x364/0xdbc net/core/dev.c:3659
>  validate_xmit_skb_list+0x94/0x130 net/core/dev.c:3709
>  sch_direct_xmit+0xe8/0x548 net/sched/sch_generic.c:327
>  __dev_xmit_skb net/core/dev.c:3805 [inline]
>  __dev_queue_xmit+0x147c/0x3318 net/core/dev.c:4210
>  dev_queue_xmit include/linux/netdevice.h:3085 [inline]
>  packet_xmit+0x6c/0x318 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x376c/0x4c98 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg net/socket.c:747 [inline]
>  __sys_sendto+0x3b4/0x538 net/socket.c:2144
>  __do_sys_sendto net/socket.c:2156 [inline]
>  __se_sys_sendto net/socket.c:2152 [inline]
>  __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2152
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
>  el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> ================================================================================
> skb len=9070 headroom=178 headlen=9070 tailroom=6816
> mac=(178,14) net=(192,176) trans=368
> shinfo(txflags=0 nr_frags=0 gso(size=7321 type=131074 segs=0))
> csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
> hash(0x0 sw=0 l4=0) proto=0x86dd pkttype=0 iif=0
> dev name=erspan0 feat=0x0000000000006869
> sk family=17 type=3 proto=0
> skb linear:   00000000: 0c 2c ff f5 7b 01 6d 27 63 bd 56 37 86 dd 39 8d
> skb linear:   00000010: 53 75 03 e5 2b 02 59 1f 11 1e e6 16 d5 c0 18 43
> skb linear:   00000020: 74 a7 ff e4 ec 55 e0 65 47 86 a7 01 00 93 5b a5
> skb linear:   00000030: 14 d4 08 08 ef a0 11 10 16 01 84 2f d0 8d 49 a4
> skb linear:   00000040: 7e ff 71 bc 41 31 fe 4c 1f 99 bf 00 a9 00 00 00
> skb linear:   00000050: 08 d1 84 3e 77 0a fd 6e 9e f5 83 7d bd 00 00 00
> skb linear:   00000060: 00 53 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   00000070: 00 00 00 00 00 00 11 00 00 00 05 00 00 00 01 00
> skb linear:   00000080: 00 06 89 7b 42 8e 75 eb 00 00 00 00 00 00 00 00
> skb linear:   00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   000000f0: 00 00 00 00 00 00 65 72 73 70 61 6e 30 00 00 00
> skb linear:   00000100: 00 00 00 00 00 00 05 00 00 00 00 00 00 00 00 00
> skb linear:   00000110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> skb linear:   00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ------------[ cut here ]------------
> erspan0: caps=(0x0000000000006869, 0x0000000000000000)
> WARNING: CPU: 0 PID: 5975 at net/core/dev.c:3230 skb_warn_bad_offload+0x160/0x194 net/core/dev.c:3228
> Modules linked in:
> CPU: 0 PID: 5975 Comm: syz-executor412 Tainted: G    B              6.4.0-rc4-syzkaller-g908f31f2a05b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : skb_warn_bad_offload+0x160/0x194 net/core/dev.c:3228
> lr : skb_warn_bad_offload+0x160/0x194 net/core/dev.c:3228
> sp : ffff800096947280
> x29: ffff800096947280 x28: dfff800000000000 x27: ffff0000d2086000
> x26: 0000000000000020 x25: 1fffe0001ae170d8 x24: ffff80008c6f97c0
> x23: dfff800000000000 x22: ffff0000d70b8658 x21: ffff0000d2086000
> x20: ffff0000d2086000 x19: ffff0000d20860f0 x18: 0000000000000000
> x17: 0000000000000000 x16: ffff80008a4342bc x15: 0000000000000203
> x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
> x11: 0000000000000201 x10: 0000000000000000 x9 : e71a9b1dab1be800
> x8 : e71a9b1dab1be800 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff800096946b78 x4 : ffff80008df9ed80 x3 : ffff800080597be8
> x2 : 0000000000000001 x1 : 0000000000000201 x0 : 0000000000000000
> Call trace:
>  skb_warn_bad_offload+0x160/0x194 net/core/dev.c:3228
>  __skb_gso_segment+0x2f8/0x3d0 net/core/dev.c:3404
>  skb_gso_segment include/linux/netdevice.h:4859 [inline]
>  validate_xmit_skb+0x364/0xdbc net/core/dev.c:3659
>  validate_xmit_skb_list+0x94/0x130 net/core/dev.c:3709
>  sch_direct_xmit+0xe8/0x548 net/sched/sch_generic.c:327
>  __dev_xmit_skb net/core/dev.c:3805 [inline]
>  __dev_queue_xmit+0x147c/0x3318 net/core/dev.c:4210
>  dev_queue_xmit include/linux/netdevice.h:3085 [inline]
>  packet_xmit+0x6c/0x318 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x376c/0x4c98 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:724 [inline]
>  sock_sendmsg net/socket.c:747 [inline]
>  __sys_sendto+0x3b4/0x538 net/socket.c:2144
>  __do_sys_sendto net/socket.c:2156 [inline]
>  __se_sys_sendto net/socket.c:2152 [inline]
>  __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2152
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
>  el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> irq event stamp: 128240
> hardirqs last  enabled at (128240): [<ffff80008a4321bc>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
> hardirqs last  enabled at (128240): [<ffff80008a4321bc>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
> hardirqs last disabled at (128239): [<ffff80008a42fdf4>] __el1_irq arch/arm64/kernel/entry-common.c:470 [inline]
> hardirqs last disabled at (128239): [<ffff80008a42fdf4>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (128206): [<ffff80008861d870>] spin_unlock_bh include/linux/spinlock.h:395 [inline]
> softirqs last  enabled at (128206): [<ffff80008861d870>] release_sock+0x15c/0x1b0 net/core/sock.c:3495
> softirqs last disabled at (128224): [<ffff8000886a21f0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
