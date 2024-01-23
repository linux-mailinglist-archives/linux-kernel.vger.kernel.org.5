Return-Path: <linux-kernel+bounces-35208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4F838DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2844289A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055075EE8C;
	Tue, 23 Jan 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lcyuR77k"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBD5D901
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010060; cv=none; b=FzWech1sewk7O3qC5hfKDxHPFC0ev6B37PaRJ5Z4jrGXQz7/S/sYMEzQWxW6+PyN9QUKclYbd2qGpKee4a8J0scuOfzzxL2C/eynOLBwotvwEI6KAqYq542omWxgXoffWjVRgMg9gJhzRYF6HnodgX+GzlzXA1/oaJOoDv9UP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010060; c=relaxed/simple;
	bh=710I6WzqsSfHr68RspnqWJQuFL/mvNMKYPLGztWH0JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5J3FKns7lg4P1onWnJoUy/pJO6s/k5IhoNPBeBtxoQgZXl4NY6XCj/7cWGLzQnH8BObDf0ab+A+9QV/4klAIYf3kJR3bFfxpEWtzvxlRVNjf7qKBLdarQ3ihPpPCIxpS+qmhHK//uu3qRq87xnzSzSrNXRkf2SusoHLZiGSAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lcyuR77k; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso46578835e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706010056; x=1706614856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zj96yae6rL4tZLm1hgmOGwk+fliZHrdqlIWBhxFmrLs=;
        b=lcyuR77kRw512UiFPC694rgh0Xo5MExaPJY1n3EdoZEDvmNl3tX8YcLRIP+OXuWZ+L
         QSIOzm40WGFcv0e7LqfMsC1eek1x1w6mCnT2Q44O9GyTzhuQhP8LvpuO64mu/E9SQPCa
         lCC121E0duWNJvXxN3Cf4UB97NQOwAu3kY8ZibGcQ1/CLnPB/MEZJ06GwmVqwCTiHVlL
         6eAJCW3hwNgJD8Zr4bALUrC2c8dkAoWL7OyQbHo92elYIHLT495fIHjPcOPcLGTMv7SR
         fhOFxqHJyVTwQQSjEabiigL53RKWxD07HV9OwQ5rnzgHj7XDf4+OMjfno4DQ3LB+1PkV
         SY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010056; x=1706614856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj96yae6rL4tZLm1hgmOGwk+fliZHrdqlIWBhxFmrLs=;
        b=EiPMfh+y6/FOEg7F8OqMqbxSfbQ/yJ28pSAzr9L5o5lhCgu9Tlt66cr2+mWBnjSfzg
         MIySYfl9RS3AUd1bGn2cHTmZ+3OhZVVF3AvJengG8BiZPZW9eOhPnRRzjWzRf9Acaf64
         A2PKB0zl51MUl5kZl6aMG1slWC2BvwiUassKb+mV5Q5hS1gXK1fnkBVr2ferQQEAFAme
         xqWlc3v15uK3wThUrxKcNERetNMZp7sz6VdnNRh0fI09tE0wlx7PUe4YvwjUVHBVnpFy
         m19yPeGk9jvFBigSM3tA2WAGhE+INGxQJP76jwYcM0JtJOsYYVhHqMTK6b00lbCH/sDq
         utLA==
X-Gm-Message-State: AOJu0YzQJXJvFmHrcOWngoBrmR7xIbgRP5tyy/t9fieMYv7Wa5sPi7qb
	3pBpN1oKAH/Mg/oQSj7tETD4op+PXn+lBRgtodxfJ0sjA1HxswRB2ph/jhbbJ8Q=
X-Google-Smtp-Source: AGHT+IF4M/aIYe8VuEI9FnITlWjNOyii2rrR0XWzenXfI/8NS3mGe0VpzOf6u3sp1RbZY/Gzouareg==
X-Received: by 2002:a05:600c:3110:b0:40e:addd:8567 with SMTP id g16-20020a05600c311000b0040eaddd8567mr460253wmo.124.1706010055719;
        Tue, 23 Jan 2024 03:40:55 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b0040e56830a35sm42198649wmo.18.2024.01.23.03.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:40:55 -0800 (PST)
Message-ID: <74b39ef8-b2b9-415f-a104-2471c240f4e5@tuxon.dev>
Date: Tue, 23 Jan 2024 13:40:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] watchdog: rzg2l_wdt: Add suspend/resume support
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-8-claudiu.beznea.uj@bp.renesas.com>
 <a5a807c1-76ef-4cf7-a2cf-bc432c420ded@roeck-us.net>
 <2af40ace-2779-45a0-a244-e7e9e5cc510c@tuxon.dev>
 <d879634e-c329-4eef-928f-f296535f8838@roeck-us.net>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <d879634e-c329-4eef-928f-f296535f8838@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23.01.2024 12:09, Guenter Roeck wrote:
