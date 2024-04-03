Return-Path: <linux-kernel+bounces-129731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3070896F31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F225B2867A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0DB56B64;
	Wed,  3 Apr 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWosff4F"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEF147C95;
	Wed,  3 Apr 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148436; cv=none; b=uAR1a3ffUCL3PwM/1YywjB6EwFDTd8wRFWQJWWLpLpwd2kA5ON/iicUD4d0O4gIQ6bOigk+OKs3iEqScuCjQoWAGNKK/XRZp3RafL47zQ5TFI7ht94gjTzgN0278WVUmg2FcHzab012LFdWALvfrTPCfjoXRjiuGmiUJNrHfBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148436; c=relaxed/simple;
	bh=mmBOX5CWfuQTkTPKm+iURBQ8uUZaZB/7MTJNd2TQzbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCafBTCrCxJhFdtMxfSVzoperQXmFfsQtMgnpOuH60vKQlGX6Z3oqbQesCSnymNfOOBEUG67Qqj8coVFBYTbB7MucD/oxmwxaFXJh7RxmWs5XiSus9K46AqyChAfFaeFMLjOV+DrtU2jLLwvtofMamIrSl73b910bpsKHuzoo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWosff4F; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e6777af4so10443277e87.2;
        Wed, 03 Apr 2024 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712148433; x=1712753233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuDN6L38TIM9wf05jp6jhML5GX0735G9pkKElMgFJl0=;
        b=aWosff4FAf8fgSF3bxjE9H9ylFYEs8x+tao3GEWMjuLUJ8lZCzuiH1qDv11pnHUD+7
         MZqZjo4OWJn1eYQcQY48QzWm+9w3TOf94O3KP1Kt/DMQYjnMUnbNQDRBKwWOHOtYMAgk
         BLOjp9DkwXRX92zNKiMnQuwkLJGtYkuGj4gyOsvKJc9a2RQXa+WeDaW4g+fJ4ZfLgyXI
         QbI5GtwWIE8bqatGnAKUrGJAVmC1lsPwmX5WTl4UuXq4BSQyK7fHQ1K4N7fZybwzjzT6
         nHLjjvBB79ILm02QqCcalUUr5Z0u+/fhB0AbjLHNXCDHsr4T/zXESUJdnVf2lSF/7HY0
         VlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148433; x=1712753233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuDN6L38TIM9wf05jp6jhML5GX0735G9pkKElMgFJl0=;
        b=K62mwuv7fuFjOYtvuj9kvmBjCsGbohtpFvvmpE+6b5h+liHi4M0zvPRk5vrXpUsbTA
         LcifsLtB9oE2JMsp0Uc+RKzc8120t+m6Aeos7zfQeqAC6a+SJjUo7EL0C2RDNpeOAinj
         fEFHaEKnB0K+KaZ2xHrPVXuQLdfWj7qb+b+vhglJUsltaJ+jWe98XEqDyKh8ipvgjTxK
         Y0cd/6oV9YmxUpB0muxSTievtbb3q5Pbj223TsEbfgDVtq92aW2uuqhh9wjHp6sPsPbY
         +std7jx2DGuSmd9IkGoMEM0iuNTvEIXZ1mFsK6ZRApsj15qN1oxWSrCV5UCN3rvEXCjX
         zbnA==
X-Forwarded-Encrypted: i=1; AJvYcCWmW1w+5m0cTVayF8k6qZUKmMto2Q03P+FCbL/RmDNG6A3gyJHls5fwY3aKKphPeEqH0Jz5c7Dy6JVfBYFHSMzL5pWH6xgFeOOxT3nop+2UrlN0Rm4MnFVkI5Jw6ikXIoFlXJInJgrEc/utM/DI2RrHaub0ZDd6MilmA1in9kuHIDnuj7UTfK8P
X-Gm-Message-State: AOJu0Yzatx5inrnecZTuGp0jGBHWa1GzKOEJgn5uWOQF5i2fvKGwpZju
	8qSmPy7u2xiSIrg3vSE3aBZ4741WQrZWp269H5/gwYe+/5RWLE9XhBH01YO2
X-Google-Smtp-Source: AGHT+IFBTNYJCfhqRdcb8brcRkZuW7VL/46WTvto5wbFfg82T3NK4Rar6AxuZXNY+0UHiF7/TQvvDQ==
X-Received: by 2002:a05:6512:114f:b0:513:cfaa:e618 with SMTP id m15-20020a056512114f00b00513cfaae618mr4523164lfg.0.1712148432988;
        Wed, 03 Apr 2024 05:47:12 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512221200b00516b061e091sm648150lfu.4.2024.04.03.05.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 05:47:12 -0700 (PDT)
