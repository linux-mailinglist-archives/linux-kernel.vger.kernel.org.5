Return-Path: <linux-kernel+bounces-96624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD74875F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0268B1F21C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5705651009;
	Fri,  8 Mar 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="uwbJryeQ"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B798481DC;
	Fri,  8 Mar 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885090; cv=none; b=mmgtuW2HpyMCQ6X0Ws+SrBCifiTqxwnfPZ5vnTBgcBwsCcuuHAaOqtmdaJUfWH+H5kgfmKcQRV59/+Vm9VRaubSgCM9oDz7YV0I+ZhB8+wan/hgormosgi4lbgimnqkxBikJgxnSI3Go1HfQEas3NlXDTW0xhZHfIxhmyV+OuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885090; c=relaxed/simple;
	bh=QZTAxiGWwpEexgLFe9jZSIY9NbeDwvSTqVQZnYmTvI4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MRqIfpAkpm1Eb8i7FMuyZdbZLYAT9DWijx97qmpiflCvCtLhwi4Uf8CL8Ds0/yny3M+DnWSr/CPJNcZzh/CphzJlF1DLLVz3jpL2rqEy9bKTOAVruS0B2cUJKb5BmS2DjS0FYch1jYyE6LETpcI2TQTkv8AkfjIGWDHUxpYn/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=uwbJryeQ; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 3DAD4210EA;
	Fri,  8 Mar 2024 09:55:40 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS id 21A7D20E79;
	Fri,  8 Mar 2024 09:55:40 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 840543C0439;
	Fri,  8 Mar 2024 09:55:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1709884536; bh=QZTAxiGWwpEexgLFe9jZSIY9NbeDwvSTqVQZnYmTvI4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=uwbJryeQTqOraXtDwW0CqiNcFIwZl1Qg5NaS2QLFcunSAsCGPap9cjb43fPYdi53l
	 yiO1mtQ2jGfow6vIwAd/dSXxzzMFuiOQJuUkprRvsRYVwrlCIWyOd1yjJGAJfYFHrM
	 MLoG9QLnx96tgCc/7vAyISjjV9S7n3/rKy9GQ6pc=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 4287tOn7014553;
	Fri, 8 Mar 2024 09:55:26 +0200
Date: Fri, 8 Mar 2024 09:55:24 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
cc: Simon Horman <horms@verge.net.au>, gyroidos@aisec.fraunhofer.de,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipvs: allow netlink configuration from non-initial user
 namespace
In-Reply-To: <20240307203107.63815-1-michael.weiss@aisec.fraunhofer.de>
Message-ID: <e1c8e477-ae59-48de-4aa8-e6df09013831@ssi.bg>
References: <20240307203107.63815-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-396118792-1709884526=:4390"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-396118792-1709884526=:4390
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Thu, 7 Mar 2024, Michael Weiß wrote:

> Configuring ipvs in a non-initial user namespace using the genl
> netlink interface, e.g., by 'ipvsadm' is currently resulting in an
> '-EPERM'. This is due to the use of GENL_ADMIN_PERM flag in
> 'ip_vs_ctl.c'.
> 
> Similarly to other genl interfaces, we switch to the use of
> GENL_UNS_ADMIN_PERM flag which allows connection from non-initial
> user namespace. Thus, it would be feasible to configure ipvs using
> the genl interface also from within an unprivileged system container.
> 
> Since adding of new services and new dests are triggered from
> userspace, accounting for the corresponding memory allocations in
> ip_vs_new_dest() and ip_vs_add_service() is activated.
> 
> We tested this by simply running some samples from "man ipvsadm"
> within an unprivileged user namespaced system container in GyroidOS.
> Further, we successfully passed an adapted version of the ipvs
> selftest in 'tools/testing/selftests/netfilter/ipvs.sh' using
> preliminary created network namespaces from unprivileged GyroidOS
> containers.

	I planned such change but as followup patchset to other
work which converts many structures to be per-netns.

	There is a RFC v2 patchset for reference:

https://archive.linuxvirtualserver.org/html/lvs-devel/2023-12/index.html

	My goal was to isolate the different namespaces as much as
possible: different structures, different kthreads, etc. with the
goal to reduce the security risks of giving power to unprivileged roots.
Such isolation should help when namespaces are served from different CPUs.

	May be I should push fresh v3 soon, so that we can later use
GFP_KERNEL_ACCOUNT not only for services and dests but also
for allocations by schedulers, estimators, etc. The access to
sysctl vars should be enabled too, around comment
"Don't export sysctls to unprivileged users",
alloc_percpu => alloc_percpu_gfp(,GFP_KERNEL_ACCOUNT),
SLAB_ACCOUNT for kmem_cache_create, not sure about __GFP_NOWARN and
__GFP_NORETRY usage too.

	Not sure about the sysctl vars: now they are cloned from
init_net, do we give full access for writing, some can be privileged,
etc.

	I didn't push such changes yet because I'm not sure what
is needed: looks like, for now, what was needed is root from init_net to 
control rules in different netns and there was no demand from the 
virtualization world to extend this. If we can clearly define what is 
good and what is bad from security perspective, we can go with such 
changes after pushing the above patchset, i.e. the GENL_UNS_ADMIN_PERM
change should follow all other changes.

> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 36 +++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 143a341bbc0a..d39120c64207 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -1080,7 +1080,7 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
>  			return -EINVAL;
>  	}
>  
> -	dest = kzalloc(sizeof(struct ip_vs_dest), GFP_KERNEL);
> +	dest = kzalloc(sizeof(struct ip_vs_dest), GFP_KERNEL_ACCOUNT);
>  	if (dest == NULL)
>  		return -ENOMEM;
>  
> @@ -1421,7 +1421,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
>  		ret_hooks = ret;
>  	}
>  
> -	svc = kzalloc(sizeof(struct ip_vs_service), GFP_KERNEL);
> +	svc = kzalloc(sizeof(struct ip_vs_service), GFP_KERNEL_ACCOUNT);
>  	if (svc == NULL) {
>  		IP_VS_DBG(1, "%s(): no memory\n", __func__);
>  		ret = -ENOMEM;
> @@ -4139,98 +4139,98 @@ static const struct genl_small_ops ip_vs_genl_ops[] = {
>  	{
>  		.cmd	= IPVS_CMD_NEW_SERVICE,
>  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> -		.flags	= GENL_ADMIN_PERM,
> +		.flags	= GENL_UNS_ADMIN_PERM,
>  		.doit	= ip_vs_genl_set_cmd,
..

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-396118792-1709884526=:4390--


