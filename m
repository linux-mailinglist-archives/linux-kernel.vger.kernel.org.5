Return-Path: <linux-kernel+bounces-65586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C234854F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68266B299F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F74605C1;
	Wed, 14 Feb 2024 16:49:49 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8D60BA9;
	Wed, 14 Feb 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929389; cv=none; b=Vi7AenoGPZDaaXSFjhv/2ubmWPAJ+9UZ1O/Fpbf2RgvCmgt9uk0LAfSPzj4mE0GvGNbka5a1KGqKaEJiZ9rrF74rzmU6cB2BjKKg2zN2rwqMDbV8nnywwN/Pw7nAtwUxbmqOSoZIpSwJHEJp5zArSb/kW7ewvKElsVDzucdHnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929389; c=relaxed/simple;
	bh=zR2KWP8yg4tZ+LnvHd7op1sKZotXTweSN7cy2brrjkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAEdLBso8SefIEAGoSbZ3y6vSTs5AqblXoIT4wx5TGeR/V8YqxG7Y6UAz6OTTRy9nAXQrVEGKFEG0iFbMefZb6YlFePKF9CuqbqdAcV77gRawoewisioIyYFJq/zNG8sD3ZYwq9L9zY3oHo1F9waA6C03yGPH/OrAYx1Ehv04tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=48386 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1raIS4-001NHr-PN; Wed, 14 Feb 2024 17:49:42 +0100
Date: Wed, 14 Feb 2024 17:49:40 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: kovalev@altlinux.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, laforge@gnumonks.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Message-ID: <ZczvJKETNyFE5Glm@calendula>
References: <20240214162733.34214-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214162733.34214-1-kovalev@altlinux.org>
X-Spam-Score: -1.8 (-)

On Wed, Feb 14, 2024 at 07:27:33PM +0300, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> The gtp_net_ops pernet operations structure for the subsystem must be
> registered before registering the generic netlink family.

Thanks for finding a remedy for this.

If your fix is correct, (I didn't test your patch yet) then maybe this
needs to be fixed in a few more spots in the tree?

net/devlink/core.c-static int __init devlink_init(void)
net/devlink/core.c-{
net/devlink/core.c-     int err;
net/devlink/core.c-
net/devlink/core.c-     err = genl_register_family(&devlink_nl_family);
net/devlink/core.c-     if (err)
net/devlink/core.c-             goto out;
net/devlink/core.c:     err = register_pernet_subsys(&devlink_pernet_ops);
net/devlink/core.c-     if (err)

net/handshake/netlink.c-        ret = genl_register_family(&handshake_nl_family);
net/handshake/netlink.c-        if (ret) {
net/handshake/netlink.c-                pr_warn("handshake: netlink registration failed (%d)\n", ret);
net/handshake/netlink.c-                handshake_req_hash_destroy();
net/handshake/netlink.c-                return ret;
net/handshake/netlink.c-        }
net/handshake/netlink.c-
net/handshake/netlink.c-        /*
net/handshake/netlink.c-         * ORDER: register_pernet_subsys must be done last.
net/handshake/netlink.c-         *
net/handshake/netlink.c-         *      If initialization does not make it past pernet_subsys
net/handshake/netlink.c-         *      registration, then handshake_net_id will remain 0. That
net/handshake/netlink.c-         *      shunts the handshake consumer API to return ENOTSUPP
net/handshake/netlink.c-         *      to prevent it from dereferencing something that hasn't
net/handshake/netlink.c-         *      been allocated.
net/handshake/netlink.c-         */
net/handshake/netlink.c:        ret = register_pernet_subsys(&handshake_genl_net_ops);

net/ipv4/tcp_metrics.c: ret = register_pernet_subsys(&tcp_net_metrics_ops);
net/ipv4/tcp_metrics.c- if (ret < 0)
net/ipv4/tcp_metrics.c-         panic("Could not register tcp_net_metrics_ops\n");
net/ipv4/tcp_metrics.c-
net/ipv4/tcp_metrics.c- ret = genl_register_family(&tcp_metrics_nl_family);
net/ipv4/tcp_metrics.c- if (ret < 0)
net/ipv4/tcp_metrics.c-         panic("Could not register tcp_metrics generic netlink\n");
net/ipv4/tcp_metrics.c-}

net/ipv6/ioam6.c-int __init ioam6_init(void)
net/ipv6/ioam6.c-{
net/ipv6/ioam6.c:       int err = register_pernet_subsys(&ioam6_net_ops);
net/ipv6/ioam6.c-       if (err)
net/ipv6/ioam6.c-               goto out;
net/ipv6/ioam6.c-
net/ipv6/ioam6.c-       err = genl_register_family(&ioam6_genl_family);
net/ipv6/ioam6.c-       if (err)
net/ipv6/ioam6.c-               goto out_unregister_pernet_subsys;

net/ipv6/seg6.c-        err = genl_register_family(&seg6_genl_family);
net/ipv6/seg6.c-        if (err)
net/ipv6/seg6.c-                goto out;
net/ipv6/seg6.c-
net/ipv6/seg6.c:        err = register_pernet_subsys(&ip6_segments_ops);
net/ipv6/seg6.c-        if (err)
net/ipv6/seg6.c-                goto out_unregister_genl;

net/netlink/genetlink.c-        err = genl_register_family(&genl_ctrl);
net/netlink/genetlink.c-        if (err < 0)
net/netlink/genetlink.c-                goto problem;
net/netlink/genetlink.c-
net/netlink/genetlink.c:        err = register_pernet_subsys(&genl_pernet_ops);
net/netlink/genetlink.c-        if (err)
net/netlink/genetlink.c-                goto problem;

> Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug:
[...]
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index b1919278e931f4..2129ae42c70304 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1907,20 +1907,20 @@ static int __init gtp_init(void)
>  	if (err < 0)
>  		goto error_out;
>  
> -	err = genl_register_family(&gtp_genl_family);
> +	err = register_pernet_subsys(&gtp_net_ops);
>  	if (err < 0)
>  		goto unreg_rtnl_link;
>  
> -	err = register_pernet_subsys(&gtp_net_ops);
> +	err = genl_register_family(&gtp_genl_family);
>  	if (err < 0)
> -		goto unreg_genl_family;
> +		goto unreg_pernet_subsys;
>  
>  	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
>  		sizeof(struct pdp_ctx));
>  	return 0;
>  
> -unreg_genl_family:
> -	genl_unregister_family(&gtp_genl_family);
> +unreg_pernet_subsys:
> +	unregister_pernet_subsys(&gtp_net_ops);
>  unreg_rtnl_link:
>  	rtnl_link_unregister(&gtp_link_ops);
>  error_out:
> -- 
> 2.33.8
> 

