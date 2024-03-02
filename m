Return-Path: <linux-kernel+bounces-89473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124386F0D5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C331C21315
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C818627;
	Sat,  2 Mar 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BowJBDTg"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498C17BD9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392879; cv=none; b=JxrpyXzwa5QEpR1Q3zimHxfvI0JfMZmd8dQusw+/xbO/yCN1BGsm4HWtMn5bg2yyGhy+nVWiD5XYwfawIdRz841iv98Sxgr9AiC+BvHtSX0gIN7iMWppQRXu0XGfVfm0Y8uWHYJkbfcwGZN3OfLlExK+/jrY9JMgMU6DGjVruv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392879; c=relaxed/simple;
	bh=I47t85Os55PEa/BfNCWv/BXn73oHgJagc4hC5Nos084=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOetQmDvQDjZSCgzHp1JtH20IwtBWtBW6/gpUZ5xrQgvS1GVZByOqxbAfBKDs2ctpwoZusN0ODwsNSAUsbt5pRpScb/Br0jl6E4MM0G16cRzi26pQka5nK/5wT+wrvrNuLl4YwcupN3Fe94qK8RYNdV6xJH6qx50y2XN6GaAisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BowJBDTg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412c24280ffso18430475e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709392876; x=1709997676; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=db2sXyhsfc6Q/OHUgG2VKAJ26jyQ5IGovOGiX2OSiYg=;
        b=BowJBDTgm0mRsBnJQ0vAFNEe4Y1UDuF2D6RHKBQ4G7jzT8CeaHm285zSMP19cJxf8g
         OoHD98fJyRoiD2KNqZF3mvG0g/ucxCz/y90mD0fvPRe5QUb0vR+AkGU28pzu3lSTvuBS
         F3go3FK5VGnWn+OAyHO55OzYwk9t/guBsDUSmqodjKoKv94EbJyBi50dB1zfMymZBvVK
         hZbz+a+8gYjR8NutOVvL1Swsi7zBe4AfZuhkeOSN0LZnOqjs1zXFydZP3jMO4R7azo1C
         M6amo5wA3WK7OzAR5WIylHrXLlMYrjhxBTLHPN+8hyWQiUJn7Lb3Ffm1mrggh5xoWW7/
         dsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709392876; x=1709997676;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=db2sXyhsfc6Q/OHUgG2VKAJ26jyQ5IGovOGiX2OSiYg=;
        b=Z5jyfn6FVrhY1OzvUYqJFvWqRTEt+EPq2xeGpVQwxek3iX9PqU1hrSm5sV/bW+mVvx
         jJ9KNpCwTlrGstNm2o3w4PQsjX9GtbFme9JeuUMSlXHOBbf3HN0qCyN6zdrNKicvKG60
         Pbpfsb4BJT/TN2e//oQmAb8fFBDPr9e5kkkgzKihm3IiY3COxg5YozErpa00MXmbi3Xm
         9YKQc9xwm1zgdKhNP5z20/U8Y6AcEqZpTPtyIHRG9FogtalT1gMmjF46E8EK8VfuHxO/
         wjZQOce0YKJ9Wi0sYv7fJZNkb8OU/Dkvdw+61kL8T5Bi09TL82KyBno8y/zGMMEDNcMA
         wBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDlKBHIrvxjWEg5GVZ+XXIMz6lJ9FB2v4lD7TiFqUPBXm/MqMYeoDi0ww4GK1sb0Ap6UIn6K1+BaptKqXkSIalYDolIpKq5fAI0L2D
X-Gm-Message-State: AOJu0YxV0anLxoIvmygL3Eg9vMbSplOyH+LHyYxw34vNBPbyJkXND7oC
	zc1gOgzR+gGTbB2LrNYhESYPG2eRZUJMd2UQMWAMPO0uaY40Ie2k
X-Google-Smtp-Source: AGHT+IFje49m2+Sm61wx66C0eYJgt+5oKJABw7vtF/Ez8g0huflWYR1aEJCCJ9duKZaPb3dTeuUmeg==
X-Received: by 2002:a05:6000:222:b0:33a:ee4d:98c8 with SMTP id l2-20020a056000022200b0033aee4d98c8mr3692596wrz.61.1709392876171;
        Sat, 02 Mar 2024 07:21:16 -0800 (PST)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id h5-20020adf9cc5000000b0033dd9b050f9sm7441049wre.14.2024.03.02.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 07:21:15 -0800 (PST)
From: Rui Miguel Silva <rmfrfs@gmail.com>
To: Alex Elder <elder@ieee.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
In-Reply-To: <36a4d208-9945-4a65-bdf1-d8309d779e63@ieee.org>
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
 <7ef732ad-a50f-4cf5-8322-376f42eb051b@moroto.mountain>
 <36a4d208-9945-4a65-bdf1-d8309d779e63@ieee.org>
Date: Sat, 02 Mar 2024 15:21:15 +0000
Message-ID: <m3wmqklkwk.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Elder <elder@ieee.org> writes:
Hey Alex,

> On 3/2/24 3:59 AM, Dan Carpenter wrote:
>> On Fri, Mar 01, 2024 at 02:04:24PM -0500, Mikhail Lobanov wrote:
>>> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
>>> Assigning the channel the result of executing the get_channel_from_mode function
>>> without checking for NULL may result in an error.
>> 
>> get_channel_from_mode() can only return NULL when light->channels_count
>> is zero.
>> 
>> Although get_channel_from_mode() seems buggy to me.  If it can't
>> find the correct mode, it just returns the last channel.  So potentially
>> it should be made to return NULL.
>
> I agree with you.  This looks quite wrong to me, and I
> like your fix, *except* there is also no need to check
> whether the channel pointer is null inside the loop.
> It's the address of an object, and will always be non-null.
>
>      static struct gb_channel *
>      get_channel_from_mode(struct gb_light *light, u32 mode)
>      {
>          struct gb_channel *channel;
>          u32 i;
>
>          for (i = 0; i < light->channels_count; i++) {
>              channel = &light->channels[i];
>              if (channel->mode == mode)
>                  return channel;
>          }
>          return NULL;
>      }
>
>
> Rui, could you please confirm what Dan says (and his
> proposed change) was your intention?

Yup, Dan is right.

>
> If so (and assuming you also fix the check for a null
> channel pointer inside the loop):

And you also here.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks.

Cheers,
   Rui
>
> 					-Alex
>
>> 
>> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
>> index d62f97249aca..acd435f5d25d 100644
>> --- a/drivers/staging/greybus/light.c
>> +++ b/drivers/staging/greybus/light.c
>> @@ -95,15 +95,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
>>   static struct gb_channel *get_channel_from_mode(struct gb_light *light,
>>   						u32 mode)
>>   {
>> -	struct gb_channel *channel = NULL;
>> +	struct gb_channel *channel;
>>   	int i;
>>   
>>   	for (i = 0; i < light->channels_count; i++) {
>>   		channel = &light->channels[i];
>>   		if (channel && channel->mode == mode)
>> -			break;
>> +			return channel;
>>   	}
>> -	return channel;
>> +	return NULL;
>>   }
>>   
>>   static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
>> _______________________________________________
>> greybus-dev mailing list -- greybus-dev@lists.linaro.org
>> To unsubscribe send an email to greybus-dev-leave@lists.linaro.org

