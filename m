Return-Path: <linux-kernel+bounces-108854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171578810ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77BBB20D49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB133D964;
	Wed, 20 Mar 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y9CwmwAY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF33D0C4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934111; cv=none; b=gkKqHjMoAycpjOFxkdf7z03JxhZFfZYZUkJfoaGw51RHKgW9+iv8aoDL4tsOAL+n7ZAOB9yv1K6+EW1Ipmy32FxXVyu53YNwLv7uoBc8Qhdn9aXKYPLQglnXNcXWzRA4DT00ZSvUcCfPehkkNrPg4Q2IVozVupQNm2vNXgzhtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934111; c=relaxed/simple;
	bh=4Z+E+vRRnXtaVEn3HNcuDEF/By+cXE2pMXiic5X53J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sk//hPby5ZGCX86+HzFfd2ubyJ+lXyJ8+Hep1M3L0ApCG16EzxiPdmGvOxEuuLTphXgoeoUPD7MO7MC1Rr8neQsomT6I/jlZAjiCFIMdfr0QpZC1+R3tpBON7JpqjJ2jUiUzrYhCoIT+k0VfBdXLLqqNdcu1cO8TjWBhi9679Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y9CwmwAY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so8460801a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710934107; x=1711538907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t09iTUhLm/Te/RlcYfub0MWtjkucD7v1Wp5XC1yZhck=;
        b=Y9CwmwAYUGiEPFjqNayfO4qUjFFlENJFtep7q2+xiNZ6K6sDY0U8ZXRfbSeWmE3z3h
         dcxPKevNFf4SerIRhRmcMf59mqXgJ57jFDWCpF7nSwCrMF3GRrOTfYYcI1zN0hvV6BBf
         +ypPXq+bCNvUImQXrKGtS09wHN558zQk+FR6pmDoiVQ0JidEvh2j4oubZehJ3H9k2F7T
         AGChdaTq9iePx4LA7zlJYLrqG9U3VPunglCdPImjM2UT1EhCWGNdGmmvjj3Z++aNsYvw
         YDzd8P6fj+BuPjioWn1P+cmMjm32j8WTmeQEZgf2BGAVswvpj0xofmq4wGwLYFIWl9Cf
         LiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710934107; x=1711538907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t09iTUhLm/Te/RlcYfub0MWtjkucD7v1Wp5XC1yZhck=;
        b=mYjdBBLvIT8THL+ImxwowFj0tSBu8uweUcptD5sUMZjpkIbhAd50OGGGg8dyvxUZ+s
         7rEiKX7pO812JwTYB1z/Q5Dpzyc7YNRZF5kAkPJ/OpFG/8YHcA2d7JMzFTmbpB3a1AOZ
         3A6oK+aGGiEaTb3Q+5KL5Bax4sA5Aj4/uuQSBKw/NMoB4q9+srKeSqAL3LH4DIhpHT9y
         W0iEeD5CcdqUD5/hn6/BWFCT7vttMpONtqjjWMw5BQg3/2AiyPT7lYZItx/8/oQjYQoP
         wEgOPTo+sH7OLskwSOTiX3yknP0Plf8UMPJCoPLQM+Z8aPKTetoLquRa2s0z4p+eBSS4
         59Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVUiQtoqkefZBN/QShEVnLPHZqSkj1Clrpmmynt9oOfi0Tir35cF0d+ZPzjqL/lSlTV7Bxp852O83pYCabZ/sVosAFtq4EBRv7ERk90
X-Gm-Message-State: AOJu0YwCmWvggVn6/x6l4c8yd/lE1BYWG+8P6OOR1OghdwXOnmv28BUE
	nBooWl6GgxXoG/tJMdzv59CAiQw3LVAbVztm1ygIzW2fQZYRNUIwY8ltpIRWiy4=
X-Google-Smtp-Source: AGHT+IEi1/Tx0HHmeCCSDdMtByTCaQDWFeiUWqVzIOQYwu2D/XJmlFAMlNOSfmq703CQ9vuWxWLQmw==
X-Received: by 2002:a05:6402:221b:b0:56b:9f35:65f9 with SMTP id cq27-20020a056402221b00b0056b9f3565f9mr1023033edb.0.1710934107425;
        Wed, 20 Mar 2024 04:28:27 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id l8-20020aa7c308000000b0056b7ed75a46sm2776633edq.27.2024.03.20.04.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 04:28:27 -0700 (PDT)
Message-ID: <dfc130d9-2995-4ebc-b164-758c40cff749@tuxon.dev>
Date: Wed, 20 Mar 2024 13:28:25 +0200
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
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
 <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
 <OSAPR01MB158778802C8AAF3F9230259286332@OSAPR01MB1587.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <OSAPR01MB158778802C8AAF3F9230259286332@OSAPR01MB1587.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.03.2024 13:08, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Wednesday, March 20, 2024 10:43 AM
>> Subject: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt type on resume
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time") removed
>> the setup of TINT from rzg2l_irqc_irq_enable(). To address the spourious interrupt issue the setup of
>> TINT has been moved in rzg2l_tint_set_edge() though rzg2l_disable_tint_and_set_tint_source(). With
>> this, the interrupts are not properly re-configured after a suspend-to-RAM cycle. To address this issue
>> and avoid spurious interrupts while resumming set the interrupt type before enabling it.
> 
> Just a question,
> 
> Previously you don't save/restore irq_type() register during suspend/resume()??
> After STR, any way we will lose that information.

Part of IA55 registers are saved/restored in IA55 suspend/resume functions.

The rest of configuration (enable and TINT) was done though pinctrl driver
because IA55 is resumed before pinctrl driver and if we enable the
interrupt at that point the pin may be in unwanted state and IA55 may
report invalid interrupts.

As TINT was removed from enable we need to handle it now.

> 
> Cheers,
> Biju
> 
> 
> 
>>
>> Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> index 93916553bcc7..4fee3b0e6c5e 100644
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -2045,7 +2045,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>>
>>  	for (unsigned int i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
>>  		struct irq_data *data;
>> +		unsigned long flags;
>>  		unsigned int virq;
>> +		int ret;
>>
>>  		if (!pctrl->hwirq[i])
>>  			continue;
>> @@ -2063,17 +2065,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>>  			continue;
>>  		}
>>
>> -		if (!irqd_irq_disabled(data)) {
>> -			unsigned long flags;
>> -
>> -			/*
>> -			 * This has to be atomically executed to protect against a concurrent
>> -			 * interrupt.
>> -			 */
>> -			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
>> +		/*
>> +		 * This has to be atomically executed to protect against a concurrent
>> +		 * interrupt.
>> +		 */
>> +		raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
>> +		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
>> +		if (ret)
>> +			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
>> +		else if (!irqd_irq_disabled(data))
>>  			rzg2l_gpio_irq_enable(data);
>> -			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
>> -		}
>> +		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
>>  	}
>>  }
>>
>> --
>> 2.39.2
> 

