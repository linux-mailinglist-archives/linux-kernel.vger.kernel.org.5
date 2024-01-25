Return-Path: <linux-kernel+bounces-38080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B883BAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33F61C2148D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7A12B82;
	Thu, 25 Jan 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBL7vbka"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BB12B66
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168261; cv=none; b=Q3SsGmFF65jdgIOaGxwmtos2criYnDI6fmJ9nUUddcjs/VYNtKnA6fTRBeGVOCBKy4iVgWeUyXCpZZn5iqpqXvVs2A7RP5qt0q3HVir5rcIezL1/4F2oQAssckUCAXLUengmeG52dvLMOFjC7zZNsKZKMevGuhmjALV+fPbusLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168261; c=relaxed/simple;
	bh=BULKPueSd6FUCRZ349T4+wX1lApgUj19QadMyGGWILw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBjGujkNYcczro4ducYDapGGuC0Apd4V5kh/jhk8zgHZS4Cl66wi/x6ghl56mxH7Owtt5NPTiTu7JoeQWEusmKD85KsxrEbHIWag3/ZTNl2skLOBB8I2LL8onEuTla41R7XFDJPWcus20l5xCh/v1SjEGofzmJ/eomSqeXmbmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LBL7vbka; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso81758275e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706168258; x=1706773058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt9c3L6xLHxEH4Xq+0fqlWuKOPFNWTaVYRPe6NdZRFw=;
        b=LBL7vbkaHNNdOV1iDeTPAFoVfjjStAFF2zefm8gUIbQnrJBqCJp36tV0cl1SfOnvBM
         9IgTJa5YLYh7qqSRXbVRDhtkDOgZnNv7lA3mH1d5yuwONYkdlprgyFslc1pcIOx0QIr/
         M0YJ+UXkPyiep4zoIsU0VuY2W8/v/CEBb+5dxRerjHQbzxs6QBsVQuPbG2Vl5fJEq04S
         QEmIxv0QyI93TgjTR5x8JMZx3xTuAkzeD8EBF7UcS4sJNAQPH6DXzfNVeXo8wqBJEnCw
         IbPnS4DftX9Yu3+ns8kfAYFRY/By5N4+wVxGbIbCvpCd4xLgYkLFFpy7by1BldTWsgyT
         pQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706168258; x=1706773058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt9c3L6xLHxEH4Xq+0fqlWuKOPFNWTaVYRPe6NdZRFw=;
        b=BqTBV5kiNw77y/iTXhnls2rbIKWIbTyVsjMukrRhqbIoWuu5E2YyDLwJ+6LlrT2x52
         zm646fTgVMdpR4f2u1dVptX/kJTQIAbenslgOwbpacuUVf81H+P4OI6690ICkXg7XG95
         OF4POYcw8BAcQ5cFqbizbav2Kd1grtTsG8p5KPYS3/wVpmnpfTPrfMlE0D0KJq7UsI1O
         bbY842Sk6/sXlDp+dvB6AlRIHNAkFUjnbQqtgaYl8Bl1gU0hWZR5IGjda5+XlZVvovuj
         WaQi1FUEUbMFfMemj1zeMZTPYPJQ3eMoG36Z0riOz+/w40Jck2Hes4R9ogwsnZdHQreP
         1wEA==
X-Gm-Message-State: AOJu0YxA4sBHW8c7rN0ppBi9qQOHU5RHfy9GbnKUQB6Hy8w2XH8XfCCj
	LyTi7/V6PfRhr35m3bLCVxwrMGBv4NO80ZTFGrsbAmRdeCTgzvssVPDdK3tAWbk=
X-Google-Smtp-Source: AGHT+IHdMJVprQzVU82qnhjOv9A3fxHwxa21rh2msOKfIUA660cSu3ThoZFAOiYcOWiGABpdKs8t9g==
X-Received: by 2002:a05:600c:601c:b0:40e:d30d:4066 with SMTP id az28-20020a05600c601c00b0040ed30d4066mr2862wmb.169.1706168257738;
        Wed, 24 Jan 2024 23:37:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05600c0ccf00b0040e9f7dadc6sm1539709wmb.25.2024.01.24.23.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:37:37 -0800 (PST)
