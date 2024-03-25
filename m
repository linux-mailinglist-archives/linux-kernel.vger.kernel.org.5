Return-Path: <linux-kernel+bounces-116509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4988A00B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809DE1F39916
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFA13CC40;
	Mon, 25 Mar 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NsGqJAA5"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0000E4317B;
	Mon, 25 Mar 2024 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339299; cv=none; b=Gv71jqONa4jmKfywnGsPPlb8gn0SFnInUcZzXWMrhQFJNyrXfmmPiswKQsZMIGu4ZRhX43VHpIGT3m9eng3dalL/MXtB7+EuVVTiRKrx6TVbB/454qL8XWJ+CF5380uOh6UWoJ6v3IsvCGrilDsSoSnS+8QWPt7D7Rqib54MdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339299; c=relaxed/simple;
	bh=Xrto1isUre/YOZl7rOJbD4TAJ6P1KNC0m3iMnvHrYc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDh58WcbcVXWCknwYOwWztjzx650ImKkdb72KL77QtLGK17PzO+eC0+gaD9Q3O9a+TM38BTPd425kOWmlmYOgMnC9i8z/jTn27fuctwQbXv6YxOrK8MRrsRDchgcADTesV+sDQu7qmZVN8bdI8A/yc5WSPwc+fMr2JcJsqOpYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NsGqJAA5; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GRkUX
	HpEGK2aXuxqbIEPhXhKHaUg92/b19NkuDLSQuo=; b=NsGqJAA511U9cs0LdI7Jv
	hfw0aeqHvBd9m0X2dkYEc9m5pkfGNFkauliWVAvOPCUT9TXv4wH09WVbz1Qd8pi0
	5lMWmYROUhS4z4AUdSqi6sn0Qib7MHqjSulUsrWnOxYG7H1nmXbkCNmY1YsIT3ZL
	4nImX5nzx5xvmXQXSnsfuo=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3X2YD9wBmoJnGBw--.35036S2;
	Mon, 25 Mar 2024 12:01:09 +0800 (CST)
From: Peilin He <peilinhe2020@163.com>
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
Subject: Re: Re: [PATCH v3 resend] net/ipv4: add tracepoint for icmp_send
Date: Mon, 25 Mar 2024 04:01:07 +0000
Message-Id: <20240325040107.3776173-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJzBzkJFVgCTdXBx=YBg@mail.gmail.com>
References: <CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJzBzkJFVgCTdXBx=YBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X2YD9wBmoJnGBw--.35036S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1fAr17try7tr1rCw13CFg_yoW7Xr1fpF
	yDAF1rKr4ktrsrCw13Zw4jqr15Way8GryUGr1Iqw4xCr1Dtrn8t3y2gr1YkF95Zrs8K34a
	v3WYk3s8Cwn8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4Ap8UUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiZRWssWXAkuWgygABsU

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
>> Changelog
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
>
>This is completely bogus.
>
>Adding tracepoints is ok if there are no side effects like bugs :/
>
>At this point there is no guarantee the UDP header is complete/present
>in skb->head
>
>Look at the existing checks between lines 619 and 623
>
>Then audit all icmp_send() callers, and ask yourself if UDP packets
>can not be malicious (like with a truncated UDP header)
Yeah, you are correct. Directly parsing udphdr through the sdk may
conceal bugs, such as illegal skb. To handle such exceptional scenarios,
we can determine the legitimacy of skb by checking whether the position
of the uh pointer is out of bounds.

Perhaps it could be modified like this:	
	struct udphdr *uh = udp_hdr(skb);
	
	if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
		(u8 *)uh + sizeof(struct udphdr) > skb_tail_pointer(skb)) {
		__entry->sport = 0;
		__entry->dport = 0;
		__entry->ulen = 0;
	} else {
		__entry->sport = ntohs(uh->source);
		__entry->dport = ntohs(uh->dest);
		__entry->ulen = ntohs(uh->len);
	}
	
Additionally, the validity of all parameters in the current patch has been
confirmed without any issues. Thank you once again for your reminder.


