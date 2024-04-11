Return-Path: <linux-kernel+bounces-141721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95098A2289
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A1828468D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F974D9FB;
	Thu, 11 Apr 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsq9GiUk"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B44AEC7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879002; cv=none; b=ZMXjVNmt5UAS+fhfpfguT+pEv0GFjYdTkZObVMXSn2KHU2QoWBEpnK5Mm7hI4pojXipCDYTXo41XxGe4zqvNgnp2L3u115KC63CRJ0XdnjRECmMHqQmFT9WDF04v+FxIKYMUKhU7LELV6A1t2znTaROOoNVwyfmOlVfUy/Bvy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879002; c=relaxed/simple;
	bh=euNP9GFzTMlL7dk7n0mj6KeWCa/Ukh/qAxFXqL0UvYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acT0jS5ejRY0rUewujwkYcLfTnJ4tLAmsjExSkcIjt6lt9QdP+NBZtXCdxuM5XmCGceGd6w337Cra2+5ObxDp896ZgRuTuHWA418oJJcjTb7Jlmhqx2B5MyzpYcH0mDfjw5Sll77ulcErGfm9XK9LNieFJ9d36ejk79G7zIEmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsq9GiUk; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d67d1073easo7101539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712879000; x=1713483800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftwuYrVcc3eraO9zw33nB+CAyySYVAqnz6ETdM0/8LE=;
        b=dsq9GiUkMUjAE/9hHurfS0U+yLdoKGbL1mNiGUK+oCLvjIvC5Dc91EOH5rETKKnRoj
         qAtW5O251Ua/bAMX011pUQdFtsphGS6ax5j/bxgm3IrH8Ho9tD8lQ+HC5M4ce4NzbsGA
         XcmNpmB9jZw5F22KMKeBW3ftjQJfyiBTEQhvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879000; x=1713483800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftwuYrVcc3eraO9zw33nB+CAyySYVAqnz6ETdM0/8LE=;
        b=f3xY4CVuWFOCnOwTpgcD+RbU1HvS4+HJ3sSyiFdMtjyIgdrCe9+gMsv1PjbsubbzrI
         tC9EB/8r7wQJaiIABGd1I1Ru+gpZBdCT5QWruQs3NqdoO3zIlOCsNuRK7EDi4x4N0WWl
         M8zc3jlNB9chQMJit/bpUbM7op7TZ65BlZW86O5dGvwJP/mpQP0LLLvQzp2kRcCaMLUC
         GZ/nOMRjEkG9eGoZLuVf8mQZge4fqh6bNdDXnSMzZ11RebJqqFRyGfxUWy1iDEiqCb+n
         BhL+PaQJTGpMIKJ98TrFgP8fqDdcP9ZjpeGjXYhz632zhi6Qobf+NTrV+neHarkwF/6N
         ceRA==
X-Forwarded-Encrypted: i=1; AJvYcCUGqWi6k5oRMAlE2f4YNqV7UODRxYDp9mzlMHVjKsM2tokUC+DqHILr86xkGkB+/3t593WkpF3izK9TmsI0ROx7LlZjuB5hM3BLWWc9
X-Gm-Message-State: AOJu0Yw8sghwIZsrSMqtixPh/Mlz/LcR/WnbZrhzUKPqxeTyWa6hPqQI
	0212D6JzmXmF/XNEdVE2nX1VNUsJ/qNDq51v0DX5zpoUIpSQCjM3KlqMGPng0aA=
X-Google-Smtp-Source: AGHT+IFi/4KYRs4PuSpmw/VIWvfaUej67bS0cewEgnxZV2DTetbKiVyr7CY3wapXFEqbezkxkPfauA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr1532834iop.1.1712878998599;
        Thu, 11 Apr 2024 16:43:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m40-20020a05663840a800b00482b8b12872sm667259jam.174.2024.04.11.16.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:43:18 -0700 (PDT)
Message-ID: <cc48bddb-93c7-4a75-9d78-e88a9c6fcc1e@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:43:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.86-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