Message-ID: <04411aaf-6f2c-4f43-83b4-aa0741ccd25f@linaro.org>
Date: Thu, 25 Jan 2024 08:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
To: Saravana Kannan <saravanak@google.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
 wim@linux-watchdog.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 jaewon02.kim@samsung.com, chanho61.park@samsung.com,
 semen.protsenko@linaro.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com,
 linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org>
 <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
 <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
 <6c72a521-1048-42eb-ac74-d8f718a90723@linaro.org>
 <CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com>
 <f4d3aa5a-e01d-4ef3-8004-b6eac4461184@linaro.org>
 <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/01/2024 22:27, Saravana Kannan wrote:
> On Tue, Jan 23, 2024 at 10:27 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/01/2024 04:37, Saravana Kannan wrote:
>>> On Tue, Jan 23, 2024 at 10:12 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 23/01/2024 18:30, Peter Griffin wrote:
>>>>>>>               dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
>>>>>>>       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
>>>>>>> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>>>>>>       if (ret)
>>>>>>>               return ret;
>>>>>>>
>>>>>>> -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
>>>>>>> -             wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
>>>>>>> -                                             "samsung,syscon-phandle");
>>>>>>> -             if (IS_ERR(wdt->pmureg))
>>>>>>> -                     return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
>>>>>>> -                                          "syscon regmap lookup failed.\n");
>>>>>>
>>>>>>
>>>>>> Continuing topic from the binding: I don't see how you handle probe
>>>>>> deferral, suspend ordering.
>>>>>
>>>>> The current implementation is simply relying on exynos-pmu being
>>>>> postcore_initcall level.
>>>>>
>>>>> I was just looking around for any existing Linux APIs that could be a
>>>>> more robust solution. It looks like
>>>>>
>>>>> of_parse_phandle()
>>>>> and
>>>>> of_find_device_by_node();
>>>>>
>>>>> Are often used to solve this type of probe deferral issue between
>>>>> devices. Is that what you would recommend using? Or is there something
>>>>> even better?
>>>>
>>>> I think you should keep the phandle and then set device link based on
>>>> of_find_device_by_node(). This would actually improve the code, because
>>>> syscon_regmap_lookup_by_phandle() does not create device links.
>>>
>>> I kinda agree with this. Just because we no longer use a syscon API to
>>> find the PMU register address doesn't mean the WDT doesn't depend on
>>> the PMU.
>>>
>>> However, I think we should move to a generic "syscon" property. Then I
>>> can add support for "syscon" property to fw_devlink and then things
>>> will just work in terms of probe ordering, suspend/resume and also
>>> showing the dependency in DT even if you don't use the syscon APIs.
>>>
>>> Side note 1:
>>>
>>> I think we really should officially document a generic syscon DT
>>> property similar to how we have a generic "clocks" or "dmas" property.
>>> Then we can have a syscon_get_regmap() that's like so:
>>>
>>> struct regmap *syscon_get_regmap(struct device *dev)
>>> {
>>>         return syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
>>> }
>>>
>>> Instead of every device defining its own bespoke DT property to do the
>>> exact same thing. I did a quick "back of the envelope" grep on this
>>> and I get about 143 unique properties just to get the syscon regmap.
>>> $ git grep -A1 syscon_regmap_lookup_by_phandle | grep '"' | sed -e
>>> 's/^[^"]*//' -e 's/"[^"]*$/"/' | sort | uniq | wc -l
>>> 143
>>
>> Sorry, generic "syscon" property won't fly with DT maintainers, because
>> there is no such thing as syscon in any of hardware.
> 
> Then why do we allow a "syscon" compatible string and nodes? If the

To bind Linux drivers.

> "syscon" property isn't clear enough, we can make it something like
> gpios and have it be <whatever>-syscon or have syscon-names property
> if you want to give it a name.

This could work.

> 143 bespoke properties all to say "here are some registers I need to
> twiddle that's outside my regmap" doesn't seem great.

Why? 143 of these registers are not the same.

> 
>>>
>>> Side note 2:
>>>
>>> How are we making sure that it's the exynos-pmu driver that ends up
>>> probing the PMU and not the generic syscon driver? Both of these are
>>> platform drivers. And the exynos PMU device lists both the exynos
>>> compatible string and the syscon property. Is it purely a link order
>>> coincidence?
>>
>> initcall ordering
> 
> Both these drivers usr postcore_initcall(). So it's purely because
> soc/ is listed earlier in drivers/Makefile than mfd/. And as soon as

Oh... great :/.

> drivers are made into modules this is going to break. This is
> terrible. If you want to have a modular system, this is going to throw
> in a wrench.

Best regards,
Krzysztof


