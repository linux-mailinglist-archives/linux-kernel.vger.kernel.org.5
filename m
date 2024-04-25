Return-Path: <linux-kernel+bounces-158803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E48B2518
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344ED1C20A33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915814B078;
	Thu, 25 Apr 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="F/9soyhe"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BC14AD32;
	Thu, 25 Apr 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058952; cv=none; b=A90bdknE2ZdLAl0rnXHZI647CCyas4S70aZk978Jb7RAbQQtKENlnRC8tLpLy8z3hh+OYQsGaTHoz2fMx7GJ8fpJrG1jBYYX/5kmwaLIeVnlCeSO3E7kUX9vFu0mU9CrAzak8Ob6jZOtl/0TU74H4LiB03Zconi1IYJ9VJUqBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058952; c=relaxed/simple;
	bh=WBfwUAPY3IxR/dJmmO7e7McMTactBi43fT6vxXVxBSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+FFdEj6RVLgC4RkGCA48cBv2FFrnGh+IozjXhf3wiyiH3cC2M9/t0OwxX3M5gQr7H4BStELbO0tvieRa4KvOJ3Hbtun7B0/ZF+Pav5He7PeF+hPOOwblxUI78c6kDy0w3LyMolTzZb3n+7vMCDVdxoLZ1cLPFeG5mCEuog/Ve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=F/9soyhe; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=24WSueX8LHY0EiPcpbJWLG6ltBcd7mI2TNQSXr3WiGE=; b=F/9soyheS3atoAr68aCu6Pldhk
	TPhvyJIYQN4hhaV4L7aqFXVylvrcvk8fuC6S1HJ+VB7O4B05EaEsvo865NiqUCU20xAVwvxvwfi1A
	eXlgbNj0jv1SzTNXA7LSNq+mP7gNS16Bk84EKts9Khy+A2QmWp5IrAydyhWDHD2G28Sw=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0120-007NDU-1t;
	Thu, 25 Apr 2024 17:29:04 +0200
Message-ID: <554bd11b-376e-4d68-ad79-01e5202deaf8@nbd.name>
Date: Thu, 25 Apr 2024 17:29:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next v2 5/5] net: add heuristic for enabling TCP
 fraglist GRO
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240425150432.44142-1-nbd@nbd.name>
 <20240425150432.44142-7-nbd@nbd.name>
 <CANn89iLqpADT6T_JtecgMJKKcTEBORVdVqTYYBRtwWWnk6=4ng@mail.gmail.com>
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
In-Reply-To: <CANn89iLqpADT6T_JtecgMJKKcTEBORVdVqTYYBRtwWWnk6=4ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.04.24 17:26, Eric Dumazet wrote:
> On Thu, Apr 25, 2024 at 5:04 PM Felix Fietkau <nbd@nbd.name> wrote:
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
>>  net/ipv4/tcp_offload.c   | 48 +++++++++++++++++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c | 51 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 99 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index 520fd425ab19..3bb96a110402 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -405,6 +405,52 @@ void tcp_gro_complete(struct sk_buff *skb)
>>  }
>>  EXPORT_SYMBOL(tcp_gro_complete);
>>
>> +static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb)
>> +{
>> +       const struct iphdr *iph = skb_gro_network_header(skb);
> 
> I do not think loading iph before all skb_gro_header() and
> skb_gro_header_slow() calls is wise.
> 
> pskb_may_pull() can re-allocate skb->head

Will fix.

>> +       struct net *net = dev_net(skb->dev);
>> +       unsigned int off, hlen, thlen;
>> +       struct sk_buff *p;
>> +       struct tcphdr *th;
>> +       struct sock *sk;
>> +       int iif, sdif;
>> +
>> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
>> +               return;
>> +
>> +       off = skb_gro_offset(skb);
>> +       hlen = off + sizeof(*th);
>> +       th = skb_gro_header(skb, hlen, off);
>> +       if (unlikely(!th))
>> +               return;
>> +
>> +       thlen = th->doff * 4;
>> +       if (thlen < sizeof(*th))
>> +               return;
>> +
>> +       hlen = off + thlen;
>> +       if (!skb_gro_may_pull(skb, hlen)) {
>> +               th = skb_gro_header_slow(skb, hlen, off);
>> +               if (unlikely(!th))
>> +                       return;
>> +       }
>> +
>> +       p = tcp_gro_lookup(head, th);
>> +       if (p) {
>> +               NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
>> +               return;
>> +       }
>> +
>> +       inet_get_iif_sdif(skb, &iif, &sdif);
>> +       sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
>> +                                      iph->saddr, th->source,
>> +                                      iph->daddr, ntohs(th->dest),
>> +                                      iif, sdif);
>> +       NAPI_GRO_CB(skb)->is_flist = !sk;
>> +       if (sk)
>> +               sock_put(sk);
>> +}
>> +
>>  INDIRECT_CALLABLE_SCOPE
>>  struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
>>  {
>> @@ -416,6 +462,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
>>                 return NULL;
>>         }
>>
> 
> I would probably pull the whole TCP header here, before calling
> tcp4_check_fraglist_gro(head, skb)
> and no longer do this twice from tcp4_check_fraglist_gro() and tcp_gro_receive()
> 
> Perhaps define a new inline helper, that will be called from
> tcp4_gro_receive() and tcp6_gro_receive(),
> and not anymore from  tcp_gro_receive()
> 
> static inline struct tcphdr *tcp_gro_pull_header(...)
> {
>       ....
>         off = skb_gro_offset(skb);
>         hlen = off + sizeof(*th);
>         th = skb_gro_header(skb, hlen, off);
>         if (unlikely(!th))
>                 return NULL;
> 
>         thlen = th->doff * 4;
>         if (thlen < sizeof(*th))
>                 return NULL;
> 
>         hlen = off + thlen;
>         if (!skb_gro_may_pull(skb, hlen))
>                 th = skb_gro_header_slow(skb, hlen, off);
> 
>        return th;
> }

Makes sense

Thanks,

- Felix

