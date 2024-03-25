Return-Path: <linux-kernel+bounces-116508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C93288A61D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C6DBC1513
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE26E5FD;
	Mon, 25 Mar 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cnp4fQnZ"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FF1B81F;
	Mon, 25 Mar 2024 03:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339154; cv=none; b=Klb6nIkmv8xzJTlVgi+JBopevSuQ4md29nqzDRDGacREVjS2fj8+4UuGpJxObo1dQNM2NIDGyMR5uobTuPnD9yeyH5tJ9s0TwDCKFtLcRXb7fB6QISbNPdfolOJ5/JnayKPTxx9e4qhaNK/juxkaIegqmLsyCFWXPrXqsak6SZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339154; c=relaxed/simple;
	bh=dhSk9xYlvB9BWrRcYumZmtBULUH7LFBv69V2VOhVP2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ef/NKi5rrpl1BK/TBb6GbYIQ7UEf7J537CDrsZRBQ4Uqgji1XCIrzjbvkKgfeRTQaSPDp0tdxkzqlXbj1BVeY4HS4xMoRIXbiGJ9GbPdeZqqV0C/4CSXvcu+kOYu5Dl6LLd6GzqTnkIDcGLywZh/0wA1C5s/uL+Fq9XBt/ZPueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cnp4fQnZ; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lPX/M
	9qGGRnZuiwR3wscgK7y8VnR6FNWSaY4LI0hbT8=; b=Cnp4fQnZYB1ZdADCshVLN
	WW+DHNyLyR5Y3lbyQut6Yyxfy3cadSwszv9vzrU9xkSTM/0QuVxKEojnzZMkov28
	AQcYahqI8+hYGvFkBIsz9uyHTGcT6/OxFr3qc7WG76v/s8E7gmXBNaHRL7rF0Ieb
	OnIwWSPZh4q9x7z5mZXsMc=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3_0ov9gBmL4gpBg--.1652S2;
	Mon, 25 Mar 2024 11:57:37 +0800 (CST)
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
Date: Mon, 25 Mar 2024 03:57:35 +0000
Message-Id: <20240325035735.3776104-1-peilinhe2020@163.com>
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
X-CM-TRANSID:_____wD3_0ov9gBmL4gpBg--.1652S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF1fAr17try7tr1rCw13CFg_yoW7Xr4rpF
	yDAF1rKrWktrsrCw1fZw42qr15uayrGryUJr1Iqw4xCr1Dtr1Dt3y2gr1YkF95Zrs8K34a
	v3WYk3s8Cwn8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwkucUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiZRWssWXAkuWgygAAsV

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
of the uh pointer is out of bounds. The modifications in the patch are
as follows:	
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


