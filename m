Return-Path: <linux-kernel+bounces-89466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAD686F0B4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FAD1F2142C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959CD17C62;
	Sat,  2 Mar 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Lv79n+GI"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57D17BA2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709391442; cv=none; b=Hgkzs+D48iSNPDeNlcvxNQUz2jy4fBKQsdpistF9AXeBVCltFrQUWeM+0bVVzBQpERA/NjtARJG3dyGqahsKWuo4DvcawOymQVHUyd7CqkKUuUz+zAPVT5szOLkv3KsQMSzMWEZetOb/9u8ruIYKxmwpS/VORvgXmF1THkWnNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709391442; c=relaxed/simple;
	bh=vsDO370P9L0eb7fcWgulrtTqYp1omUqwzrlkY+TsrEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNhUYGLx5uO4rM8Ssmh07Wn18Nf2T5Ly4uG4Vosd7mk/73B8uk77tklp16jWD2SYpPjBzFBrnWRFwRBaLF4ZMf48ozTer09A6oBq1Iyyjci9pW85kOm8Yo4SiFF6Fci83NxQPvVoNKZMFDJtoeyIzWvAuKTqkwugiLRg3b6d/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Lv79n+GI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6905d51fdfbso9742776d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 06:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709391438; x=1709996238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfIgoTdA9N+MeIiEy0xWNsxv5l2fuvtP53bPZ++Mceg=;
        b=Lv79n+GIukZYNqW1yCfnmacMqZztGlrqCYXSwWvvghpWzeYdvbqeVPIjwy8U1+UEIU
         1spN8WqMdkyDUTg//9erJCwQZ9AdfixlaejrMNJYpDeMhaEgkWHzh11uOEiyDKu9cv0C
         8d6baKt65vEglCpqT7adkjYN5CKrZW5CWZVtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709391438; x=1709996238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfIgoTdA9N+MeIiEy0xWNsxv5l2fuvtP53bPZ++Mceg=;
        b=Ql5FxwekMGSjdQs/BPj8lqe0FdF3d+zQAgRoMshQcps8p3NUGR16J77BK5cTJCzHZ5
         lsd465UM07Gu/8k1NfuVnauaJkSg1DXjtsJAHE8AEV2AnLhW+U/Wj7W9iWK/IBrMBmAO
         GJAO8y7Zr0rw+4RyfCR15LaUBBDj9cQ47mGDMro617Q7MSoUhDpagFTJM09EhJyr0L6W
         wHSv6GpKyXfmXzIa6O6QA+flS2X1+KbEmOXNjIOUazqeYCPKzw+qk8Z6zyrkF0ghaXDM
         pqqO70cMlRkC0XQIj0rGF5peB6O1ZqDDw+luP1iFPXGDsat0Ex6juHtN8NEEGsAbjtjw
         jFEA==
X-Forwarded-Encrypted: i=1; AJvYcCW9AmxQUiikuBq444IoFe7F2NpuyXl66hB2/3kKW2s/jnbSQ5UVam7ziWsDH93j35dlUlkq1YTWKe0wpwb7DOteX2bMCgMXnz/YyNV1
X-Gm-Message-State: AOJu0Yw+OGcKVzXV7+MzMV2uKOQo8eMppI7KJyEjNDQG8kW/j/og6G2o
	Ta1zpI6ijx5KU2km+8jPYkRUnNcvd9YnYJSyoLxPjb1YkJLu+IJ0/xGCOkriRQ==
X-Google-Smtp-Source: AGHT+IG9qW7IYS8D4z4TN+vHi467Y/Zi72+/DehK/Phj0uWp6/CbVvutRoW9BsGBwd53MOe9t8x0Hw==
X-Received: by 2002:a0c:da84:0:b0:690:5ff8:cc0 with SMTP id z4-20020a0cda84000000b006905ff80cc0mr2942320qvj.11.1709391438501;
        Sat, 02 Mar 2024 06:57:18 -0800 (PST)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id or33-20020a05621446a100b0068f455083fbsm3018169qvb.63.2024.03.02.06.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 06:57:18 -0800 (PST)
Message-ID: <36a4d208-9945-4a65-bdf1-d8309d779e63@ieee.org>
Date: Sat, 2 Mar 2024 08:57:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [greybus-dev] Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Mikhail Lobanov <m.lobanov@rosalinux.ru>, rmfrfs@gmail.com
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
 <7ef732ad-a50f-4cf5-8322-376f42eb051b@moroto.mountain>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <7ef732ad-a50f-4cf5-8322-376f42eb051b@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/24 3:59 AM, Dan Carpenter wrote:
> On Fri, Mar 01, 2024 at 02:04:24PM -0500, Mikhail Lobanov wrote:
>> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
>> Assigning the channel the result of executing the get_channel_from_mode function
>> without checking for NULL may result in an error.
> 
> get_channel_from_mode() can only return NULL when light->channels_count
> is zero.
> 
> Although get_channel_from_mode() seems buggy to me.  If it can't
> find the correct mode, it just returns the last channel.  So potentially
> it should be made to return NULL.

I agree with you.  This looks quite wrong to me, and I
like your fix, *except* there is also no need to check
whether the channel pointer is null inside the loop.
It's the address of an object, and will always be non-null.

     static struct gb_channel *
     get_channel_from_mode(struct gb_light *light, u32 mode)
     {
         struct gb_channel *channel;
         u32 i;

         for (i = 0; i < light->channels_count; i++) {
             channel = &light->channels[i];
             if (channel->mode == mode)
                 return channel;
         }
         return NULL;
     }


Rui, could you please confirm what Dan says (and his
proposed change) was your intention?

If so (and assuming you also fix the check for a null
channel pointer inside the loop):

Reviewed-by: Alex Elder <elder@linaro.org>

					-Alex

> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d62f97249aca..acd435f5d25d 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -95,15 +95,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
>   static struct gb_channel *get_channel_from_mode(struct gb_light *light,
>   						u32 mode)
>   {
> -	struct gb_channel *channel = NULL;
> +	struct gb_channel *channel;
>   	int i;
>   
>   	for (i = 0; i < light->channels_count; i++) {
>   		channel = &light->channels[i];
>   		if (channel && channel->mode == mode)
> -			break;
> +			return channel;
>   	}
> -	return channel;
> +	return NULL;
>   }
>   
>   static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
> _______________________________________________
> greybus-dev mailing list -- greybus-dev@lists.linaro.org
> To unsubscribe send an email to greybus-dev-leave@lists.linaro.org


