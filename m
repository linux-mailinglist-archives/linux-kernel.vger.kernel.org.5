Return-Path: <linux-kernel+bounces-69265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5890A858662
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158F9283265
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65590138496;
	Fri, 16 Feb 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VY15vxuq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cDmr2Ici"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B763137C3B;
	Fri, 16 Feb 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112896; cv=pass; b=sh4uKNqvDgzjXomB58VXpGcKJDAUwuVe10LCCO+B3977SzYA0D7TosizdLU2WgCdi1czd8IIKuApUbrCPNykk822Qre1BOzNh7OKANT280f7SbqpVIqGOq0ML9fDjt3Z+I1guT4bMneoC1TUWq6cEtZC/A3vyhWUaZ3jMLR1ZQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112896; c=relaxed/simple;
	bh=XhOtdNnL6eEzH/sKAz15MgQet09Za2R2LkT+X2Dc7DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW/Nc4OuMyQLfrJFr84IhTj9bDv+3In7O/UJ8Ykq4RNjoxkZJgXhJrzzNOkHOMbs00rKPmyEA5N+XIXd4iMHQdUynVMeGugI9HBMCQI64ONmbrJOYL/Gd0RK8PwqYVrIAL8UqShBBs/DAIVZN1H9koht4rBSE61N/kYR3ekKy6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VY15vxuq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cDmr2Ici; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708112869; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KGkoHJFu2YAlYmriH2+xQyJ9nwsngEiqlNNCm1xKWUd/hVUtuwsDDRSoCsVRXXEjqP
    c89EaBZg4ku2z/c7mQD4aiz8UsdKrAhV68tq50K5MfIGIb0UFkYXCbu99DOI48lx2iOQ
    lFVspYW4wFrTAr16VzPWJjLeMK21CUfu7W3ZeKTpnd/h1tVPi6DHQVtIScOu3vEpOxbu
    rCa+o0dCTquogTQ2hIhB5e2c+Vn8qXLchjHsyE3M1H0O/RTtv8d8r1lplO3e/bC2upfC
    Zjzy87bkafLyv9PZ+i7d2gddL/xmYxUldb1H3m6/J6G6dOOZ4t/BNVke2sI0I4iUPjp8
    ldeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708112869;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9MVBjdTVYapRTGhwhTcOMWbNz5YT9tAdKc3x5vE1TuI=;
    b=qmFwEJ/zZoHWbdR5b06JvaVwBXLCdP++GsVRXYM0dkxv5xT99zfw6IeUUNVzOkE0Vd
    FJHSzm04HfzzfyU39DjhuKzbWsR6X4nsr/ZAK3+YW1UjB6aQpyRkY5UJ2Gsg1OLadj1e
    2GRzp6InNsbwkV5BdzimIdImPiDAzyGyYWBV/5CXHh2rQrGmzx/G//TFJBUTWpEAaXm7
    3HzMZM9at+LURFl72cs2jH7ynu8PUJckguYr53xQOMpa4nHdEU+NfGIsYVPYQV8dXVGX
    2HXWuGgK+rSNOk0VDZ1KDipVgB9CU8fyfKMUhG7owZNr4lgcMgYlMFwe4TGPVH8c3QgG
    DhaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708112869;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9MVBjdTVYapRTGhwhTcOMWbNz5YT9tAdKc3x5vE1TuI=;
    b=VY15vxuqw0SNGfl/4aYQdwhegCPEipJcXkOG6X0zRmiFqFept7kSaDKl11TeUFC7Jn
    Zox1bmsZUwvi7W7vi+F71ktHLhl9sFT3w42InTUdlr5tXaAw0TyF9WR7oNCHW6bVqHYo
    y6uPXAi7Agd2Bp/vizSSlQdHSWuI5/Bs8sXTeLyOHnN3Vcg2njlDMBAMpXUy9APYGk9X
    4NTTMzOptjWcoE2LQBK2Xib4v5kwwZZe5Msdj/m4nEw9CvD8co4jhm/JZp6HJy2pHfHT
    5sRkoo0ksVEnkz84Bypj2iiF5qu2oqs4qhWdRfm5Lc2O5pHy2DX9dy62tXpjdt56o2s5
    bCCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708112869;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9MVBjdTVYapRTGhwhTcOMWbNz5YT9tAdKc3x5vE1TuI=;
    b=cDmr2Icii0xVmoHQ1vM/74ocO5tbT0UTzW/SouRaYASPAy0hso+p5O0B+z9XPTioJu
    pWx1sqZR7yGn1U9FUdBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01GJlm2Hx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Feb 2024 20:47:48 +0100 (CET)
Message-ID: <12cd0fd0-be86-4af0-8d6b-85d3a81edd2a@hartkopp.net>
Date: Fri, 16 Feb 2024 20:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: softing: remove redundant NULL check
To: Simon Horman <horms@kernel.org>, Daniil Dulov <d.dulov@aladdin.ru>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240211150535.3529-1-d.dulov@aladdin.ru>
 <20240216172701.GP40273@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240216172701.GP40273@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

I have a general question on the "Fixes:" tag in this patch:

On 16.02.24 18:27, Simon Horman wrote:
> On Sun, Feb 11, 2024 at 07:05:35AM -0800, Daniil Dulov wrote:
>> In this case dev cannot be NULL, so remove redundant check.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")

IMHO this is simply an improvement which is done by all patches applied 
to the kernel but it does not really "fix" anything from a functional 
standpoint.

Shouldn't we either invent a new tag or better leave it out to not 
confuse the stable maintainers?

Best regards,
Oliver

>> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> 
> Hi Daniil,
> 
> I am not sure that dev cannot be NULL.
> But I do see that the code assumes it is not, and would crash if it is.
> So I think that, functionally, your statement is correct.
> 
> 	priv = netdev_priv(dev);
> 	card = priv->card;
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

