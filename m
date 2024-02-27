Return-Path: <linux-kernel+bounces-83008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28CF868CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2F5285DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F663137C47;
	Tue, 27 Feb 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeRFFber"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148961369BF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028504; cv=none; b=lhC3Y7b7uNqQdjTRqrnJOpILLZMTiA6/KUxNUL1Np8nAEUoSGnVHrPCEeFru55VxmlOKoEVPJBpbJTd0EEVDIopMJO1KR45WbiujtWVVjQSRcEABAv2BjSjGX9UyJtuW2jcVHgE5wcc5Mkp0ZEvTwFPhXm8SN4uEy5KU3uk4qJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028504; c=relaxed/simple;
	bh=OI4MKF6CdNpT7v2xjTJZcmr2tJKCwXVfHLHQP+OK1IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekpN+SN8pV3FjKg8eZ3VSWTpVZJM9OScNyWrZeOjj7rjXlL0xJSZgMPPXS29OGvv4w6AE1rOpBpId/jYZu1M2XRWUQxwjCOAFL2+jwreWVic2GbYECxamnKiZPKDqJ4HhIh8pyYPOeCTHfgXeIpxr8k7njNzUcKdvynvasUyNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeRFFber; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5661b7b1f51so1824377a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709028501; x=1709633301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooc5SS3j03ORm6wAIXAzAUPoc8fJQ9XOTzT5/SJVA8Y=;
        b=MeRFFberdKlzYsgoyxeKcHQ6ozmK+MMplb95efJQew4W7qlKcZkZ87JD40yTy3n+zQ
         D0Vt+gMzHUCNV40OmTJSGr+8j8wwITJGtUJn14jzkduNHBS1QpA3coTb64w4mWGESBmj
         Zpr+aJQSxt+A+9peqfq8F5e/n5ZX0TCexE+CFfjTUi2VBMO7QAdmqwelRhEIokO6z4R3
         xaMCZpStaj7ps2qupOCuDkyebY1uayxr4yM9rSFovwHWGdPsGKDfokNVQ9Our8XmLws3
         XMzJI8yW34J2QFtpeE9ST2ds/8xDW3zu3iYNFGsPK2WE/pm/ZVhIZM747utN1qaSC28b
         gZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028501; x=1709633301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooc5SS3j03ORm6wAIXAzAUPoc8fJQ9XOTzT5/SJVA8Y=;
        b=BLWEaceJEnPzkigOiX3ieYdMgpEmB1c8YAo3jlxObrdYZiLH9phulZwTNM71alwj/r
         GOGrUu7hYi06biGGGcxJw9U6FzZdS73dPx3MJI7G5sRO8YRMoAd7HX3NzpTnvV1p8DDS
         4talEOYWqPG5PUYaG/FrYO2OU/zMvyzL8shB2Ri/x4iYgQzmWEvCawFjfWuI7cLvsE7r
         p8wcpQQVSFklSfcpy5o8dO/AqclTbD2ye34sLUNOX4oHrL9KPkTa87Rh0NAKqjROU+6y
         fDYt2UC7vb5cwkDM7mRJObtx7lS9RsRKn5nYC7flfIxNoIFgXqhsRPpMLkqpvziPlLD4
         ww4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQAEaRCiLrSQQe9Vf5A1jZZ2nLlyEvutF3qFboGGizevGJJ/v1pJSf7BErC2KznmuGHHyLcxrEeSCPCBPhp8tAxXrJ9STm9pT+GOob
X-Gm-Message-State: AOJu0YwOfBGiZrV+XFFKiZ8o7nR519Mp2ZwIRRFMGc+oUt7t8cU2M0IB
	dzBgEHQgZDJ+nOCKJ/56sBxBN33yNtyeSLl2bOGCAMrowkjRM6aqb164jUjtu1g=
X-Google-Smtp-Source: AGHT+IE1EiV8Igbb2EVKLcncUtmKcFbSvxFWmJNfpS/Isp1yWRgR1sxzZOpH5nj0WUOH1E7n+jeMtQ==
X-Received: by 2002:a17:906:7d86:b0:a3c:36ae:6c96 with SMTP id v6-20020a1709067d8600b00a3c36ae6c96mr5271008ejo.42.1709028501368;
        Tue, 27 Feb 2024 02:08:21 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a43d1968921sm5696ejc.190.2024.02.27.02.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:08:20 -0800 (PST)
Message-ID: <ddc5c922-8587-492c-93b0-9fd6f584d081@linaro.org>
Date: Tue, 27 Feb 2024 10:08:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for BoHong bh25q128as
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 David Bauer <mail@david-bauer.net>
References: <20240220200325.19089-1-ansuelsmth@gmail.com>
 <f7c45e7b-993c-444b-8710-042da7512bbf@linaro.org>
 <65d9d08f.df0a0220.988bb.3177@mx.google.com>
 <CZEVS9033HET.1NPH0K6PQLR87@kernel.org>
 <4d117770-6e0c-412f-ac1a-d9ba84b5b4ba@linaro.org>
 <65ddac61.5d0a0220.a0c6e.35bf@mx.google.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <65ddac61.5d0a0220.a0c6e.35bf@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/24 09:33, Christian Marangi wrote:
> On Mon, Feb 26, 2024 at 10:53:34AM +0200, Tudor Ambarus wrote:
>>
>>
>> On 26.02.2024 10:51, Michael Walle wrote:
>>> Hi,
>>>
>>> On Sat Feb 24, 2024 at 12:18 PM CET, Christian Marangi wrote:
>>>> The user just tested this and It seems there is a problem in JEDEC id?
>>>>
>>>> [    0.726451] spi spi0.0: setup: ignoring unsupported mode bits a00
>>>
>>> What SPI controller is used in this case?
>>>
>>>> [    0.732850] spi-nor spi0.0: unrecognized JEDEC id bytes: 68 40 18 68 40 18
>>>> [    0.739725] spi-nor: probe of spi0.0 failed with error -2
>>>
>>> And what kernel version is this? This should only happen if the SFDP
>>> header is wrong, but according to your dump, it is correct.
>>>
>>
>> I assume the test was done on an older kernel, where the identification
>> of the flash based on SFDP is not yet available.
> 
> The test has been done on 5.15 and 6.1. The support for this was
> introduced later? Can you point me to the commits so I can backport
> them?
> 

Use git blame.

773bbe104497 ("mtd: spi-nor: add generic flash driver")

