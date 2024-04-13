Return-Path: <linux-kernel+bounces-143803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E028A3DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5BF1C209E3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91514CB2E;
	Sat, 13 Apr 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoxqaL7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE504D9F4;
	Sat, 13 Apr 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713024898; cv=none; b=Wr99eAF7IbVxZw5PS3D421nJvhqZy1gqbpGSdqh8Ek3JLB94Id1vlFJnc57W6+dYsjaiugA/YnHFks0kxQU+AvYw3H+IvHg/ubWHukxIHDIhUzv0H0RmmiGy+izTD3u96TjOGu6fLHMduAoCjSbxJHq7pBUrprfssiHdqCsgXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713024898; c=relaxed/simple;
	bh=rACH4h0q/gLqvy6sOfXp3B7RvEQ9zv1cEYzOwBCoKTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPvIiZamFyohIwljukbPvU9y+a95hLF87qdR0F+MnyQgkNDc3OprMoWNchwnFsGNob6alVVIL2wpksNbd3MxmbEYezZ0KTIUslc0m7tdhXtnvS8Ici/MPtzTGt0GEmsw2fbg4Ipfed1cUjoIbnA4HFtOn7y4TLhmqPejhVXhU40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoxqaL7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9F3C113CD;
	Sat, 13 Apr 2024 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713024897;
	bh=rACH4h0q/gLqvy6sOfXp3B7RvEQ9zv1cEYzOwBCoKTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoxqaL7xcOmM7kD8ONQ9B+JkGE9qhTMTuIeAbJofmSiPezG+yqcY18CLoCEd46obc
	 n3ax4TXEHlBmNWXOO49CHX5RDKkrCXyYly/snPELH6aGTO26i1UsHXMCd4BUw2sBtm
	 5xKyPbBrHllzjRvVCcEDJFhdck/waE5cjg/lcgbbwxeHKP6sAXEXIS1dY4A7dzyTi/
	 QPjBiE2BymtZXWBbCkNIFBNaoHn6lxoIX/EnFOExgaB60c64T9arS4xtnharStrT2+
	 jv6U9/3/grvRRVLs3kCy+zhA9aVjZy7moF1NyVaF+e/uNnXJMB/7r1bVrO77X1Nn96
	 kRvOb1Fruaj9Q==
Date: Sat, 13 Apr 2024 17:13:19 +0100
From: Simon Horman <horms@kernel.org>
To: xu.xin16@zte.com.cn
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, dsahern@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org, yang.yang29@zte.com.cn,
	he.peilin@zte.com.cn, liu.chun2@zte.com.cn, jiang.xuexin@zte.com.cn,
	zhang.yunkai@zte.com.cn, kerneljasonxing@gmail.com,
	fan.yu9@zte.com.cn, qiu.yutan@zte.com.cn
Subject: Re: [PATCH net-next v5] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240413161319.GA853376@kernel.org>
References: <20240411180154691lpBFKqpsU4tf1vugPPIqq@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411180154691lpBFKqpsU4tf1vugPPIqq@zte.com.cn>

On Thu, Apr 11, 2024 at 06:01:54PM +0800, xu.xin16@zte.com.cn wrote:
> From: hepeilin <he.peilin@zte.com.cn>

nit: it's nicer if this From line matches one of the Signed-off-by lines

     From: Peilin He <he.peilin@zte.com.cn>


> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.
> 
> 1. Giving an usecase example:
> =============================
> When an application experiences packet loss due to an unreachable UDP
> destination port, the kernel will send an exception message through the
> icmp_send function. By adding a trace point for icmp_send, developers or
> system administrators can obtain detailed information about the UDP
> packet loss, including the type, code, source address, destination address,
> source port, and destination port. This facilitates the trouble-shooting
> of UDP packet loss issues especially for those network-service
> applications.
> 
> 2. Operation Instructions:
> ==========================
> Switch to the tracing directory.
>         cd /sys/kernel/tracing
> Filter for destination port unreachable.
>         echo "type==3 && code==3" > events/icmp/icmp_send/filter
> Enable trace event.
>         echo 1 > events/icmp/icmp_send/enable
> 
> 3. Result View:
> ================
>  udp_client_erro-11370   [002] ...s.12   124.728002:
>  icmp_send: icmp_send: type=3, code=3.
>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=23
>  skbaddr=00000000589b167a
> 
> v4->v5:
> Some fixes according to
> https://lore.kernel.org/all/CAL+tcoDeXXh+zcRk4PHnUk8ELnx=CE2pcCqs7sFm0y9aK-Eehg@mail.gmail.com/
> 1.Adjust the position of trace_icmp_send() to before icmp_push_reply().
> 
> v3->v4:
> Some fixes according to
> https://lore.kernel.org/all/CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJzBzkJFVgCTdXBx=YBg@mail.gmail.com/
> 1.Add legality check for UDP header in SKB.
> 2.Target this patch for net-next.
> 
> Changelog
> ========
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
> 1. Change the tracking directory to/sys/kernel/tracking.
> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
> 
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com/
> 1. adjust the trace_icmp_send() to more protocols than UDP.
> 2. move the calling of trace_icmp_send after sanity checks
> in __icmp_send().
> 
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>

nit: There should be a space between 'He' and '<'

> Reviewed-by: xu xin <xu.xin16@zte.com.cn>

This has been posted by xu xin, thus it is appropriate for
a Signed-off-by line from xu xin to be present.

> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>

Hi,

Unfortunately this patch does not apply to next-next.
Please rebase and repost after waiting a suitable time for
other review.

-- 
pw-bot: changes-requested

> ---
>  include/trace/events/icmp.h | 65 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 69 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
> 
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000..7d5190f48
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,65 @@
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
> +			__field(const void *, skbaddr)
> +			__field(int, type)
> +			__field(int, code)
> +			__array(__u8, saddr, 4)
> +			__array(__u8, daddr, 4)
> +			__field(__u16, sport)
> +			__field(__u16, dport)
> +			__field(unsigned short, ulen)
> +		),
> +
> +		TP_fast_assign(
> +			struct iphdr *iph = ip_hdr(skb);
> +			int proto_4 = iph->protocol;
> +			__be32 *p32;
> +
> +			__entry->skbaddr = skb;
> +			__entry->type = type;
> +			__entry->code = code;
> +
> +			struct udphdr *uh = udp_hdr(skb);
> +			if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
> +				(u8 *)uh + sizeof(struct udphdr) > skb_tail_pointer(skb)) {
> +				__entry->sport = 0;
> +				__entry->dport = 0;
> +				__entry->ulen = 0;
> +			} else {
> +				__entry->sport = ntohs(uh->source);
> +				__entry->dport = ntohs(uh->dest);
> +				__entry->ulen = ntohs(uh->len);
> +			}
> +
> +			p32 = (__be32 *) __entry->saddr;
> +			*p32 = iph->saddr;
> +
> +			p32 = (__be32 *) __entry->daddr;
> +			*p32 = iph->daddr;
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
> \ No newline at end of file
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index b71b836cc..2081fee18 100644
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
> @@ -766,6 +768,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  	if (!fl4.saddr)
>  		fl4.saddr = htonl(INADDR_DUMMY);
> 
> +	trace_icmp_send(skb_in, type, code);
> +
>  	icmp_push_reply(&icmp_param, &fl4, &ipc, &rt);
>  ende:
>  	ip_rt_put(rt);
> -- 
> 2.17.1
> 

