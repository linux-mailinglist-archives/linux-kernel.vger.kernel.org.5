Return-Path: <linux-kernel+bounces-148526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD06D8A83FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04C01C213F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389F13DDD8;
	Wed, 17 Apr 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="rIP3z9lg"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052913C9AD;
	Wed, 17 Apr 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359568; cv=none; b=DjOkW6bNKFTC39XwOHw01u+zA392VCwJJJlkf2io6qKhwg1fxCPm6DTktlq5+sYSa+InHlKKtsPqZ63fIZiFq4v5CQeLIDGO6YxyeXaBqpq06H3+THWbVegfxGC4xahHcbJkar0JPhVc6uiVi14I6vW4qnfJJgOU8UBD6duX2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359568; c=relaxed/simple;
	bh=M5AbliW62VTYQiQJ1ZutBcfkVP4HB7k7NtYzfZIlJ/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hslPlwJUgtJhjbd4hbAn6MsnjRDXUuILc1EqCRCDtLzj+a/BhEnciENnZcQiwbzN7gJKCud2aOwdHHwEzaolrvwrFnBegfoA82UXcfOpEEsw5RVWns1sRv+94FrlvVSM0EPlA7kEBZZtwHQJhb//518uCZJk45/pxwUqfPbyCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=rIP3z9lg; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id B332637CFC;
	Wed, 17 Apr 2024 16:02:28 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Wed, 17 Apr 2024 16:02:24 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 4288A90044E;
	Wed, 17 Apr 2024 16:02:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1713358938; bh=M5AbliW62VTYQiQJ1ZutBcfkVP4HB7k7NtYzfZIlJ/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=rIP3z9lg474l8tpwwtcJBro3ovnU4Qfnvcxkx1KMUiZeJfC+x4FRaIz45VEtYhIA7
	 2hXk/0GMt1SRfVrA/ZjGxU/NrGCNmi6eLwucjmlmiiwLcIMruuUoBP1u7fgn+0PecV
	 gqnKrdP1nTNquMXl96hRMOVYdKZUhu1/Jfmh++ig=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43HD2EIr076830;
	Wed, 17 Apr 2024 16:02:15 +0300
Date: Wed, 17 Apr 2024 16:02:14 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
        Christian Brauner <brauner@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next] ipvs: allow some sysctls in non-init user
 namespaces
In-Reply-To: <20240416144814.173185-1-aleksandr.mikhalitsyn@canonical.com>
Message-ID: <32f56a2e-8142-4391-916a-65fe51a57933@ssi.bg>
References: <20240416144814.173185-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-76452460-1713358936=:3334"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-76452460-1713358936=:3334
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Tue, 16 Apr 2024, Alexander Mikhalitsyn wrote:

> Let's make all IPVS sysctls visible and RO even when
> network namespace is owned by non-initial user namespace.
> 
> Let's make a few sysctls to be writable:
> - conntrack
> - conn_reuse_mode
> - expire_nodest_conn
> - expire_quiescent_template
> 
> I'm trying to be conservative with this to prevent
> introducing any security issues in there. Maybe,
> we can allow more sysctls to be writable, but let's
> do this on-demand and when we see real use-case.
> 
> This list of sysctls was chosen because I can't
> see any security risks allowing them and also
> Kubernetes uses [2] these specific sysctls.
> 
> This patch is motivated by user request in the LXC
> project [1].
> 
> [1] https://github.com/lxc/lxc/issues/4278
> [2] https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a2284b890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103
> 
> Cc: Stéphane Graber <stgraber@stgraber.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Julian Anastasov <ja@ssi.bg>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 143a341bbc0a..92a818c2f783 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -4285,10 +4285,22 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)

	As the list of privileged vars is short I prefer
to use a bool and to make only some vars read-only:

	bool unpriv = false;

>  		if (tbl == NULL)
>  			return -ENOMEM;
>  
> -		/* Don't export sysctls to unprivileged users */
> +		/* Let's show all sysctls in non-init user namespace-owned
> +		 * net namespaces, but make them read-only.
> +		 *
> +		 * Allow only a few specific sysctls to be writable.
> +		 */
>  		if (net->user_ns != &init_user_ns) {

	Here we should just set: unpriv = true;

> -			tbl[0].procname = NULL;
> -			ctl_table_size = 0;
> +			for (idx = 0; idx < ARRAY_SIZE(vs_vars); idx++) {
> +				if (!tbl[idx].procname)
> +					continue;
> +
> +				if (!((strcmp(tbl[idx].procname, "conntrack") == 0) ||
> +				      (strcmp(tbl[idx].procname, "conn_reuse_mode") == 0) ||
> +				      (strcmp(tbl[idx].procname, "expire_nodest_conn") == 0) ||
> +				      (strcmp(tbl[idx].procname, "expire_quiescent_template") == 0)))
> +					tbl[idx].mode = 0444;
> +			}
>  		}
>  	} else
>  		tbl = vs_vars;

	And below at every place to use:

	if (unpriv)
		tbl[idx].mode = 0444;

	for the following 4 privileged sysctl vars:

- sync_qlen_max:
	- allocates messages in kernel context
	- this needs better tunning in another patch

- sync_sock_size:
	- allocates messages in kernel context

- run_estimation:
	- for now, better init ns to decide if to use est stats

- est_nice:
	- for now, better init ns to decide the value

- debug_level:
	- already set to 0444

	I.e. these vars allocate resources (mem, CPU) without
proper control, so for now we will just copy them from init ns
without allowing writing. And they are vars that are not tuned
often. Also we do not know which netns is supposed to be the
privileged one, some solutions move all devices out of init_net,
so we can not decide where to use lower limits.

	OTOH, "amemthresh" is not privileged but needs single READ_ONCE 
for sysctl_amemthresh in update_defense_level() due to the possible
div by zero if we allow writing to anyone, eg.:

	int amemthresh = max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
	...
	nomem = availmem < amemthresh;
	... use only amemthresh

	All other vars can be writable.

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-76452460-1713358936=:3334--


