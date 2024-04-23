Return-Path: <linux-kernel+bounces-155154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1D78AE5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687A7287011
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8428593B;
	Tue, 23 Apr 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="OnCy526W"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563D8405C;
	Tue, 23 Apr 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875021; cv=none; b=lKL9KssRkCGsCP0FZV2nyverT9AH4WXSrXnX1VlS9krLJJg6zzQtcl01g3z4yFxa8jH9URUl/R7VOKIAp2prv+Utuc12oZzDfm0lv7uhDtDdWM2GAc8+zYunDtGIMnsJ3Bm1sZohuOZPsiKf5ET6lWK396Xjvli7Pr2flfZkLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875021; c=relaxed/simple;
	bh=9mJZ62l2+7SP3ReX1gQJjaQNcoPHMtLwRRBOZfEeAhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFkTvW8xTbPEPFyEonNE4H4NSSBVyI36VRYoQQMnU7Y28n8i5Qb2u8lgr13negTaKJiy3CY59RNUoT0SpkGPC7INNBvmqhv+q4WL4pZ8NdIDat3kbxanwwPerveiRrUJz7CzM3TqokuKjaCf4AEvVhUHpXU74CqsPp+m40RAsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=OnCy526W; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/DSRa/6jf8NZlb//FM+oy5i4OZYimdjhlzNTdhVYxvI=; b=OnCy526WuugtHWZ18i2/UEYnqJ
	ZyNODvLnguJeIzJ8hFaMqeRHZWDsWjlQ8FALHfehs8k5PCwqJjBy9CXJjSFxmGtUGmYVY1o5KomPf
	Ddmf/yErTtDqyuS9NPAzHc5i2f+nIYT7Xduq3zRTJDklIoIbCOzCPJFdpm/0RDhgPRbc=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzFBN-0066eH-0X;
	Tue, 23 Apr 2024 14:23:33 +0200
Message-ID: <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
Date: Tue, 23 Apr 2024 14:23:32 +0200
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
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
 <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
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
In-Reply-To: <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.04.24 14:11, Eric Dumazet wrote:
> On Tue, Apr 23, 2024 at 1:55 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> In the world of consumer-grade WiFi devices, there are a lot of chipsets
>> with limited or nonexistent SG support, and very limited checksum
>> offload capabilities on Ethernet. The WiFi side of these devices is
>> often even worse. I think fraglist GRO is a decent fallback for the
>> inevitable corner cases.
> 
> What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST_GRO already ?
> 
> Many of these devices are probably using NAT.

In my tests, nftables NAT works just fine, both with and without 
flowtable offloading. I didn't see anything in netfilter that would have 
a problem with this.

- Felix

