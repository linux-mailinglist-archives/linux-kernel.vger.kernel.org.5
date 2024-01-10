Return-Path: <linux-kernel+bounces-22249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D0829B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65EE4B2317C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665644A993;
	Wed, 10 Jan 2024 13:33:47 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FE4CB5B;
	Wed, 10 Jan 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rNYi5-0000Y9-0c; Wed, 10 Jan 2024 14:33:33 +0100
Date: Wed, 10 Jan 2024 14:33:33 +0100
From: Florian Westphal <fw@strlen.de>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH 1/4] netfilter: nfnetlink_log: use proper helper for
 fetching physinif
Message-ID: <20240110133333.GA24888@breakpoint.cc>
References: <20240110110451.5473-1-ptikhomirov@virtuozzo.com>
 <20240110110451.5473-2-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110110451.5473-2-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> We don't use physindev in __build_packet_message except for getting
> physinif from it. So let's switch to nf_bridge_get_physinif to get what
> we want directly.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  net/netfilter/nfnetlink_log.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
> index f03f4d4d7d889..134e05d31061e 100644
> --- a/net/netfilter/nfnetlink_log.c
> +++ b/net/netfilter/nfnetlink_log.c
> @@ -508,7 +508,7 @@ __build_packet_message(struct nfnl_log_net *log,
>  					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
>  				goto nla_put_failure;
>  		} else {
> -			struct net_device *physindev;
> +			int physinif;
>  
>  			/* Case 2: indev is bridge group, we need to look for
>  			 * physical device (when called from ipv4) */
> @@ -516,10 +516,10 @@ __build_packet_message(struct nfnl_log_net *log,
>  					 htonl(indev->ifindex)))
>  				goto nla_put_failure;
>  
> -			physindev = nf_bridge_get_physindev(skb);
> -			if (physindev &&
> +			physinif = nf_bridge_get_physinif(skb);
> +			if (physinif &&
>  			    nla_put_be32(inst->skb, NFULA_IFINDEX_PHYSINDEV,
> -					 htonl(physindev->ifindex)))
> +					 htonl(physinif)))

I think you can drop this patch and make the last patch pass
nf_bridge_info->physinif directly.

