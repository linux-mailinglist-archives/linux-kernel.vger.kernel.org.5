Return-Path: <linux-kernel+bounces-71990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83F85AD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE8BB22745
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C153E33;
	Mon, 19 Feb 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ki5jJ4a0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hpGTBR9W"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442A2E835;
	Mon, 19 Feb 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708376871; cv=pass; b=XzmhyyLLOnpOC4fCHhDCca0Ndh7rAN6lchE5uEp7e2vQm7eX1zFu90SB/JoAzDCTsriEVKnn/RabjYDehE7j5wNKSHXJaJTkaWLuyvDjbxhkcKkeN53PFaUvoY61pQSJbenb+kwCWjIJ7j1WdkT4OUL8ak/3ZuCgSUDlUfnaC8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708376871; c=relaxed/simple;
	bh=eNljqwevEksOUMlEebSE8qxQgsP5d/5/H18BupVK6+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SA7JdWWPDe3dIZBnEQjGNziVVourjtuU0BHnPGjSL+91RoY602Pop7/rDLQSc3S/FI464lBPQ1j5kxkJganLcrpwj4OTbP/3puvQvIbh5cEINkjbG6KnAt16P2/iO5AL58sqU/AapRx4x8noX/xhXOVWIZmUWO6CSIVceWu2rJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ki5jJ4a0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hpGTBR9W; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708375067; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RLoVMLhRCUjEZnzpW3aKBpfB2VpJwlSQuQFYGmFSmyOKvtye0tQjX13oiqK6acTNKZ
    ARg0EctxXyRO3A/OqoQk8RwolS2Tpd4nG9CqsOoamSAKzW4Ya/Om1+/N5wD2Ta6mIDbp
    kMcNa4tDkX54shueRnW3016MvLaxpXEDNW9Q+tg2jOypJ8ModkvXBt57P9L0K/oOz5/E
    m3A2zZIeThrzGav1iC4qF9hXwL57U2nrdYsee0n9R17SqhZM/AdxhRoUlyQEVuMsfOas
    Hpw5sQYiMXEqYXbNWSwFoQQsER0C61apF3cwgFejRn9slJnvMgwDO3gD4MG0t3nxRGD7
    4AcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708375067;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Fv4HUwoYJ78Ao5yyDcK+Lz6h+c9zEeTZIGoLl7li1Rw=;
    b=iIxqFJrFnfjERZhfAjhFKwzM7bCpXWkvPNHxMVYWR21X+ZdAT/kAxtkQ4deYzBH30W
    ciMwYWyemRU0vLfCI23ZKlI3kIBniPQGZc1/BHDNBpdP0LDKyHDIHmKs5Cn1PVo3ViRj
    db0tX/cbyZnBh4NjuxQyyLVXDVPqbPVjsN/dLvsDcSAQjTTDjP6bOKr+ktwDbyRYrtzP
    ulcLhJok15ZjfuaQx86hoMlkf4fBP9ppmaPoNIy+tdKAKxmedJms0n1Fx6OpmKOd9sKE
    v2n6z5UQ+iGzt04Ei/WVO7w8ZZtSvSrtnvXfOrPhxVWQrWiulgGQX6OhW0fZEjydINJs
    xyfw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708375067;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Fv4HUwoYJ78Ao5yyDcK+Lz6h+c9zEeTZIGoLl7li1Rw=;
    b=Ki5jJ4a0ISlzbCYHqEjTRNXBFq1CXKzI/Padmw8s8rzprr5JAOab26Q86qI/7868Rk
    lu0GmcOPWDvVXuNYRKkIkrO0ZskonOQ498yTWica2qgRuPV8R9A9dm9eRxSnqfT353RY
    K566A8yiAkTC6MJ21ErjTt1zyf+6TJ1/YDHb9u15j/ZQT+o04sVnXrG8Oel1Q8sIxP2N
    8y8AaRaM6WgOl4080G+kCj+x3z9XxEtn6PbS5nQANi8Bop6YNCimMmIOFk9CQbHnZZGA
    USDsOiQRuw3WVMOKGtpHtIuU6p14gZUjmEA8qMZ8whdVIaX6TR55NAY7VDJUTMbtqBZ8
    GwIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708375067;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Fv4HUwoYJ78Ao5yyDcK+Lz6h+c9zEeTZIGoLl7li1Rw=;
    b=hpGTBR9WEO3/nloOvwsmULD0/vv6szH/ypkVJ0Qtir7LqLyWjkXUHGlvHY0rxwFGIQ
    k2emtWXlYz0tO6oTAGCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01JKbk876
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Feb 2024 21:37:46 +0100 (CET)
Message-ID: <e9f2c716-51d3-4c03-a447-9fed357669c5@hartkopp.net>
Date: Mon, 19 Feb 2024 21:37:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: softing: remove redundant NULL check
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Daniil Dulov <d.dulov@aladdin.ru>, Wolfgang Grandegger
 <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240211150535.3529-1-d.dulov@aladdin.ru>
 <20240216172701.GP40273@kernel.org>
 <12cd0fd0-be86-4af0-8d6b-85d3a81edd2a@hartkopp.net>
 <20240219170038.GH40273@kernel.org>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240219170038.GH40273@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

On 2024-02-19 18:00, Simon Horman wrote:
> On Fri, Feb 16, 2024 at 08:47:43PM +0100, Oliver Hartkopp wrote:
>> Hi Simon,
>>
>> I have a general question on the "Fixes:" tag in this patch:
>>
>> On 16.02.24 18:27, Simon Horman wrote:
>>> On Sun, Feb 11, 2024 at 07:05:35AM -0800, Daniil Dulov wrote:
>>>> In this case dev cannot be NULL, so remove redundant check.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>
>>>> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
>>
>> IMHO this is simply an improvement which is done by all patches applied to
>> the kernel but it does not really "fix" anything from a functional
>> standpoint.
>>
>> Shouldn't we either invent a new tag or better leave it out to not confuse
>> the stable maintainers?
> 
> Hi Oliver,
> 
> sorry for missing that in my review.
> 
> Yes, I agree that this is probably not a fix, for which my
> rule of thumb is something that addresses a user-visible problem.
> So I agree it should not have a fixes tag.
> 
> I would suggest that we can just change the text to something that
> has no tag. Something like:
> 
> ...
> 
> Introduced by 03fd3cf5a179 ("can: add driver for Softing card")
> 

Yes, but the "Introduced-by:" tag would be an optional tag for people 
that like blaming others, right?

IMHO we should think about completely removing the "Fixes:" tag, when it 
has no user-visible effect that might be a candidate for stable kernels. 
It is common improvement work. And it has been so for years.

Best regards,
Oliver

