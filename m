Return-Path: <linux-kernel+bounces-56208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562E84C75E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA991F232EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EAB20DC4;
	Wed,  7 Feb 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cI/AR/Jx"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBA20DF5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298232; cv=none; b=Li994ZLIqv5k8VsnENTi31brUMW+FhFvg/l671RhS/o2qH1VtE5/1Tz/C0VnRzBdi0equTnIsD2QR0mS0Wtoqb7Kgh3GttvtqAj7VzyS9UgYPBes00IO53okU2a4VI0IHD50Xu5W/pWBl/Yocow8XAGeXybAExIUrApGFoRSFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298232; c=relaxed/simple;
	bh=YGtZYhJCfM5pYqP2p4P2ioqSd2yPXhH8tEbXC5C53q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aV9+e8hFIV/v+kO2ErYCD721RT4yWKjbl3K3pi/29t7961cqrJB10U/EDnHTbn+vsri40hgDsFtQAhYwp90XXmDsJ8h5nnK22M1D8f0ox5NDCDQ+jBwZLNYcX4+K3CJycBqy5GPgHxjkWMkCwPwEyDBKY70E5Bl4vNqWy0yyA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cI/AR/Jx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe3141e1cso3825895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707298229; x=1707903029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXrAYS0UnRqCz6HcnK2V1Gsfy2gmBA+8A64IxzHSNPk=;
        b=cI/AR/JxJkrceOZU2DnlwUyKCYMmj8S5muufBkO0OOtZWCPGFc+00yoWv9O268S03u
         0opRKaMkq6ulG7Tcn/h7jsPkI/v6A7PCHvIikHe6VeDm/ZoYrvo5odFJdWLZjYCoRprj
         RUBEP38KaUlWpOa2TnJ6LzfaQdDX7lFRJxeAsqH8s5M3kyCsorAarv5HR8dSDvQZptpL
         MccW9HgY5rsK7e2GGBr/q4rar8QiRbgdj0t1WNYWueFsTJHtjsp6AA7By0wlMsUYfWId
         2gH/9PuUfr2a/n3qVpjbqyxBHBg3zwiO9K9KIlR5ooY5Pln9WPdfdOxhl+r0UEFkPmDI
         fYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298229; x=1707903029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXrAYS0UnRqCz6HcnK2V1Gsfy2gmBA+8A64IxzHSNPk=;
        b=u/ZNyDAks9ju2A3rZaXb6pb1h9SinswwAsk+HbuN0cBfxdIppf58o3+9zs31UEFCRF
         ErDooxX0nI7ThmxnFGoER7R7N+pOC7Me++Jucp5GCsZOaa+wI+gveQgKpM9jwaWMn49s
         YOY/wJ2tOF2t7Pym9XhAXE46NlpdHM/tjRQRGOOmfG0o9xLIraLcRkkSlcYCagAh5KxN
         7vbq7/IJKfL+U/6sYv4UfSyvVRYry2kb9MUmv9Fu6wH7oGyvIwa+K/jF7fQaoWW72LAo
         zaZC+U+2z+LGjL7vcnI5kBUrgmYfEyYU1oLKrs6O3rDAOTqchpLDC/bVoyC6uWbeRpfI
         3oSw==
X-Gm-Message-State: AOJu0Yy23oQoRvIk11Qn8NfDui4l7c68r5IkfwZzgw/OmdIym4R8ViGT
	1zaCWWMWSUaHIfZpHtIaZmnBdPo4Vlvs0nX93AQEsdRCz4Garod5/dJKG4D1I+8=
X-Google-Smtp-Source: AGHT+IE9vY2FNzT3x5cjXW4ZpsGuGIjXWSoYtxeKH9m6EHcgEGaQhy2yUXM51FjqePQavj5rhUSZ5g==
X-Received: by 2002:a5d:588d:0:b0:33b:1545:fe6b with SMTP id n13-20020a5d588d000000b0033b1545fe6bmr3609108wrf.32.1707298228941;
        Wed, 07 Feb 2024 01:30:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCWunHCo40PehRFqk6QmCpOWgGzWbdgtDF0pml9YuxksYw9lUpByGeFwOL9utF3PPm5iJ923O94Pm/JILW1v4uEG15dBpoQJisL+mOo+ZQpHC3hQqWZY148FRBJ+P0jIwqdAahNMCyj0+u8SmqfqMPaCuzqnsKtF4pwWrcEqZEQDWOx9b4CE9aSAxpuh4/Xv8s3Bt7z+A0ksCJKS941UI=
