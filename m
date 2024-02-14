Return-Path: <linux-kernel+bounces-65615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A9854F70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB947B2AFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19060BAE;
	Wed, 14 Feb 2024 17:06:21 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78E6024D;
	Wed, 14 Feb 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930380; cv=none; b=aF6JHpTNo7j8Km6AjQHtAYGZ7SK9nxeQO+zZsomDDfBsX4N/xho2MuwZ/g+H2dLrx4j6F6clHOUaOzxsnlWcdXAYqaaoDk5i3ycmiKockQCJoC/d8o917uGj5QD3QRcwU20oSMEKo2DqlkTcedfuCFQqd6jZDWxFQvSGs2I8LTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930380; c=relaxed/simple;
	bh=crPfgZH3l8kcl+ACAoGhNiyQVwUurz54bo32xrk+ATU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZQoaTWaqjsToHbRT4G1c3eM0IddBpJh/AFGW2KZ+2MtGw7JASz8uhQiVUa9caGa1NhVBcja1MqO6kdVa0MIZabD+cKtBRqBnIXbvqvwiqQ7f3Rp/EqNdesqI4ncMIfw6GfUEQGmdxK4tDxtPzFfjmbP5vi2+ejC+qiAqDjrb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id B0E0D2F20258; Wed, 14 Feb 2024 17:06:15 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.103] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id D805B2F20241;
	Wed, 14 Feb 2024 17:06:12 +0000 (UTC)
Message-ID: <a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
Date: Wed, 14 Feb 2024 20:06:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Content-Language: en-US
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, laforge@gnumonks.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, nickel@altlinux.org,
 oficerovas@altlinux.org, dutyrok@altlinux.org, stable@vger.kernel.org
References: <20240214162733.34214-1-kovalev@altlinux.org>
 <ZczvJKETNyFE5Glm@calendula>
From: kovalev@altlinux.org
In-Reply-To: <ZczvJKETNyFE5Glm@calendula>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

14.02.2024 19:49, Pablo Neira Ayuso wrote:
> On Wed, Feb 14, 2024 at 07:27:33PM +0300, kovalev@altlinux.org wrote:
>> From: Vasiliy Kovalev <kovalev@altlinux.org>
>>
>> The gtp_net_ops pernet operations structure for the subsystem must be
>> registered before registering the generic netlink family.
> Thanks for finding a remedy for this.
>
> If your fix is correct, (I didn't test your patch yet) then maybe this
> needs to be fixed in a few more spots in the tree?
>
> net/devlink/core.c-static int __init devlink_init(void)
> net/devlink/core.c-{
> net/devlink/core.c-     int err;
> net/devlink/core.c-
> net/devlink/core.c-     err = genl_register_family(&devlink_nl_family);
> net/devlink/core.c-     if (err)
> net/devlink/core.c-             goto out;
> net/devlink/core.c:     err = register_pernet_subsys(&devlink_pernet_ops);
> net/devlink/core.c-     if (err)
>
> net/handshake/netlink.c-        ret = genl_register_family(&handshake_nl_family);
> net/handshake/netlink.c-        if (ret) {
> net/handshake/netlink.c-                pr_warn("handshake: netlink registration failed (%d)\n", ret);
> net/handshake/netlink.c-                handshake_req_hash_destroy();
> net/handshake/netlink.c-                return ret;
> net/handshake/netlink.c-        }
> net/handshake/netlink.c-
> net/handshake/netlink.c-        /*
> net/handshake/netlink.c-         * ORDER: register_pernet_subsys must be done last.
> net/handshake/netlink.c-         *
> net/handshake/netlink.c-         *      If initialization does not make it past pernet_subsys
> net/handshake/netlink.c-         *      registration, then handshake_net_id will remain 0. That
> net/handshake/netlink.c-         *      shunts the handshake consumer API to return ENOTSUPP
> net/handshake/netlink.c-         *      to prevent it from dereferencing something that hasn't
> net/handshake/netlink.c-         *      been allocated.
> net/handshake/netlink.c-         */
> net/handshake/netlink.c:        ret = register_pernet_subsys(&handshake_genl_net_ops);
>
> net/ipv4/tcp_metrics.c: ret = register_pernet_subsys(&tcp_net_metrics_ops);
> net/ipv4/tcp_metrics.c- if (ret < 0)
> net/ipv4/tcp_metrics.c-         panic("Could not register tcp_net_metrics_ops\n");
> net/ipv4/tcp_metrics.c-
> net/ipv4/tcp_metrics.c- ret = genl_register_family(&tcp_metrics_nl_family);
> net/ipv4/tcp_metrics.c- if (ret < 0)
> net/ipv4/tcp_metrics.c-         panic("Could not register tcp_metrics generic netlink\n");
> net/ipv4/tcp_metrics.c-}
>
> net/ipv6/ioam6.c-int __init ioam6_init(void)
> net/ipv6/ioam6.c-{
> net/ipv6/ioam6.c:       int err = register_pernet_subsys(&ioam6_net_ops);
> net/ipv6/ioam6.c-       if (err)
> net/ipv6/ioam6.c-               goto out;
> net/ipv6/ioam6.c-
> net/ipv6/ioam6.c-       err = genl_register_family(&ioam6_genl_family);
> net/ipv6/ioam6.c-       if (err)
> net/ipv6/ioam6.c-               goto out_unregister_pernet_subsys;
>
> net/ipv6/seg6.c-        err = genl_register_family(&seg6_genl_family);
> net/ipv6/seg6.c-        if (err)
> net/ipv6/seg6.c-                goto out;
> net/ipv6/seg6.c-
> net/ipv6/seg6.c:        err = register_pernet_subsys(&ip6_segments_ops);
> net/ipv6/seg6.c-        if (err)
> net/ipv6/seg6.c-                goto out_unregister_genl;
>
> net/netlink/genetlink.c-        err = genl_register_family(&genl_ctrl);
> net/netlink/genetlink.c-        if (err < 0)
> net/netlink/genetlink.c-                goto problem;
> net/netlink/genetlink.c-
> net/netlink/genetlink.c:        err = register_pernet_subsys(&genl_pernet_ops);
> net/netlink/genetlink.c-        if (err)
> net/netlink/genetlink.c-                goto problem;

Most likely, judging by the backtrace, the bug is the same [1]:

Call Trace:
  <TASK>
  genl_dumpit+0x119/0x220 net/netlink/genetlink.c:1025
  netlink_dump+0x588/0xca0 net/netlink/af_netlink.c:2264
  __netlink_dump_start+0x6d0/0x9c0 net/netlink/af_netlink.c:2370
  genl_family_rcv_msg_dumpit+0x1e1/0x2d0 net/netlink/genetlink.c:1074
  genl_family_rcv_msg net/netlink/genetlink.c:1190 [inline]
  genl_rcv_msg+0x470/0x800 net/netlink/genetlink.c:1208
  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0xd5/0x180 net/socket.c:745
  ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
  ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
  __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f35d567cda9

[1] https://lore.kernel.org/all/0000000000007549a6060f99544d@google.com/T/


-- 
Regards,
Vasiliy Kovalev


