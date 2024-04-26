Return-Path: <linux-kernel+bounces-159784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2768B33F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26045284576
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C713EFF4;
	Fri, 26 Apr 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="GFji33As"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD526282EA;
	Fri, 26 Apr 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123724; cv=none; b=WGGXefQFGjUQgVOpaat5T56yCidpH5rz0md7vvaKsnLeihUzQItYtrY7hDNz71+8nXiTB7/KZb+25IBv2h1KqD/GozaJiyiAMglkdHnmWbFkHLlxQYE96Qh2NEPf2rc9pAmo1kp6LToQSD2C0J9aC3Pw3wZNB2CUOMJ32ApoSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123724; c=relaxed/simple;
	bh=uSg+JsA984ostLXPPYPAUTtsSiyJkCZ6SKROscXhfjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlpxt0/hBPS8Kt1tau/E5Pzv6J8Gua0DcGelG91v2cAE/BMc6wdTtTedp5yyXiBkbHRbMey88kJLKQh+Rjodzb1NCO2kVh/dpZxzZclmWw1Dt2hxEgwLL48QKxirJnNx6WUzgQh+GPlSL/DIE6pyY8DUg05EuWL+lnjXTkpOh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=GFji33As; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AUvRK9BW9RFjx6ktJJTIck1J53QfoMTxbI/6X0yUxxA=; b=GFji33AsQgXWgjzYPkvZWTIrE+
	YheGbKUOoO2Dqy6g2WtMoW66HTIyQZuXLk+v3m7HtINYx+jcuqUJUI3mQj+L8/4fO3QrT0DIPHTWg
	NUI+t/0ehHDSTE3Ve2TeVm5JpNZ8d6dSYF9Yl6CbCxmidenNg8XjpxD77gtcKy0DQysM=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0Hsh-007sat-2G;
	Fri, 26 Apr 2024 11:28:35 +0200
Message-ID: <9f4bc3f2-d66b-42d4-af15-a8b1b1fc696a@nbd.name>
Date: Fri, 26 Apr 2024 11:28:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next v3 2/6] net: add support for segmenting TCP
 fraglist GSO packets
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240426065143.4667-1-nbd@nbd.name>
 <20240426065143.4667-3-nbd@nbd.name>
 <CANn89iJKfgQNNXUL10-7aVZTn+ttqvVNZbnKi6jCdQGwzbFFYQ@mail.gmail.com>
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
In-Reply-To: <CANn89iJKfgQNNXUL10-7aVZTn+ttqvVNZbnKi6jCdQGwzbFFYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.04.24 09:44, Eric Dumazet wrote:
> On Fri, Apr 26, 2024 at 8:51 AM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> Preparation for adding TCP fraglist GRO support. It expects packets to be
>> combined in a similar way as UDP fraglist GSO packets.
>> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 65 ++++++++++++++++++++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c |  3 ++
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index fab0973f995b..c493e95e09a5 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -28,6 +28,68 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
>>         }
>>  }
>>
>> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
>> +                                    __be32 *oldip, __be32 *newip,
>> +                                    __be16 *oldport, __be16 *newport)
> 
> 
> Do we really need pointers for newip and newport ?
> 
>> +{
>> +       struct tcphdr *th;
>> +       struct iphdr *iph;
>> +
>> +       if (*oldip == *newip && *oldport == *newport)
>> +               return;
>> +
>> +       th = tcp_hdr(seg);
>> +       iph = ip_hdr(seg);
>> +
>> +       inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
>> +       inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false);
>> +       *oldport = *newport;
>> +
>> +       csum_replace4(&iph->check, *oldip, *newip);
>> +       *oldip = *newip;
>> +}
>> +
>> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
>> +{
>> +       struct sk_buff *seg;
>> +       struct tcphdr *th, *th2;
>> +       struct iphdr *iph, *iph2;
> 
> I would probably add a const qualifier to th and iph

Will do, thanks.

- Felix


