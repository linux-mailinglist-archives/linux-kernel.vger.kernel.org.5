Return-Path: <linux-kernel+bounces-64601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E38540BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162BDB21C91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84765C;
	Wed, 14 Feb 2024 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gy3Q614O"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042A7E2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869737; cv=none; b=tnlDsd2UmHsW7FyXxVTZMaqVJnGPilqwR59IcqPoN2AXnNh/ZfkexYKiRq4vrMgw9NITfcdhRw9XnX9zU0A3EgXw2X/RfoI7CzW4RvdEdrC8dVCtkN10lZwttK/sM5FpijiCXrkdD7yuK/yy5jDVIvAIo59t6I7cSGkkk6snEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869737; c=relaxed/simple;
	bh=e/JPk36YcaAkB2eASchwf/O4/pt4gfV1CfqC3KKqLck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLYiKXk2yVpULnA99noElaMT95rugpcqZ7YH34qmCYICrGZpzpm/cbgGnehEM84ikUIFgjIbAVI/s+7Eldwm/7LvWbxfT3SDtcMRRBdGDzNI1pYwPWtNA8yM49YdjcPHbuYsI6JLZV/IPJ/Su/PRz0+JMX3Z4f4uGGnNqobO15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gy3Q614O; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso93844039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707869734; x=1708474534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2dMR0dbccb+q6sxSnuzRauid6CUXOmO7gipmGVqwVI=;
        b=gy3Q614OHRtayXXVNca16ZROgGbouqHww8L0MKv9bTnU7BcQEMldT/+XaBNAR338WX
         fMtwFPD//SEc1WScRDRRwYXKwHU+onUgzDC25ixWK5eR3MGSbUAFvWObQDpLCh8Y/CRd
         t0/B41LuJYwHY0Jb+TGVN/9SUDiUMDIplHz1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869734; x=1708474534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2dMR0dbccb+q6sxSnuzRauid6CUXOmO7gipmGVqwVI=;
        b=Aon9G+fI9Iz5NzDgXWjzUdZN4dlrmENMmvFXpXBo85w8q9leRyDrdmrFoysX74iyn9
         xRdyoNzL6rCeDssKnDW71kEBq+D7r8ug9DgXLfAQ6wpvjjWCs1AUi6IeWKo+mT+LpZwR
         eJvuwrtsfr9ILABXAQpadCOxXk3XlFMnhNLMV6olAQNQw6lITy/U4mOcndiFnbUyAnZN
         CESAC7U/8JzJ5fICj3cwfHAOlA+dsLgyEV9FD8ftB2i1qz9V/bIzf3ly5tMSqgUHmMRg
         TkWXFjzwPc5lV77m7+2ScSXE4xyU0/2VJljQoV3wZ1qsVjy1qDY/X5j8qFXPgqHcG4/X
         hK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVev0DtlJShygWDOR/DiW0KMGTlpLloufH4Jo1mY2rhDfvBuqgiwmNRsnBcj7O2ijdLe19ktd/HmFMoVhkupH46zNFPMc5UQpN/A2n8
X-Gm-Message-State: AOJu0Yx2vMJjQUKcnN3lo5YBzngf9f7e3UeqghpDJR+Ao7qrK16yPhy7
	sAtATAakrAqd2fR0lw4ghiyIUnOuXYMn9fQnWK9G+ZFi7H5lj+n058JF9UnlXAs=
X-Google-Smtp-Source: AGHT+IGZPxBDGfs1GmmWPdgYBbbuzmh0oqNysYe208XUtrQBS8ruPHHgQ0FygG9avlS6AY88n1HIyQ==
X-Received: by 2002:a6b:ec1a:0:b0:7c4:8398:ac64 with SMTP id c26-20020a6bec1a000000b007c48398ac64mr413794ioh.1.1707869734360;
        Tue, 13 Feb 2024 16:15:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoTjLI+7jQTSlcz2sbv7KXq9AUXRKEHCUIBP16b9E4j7pskLlJlDZ9IEdtWsLsmQVZWrww6JzE1txJTPJVH3MJTVv5ydQcdsJGIpbKgjBaZJcA8FEl3v7O7fhDZ0NSJsZh8hrRcL1GD/+MvtwFSYdplaRbm2u3zc2RhGJHuHH0EZIvjxCbQvIt3HzXhyz3rIDvetV7UwsskUB13liQdl+iGJerRZYxqtcylOFcL2bTww4+EESP5/USLOPr+6eZ1YhYBdH+7BbpgAn3EcitWCpQZn3GUbzyhHiIaSe4tKOsfyJrzN3Gr59gVejYLM/a4EjL3UcdK83FTk96hEJbk1FDXiwhU1k5wdLDyqctQUX7Hw903pbgV7+tsIgTlGBPY4JEX295XkHm0L8r4wezPiYeM03SQ25GIwUiegekayXJIkpiDlZTjULPZOuckAGwy286xe+2G4WaWD3ihzXA0nrxyVgxXlFGMY2NVp7SEKDcsQQkL6gx469uc40SrFpikyITMtb8CwlYM8n7ydK5dHzKtJIWzD3REkdUQwm3wA0ALLku9Iaxc1wWPuRYViDBV1+iW+bBNNBSxQ==
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b1-20020a056638150100b00473a063fe07sm2003035jat.118.2024.02.13.16.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:15:34 -0800 (PST)
Message-ID: <d66a3b58-2cad-466b-8f6a-cd6a10013b65@linuxfoundation.org>
Date: Tue, 13 Feb 2024 17:15:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc1.gz
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

