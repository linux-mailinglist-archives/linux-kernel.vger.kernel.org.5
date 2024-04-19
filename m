Return-Path: <linux-kernel+bounces-151023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA88AA810
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4313D1C209FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B368BE5A;
	Fri, 19 Apr 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oT3ULVD9"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65034883D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505718; cv=none; b=SnkyFGZ4P8llmOWfAAo+/SaGTXWPS51+5BfKa80ZF4nTSFoenry2jz+LRSZ04e2ysnBBSeOP/a9zu23Ln70fDpVe7EtSWYXw6tKKNgBnQj5/F08atEaSXB2p4zMb1rS6NOCWKQjZeMdSwvPrtUNO5Lb2TplOO7rWM2D+oxAuVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505718; c=relaxed/simple;
	bh=gMy6cw3DboCqmYxhdSgZUroOrhCMb6yIgY4xhy8AcRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQC8NS2DsPCHEBBbkIUBtZY9xLJugFt/hmTv6IY07Xjojj/rTMGtmtzMbjKluucdvq7phqgSGnOqCUPXWn11Ti8n6Zs2fbELXc+DyEPId6OaWMBxo/p+nax2DrARuEH/5YdCQXn4u5am063hHMw6Tnl/DiJ1IDdoS8k3VO6xq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oT3ULVD9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5193363d255so2071735e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713505713; x=1714110513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUWUrX+7Up17uccVitcI8TMuldwzT9oiXZZdOg/1/xo=;
        b=oT3ULVD9x5mC2+ZcPo14nswAR7JK8M7L7d98bRiF+zPA5+ReXUmVyS9rGdRxne6LaC
         PAi8pqrjNghCJtYSBEahF522k9Wc5yTQ1ODit2dLWx/phcjbOcPJwND4K9QWF9x5AJLp
         OsjZ3fxfJ3O0DxeSKteeK+fLsTW3w9bclykUvxJZrCLXhRl5HGuzv+hS+QTESSpnj1jt
         s8daAtFtrVeQFWCGvHu4VMQ3tfLDfRg6oI1kFRQ+hS5VmOKSo+tLA+zIbl9Ykyx1ujo4
         ISdGS7G2pFJWHmyOs77C+xmTVqvrwMLTKX4aWeiaSr3T9byh0Pq852C9KPMgCVAtvxFj
         WGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713505713; x=1714110513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUWUrX+7Up17uccVitcI8TMuldwzT9oiXZZdOg/1/xo=;
        b=jUl+qSwoN4P7tXjf62551vH662oYwN4gE/D6u3iuCG627CMQVqLAqyRdP8r//hcu9K
         scBkLJu+4DZGy9baPKCgMNsuN/jpGUjAO6jYo1MD4G5Vs98bcnYRzRiF68jZOZI2JQ4m
         6mobiuiFSjG/r5WWjK3OPe+EWig3V0HXsq7IVYdtvB4p/NX+YuafV3HYpVvdy8TWNW4v
         9we9xgXosf4zkcbyzrBOoGeLq3YkLnZ/lJTV4Q+RaI2HKUzAA1hLDbB444F3btbM/8gR
         RFpztfeMEKduNV3GfiIqmvN8Ytj0qdC7ichEGOy+9HHToiM+6OZS2VutdyiIwEYUDmlk
         mc9g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3anUiT2SHkbSzG/5sLp0hg9G/7mtCf/gMuAnI1LtwV4jAALaiSTaMoNB8vn5qDjvXYUd1T0rdjFMakl9BwYeDYp2fnVefNFlxkkQ
X-Gm-Message-State: AOJu0Yyfw0vUaXp8LlY97iKRqkf9RF0UPnidApiIgblqU22NOaLjPyEI
	1eCjimjrur+n7wXtJsqVyLqb8S+GxR38hnIJ5+ZtSUNcYM9x5wICs2FyK/MtjAc=
X-Google-Smtp-Source: AGHT+IGGFhdm24fRbZbASPVJ5Uk1/4VA+Pl0auWkqMpLjHkM4OYbghllVrdt80G8vUK8NW1HumU/Pg==
X-Received: by 2002:a19:4316:0:b0:516:d029:b51e with SMTP id q22-20020a194316000000b00516d029b51emr601805lfa.60.1713505713141;
        Thu, 18 Apr 2024 22:48:33 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id br20-20020a170906d15400b00a52241b823esm1749562ejb.109.2024.04.18.22.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 22:48:32 -0700 (PDT)
Message-ID: <7593a5ef-7235-4d3a-a52d-90a7b1aeae0f@tuxon.dev>
Date: Fri, 19 Apr 2024 08:48:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt
 type on resume
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linus.walleij@linaro.org, tglx@linutronix.de, biju.das.jz@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
 <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXescaJ-V0iuXsxo=X-7RYTBR1W5+EXZCw_2VPHEFGzdA@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXescaJ-V0iuXsxo=X-7RYTBR1W5+EXZCw_2VPHEFGzdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18.04.2024 17:07, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Mar 20, 2024 at 11:43 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT
>> source at the same time") removed the setup of TINT from
>> rzg2l_irqc_irq_enable(). To address the spourious interrupt issue the setup
>> of TINT has been moved in rzg2l_tint_set_edge() though
>> rzg2l_disable_tint_and_set_tint_source(). With this, the interrupts are
>> not properly re-configured after a suspend-to-RAM cycle. To address
>> this issue and avoid spurious interrupts while resumming set the
>> interrupt type before enabling it.
>>
>> Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -2045,7 +2045,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>>
>>         for (unsigned int i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
>>                 struct irq_data *data;
>> +               unsigned long flags;
>>                 unsigned int virq;
>> +               int ret;
>>
>>                 if (!pctrl->hwirq[i])
>>                         continue;
>> @@ -2063,17 +2065,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>>                         continue;
>>                 }
>>
>> -               if (!irqd_irq_disabled(data)) {
>> -                       unsigned long flags;
>> -
>> -                       /*
>> -                        * This has to be atomically executed to protect against a concurrent
>> -                        * interrupt.
>> -                        */
>> -                       raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
>> +               /*
>> +                * This has to be atomically executed to protect against a concurrent
>> +                * interrupt.
>> +                */
>> +               raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
>> +               ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
>> +               if (ret)
>> +                       dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
>> +               else if (!irqd_irq_disabled(data))
>>                         rzg2l_gpio_irq_enable(data);
>> -                       raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
>> -               }
>> +               raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
>>         }
>>  }
> 
> LGTM, but I'd rather move the dev_crit() outside (i.e. after) the
> critical section.

I was in balance about having it as proposed. I'll send an update to move
it outside.

Thank you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

