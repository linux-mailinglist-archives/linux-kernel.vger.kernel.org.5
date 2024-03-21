Return-Path: <linux-kernel+bounces-110670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F9A886218
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246D51C21D97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB62135A44;
	Thu, 21 Mar 2024 20:52:42 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710BE134420;
	Thu, 21 Mar 2024 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054361; cv=none; b=dQYumnxS9263jc0N3cyn3UZc9UMQalUJotQ2nccMixqP7PZzTDjGt5ggPCjAbxAXChYfwg2N9TEA5gaE6UtrmgqcBNR3VLB/FgSJeabFuyW25DXWMXkcGTEDuZBWApfVwt5N/aaVHF1Gbvg5Y+36ES6Q4o5DWswoABC8Q9rhWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054361; c=relaxed/simple;
	bh=9zlC3L4tt8Mzkzt3jkTnHSaQIRdB72fowZOWPPC5Zko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfu4ALOekNJrxhTu/C156bMlqNqD90qTGYqQ7DhJpPIrhDr0AQguFAdmKDdg7tYQMpqKOoPBIwFy70qAoJhD7knSdLkhuDDvG/F0vMHGTVl5l5wVuHuvvx+IyR2VxFK1Fe58rBTlchB/artoGfzUSpVp5hio6kqNhOjQKi3MfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 21 Mar 2024 21:52:27 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dietmar Maurer <dietmar@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>,
	Wolfgang Bumiller <w.bumiller@proxmox.com>,
	Alexandre Derumier <aderumier@odiso.com>
Subject: Re: [PATCH net] netfilter: conntrack: fix ct-state for ICMPv6
 Multicast Router Discovery
Message-ID: <ZfyeC8mjLnGkqnVT@calendula>
References: <20240306141805.17679-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306141805.17679-1-linus.luessing@c0d3.blue>

On Wed, Mar 06, 2024 at 03:18:04PM +0100, Linus Lüssing wrote:
> So far Multicast Router Advertisements and Multicast Router
> Solicitations from the Multicast Router Discovery protocol (RFC4286)
> would be marked as INVALID for IPv6, even if they are in fact intact
> and adhering to RFC4286.

There is also RFC4890 which specifies that also acts as multicast
routers need to process these message on their interfaces.

> This broke MRA reception and by that multicast reception on
> IPv6 multicast routers in a Proxmox managed setup, where Proxmox
> would install a rule like "-m conntrack --ctstate INVALID -j DROP"
> at the top of the FORWARD chain with br-nf-call-ip6tables enabled
> by default.
> 
> Similar to as it's done for MLDv1, MLDv2 and IPv6 Neighbor Discovery
> already, fix this issue by excluding MRD from connection tracking
> handling as MRD always uses predefined multicast destinations
> for its messages, too. This changes the ct-state for ICMPv6 MRD messages
> from INVALID to UNTRACKED.

An explicit rule will be still needed to accept this traffic, assuming
default policy to drop. I think that the issue is likely that this
"drop invalid rules" is the at the very beginning of the ruleset.

Anyway, turning this from invalid to untracked seems sensible to me.
Users will still have to explicitly allow for this in their ruleset
assuming default policy to drop.

I am going to include your Fixes: tag and pass up this patch upstream.

Thanks.

> This issue was found and fixed with the help of the mrdisc tool
> (https://github.com/troglobit/mrdisc).
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/icmpv6.h               | 1 +
>  net/netfilter/nf_conntrack_proto_icmpv6.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/icmpv6.h b/include/uapi/linux/icmpv6.h
> index ecaece3af38d..4eaab89e2856 100644
> --- a/include/uapi/linux/icmpv6.h
> +++ b/include/uapi/linux/icmpv6.h
> @@ -112,6 +112,7 @@ struct icmp6hdr {
>  #define ICMPV6_MOBILE_PREFIX_ADV	147
>  
>  #define ICMPV6_MRDISC_ADV		151
> +#define ICMPV6_MRDISC_SOL		152
>  
>  #define ICMPV6_MSG_MAX          255
>  
> diff --git a/net/netfilter/nf_conntrack_proto_icmpv6.c b/net/netfilter/nf_conntrack_proto_icmpv6.c
> index 1020d67600a9..327b8059025d 100644
> --- a/net/netfilter/nf_conntrack_proto_icmpv6.c
> +++ b/net/netfilter/nf_conntrack_proto_icmpv6.c
> @@ -62,7 +62,9 @@ static const u_int8_t noct_valid_new[] = {
>  	[NDISC_ROUTER_ADVERTISEMENT - 130] = 1,
>  	[NDISC_NEIGHBOUR_SOLICITATION - 130] = 1,
>  	[NDISC_NEIGHBOUR_ADVERTISEMENT - 130] = 1,
> -	[ICMPV6_MLD2_REPORT - 130] = 1
> +	[ICMPV6_MLD2_REPORT - 130] = 1,
> +	[ICMPV6_MRDISC_ADV - 130] = 1,
> +	[ICMPV6_MRDISC_SOL - 130] = 1
>  };
>  
>  bool nf_conntrack_invert_icmpv6_tuple(struct nf_conntrack_tuple *tuple,
> -- 
> 2.43.0
> 

