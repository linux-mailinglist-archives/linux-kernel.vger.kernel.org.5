Return-Path: <linux-kernel+bounces-154859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE148AE217
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F232832CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EB64CD0;
	Tue, 23 Apr 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Sdkb0v8A"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B95CDF2;
	Tue, 23 Apr 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867941; cv=none; b=SvZPreLDrTdZyc9AjON+dSJJbgIJoRwKyHFwl1fikir7lS/G7Ta/pYsYeWJbYE9yFXujkSWESOJQmwocdkhIPoh69ntueISkTanCEZyKkymPLzYmfcVDKFagxuorff7WhBaR/f8kpzTD5+Dm6QOv6VMcqe/XCcEOGnYdlmw2Aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867941; c=relaxed/simple;
	bh=Y8f5+YKLqjKKXsFmgIr/oOVxZIeWK6XAH8GXTpW6zo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLlRBL7soTniS5uYvronqlR1zBwOl3IOmuK8q5v7tcOWT/2JXh9w++sWOyo6MCkNnAOhlGcHCJbOx73yxbivUy4bR1X4AmIc1j9MWBnQdmFmjicwnpk694iiDWqdt/2KSI3ZFp6CS8SWVCACZZtCw7AVB4oMK1UoQg9ugiws9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Sdkb0v8A; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e6sfNgyyq3CP0DjLtTP2ZBLYSGUFE+AaTMTxRx7+2Mw=; b=Sdkb0v8ApZ8eALsQJahEXgrNj4
	7EOx8+0/ILDg5MFyUY/fHFjMDPTuFRY1+r2zZJ+t7ZQDD4vFNuEQiImMbhMm489QKlTkkMl3UE10/
	KQxnokWGZdgrO6TFW0SSATzzFXlYVFvcfgnt+DY5y0iggp65fnsH3HBnNiJ62OSzWITc=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzDLB-0061vs-11;
	Tue, 23 Apr 2024 12:25:33 +0200
Message-ID: <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
Date: Tue, 23 Apr 2024 12:25:26 +0200
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
In-Reply-To: <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.04.24 12:15, Eric Dumazet wrote:
> On Tue, Apr 23, 2024 at 11:41 AM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> When forwarding TCP after GRO, software segmentation is very expensive,
>> especially when the checksum needs to be recalculated.
>> One case where that's currently unavoidable is when routing packets over
>> PPPoE. Performance improves significantly when using fraglist GRO
>> implemented in the same way as for UDP.
>>
>> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
>> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
>> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
>> 1Gbps.
>>
>> rx-gro-list off: 630 Mbit/s, CPU 35% idle
>> rx-gro-list on:  770 Mbit/s, CPU 40% idle
> 
> Hi Felix
> 
> changelog is a bit terse, and patch complex.
> 
> Could you elaborate why this issue
> seems to be related to a specific driver ?
> 
> I think we should push hard to not use frag_list in drivers :/
> 
> And GRO itself could avoid building frag_list skbs
> in hosts where forwarding is enabled.
> 
> (Note that we also can increase MAX_SKB_FRAGS to 45 these days)

The issue is not related to a specific driver at all. Here's how traffic 
flows: TCP packets are received on the SoC ethernet driver, the network 
stack performs regular GRO. The packet gets forwarded by flow offloading 
until it reaches the PPPoE device. PPPoE does not support GSO packets, 
so the packets need to be segmented again.
This is *very* expensive, since data needs to be copied and checksummed.

So in my patch, I changed the code to build fraglist GRO instead of 
regular GRO packets, whenever there is no local socket to receive the 
packets. This makes segmenting very cheap, since the original skbs are 
preserved on the trip through the stack. The only cost is an extra 
socket lookup whenever NETIF_F_FRAGLIST_GRO is enabled.

PPPoE in this case is only an example. The same issue appears when 
forwarding to any netdev which does not support TSO, which in my case 
affects most wifi drivers as well.

- Felix

