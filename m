Return-Path: <linux-kernel+bounces-42841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B284840793
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC95628C256
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EB65BAC;
	Mon, 29 Jan 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hROZEAOj"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD5657B5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536560; cv=none; b=l7AWV+Or0QY5iSJoDEJJfykZMGeKxeJ4y3726Hl0LfdEwhlGQEBbahVqBitpLCBYTgkpxQE54w6lYyBFSnZZ4//9DAlEn7Elbw683PUvr2HWyGVgTbMYM1KG5W4yHo1BKoLicvvM8XKbXZ5pNgcKCqyrH1VlFdhMlYkc7Xm0gyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536560; c=relaxed/simple;
	bh=0kU0XJcwqyXCVZxm+kFwwNR3JQ+C+nscVOHBvBX63BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzjrCGI2aLxKBmY4BPmhpfM0baYv57oXibwEIYEkFDBcEGK7bXtcbZOK+d4uXOHWsDB9S2+KNkK4i2auOh9DhmJ+gkInq1eBBRHFUOXpri0rV7TquFS2WLBmTQT/4l7ach77Xbt7+rO7FuLsXzDim1dDTb1epv+D1YLZAX+zDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hROZEAOj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3566c0309fso177641666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706536556; x=1707141356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2pjxJTJw4PCQDkxC6JWUuLXXl1QpeecImfpOYgGbFk=;
        b=hROZEAOjLz3J60bpDQybqKcOKTAfOfCWZM1ktDfBXG9EqRZZRx+KL5llybC2WYa2Ze
         hRkajEAO8ntFw39Oq+MQb0XPtC24dmYmYrSu5wC+VniBLDRbCLedDWd5B4mEaIP61Phx
         9c03UmMFs9oScGcL9ey3d9swu7NnWAjV1124iDSjmzXhfMBUo7w1SJoBBXCTbea64kMt
         VRqi8PNdIjXSkegMXHfvAZ40TrC7NPFf6yO6rT0vI+aSeFyiqK/T6JP+YCikybSrUZf7
         hfSeNPI1VQz1v4c6lZMt4zXEttgLj8Ew6XEwH5/anW+zRG0vQnpvOjJm1qJnEFuy5gEl
         LttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536556; x=1707141356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2pjxJTJw4PCQDkxC6JWUuLXXl1QpeecImfpOYgGbFk=;
        b=lfx6Hiwmgbwrs3JZAGolgdB9FtpY+1bPexFgqdmnEZCDSpDz9smLpg1kDLR49lJDoL
         ELHaJQfXA7cFDwnIZWzjul16ybUAKSoK2yNqI1hsrM1ffvfuHcHNv7tlnTbRW1ImtbNl
         8odHuKEVVadUXih8J8VI9Is8D8NWVyX+5najQFXPeoe7F8FoeWnQd4XoYrW/7vFMCSvR
         lezH460hWB/EFHalr9GBUgewTCc9rX8axYQk99dX423NemNxsAB+DjGBkjfDeLcV/j22
         k1JqZE91qga15JCDvXMFtqcfsQpPCcoMp5Fr+8bwRsPPyqtzjc9CXyHZeHBpH8xj1n00
         wtyg==
X-Gm-Message-State: AOJu0YzhUIvX5b0+oCxXuBbHpBovut/BdRntKfKJrA9AKPxVJ/HFru6/
	XOJ3JmjlwNlqYxYmloVYxa1UEWVNFGGAlUbjiV67lZwXRwnYbG0Ecqj3OX5hJ8o=
X-Google-Smtp-Source: AGHT+IEdvnhMQ/CDu0i2JcMjQ93Mjck1u0vYpVh300T2TKQ++pg6Wjm5npTJCOfGrbQJZ3bPR/M7rw==
X-Received: by 2002:a17:906:b0d:b0:a35:dafa:a5d8 with SMTP id u13-20020a1709060b0d00b00a35dafaa5d8mr1224292ejg.73.1706536556328;
        Mon, 29 Jan 2024 05:55:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id vx6-20020a170907a78600b00a35ea4a21e8sm425895ejc.2.2024.01.29.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 05:55:55 -0800 (PST)
Message-ID: <1c680be4-67b7-435b-9609-b5f7a45ca675@tuxon.dev>
Date: Mon, 29 Jan 2024 15:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 10/15] net: ravb: Move delay mode set in the
 driver's ndo_open API
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
 <20240123125829.3970325-11-claudiu.beznea.uj@bp.renesas.com>
 <b0a4f320-6218-2631-a5a0-26cfa9a25ee1@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b0a4f320-6218-2631-a5a0-26cfa9a25ee1@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24.01.2024 22:18, Sergey Shtylyov wrote:
> On 1/23/24 3:58 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Delay parsing and setting were done in the driver's probe API. As some IP
>> variants switch to reset mode (and thus registers content is lost) when
> 
>    s/registers content/the register contents/, perhaps?
> 
>> setting clocks (due to module standby functionality) to be able to
>> implement runtime PM keep the delay parsing in the driver's probe function
>> and move the delay applying function to the driver's ndo_open API.
>>
>> Along with it, both delay specific functions were kept together.
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 8956c33c60e2..69d4854d6738 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -1800,6 +1800,59 @@ static int ravb_compute_gti(struct net_device *ndev)
>>  	return 0;
>>  }
>>  
>> +/* Set tx and rx clock internal delay modes */
>> +static void ravb_parse_delay_mode(struct device_node *np, struct net_device *ndev)
> 
>    Wait, why are you moving this? Its call site didn't move -- it's still
> down in the probe() method...

As explained in the patch description ("Along with it, both delay specific
functions were kept together.") functions were moved closed to each other
to have the code dealing with delay in the same place.

> 
> [...]
>> @@ -2785,10 +2793,7 @@ static int ravb_probe(struct platform_device *pdev)
>>  	if (error)
>>  		goto out_rpm_put;
>>  
>> -	if (info->internal_delay) {
>> -		ravb_parse_delay_mode(np, ndev);
>> -		ravb_set_delay_mode(ndev);
>> -	}
>> +	ravb_parse_delay_mode(np, ndev);
>>  
>>  	/* Allocate descriptor base address table */
>>  	priv->desc_bat_size = sizeof(struct ravb_desc) * DBAT_ENTRY_NUM;
>>
> 
> MBR, Sergey

