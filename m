Return-Path: <linux-kernel+bounces-141729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B842F8A22A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D6C1C21308
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCE4AEFE;
	Thu, 11 Apr 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ax+8tY8H"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7825647A48
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879777; cv=none; b=U8y0iRcHvF6q3h0mV/YCzUdFQOqlPCBVGyPSSRD9xfqRqSV4Q463oLd5REDLvQuUaBAktHwYbqOR0VViLG3UArFowvTXkgy8Jcs5nuwdHFNRd8vnIbACv0AcMkCwbOIeSoosD64W5woa+m8cP/4MZordrqyqU3dBCOWbvPchth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879777; c=relaxed/simple;
	bh=1hJuW4Q6DIb/H/sHiYOYExJ//bqXgHS7kwabOym3u1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnX1zI8dc5m9RvxqlmzhJzT6WskfLVWzSrHnWZj5RqL58Fe8/W4t463vmWBgg1HgdpApOe+6jmF99zhCBjqM+XwTowdhl6KeknK1n7ttUmFSy72NaQ490QX1nwQfb8boRk5I1q7U+YBREDkpEBxjZrdC6Y00jMkqYgBzMdxzQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ax+8tY8H; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso7992039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712879774; x=1713484574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qe0CvRWLgYscYGo8HB4Lqcq6jCdobjBtnisZZSsYEYM=;
        b=ax+8tY8Hx9T+pGfzUTLwrcFhDUP6gZduZygzmij8iEUD/K9t63R2hSY0r5TO34whZk
         4DSVX4/IC+85oXl+NGdzkgVOu02adxYYPChJ6NUyc+IHH8XsW1wQdmsjBqXV+XFofOEh
         IajvAi6/GaZdNGq1LNX/yzxYSZsReZBpAohz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879774; x=1713484574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe0CvRWLgYscYGo8HB4Lqcq6jCdobjBtnisZZSsYEYM=;
        b=INSKNW6W1/XRPajzJqvs11YshsfrMWaFiEdGh1NDS9Bxm9iNIPZFWqfQFgGjFK1wR3
         oRYA5VMiwD8jiqq+fPIgPKSG38iS0XVfG/dHMUZCj9QhUZVi7+1GUOYkEP5isvo7t4Qw
         yPX0pJ6L24cRmOJ2CmxysIV4me1U5z8OtKRlCbgrJN5dUHSOgEqoOSvOT1LIU1AwM0Z9
         yjsoc1WAESrtrQi6dz/1vt//L+xZ9dgC3Eo9qbdHCyPj3JFjlXZRlsu73y9F6A6xh2+V
         SOEYuvSiXGwLHnhKCaG9comT5uaff/eDwYAxS2UeCtWMjB2ZD4F2mV/nfNR2vGJLQZFW
         E4sA==
X-Forwarded-Encrypted: i=1; AJvYcCXjfvJ2R1mbBQ8t/Q0By2zKHttSdYMQmfMjDCo9KhxBI1FWehgrevseeH659aJ9ktrTRcJaJJ3b8seGdHaKM9hAqT7RzXJFmx7FUv5h
X-Gm-Message-State: AOJu0YwYJfLjUfjNUjnWTEXzAgttEHxY4DHRQAvQ6KD8YZnZgE/buViT
	oYR5a3KzxJj0/JKmkq8stBc6ejQN4qbq+NvTuyJrzTN/OlHrzzT3B9myztm/RpY=
X-Google-Smtp-Source: AGHT+IGV0IhqS2O6YRkP3iIt3Yudyqf3AzBPtdznd78B8RXYp98RlusRMAJ9uzdymcwqzIpF6kSb0w==
X-Received: by 2002:a05:6e02:194f:b0:369:e37d:541f with SMTP id x15-20020a056e02194f00b00369e37d541fmr1456230ilu.1.1712879774647;
        Thu, 11 Apr 2024 16:56:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r13-20020a92c50d000000b003698fc3a541sm644512ilg.80.2024.04.11.16.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:56:14 -0700 (PDT)
Message-ID: <8de5278c-9bf5-46ab-9fa0-ffba4c95b4fc@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:56:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.312 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.312-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

