Return-Path: <linux-kernel+bounces-116511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431C88A013
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137BB1F39968
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8170170CB4;
	Mon, 25 Mar 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dXtWnxiT"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD8E6EB40;
	Mon, 25 Mar 2024 04:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339510; cv=none; b=ZfUmkn9rxt9JztKaIWtMhWFKfEeyEUhzyisVmPrYgDjVV2DvOXZpHdWrohG0sybOOoh94OtGImoEatWXvKJNm/jhLgxjkVAWrwAXWH65LB9TxpxWKD2ViUoSFhUf4S7phMeU4nnABwo/rnO/BiwcSD79ErZoeOd6csH7Yuirztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339510; c=relaxed/simple;
	bh=rgwIpB0WPqzeg+xu8gCr5ED6nFgEZ11bQhARANcvMyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFo4ZayJZXhIbaSFylzQsKnTMBf+RAuwr2WJyv+x6mY4Qz6OW32qyVOOGbdb0v7rz+8roZt4QMFDPv/NnWoApHtxLgcRJh/Ha6vyuzagG3VKRVasmBabhdznPaLwbZXJ4JP8VcfiUA0Ar3HMviv9kmG0TNn2fgi5KDPcHyKXy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dXtWnxiT; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gIh4l
	B0xITLrabRKSwTrKCIpHwQ83Dk2koTT84qc7og=; b=dXtWnxiTmR9fkp/pVgNQg
	Vnl12TeBTNhwO3SNbSCYVJ7a1eIt7h58ds0WFO9cVojyxUPTF8vES3QS7SXoNdB6
	Tia4oVCqMq6osmMD7NUql/YiGen9/WWfrWGMZOtoMd0BErkomiXhOvRjd7gi6Sry
	noAfqOE6EKd0qINdgCyC2U=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3v7nN9wBmtFqfBw--.51546S2;
	Mon, 25 Mar 2024 12:04:31 +0800 (CST)
From: Peilin He <peilinhe2020@163.com>
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	he.peilin@zte.com.cn,
	jiang.xuexin@zte.com.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liu.chun2@zte.com.cn,
	mhiramat@kernel.org,
	netdev@vger.kernel.org,
	rostedt@goodmis.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: Re: [PATCH v3 resend] net/ipv4: add tracepoint for icmp_send
Date: Mon, 25 Mar 2024 04:04:29 +0000
Message-Id: <20240325040429.3776225-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL+tcoDT01EL7g_73Whrz753oEBuRtBrfmo2PHvTdifXKP4fhQ@mail.gmail.com>
References: <CAL+tcoDT01EL7g_73Whrz753oEBuRtBrfmo2PHvTdifXKP4fhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7nN9wBmtFqfBw--.51546S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryDuw1kJr1xXF1UGw18uFg_yoW7GFy7pF
	1DAFn5Grn7tr47u34fZw4aqFn3X3yruryUKr4jgw1Ykwn2vr1xtrWvgrn09FykZrs0kryS
	vF1jv3s8G3WYqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwmiiUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiYxSssWV4HUoocQAAs5

