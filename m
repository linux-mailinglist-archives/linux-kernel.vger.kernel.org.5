Return-Path: <linux-kernel+bounces-42836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B300C84077C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685511F21DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1465BAF;
	Mon, 29 Jan 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qH02PZnu"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155C657B7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536423; cv=none; b=RYgzW2oI7PgKR7VjpZkBd4UMVn6YfZHGbz6693zQw14mCtFXGVn5EqPq4AMxbG6G44GFPkOH9WakhXYjopmBd9Yj1bIn2wF0yy6Mb1VDs5teWteIwpVM99i1DSddvbDNf+c+9N/OBUpqRg7H5GWd+onxJ3USaaFOSB6YaBOOcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536423; c=relaxed/simple;
	bh=oKTtlGKGHzW67q9lNAPeOOHT4ufGfMV2g9iVTJql09M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGppILBj63y9PrzJ6T+rA5D8DPXJbJG8ionSZ9dcOIcCAtt78HslOg0Soluq80byvPlON41Djr5ZXdKW0kuHuxq35hYwlds6lGN8jL6KOICbFA6EkurnmReoIXOCaIX0B1jwhW3meraT4yMeGdXOrjpb1sQHWDI3kUEMCkGUnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qH02PZnu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a35e1b735a9so80444166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706536418; x=1707141218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+091sc1ylf97d/ug8x57mJneSunWTfvE/VbxY6s7r8=;
        b=qH02PZnuekYwzseOLPC+aBZuSYwSbcQD1pGsvcFrGoDCH3RVghpCtCUUS4/uHy4Kei
         6kNkrSohvJdIKyKB5RWHQBk4a8xUeEEdgY6xGCHNIY3YINNHfVk8K+ukLN1qh3rK2HMJ
         9iMSohgRU3pX+j5r0Y8I8CWkgJzLPBzovgmlWJNyLYVUJvHi7PFW8a+ptaQwFwYiKKZ+
         9frLRyc8oi6fkWZqQvv5II6O7gce4pJzLxiu8biQdfEvKJn4n8OuJl267L648uguyBV3
         C9Oh064Y6E1YDDH4/CNKEecejduKVOEIEpTx4JgFE53q5qyMbM44laJTiDFNLoP91I4Q
         b/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536418; x=1707141218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+091sc1ylf97d/ug8x57mJneSunWTfvE/VbxY6s7r8=;
        b=Gygva4ieJHbLwMHQ+ZkN0VmMe5gLrTB+msMJLqkK9B9xZj28XGUjrubO2Hw4LhSZz/
         ERyhnAcwyt2+bRDy5d8cXWtAJh9DnLuNjuLjizmKz/3lxncK0xTUFdS1+pnHDwG/z53n
         pUWbiCQOmUG439aMbr2wo/ZtGQud+0Y9aPnmzb/KRWZZgMfyjffVrAZ+N/KNrgRYLPlM
         Ay+V2GJC/s7Y/AoIDmOgKYy8eoHSVPY8L/Ajf9Msy29NnntKglW6/dNs81bSDkmMLa8i
         Leqg1rT3SPEthnYjkmgBFdRmecMqwFEr/pdrY/5X8KTn7iu4Lr4uEsN7T1EnuugzijtA
         cF7A==
X-Gm-Message-State: AOJu0YxAtrLg8UvlEHvDCghlkVjaN5iZT0AeqHnNBh0hmAi+aFjxgOIU
	7Ra/Kw/biY4Wrzzy8gv7UohqJLMk4/89ZRJmawwY0ruLz4uLtGYoRaONP/ONk9F6L75pOVtNPym
	W
X-Google-Smtp-Source: AGHT+IFdg6MQ44AuBXJMMqOxMhsWRNVSLr1MdZXI2hQdBMvYhSqahrsgV6sFVLTQdTa1xScAS5CWcg==
X-Received: by 2002:a17:906:b350:b0:a36:af:3937 with SMTP id cd16-20020a170906b35000b00a3600af3937mr12416ejb.18.1706536418104;
        Mon, 29 Jan 2024 05:53:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906a29500b00a35d7b6cb3fsm664137ejz.95.2024.01.29.05.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 05:53:37 -0800 (PST)
Message-ID: <6307da2b-aadf-4cd7-85e3-3032153544b5@tuxon.dev>
Date: Mon, 29 Jan 2024 15:53:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 07/15] net: ravb: Move reference clock
 enable/disable on runtime PM APIs
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
 <20240123125829.3970325-8-claudiu.beznea.uj@bp.renesas.com>
 <ec3f5d8a-ac38-1134-93a3-c4ceb8b944e0@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ec3f5d8a-ac38-1134-93a3-c4ceb8b944e0@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.01.2024 22:43, Sergey Shtylyov wrote:
> On 1/23/24 3:58 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Reference clock could be or not part of the power domain. If it is part of
> 
>    Could be or not be, perhaps?
> 
>> the power domain, the power domain takes care of propertly setting it. In
> 
>    Properly. :-)
> 
>> case it is not part of the power domain and full runtime PM support is
>> available in driver the clock will not be propertly disabled/enabled at
>> runtime. For this, keep the prepare/unprepare operations in the driver's
>> probe()/remove() functions and move the enable/disable in runtime PM
>> functions.
>>
>> Along with it, the other clock request operations were moved close to
>> reference clock request and prepare to have all the clock requests
>> specific code grouped together.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 9fc0e39e33c2..4673cc2faec0 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>> @@ -3060,21 +3058,27 @@ static int ravb_resume(struct device *dev)
>>  	return ret;
>>  }
>>  
>> -static int ravb_runtime_nop(struct device *dev)
>> +static int ravb_runtime_suspend(struct device *dev)
>>  {
>> -	/* Runtime PM callback shared between ->runtime_suspend()
>> -	 * and ->runtime_resume(). Simply returns success.
>> -	 *
>> -	 * This driver re-initializes all registers after
>> -	 * pm_runtime_get_sync() anyway so there is no need
>> -	 * to save and restore registers here.
>> -	 */
> 
>    I want to pull out the dummy {ravb|sh_eth}_runtime_nop() funcs --
> they don't seem to be necessary... Then we can implement your clock
> dance with freshly added ravb_runtime_{suspend|resume}()...

For this series, does it worth having a patch that removes ravb runtime
suspend/resume ops to then add a new patch that add it it again?
I can do it but it I see no reason in doing it in this series...

The dummy functions were there and the commit description explains the
reason they were updated.

Thank you,
Claudiu Beznea

> 
> [...]
> 
> MBR, Sergey

