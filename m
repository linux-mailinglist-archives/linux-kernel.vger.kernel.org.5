Return-Path: <linux-kernel+bounces-85858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B114386BC59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4FC28825C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A576EE9;
	Wed, 28 Feb 2024 23:51:46 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66972931;
	Wed, 28 Feb 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164305; cv=none; b=mGHVcB4iTF/k+J1fcv5zxJc0wMZF3GqaDxAlS3V0TJhLsj509cfuKlg+47KBvZLOOylGZLNumPVdiOUpKsiXXKoKr1Tp8ZkckSrv3OEHsjTZn4a0ylcJBOagYbhiOvAjlpkXu8HhISE5z7UW9SRE+SxCjB1qEOa3BV+A8mwDU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164305; c=relaxed/simple;
	bh=e56CFHFkLiBHp65hwLBvKm7eKWDnSCWhNsYtrm/tC/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM40lVpDYF9OLGhpA5nTZHE1ixXfL8eTOJsLok0BWtEH9nVYzzNJ/4zSBxg8WGbjTyYgw76/+kB8A4dUu+0l2jvQr5gaNooY5XFVf3I5Q46YBSnK+BcmDJP5K0qXscdyWfIS36ZW9zJGj0vcEMrkP4h93hJXzeEG/leiWQWHoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=54716 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rfThx-0053eL-7N; Thu, 29 Feb 2024 00:51:31 +0100
Date: Thu, 29 Feb 2024 00:51:28 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, laforge@gnumonks.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, kovalev@altlinux.org,
	nickel@altlinux.org, dutyrok@altlinux.org, stable@vger.kernel.org
Subject: Re: [PATCH net] gtp: fix use-after-free and null-ptr-deref in
 gtp_newlink()
Message-ID: <Zd_HAGqXSE6Nwcag@calendula>
References: <20240228114703.465107-1-oficerovas@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228114703.465107-1-oficerovas@altlinux.org>
X-Spam-Score: -1.9 (-)

On Wed, Feb 28, 2024 at 02:47:03PM +0300, Alexander Ofitserov wrote:
> The gtp_link_ops operations structure for the subsystem must be
> registered after registering the gtp_net_ops pernet operations structure.

A fix for this was already applied, see:

commit 136cfaca22567a03bbb3bf53a43d8cb5748b80ec
Author: Vasiliy Kovalev <kovalev@altlinux.org>
Date:   Wed Feb 14 19:27:33 2024 +0300

    gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()

> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 2129ae42c7030..0ddec4cc84093 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1903,26 +1903,26 @@ static int __init gtp_init(void)
>  
>  	get_random_bytes(&gtp_h_initval, sizeof(gtp_h_initval));
>  
> -	err = rtnl_link_register(&gtp_link_ops);
> +	err = register_pernet_subsys(&gtp_net_ops);
>  	if (err < 0)
>  		goto error_out;

BTW, I like that this calls register_pernet_subsys() before
rtnl_link_register(), where a rtnetlink request could come before
pernet is set up.

> -	err = register_pernet_subsys(&gtp_net_ops);
> +	err = rtnl_link_register(&gtp_link_ops);
>  	if (err < 0)
> -		goto unreg_rtnl_link;
> +		goto unreg_pernet_subsys;
>  
>  	err = genl_register_family(&gtp_genl_family);
>  	if (err < 0)
> -		goto unreg_pernet_subsys;
> +		goto unreg_rtnl_link;
>  
>  	pr_info("GTP module loaded (pdp ctx size %zd bytes)\n",
>  		sizeof(struct pdp_ctx));
>  	return 0;
>  
> -unreg_pernet_subsys:
> -	unregister_pernet_subsys(&gtp_net_ops);
>  unreg_rtnl_link:
>  	rtnl_link_unregister(&gtp_link_ops);
> +unreg_pernet_subsys:
> +	unregister_pernet_subsys(&gtp_net_ops);
>  error_out:
>  	pr_err("error loading GTP module loaded\n");
>  	return err;
> -- 
> 2.42.1
> 
> 

