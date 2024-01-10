Return-Path: <linux-kernel+bounces-22286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F5B829BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732972847AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70952495F4;
	Wed, 10 Jan 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3h65+Rs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAC48CC7;
	Wed, 10 Jan 2024 13:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2648EC433C7;
	Wed, 10 Jan 2024 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704894957;
	bh=Gp5DqY+37ZFySNj8568/k2wU0YW25d8qUEf6lNPjcEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3h65+Rsv/ojHEdBLQr7cFQyqQ2qrFnGr/E4bnsUEbfWW60MSRO6RlxB2X0cuttNM
	 s84gjOE+YYBeptO36iDDFzvUW2p/T5Vu66TRClakqNSyxDhxDJbBuC1pMbPrYF4Fqg
	 KbLKHZgbObes1f2Iap2TBI7QwJ2emo2fon7RC4MVBBzToFuuRVLLGlS4kccZUpLYSe
	 OmMF2F/Q4AdQ4f75NjKJ11s4EdTGok9OGMxcHCotpxec2+tGS9h67VnerkncaEzLK7
	 033CF3y15G/UYbPrMlvJmt6c7zohsmTFGXKiPoO9NwTGQjEvmCkTz4/qkIJRRWLkmm
	 SNiIwsQ4Femyg==
Date: Wed, 10 Jan 2024 13:55:52 +0000
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: quic_subashab@quicinc.com, quic_stranche@quicinc.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: qualcomm: rmnet: fix global oob in
 rmnet_policy
Message-ID: <20240110135552.GB9296@kernel.org>
References: <20240110061400.3356108-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110061400.3356108-1-linma@zju.edu.cn>

On Wed, Jan 10, 2024 at 02:14:00PM +0800, Lin Ma wrote:
> The variable rmnet_link_ops assign a *bigger* maxtype which leads to a
> global out-of-bounds read when parsing the netlink attributes. See bug
> trace below:
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
> Read of size 1 at addr ffffffff92c438d0 by task syz-executor.6/84207
> 
> CPU: 0 PID: 84207 Comm: syz-executor.6 Tainted: G                 N 6.1.0 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:284 [inline]
>  print_report+0x172/0x475 mm/kasan/report.c:395
>  kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
>  validate_nla lib/nlattr.c:386 [inline]
>  __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
>  __nla_parse+0x3e/0x50 lib/nlattr.c:697
>  nla_parse_nested_deprecated include/net/netlink.h:1248 [inline]
>  __rtnl_newlink+0x50a/0x1880 net/core/rtnetlink.c:3485
>  rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
>  rtnetlink_rcv_msg+0x43c/0xd70 net/core/rtnetlink.c:6091
>  netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  sock_sendmsg+0x154/0x190 net/socket.c:734
>  ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
>  ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
>  __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdcf2072359
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdcf13e3168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fdcf219ff80 RCX: 00007fdcf2072359
> RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
> RBP: 00007fdcf20bd493 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fffbb8d7bdf R14: 00007fdcf13e3300 R15: 0000000000022000
>  </TASK>
> 
> The buggy address belongs to the variable:
>  rmnet_policy+0x30/0xe0
> 
> The buggy address belongs to the physical page:
> page:0000000065bdeb3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x155243
> flags: 0x200000000001000(reserved|node=0|zone=2)
> raw: 0200000000001000 ffffea00055490c8 ffffea00055490c8 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffffffff92c43780: f9 f9 f9 f9 00 00 00 02 f9 f9 f9 f9 00 00 00 07
>  ffffffff92c43800: f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9 06 f9 f9 f9
> >ffffffff92c43880: f9 f9 f9 f9 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
>                                                  ^
>  ffffffff92c43900: 00 00 00 00 00 00 00 00 07 f9 f9 f9 f9 f9 f9 f9
>  ffffffff92c43980: 00 00 00 07 f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9
> 
> According to the comment of `nla_parse_nested_deprecated`, the maxtype
> should be len(destination array) - 1. Hence use `IFLA_RMNET_MAX` here.
> 
> Fixes: 14452ca3b5ce ("net: qualcomm: rmnet: Export mux_id and flags to netlink")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Thanks,

I agree with your analysis, proposed fix, and that the problem
was introduced in it's current form by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