>> ---------
>> v2->v3:
>> Some fixes according to
>> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
>> 1. Change the tracking directory to/sys/kernel/tracking.
>> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>>
>> v1->v2:
>> Some fixes according to
>> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3DsZtRnKRu_tnUwqHuFQTJvJsv=
>-nz1xPDw@mail.gmail.com/
>> 1. adjust the trace_icmp_send() to more protocols than UDP.
>> 2. move the calling of trace_icmp_send after sanity checks
>> in __icmp_send().
>>
>> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
>> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
>> Cc: Yang Yang <yang.yang29@zte.com.cn>
>> Cc: Liu Chun <liu.chun2@zte.com.cn>
>> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
>
>I think it would be better to target net-next tree since it's not a
>fix or something else important.
>
OK. I would target it for net-next.
>> ---
>>  include/trace/events/icmp.h | 64 +++++++++++++++++++++++++++++++++++++
>>  net/ipv4/icmp.c             |  4 +++
>>  2 files changed, 68 insertions(+)
>>  create mode 100644 include/trace/events/icmp.h
>>
>> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
>> new file mode 100644
>> index 000000000000..2098d4b1b12e
>> --- /dev/null
>> +++ b/include/trace/events/icmp.h
>> @@ -0,0 +1,64 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM icmp
>> +
>> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_ICMP_H
>> +
>> +#include <linux/icmp.h>
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(icmp_send,
>> +
>> +               TP_PROTO(const struct sk_buff *skb, int type, int code),
>> +
>> +               TP_ARGS(skb, type, code),
>> +
>> +               TP_STRUCT__entry(
>> +                       __field(const void *, skbaddr)
>> +                       __field(int, type)
>> +                       __field(int, code)
>> +                       __array(__u8, saddr, 4)
>> +                       __array(__u8, daddr, 4)
>> +                       __field(__u16, sport)
>> +                       __field(__u16, dport)
>> +                       __field(unsigned short, ulen)
>> +               ),
>> +
>> +               TP_fast_assign(
>> +                       struct iphdr *iph =3D ip_hdr(skb);
>> +                       int proto_4 =3D iph->protocol;
>> +                       __be32 *p32;
>> +
>> +                       __entry->skbaddr =3D skb;
>> +                       __entry->type =3D type;
>> +                       __entry->code =3D code;
>> +
>> +                       if (proto_4 =3D=3D IPPROTO_UDP) {
>> +                               struct udphdr *uh =3D udp_hdr(skb);
>> +                               __entry->sport =3D ntohs(uh->source);
>> +                               __entry->dport =3D ntohs(uh->dest);
>> +                               __entry->ulen =3D ntohs(uh->len);
>> +                       } else {
>> +                               __entry->sport =3D 0;
>> +                               __entry->dport =3D 0;
>> +                               __entry->ulen =3D 0;
>> +                       }
>
>What about using the TP_STORE_ADDR_PORTS_SKB macro to record the sport
>and dport like the patch[1] did through extending the use of header
>for TCP and UDP?
>
I believe patch[1] is a good idea as it moves the TCP protocol parsing
previously done inside the TP_STORE_ADDR_PORTS_SKB macro to TP_fast_assign,
and extracts the TP_STORE_ADDR_PORTS_SKB macro into a common file,
enabling support for both UDP and TCP protocol parsing simultaneously.

However, patch[1] only extracts the source and destination addresses of
the packet, but does not extract the source port and destination port,
which limits the significance of my submitted patch.

Perhaps the patch[1] could be referenced for integration after it is merged.
>And, I wonder what the use of tracing ulen of that skb?
>
The tracking of ulen is primarily aimed at ensuring the legality of received
UDP packets and providing developers with more detailed information
on exceptions. See net/ipv4/udp.c:2494-2501.
>[1]: https://lore.kernel.org/all/1c7156a3f164eb33ef3a25b8432e359f0bb60a8e.1=
>710866188.git.balazs.scheidler@axoflow.com/
>
>Thanks,
>Jason
>
>> +
>> +                       p32 =3D (__be32 *) __entry->saddr;
>> +                       *p32 =3D iph->saddr;
>> +
>> +                       p32 =3D (__be32 *) __entry->daddr;
>> +                       *p32 =3D iph->daddr;
>> +               ),
>> +
>> +               TP_printk("icmp_send: type=3D%d, code=3D%d. From %pI4:%u =
>to %pI4:%u ulen=3D%d skbaddr=3D%p",
>> +                       __entry->type, __entry->code,
>> +                       __entry->saddr, __entry->sport, __entry->daddr,
>> +                       __entry->dport, __entry->ulen, __entry->skbaddr)
>> +);
>> +
>> +#endif /* _TRACE_ICMP_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> \ No newline at end of file
>> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> index e63a3bf99617..21fb41257fe9 100644
>> --- a/net/ipv4/icmp.c
>> +++ b/net/ipv4/icmp.c
>> @@ -92,6 +92,8 @@
>>  #include <net/inet_common.h>
>>  #include <net/ip_fib.h>
>>  #include <net/l3mdev.h>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/icmp.h>
>>
>>  /*
>>   *     Build xmit assembly blocks
>> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, in=
>t code, __be32 info,
>>                 }
>>         }
>>
>> +       trace_icmp_send(skb_in, type, code);
>> +
>>         /* Needed by both icmp_global_allow and icmp_xmit_lock */
>>         local_bh_disable();
>>
>> --
>> 2.44.0
>>


