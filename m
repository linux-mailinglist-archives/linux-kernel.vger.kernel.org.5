Return-Path: <linux-kernel+bounces-159775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF58B33CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370F2B2301C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567513F011;
	Fri, 26 Apr 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ty1yjBR2"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63113E052;
	Fri, 26 Apr 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123287; cv=none; b=U9xonCVcd93Yd/pj6LyAgKJ3xepgYKXKw2uM7wvLcLcr7s00QRQP21j2opYbwanodskfCUOk2yy+sCL1WaL7pya81miqWZZ1vo4YZpToIPWp1/ub/Sn3EubkbxJh6RdasTZlbb+f8L6+IoRwALYF0RjG9gmKkipV6wjdSzsIr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123287; c=relaxed/simple;
	bh=OBW1YwIsE9yd0NZZ//6apOQpHOMIGIMIaIXFyjPK1A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Du4Hlz9jMR6HRAL3OBhPpedFobfPOtVvojHI8jnZNYUm8b96odv/G0HB0R40CDOrYKXaDYCoCjFsSFATwbtigGq9xEfq56cf0x+blOnosRW3GYMyIr2CnyuS9D5JzdP64N6ibJtCa2iLn1hvYafmyIc0h6GhTSfSyBxtU5X+EyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ty1yjBR2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bUsM/+EFDc2XNhwU4d8yS9gf88wFymspxCgCF26Ujjg=; b=ty1yjBR2CB/66avr6xtuZvub6b
	k2Wsii5rkoXD0J09gUpdns7dZhb5Tten5XoP6Y0fPTHmzU9B6kUrroC4giEtRSKU7JvCi5+rfywkK
	8UbVD8LB0ApfJfiq4P1YU9khtXT5JUgGzfgSHXf10jYMlxf37R0iBy5ddWsoE9Xgr7KM=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0Hlb-007sLq-1A;
	Fri, 26 Apr 2024 11:21:15 +0200
Message-ID: <b7c9f59b-682d-4444-9906-58704f0f0359@nbd.name>
Date: Fri, 26 Apr 2024 11:21:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next v3 6/6] net: add heuristic for enabling TCP
 fraglist GRO
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240426065143.4667-1-nbd@nbd.name>
 <20240426065143.4667-7-nbd@nbd.name>
 <CANn89i+n76MEoQPbj8oxMMEw5N6T8KAP4Xp2YsUYb32fUzAJNg@mail.gmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <CANn89i+n76MEoQPbj8oxMMEw5N6T8KAP4Xp2YsUYb32fUzAJNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.04.24 09:32, Eric Dumazet wrote:
> On Fri, Apr 26, 2024 at 8:51 AM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> When forwarding TCP after GRO, software segmentation is very expensive,
>> especially when the checksum needs to be recalculated.
>> One case where that's currently unavoidable is when routing packets over
>> PPPoE. Performance improves significantly when using fraglist GRO
>> implemented in the same way as for UDP.
>>
>> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
>> socket in the same netns as the receiving device. While this may not
>> cover all relevant use cases in multi-netns configurations, it should be
>> good enough for most configurations that need this.
>>
>> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
>> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
>> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
>> 1Gbps.
>>
>> rx-gro-list off: 630 Mbit/s, CPU 35% idle
>> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>>
>> Signe-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 30 ++++++++++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c | 33 +++++++++++++++++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index ee5403760775..2ae83f4394dc 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -406,6 +406,34 @@ void tcp_gro_complete(struct sk_buff *skb)
>>  }
>>  EXPORT_SYMBOL(tcp_gro_complete);
>>
>> +static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>> +                                   struct tcphdr *th)
>> +{
>> +       const struct iphdr *iph = skb_gro_network_header(skb);
>> +       struct net *net = dev_net(skb->dev);
> 
> Could you defer the initializations of iph and net after the
> NETIF_F_GRO_FRAGLIST check ?
> 
> dev_net() has an implicit READ_ONCE() ...

Will do, thanks.

- Felix


