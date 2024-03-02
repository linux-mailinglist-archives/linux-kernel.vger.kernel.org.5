Return-Path: <linux-kernel+bounces-89426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3F86F02F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFD61C21AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27035171D8;
	Sat,  2 Mar 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F1ruERiJ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B371119A;
	Sat,  2 Mar 2024 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709377406; cv=none; b=qZVEfmSKHm6Dt/SyUU+Bymiu/O16Bkw8IArwDbpSuyNeZwZneg4lopEE9lk5I687cuWeN2ga4Y53Inmt0yGobui2bJ7df+Yww+3la/ReP2Hb8pTAs7S/U3q8axFlbO2myQDGGPgiD1qPV4DN7tzIGUXWixj2ZO9pivC88RQ5QOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709377406; c=relaxed/simple;
	bh=StM8jCcuLIUhEXyA+Kx/oOlysO2RAZR6KO06K2kCibA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBEEt23tUAN52/MIyqcI9FS2Py8IQD2Q5FpgSGYh6Mkt3BLN5d4w6q4e8uwpdM8bbwx56OYW16AB0Dpoahvn2IdsYwu7S5Xd5+4zkE6U+g85NupBhSgcC/Xa2P131QIWRk8tSI/O86O2mvCkUGX/olmPYBkeG6ZL/RXdRW7ZM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F1ruERiJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5sI/Q
	17YHnDgZ7jjFmoiztGvtNafvTpgOVQgThSAgDQ=; b=F1ruERiJH0Tl+SEoli0Py
	UySZ7fSbsYc9uix3evr+rQXRMjHItzJ7a+9lLr6Sb6N69olegmH/fHSgF2QJ78SP
	Ji6nEPVIa/7rlSuszGk9XUIHccE+fA1e4po6EhEmR10cJ2CbiYM42+uhN7+xY6qe
	0IEZg3QEmIkE61N8VUH0bI=
Received: from hpl-virtual-machine.. (unknown [117.173.176.146])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3n8ozB+NlgyMPBg--.36598S2;
	Sat, 02 Mar 2024 19:02:12 +0800 (CST)
From: He Peilin <peilinhe2020@163.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
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
Subject: Re: Re: [PATCH] net/ipv4: add tracepoint for icmp_send
Date: Sat,  2 Mar 2024 06:02:11 -0500
Message-Id: <20240302110211.6967-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com>
References: <CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n8ozB+NlgyMPBg--.36598S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4fWFy7Zw1ktF47Xw17trb_yoW5tw4rpF
	1UAFZ5WFZ7Jr47u34fZw1fJ3Zav3y8uryUKrW2ga4jkF1vyr1xJrs2gr90kryrArs0krya
	vF4jv345G3Z0q3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfmi_UUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiYxaVsWV4G2+JpQAAsU

> >  include/trace/events/icmp.h | 57 +++++++++++++++++++++++++++++++++++++++++++++
> >  net/ipv4/icmp.c             |  4 ++++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 include/trace/events/icmp.h
> >
> > diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> > new file mode 100644
> > index 000000000000..3d9af5769bc3
> > --- /dev/null
> > +++ b/include/trace/events/icmp.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM icmp
> > +
> > +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_ICMP_H
> > +
> > +#include <linux/icmp.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(icmp_send,
> > +
> > +               TP_PROTO(const struct sk_buff *skb, int type, int code),
> > +
> > +               TP_ARGS(skb, type, code),
> > +
> > +               TP_STRUCT__entry(
> > +                               __field(__u16, sport)
> > +                               __field(__u16, dport)
> > +                               __field(unsigned short, ulen)
> > +                               __field(const void *, skbaddr)
> > +                               __field(int, type)
> > +                               __field(int, code)
> > +                               __array(__u8, saddr, 4)
> > +                               __array(__u8, daddr, 4)
> > +               ),
> > +
> > +               TP_fast_assign(
> > +                               // Get UDP header
> > +                               struct udphdr *uh = udp_hdr(skb);
> > +                               struct iphdr *iph = ip_hdr(skb);
> > +                               __be32 *p32;
> > +
> > +                               __entry->sport = ntohs(uh->source);
> > +                               __entry->dport = ntohs(uh->dest);
> > +                               __entry->ulen = ntohs(uh->len);
> > +                               __entry->skbaddr = skb;
> > +                               __entry->type = type;
> > +                               __entry->code = code;
> > +
> > +                               p32 = (__be32 *) __entry->saddr;
> > +                               *p32 = iph->saddr;
> > +
> > +                               p32 = (__be32 *) __entry->daddr;
> > +                               *p32 =  iph->daddr;
> > +               ),
> > +
> 
> FYI, ICMP can be generated for many other protocols than UDP.

We have noted this issue. Therefore, a UDP judgment confition has been added in TP_fast_assign.This condition will only track abnormal messages when icmp_send is called with the UDP protocol. Otherwise, it will simply print the abnormal type and code.

As follows:
if(proto_4 == IPPROTO_UDP) {
	struct udphdr *uh = udp_hdr(skb);
	__entry->sport = nthos(uh->source);
	__entry_dport = nthos(uh->dest);
	__entry->ulen = nthos(uh->len);
} else {
	__entry->sport = 0;
	__entry_dport = 0;
	__entry->ulen = 0;
}

> 
> > +               TP_printk("icmp_send: type=%d, code=%d. From %pI4:%u to %pI4:%u ulen=%d skbaddr=%p",
> > +                       __entry->type, __entry->code,
> > +                       __entry->saddr, __entry->sport, __entry->daddr,
> > +                       __entry->dport, __entry->ulen, __entry->skbaddr)
> > +);
> > +
> > +#endif /* _TRACE_ICMP_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index e63a3bf99617..437bdb7e2650 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -92,6 +92,8 @@
> >  #include <net/inet_common.h>
> >  #include <net/ip_fib.h>
> >  #include <net/l3mdev.h>
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/icmp.h>
> >
> >  /*
> >   *     Build xmit assembly blocks
> > @@ -599,6 +601,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
> >         struct net *net;
> >         struct sock *sk;
> >
> > +       trace_icmp_send(skb_in, type, code);
> 
> I think you missed many sanity checks between lines 622 and 676
Thank you for the reminder. The next step is to move the trace point to line 676.

> Honestly, a kprobe BPF based solution would be less risky, and less
> maintenance for us.
emm, yeah, but tracepoints has advantages on its convienice, especially for those Embedded Linux which doesn't support EBPF.