Message-ID: <1d956aab-2892-4a2b-a4b3-0a93504668eb@gmail.com>
Date: Wed, 3 Apr 2024 15:47:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] watchdog: ROHM BD96801 PMIC WDG driver
Content-Language: en-US, en-GB
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f8e743a6c49607de0dd7a27778383477e051b130.1712058690.git.mazziesaccount@gmail.com>
 <4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net>
 <279336b3-f28d-48ee-a10f-47abba7b0b89@gmail.com>
 <d2ab33e6-4d3e-472a-b4d7-b703955989ba@roeck-us.net>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <d2ab33e6-4d3e-472a-b4d7-b703955989ba@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 15:41, Guenter Roeck wrote:
> On Wed, Apr 03, 2024 at 09:34:35AM +0300, Matti Vaittinen wrote:
>> Hi Guenter,
>>
>> First of all, thanks for the review. It was quick! Especially when we speak
>> of a RFC series. Very much appreciated.
>>
>> On 4/2/24 20:11, Guenter Roeck wrote:
>>> On Tue, Apr 02, 2024 at 04:11:41PM +0300, Matti Vaittinen wrote >> +static int init_wdg_hw(struct wdtbd96801 *w)
>>>> +{
>>>> +	u32 hw_margin[2];
>>>> +	int count, ret;
>>>> +	u32 hw_margin_max = BD96801_WDT_DEFAULT_MARGIN, hw_margin_min = 0;
>>>> +
>>>> +	count = device_property_count_u32(w->dev->parent, "rohm,hw-timeout-ms");
>>>> +	if (count < 0 && count != -EINVAL)
>>>> +		return count;
>>>> +
>>>> +	if (count > 0) {
>>>> +		if (count > ARRAY_SIZE(hw_margin))
>>>> +			return -EINVAL;
>>>> +
>>>> +		ret = device_property_read_u32_array(w->dev->parent,
>>>> +						     "rohm,hw-timeout-ms",
>>>> +						     &hw_margin[0], count);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +
>>>> +		if (count == 1)
>>>> +			hw_margin_max = hw_margin[0];
>>>> +
>>>> +		if (count == 2) {
>>>> +			hw_margin_max = hw_margin[1];
>>>> +			hw_margin_min = hw_margin[0];
>>>> +		}
>>>> +	}
>>>> +
>>>> +	ret = bd96801_set_wdt_mode(w, hw_margin_max, hw_margin_min);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
>>>> +					   "prstb");
>>>> +	if (ret >= 0) {
>>>> +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
>>>> +				 BD96801_WD_ASSERT_MASK,
>>>> +				 BD96801_WD_ASSERT_RST);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = device_property_match_string(w->dev->parent, "rohm,wdg-action",
>>>> +					   "intb-only");
>>>> +	if (ret >= 0) {
>>>> +		ret = regmap_update_bits(w->regmap, BD96801_REG_WD_CONF,
>>>> +				 BD96801_WD_ASSERT_MASK,
>>>> +				 BD96801_WD_ASSERT_IRQ);
>>>> +		return ret;
>>>> +	}
>>>
>>> I don't see the devicetree bindings documented in the series.
>>
>> Seems like I have missed this WDG binding. But after reading your comment
>> below, I am wondering if I should just drop the binding and default to
>> "prstb" (shutdown should the feeding be skipped) - and leave the "intb-only"
>> case for one who actually needs such.
>>
>>> I am also a bit surprised that the interrupt isn't handled in the driver.
>>> Please explain.
>>
>> Basically, I just had no idea what the IRQ should do in the generic case. If
>> we get an interrupt, it means the WDG feeding has failed. My thinking is
>> that, what should happen is forced reset. I don't see how that can be done
>> in reliably manner from an IRQ handler.
>>
>> When the "prstb WDG action" is set (please, see the above DT binding
>> handling), the PMIC shall shut down power outputs. This should get the
>> watchdog's job done.
>>
>> With the "intb-only"-option, PMIC will not turn off the power. I'd expect
>> there to be some external HW connection which handles the reset by HW.
>>
>> After all this being said, I wonder if I should just unconditionally
>> configure the PMIC to always turn off the power (prstb option) should the
>> feeding fail? Or do someone have some suggestion what the IRQ handler should
>> do (except maybe print an error msg)?
>>
> 
> Other watchdog drivers call emergency_restart() if the watchdog times out
> and triggers an interrupt. Are you saying this won't work for this system ?
> If so, please explain.
> 

Thanks Guenter. If it works with systems using other devices, then it 
should work (to the same extent) with systems using this PMIC. Thanks.

I'll add the IRQ handling to next version - but it may take a while as 
I'm currently having some problems with the IRQs in general, and because 
I'll wait for feedback from Mark to the regulator part.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


