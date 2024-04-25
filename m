Return-Path: <linux-kernel+bounces-158968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698E28B2780
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DECB263EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472B14E2FA;
	Thu, 25 Apr 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="QcLsvY2v"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FA1E864;
	Thu, 25 Apr 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065559; cv=none; b=KIUnJz3OTHBr09MPxxxMLb7W/J4hocF292EtjlfG2FBt00FzAOmhpVTb1+D3M1OV1fbTpveLWSk6bVipliPnDBIYPWvZh49UjW3f985p5onNcyPEXsd633MuJXpvS9QGyvT38kAGjjKEcyC1pHXHMHZNcMVWVd8NhWwg/yU8ulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065559; c=relaxed/simple;
	bh=jnjSDnMCXOOxXg1UUOieAbeuHVRhOq6Wkd+/w6HJWqU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UR5sHkNlpBj2bQYJKCR1LFHd70ppuLo56JwiJ6ktQYNETeKCNpxw5BjJme70kXNx3FdJ8FrMQ4PD8Ou8Mh7iPr0qTOoafuip6fseXtcDmh8i+A88n7T9KnbgwA1A59VJnsUJJBI64OTuo9RpBXB0lRz+wUF6bBkDtuk0Dlj9ZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=QcLsvY2v; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 85C531C1D8;
	Thu, 25 Apr 2024 20:19:07 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Thu, 25 Apr 2024 20:19:06 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id AE8F69003B8;
	Thu, 25 Apr 2024 20:19:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1714065544; bh=jnjSDnMCXOOxXg1UUOieAbeuHVRhOq6Wkd+/w6HJWqU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QcLsvY2vZ2mub1fhRo833PU26s1e3aScte8h6eE4C1k8SGNEbhSrMe761iPPOHKGv
	 euJYUo1Igk9FPCTwPEmxjmN0Kvung3mT37ZRu79Am/wi/yJ1RFLITZl7ShgVr+0VFF
	 vO3BzLL5Y7qynkCYZjIRvn0EjjMY3FeYyJusz91A=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43PHItdp113003;
	Thu, 25 Apr 2024 20:18:56 +0300
Date: Thu, 25 Apr 2024 20:18:55 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Ismael Luceno <iluceno@suse.de>
cc: linux-kernel@vger.kernel.org, Firo Yang <firo.yang@suse.com>,
        Andreas Taschner <andreas.taschner@suse.com>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.com>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        coreteam@netfilter.org
Subject: Re: [PATCH v3] ipvs: Fix checksumming on GSO of SCTP packets
In-Reply-To: <20240425162842.23900-1-iluceno@suse.de>
Message-ID: <41e7f590-9ff1-da7d-a1a2-1b6e5508f4f1@ssi.bg>
References: <20240425162842.23900-1-iluceno@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-2035234302-1714065536=:89087"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-2035234302-1714065536=:89087
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Thu, 25 Apr 2024, Ismael Luceno wrote:

> It was observed in the wild that pairs of consecutive packets would leave
> the IPVS with the same wrong checksum, and the issue only went away when
> disabling GSO.
> 
> IPVS needs to avoid computing the SCTP checksum when using GSO.
> 
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
>     Changes since v2:
>     * Use only skb_is_gso, no need to check for GSO type

	v2 is already applied. I acked it because sctp_gso_segment()
checks for skb_is_gso_sctp(). If v3 is just an optimization
better to live with v2? Is it possible to see skb_is_gso() but
not skb_is_gso_sctp() while working with SCTP packet?

>     Changes since v1:
>     * Added skb_is_gso before skb_is_gso_sctp.
>     * Added "Fixes" tag.
> 
>  net/netfilter/ipvs/ip_vs_proto_sctp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> index a0921adc31a9..83e452916403 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> @@ -126,7 +126,8 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	if (sctph->source != cp->vport || payload_csum ||
>  	    skb->ip_summed == CHECKSUM_PARTIAL) {
>  		sctph->source = cp->vport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
> @@ -174,7 +175,8 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	    (skb->ip_summed == CHECKSUM_PARTIAL &&
>  	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
>  		sctph->dest = cp->dport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
> -- 
> 2.43.0

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-2035234302-1714065536=:89087--


