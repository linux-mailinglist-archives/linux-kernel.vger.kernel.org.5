Return-Path: <linux-kernel+bounces-165930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C3F8B938D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847CE1C2093C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1018E1D;
	Thu,  2 May 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LL4xSxad"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA31862F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618906; cv=none; b=NyYMOYy10zlk4hZDXo+ZvkAsyqg0kx6RorI2LKvRoYlsFH9734+0gNhYwIik1t/sSgZE4oxKBB1M/bgvf3oVCoNg++vvv/epuVzoG4Qe2qbo1sJcMdo52NE6/Bua8w9L0cBdGa/yo+T4lSg3cOX4IUXocFwzd1A1RAtBwMrN8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618906; c=relaxed/simple;
	bh=BkZwjGi9xHFmiL4nfLiT+Ex0R1ixPTG84Y2Wyym36rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scELnbPx7lbJcXHXTV3NAFCYTPgAMmuDt/35uKf8QjmTbv972JvAghNu2wzC3Pj9yjMIJNEV3nbroiO2A3zz6/gQuM6r9KJp0G6f55TmLp4kuhO7LaOFeN+vEouqy7Wop/ng2t/N15j8AZ/xIQ8CCBJlE4R6NsECiB1YET+eN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LL4xSxad; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7da55194b31so66379039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714618904; x=1715223704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEbLbPrNhjOiBsrjmUYUubkruoX+8IYozwRGt3/a5Dg=;
        b=LL4xSxadI/SHLyt+ie6KjVIszYT5ZgYQtfzY6lu/0pRV0XL4IJRyAKj7kMUEaL7Dus
         2Tz6kskAMQYXBRyf06dDO+sn7B2fPUWptYNctbw4PTsXDDkaXzSW1doolQ6C9ViiEySC
         Y3/zC4Zp7HJhUnLII7151xeY8Ka8xJve/a644=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714618904; x=1715223704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEbLbPrNhjOiBsrjmUYUubkruoX+8IYozwRGt3/a5Dg=;
        b=RDqE/4iZ7nw/8mBzJDewHCFTbE/4x7NtOGRBmCu8EjKOaRaHhaJ9Sa/a1VDn7nIKNS
         DmTU8xgeyU5CGQ5afv8mDxOguHh1XcwKJJvSziLxQTxLl6YE9LkNHvzpukEYP0aEQ6HX
         jZ1tKD/zQVpSjT9tZRowJKTLIu9ykAIs+N9zKf9fIZQIseL2/HT79slogGcTqT6hsitU
         mxQQBA9aQT9Lm/ZjM5k2mc+C0H1/1L+f65n6mrHm2CVgqGsQF+7j4y0gunp21aF5XtxY
         JIIa1elxuT60T8OqrheI2n7jWeZckXkfSUJ4611KBjMikOz/IfTf8cplgatbj6QL6Diu
         /08Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiySJxIierQ07h6L2GpZ/eMQA+zze5MBM1NyLhm/3MhdrYx12ATDUlzdLuGSeHMRCtz1t0eOxN9gPIPHBudsnT3pfjGbntBtjq+aa/
X-Gm-Message-State: AOJu0Yw6tina/bUq3X2GRb6MPQu4OIbjTQvma7bCeMSs/SH5SxbIhNBd
	Nuz0Hm6L5wj2ORJ1+/p0gsB6LGV0ytQtbPOB3MoE0hzHCi+ffAkFjEJjg4P//1Q=
X-Google-Smtp-Source: AGHT+IHjgrfimqrsDqQVMZXl8hehMhT3txq7RWm8puN/VGmrCn5LcYRp8OPwG462EjPGbVuGDuF24g==
X-Received: by 2002:a6b:3113:0:b0:7dd:88df:b673 with SMTP id j19-20020a6b3113000000b007dd88dfb673mr5566655ioa.0.1714618904091;
        Wed, 01 May 2024 20:01:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ky4-20020a056638940400b0048805115ed7sm968194jab.79.2024.05.01.20.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:01:43 -0700 (PDT)
Message-ID: <d1f1ee27-4606-4a84-85e0-284936e453d2@linuxfoundation.org>
Date: Wed, 1 May 2024 21:01:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
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

