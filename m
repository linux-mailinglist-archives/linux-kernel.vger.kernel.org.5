Return-Path: <linux-kernel+bounces-27305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA0782ED91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBF6285981
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FE31B80C;
	Tue, 16 Jan 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="wnFGUlym"
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74C1B7F2;
	Tue, 16 Jan 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTP id B7F1424587;
	Tue, 16 Jan 2024 13:12:04 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 9D4CE24583;
	Tue, 16 Jan 2024 13:12:04 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 413883C043D;
	Tue, 16 Jan 2024 13:11:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1705403520; bh=UxqN8goLJo6H6a7nMjf8r0aorH2j0H/0oPA9ij7vGs8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=wnFGUlymIz1ag50Nx7oh8FaocUejgNj/GfPnORiHfTvVAwGn2G8y+kBE1JnNnpmtT
	 iY5ALZ8AHHmg63lIQOHsfp/f6Rf5e7bUeXsixbVP917ZXCUnTEoObTYuxl0ntcUNnK
	 UJIsB5lHZJhvSC2feK1i5LAxAwtfTNSW1G7tgMrE=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 40GBBn3L041664;
	Tue, 16 Jan 2024 13:11:50 +0200
Date: Tue, 16 Jan 2024 13:11:49 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Fedor Pchelkin <pchelkin@ispras.ru>
cc: Simon Horman <horms@verge.net.au>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dwip Banerjee <dwip@linux.vnet.ibm.com>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: ipvs: avoid stat macros calls from preemptible
 context
In-Reply-To: <20240115143923.31243-1-pchelkin@ispras.ru>
Message-ID: <3964ec81-c8d2-c4c6-8ca8-2e2b50dc4240@ssi.bg>
References: <20240115143923.31243-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Mon, 15 Jan 2024, Fedor Pchelkin wrote:

> Inside decrement_ttl() upon discovering that the packet ttl has exceeded,
> __IP_INC_STATS and __IP6_INC_STATS macros can be called from preemptible
> context having the following backtrace:
> 
> check_preemption_disabled: 48 callbacks suppressed
> BUG: using __this_cpu_add() in preemptible [00000000] code: curl/1177
> caller is decrement_ttl+0x217/0x830
> CPU: 5 PID: 1177 Comm: curl Not tainted 6.7.0+ #34
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xbd/0xe0
>  check_preemption_disabled+0xd1/0xe0
>  decrement_ttl+0x217/0x830
>  __ip_vs_get_out_rt+0x4e0/0x1ef0
>  ip_vs_nat_xmit+0x205/0xcd0
>  ip_vs_in_hook+0x9b1/0x26a0
>  nf_hook_slow+0xc2/0x210
>  nf_hook+0x1fb/0x770
>  __ip_local_out+0x33b/0x640
>  ip_local_out+0x2a/0x490
>  __ip_queue_xmit+0x990/0x1d10
>  __tcp_transmit_skb+0x288b/0x3d10
>  tcp_connect+0x3466/0x5180
>  tcp_v4_connect+0x1535/0x1bb0
>  __inet_stream_connect+0x40d/0x1040
>  inet_stream_connect+0x57/0xa0
>  __sys_connect_file+0x162/0x1a0
>  __sys_connect+0x137/0x160
>  __x64_sys_connect+0x72/0xb0
>  do_syscall_64+0x6f/0x140
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x7fe6dbbc34e0
> 
> Use the corresponding preemption-aware variants: IP_INC_STATS and
> IP6_INC_STATS.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 8d8e20e2d7bb ("ipvs: Decrement ttl")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
>  net/netfilter/ipvs/ip_vs_xmit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
> index 9193e109e6b3..65e0259178da 100644
> --- a/net/netfilter/ipvs/ip_vs_xmit.c
> +++ b/net/netfilter/ipvs/ip_vs_xmit.c
> @@ -271,7 +271,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
>  			skb->dev = dst->dev;
>  			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
>  				    ICMPV6_EXC_HOPLIMIT, 0);
> -			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
> +			IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>  
>  			return false;
>  		}
> @@ -286,7 +286,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
>  	{
>  		if (ip_hdr(skb)->ttl <= 1) {
>  			/* Tell the sender its packet died... */
> -			__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
> +			IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
>  			icmp_send(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
>  			return false;
>  		}
> -- 
> 2.43.0

Regards

--
Julian Anastasov <ja@ssi.bg>


