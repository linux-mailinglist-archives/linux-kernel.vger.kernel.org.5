Return-Path: <linux-kernel+bounces-159942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E1A8B3691
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F4E1F2333F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C3145340;
	Fri, 26 Apr 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Rn/L5oeL"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C01144D3F;
	Fri, 26 Apr 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131371; cv=none; b=YXpLAofokswkOqly2FzlqF/s/Km5Vre9mcsW647r431q8aghE6Iq8gjrm1UvxCMPlmQ61RON/lHT4352iK647a+Cle+Xg3pGhH9G0/sggIbIgKHkc3LTP71kLgDf5+xrDi+uDED3FD4IGDSY/s877WEAinE4HpspySduuMJ8R5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131371; c=relaxed/simple;
	bh=uIMBVVZN0rAr0YvSwbBAXPUUyJX6ueLcEdjL2EoKaAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTjNrxUeEbe/WdVIBKzux7XcVtCyElUPXnAAL/8wNr5zWzhIli2UxLxpWMNpywdKKMdP2CHPaz6oeQfzFijaGJviynClab3Kr7CZCCJfYxgGI7g/F1oT73Yjs8XY5NQyhvjdXGsg5trKNUN6k3L/PsciKdYxQ/Wnl/EOMxypPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Rn/L5oeL; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vl89SPPDdjqrDw3KYXpqLJi42kU9OHhpKP+Ax8ANpKc=; b=Rn/L5oeLFpfLOrAY3pTtATBJNU
	wstRwJmcGepQ+Dbyu8kBFokOaRLfA3esAxoWoJpmCxoRzmu+y7xp0wmwIK5hoHLyGr1mlk0xobzqo
	SDCdqz9MbbCiWJw6rHF18I3dMhTQgr8dsI2D4wzBUloImi+qMUgR0dTgNDqWpJ6H1YSs=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0Jrz-007x5k-1j;
	Fri, 26 Apr 2024 13:35:59 +0200
Message-ID: <ca40fe27-30b5-4941-9235-6cc444eed1fd@nbd.name>
Date: Fri, 26 Apr 2024 13:35:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next v3 2/6] net: add support for segmenting TCP
 fraglist GSO packets
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240426065143.4667-1-nbd@nbd.name>
 <20240426065143.4667-3-nbd@nbd.name>
 <5a95fea4156b492eb19124bb33b21be81766c617.camel@redhat.com>
 <9350b6f7-abd8-45c5-931a-62f48a50bee4@nbd.name>
 <869b3dbb8f5c80ead202c6db3ebc61c0007ee5e1.camel@redhat.com>
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
In-Reply-To: <869b3dbb8f5c80ead202c6db3ebc61c0007ee5e1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 12:40, Paolo Abeni wrote:
> On Fri, 2024-04-26 at 11:39 +0200, Felix Fietkau wrote:
>> On 26.04.24 10:28, Paolo Abeni wrote:
>> > On Fri, 2024-04-26 at 08:51 +0200, Felix Fietkau wrote:
>> > > Preparation for adding TCP fraglist GRO support. It expects packets to be
>> > > combined in a similar way as UDP fraglist GSO packets.
>> > > For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>> > > 
>> > > Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> > > ---
>> > >  net/ipv4/tcp_offload.c   | 65 ++++++++++++++++++++++++++++++++++++++++
>> > >  net/ipv6/tcpv6_offload.c |  3 ++
>> > >  2 files changed, 68 insertions(+)
>> > > 
>> > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> > > index fab0973f995b..c493e95e09a5 100644
>> > > --- a/net/ipv4/tcp_offload.c
>> > > +++ b/net/ipv4/tcp_offload.c
>> > > @@ -28,6 +28,68 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
>> > >  	}
>> > >  }
>> > >  
>> > > +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
>> > > +				     __be32 *oldip, __be32 *newip,
>> > > +				     __be16 *oldport, __be16 *newport)
>> > > +{
>> > > +	struct tcphdr *th;
>> > > +	struct iphdr *iph;
>> > > +
>> > > +	if (*oldip == *newip && *oldport == *newport)
>> > > +		return;
>> > > +
>> > > +	th = tcp_hdr(seg);
>> > > +	iph = ip_hdr(seg);
>> > > +
>> > > +	inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
>> > > +	inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false);
>> > > +	*oldport = *newport;
>> > > +
>> > > +	csum_replace4(&iph->check, *oldip, *newip);
>> > > +	*oldip = *newip;
>> > > +}
>> > > +
>> > > +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
>> > > +{
>> > > +	struct sk_buff *seg;
>> > > +	struct tcphdr *th, *th2;
>> > > +	struct iphdr *iph, *iph2;
>> > > +
>> > > +	seg = segs;
>> > > +	th = tcp_hdr(seg);
>> > > +	iph = ip_hdr(seg);
>> > > +	th2 = tcp_hdr(seg->next);
>> > > +	iph2 = ip_hdr(seg->next);
>> > > +
>> > > +	if (!(*(u32 *)&th->source ^ *(u32 *)&th2->source) &&
>> > > +	    iph->daddr == iph2->daddr && iph->saddr == iph2->saddr)
>> > > +		return segs;
>> > 
>> > As mentioned in previous revisions, I think a problem with this
>> > approach is that the stack could make other changes to the TCP header
>> > after the GRO stage, that are unnoticed here and could cause csum
>> > corruption, if the egress device does not recompute the packet csum.
>> 
>> On segmentation, each packet keeps its original TCP header and csum. If 
>> the stack makes changes, they apply to the first packet only. I don't 
>> see how we could get csum corruption.
> 
> You are right. I did not take in account that such changes (to the
> first skb) are not reflected to the frag_list at segmentation time. The
> end result could be different from what the user/admin is expecting,
> but at least should not impact drops.
> 
> Side note: alike UDP, this is not supporting IPv6 NAT...

I will add that for both in the next version.

Thanks,

- Felix


