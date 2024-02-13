Return-Path: <linux-kernel+bounces-63028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BE85297F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559D7B234BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2193A168D8;
	Tue, 13 Feb 2024 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UdBo+yNJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D114296
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807552; cv=none; b=YpGzVKwc8Qz0q7I/fh9POGhwG6PjpGTxjejpFVWIBAjCF2VN9UC4roLP8u06sox9dsIOxYydncAiNUQmnu+25kvtGV3akrkJWl2KL9/RfBda1mbs1tDeQN4/macmWSFc+pOz/PYnDqm1rBfjccf11qE6F5kJLrcRt1Bgnts7fGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807552; c=relaxed/simple;
	bh=2PCqVnulVRtxfKX+jOse4rhJ+xP6/Ap/a+/UZoa0fQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8ioJPJDIsuwKOaqzYzkWVu+Hv89WFmO0+JtCtEtK8QIazDTGIIO38cCQ8aSi5s0DlFs7Akp2qWRzGk0vqka1QZGytX6jKZt3wWSFXdVmvj6tRRogfXnQmVWTTYtm0XmQd+/fT9ajnw7QMK2NUp0H1dleaH5253et1GVdm4zvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UdBo+yNJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51167e470f7so4846343e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707807548; x=1708412348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCpik2vbbKYs8wNuTcz5Utg4u+f8GdmePgUExwK1BdQ=;
        b=UdBo+yNJ9QLaKC/+6VdknpwLvLi6xWcWgQHhSDrCDAQm2lKjm79jQ5gqtRu6K/cQCq
         IJ2SThK3ClzIvQsNpu0KHN8qj+G1OO5YxtBHhSjg/N8kb65vVFbfrRqU9pl39mRYG36d
         u4RgDBUQifw9F6kPCt+eqpOv4YJRTZUlQtdYpqboetuqQqfjJ9nmWUVHEDkSMPJQerFT
         3qEOvHZrh65430mgn0hoZt7yVFDEeqwY0wnCO/pFsq/aPd7K0i/Z8g7/TlJaUs+uYRj8
         alkYc2kCTIcynuhWuQcT8qGHNoSxa2pt5lGndE0FfiRa+nFjvC0EKye3t/Bl5Sq4hSXj
         3XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707807548; x=1708412348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCpik2vbbKYs8wNuTcz5Utg4u+f8GdmePgUExwK1BdQ=;
        b=hZCCKo7bGmx9haZwQtznwwaSTP6xrALaS5o5aqWRFFLaFYfLAKikW2hp0FKyF4s+oG
         ahMdE/Y0ugt4tjyLTDt4wF8t6glpVdrZqoAyc6SZuLJyb6c2cs7rSFIjmynJMBc9dh7d
         fzJlSeBcu27KlIrK6dWYjp9iqPgRKevDeRZuLghhCD169A22Ppj92tUD+Qy122G/y9tF
         EYuEIzQ8nlNPfJqWWTF9l5Q8szbLPXlH3kNArLO14+4bXMQMY/TMpgsVWTeuIKcbQmC+
         3xZSnVh0+dWFjYUP7C6gnGNydTwmpF7iMPkDFEcBLwjus9WAD7Z9TTNrp1ZRljbe9RfX
         p0ng==
X-Forwarded-Encrypted: i=1; AJvYcCXqCMcgqWrKLp3GLeLAjZt5EnjysVeTzmpfelcUfLuNrSl8NQC1thTvoyI0mVx7/JFxTq9mtcXWodrvEPAfJ8yR6TqqTnp1kMdSaTqn
X-Gm-Message-State: AOJu0Yz1OoUcnPuSDmlJBETQOavYuRUr/eaqgJ7aFdyYXXifmBNfp01i
	H+T9PGIjTs/l3THz69G/BfMjZIACuc0hK5dqiexGh/HG0GdaUwa0HruHIxKaRV0=
