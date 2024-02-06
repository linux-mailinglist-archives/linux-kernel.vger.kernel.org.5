Return-Path: <linux-kernel+bounces-54533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D251384B068
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E50284087
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8642F12BF3B;
	Tue,  6 Feb 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AASB5pa1"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA512C542
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209588; cv=none; b=bKjEbZNIDtUgPDMdePu0X0t87EJtxbXZ1qOKtsnFRemZL6+MyWRgfJtRigWCWC0125REEBIJpi0NAsaUvXIP/H6gu20KPIXrQjXYLLgcee87xZZn8WfudRQnuVyKNO0sODROCOuGh/ddyP9x1uXaknBdvWnY/JARHE/SPt2Hy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209588; c=relaxed/simple;
	bh=IkPuQ84N43CJPITRNgIwZvKuIcHHnEU4bjoIXAe0YqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUSMA6m6J8aZwrOxX436iQamIfifm1NIlqAKKmzKm0ZUc/IDnTXZw6QJ7K+VLgZhkiUQ0JUddknd6n4Rjx6br3eY400zAzJuDNDoXvjLdxnPGyNwptXUS1ikuHDTjOa6brj9UmuRGU60MyNR3vHt/j9l8PavWAUEae276FS/N3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AASB5pa1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337d05b8942so4079781f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707209585; x=1707814385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOB+7yx/h2D9LzRqpjI3KvwptvPg8iNwQL8CUYIoCCY=;
        b=AASB5pa1R6nmfzihMkxJcrPNCv8tX6dPQhqOSScJJQYKZq9J93Xj76a0hmIqbprN7Y
         fXrwqR9npCjjwKfeR9WfyQTHKZpb+uMXg6EHfD1Hg7r6dbNGhuE293r1070B0Zg3vT9X
         YoF/giLbftatC9Z6TP+aZM82tf4YSfi2HOJb2hB0f1lr5ByYR649zDuR2BjuABnJcAkd
         UnPr++ZGiD4XFtGPxZUOdhbR1dU8IFKSF8Mzup7nTdOWdloY84S6ipnN+ZY+sVlfGZOi
         hjWHJHUFAN1swTiWuMFFbWwDMOXLFeVB70yMIYiA9G3Y5o3BvF60aMWDvr/S9afFC3N7
         Niqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707209585; x=1707814385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOB+7yx/h2D9LzRqpjI3KvwptvPg8iNwQL8CUYIoCCY=;
        b=FMpo8ijhIVMbf1FE6u4LpQGrgqqZhtguFrFzgq0xvXMLWJ5frK6QMLaiF6PyNozBZq
         LdcruGlOOuHvyGQWqE//tue73BXDPyBcoJx+mp2w6Zyjm3b3aJfONXiROmvDIy0Akswh
         LqIW3RKePnaNz2rGM3xD7d2qf70kIq4cIgdIdEVDy5QUOoAXFKy+qjExClyZtZLB9+vE
         zDSu5IGHDeyCYnTCEAxhbwRkLtVUEMJqs5b3tvTi+5In9x5qfOAw84czVWhUUE9HnFCe
         Z1AKlOczmx5p3s7M6kQ4yf+mH6KJAojtZDPevCkOn37f9maO2ts/mb51FcjUGgvL1ix1
         OCFg==
X-Gm-Message-State: AOJu0Yz/gVk2rb20mt/7fAmfY6q+Z3R6T1yBBgz+L7ppInj3EWjx+ApC
	1SGD9l21xz3langG3v9a3652a4oFiEtLz0UKs7fmmB6OGyPivZS7WVE72M/xUGA=
X-Google-Smtp-Source: AGHT+IGS8MfQ65GOqo3MYqcajLE4932ZgjiunnST14lr6aRb8+7Jw4H1H3uGhAdEe8GMGs4XPr/6Lg==
X-Received: by 2002:a5d:64ab:0:b0:33a:e4b9:d810 with SMTP id m11-20020a5d64ab000000b0033ae4b9d810mr987579wrp.40.1707209585154;
        Tue, 06 Feb 2024 00:53:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUX77xMI4C4mm1puygvAWHHx0R8IaKaob0ea0+Ds+26gxMCDz9n4rcygqOHZxAFkxmPk7DAcebrs8jUrSorldHTAETyZVeOhQBFUSoOm73vzeuaz0jtXziyxT+spNYjPcXoJd3vzALLPS0j99iaBk1olyvhC+KOn+NDeXYwtdTEawt6DVzS72Xr5JSQBuKp5i6xg6cfXLiLbNNiVqNgh7QZfdBfhznE8LQRvOCUjdQ1crM/ejvYxvNXFUST/sG37H/RMBG1ijUd7fxkUWrRAczODnI5MDY7iPKLra2aEDvMQKACuvWADc7ABHhTKOZdbXai230STx2OKNvFZCLtxaa4ZdhGCpP9rqiVE79Y6zwWR2dpQiIQcE7hMofUfE+NxY2vbGcaYZYn6B4uWius9KLvNOUGpccIpdsFuS1/jHP/20T9Ok8vcwG1YEHFv13Lk4iwrWZtcPHXqVJKCGuS8yVS6vHactlHvjWa78xGawhPsob1DQKAYjOzMMJeWXdZyJszihDAL+0G5nw5OGiacqoTEReO/7lceVvA5kQqkYCWolH7GssL6lcP
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id p4-20020a056000018400b0033b1cb8135asm1518359wrx.88.2024.02.06.00.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:53:04 -0800 (PST)
Message-ID: <4578780f-cb79-42c1-abc1-56faea4794e2@tuxon.dev>
Date: Tue, 6 Feb 2024 10:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, geert+renesas@glider.be, magnus.damm@gmail.com,
 biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com>
 <20240206075149.864996-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXtNgoTEBjC92BB2NSLL_8MM78sVm3A3WbhY=b-6J=vqA@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXtNgoTEBjC92BB2NSLL_8MM78sVm3A3WbhY=b-6J=vqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 06.02.2024 10:34, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch!
> 
> On Tue, Feb 6, 2024 at 8:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=y (e.g. the
>> clocks are enabled though pm_runtime_* specific APIs). To avoid building
>> a driver that don't work select CONFIG_PM.
> 
> depend on?

I knew I missed something...

> 
>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -910,7 +910,7 @@ config RENESAS_RZN1WDT
>>
>>  config RENESAS_RZG2LWDT
>>         tristate "Renesas RZ/G2L WDT Watchdog"
>> -       depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
>> +       depends on ((ARCH_RZG2L || ARCH_R9A09G011) && PM) || COMPILE_TEST
> 
> IMHO this is still a bit futile, as both ARCH_RZG2L and ARCH_R9A09G011
> select PM, so this is always met.  In addition, the "&& PM" clutters
> the logic, and makes the expression harder to read.

I agree with all these.

> 
> If Günter insists on having the dependency, what about adding a
> separate line instead?
> 
>     depends on PM || COMPILE_TEST

OK for me.

> 
>>         select WATCHDOG_CORE
>>         help
>>           This driver adds watchdog support for the integrated watchdogs in the
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

