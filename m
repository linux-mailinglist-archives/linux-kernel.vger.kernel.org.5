Return-Path: <linux-kernel+bounces-152475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39C8ABF04
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA77A280FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFEA11733;
	Sun, 21 Apr 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="Oo17cw39"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7C10979;
	Sun, 21 Apr 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713697621; cv=none; b=Z2g3qNuRh37A/ESXd2iONr+zKBrLKnGMeRyaQulYGxJA+qTF7CDWaTPljlfykBodopLV1xENA6W1PXHUCRko3UxVsx8hVKTBbdVkPnj2B6FwMCOYrg9lb3sA9DxMU+/ws47RTWrkJGNA3gtNLzQdQW91hCz87AXaskcGRfRpS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713697621; c=relaxed/simple;
	bh=Ner97hv7U1mBPZ7qaJ0aCMYKz05PKiaL1oq32Flq5kM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=erXRPHu3JM6SNS+8E5M3OuonZGMA4atvWniACDxpgXtVun9em4OxH5Y/2LK4WzZcXAfNkEcgviHiKWKXQ+WwhAUegwi0Lrx7fAXYU9ZDEjxTeVaMpQ86P5PstFNiPVyAF4F53zN15u/LlD4gK7oZaV4wagzyoJ8rVb1dmApx2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=Oo17cw39; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id B7E242259D;
	Sun, 21 Apr 2024 14:06:56 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Sun, 21 Apr 2024 14:06:55 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id C78509003A3;
	Sun, 21 Apr 2024 14:06:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1713697612; bh=Ner97hv7U1mBPZ7qaJ0aCMYKz05PKiaL1oq32Flq5kM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Oo17cw39RqVFmSeyRvUmdCHsEU1FaPd0u9V09OFQAlp9FG5U+d24X5XKJcyJLQEqX
	 bFsqAcQ66fYVxCAUMavppPzonkErsY8ydeKAjqPz67W8Ty97QxT+ZSBr7WUwF1oPuL
	 fC37q9i/k7LyaFrzzOFI5UiXT+iZYTmih+e/0GrQ=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43LB6nwL035464;
	Sun, 21 Apr 2024 14:06:49 +0300
Date: Sun, 21 Apr 2024 14:06:49 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
        Christian Brauner <brauner@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next v3 2/2] ipvs: allow some sysctls in non-init
 user namespaces
In-Reply-To: <20240418145743.248109-2-aleksandr.mikhalitsyn@canonical.com>
Message-ID: <b3c6447c-7ca4-022c-5f10-3aafff900ac5@ssi.bg>
References: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com> <20240418145743.248109-2-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-205715629-1713697611=:3044"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-205715629-1713697611=:3044
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Thu, 18 Apr 2024, Alexander Mikhalitsyn wrote:

> Let's make all IPVS sysctls writtable even when
> network namespace is owned by non-initial user namespace.
> 
> Let's make a few sysctls to be read-only for non-privileged users:
> - sync_qlen_max
> - sync_sock_size
> - run_estimation
> - est_cpulist
> - est_nice
> 
> I'm trying to be conservative with this to prevent
> introducing any security issues in there. Maybe,
> we can allow more sysctls to be writable, but let's
> do this on-demand and when we see real use-case.
> 
> This patch is motivated by user request in the LXC
> project [1]. Having this can help with running some
> Kubernetes [2] or Docker Swarm [3] workloads inside the system
> containers.
> 
> Link: https://github.com/lxc/lxc/issues/4278 [1]
> Link: https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a2284b890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103 [2]
> Link: https://github.com/moby/libnetwork/blob/3797618f9a38372e8107d8c06f6ae199e1133ae8/osl/namespace_linux.go#L682 [3]
> 
> Cc: Stéphane Graber <stgraber@stgraber.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Julian Anastasov <ja@ssi.bg>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 32be24f0d4e4..c3ba71aa2654 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -4270,6 +4270,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	struct ctl_table *tbl;
>  	int idx, ret;
>  	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
> +	bool unpriv = net->user_ns != &init_user_ns;
>  
>  	atomic_set(&ipvs->dropentry, 0);
>  	spin_lock_init(&ipvs->dropentry_lock);
> @@ -4284,12 +4285,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
>  		if (tbl == NULL)
>  			return -ENOMEM;
> -
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns) {
> -			tbl[0].procname = NULL;
> -			ctl_table_size = 0;
> -		}
>  	} else
>  		tbl = vs_vars;
>  	/* Initialize sysctl defaults */
> @@ -4315,10 +4310,17 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	ipvs->sysctl_sync_ports = 1;
>  	tbl[idx++].data = &ipvs->sysctl_sync_ports;
>  	tbl[idx++].data = &ipvs->sysctl_sync_persist_mode;
> +
>  	ipvs->sysctl_sync_qlen_max = nr_free_buffer_pages() / 32;
> +	if (unpriv)
> +		tbl[idx].mode = 0444;
>  	tbl[idx++].data = &ipvs->sysctl_sync_qlen_max;
> +
>  	ipvs->sysctl_sync_sock_size = 0;
> +	if (unpriv)
> +		tbl[idx].mode = 0444;
>  	tbl[idx++].data = &ipvs->sysctl_sync_sock_size;
> +
>  	tbl[idx++].data = &ipvs->sysctl_cache_bypass;
>  	tbl[idx++].data = &ipvs->sysctl_expire_nodest_conn;
>  	tbl[idx++].data = &ipvs->sysctl_sloppy_tcp;
> @@ -4341,15 +4343,22 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	tbl[idx++].data = &ipvs->sysctl_conn_reuse_mode;
>  	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
>  	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
> +
>  	ipvs->sysctl_run_estimation = 1;
> +	if (unpriv)
> +		tbl[idx].mode = 0444;
>  	tbl[idx].extra2 = ipvs;
>  	tbl[idx++].data = &ipvs->sysctl_run_estimation;
>  
>  	ipvs->est_cpulist_valid = 0;
> +	if (unpriv)
> +		tbl[idx].mode = 0444;
>  	tbl[idx].extra2 = ipvs;
>  	tbl[idx++].data = &ipvs->sysctl_est_cpulist;
>  
>  	ipvs->sysctl_est_nice = IPVS_EST_NICE;
> +	if (unpriv)
> +		tbl[idx].mode = 0444;
>  	tbl[idx].extra2 = ipvs;
>  	tbl[idx++].data = &ipvs->sysctl_est_nice;
>  
> -- 
> 2.34.1
> 
> 

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-205715629-1713697611=:3044--


