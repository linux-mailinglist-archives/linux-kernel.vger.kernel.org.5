Return-Path: <linux-kernel+bounces-34280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FEE83775D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCBD283113
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5047F44;
	Mon, 22 Jan 2024 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+BTYfW9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5B487AC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964672; cv=none; b=ZuI2IgBd0lF07xSLZJ0lcvKsnVMxN4RzxXMffljpLeN10GiNs5j3XQD4rXAHNjWlD4k2ZoqVf0r62bbX0GHZuY0gyVNuVcRWhTLYz7EDVoImoEeFUEmTa5mm+uzhqAwZOo9kxdNNj3Def0Xy5ANnl/MRuSbOCXOtMJCWAq4R1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964672; c=relaxed/simple;
	bh=DftyMU53+ApjRX/K58RTxmz1DDZhYiUsMFEdT0jdEYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkc38++su4Rq38bLKr4PIcNvOtq4h6eZ/tEuzkdzhHcjvhVG9yK92mLH5HU/o5gyYNllnJLceTHEcE2ZAavASaPjemxz+rWIs+Cq6CRg95KfBXQilRvEJveJwh8ZJiWoYYvZnpgWTu3cFZz8ncKkfSnUIgKrvA9tsNc/qvXiLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+BTYfW9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705964669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c3FgscPu0lXJFm3GTXyVD6XcnpcGhNdTIze30CTggI=;
	b=a+BTYfW9ONqvHN0Ky7VYEav+pvafmc5flRmNviO7GI9QPdMwILGSe/A3fIzQ+1Lr/B4VKW
	TtngNqV/+fZ9fJhOkKyCrQG2Wlp5+adbH3a92wPhdqirutQocSbj56Y0y6FkI3SY1yu5hj
	NzD20vGRycv4dM2BMVh4tTYiaBo90cw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-sj1WXMpJOM2rd4f5ZliY4g-1; Mon, 22 Jan 2024 18:04:27 -0500
X-MC-Unique: sj1WXMpJOM2rd4f5ZliY4g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e5ebf58fbso15681655e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964665; x=1706569465;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7c3FgscPu0lXJFm3GTXyVD6XcnpcGhNdTIze30CTggI=;
        b=bYc+EFMWCiR6aLUMpRayZcKbG1wxeOZeYCxB9NZr+VkIVJqVBCisB7xCdRr/+oXnHh
         auiEKuwav28QY1nA5/YMw2qXmAuckO0zdjKOGATu5o5Y/1oS44fpP4ZqHM2IAzoajif7
         daOwlgmEzKycgRcdoQWn3mAcZkhm8eex2Ju01TlJKLkbwORmerKIhUZaOkBsbJ7kSWp0
         eiXqRm5eH1h0q0gnNlHGId1Ih5s15pe/ULr4OnqIBH8wDkR0vwP2bI17ylH38A5Z14FC
         n53ijwlj/ErWRDZdu0D4mtdNXAESJVJ3HHqtjkab3UXiYQ7MPL0zfRsOFRKyBvVp0Pyc
         EH1Q==
X-Gm-Message-State: AOJu0Yw1E488UpeSerCX9rV9OR4vSqPnIHiG3Ci/Z3pEbd0nUDbyztFu
	R1lwbFVYt5QWQOxTCwEWVGXyDf93dJgWpP8cSdhxjEgMDgHnDzZiMM9GQf1KZOEPrC6m012clwS
	qVviKdi1wSFrXfuzANB1WMtvdiDJLpfAy1SCQMzAs0JdW9SJxD1JecgU0vtB5t6YPdJAPEg==
X-Received: by 2002:a05:600c:19d0:b0:40e:47f5:c74e with SMTP id u16-20020a05600c19d000b0040e47f5c74emr2213226wmq.23.1705964665579;
        Mon, 22 Jan 2024 15:04:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8352cOmaMtQLEHn07VgcDYdo9jNcXTeLbFnRyNs5Xa66msABsScIDJEFKORTq82yXMRla/w==
X-Received: by 2002:a05:600c:19d0:b0:40e:47f5:c74e with SMTP id u16-20020a05600c19d000b0040e47f5c74emr2213221wmq.23.1705964665204;
        Mon, 22 Jan 2024 15:04:25 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0040d7b340e07sm40645479wmq.45.2024.01.22.15.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 15:04:24 -0800 (PST)
Message-ID: <bdc7e401-a676-4040-9138-8dc5cf35bd05@redhat.com>
Date: Tue, 23 Jan 2024 00:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau/fifo/gk104: remove redundant variable
 ret
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Colin Ian King <colin.i.king@gmail.com>
Cc: nouveau@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>
References: <20240116111609.2258675-1-colin.i.king@gmail.com>
 <aafe669f-b322-4f22-a48e-564e3eb3447f@moroto.mountain>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <aafe669f-b322-4f22-a48e-564e3eb3447f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 13:31, Dan Carpenter wrote:
> On Tue, Jan 16, 2024 at 11:16:09AM +0000, Colin Ian King wrote:
>> The variable ret is being assigned a value but it isn't being
>> read afterwards. The assignment is redundant and so ret can be
>> removed.
>>
>> Cleans up clang scan build warning:
>> warning: Although the value stored to 'ret' is used in the enclosing
>> expression, the value is never actually read from 'ret'
>> [deadcode.DeadStores]
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/gpu/drm/nouveau/nvif/fifo.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
>> index a463289962b2..e96de14ce87e 100644
>> --- a/drivers/gpu/drm/nouveau/nvif/fifo.c
>> +++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
>> @@ -73,9 +73,9 @@ u64
>>   nvif_fifo_runlist(struct nvif_device *device, u64 engine)
>>   {
>>   	u64 runm = 0;
>> -	int ret, i;
>> +	int i;
>>   
>> -	if ((ret = nvif_fifo_runlists(device)))
>> +	if (nvif_fifo_runlists(device))
>>   		return runm;
> 
> Could we return a literal zero here?  Otherwise, I'm surprised this
> doesn't trigger a static checker warning.

Why do you think so? Conditionally, runm is used later on as well. I don't
think the checker should complain about keeping the value single source.

If you agree, want to offer your RB?

- Danilo

> 
> regards,
> dan carpenter
> 


