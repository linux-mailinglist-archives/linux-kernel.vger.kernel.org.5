Return-Path: <linux-kernel+bounces-157781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CE8B161F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D459C1F216E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9616D9DE;
	Wed, 24 Apr 2024 22:21:32 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906D16D4CA;
	Wed, 24 Apr 2024 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997291; cv=none; b=IEjKb2SUrk7WZ+2v/qpN6sxHf2hL0hUE5+hOBVmtmhNHm8Q+VdJNU2BhCHOGzdNEWkfu/EhZv2RS9+icc5LCvBB3NSoussY4cBNQ7kk8CezK6COiYW/BNizbJSTUrya2aHjvOmB0SdCo83RhPWi5c19pykKq3Dd5+FfrtC9FbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997291; c=relaxed/simple;
	bh=e7ZeaCF9fOPOeOCdD6PM03PAZj7zzEABjm4s98O48vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuoVWICTVIjRplK131tNTRFy3pTqc5nVV4K7ugjbymZqjnnfCQkQNNalinfScEcpFsfPbAmN3YDfsUSW5hR7QHeoK54fDCk1Svkn3c1pEc02PMvsU66Kn+nAfMy0qzsfzaJpNJkXjpxIyrgv6NFehJnD9GWsAKzSx35fahtc7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 25 Apr 2024 00:21:26 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ismael Luceno <iluceno@suse.de>
Cc: linux-kernel@vger.kernel.org, Firo Yang <firo.yang@suse.com>,
	Andreas Taschner <andreas.taschner@suse.com>,
	Michal =?utf-8?Q?Kube=C4=8Dek?= <mkubecek@suse.com>,
	Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH v2] ipvs: Fix checksumming on GSO of SCTP packets
Message-ID: <ZimF5pntTWWcwq-r@calendula>
References: <20240421142234.15764-1-iluceno@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240421142234.15764-1-iluceno@suse.de>

On Sun, Apr 21, 2024 at 04:22:32PM +0200, Ismael Luceno wrote:
> It was observed in the wild that pairs of consecutive packets would leave
> the IPVS with the same wrong checksum, and the issue only went away when
> disabling GSO.
> 
> IPVS needs to avoid computing the SCTP checksum when using GSO.

I am placing this into the nf.git tree for submission upstream in the
next pull request, unless stated otherwise.

Thanks.

> Fixes: 90017accff61 ("sctp: Add GSO support", 2016-06-02)
> Co-developed-by: Firo Yang <firo.yang@suse.com>
> Signed-off-by: Ismael Luceno <iluceno@suse.de>
> Tested-by: Andreas Taschner <andreas.taschner@suse.com>
> CC: Michal Kubeček <mkubecek@suse.com>
> CC: Simon Horman <horms@verge.net.au>
> CC: Julian Anastasov <ja@ssi.bg>
> CC: lvs-devel@vger.kernel.org
> CC: netfilter-devel@vger.kernel.org
> CC: netdev@vger.kernel.org
> CC: coreteam@netfilter.org
> ---
> 
> Notes:
>     Changes since v1:
>     * Added skb_is_gso before skb_is_gso_sctp.
>     * Added "Fixes" tag.
> 
>  net/netfilter/ipvs/ip_vs_proto_sctp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> index a0921adc31a9..1e689c714127 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> @@ -126,7 +126,8 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	if (sctph->source != cp->vport || payload_csum ||
>  	    skb->ip_summed == CHECKSUM_PARTIAL) {
>  		sctph->source = cp->vport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
> @@ -174,7 +175,8 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	    (skb->ip_summed == CHECKSUM_PARTIAL &&
>  	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
>  		sctph->dest = cp->dport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
> -- 
> 2.43.0
> 
> 

