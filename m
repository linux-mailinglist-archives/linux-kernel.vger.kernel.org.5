Return-Path: <linux-kernel+bounces-137761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E289E6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27921C20FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE62623;
	Wed, 10 Apr 2024 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+d2S1WA"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDA7F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708688; cv=none; b=Tv2RjvPqy2aveowJPBGFaifDxRK+ks5+a0/soa/qLHiInnIApMQk6NdR5KMPx0L1e7EDQivpGe7NapmVVo3r3d0htRIkRSv4dpsJ/3eQpUGOX+BMXCABMxKcP5l/RG2b2FdhiPmrXH+aFjnjh9xaZtQM2QUnvsSg7ZKRFO1lghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708688; c=relaxed/simple;
	bh=GIYL7/nThlCUdA4CAU9q44dwx4jH78PDGJqI3ovNgOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2Cf8jiqYZa4nIcnhQDDXePl8hhWIvsQ4n8V4X5ntpRUieMX0yQOYo/e4xskeqqKg+/e5eyUA7TwjGYswJ3HM8Pd2U0sg6zUgRJPrhsVsrgwO96E66IasnuNyRNv/FQbSrfOfvsYqkTYEQ7+qCLLWh4LRo5884H6Q1kc4Uwm2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+d2S1WA; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso64026239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712708685; x=1713313485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ES6QomRFvLrFDB39gb2GX3zkfNFij1oZGJPnUaL3yX8=;
        b=a+d2S1WAcfuGXYh0F9aoVtK3ADrGR7rap3QlQseJSVR+ldrkof5ZhdRTBfYw5Gt83b
         z2kQSe/l/8UUbAaktAhLFhDkS/nsmfM5AxQWdDVWBKHTXj1CNGCMysEkmSD/ez/7vwWn
         3K2xsfsj+n14SnyGWTe9IxizhiEDclPFdRlNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708685; x=1713313485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ES6QomRFvLrFDB39gb2GX3zkfNFij1oZGJPnUaL3yX8=;
        b=Anp7EmM3aW7YCol9MVJU/qyAB3c4xo4IDB86PvctfgbCjqWGBklLJZD9b3nZWBT6TE
         hLoYt7DLUzzb/E2SaXtD3qUV0gmk7Bvek6N8IUtQgXYENj8jGFrCQasGMkfTkNv2kVfR
         DSqacuRlB/Q3kS+BnjqPVaNktqXiteJMbC2sKnfrO2zyIjrHdD/HwaPXAg/haScFOBDZ
         fNJDhLI2YwmTyTOyEI5RQE5oS1cv7tnbSZYWF5c7VxGwjLrkED4xxMRlZOklQvHjt3+M
         JeA9KZmjxlodNEHMyM2gubOf45maxSI8ZXrg+z8ykXOKZQawccNdUeXKeavpsZwL3/qf
         +oRw==
X-Forwarded-Encrypted: i=1; AJvYcCXKxskui+cwLJg69PGFyeqioKgXSleqVpk9EcZS758AzeC/VqfrsGf7FIyVvUW9p3kq1K/sP6VHDaTfUDpr3bvoe3R70nf74t2oUhz0
X-Gm-Message-State: AOJu0Yxf3wE/om++0ZWFzZbGvld7TuopuYSLPGkHjTBUdZvz1DTwAbz8
	+tjAhDRYWT7CCrRVPgbM6po/yOgwE8aKZTi2x63NNie1rekUjXPITM1l0Qe+83E=
X-Google-Smtp-Source: AGHT+IHAftx4RfZVpvtH7wznKTottslQUrkWU/Fb6KD2yX1QroQOCt6CIVbNLlH0WAmaBk1thLR4Tw==
X-Received: by 2002:a5d:9ec1:0:b0:7d5:ddc8:504d with SMTP id a1-20020a5d9ec1000000b007d5ddc8504dmr1441180ioe.0.1712708684989;
        Tue, 09 Apr 2024 17:24:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id el6-20020a0566384d8600b0047f100b70e1sm3630203jab.105.2024.04.09.17.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:24:44 -0700 (PDT)
Message-ID: <c1b7885b-8f21-4b8c-87ac-429799551723@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:24:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

