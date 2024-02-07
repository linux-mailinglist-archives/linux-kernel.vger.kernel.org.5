Return-Path: <linux-kernel+bounces-56012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644E84C4EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F243D281EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65471CD2B;
	Wed,  7 Feb 2024 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhO43A2e"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF341CD26
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286863; cv=none; b=Rg/48TYFvdaxZz4Pt8bh8m5PirqaonLJM0mFUBB+0RXM9TO2FWNlKSc6C2/y2hNb7Br66cGxORK1ZkqaQQPv2Y1yoAmeMZzM9OOwkb7OTTk/pdqTF8O1toqw0OyhrXr5/eDtDOTrT2cJ6jasrohAH/5sM+nLrO1YbYVWQy56sr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286863; c=relaxed/simple;
	bh=l1clcTPdVURHS4P5RVBj+1FOj0fLnM8XRADul96ykm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPCSC+iVdESrCB/wbZ4wrB/r2VpFgxOt48S9atZs3SVLCvQrLjxcRFWNpicC46jsUYreusPoGeGOiSH73Ug/urYzbmA1H0/mAnxUjDNo93p4l4E4H8DhBp2PEPnEs6vF63vkGvbEoeTp+9aQm6lkZEa7eflUmdJqjFacMTXUsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OhO43A2e; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40efcb37373so2069415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 22:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707286859; x=1707891659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZCDdTRk8ciH6FS26XWJyVrDKJALrXXLu6bJhxDtbHY=;
        b=OhO43A2eEz85oHAAmEJpxzJjlP3U2AbHicGVFZETg9FyoSV+DqKhXwIwO06d/f/v1T
         2TIA77WPfijcdrtDwh+BA0ZmcS1oHEGHQDpDoMfMFjd4WRS43h+J9CVtURuRzmDlzmEq
         w4xuWPxk1Gmgv3UPv0EhdQu8CXqGM0j157OjZXDRQHNCkA9QgYEFZh/286amByS8Ywzi
         ihJws0BfraV3MJCpLqueYvBEaFvMUdsVO1iejtXCZmj0X+HvHrRCihAEVv7PgipgD+YG
         u+IXleM/MnIjHeAwQlfOnPuHRx652GqRbAjqrZfWfrI/lVMUwPd9fcjk6lRAhcE7SREN
         IxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707286859; x=1707891659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZCDdTRk8ciH6FS26XWJyVrDKJALrXXLu6bJhxDtbHY=;
        b=micqKXqBK/prnj6nyw1b45ZUiFRx6Uqy76Vhu3pHbMe24A0BFjldpKhbM/PkrAOnMI
         y7b1q3vkJO5eSPov9Iedxm3vV/34c37Eua08eBF3SgyNIbsdapL3RvofDdMkRZjGjJvr
         ymk3NzjEBZFrt1bIvxWtJjdI4iJYhezeL0ZpiH/Ol/53TVcrBiBRmzRng74hSTxXWiBi
         uN8Wt6u7ypTEUSA89V1KEyNnhpRbJlBW1UwWapFFIcnUlVgVIGnat9jp2V7k+gx1HX/T
         PNj7iY88YUA7Q5hzjJSP/sDhjoP0b5ToXCjPV351ye98A+g4Z+fFWulo9m+aKGTHQ6oU
         Qd2Q==
X-Gm-Message-State: AOJu0YxtE2XVhjL5ody1uzLJ499gKGkiuye3wfoZaQM7EsY8AsHK/oIy
	qp7e/1rl3ZBTv21mMIiuaJlMui569aUmunGaEq/lyEc5H3HKtoX3ZGJkdfdqOFA=
X-Google-Smtp-Source: AGHT+IG4xM+HZbEIWxMtNnq3z/vbBUehFRqRlrmFRVXJBVJIfxcsZmP1vgixaZRfj4Dwn64BO86YDQ==
X-Received: by 2002:adf:ea11:0:b0:33b:187f:ccc2 with SMTP id q17-20020adfea11000000b0033b187fccc2mr2393960wrm.71.1707286859461;
        Tue, 06 Feb 2024 22:20:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXht0s+5XLYwmbMYGHO9hYHEKtMIUR8SMKjE4DZmjf+xKGxyhIM5rAZEuuWoLJKwsmcjTJs9nRIxCvdnS2zNlZmsth5vb75/NUrmSnamzu6Nt/8tFLcoPOdOgbIVMKx9HBjsF/tXdRsxueEHq+4ftQiT7E1J6bn7RlJrlpF2L3vdespp4G/GGaqNeCTnd8RKoH/7VYvHPHv8ComfNLd6Ci7C7pdZofvJ7hPHSSqahghDNe2LZrxB8TBLGVwLUcZJ1rtmDqSADOu7gwyKM+M49seY5zX8jq7yzu4I0O6Dj8zY8/p4Bh8oDr7vhNQGF9pd+8JR3L1h4gMlWmZHDQsVx2ixvVDwCGBPJ7s4kM6MmkLlMbrdewCARgnf/ojZEYTmog8rkQQEh44gz42ax6rAKg3tGaVvSg4Qa0XZ0mlNdJRenfI3isFZgd4mgXz5eLsmzdEUgx9Kj2BRYUJ9mWKaBa7qxNRi0n9r5aB5yhxKKJ9F3iML0JckyMxbw8R7AF7wVUV1fGE/88WJwOba5dcg/brdetGteJiciGg2I4S18Zxuca6VPNGPUy1tiesEoYgTYmudjw6QJolwQPKUhuzPYmsijAr8tHXsA==
Received: from [192.168.0.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d54c7000000b0033b444a39a9sm622871wrv.54.2024.02.06.22.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 22:20:58 -0800 (PST)
Message-ID: <16a5e423-1111-49ff-ad6c-b0bb89a4879a@linaro.org>
Date: Wed, 7 Feb 2024 06:20:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] spi: s3c64xx: explicitly include <linux/types.h>
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, robh+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-2-tudor.ambarus@linaro.org>
 <CAPLW+4=Xd+B=ZncqPgU4qaJ8zY8JJvJZApdUW_v0w6yr2cy9Sg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4=Xd+B=ZncqPgU4qaJ8zY8JJvJZApdUW_v0w6yr2cy9Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/6/24 18:02, Sam Protsenko wrote:
> On Tue, Feb 6, 2024 at 2:52 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> The driver uses u32 and relies on an implicit inclusion of
>> <linux/types.h>.
>>
>> It is good practice to directly include all headers used, it avoids
>> implicit dependencies and spurious breakage if someone rearranges
>> headers and causes the implicit include to vanish.
>>
>> Include the missing header.
>>
>> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
> 
> Not sure if Fixes tag is needed here.

We have already talked about this. If a patch that causes the implicit
include to vanish is backported to stable, it will reveal the missing
header here and will result in backporting this patch as well. So, as a
good practice let's allow this patch to be queued to stable, it will
avoid possible compilation errors.

I guess Mark has to break the tie again. Or Greg if he cares, I added
him in To:.

> 
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 72c35dbe53b2..c15ca6a910dc 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/spi/spi.h>
>> +#include <linux/types.h>
> 
> Is this really needed for the further patches in this series?
> 

Yes, because in patch 3/4 I use u8 and u16 and I don't want to use those
without having the header included. Do you find this wrong?

>>
>>  #define MAX_SPI_PORTS          12
>>  #define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
>> --
>> 2.43.0.594.gd9cf4e227d-goog
>>