X-Google-Smtp-Source: AGHT+IGjoR6hnuW3OcU7aaaNQQGAb1sYfgR0pKAvTNOwt2TZKbeYNaZcfd7E/xxMPgIQxROm5H3D5g==
X-Received: by 2002:ac2:4ac9:0:b0:511:7b35:9563 with SMTP id m9-20020ac24ac9000000b005117b359563mr5107781lfp.19.1707807548051;
        Mon, 12 Feb 2024 22:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKCgnNjA3S3HjaBNCWy4Q7NMoxP44y3hLRWT+ar5k56QUm1zE49O7IEG5sLc+/NOhJ4fpoY92In49wVsupq47PjBfjKOC1EC3TWATyuRXUBqfk0PLnLtrZZkzQ+XXO/B0SJzetreNhVaRLYcelZp/CFRvvcs0gEveAmnsFX1wyPjQah3lnSGQ1icwmCaZSeRliPh4EkMWpElkETJT+PWZw7iLF4gjH76HC2NquanHezRgt8jIV4IarqOBuFjrARt+VERH6J9Nilmw5kZhgQrk4q+/Z0O8FazdWUz+etl8bDvT8bVetEjxxMfEViDo3gfomPzsh+PG8c6A=
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b004106c2278eesm10839306wmq.0.2024.02.12.22.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 22:59:07 -0800 (PST)
Message-ID: <6a024193-e8bd-4458-9fb4-2aa44e1f4513@tuxon.dev>
Date: Tue, 13 Feb 2024 08:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] net: ravb: Add runtime PM support
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
 <20240209170459.4143861-6-claudiu.beznea.uj@bp.renesas.com>
 <3808dee0-b623-b870-7d96-94cc5fc12350@omp.ru>
 <7d0ae75d-2fdb-47cb-b57b-20ee477d6081@tuxon.dev>
 <1990e269-44fe-b45f-09b5-0c84f21778fc@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1990e269-44fe-b45f-09b5-0c84f21778fc@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.02.2024 22:19, Sergey Shtylyov wrote:
> On 2/12/24 10:56 AM, claudiu beznea wrote:
> 
> [...]
> 
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Add runtime PM support for the ravb driver. As the driver is used by
>>>> different IP variants, with different behaviors, to be able to have the
>>>> runtime PM support available for all devices, the preparatory commits
>>>> moved all the resources parsing and allocations in the driver's probe
>>>> function and kept the settings for ravb_open(). This is due to the fact
>>>> that on some IP variants-platforms tuples disabling/enabling the clocks
>>>> will switch the IP to the reset operation mode where registers' content is
>>>
>>>    This pesky "registers' content" somehow evaded me -- should be "register
>>> contents" as well...
>>>
>>>> lost and reconfiguration needs to be done. For this the rabv_open()
>>>> function enables the clocks, switches the IP to configuration mode, applies
>>>> all the registers settings and switches the IP to the operational mode. At
>>>> the end of ravb_open() IP is ready to send/receive data.
>>>>
>>>> In ravb_close() necessary reverts are done (compared with ravb_open()), the
>>>> IP is switched to reset mode and clocks are disabled.
>>>>
>>>> The ethtool APIs or IOCTLs that might execute while the interface is down
>>>> are either cached (and applied in ravb_open()) or rejected (as at that time
>>>> the IP is in reset mode). Keeping the IP in the reset mode also increases
>>>> the power saved (according to the hardware manual).
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> [...]
>>>
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index f4be08f0198d..5bbfdfeef8a9 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>> @@ -1939,16 +1939,21 @@ static int ravb_open(struct net_device *ndev)
>>>>  {
>>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>>  	const struct ravb_hw_info *info = priv->info;
>>>> +	struct device *dev = &priv->pdev->dev;
>>>>  	int error;
>>>>  
>>>>  	napi_enable(&priv->napi[RAVB_BE]);
>>>>  	if (info->nc_queues)
>>>>  		napi_enable(&priv->napi[RAVB_NC]);
>>>>  
>>>> +	error = pm_runtime_resume_and_get(dev);
>>>> +	if (error < 0)
>>>> +		goto out_napi_off;
>>>
>>>    Well, s/error/ret/ -- it would fit better here...
>>
>> Using error is the "trademark" of this driver, it is used all around the
>> driver. I haven't introduced it here, I don't like it. The variable error
> 
>    Heh, because it's my usual style. Too bad you don't like it... :-)
> 
>> in this particular function is here from the beginning of the driver.
> 
>    I think it's well suited for the functions returning either 0 or a
> (negative) error code. It's *if* (error < 0) that confuses me (as this
> API can return positive numbers in case of success...
> 
>> So, I don't consider changing error to ret is the scope of this series.
> 
>    OK, you're probably right... are you going to respin the series because
> of Biju's comments?

Yes!

Thank you,
Claudiu Beznea

> 
> [...]
>>>> @@ -3066,6 +3089,12 @@ static void ravb_remove(struct platform_device *pdev)
>>>>  	struct net_device *ndev = platform_get_drvdata(pdev);
>>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>>  	const struct ravb_hw_info *info = priv->info;
>>>> +	struct device *dev = &priv->pdev->dev;
>>>> +	int error;
>>>> +
>>>> +	error = pm_runtime_resume_and_get(dev);
>>>> +	if (error < 0)
>>>> +		return;
>>>
>>>    Again, s/erorr/ret/ in this case.
>>
>> error was used here to comply with the rest of the driver. So, if you still
>> want me to change it here and in ravb_remove() please confirm.
> 
>    No, we are good enough without that; I'll consider doing a cleanup
> when/if I have time. :-)
> 
>> Thank you,
>> Claudiu Beznea
> 
> MBR, Sergey

