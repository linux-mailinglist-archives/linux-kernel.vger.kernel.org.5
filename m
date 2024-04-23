Return-Path: <linux-kernel+bounces-155111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE348AE564
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70101F242AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAD13D8B0;
	Tue, 23 Apr 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="O6rtlvr2"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474612E1EA;
	Tue, 23 Apr 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873328; cv=none; b=aBZONhP0YPg4XbOmdnnnKieyfG+vkJ6O/3PIlRS7gJb4TtNesELXshIcBMPxQjg5Xadix/stY36o5OXu0uDlVSUlL8GU+0/nmGc/7d0zxb96lNRDuVMAVlrErF+eV9V00QfTboD+O0qBBUQk96WIS422DV4FzXIV18w/87jmlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873328; c=relaxed/simple;
	bh=nFPR/DbC8cJ0K8TZ4OVVLfca4UPf5sag1TOSws6aqzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5b70XjqN4OQjnpQPSIBxHEhde9yzS5MYg8nSEhzdnJE5SLaLi+O8c3+iJSuMa9wMMWQB7IPGDb0zKEa8ZPOu0Oo9CneYXc3Ut9bhYtMj1Sw5+LC+McNdxIQAgPOBMUua+jIUXCLUj6a7QbP7AZo+TL4hPL/E8i8YEY/hSDM7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=O6rtlvr2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tL4juWEwXwyda0igPZvP7Eh/zgw2setXuW+VBu9ZRFk=; b=O6rtlvr2bbEA0Nv6U13IsSVLuq
	YovVNpOcViwZ99gxG7fKe9NbRpFf8K9kS/o6BH3LKTb9knMNuSsIsCvXbgmEtaxnfDsVoo0BosUKo
	YCI14mPG3HRrAO29UzUeZR7vBmAFhrr5vVsWq/7anbiqpJq51E8QldQPhV3WY8Kf4ppQ=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzEk4-0065cN-1N;
	Tue, 23 Apr 2024 13:55:20 +0200
Message-ID: <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
Date: Tue, 23 Apr 2024 13:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
References: <20240423094117.93206-1-nbd@nbd.name>
 <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
 <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
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
In-Reply-To: <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.04.24 13:17, Eric Dumazet wrote:
> On Tue, Apr 23, 2024 at 12:25 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> On 23.04.24 12:15, Eric Dumazet wrote:
>> > On Tue, Apr 23, 2024 at 11:41 AM Felix Fietkau <nbd@nbd.name> wrote:
>> >>
>> >> When forwarding TCP after GRO, software segmentation is very expensive,
>> >> especially when the checksum needs to be recalculated.
>> >> One case where that's currently unavoidable is when routing packets over
>> >> PPPoE. Performance improves significantly when using fraglist GRO
>> >> implemented in the same way as for UDP.
>> >>
>> >> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
>> >> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
>> >> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
>> >> 1Gbps.
>> >>
>> >> rx-gro-list off: 630 Mbit/s, CPU 35% idle
>> >> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>> >
>> > Hi Felix
>> >
>> > changelog is a bit terse, and patch complex.
>> >
>> > Could you elaborate why this issue
>> > seems to be related to a specific driver ?
>> >
>> > I think we should push hard to not use frag_list in drivers :/
>> >
>> > And GRO itself could avoid building frag_list skbs
>> > in hosts where forwarding is enabled.
>> >
>> > (Note that we also can increase MAX_SKB_FRAGS to 45 these days)
>>
>> The issue is not related to a specific driver at all. Here's how traffic
>> flows: TCP packets are received on the SoC ethernet driver, the network
>> stack performs regular GRO. The packet gets forwarded by flow offloading
>> until it reaches the PPPoE device. PPPoE does not support GSO packets,
>> so the packets need to be segmented again.
>> This is *very* expensive, since data needs to be copied and checksummed.
> 
> gso segmentation does not copy the payload, unless the device has no
> SG capability.
> 
> I guess something should be done about that, regardless of your GRO work,
> since most ethernet devices support SG these days.
> 
> Some drivers use header split for RX, so forwarding to  PPPoE
> would require a linearization anyway, if SG is not properly handled.

In the world of consumer-grade WiFi devices, there are a lot of chipsets 
with limited or nonexistent SG support, and very limited checksum 
offload capabilities on Ethernet. The WiFi side of these devices is 
often even worse. I think fraglist GRO is a decent fallback for the 
inevitable corner cases.

>> So in my patch, I changed the code to build fraglist GRO instead of
>> regular GRO packets, whenever there is no local socket to receive the
>> packets. This makes segmenting very cheap, since the original skbs are
>> preserved on the trip through the stack. The only cost is an extra
>> socket lookup whenever NETIF_F_FRAGLIST_GRO is enabled.
> 
> A socket lookup in multi-net-namespace world is not going to work generically,
> but I get the idea now.

Right, I can't think of a proper solution to this at the moment. 
Considering that NETIF_F_FRAGLIST_GRO is opt-in and only meant for 
rather specific configurations anyway, this should not be too much of a 
problem, right?

- Felix

