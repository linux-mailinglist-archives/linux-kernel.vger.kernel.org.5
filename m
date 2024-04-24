Return-Path: <linux-kernel+bounces-156838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9388B08F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7210E1C22365
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30D15ADAC;
	Wed, 24 Apr 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="kDREl58w"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF015AAC6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960546; cv=none; b=pmDjqnrhVzNMkbajVZVuoSiqgf1DbO+xwOXHKjd0hpXnHpPLlRzQW5UCYcPjns2aDptMdlLcOson8CzKQCe23HoFIKJNimTPvbJdeokD81QCIzLzuRcKDJTdIVVOPE4B6ORyW/QNtdA7JV5633O8J7sfaijAnAz0oJHfTq4eEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960546; c=relaxed/simple;
	bh=52KjXxQlothyD4xprqVtVoLLSPB94MV2Pp7tmkfirFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TI2ldjYtX7/uv2vTuaWvGvOyvzfUC85estcyOz5iEu4cPEy5vxzTzfbaYf5IZup4QLoQKKLFGogStZ/UN0nR+YpEgWYoYHqIflennFZPY2i+VShtPqWnz0N7kqqhs8cLolQF3GYAzA6MjV3Jxno8jQXL/xr3Y4opm3hKvferxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=kDREl58w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so6372070b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713960545; x=1714565345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znsyJuQoNLo0qiO8ZilKT4EJeX5sYMfLiF0BBqCk6Wc=;
        b=kDREl58wK3fyNkIbcZ6RqN1pWxnEhjV1BSiwMLiZxW5FLiZe6V/psG2CtuMHanJkBn
         V1TA89JzVCOwk+H4BGPDlzjrK7powMf2a7keFDJMRi4Bm5AVd3Z20Lmb8ubN3F5GkTM4
         /DEsoaAwu47FGxyeGCP6L8OH0CmVcFH7s4XQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960545; x=1714565345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znsyJuQoNLo0qiO8ZilKT4EJeX5sYMfLiF0BBqCk6Wc=;
        b=rbhNHvp3P5dtMO53GamqKMJylXR8RkC6aM+7te+pUSUN38IF1myPDt3bkZaKfGXK9D
         xtDh3EzxpiNmJfwtdfR8mBAjLGpXYBofFyXyaikDDP1o5MuJh0jYEppJ44J95yEwo2GX
         Lh1nxiKwJRtOFzRrIb25BSLaWBbGVMBGzrhwAqZUMzLmFNL0TjO7OcCk606lvor1KqTk
         z+4CZ1lcCgS+3dVRrFPrrW5/cqpZzuvTbTir9eI2Qvjf2PULgIfWlOqOjUR0TpAqKXQj
         jzUJhsf0VUQiq84qZcAEsu5esUVjFLuKKiemwx6228q4LVBhL6yoHEPCgjrraVRvHFla
         0/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXxuXZ4znffNVdDIm0jdktvCCMj+8OxHR0oEAde1vhfHBWgvlsuNRMb9CJQjEW331XLKYcHrwOylruGQUAoubAqTCUbMyK+mo5g7/W7
X-Gm-Message-State: AOJu0YzxftnHBmJHf893mAsMIquM6XFMTA+uE6236JLJOf6ahl0S59Cp
	DwVdo5BjPiPQ9zEXXW4WqTPr5etxTrlQfEMnC0Isgal6ODcwcgjbvU/dsVcD8A==
X-Google-Smtp-Source: AGHT+IFeVOF9Xq7BV/1lu/eWDxBBt0FpQyQswmdg/BvQlTgta0ZdVo5eTD/m/qcg8g9kZLOP5hItkg==
X-Received: by 2002:a05:6a20:5650:b0:1ac:e0fa:fb24 with SMTP id is16-20020a056a20565000b001ace0fafb24mr2009997pzc.29.1713960544628;
        Wed, 24 Apr 2024 05:09:04 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id j14-20020a62e90e000000b006edec30bbc2sm11289323pfh.49.2024.04.24.05.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:09:04 -0700 (PDT)
Message-ID: <4cbd8c10-6abf-4c10-a16c-62573ae1945d@penguintechs.org>
Date: Wed, 24 Apr 2024 05:09:02 -0700
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

Ah, I see that. Yeah, Zijun's 1/2 doesn't have the returns.

>> However, since this patch doesn't include the quirk fix from Zijun's
>> patchset (patch 2/2), bluetooth fails to work after a warm boot.
>>
> 
> That's OK, we have the first part right. Let's now see if we can reuse
> patch 2/2 from Zijun.
> 
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

