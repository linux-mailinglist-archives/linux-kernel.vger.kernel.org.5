Return-Path: <linux-kernel+bounces-34809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AC8387C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6701C234F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2350A6F;
	Tue, 23 Jan 2024 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Q5XO73gX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430A55E5E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993362; cv=none; b=bt74tbESXCc7+B03/AYZoVnwd0BuqfETeUemhAd0EVIxE0zI6CIVcLPHdBhtJEu5eStCzxf/UOnyOM/oBP5P7lBsiwQu6B6euTKGsVXyqZElWjMcC/Li/Bn5wKzwiTq9XSfebPi/k+ZAgvrPchXeB406FKYyjsYaPH3qIZQPCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993362; c=relaxed/simple;
	bh=umk0ZPnWTL0b4WUNFY7XpYAosoBwjT3rA5b6SOxM+0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eidDyF8BkYpsKM2KCcaSXpWkkFSJeYuEhr4/3enJX5BpkiIRhXTLJYQ4rP2W09lEsMN3yIcaldOG+k6lQxTR9DtfRMoFxcq7+NwZ6XYZADLaNlL2mVLCZOMUYcG5HbfATCbWhHETrbPvMpbsXDpxz1ejbRApt9++Ef7aAgkNjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Q5XO73gX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337d99f9cdfso3505571f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705993358; x=1706598158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HA3HgAJbahgUJBX1gJ3AzroSL9tqmUD02YJ2gg4LNI=;
        b=Q5XO73gX+U2nlb9u59i4ZhawUFU0/aOalOflTpE5G0EqqxrXQ0v119F96LsSe7ohiC
         w/u4kj1Ci8lLFZNqnUFSbrr4b80XzBdUisbIdwRPNJ+ZdJIeOGK6XmwimsLH6on8A6mI
         xBI0d5TqhipvbFwbkY1JL2jHKJtJ8pMmJLxuhriz+B92AlYnYzNE6Foqkg9vyE+lRqOw
         KHAz4gKoqrm3bqJfo5ytjZF3LT3tr2C0ukmbzPNEPhGMfEaH39UviY+WeHnIiT/F/dZz
         qXH3kz08EjJ25wWvXLGhAdgdDJcGdCBYraNWjWqo265YOsxQNQk88Ij3bYh0Otz/eiK1
         3dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705993358; x=1706598158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HA3HgAJbahgUJBX1gJ3AzroSL9tqmUD02YJ2gg4LNI=;
        b=ZTXnHjTE12sgBhKT9U50L22JlFLoAAUoRHXmg1JSTNjK0M3riiSWuJ3YxczCCqmib4
         4RkS3eZStx31EyB7ET+sqoz6cXnk3RG+ojpfMHD5nsCi3TSVZnFYFxBDjzBtElktCnTe
         PogTMr6remA6KGVGNgLyyryV/ovZ85v/PMQEclxNTdeW91Xyvp6vv8Ch2a/b0lVlqViP
         fqI350KC+abB+wxfmkwg/0911oF8izSjmFk2iGdh/vPGzsIHpNQMBqsH93yo5PgKiBwi
         nJr2NjjbJCOK3sRERqFg8yh8UgbN6aPTdIJmEsa4tsmapZPecl3gkLJlFfHUSXKyieU8
         BkmA==
X-Gm-Message-State: AOJu0YwdsFX8kmq34AZhcowaIRg3xhgAvIWWOvTMOxp+jwJn4Fyp98tf
	fo1mtG9Jm7tsHGZfnrdQI5oV7J1pasmmDpW3l9xGUMHiEhL/pqimT5LXg0jegc8=
X-Google-Smtp-Source: AGHT+IFS5K2uIygufmipIXH0vhHz5DAndNr0whIooxvibYTJnGVc1IlHqA+kcq/xwxH4E4Cnt7O3Xg==
X-Received: by 2002:a05:6000:4cc:b0:339:35a4:7caa with SMTP id h12-20020a05600004cc00b0033935a47caamr1569042wri.54.1705993358156;
        Mon, 22 Jan 2024 23:02:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0033926505eafsm8410992wrs.32.2024.01.22.23.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 23:02:37 -0800 (PST)
Message-ID: <92db308f-075c-4799-9777-5bc14438ce68@tuxon.dev>
Date: Tue, 23 Jan 2024 09:02:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-4-claudiu.beznea.uj@bp.renesas.com>
 <c857cdd4-459b-41ae-b4bb-0da45e461335@roeck-us.net>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <c857cdd4-459b-41ae-b4bb-0da45e461335@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22.01.2024 19:31, Guenter Roeck wrote:
> On 1/22/24 03:11, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> pm_runtime_put() may return an error code. Check its return status.
>>
>> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>   drivers/watchdog/rzg2l_wdt.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
>> index 4ab9e7c5e771..0554965027cd 100644
>> --- a/drivers/watchdog/rzg2l_wdt.c
>> +++ b/drivers/watchdog/rzg2l_wdt.c
>> @@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device
>> *wdev)
>>   static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>>   {
>>       struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>> +    int ret;
>>         rzg2l_wdt_reset(priv);
>> -    pm_runtime_put(wdev->parent);
>> +
>> +    ret = pm_runtime_put(wdev->parent);
>> +    if (ret < 0)
>> +        return ret;
>>         return 0;
>>   }
> 
> A simple
>     return pm_runtime_put();
> might do.

pm_runtime_put() may return 1 if the device is already suspended though
this call trace:

pm_runtime_put() ->
   __pm_runtime_idle() ->
       rpm_idle() ->
           rpm_suspend() ->
               rpm_check_suspend_allowed() [1]

That return value is not considered error thus I wanted to consider it
here, too.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/base/power/runtime.c#L278

> 
> However, one question: Given that pm_runtime_put() returns -ENOSYS if
> CONFIG_PM is disabled, that means the driver will depend on CONFIG_PM=y.

Indeed, the driver depends on CONFIG_PM=y for proper working. It is for
devices selecting ARCH_RZG2L and RZ/V2M (ARM64 based uarch) which select
CONFIG_PM=y:
https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L45

The driver is written with CONFIG_PM=y dependency in mind (e.g. the clocks
are enabled though runtime PM APIs).

> Assuming this is intentional, would it make sense to explicitly declare
> that dependency in Kconfig ? It doesn't seem to make any sense to build
> the driver if it won't work anyway.

The dependency exists there for ARCH_RZG2L and RZ/V2M devices but not
directly and it is not strict (in the sense that we allow to build the
driver w/o CONFIG_PM (I think this is good to check build on different
configurations, the COMPILE_TEST is there anyway in [1]) ). E.g.:

RENESAS_RZG2LWDT depends on ARCH_RENESAS [1]
ARCH_RENESAS is the ARMv8 uarch flag [2]
SOC_RENESAS is set if ARCH_RENESAS [3]
ARCH_RZG2L is visible only if SOC_RENESAS [4]
ARCH_RZG2L selects PM [5]
RZ/V2M selects PM [6]

Please let me know what do you think about it?

Thank you,
Claudiu Beznea


[1]
https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/Kconfig#L913
[2]
https://elixir.bootlin.com/linux/latest/source/arch/arm64/Kconfig.platforms#L273
[3]
https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L2
[4]
https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L9
[5]
https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L45
[6]
https://elixir.bootlin.com/linux/latest/source/drivers/soc/renesas/Kconfig#L328


> 
> Thanks,
> Guenter
> 

