Return-Path: <linux-kernel+bounces-59024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9758284F003
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5425A283516
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B55730A;
	Fri,  9 Feb 2024 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Xmlafq33"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764056B86
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707457727; cv=none; b=BuL4iboBAo8kXN1mhkJxve0iQOJPpkbj9nAnDWmWf4EkWv2jXkbZvO7JORPgSiXIOGZJhnMd+u4Ph9ZiDDwHqE4CktIq536iFtoAjq58X4KOJBr/di7J9UN6PiZ6Zu8acegdWc//t0DAxdacPzV/lZUcZPFwz0NK28A8Kf9D8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707457727; c=relaxed/simple;
	bh=nmD3BwatGhYAlv4NhN2ZIYh92q6PNgmm207o5l1juhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7u+YH2lx7fm3rV5BkSq/QrqVWZwBiFNYlqOBQWP025Pp8SSWLpmLc8zl0AoG56Oe+xh7gpvQtf6LjlL6+vf9Rphqb0wMEX1Dfpt1KPWqdptrBVoGi8pzo8g0+RoaW3S+wZGDDAZHPq5ad0uuakeuMfmkNfDqPRW5c27RjcYpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Xmlafq33; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41068e36cbbso1809875e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 21:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707457722; x=1708062522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxSyZICm/I5GO8I9p/NPQ1lnFZnR704Xte4TLK0i60g=;
        b=Xmlafq33YUb/YT8weqfjltgBZZVULw3HqtsvvVxDC5j4JVPoqC1q4GS7o/Oqy8v0Yd
         uxy9cpPpllAnun8rx9Rb32+54pfGSQJVMWiDpvtXSqXQb2VgmBEog4JCmrFHPGVsE4DN
         RRKBIO3o0AvNuDQ7o3LYFZYHtLWnRaQpYGiEVUF0r77P2zF/XpXW1mxNBrTPFQL+PilE
         eY03O5Dxuq/o7VT+IaywEEYwlkSef8Y+C2GqqwQSbVsUNwVgc+adV1LCtjeXEDrsI7Xp
         1upIy+uRi7idAmNU97alSBh/gLpeM3D0YkWDumwiv1+BxdtOowcVoYOJByxlXWUGXyfW
         94Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707457722; x=1708062522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxSyZICm/I5GO8I9p/NPQ1lnFZnR704Xte4TLK0i60g=;
        b=O31ojRnG/NqWrv4iOarCBntCGaISBD1OdBuF0+NTzNT16lqBSsoOSAlHK8PnHS3fJM
         8EN1X/gn/bTkSKhPcDSUPyyT2AQ+1/s/J5wFx7vb55/kI/pObbG3t/PhJXjUIgjCqg7n
         trWB8ZEoIBVKXkU/4bm5Cj8pRT1x6AUkR3DbE8sAVPZKJThJnO49ePU+RY2nCXz3kp7+
         hH1pspuaAQiDH4UHCM/lowxZDAcWc3Xgh6Gl5sGGF3sL2MZSdXHxFkRbj1zBxWoZt+OR
         chS6TQavYyUxao6p/hCYg2wl3aQx2+pgNYRBM17xqgttFX5xylkoOxIYJpNaZfjyA6VZ
         Yy8g==
X-Gm-Message-State: AOJu0YzhnMFCwa6n8yGTYtiNQpnNHuxwk4+15VMTZFI5gmUv1rpllF7u
	s53hJCtAs1uacogIaRBmFf/MVXyZ2VydfSEkj0UIbB6FUXBVHKyUkiV2dpz5CwY=
X-Google-Smtp-Source: AGHT+IGYS5H+2CjG8e6jjJum1vd6pG6x4LD1FMRK/cR4j9shs0jwQvPBVgwlnij9m2MjjRWGrY3K7A==
X-Received: by 2002:a05:600c:3d07:b0:40f:d34d:d4ea with SMTP id bh7-20020a05600c3d0700b0040fd34dd4eamr478127wmb.31.1707457721860;
        Thu, 08 Feb 2024 21:48:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtIS/aziom1k321wH/A41qtyDt1Byh9r1PFigPhj3XzdDU7dowCNjNpPCmR25NYAhwJ+Sm4r03jsSWazNajD2LKuS1irGUEHOyUyLJC7pQ/xsJ6L6vQPzHGAFAhhxQf0aLBUqLMEFQ4TyT9chaghAnfe5iCKfN5hwhQArRmd6m3ezITg6w/sfnUY5KVANbVbxLB8WV060t5cVs4mHL7D6xTCpF1m0fYDoKTxvfI2IWMK7Ud17waxvZ2NHArYpT71edj/gCUcBbvmwEbRs0/DH5YOhdPQhFu9K96fbdN5QxdP0pm0iYlSqJ6rHarUp02GbOuCNx0ad7Nfg=
Received: from [192.168.50.4] ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b004103400259fsm1425125wmb.29.2024.02.08.21.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 21:48:41 -0800 (PST)
Message-ID: <13956279-3ab1-4eb8-b361-a0c79135cb56@tuxon.dev>
Date: Fri, 9 Feb 2024 07:48:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: ravb: Get rid of the temporary variable
 irq
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
 <20240207120733.1746920-2-claudiu.beznea.uj@bp.renesas.com>
 <c284aab3-faf0-969c-7256-5bc72afe7e3e@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <c284aab3-faf0-969c-7256-5bc72afe7e3e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08.02.2024 22:43, Sergey Shtylyov wrote:
> On 2/7/24 3:07 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The 4th argument of ravb_setup_irq() is used to save the IRQ number that
>> will be further used by the driver code. Not all ravb_setup_irqs() calls
>> need to save the IRQ number. The previous code used to pass a dummy
>> variable as the 4th argument in case the IRQ is not needed for further
>> usage. That is not necessary as the code from ravb_setup_irq() can detect
>> by itself if the IRQ needs to be saved. Thus, get rid of the code that is
>> not needed.
>>
>> Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 9521cd054274..e235342e0827 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2611,17 +2611,20 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
>>  		if (!dev_name)
>>  			return -ENOMEM;
>>  
>> -		*irq = platform_get_irq_byname(pdev, irq_name);
>> +		error = platform_get_irq_byname(pdev, irq_name);
>>  		flags = 0;
>>  	} else {
>>  		dev_name = ndev->name;
>> -		*irq = platform_get_irq(pdev, 0);
>> +		error = platform_get_irq(pdev, 0);
>>  		flags = IRQF_SHARED;
>>  	}
>> -	if (*irq < 0)
>> -		return *irq;
>> +	if (error < 0)
>> +		return error;
>>  
>> -	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
>> +	if (irq)
>> +		*irq = error;
>> +
>> +	error = devm_request_irq(dev, error, handler, flags, dev_name, ndev);
>>  	if (error)
>>  		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
>>  
> 
>    Thanks for addressing my IRC comment! Tho the naming seems awful. :-)
>    I'd suggest to add a local variable (named e.g, irq_num) and use it to

I tried to avoid that...

> store the result of platform_get_irq[_byname]().
> 
> [...]
> 
> MBR, Sergey

