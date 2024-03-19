Return-Path: <linux-kernel+bounces-107638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B735987FF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7AA1C22C53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904F81AAD;
	Tue, 19 Mar 2024 14:23:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323781721;
	Tue, 19 Mar 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858209; cv=none; b=LvcdfSr1RAkE+AIAQUYt9AlFe0XgZ8/vZljYLkjYlYVEBIErjcYd74bX+QDB9fldcKTNrsyYwfg+8U5gC6Wtan0ZuiWOO6Grc27uIJVcCpFJeOQNrDDaF7GN4pZmALrd5oFLA0X0Yo7aD8T3doiGH5H9cpuNpBVudikIOidCI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858209; c=relaxed/simple;
	bh=Xmo2x6S5V7/NQhmCgDANew9z2mao2c7yl6NKCnwOGZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/uNy1GdFLg3+OtSXbWFjS9cKGADb9IGFbuaygI17fte583yxAPgi09+wYdf5xWApbnXIoxerKxZ67oTEcGGGjofVULyLe1CoxX6wDmcpABmQf9Ves1dI3AshOsmXrAg+74JtejgENMqfIZTB2wASVZ0zgcZqtUxmdbtn4ApY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7976FC433F1;
	Tue, 19 Mar 2024 14:23:27 +0000 (UTC)
Date: Tue, 19 Mar 2024 10:25:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <xu.xin16@zte.com.cn>
Cc: <edumazet@google.com>, <davem@davemloft.net>, <mhiramat@kernel.org>,
 <dsahern@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <yang.yang29@zte.com.cn>, <he.peilin@zte.com.cn>, <liu.chun2@zte.com.cn>,
 <jiang.xuexin@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH v2] net/ipv4: add tracepoint for icmp_send
Message-ID: <20240319102549.7f7f6f53@gandalf.local.home>
In-Reply-To: <202403192013525995034@zte.com.cn>
References: <202403192013525995034@zte.com.cn>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 20:13:52 +0800 (CST)
<xu.xin16@zte.com.cn> wrote:

> From: Peilin He<he.peilin@zte.com.cn>
> 
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
>         cd /sys/kernel/debug/tracing

FYI, that directory is obsolete. Please always reference /sys/kernel/tracing.

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
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com/
> 	1. adjust the trace_icmp_send() to more protocols than UDP.
> 	2. move the calling of trace_icmp_send after sanity checks
> 	   in __icmp_send().
> 
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---
>  include/trace/events/icmp.h | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 68 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
> 
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..c3dc337be7bc
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,64 @@
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
> +			__field(__u16, sport)
> +			__field(__u16, dport)
> +			__field(int, type)
> +			__field(int, code)
> +			__array(__u8, saddr, 4)
> +			__array(__u8, daddr, 4)
> +                	__field(const void *, skbaddr)
> +			__field(unsigned short, ulen)

Note, to prevent holes, I usually suggest pointers and longs go first,
followed by ints, and then end with char.

                	__field(const void *, skbaddr)
			__field(int, type)
			__field(int, code)
			__array(__u8, saddr, 4)
			__array(__u8, daddr, 4)
			__field(__u16, sport)
			__field(__u16, dport)
			__field(unsigned short, ulen)

-- Steve


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
> +			if (proto_4 == IPPROTO_UDP) {
> +				struct udphdr *uh = udp_hdr(skb);
> +				__entry->sport = ntohs(uh->source);
> +				__entry->dport = ntohs(uh->dest);
> +				__entry->ulen = ntohs(uh->len);
> +			} else {
> +				__entry->sport = 0;
> +				__entry->dport = 0;
> +				__entry->ulen = 0;
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
> index e63a3bf99617..21fb41257fe9 100644
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
> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  		}
>  	}
> 
> +	trace_icmp_send(skb_in, type, code);
> +
>  	/* Needed by both icmp_global_allow and icmp_xmit_lock */
>  	local_bh_disable();
> 


