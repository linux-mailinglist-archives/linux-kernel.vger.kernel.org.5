Return-Path: <linux-kernel+bounces-152474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08A8ABF01
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2DB28101B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7311CAB;
	Sun, 21 Apr 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="mojg62LF"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C73205E18;
	Sun, 21 Apr 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713697578; cv=none; b=LYvTZ68ePdjebNZ2+ge547qam6aDT3nLUGzO3E8eXMiZwn6b5dLmouMxQhGFA12KWnlS06Yy5HirtWnmX72FrWmfZ7b9HvDDmIOfy9/Q+lmTjhgVr9/ie61JvJTdpYiI386d2WFiwr8D9wEi4OhcPiiCiooB1fA9B8KWMbnZeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713697578; c=relaxed/simple;
	bh=GdwWJ85LC1A0LTIVA+zAN8BD2/xLrsuqVq8CLg9O6dI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rUXxz+jFR3mRkbBcw8HxUYx3EkZmAFJcKCa79FVGdMUiNFGIBdhZhfDiPyF1TLjj8LJYuplGgEZfk2k+og4cVs+lVeJl2kyXS+0qCZxnndDUa2Fze4AzyRSe0vnG9//y8xTdF8wqj1I6D6y/6JzE92sIJYglaetFxBrTJwV//4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=mojg62LF; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 676C9224CC;
	Sun, 21 Apr 2024 14:06:13 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Sun, 21 Apr 2024 14:06:12 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 8FBC39003A3;
	Sun, 21 Apr 2024 14:06:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1713697569; bh=GdwWJ85LC1A0LTIVA+zAN8BD2/xLrsuqVq8CLg9O6dI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=mojg62LF85N0UTEZNOrENQaxe7gEDHYIXhVe/VAzjjKK4+wMaypT5dwYg0pkcoruF
	 fghni4PYZUtuoVz+OANK1LeyTIudOkNXXEmFR/W/ofd8UM3jCJ3IYVQhdFHi6YesqZ
	 tCL7ClloJI156oR6bBfLvCb5Y8vK6FhnJrYrKOTs=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43LB67r1035357;
	Sun, 21 Apr 2024 14:06:08 +0300
Date: Sun, 21 Apr 2024 14:06:07 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next v3 1/2] ipvs: add READ_ONCE barrier for
 ipvs->sysctl_amemthresh
In-Reply-To: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com>
Message-ID: <ef5a38db-c80d-feb8-7c7d-c9b66085afba@ssi.bg>
References: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Thu, 18 Apr 2024, Alexander Mikhalitsyn wrote:

> Cc: Julian Anastasov <ja@ssi.bg>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Suggested-by: Julian Anastasov <ja@ssi.bg>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 143a341bbc0a..32be24f0d4e4 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -94,6 +94,7 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  {
>  	struct sysinfo i;
>  	int availmem;
> +	int amemthresh;
>  	int nomem;
>  	int to_change = -1;
>  
> @@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  	/* si_swapinfo(&i); */
>  	/* availmem = availmem - (i.totalswap - i.freeswap); */
>  
> -	nomem = (availmem < ipvs->sysctl_amemthresh);
> +	amemthresh = max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
> +	nomem = (availmem < amemthresh);
>  
>  	local_bh_disable();
>  
> @@ -145,9 +147,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  		break;
>  	case 1:
>  		if (nomem) {
> -			ipvs->drop_rate = ipvs->drop_counter
> -				= ipvs->sysctl_amemthresh /
> -				(ipvs->sysctl_amemthresh-availmem);
> +			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
> +			ipvs->drop_rate = ipvs->drop_counter;
>  			ipvs->sysctl_drop_packet = 2;
>  		} else {
>  			ipvs->drop_rate = 0;
> @@ -155,9 +156,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  		break;
>  	case 2:
>  		if (nomem) {
> -			ipvs->drop_rate = ipvs->drop_counter
> -				= ipvs->sysctl_amemthresh /
> -				(ipvs->sysctl_amemthresh-availmem);
> +			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
> +			ipvs->drop_rate = ipvs->drop_counter;
>  		} else {
>  			ipvs->drop_rate = 0;
>  			ipvs->sysctl_drop_packet = 1;
> -- 
> 2.34.1

Regards

--
Julian Anastasov <ja@ssi.bg>


