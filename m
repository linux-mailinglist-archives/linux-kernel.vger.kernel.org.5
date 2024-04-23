Return-Path: <linux-kernel+bounces-155603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614CE8AF4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF821C22F26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDA13D886;
	Tue, 23 Apr 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="jvwKq515"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961844CB55;
	Tue, 23 Apr 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891342; cv=none; b=gRmn6ZXpy5LMnSBVSUsDy1KkFLi2JcbdtoVNVboD2YjV3Aqj0jC6cnqm7uIIDd5hoJnwAufU11PmpBatnJ5BHy6O4NEGaftNDEF8fjbTfGmb24BiVTRBAO1O16ryFdWpnXokNI3S2+D0Bce8o++TYFnc9H/kKcegRi6aOmuJFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891342; c=relaxed/simple;
	bh=RAo4IfDAu5g0LmRE1zzsNWlD6/JX+GqMC2sW42ZFyc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1vRdJ/AIYYm2/9qMyYPhvyikVpH2Ynwzv1iulKv1vMuf/r/nNrJhLilIwfiuBN+Ic1BF0qfbHRIEk0eghL7JNkdhbefIBUz6Wc5Bk+e0CSQMZQ0BU1NayFDtaLbKUBY75IV1SRHOtIEnR5GUoMo93bl69GKoyeyurPGWlkYjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=jvwKq515; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JC6KZtDYD3PtVC2ZV8829h/PXYrLgdMvHZ2+tPN/r5s=; b=jvwKq515D/Q1FFPF45hDlJAGxn
	hs6Mc46U40oWYMQXzE/A+OfI4BaoLBJIHa3brfAseXPSTxZcvncqwrbFj3oWw9bqnyix0rrYGcTTx
	CEBy5jKn94f7HJNCDyCIsFWPQhcu1EG3VCONkmshapbShsURnehqx9ssQKh/7gVZevgk=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzJQb-006E0M-12;
	Tue, 23 Apr 2024 18:55:33 +0200
Message-ID: <328ab7b3-4890-4e0d-8b9a-fed7700f1a6a@nbd.name>
Date: Tue, 23 Apr 2024 18:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240423094117.93206-1-nbd@nbd.name>
 <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
 <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
 <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
 <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
 <97f10c8b5b615eac8f65d67ef10928d97b6b760d.camel@redhat.com>
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
In-Reply-To: <97f10c8b5b615eac8f65d67ef10928d97b6b760d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.04.24 16:34, Paolo Abeni wrote:
> On Tue, 2024-04-23 at 14:23 +0200, Felix Fietkau wrote:
>> On 23.04.24 14:11, Eric Dumazet wrote:
>> > On Tue, Apr 23, 2024 at 1:55 PM Felix Fietkau <nbd@nbd.name> wrote:
>> > > 
>> > > In the world of consumer-grade WiFi devices, there are a lot of chipsets
>> > > with limited or nonexistent SG support, and very limited checksum
>> > > offload capabilities on Ethernet. The WiFi side of these devices is
>> > > often even worse. I think fraglist GRO is a decent fallback for the
>> > > inevitable corner cases.
>> > 
>> > What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST_GRO already ?
>> > 
>> > Many of these devices are probably using NAT.
>> 
>> In my tests, nftables NAT works just fine, both with and without 
>> flowtable offloading. I didn't see anything in netfilter that would have 
>> a problem with this.
> 
> I see you handle explicitly NAT changes in __tcpv4_gso_segment_csum(),
> like the current UDP code.
> 
> The TCP header has many other fields that could be updated affecting
> the TCP csum.
> Handling every possible mutation looks cumbersome and will likely
> reduce the performance benefits.
> 
> What is your plan WRT other TCP header fields update?

I think that should be easy enough to handle. My patch already only 
combines packets where tcp_flag_word(th) is identical. So when 
segmenting, I could handle all flags changes with a single 
inet_proto_csum_replace4 call.

> Strictly WRT the patch, I guess it deserves to be split in series,
> moving UDP helpers in common code and possibly factoring out more
> helpers with separate patches.
Will do.

> e.g. in __tcpv4_gso_segment_csum() is quite similar
> __udpv4_gso_segment_csum() - even too much, as the tcp csum should be
> always be updated when the ports or addresses change ;)

Will fix that.

Thanks,

- Felix

