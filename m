Return-Path: <linux-kernel+bounces-159807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5698B3459
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FB4B23100
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8613F450;
	Fri, 26 Apr 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="DOiA40nZ"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD013EFE8;
	Fri, 26 Apr 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124523; cv=none; b=FS8lfA1zg3I+v+uAIaRPEAVXb1J9M4XERC49vL2CBJ8PqSbXHt9fKUPcGTKEoN9YwQrsizE711rB2fRnM7ONTlr1uJIZM74qiyQlDXYtPK9d11L+sP3VE1Srv5mdgkThfVqqbEItvqAfPKNkARNDoKefRAQwA9SvlBPgY0VQQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124523; c=relaxed/simple;
	bh=iffmhhS12mkojRuXCCXX7+sQI/+MPnrYxWoprfZ7Xa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uz1sIVHI6/tEHB9yS8hSJraS3CAYQBJzFLdtz8C2HKb9ePh6SkT6a6R+dI2CLb0Tw9cX9QHY/U8/r7+qZTEcgd25Dgw+bwcsXMozh0hNRsaelsuCd1i4385xDqgoUunldOqvi+rVdfdyYzkuUzRhcXUnEprvml3uFvO8mFqiFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=DOiA40nZ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y+7iMbyGlijD6E+68cUdUiYR7TYmH32wmsCd0z32D2Q=; b=DOiA40nZBq6wqMDCFNeAVfjD2Y
	Oj3Up4FUO4FKKj/xLSJqnpcsJxPAXmx7UvK1HQ9h+LdQVYGbWQZmv4xoNtHKpTKbxY3t8hYn6YDOn
	2BNOed2BWR0xXidS3Qh1NKOt4Rlkp+l/yixpYy4luaZl8N7YXqv55lLxM4yf3D2lycKw=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s0I5c-007t3m-07;
	Fri, 26 Apr 2024 11:41:56 +0200
Message-ID: <4d0f7392-06bf-414d-ab3e-158dc2c3f296@nbd.name>
Date: Fri, 26 Apr 2024 11:41:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next v3 3/6] net: add code for TCP fraglist GRO
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240426065143.4667-1-nbd@nbd.name>
 <20240426065143.4667-4-nbd@nbd.name>
 <17d72e2d11808ca678432749aaad7702d4d1ff8e.camel@redhat.com>
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
In-Reply-To: <17d72e2d11808ca678432749aaad7702d4d1ff8e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 10:21, Paolo Abeni wrote:
> On Fri, 2024-04-26 at 08:51 +0200, Felix Fietkau wrote:
>> This implements fraglist GRO similar to how it's handled in UDP, however
>> no functional changes are added yet. The next change adds a heuristic for
>> using fraglist GRO instead of regular GRO.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 22 ++++++++++++++++++++++
>>  net/ipv6/tcpv6_offload.c |  9 +++++++++
>>  2 files changed, 31 insertions(+)
>> 
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index c493e95e09a5..ffd6b7a4163a 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -332,6 +332,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
>>  	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>>  	flush |= skb_cmp_decrypted(p, skb);
>>  
>> +	if (NAPI_GRO_CB(p)->is_flist) {
>> +		flush |= (__force int)(flags ^ tcp_flag_word(th2));
>> +		flush |= skb->ip_summed != p->ip_summed;
>> +		flush |= skb->csum_level != p->csum_level;
>> +		flush |= !pskb_may_pull(skb, skb_gro_offset(skb));
> 
> I'm sorry, I'm lagging behind. I think the TCP flags handling here is
> correct - preserving the original ones should work.
> 
> The question a made WRT 2 above checks being non necessary/redundant:
> 
> 		flush |= (__force int)(flags ^ tcp_flag_word(th2));

This one is not redundant, because the earlier flags check includes this 
part: & ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH))

> 		flush |= !pskb_may_pull(skb, skb_gro_offset(skb));

This one looks like a redundant leftover, I will remove it in the next 
version.

Thanks,

- Felix

