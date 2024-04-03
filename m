Return-Path: <linux-kernel+bounces-130705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB40897BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED1428B2C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D715696D;
	Wed,  3 Apr 2024 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SejcQfFb"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE06156881
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185211; cv=none; b=etBCz+sfXQil2QbbfYoG3jlgiCHUbR/S5wTuMH7dVyxSoiydSUMxu0H0vUWycbQNpo99hq6JKz/sWP65cIwCxRUcOKuJt1zONzgiThry7l9HB/cQHJe8pYU3b5RDtPTJ+H6AGJadRnlp6Qb0kIxFs0akKSRH+M1C+NvXnnMOADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185211; c=relaxed/simple;
	bh=jmIV0GOw5opWjSRaLZcl7S1Iprv49UC3ViIj5KVGbdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEzwL6Zo9aS2lOWEIK9pNcLO0d9teAUi+D2HKPE2OuvA0jOIzZE6chSCZ3DNYmqGFTyPn/fZpVTT6VKLMiAjp/N0PEaWJ/LWTT2vzyEI2UHXke27iRsD44fwZNLXQRfwLCDqs8uV4+xak/kPWjVwtO1fV5tflEdoH+BWrBUXJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SejcQfFb; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso4636039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712185209; x=1712790009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDl1NAxggtWfWoUqJc0/YE9Vva3ljQrZuJwUEtA4epk=;
        b=SejcQfFb7FOuTKgTUU3n0ylMs/sEjsb40cr+bLvbttwvhe51sflq4vt/QsHqKuEqTl
         fiQpIlPu62O4WUG3U1zqcpR0p3Qb6cNgWLdUuKJeCl+jCJ+vzH4HqqQvOBKFzkglgVz2
         HXs++/9tUY6TgeGn23UaI2jVyP8gwC+eeUuVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712185209; x=1712790009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDl1NAxggtWfWoUqJc0/YE9Vva3ljQrZuJwUEtA4epk=;
        b=SXTDrQPTMKBtryExiW8mBKVB1xkbtEJj8Uv7VpW4jskUXOpAlTqIMiK+H7nofIZ7yR
         FLUCQ4VS6CBCpAmmGbeAJu7MpKBIE+VLHq/1Fw7xfPWWy970Sy6hgRMjh5VXDinqrYX8
         476Q0K49g4IBlJNFxMwT4KYLj8CMUh9pix9Z5sE13SRVgiiDnIIpLh89QcTDe5Sa69WW
         a1aDjvz97W5rGtu6fzVfUJ0zF7x4XSN7y5NDhJqqwu+QjXP295+inqbtONrfkpKEASjy
         KPVsS9nQhAP3kN53Oj7MeIKfo/f1iFVmQqvNKk17FMcESEHzRI7FfM9dq+PZapSw/TPe
         KuJw==
X-Forwarded-Encrypted: i=1; AJvYcCXz3lEnclx2Zbf7pOvv9XlNu9TSRppDhJwRitqxAgBXvBUqzJqpPVjM/gIfFrPqlFGpvnAucoUyzt0sR3JlgGBPQPMG9EBLvyNVOOvg
X-Gm-Message-State: AOJu0YxuSK+ydnU6WOSggVm9CgWkjQMZ+Aaj+YIebW680z2UiVdGFoCK
	Fhi3UA78f5UeQu2ga+JoVsVE8XBNVk1us/O5hvdYD40VKN8b8jKRxQ4HZZSbr7g=
X-Google-Smtp-Source: AGHT+IFl5XEZ2ibJnPA43ZuAvjF2L0kiBzzsvfNYmw9cYR0Av/jzR05d3ho2D1+yTpz0sqmI2dVeRg==
X-Received: by 2002:a05:6602:3418:b0:7d0:bd2b:43ba with SMTP id n24-20020a056602341800b007d0bd2b43bamr1609782ioz.0.1712185207862;
        Wed, 03 Apr 2024 16:00:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t31-20020a056638349f00b0047be37bfbbdsm4057220jal.153.2024.04.03.16.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 16:00:07 -0700 (PDT)
Message-ID: <a515127e-7609-4947-aec1-4a7cbdf72c40@linuxfoundation.org>
Date: Wed, 3 Apr 2024 17:00:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240403175125.754099419@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 11:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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

