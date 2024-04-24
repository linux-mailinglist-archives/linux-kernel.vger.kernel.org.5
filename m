Return-Path: <linux-kernel+bounces-156873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4138B09B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018C3287288
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D70156C71;
	Wed, 24 Apr 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="TjZ03cbK"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92C13FD99
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961812; cv=none; b=I0P08btMid2CvvuA9eC8aAKk1O7kvXd1fi9cL7ZAR1M8PzBEpGPGrwpJpJd7vBxF1DKb8Xk+ho5QRohhzOR9LHDzl1I5sUvg9UTgKxSVnrTP031hUD7UXDzVfpI4KdfChJNEtPtO6UNXZ+xm9exDSnhudOp660IbeT96Ne2KYug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961812; c=relaxed/simple;
	bh=l4FB/9MAV2vZB9PDYYRqVsJ5eMKUxfbpz8L010+RzDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De/wulR4YnF79aUtnV7SKVrFz59yKznLs7C5kfyotysWVFSZKJ3ZsmD7etCc26VnGUyAAjg9gUuzjfotQH2GZIaO7fzoSvxacsWlMdqJGEhGxAnFtBgTmfoA7u9bhdSTPTw7y6vrcQMu4IQ+FIqUMTeF4LTRp8AlhCVhkYYTaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=TjZ03cbK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso5566169b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713961810; x=1714566610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Srymdr2tW2UrSVymHAuxU117AR4xE7R/7y8mad/3ac=;
        b=TjZ03cbK5FYWn5fPjs5eoDuHZx48UujndyeRlbeiIzPV6gDyIZaa7ggwwRX0mGcYcm
         fmuulx0EwQbWthSBkLm9/pJL1Jv3YproVKAOIcc3eHfLJN4RTpq33uojSY5dh65Cjnj1
         iWrBfA/OtvMuCismKyeLMFvMHmV/aaSyRsO6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961810; x=1714566610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Srymdr2tW2UrSVymHAuxU117AR4xE7R/7y8mad/3ac=;
        b=CQD3nd1yMjQQ+rDlUPn2niAyJqMZfwMhxIs+EWMtuFf9YJr8eFs+iQdZQybP9Qu9qL
         bV4PY9hlRDd3cf6HOC1k/0i+OiOQ558sRaWWq2et0pLOyfxfZyjzwCNlCz/ay9lQ0SXh
         C5IZPpmi+AarB7/v1aK9Bx8LNe1vStfK0oXn+LJ4MHrk2cmCk3krt3HclYLoNifSMbhD
         hpYgmyliAvZ1fNo8DrSRfwPdWUce7zLyDHz1JwlSkzQji72U/a35EYlOmsEi9nx8jCO4
         /g5S99pytxHwUTQOTGCSDY6O+y/V+uK+Z7eAD9izsb3o9mPoBKGRy2fWvcexCnKU+cqB
         +bVg==
X-Forwarded-Encrypted: i=1; AJvYcCVD/bftzcdrW1/oqDNoh6kpvgBkMG/yAX1d6YHDwtgo+7hMVHWSYiltJKWkJ574jIvYIFY+GCDwToEYg1f/eM+lqUi9972LOCGduEJ5
X-Gm-Message-State: AOJu0YwzzkpjPZwEu6qadgtiFGJDX5D6wHjGYIByvxGizZli7tBWAzxe
	P8nYXSdlnq+mZFa3ytW6wbU7821TKGqW28QdtjtvFbsXNXfjlu0+Gvh0tNz0lA==
X-Google-Smtp-Source: AGHT+IEUYR8+xMiieona8sk0iNUW9cTjDLQ/y86TSmhuwzEyQqdiMK6TCcwauJJQ755YKmf4W0a2KA==
X-Received: by 2002:a05:6a00:148d:b0:6ea:9252:435 with SMTP id v13-20020a056a00148d00b006ea92520435mr3298139pfu.30.1713961810283;
        Wed, 24 Apr 2024 05:30:10 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id ey14-20020a056a0038ce00b006f27e986e84sm7044852pfb.158.2024.04.24.05.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:30:09 -0700 (PDT)
Message-ID: <835f54a6-bdf7-447b-b76b-185cdde99450@penguintechs.org>
Date: Wed, 24 Apr 2024 05:30:08 -0700
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
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
 <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org>
 <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 5:27 AM, Bartosz Golaszewski wrote:
> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>
>>>>> That's OK, we have the first part right. Let's now see if we can reuse
>>>>> patch 2/2 from Zijun.
>>>>
>>>> I'm compiling it right now. Be back soon.
>>>>
>>>
>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>> right. If I were to guess I'd say we need some mix of both.
>>
>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>
>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>
> 
> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
> Krzysztof's changes and replaces them with a different if else. This
> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
> Krzysztof handle it.

Got it. Thx.

BTW, should this patch's commit message include the following?

Tested-by: "Wren Turkal" <wt@penguintechs.org>

If so, please feel free to add it.

wt
-- 
You're more amazing than you think!

