Return-Path: <linux-kernel+bounces-138477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B2A89F1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FF51C23514
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E115B14C;
	Wed, 10 Apr 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gAwdpUNh"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF515B10A;
	Wed, 10 Apr 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751546; cv=none; b=daur5z7/d5dCTsCyAW7dYBHYmG9Hl8iYClxJ/v0CBN6v2L+hgQUYvtEI4ug11NFY+ev6/W4bdRlGfZf2PEV4isAm4IbCC24yZbPS45H9h5Vz+ubg/y7ahdOSMke9F5cgqB101VLXHsrgAXKB7tJR4/J9usHDEcOyqlf0dQbuaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751546; c=relaxed/simple;
	bh=ciCyitloPJUj9l9pbQATwhGeyRiLDR+ZOvHOcClUbn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SH6nFJ0suAxt1ZL+PHUAiPrmxDaTIUF6l/A8RA7cNJ5D/+tJJmdALO3keGM3OLcNk1iay6AgyNqhJUgbUp/25XrHkjdHqOm/e31Wuasa2qV7/LJTLOvQmDTO04kul7nXbY4T87FMIPkYi2BK7c1tA5yFrBnAMNQwuyAave3Hyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gAwdpUNh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BC4Af
	LdQra70q2ATsF29iy5NzMY1RVurEWX8+rpgn+c=; b=gAwdpUNhD/e86lpsVcbB8
	PjWCQbNQFngVTeCBdpg4tiQDOHekgwCIx+PwFLt7qNJwvGYVyvRJRg440/QvyC/N
	9Kf9kp1Izhu/RND7v6Gvb6ULSavGzw6C5EYACIi/QrEtFmeHGrrQhGoam/n/na31
	EXBEt1sazrLbjI6bDi1fD8=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDnF9IGgxZmHGTPAg--.23250S2;
	Wed, 10 Apr 2024 20:16:07 +0800 (CST)
From: Peilin He <peilinhe2020@163.com>
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	jiang.xuexin@zte.com.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liu.chun2@zte.com.cn,
	mhiramat@kernel.org,
	netdev@vger.kernel.org,
	qiu.yutan@zte.com.cn,
	rostedt@goodmis.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: Re: Subject: [PATCH net-next v4] net/ipv4: add tracepoint for icmp_send
Date: Wed, 10 Apr 2024 12:16:05 +0000
Message-Id: <20240410121605.132052-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL+tcoAcagGKkzJLrgCmFRv52uBbdAN_ufspvmkbG2MaFw2_tQ@mail.gmail.com>
References: <CAL+tcoAcagGKkzJLrgCmFRv52uBbdAN_ufspvmkbG2MaFw2_tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnF9IGgxZmHGTPAg--.23250S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1fAr17tF13KFWUKr4Uurg_yoWxXFW8pF
	yUAFn5Grs7trsrCryxuw4aqF15WrW8uryUKryIqw4IkwnFvrnrt3yvqr1YkFykZrs8Krya
	v3WYk3s8Cwn8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuKZXUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiZQi8sWXAlEnhJAAAsd

>> From: hepeilin <he.peilin@zte.com.cn>
>>
>> Introduce a tracepoint for icmp_send, which can help users to get more
>> detail information conveniently when icmp abnormal events happen.
>>
>> 1. Giving an usecase example:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
>=3D=3D=3D=3D=3D
>> When an application experiences packet loss due to an unreachable UDP
>> destination port, the kernel will send an exception message through the
>> icmp_send function. By adding a trace point for icmp_send, developers or
>> system administrators can obtain detailed information about the UDP
>> packet loss, including the type, code, source address, destination addres=
>s,
>> source port, and destination port. This facilitates the trouble-shooting
>> of UDP packet loss issues especially for those network-service
>> applications.
>>
>> 2. Operation Instructions:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
>=3D=3D
>> Switch to the tracing directory.
>>         cd /sys/kernel/tracing
>> Filter for destination port unreachable.
>>         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filter
>> Enable trace event.
>>         echo 1 > events/icmp/icmp_send/enable
>>
>> 3. Result View:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  udp_client_erro-11370   [002] ...s.12   124.728002:
>>  icmp_send: icmp_send: type=3D3, code=3D3.
>>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=3D23
>>  skbaddr=3D00000000589b167a
>>
>> v3->v4:
>> Some fixes according to
>> https://lore.kernel.org/all/CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJzBzkJFVgCTdX=
>Bx=3DYBg@mail.gmail.com/
>> 1.Add legality check for UDP header in SKB.
>
>I think my understanding based on what Eric depicted differs from you:
>we're supposed to filter out those many invalid cases and only trace
>the valid action of sending a icmp, so where to add a new tracepoint
>is important instead of adding more checks in the tracepoint itself.
>Please refer to what trace_tcp_retransmit_skb() does :)
>
>Thanks,
>Jason
Okay, thank you for your suggestion. In order to avoid filtering out
those many invalid cases and only tracing the valid action of sending
a icmp, the next patch will add udd_fail_no_port trancepoint to the
include/trace/events/udp.h. This will solve the problem you mentioned
very well. At this point, only UDP protocol exceptions will be tracked,
without the need to track them in icmp_send.

>> 2.Target this patch for net-next.
>>
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
>> ---
>>  include/trace/events/icmp.h | 65 +++++++++++++++++++++++++++++++++++++
>>  net/ipv4/icmp.c             |  4 +++
>>  2 files changed, 69 insertions(+)
>>  create mode 100644 include/trace/events/icmp.h
>>
>> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
>> new file mode 100644
>> index 000000000000..7d5190f48a28
>> --- /dev/null
>> +++ b/include/trace/events/icmp.h
>> @@ -0,0 +1,65 @@
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
>> +                       struct udphdr *uh =3D udp_hdr(skb);
>> +                       if (proto_4 !=3D IPPROTO_UDP || (u8 *)uh < skb->h=
>ead ||
>> +                               (u8 *)uh + sizeof(struct udphdr) > skb_ta=
>il_pointer(skb)) {
>> +                               __entry->sport =3D 0;
>> +                               __entry->dport =3D 0;
>> +                               __entry->ulen =3D 0;
>> +                       } else {
>> +                               __entry->sport =3D ntohs(uh->source);
>> +                               __entry->dport =3D ntohs(uh->dest);
>> +                               __entry->ulen =3D ntohs(uh->len);
>> +                       }
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
>> index 8cebb476b3ab..224551d75c02 100644
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
>> 2.25.1


