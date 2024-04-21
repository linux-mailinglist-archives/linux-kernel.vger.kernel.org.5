Return-Path: <linux-kernel+bounces-152473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8678ABEFD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7FF1F210F8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73DD111A2;
	Sun, 21 Apr 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="Frm2YIm8"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BDCFBEF;
	Sun, 21 Apr 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713697309; cv=none; b=ntc6D1oP6kmKQoMQpsI8S+11seHdmM+Em8i3pwT/ERQpPpPSnjZhygiUcvf/ed4RV/epFm3VTx8YuyiU/2hg8rZOEqBVP2KuAvvdacK1IbZsGiOqY0JCl7AVuV742XTdKRgE7ZXckcju0XoyJeLBHmB75dcB+9tTROyHig92dko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713697309; c=relaxed/simple;
	bh=1FeIcTYwAU1S0raUDq2BITNq18igT++vQ66L7gX7ud4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ibZpf+cm+2ZcgILUw82kiW7CEuh4p2xFK/BCSxY2q7mBlXXq74MiKdQmTbC61g4VD6Gr+raBWnMpcBPx7HdwgxKxlerXDLlMEMvpeP4Uth+I5egn/uPNDvKAO7PXHon69N6BEt9BzDAig9s2pZm76Luq52mLPW285U5G/ONeyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=Frm2YIm8; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 537FF2258B;
	Sun, 21 Apr 2024 14:01:36 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Sun, 21 Apr 2024 14:01:35 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 5300F9003A3;
	Sun, 21 Apr 2024 14:01:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1713697291; bh=1FeIcTYwAU1S0raUDq2BITNq18igT++vQ66L7gX7ud4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Frm2YIm8I/YQvMO+QzP1ECvaKyBoTFzjUIU7sR6SQU33/ae0QqMYEYMmPKf4c7AAG
	 suYC40PeFdZOjXjIa5IhAHOBhGDnXwbfVGhOvYAMoSNS44YyjYltiO6ENb/VBkSlj7
	 9bx0yMW/7/CP+HoWafAU4C2yyTgShFKvo5dCz+aY=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43LB1L8h034296;
	Sun, 21 Apr 2024 14:01:22 +0300
Date: Sun, 21 Apr 2024 14:01:21 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Ismael Luceno <iluceno@suse.de>
cc: linux-kernel@vger.kernel.org, Firo Yang <firo.yang@suse.com>,
        Andreas Taschner <andreas.taschner@suse.com>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.com>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: Fix checksumming on GSO of SCTP packets
In-Reply-To: <20240418144434.16407-1-iluceno@suse.de>
Message-ID: <fd234180-4d6f-313a-0edd-13c821bd4423@ssi.bg>
References: <20240418144434.16407-1-iluceno@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-1861435800-1713697283=:3044"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-1861435800-1713697283=:3044
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Thu, 18 Apr 2024, Ismael Luceno wrote:

> It was observed in the wild that pairs of consecutive packets would leave
> the IPVS with the same wrong checksum, and the issue only went away when
> disabling GSO.
> 
> IPVS needs to avoid computing the SCTP checksum when using GSO.
> 
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

	Thanks for the fix, I'll accept this but skb_is_gso_sctp()
has comment for pre-condition: skb_is_gso(skb). Can you send v2
with it?

	I'm guessing what should be the Fixes line, may be?:

Fixes: 90017accff61 ("sctp: Add GSO support")

	because SCTP GSO was added after the IPVS code? Or the
more recent commit d02f51cbcf12 which adds skb_is_gso_sctp ?

> ---
>  net/netfilter/ipvs/ip_vs_proto_sctp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> index a0921adc31a9..3205b45ce161 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
> @@ -126,7 +126,8 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	if (sctph->source != cp->vport || payload_csum ||
>  	    skb->ip_summed == CHECKSUM_PARTIAL) {
>  		sctph->source = cp->vport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso_sctp(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
> @@ -174,7 +175,8 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
>  	    (skb->ip_summed == CHECKSUM_PARTIAL &&
>  	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
>  		sctph->dest = cp->dport;
> -		sctp_nat_csum(skb, sctph, sctphoff);
> +		if (!skb_is_gso_sctp(skb))
> +			sctp_nat_csum(skb, sctph, sctphoff);
>  	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-1861435800-1713697283=:3044--


