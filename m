Return-Path: <linux-kernel+bounces-83368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098278695C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B67C1C22A22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29C145327;
	Tue, 27 Feb 2024 14:05:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ACA13B2BA;
	Tue, 27 Feb 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042705; cv=none; b=PVSqughDCpNWRdfbg2m6OFXqB0H3EIflKNcTM9hShzqDUQBDsHW//HF9inNVl9CygE+zn5tBTGCkq5bRnIGPDB+bgsyD/FIEN6SzKwxVRpJfKc08LnzB4wP/NQYpBm8HBVb3p3YNwq+Cuylsjh5sZjQ0SDPOib/cxEbzoVWW65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042705; c=relaxed/simple;
	bh=35GpseE5cIbySIWv/O/c8vhnBYQWjwpsy9ZTCo11obQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jC5iJKZS1t6tu/yIMe/o6AFFdWwW7M7SH8scWG6KDKjFDSZtAnlcJnhWgNdE7hd22Vlr8v1823Z98vXKszIqUbbabI0onOaoCTlizVLhuS6UxKoLNNA9ReOMm5uJ6qxsw5QFKvh/JXRjFBvGo9igngdC0mvyJKbin6bTO7YU4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B4DC433F1;
	Tue, 27 Feb 2024 14:05:03 +0000 (UTC)
Date: Tue, 27 Feb 2024 09:07:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: <xu.xin16@zte.com.cn>
Cc: <davem@davemloft.net>, <mhiramat@kernel.org>, <dsahern@kernel.org>,
 <edumazet@google.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <yang.yang29@zte.com.cn>, <he.peilin@zte.com.cn>, <liu.chun2@zte.com.cn>,
 <jiang.xuexin@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240227090705.1ed08b64@gandalf.local.home>
In-Reply-To: <202402271050366715988@zte.com.cn>
References: <202402271050366715988@zte.com.cn>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 10:50:36 +0800 (CST)
<xu.xin16@zte.com.cn> wrote:

>  include/trace/events/icmp.h | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 ++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
> 
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..3d9af5769bc3
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM icmp
> +
> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ICMP_H
> +
> +#include <linux/icmp.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(icmp_send,
> +
> +		TP_PROTO(const struct sk_buff *skb, int type, int code),
> +
> +		TP_ARGS(skb, type, code),
> +
> +		TP_STRUCT__entry(
> +				__field(__u16, sport)

2 bytes

> +				__field(__u16, dport)

2 bytes

> +				__field(unsigned short, ulen)

2 bytes

[ 2 byte hole for alignment ]

> +				__field(const void *, skbaddr)

4/8 bytes

It's best to keep the holes at the end of the TP_STRUCT__entry().

That is, I would move ulen to the end of the structure. It doesn't affect
anything else.

-- Steve

> +				__field(int, type)
> +				__field(int, code)
> +				__array(__u8, saddr, 4)
> +				__array(__u8, daddr, 4)
> +		),
> +
> +		TP_fast_assign(
> +				// Get UDP header
> +				struct udphdr *uh = udp_hdr(skb);
> +				struct iphdr *iph = ip_hdr(skb);
> +				__be32 *p32;
> +
> +				__entry->sport = ntohs(uh->source);
> +				__entry->dport = ntohs(uh->dest);
> +				__entry->ulen = ntohs(uh->len);
> +				__entry->skbaddr = skb;
> +				__entry->type = type;
> +				__entry->code = code;
> +
> +				p32 = (__be32 *) __entry->saddr;
> +				*p32 = iph->saddr;
> +
> +				p32 = (__be32 *) __entry->daddr;
> +				*p32 =  iph->daddr;
> +		),
> +
> +		TP_printk("icmp_send: type=%d, code=%d. From %pI4:%u to %pI4:%u ulen=%d skbaddr=%p",
> +			__entry->type, __entry->code,
> +			__entry->saddr, __entry->sport, __entry->daddr,
> +			__entry->dport, __entry->ulen, __entry->skbaddr)
> +);
> +
> +#endif /* _TRACE_ICMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e63a3bf99617..437bdb7e2650 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -92,6 +92,8 @@
>  #include <net/inet_common.h>
>  #include <net/ip_fib.h>
>  #include <net/l3mdev.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/icmp.h>
> 
>  /*
>   *	Build xmit assembly blocks
> @@ -599,6 +601,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  	struct net *net;
>  	struct sock *sk;
> 
> +	trace_icmp_send(skb_in, type, code);
> +
>  	if (!rt)
>  		goto out;
> 