Received: from [192.168.43.244] ([213.215.212.194])
        by smtp.googlemail.com with ESMTPSA id j1-20020a5d6041000000b0033b4f752b62sm702189wrt.33.2024.02.07.01.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:30:28 -0800 (PST)
Message-ID: <feff8e48-c974-447a-99bb-21d5beda1dd1@linaro.org>
Date: Wed, 7 Feb 2024 09:30:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
Content-Language: en-US
To: Joy Chakraborty <joychakr@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 linux-kernel@vger.kernel.org, manugautam@google.com, stable@vger.kernel.org
References: <20240206042408.224138-1-joychakr@google.com>
 <1ecb3744-7baf-4bdd-a01c-8c87fa0a42b3@linaro.org>
 <CAOSNQF2TpA1QXKQBEZXsjXojGcfRKZDjCtLhRUGwLPVfhNWmgA@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAOSNQF2TpA1QXKQBEZXsjXojGcfRKZDjCtLhRUGwLPVfhNWmgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/02/2024 06:35, Joy Chakraborty wrote:
> On Wed, Feb 7, 2024 at 4:06 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 06/02/2024 04:24, Joy Chakraborty wrote:
>>> reg_read() callback registered with nvmem core expects an integer error
>>> as a return value but rmem_read() returns the number of bytes read, as a
>>> result error checks in nvmem core fail even when they shouldn't.
>>>
>>> Return 0 on success where number of bytes read match the number of bytes
>>> requested and a negative error -EINVAL on all other cases.
>>>
>>> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Joy Chakraborty <joychakr@google.com>
>>> ---
>>>    drivers/nvmem/rmem.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
>>> index 752d0bf4445e..a74dfa279ff4 100644
>>> --- a/drivers/nvmem/rmem.c
>>> +++ b/drivers/nvmem/rmem.c
>>> @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int offset,
>>>
>>>        memunmap(addr);
>>>
>>> -     return count;
>>> +     if (count != bytes) {
>>
>> How can this fail unless the values set in priv->mem->size is incorrect
>>
> 
> That should be correct since it would be fetched from the reserved
> memory definition in the device tree.
> 
>> Only case I see this failing with short reads is when offset cross the
>> boundary of priv->mem->size.
>>
>>
>> can you provide more details on the failure usecase, may be with actual
>> values of offsets, bytes and priv->mem->size?
>>
> 
> This could very well happen if a fixed-layout defined for the reserved
> memory has a cell which defines an offset and size greater than the
> actual size of the reserved mem.

No that should just be blocked from core layer, atleast which is what is 
checked bin_attr_nvmem_read(), if checks are missing in other places 
then that needs fixing.


> For E.g. if the device tree node is as follows
> reserved-memory {
>      #address-cells = <1>;
>      #size-cells = <1>;
>      ranges;
>      nvmem@1000 {
>          compatible = "nvmem-rmem";
>          reg = <0x1000 0x400>;
>          no-map;
>          nvmem-layout {
>              compatible = "fixed-layout";
>              #address-cells = <1>;
>              #size-cells = <1>;
>              calibration@13ff {
>                  reg = <0x13ff 0x2>;

this is out of range, core should just err out.

--srini

>              };
>          };
>      };
> };
> If we try to read the cell "calibration" which crosses the boundary of
> the reserved memory then it will lead to a short read.
> Though, one might argue that the protection against such cell
> definition should be there during fixed-layout parsing in core itself
> but that is not there now and would not be a fix.
> 
> What I am trying to fix here is not exactly short reads but how the
> return value of rmem_read() is treated by the nvmem core, where it
> treats a non-zero return from read as an error currently. Hence
> returning the number of bytes read leads to false failures if we try
> to read a cell.
> 
> 
>>
>>> +             dev_err(priv->dev, "Failed read memory (%d)\n", count);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>
>>> +     return 0;
>>
>> thanks,
>> srini
>>
>>>    }
>>>
>>>    static int rmem_probe(struct platform_device *pdev)

