Return-Path: <linux-kernel+bounces-90652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE58702BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE4B28AF5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B213EA8F;
	Mon,  4 Mar 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="GTJXaJ4s"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E183EA78
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559007; cv=none; b=ebJZntFGr3C0Hxbz41+24SNC370dq25eZyIthSqhKvgjwPc60m8ThH3059pDFawatGvrZkBLJxxXNjW4ztZ4Y9Ef6BBsYQ8KmgLkdx8tGSYsWNZv5YkAj0p2la7/ZLNqlHgrxB6IK3tWD060OnktT2NlZQxY5No1111SC2QXSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559007; c=relaxed/simple;
	bh=1vEnJ3mMLFpedLVWqgpUF3Uwe7Sq/nt8yJh/SWaDQr4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p/Toc5s91uLbh77TeZEaMMUttBK+Tc5pXjZCj4j8GPo229F6sUxxykkdl6Z5An9Hy4E4H30aNKY+Q7rdznpgr2JPMWN0bAYmVrxalj8LD+QV7jO57ogJ9DhyZ7vzphEJOsBBpesieSGLz72QMjHYUWUKPqe5HYdUYlPFLst7ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=GTJXaJ4s; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c83daf5dc3so60736039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709559004; x=1710163804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZJ+jw9Y4deUW/fsj73N7A+2EVXwQ9W8Tou+nRgNMNY=;
        b=GTJXaJ4s3K5zm4Tr9/dPaMQ3Rl6JENsrDkJQE9YFQLBA5BWbYaqehVsvqB8xNoiytz
         PpbiSzTAFXyVzsLpAvAFC7P+hczlQ20JkOTuWIc6hZDUKJPolI9/5Q8p1k5/3W2ftz1i
         +D4uMZV1ms+wR7ElnLdDFwrFkTUgmzQH2owCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559004; x=1710163804;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZJ+jw9Y4deUW/fsj73N7A+2EVXwQ9W8Tou+nRgNMNY=;
        b=gylcZOYig/WIHOrjZJARC+AVs6yWP2fkTAEOVNBaMBaCQhuF/XHcd2kJwmf2Ra/wYJ
         wwleGjiYlm3qUTGi4eKEboK8Dmngsb1OvIz22zOLIaDs7ZdS2uKxrXGRv62djk2Jxv19
         Vd6ZoNirzjAG1pZ66OiLKDn2oHY1yQsaTy3HDe3zP26u8tl5uzILwImXfJaTS0Iutf8u
         wzLfh8VfdhIsVWWHEH/ZG0QuTb1/aXSqfmEDNZ3zAAiCtZyd7YOFSaOXPLChxb+4GGhF
         iHcwqId5Rg8MlsgUCplYbYxFYm6ej/gyeI+wzoYzjUAjtkhrcIBbbbUoP/BJgnUIhOxZ
         xnNw==
X-Forwarded-Encrypted: i=1; AJvYcCVn6dQaxC9NKhDkzSFlRxjVKu30/QNuRfyHXRIXBuKDLkjJnieeW8qm7fYTg0PjJgLPCWJnXysKMY8KU2Kt00/CJHcejf68ugDgQ9Xm
X-Gm-Message-State: AOJu0Yxeo85bjdt/f2AiYvqlN+ZvHFbHUqehboQk5dnDC8bBkmxBE6XN
	xan+eRizA6YvA6gTA5me2oO1gosshayFCE8UhqijqK+NYD6kivbk2V5NEfta4g==
X-Google-Smtp-Source: AGHT+IHuslinA4m6pPWjYZ4+EYackuTruMDe5CoFzt76a27cqscJhBvDEE/JxdbZg/qfAMjeHbR1+Q==
X-Received: by 2002:a05:6602:4892:b0:7c8:5235:3141 with SMTP id ee18-20020a056602489200b007c852353141mr3529308iob.21.1709559004011;
        Mon, 04 Mar 2024 05:30:04 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e21-20020a6b6915000000b007c7e0e8edc1sm1180657ioc.52.2024.03.04.05.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 05:30:03 -0800 (PST)
Message-ID: <e435724c-33ac-446a-81ed-fc31b56d6206@ieee.org>
Date: Mon, 4 Mar 2024 07:30:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [greybus-dev] [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
 Rui Miguel Silva <rmfrfs@gmail.com>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
 <07df4b96-70c2-41de-9d76-1deb80447a79@ieee.org>
In-Reply-To: <07df4b96-70c2-41de-9d76-1deb80447a79@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/2/24 9:31 AM, Alex Elder wrote:
> On 3/1/24 1:04 PM, Mikhail Lobanov wrote:
>> Dereference of null pointer in the __gb_lights_flash_brightness_set 
>> function.
>> Assigning the channel the result of executing the 
>> get_channel_from_mode function
>> without checking for NULL may result in an error.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> I think this is an actual problem but this might not be the
> right fix.

The current API for get_channel_from_mode() allows a
null pointer to be returned, but it seems that there
is at least one case where that should never happen.

gb_lights_light_v4l2_register() issues a WARN_ON() if
get_channel_from_mode returns NULL (and then proceeds
to dereference it).  I know BUG_ON() isn't cool, but
maybe we should avoid the dereference there.

And other than __gb_lights_flash_brightness_set(),
all callers properly handle a null pointer return.

Regardless of what I said before about commenting
for an impossible situation, I think your fix is
generally the right thing to do, but it should not
return 0 if there is no torch mode channel, it
should return -EINVAL or something.

Please consider, and post a new version.  You
could incorporate a similar change in the same
patch for gb_lights_light_v4l2_register().

					-Alex




> The point of the call to get_channel_from_mode() is to get
> the attached torch channel if the passed-in channel is a
> flash channel.  It's *possible* that any flash channel will
> *always* have an attached torch channel, but if so there
> ought to be a comment to that effect near this call (to
> explain why there's no need for the null pointer check).
> 
> I think Dan's suggestion should be implemented as well.
> It's possible the intention really *was* to have
> get_channel_from_mode() return the original channel pointer
> if there is no attached channel with the requested mode.
> But if so, that should be done differently.  I.e., Dan's
> suggestion should be taken, and the callers should use the
> passed-in channel if the call to get_channel_from_mode()
> returns NULL.  (I hope that's clear.)
> 
> So anyway, I think this (and Dan's suggestion) should be
> addressed, but your fix might not be correct.
> 
> Rui, can you please shed some light on the situation?
> 
>                      -Alex
> 
>>
>> Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
>> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
>> ---
>>   drivers/staging/greybus/light.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/light.c 
>> b/drivers/staging/greybus/light.c
>> index 87d36948c610..929514350947 100644
>> --- a/drivers/staging/greybus/light.c
>> +++ b/drivers/staging/greybus/light.c
>> @@ -148,10 +148,15 @@ static int 
>> __gb_lights_flash_brightness_set(struct gb_channel *channel)
>>                           GB_CHANNEL_MODE_TORCH);
>>       /* For not flash we need to convert brightness to intensity */
>> -    intensity = channel->intensity_uA.min +
>> +
>> +    if (channel) {
>> +        intensity = channel->intensity_uA.min +
>>               (channel->intensity_uA.step * channel->led->brightness);
>> -    return __gb_lights_flash_intensity_set(channel, intensity);
>> +        return __gb_lights_flash_intensity_set(channel, intensity);
>> +    }
>> +
>> +    return 0;
>>   }
>>   #else
>>   static struct gb_channel *get_channel_from_cdev(struct led_classdev 
>> *cdev)
> 


