Return-Path: <linux-kernel+bounces-167670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEEA8BAD24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419901C2154A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291DC15358C;
	Fri,  3 May 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="YWJ7hn1K"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED714267;
	Fri,  3 May 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741610; cv=none; b=QhIqr96/yqK3nTtq8JhGwHLRZ5gnp69NRnVK9qJKQLC6DJd4B5pxEUmySXWU3qi+a5yD9GzkZd6Rq9f9+NRnF2j/+Am7cm/f6rTNZ4W1H8V3Awtc5FU7oajrEA8rXOvVGnVmjvgXCk9WosEOgp45cw+7f03RlEI8dN6j4DlWwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741610; c=relaxed/simple;
	bh=0kB9KsGXFOQAn9WaIfuv4jbNZroARw33YyK+RAm3BLQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iBBw6vIIOdz1kARuHAGuu1Sy9o31forUoWfRPngd4ALGP1ZoCyUnJIxBEuYCnoGlhg1zBhQEeg1UCc5czjuUXm6AbWWeEAMLVh57OSqQKCBVNJR00r5aJj2ZbLitRhL49UoVMnGM0GMCCnWSTgD1MS8iHBoZqPkXO8hcLx4T0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=YWJ7hn1K; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 88119A436;
	Fri,  3 May 2024 16:06:39 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Fri,  3 May 2024 16:06:38 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 3FFEA9003F2;
	Fri,  3 May 2024 16:06:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1714741595; bh=0kB9KsGXFOQAn9WaIfuv4jbNZroARw33YyK+RAm3BLQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=YWJ7hn1KFeLK3QcqPYFmkp0qdYuCvHjowC85pPDI6on/BDmmgNSTJV89+IcfPESoG
	 pJso8GkiQ5c5wg5bPOuYW0fqAQLzoayqDo29LIAzn5ISYIXM1Fbdiu3UJRu/Qd1RPK
	 EsDjDXG22jH0l8/7xId8pnT1nKHR3U4tigsLV8aM=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 443D6Od9049696;
	Fri, 3 May 2024 16:06:25 +0300
Date: Fri, 3 May 2024 16:06:24 +0300 (EEST)
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
Message-ID: <8e70d6d3-6852-7b84-81b3-5d1a798f224f@ssi.bg>
References: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com> <20240418145743.248109-2-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-1490811829-1714741586=:48180"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-1490811829-1714741586=:48180
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
> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 32be24f0d4e4..c3ba71aa2654 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c

..

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

	Sorry but you have to send v4 because above if-block was
changed with net-next commit 635470eb0aa7 from today...

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-1490811829-1714741586=:48180--


