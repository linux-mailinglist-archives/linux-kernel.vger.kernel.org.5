Return-Path: <linux-kernel+bounces-163770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0AC8B6FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B70B21412
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8B813D2AA;
	Tue, 30 Apr 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="eMII8GUm"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A09129A7B;
	Tue, 30 Apr 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472868; cv=none; b=Lu/I7gYi6+A4zjhBovp9sdib8lljtseQ1esWXlkZqjBiwegV8sB1Sp41S5S/tLsqXvy9XMFG3MR+LeF6+SeKxD003qSMcsWvh8VaS/cRfyQM5GxM/pYLDD8ARmLNEaOwI41wvITe3VmGdFkZfkdeRMvxgAsJd4ypsqiSDlQMenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472868; c=relaxed/simple;
	bh=qrAZSPLY9V2e06HjvA6dDash3QU5DWCWBNfcSaTwLlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/4lqDFI5d5ZebB9j/CaDGUmXb7OHuBdwAIV5/k+dtmX9XaDVMQ/l4tGCWpURnIqWmIWrdpJcE67uh4CxYcYc5BMzSXJlSXOGuwMTibM4ExeNtPkpbT5rNbj5wg+Djv4h1lUTvEOM6ymZ8+wVs0OaLH51Ar0wwmSEwiOG/dXeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=eMII8GUm; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m9GOdwLtpGgxawicx0NC7KEnv3fWXOtUkoh5EDjZVXU=; b=eMII8GUmErLDjMspTFvaSuFQ8F
	lvhUXbYeHhp2ihgR5wtRfChJ9L4wEiZ3K2AAwDjDCztrpWzqad3Umva32I0nlpQbwxt4RL7QzK5Mb
	aHug0jQawIytTEU+2cQWYmTOY1R792jBUe3mDEbDGlpuUnwCE0NlrKmVggK9ugjs0w/c=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s1ki4-00AEZo-32;
	Tue, 30 Apr 2024 12:27:41 +0200
Message-ID: <9e686cb4-ed1f-4886-a0b7-328367e62757@nbd.name>
Date: Tue, 30 Apr 2024 12:27:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next v4 2/6] net: add support for segmenting TCP
 fraglist GSO packets
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240427182305.24461-1-nbd@nbd.name>
 <20240427182305.24461-3-nbd@nbd.name>
 <a20a0f0479cedc7f2f6abaf26e46ca7642e70958.camel@redhat.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
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
In-Reply-To: <a20a0f0479cedc7f2f6abaf26e46ca7642e70958.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.24 12:19, Paolo Abeni wrote:
> On Sat, 2024-04-27 at 20:22 +0200, Felix Fietkau wrote:
>> Preparation for adding TCP fraglist GRO support. It expects packets to be
>> combined in a similar way as UDP fraglist GSO packets.
>> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 67 ++++++++++++++++++++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c | 58 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 125 insertions(+)
>> 
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index fab0973f995b..affd4ed28cfe 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -28,6 +28,70 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
>>  	}
>>  }
>>  
>> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
>> +				     __be32 *oldip, __be32 newip,
>> +				     __be16 *oldport, __be16 newport)
>> +{
>> +	struct tcphdr *th;
>> +	struct iphdr *iph;
>> +
>> +	if (*oldip == newip && *oldport == newport)
>> +		return;
>> +
>> +	th = tcp_hdr(seg);
>> +	iph = ip_hdr(seg);
>> +
>> +	inet_proto_csum_replace4(&th->check, seg, *oldip, newip, true);
>> +	inet_proto_csum_replace2(&th->check, seg, *oldport, newport, false);
>> +	*oldport = newport;
>> +
>> +	csum_replace4(&iph->check, *oldip, newip);
>> +	*oldip = newip;
>> +}
>> +
>> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
>> +{
>> +	const struct tcphdr *th;
>> +	const struct iphdr *iph;
>> +	struct sk_buff *seg;
>> +	struct tcphdr *th2;
>> +	struct iphdr *iph2;
>> +
>> +	seg = segs;
>> +	th = tcp_hdr(seg);
>> +	iph = ip_hdr(seg);
>> +	th2 = tcp_hdr(seg->next);
>> +	iph2 = ip_hdr(seg->next);
>> +
>> +	if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
>> +	    iph->daddr == iph2->daddr && iph->saddr == iph2->saddr)
>> +		return segs;
>> +
>> +	while ((seg = seg->next)) {
>> +		th2 = tcp_hdr(seg);
>> +		iph2 = ip_hdr(seg);
>> +
>> +		__tcpv4_gso_segment_csum(seg,
>> +					 &iph2->saddr, iph->saddr,
>> +					 &th2->source, th->source);
>> +		__tcpv4_gso_segment_csum(seg,
>> +					 &iph2->daddr, iph->daddr,
>> +					 &th2->dest, th->dest);
>> +	}
>> +
>> +	return segs;
>> +}
> 
> AFAICS, all the above is really alike the UDP side, except for the
> transport header zero csum.
> 
> What about renaming the udp version of this helpers as 'tcpudpv4_...',
> move them in common code, add an explicit argument for
> 'zerocsum_allowed' and reuse such helper for both tcp and udp?
> 
> The same for the ipv6 variant.

Wouldn't that make it more convoluted when taking into account that the 
checksum field offset is different for tcp vs udp?
How would you handle that?

- Felix