> On 1/22/24 23:13, claudiu beznea wrote:
>>
>>
>> On 22.01.2024 19:39, Guenter Roeck wrote:
>>> On 1/22/24 03:11, Claudiu wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> The RZ/G3S supports deep sleep states where power to most of the IP blocks
>>>> is cut off. To ensure proper working of the watchdog when resuming from
>>>> such states, the suspend function is stopping the watchdog and the resume
>>>> function is starting it. There is no need to configure the watchdog
>>>> in case the watchdog was stopped prior to starting suspend.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>    drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
>>>> index 9333dc1a75ab..186796b739f7 100644
>>>> --- a/drivers/watchdog/rzg2l_wdt.c
>>>> +++ b/drivers/watchdog/rzg2l_wdt.c
>>>> @@ -279,6 +279,7 @@ static int rzg2l_wdt_probe(struct platform_device
>>>> *pdev)
>>>>        priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
>>>>          watchdog_set_drvdata(&priv->wdev, priv);
>>>> +    dev_set_drvdata(dev, priv);
>>>>        ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable,
>>>> &priv->wdev);
>>>>        if (ret)
>>>>            return ret;
>>>> @@ -300,10 +301,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
>>>>    +static int rzg2l_wdt_suspend_late(struct device *dev)
>>>> +{
>>>> +    struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
>>>> +
>>>> +    if (!watchdog_active(&priv->wdev))
>>>> +        return 0;
>>>> +
>>>> +    return rzg2l_wdt_stop(&priv->wdev);
>>>> +}
>>>> +
>>>> +static int rzg2l_wdt_resume_early(struct device *dev)
>>>> +{
>>>> +    struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
>>>> +
>>>> +    if (!watchdog_active(&priv->wdev))
>>>> +        return 0;
>>>> +
>>>> +    return rzg2l_wdt_start(&priv->wdev);
>>>> +}
>>>> +
>>>> +static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
>>>> +    LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late,
>>>> rzg2l_wdt_resume_early)
>>>> +};
>>>> +
>>>>    static struct platform_driver rzg2l_wdt_driver = {
>>>>        .driver = {
>>>>            .name = "rzg2l_wdt",
>>>>            .of_match_table = rzg2l_wdt_ids,
>>>> +        .pm = pm_ptr(&rzg2l_wdt_pm_ops),
>>>
>>> I think this will create a build error if CONFIG_PM=n because
>>> rzg2l_wdt_pm_ops
>>> will be unused but is not marked with __maybe_unused.
>>
>> The necessity of __maybe_unused has been removed along with the
>> introduction of LATE_SYSTEM_SLEEP_PM_OPS() and friends (and
>> *SET_*LATE_SYSTEM_SLEEP_PM_OPS along with the other helpers were marked
>> deprecated for that) and we can use pm_ptr() along with
>> LATE_SYSTEM_SLEEP_PM_OPS() to avoid build errors you mentioned.
>>
>> FYI, I just build the driver with CONFIG_PM=n and all good.
>>
> 
> Ok, but are you sure you did ? You just mentioned earlier that CONFIG_PM
> is set automatically through ARCH_RZG2L.

Yes, I disabled everything that selected the CONFIG_PM, checked that
CONFIG_PM is disabled in my .config, enabled COMPILE_TEST and
RENESAS_RZG2LWDT (sorry, I missed to mention all these).

> 
>>> But then the driver
>>> won't be
>>> operational with CONFIG_PM=n, so I really wonder if it makes sense to
>>> include any
>>> such conditional code instead of making the driver depend on CONFIG_PM.
>>
>> That's true. The driver wouldn't work if the CONFIG_PM=n but then it
>> depends on COMPILE_TEST which is exactly for this (just to compile test it
>> for platforms that don't support it). I see many watchdog drivers depends
>> on COMPILE_TEST.
>>
>> Give this, please let me know would you like me to proceed with it.
>>
> 
> FWIW, COMPILE_TEST dependencies on watchdog drivers fails for most of them.
> Regarding pm_ptr(), it is there for practical reasons and not associated with
> COMPILE_TEST. Again, if the driver depends on CONFIG_PM to work, using
> constructs
> such as pm_ptr() just hides that and creates the impression that it would work
> without it. 
> I do not think that is a good idea. You can use something like
> 
>     depends on (ARCH_RENESAS && PM) || COMPILE_TEST
>

Ok, I don't have anything against. I'm not sure if this will trigger any
circular dependency for Kconfig. I'll check it.

> to make that explicit. Even if not, I _really_ don't see the point in using
> pm_ptr() even without above dependency. What do you see as its benefit ?

I remember it comes on the same package with the LATE_SYSTEM_SLEEP_PM_OPS()
kind of macros. Looking at it's definition I see it useful because it sets
properly the struct platform_driver::driver::pm. AFAIK, at the moment there
are no checks on this member in the driver core code so we should be safe
w/o using it. I checked the compilation w/ COMPILE_TEST=y and CONFIG_PM=n
and compilation is good, too.

Thank you,
Claudiu Beznea

> 
> Thanks,
> Guenter
> 
>> Thank you,
>> Claudiu Beznea
>>
>>>
>>> I really don't think it is desirable to suggest that the driver would work
>>> with
>>> CONFIG_PM=n if that isn't really true.
>>>
>>> Guenter
>>>
>>>>        },
>>>>        .probe = rzg2l_wdt_probe,
>>>>    };
>>>
> 

