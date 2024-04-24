Return-Path: <linux-kernel+bounces-156849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D559D8B0915
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620FC1F23DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3A15B10D;
	Wed, 24 Apr 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="X+ojHJ96"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AC15ADA4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961065; cv=none; b=Cmo0kjGWMFjI0xroqJclhPIoromaMP6mGVH5qqKM1dn6jVk5Y8cGga2Kl2EgKv3MZrYZc1psft4E4LgBPOgJs1HDmW3Nzz8LmExJaBJzGzPKYVfFq7UwI6vx8SkkkI1UwrAi8Sp+3feZ22eetpnaiqDp+gUd8gmyx/tfLjIkagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961065; c=relaxed/simple;
	bh=PxQ+wYkcEmeQVwBCgLwFCF/d6G+Ti5It4I4uaWx1W0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAYhBLdzQucPABGXEjXjtdHBdZg0t81AxZ8gVJ1N3fXtO/JhsvCv0/dB43AMqYpax30/ReCnWuSJnDR8Rlp9sF/eUZZZx9TeSehWhK2+aKgD3STso41g9iwzej2SQYvgSgPKEawCoANoOTGWs28g4fR3YIFfzF+uEH+5qsyU8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=X+ojHJ96; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e4f341330fso57262335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713961063; x=1714565863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIBkvQVMMmmWfMpfrnBMQsoHy1wIAPYh1MyN9fB34kg=;
        b=X+ojHJ96VlzgI77GVwkkp7qq8lGbRLYxexOMUki2Aux7CB7Helyzae5LplM3j+26Sd
         9LyzMAtY88fnLtf+d+ZKs0kXYoEiGZA1q1HV+5ym29hC6OdipX0S3A7C8gUA/9Cip3bC
         N6DF4L+qA4n0QtmHi8rEzRzthnvR8Tw0EyEvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961063; x=1714565863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIBkvQVMMmmWfMpfrnBMQsoHy1wIAPYh1MyN9fB34kg=;
        b=SATzhczLb6KHynUUcMpRPSvTAhjTWBY01fkR3vyNWtkf2kgbwvlLwUn0WiVGYVlyq1
         DW9SVgK2AgmPeal2KpOOWuYB/kiheZbaKS394KISz0nVGIEsSxyyDbu7FZqu/05sqjtP
         aGxh1DD3pSV9+9ZDSnG8btq4UyGkKQeWjP98kkacO2e+A7mGHujIUMTetoWv9CMOskyJ
         t07yedRJcM/+aDweJH2tAkbMPUZV9g+29W/ON5ffuHDQW8GlZbmWM8Ria/hqsPxLHb/g
         kre78aZd1arB1xMTKKUvXqpZSMszRRn/yK9iev9s9NfRP4yr2a7dyhNK/NrFIBM5aOoq
         TMAg==
X-Forwarded-Encrypted: i=1; AJvYcCXRn/hevm+3Wpczs90geNBQq1IZ1PzHzdVsTIazIN4+Dzp3tktO0w0ghu5yV1laqNiy/+wni8mTckMH71v2t3jh4YS8Jc67Gbk6C8LU
X-Gm-Message-State: AOJu0YxpvG7a8vtouYNlnD1e9PkfoFovn6ssyH9bwySf+WYPEkrLlAh5
	e0jIFXYmilwfZuNrjs9WxaAwXmIks81G90tgR7ipdcNW24XxZq82D+CJ6DtYlA==
X-Google-Smtp-Source: AGHT+IFIxPfddfQhuY9GSa7z70gpc6/K91NbvwPtqxZMuz80dAHQ4TeIKP6XwnHXuGVukijr/kjbaw==
X-Received: by 2002:a17:902:c405:b0:1e6:36cc:5c65 with SMTP id k5-20020a170902c40500b001e636cc5c65mr2937321plk.0.1713961062928;
        Wed, 24 Apr 2024 05:17:42 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001e3e09690c6sm12000465pll.199.2024.04.24.05.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:17:42 -0700 (PDT)
Message-ID: <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
Date: Wed, 24 Apr 2024 05:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 4:56 AM, Bartosz Golaszewski wrote:
> On Wed, Apr 24, 2024 at 1:53 PM Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 4:16 AM, Wren Turkal wrote:
>>> On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
>>>> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>
>>>> said:
>>>>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>>>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>>>>
>>>>>> Any return value from gpiod_get_optional() other than a pointer to a
>>>>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>>>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth:
>>>>>> hci_qca:
>>>>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>>>>> power_ctrl_enabled on NULL-pointer returned by
>>>>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on
>>>>>> errors.
>>>>> Nack. This patch does fixes neither the disable/re-enable problem nor
>>>>> the warm boot problem.
>>>>>
>>>>> Zijun replied to this patch also with what I think is the proper
>>>>> reasoning for why it doesn't fix my setup.
>>>>>
>>>> Indeed, I only addressed a single issue here and not the code under the
>>>> default: label of the switch case. Sorry.
>>>>
>>>> Could you give the following diff a try?
>>>
>>> I had a feeling that was what was going on. I'll give the patch a shot.
>>>
>>> wt
>>
>> Considering this patch is basically equivalent to patch 1/2 from Zijun,
>> I am not surprised that is works similarly. I.e. on a cold boot, I can
>> disable/re-enable bluetooth as many time as I want.
>>
> 
> Zijun didn't bail out on errors which is the issue the original patch
> tried to address and this one preserves.
> 
>> However, since this patch doesn't include the quirk fix from Zijun's
>> patchset (patch 2/2), bluetooth fails to work after a warm boot.
>>
> 
> That's OK, we have the first part right. Let's now see if we can reuse
> patch 2/2 from Zijun.

I'm compiling it right now. Be back soon.

>> @Zijun, this patch looks more idiomatic when I look at the surrounding
>> code than your patch 1/2. Notice how it doesn't use the "else if"
>> construct. It does the NULL test separately after checking for errors.
>>
>> --
>> You're more amazing than you think!
> 
> Bart

-- 
You're more amazing than you think!

