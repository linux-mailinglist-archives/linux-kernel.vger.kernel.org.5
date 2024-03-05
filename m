Return-Path: <linux-kernel+bounces-92867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E1872737
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1087B295E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95EC23758;
	Tue,  5 Mar 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmH6Yd9K"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB21B81A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665312; cv=none; b=jD8aqngSnOobH23v+IuTXLudXWsyQ4db8dAZro3/Gigg54HZq+j5ZjI5LY7ka3zYaEuFpuXS8VFSf8bbCGqpXOdgwbk5OMKomTanAb6cA9arJPYrEtLkS/wDzlYb1MdZ2M7Vv7kNK3dyI8HGogwWRWAkKtAEC+yD2m/X/ywRBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665312; c=relaxed/simple;
	bh=W+RIx2s7YMjsH6sJS+7De6hX1x7jsNpUAzQ0NlcFJiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBx+36/YgvpGipdH38TgikW+QBYD5WKNNEw0b+EbGMj6O6BZclzZGwQdrfYPM5CsXrdCmYU3ZH6xTbbh5QcfkaVzignp8jP+kJ50DQXV5qaq3khJlkG64XZ9RRDh+HpVOzK+uZzffpKtRPzzX/ETLk8l6OeOM5k4cS+oTs5G7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmH6Yd9K; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c495be1924so55155339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709665309; x=1710270109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phLlY2jti9ivqH/MD/B8hzSvaQLkns3JMxn+/mmfZ+M=;
        b=BmH6Yd9KQ1f4d9buSjjegRAkkIKEV7O0E2sLqI7hiv6z2RFKIYkODb0YF4EOaW/mQ1
         6pGrz3G8V6n97LW2Owq4pbbAVYFB0h0efDf4yyy7apUurGzjRtrp0Pg343thgPmCWgU1
         Be52jsyChmkCnKXvxHoYgAuMCxzh5r82egGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665309; x=1710270109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phLlY2jti9ivqH/MD/B8hzSvaQLkns3JMxn+/mmfZ+M=;
        b=buAEX7BYb+8yhby7xQk3Ht+t8Sn7tTcT6nQFMEMqhpm658Jym/GXxc5rvr9rVpkoDW
         +VTv+cvWRSUQxQy2V5i8qf8bMlQARlugyIpGd0l4rBWKS+bn9B63BSgv5yNFzbhy4qkj
         tJPwzFN+RIe/DeUpgnEUY+TqeBM68UbMr5LG7IU7w1p44zz0bJBDJALtHVlvLpCkwMZd
         zQfj+rERLUZMg53hNLNfYqHiy7IMiLa0bLtHZ6g296wz5uDLK+XRJinNrKgTd2jj5J9U
         8Y3QmZJAwiDNeoo64oZfrL2qHUf25cd1Vvg+Ol4aKamp/c17c+0XSziR4ZS2ctPKqtkG
         l3qg==
X-Forwarded-Encrypted: i=1; AJvYcCUTHFDJdDy635MnJh87owtsqcapBH3IvyLKUiaGKEwRpKluqt+eCFVZYRoVuyug3Vfv88f1PihGpA2f61guBctmkApDaOe/Vpfyc5JY
X-Gm-Message-State: AOJu0YwPssRLNjc8shwRqp7YddC7Cqq/WBWzZb0UdEeVqY/A2OUfRdFb
	n2p1IDMtXoOGrY6I95bRWNwnIRaW7p5kMSwGO/7uu+FL24NPLeK8tbXgHmw8M40=
X-Google-Smtp-Source: AGHT+IHPMuTBc1rTAxSyEKpsXnbRwfQXwOdorpfvId7aMNK3EeNnLlymF5/PNN18AAz8Vd4mwqm2gA==
X-Received: by 2002:a6b:6b15:0:b0:7c8:4963:5bb4 with SMTP id g21-20020a6b6b15000000b007c849635bb4mr1607918ioc.2.1709665309410;
        Tue, 05 Mar 2024 11:01:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d59-20020a0285c1000000b004748b445684sm3126093jai.21.2024.03.05.11.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:01:49 -0800 (PST)
Message-ID: <d8df9362-d0a0-4994-bd2e-6bccaba95111@linuxfoundation.org>
Date: Tue, 5 Mar 2024 12:01:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
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


