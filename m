Return-Path: <linux-kernel+bounces-158794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A860D8B24FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADD61C21B10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51014AD2F;
	Thu, 25 Apr 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="psH61Q4b"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930DD37152;
	Thu, 25 Apr 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058588; cv=none; b=XqX1pmHTAo6dVwa68dPJdKPSqEx8FWQ4vEgrSSs3wdE3Jh0K+b2dj/k/vV3DWtjsnzlGO/On9oVns4VUA+1+zhsB2dJ85R+CrwJFplMZ8tQX0sVrRoCoK4qcJ3CLd5hcdk2ULUiFdXP9Lth+oouITSuXp3Qrw0Mgq2mjmmsI148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058588; c=relaxed/simple;
	bh=z8lrEkssKXGBLJ8WkduXGmy1x5LH5bVsT2GuLG5sXL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO1Viz/otyGB3mntSgGMTfO+zedobUXxVS9Tj7CToJussuPI0f4+uKrQptYFrq4WxN4nlv+08JHWwh2gdjqrb5Qe43oLVKC0bpp3xHyMq1r03PKPEnra8rWyQGi/mdb/L1+uUDy59eN7Mgy6pMZ8YdG9sig18u5QDHP9iXGJl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=psH61Q4b; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nmfOIPw0cblvIi139skBSZ3vxXW7qyAEkUTJ1CSEWBs=; b=psH61Q4bee0D2Q/u6VtWaKFK++
	qPVxrGGEM0n2JQMPEkCi4gMDe0tVSeP6LyQmdA56xM5MCZj6jtGtJVO8Tw0A03nUFOTdLDw9tnyhJ
	lRWowSxGCWCr2WuKhOdinAlLfm0J2fIQDBMI5w5ZeJGJC/5WsFtQ/GwZx7+r6vviAL+U=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s00w8-007N20-0b;
	Thu, 25 Apr 2024 17:23:00 +0200
Message-ID: <89c406c9-9017-49cb-9084-c0a0fc3ad6f3@nbd.name>
Date: Thu, 25 Apr 2024 17:22:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next v2 2/5] net: add support for segmenting TCP
 fraglist GSO packets
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
References: <20240425150432.44142-1-nbd@nbd.name>
 <20240425150432.44142-3-nbd@nbd.name>
 <662a73ffea9df_1e1a162941e@willemb.c.googlers.com.notmuch>
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
In-Reply-To: <662a73ffea9df_1e1a162941e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 17:17, Willem de Bruijn wrote:
> Felix Fietkau wrote:
>> Preparation for adding TCP fraglist GRO support. It expects packets to be
>> combined in a similar way as UDP fraglist GSO packets.
>> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 69 ++++++++++++++++++++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c |  3 ++
>>  2 files changed, 72 insertions(+)
>> 
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index fab0973f995b..e455f884190c 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -28,6 +28,72 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
>>  	}
>>  }
>>  
>> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
>> +				     __be32 *oldip, __be32 *newip,
>> +				     __be16 *oldport, __be16 *newport)
>> +{
>> +	struct tcphdr *th;
>> +	struct iphdr *iph;
>> +
>> +	if (*oldip == *newip && *oldport == *newport)
>> +		return;
>> +
>> +	th = tcp_hdr(seg);
>> +	iph = ip_hdr(seg);
>> +
>> +	inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
>> +	inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false);
>> +	*oldport = *newport;
>> +
>> +	csum_replace4(&iph->check, *oldip, *newip);
>> +	*oldip = *newip;
>> +}
>> +
>> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
>> +{
>> +	struct sk_buff *seg;
>> +	struct tcphdr *th, *th2;
>> +	struct iphdr *iph, *iph2;
>> +	__be32 flags, flags2;
>> +
>> +	seg = segs;
>> +	th = tcp_hdr(seg);
>> +	iph = ip_hdr(seg);
>> +	flags = tcp_flag_word(th);
>> +	flags2 = tcp_flag_word(tcp_hdr(seg->next));
> 
> Vestigial, now that flag overwrite is removed in v2?

Will fix, thanks.

> All this code is very similar to __udpv4_gso_segment_list_csum. But
> the zero checksum handling in __udpv4_gso_segment_csum makes it just
> different enough that I also do not immediately see a straightforward
> way to avoid duplicating.

Also, the checksum field is in a different location in the udp header. I 
don't think avoiding duplication makes sense here.

- Felix

