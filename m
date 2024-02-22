Return-Path: <linux-kernel+bounces-76688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F285FB07
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A8A28756A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4614C583;
	Thu, 22 Feb 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="H3i5VQ7c"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609D14601D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611609; cv=none; b=GUNWIFIDgmsgTQqAY/YDDfnq21f5COG+SQae0CyBOUanm38fXxa/R1plI5e7UXQxJ7+7DtZ45OWfu9WgVzFgJb3Zevv6i53UMkPCNwFwaFMf6oy3h42qV30GvEFK37yPU+Fjb+T4RnU5DZ4HQDw2XZ+UdcR37hL1niGYUrBiTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611609; c=relaxed/simple;
	bh=hgvHyDNtcFfA7wm1fnzygEy3YAS+iyHk6quAlKBcaPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fE5Po6c0unqfhtqq4JVXobMYwsmIk8UeunRVBYNly1o0mBujN2ZgcU6b6qNe1AtTMdCyGKYKa5+7oQzTgv8/JhqmmJr1jTSjFWeppOOKe674VbWnaN0QXWdM+dGrf4tZxre8DxcTORkgbXry2dz/yRXnX9lAAMnZSG+FjQl24c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=H3i5VQ7c; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso8905922a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1708611591; x=1709216391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D9ZsCd5gwniB13QgO5xKCrLUVsoz37jW5XwSBWuDQII=;
        b=H3i5VQ7cky73mLLRFfl/pCIohTG32zDgsappbydcXepujLBkq3boDP2Un6ixG8cZID
         EFarQJyx6JXbmOJqEW0StzV1umeDECObY1l6wfN9SYOhwGiDXdLCAastISoeHer4CrIX
         hpl9hSMLmSLZ7FajuiE5GH1fmOJw54vZgt5b4gRoBuYsA5L1UhBhzRdEdJCmSVAoLIcD
         gKp0zzoPwzPY2feYyqpwtAzc8E83YTVFbX6e9JrJ3LIQ6/yKqHkzzVA8iDbEo9xF7WS0
         G+2CWj8J6SNV348u14vcPfuQ4sIgWuhCpUs7BiwGYYyU6ExkMm6fd9wDFFDR8UgpzG9s
         KYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708611591; x=1709216391;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9ZsCd5gwniB13QgO5xKCrLUVsoz37jW5XwSBWuDQII=;
        b=e8o5OVknllJGdzbjtg2rol7l+EgC9Hwmb7x6iHSHFp3LMH7C/3m8/PjQCv0yFwntoE
         nHxygmALBgVthLgkrIHHKqbUa0MJmEh6Gpp10ourmTSYtcZ7GX1MzwO2nvAGSnkQLT1I
         Y1ROP107lKAaqHZ1mnl0k2tKDw7c84rsmYt7hDspXUJdTo00mj7Zs6yW06xd2stc124y
         lNg5Zt7M3NVwmzr3Tnoi1+4+Amz8+9M/PiMza3jl/hAd0+qY8zsHybjRNyYLb6G/Ak87
         a57rFUB5OXXFe/Z+NmYFQrf6xq4WWQVb7ozZ5sDkZNCVMLhsnqefnOb2+A+XIVs3J4mC
         VkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgkVN9HDj7R2sYVYrfwYW3//GKrSpO0DhzvQxK074AhWU2vRu6Z+3q5LFhUIrajEbiWzueuRonoYCBGIC++67vOzOEjrbQ/tua7K8d
X-Gm-Message-State: AOJu0Yz6xSgQ7leg5+HagawrfDHeYJu7l5Bo9bYEH34PaI2JSfFyDFDR
	Wk1G9FX1buK03rqdNfopKW56a+l8m1bo8i4eDO0nQ7M1/9QCGVs5cRn58N75mf8=
X-Google-Smtp-Source: AGHT+IGJwLCwDRi+Rf9GH5xhctQVuZy097Gmswzd8q5GKmkEOFqqGzZwPgVJEtCQThuPADekKTIKqA==
X-Received: by 2002:aa7:d697:0:b0:564:56ce:5570 with SMTP id d23-20020aa7d697000000b0056456ce5570mr7774154edr.33.1708611591234;
        Thu, 22 Feb 2024 06:19:51 -0800 (PST)
Received: from ?IPV6:2003:f6:af11:5800:c74a:c0a4:38db:c23e? (p200300f6af115800c74ac0a438dbc23e.dip0.t-ipconnect.de. [2003:f6:af11:5800:c74a:c0a4:38db:c23e])
        by smtp.gmail.com with ESMTPSA id k24-20020a056402341800b00563dc4f2e02sm5405792edc.95.2024.02.22.06.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:19:50 -0800 (PST)
Message-ID: <61786e1d-35dc-4cf1-a152-fba363c94520@grsecurity.net>
Date: Thu, 22 Feb 2024 15:19:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix use after free (more
 completely) -- but not fully ;)
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Torsten Hilbrich <torsten.hilbrich@secunet.com>,
 Nick Dyer <nick@shmanahar.org>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brad Spengler <spender@grsecurity.net>, Sasha Levin <sashal@kernel.org>
References: <e77756aa-c0f1-44a8-bcd6-a46fe954b195@moroto.mountain>
 <49c935cf-4bf5-456f-8bc0-d6dbf0f8cf0f@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <49c935cf-4bf5-456f-8bc0-d6dbf0f8cf0f@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.02.24 15:08, Mathias Krause wrote:
>>
>> The bug is that we must not call device_del() until after calling
>> irq_dispose_mapping().
> 
> Unfortunately, this is only half the truth. We investigated this further
> and there's another bug that got introduced in commit 24d28e4f1271
> ("Input: synaptics-rmi4 - convert irq distribution to irq_domain"). The
> IRQ domain has a UAF issue as well. I'll send the patch soon -- wanted
> to do so this week, but, again, more urgent matters interrupted this.

Unfortunately, I send that Email too fast. Looking at the backtrace
again, it's just the other bug that needs fixing (a UAF in
rmi_driver_remove()). Will sent a patch really soon now!

> 
>>
>> Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
>> Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
>> Closes: https://lore.kernel.org/all/1932038e-2776-04ac-5fcd-b15bb3cd088d@secunet.com/
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215604
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>  drivers/input/rmi4/rmi_bus.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
>> index 1b45b1d3077d..02acc81b9d3e 100644
>> --- a/drivers/input/rmi4/rmi_bus.c
>> +++ b/drivers/input/rmi4/rmi_bus.c
>> @@ -275,12 +275,11 @@ void rmi_unregister_function(struct rmi_function *fn)
>>  	rmi_dbg(RMI_DEBUG_CORE, &fn->dev, "Unregistering F%02X.\n",
>>  			fn->fd.function_number);
>>  
>> -	device_del(&fn->dev);
>> -	of_node_put(fn->dev.of_node);
>> -
>>  	for (i = 0; i < fn->num_of_irqs; i++)
>>  		irq_dispose_mapping(fn->irq[i]);
>>  
>> +	device_del(&fn->dev);
>> +	of_node_put(fn->dev.of_node);
>>  	put_device(&fn->dev);
>>  }
>>  
> 
> Acked-by: Mathias Krause <minipli@grsecurity.net>

So, forget about that one, sorry.

