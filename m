Return-Path: <linux-kernel+bounces-65627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C856854F97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D20F1F2A9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F9D7AE58;
	Wed, 14 Feb 2024 17:13:35 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89B7A706;
	Wed, 14 Feb 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930815; cv=none; b=PIvj7sguSM4Sy4HF/ajdzRKSjujsmdA+LzCBYE2eE/3wic30dDVYTa4d78Hv/xDBCF8kd07DEYTaI/HV2D4avqqK+5TA2+NgumoBDuzEnuofzG96xPmw0DZdJ0jFxv0lBdVfNCakJ1XwbsUYh1aWWWQ5PDtSkwetR45dIbBQIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930815; c=relaxed/simple;
	bh=lnxYYZhuHdZc7D0Y0bEbSBOBkMXVHnRmRIzuiMPc4fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjJ1el30yp7j87dXSb5IJXSgRH+mZ2QuzNup0qS9wrrywAU4jX+nIzlteHV2sFFYlVbF0brbsd+Fm5tDSa6k63gUCuGZNQu6mhng410m0NJo8DPebRveCuxJYCwAc2Y/aIAhCw4+MAHr6onFWQqJjVIP7RuhAYziZURLtBOoJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=54270 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1raIp3-001Ooj-PP; Wed, 14 Feb 2024 18:13:27 +0100
Date: Wed, 14 Feb 2024 18:13:24 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: kovalev@altlinux.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, laforge@gnumonks.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Message-ID: <Zcz0tG9XMqLHMKs+@calendula>
References: <20240214162733.34214-1-kovalev@altlinux.org>
 <ZczvJKETNyFE5Glm@calendula>
 <a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
X-Spam-Score: -1.9 (-)

On Wed, Feb 14, 2024 at 08:06:12PM +0300, kovalev@altlinux.org wrote:
> 14.02.2024 19:49, Pablo Neira Ayuso wrote:
> > On Wed, Feb 14, 2024 at 07:27:33PM +0300, kovalev@altlinux.org wrote:
> > > From: Vasiliy Kovalev <kovalev@altlinux.org>
> > > 
> > > The gtp_net_ops pernet operations structure for the subsystem must be
> > > registered before registering the generic netlink family.
> > Thanks for finding a remedy for this.
> > 
> > If your fix is correct, (I didn't test your patch yet) then maybe this
> > needs to be fixed in a few more spots in the tree?
> > 
> > net/devlink/core.c-static int __init devlink_init(void)
> > net/devlink/core.c-{
> > net/devlink/core.c-     int err;
> > net/devlink/core.c-
> > net/devlink/core.c-     err = genl_register_family(&devlink_nl_family);
> > net/devlink/core.c-     if (err)
> > net/devlink/core.c-             goto out;
> > net/devlink/core.c:     err = register_pernet_subsys(&devlink_pernet_ops);
> > net/devlink/core.c-     if (err)
> > 
> > net/handshake/netlink.c-        ret = genl_register_family(&handshake_nl_family);
> > net/handshake/netlink.c-        if (ret) {
> > net/handshake/netlink.c-                pr_warn("handshake: netlink registration failed (%d)\n", ret);
> > net/handshake/netlink.c-                handshake_req_hash_destroy();
> > net/handshake/netlink.c-                return ret;
> > net/handshake/netlink.c-        }
> > net/handshake/netlink.c-
> > net/handshake/netlink.c-        /*
> > net/handshake/netlink.c-         * ORDER: register_pernet_subsys must be done last.
> > net/handshake/netlink.c-         *
> > net/handshake/netlink.c-         *      If initialization does not make it past pernet_subsys
> > net/handshake/netlink.c-         *      registration, then handshake_net_id will remain 0. That
> > net/handshake/netlink.c-         *      shunts the handshake consumer API to return ENOTSUPP
> > net/handshake/netlink.c-         *      to prevent it from dereferencing something that hasn't
> > net/handshake/netlink.c-         *      been allocated.
> > net/handshake/netlink.c-         */
> > net/handshake/netlink.c:        ret = register_pernet_subsys(&handshake_genl_net_ops);
> > 
> > net/ipv4/tcp_metrics.c: ret = register_pernet_subsys(&tcp_net_metrics_ops);
> > net/ipv4/tcp_metrics.c- if (ret < 0)
> > net/ipv4/tcp_metrics.c-         panic("Could not register tcp_net_metrics_ops\n");
> > net/ipv4/tcp_metrics.c-
> > net/ipv4/tcp_metrics.c- ret = genl_register_family(&tcp_metrics_nl_family);
> > net/ipv4/tcp_metrics.c- if (ret < 0)
> > net/ipv4/tcp_metrics.c-         panic("Could not register tcp_metrics generic netlink\n");
> > net/ipv4/tcp_metrics.c-}
> > 
> > net/ipv6/ioam6.c-int __init ioam6_init(void)
> > net/ipv6/ioam6.c-{
> > net/ipv6/ioam6.c:       int err = register_pernet_subsys(&ioam6_net_ops);
> > net/ipv6/ioam6.c-       if (err)
> > net/ipv6/ioam6.c-               goto out;
> > net/ipv6/ioam6.c-
> > net/ipv6/ioam6.c-       err = genl_register_family(&ioam6_genl_family);
> > net/ipv6/ioam6.c-       if (err)
> > net/ipv6/ioam6.c-               goto out_unregister_pernet_subsys;
> > 
> > net/ipv6/seg6.c-        err = genl_register_family(&seg6_genl_family);
> > net/ipv6/seg6.c-        if (err)
> > net/ipv6/seg6.c-                goto out;
> > net/ipv6/seg6.c-
> > net/ipv6/seg6.c:        err = register_pernet_subsys(&ip6_segments_ops);
> > net/ipv6/seg6.c-        if (err)
> > net/ipv6/seg6.c-                goto out_unregister_genl;
> > 
> > net/netlink/genetlink.c-        err = genl_register_family(&genl_ctrl);
> > net/netlink/genetlink.c-        if (err < 0)
> > net/netlink/genetlink.c-                goto problem;
> > net/netlink/genetlink.c-
> > net/netlink/genetlink.c:        err = register_pernet_subsys(&genl_pernet_ops);
> > net/netlink/genetlink.c-        if (err)
> > net/netlink/genetlink.c-                goto problem;
> 
> Most likely, judging by the backtrace, the bug is the same [1]:
> 
> Call Trace:
>  <TASK>
>  genl_dumpit+0x119/0x220 net/netlink/genetlink.c:1025
>  netlink_dump+0x588/0xca0 net/netlink/af_netlink.c:2264
>  __netlink_dump_start+0x6d0/0x9c0 net/netlink/af_netlink.c:2370
>  genl_family_rcv_msg_dumpit+0x1e1/0x2d0 net/netlink/genetlink.c:1074
>  genl_family_rcv_msg net/netlink/genetlink.c:1190 [inline]
>  genl_rcv_msg+0x470/0x800 net/netlink/genetlink.c:1208
>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0xd5/0x180 net/socket.c:745
>  ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
>  ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
>  __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f35d567cda9

Ok, then a series of fixes probably needs to happen so each maintain
can review and apply them.

Maybe some of these subsystems above can only be compiled built-in, so
that cannot trigger.

In any case, are you up to pick on that series?

Thanks.

