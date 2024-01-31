Return-Path: <linux-kernel+bounces-46918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77F584465A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF331C22BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AD12DDAC;
	Wed, 31 Jan 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBFXvR+A"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BD12DD85;
	Wed, 31 Jan 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722874; cv=none; b=ABfePHgCiyoIXZy0EOrHmh77PLNGfg+v5cU9Gerj3Q5+BeHc9pnw9z6phvu6oKAfGHnv2tpBAUbObUl9cHt8IrhU1vml9I8arS/9h1cSN4et7SEVRX3FG3aklgjtEzTOzZ3hnL8AGqHDYXIwZsJyNYcONPucZFGTQQk1zO2rHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722874; c=relaxed/simple;
	bh=vAdeHRVoSIIqAH5Ez7lwMhgx5z/HQ+XRmlVVJBmXAv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/pB4eYLDGc++swBwnB9dMRuZf1TnyytFXTEU3BEjZ9QVRBl55kPzKd3s3bcpG8L//WpWEfdn1SxSjgztXXS/WD7Pe2UXaMDGB/N0IuJgeI9TKsmCcIRNj16sDr9vjirRghUA2l41cS29Y7BC2r2ijvyPBDzeJ2JgVJVlOa9n/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBFXvR+A; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40efd8d7ecbso105015e9.1;
        Wed, 31 Jan 2024 09:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706722870; x=1707327670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EbZlNLfHk6MB2DvUgj7PDUK/qmWoKpZYnt8oXMpFHo=;
        b=IBFXvR+Aa1i7W7/Yby3ddQ9fjHyt1zc4+AvPG1nF5SJVY2AUZy89UEqqfZrGEX3sZc
         ho5BlC3tuj8lFb7PU74rnJ1PEJfE8slHhkOt+C29RsUhaRG/xvH9NUUdNiCGaA+4Vz8h
         1zD9V3jv3DFwE83tB89I6Qv88OonQm1dVqzcrCFjaSDuAVaPjT1m3os4HJGvj7kx3/Kn
         OGGmZnQApnqOKr2ZtWWj6zu4uu3ZLbkRDv18GTGYX0at0GxspJC3/WlIEKh8n+4Ry5rZ
         TZLRgByP1J81NInlDlwQC5iWb1L8qVm0BMIefwPxFiaIDbW+4s6tdyAdippyeru6LnJ7
         Z8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706722870; x=1707327670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EbZlNLfHk6MB2DvUgj7PDUK/qmWoKpZYnt8oXMpFHo=;
        b=fAyEnhIMTf3z+RCtH8Hvvjuk4ir5T4s/2ATY0GMeHwpdGCwYZUAF8/FfMeYWhQzG7q
         1tU8eYFhEFVY9PaaNFNuMlXodkAhesnWf8ipS2WvSW52TrmAEmEvKScVu8Z0oFCQnZtl
         94+l9cEmILM/yAiFLf1dSfwlAlG1ztiE4cfMJn5db0DLsJwgT3qtI4mZawgBe6m5QXhw
         P9q8IfIxrmrOWs8LyhYP8RwaIMPO+V30JYLUmZp98JJJjh4S1xUNs8Yum81xGXCQWGwa
         nTS303YtOdF2llteULoNKdfOukJVfYkS4aSOirHpvav5ZPk76KVQ8E7afyUtNnmxx6VF
         FIhA==
X-Gm-Message-State: AOJu0YwoUlnQKadFT+jWZQdqTQZdhWu/QPCUjXKoWfeyIxlm2rYf9Y6k
	b+ZzXINgP/WCvpYPe+9n4Hsaa7E0Gc7qDGvCn0UjxOot0zwB7cEublazhkSI
X-Google-Smtp-Source: AGHT+IE7BWYwNtJxIsBIrVyd6V2SdxrO2f9e8E+IpcUXVwQO65/fpemICb8VpUrc82R3P+aBFnAs0A==
X-Received: by 2002:a05:600c:4e16:b0:40f:afb6:5ceb with SMTP id b22-20020a05600c4e1600b0040fafb65cebmr168938wmq.4.1706722870289;
        Wed, 31 Jan 2024 09:41:10 -0800 (PST)
Received: from [172.16.102.38] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c138100b0040f035bebfcsm2196161wmf.12.2024.01.31.09.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:41:09 -0800 (PST)
Message-ID: <c4498c59-cf64-4a8b-82b9-01d0571779c7@gmail.com>
Date: Wed, 31 Jan 2024 17:41:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ALSA: pcm: Add missing formats to formats list
Content-Language: en-US
To: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
 <3b5bf4b7-a4ec-44be-975b-04590777a965@linux.intel.com>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <3b5bf4b7-a4ec-44be-975b-04590777a965@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/26/24 09:01, Amadeusz Sławiński wrote:
> On 1/25/2024 11:35 PM, Ivan Orlov wrote:
>> Add 4 missing formats to 'snd_pcm_format_names' array in order to be
>> able to get their names with 'snd_pcm_format_name' function.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>>   sound/core/pcm.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
>> index a09f0154e6a7..d0788126cbab 100644
>> --- a/sound/core/pcm.c
>> +++ b/sound/core/pcm.c
>> @@ -211,6 +211,10 @@ static const char * const snd_pcm_format_names[] = {
>>       FORMAT(DSD_U32_LE),
>>       FORMAT(DSD_U16_BE),
>>       FORMAT(DSD_U32_BE),
>> +    FORMAT(S20_LE),
>> +    FORMAT(S20_BE),
>> +    FORMAT(U20_LE),
>> +    FORMAT(U20_BE),
>>   };
>>   /**
> 
> Maybe we can also add some kind of static_assert to check at compile 
> time that all formats are handled, something like:
> static_assert(ARRAY_SIZE(snd_pcm_format_names) == SNDRV_PCM_FORMAT_LAST 
> + 1);
> 
> Although looking at definitions there is a hole between 
> SNDRV_PCM_FORMAT_U20_BE & SNDRV_PCM_FORMAT_SPECIAL, which will cause 
> this idea to fail.
> 
> Perhaps with comment:
> static_assert(ARRAY_SIZE(snd_pcm_format_names) == SNDRV_PCM_FORMAT_LAST 
> + 1 - 2); /* -2 for formats reserved for future use */
> ?

Hi Amadeusz,

Thank you for the review and sorry for the late answer. Yes, I believe 
it could be a nice improvement! Could I send a patch and specify you in 
Suggested-by tag?

-- 
Kind regards,
Ivan Orlov


