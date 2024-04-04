Return-Path: <linux-kernel+bounces-132080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC9898F70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8981C21D66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD98134CC2;
	Thu,  4 Apr 2024 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpPo/ywa"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673881C6A0;
	Thu,  4 Apr 2024 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261480; cv=none; b=aZ2yoWLcwP4WpIlPBnEp3hCG8NAC1xoQuLvFwAEGB/ohSxIR4Ubawmu1tIpBZ6SyLOmukxJcuwGfb+c0QFg7qlWmvd9WNdq4midN3tDa/EQDsoDiKLQ6P73EQbqoktQ9mS6XvM2qReWWdHTRA3dUPRodm4NJxK9689teRM25DF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261480; c=relaxed/simple;
	bh=M8iIHi2wG31CMAypyB9Hf3PCit7uyA2n3iFds5lnbAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPkFV5BsxIhXRA4vBgCIj2kGKI3zKc2Qfk6YzeIWtm95YF/Z5kIrLY22SdGERmtSnzfweN+POecdN+zUaEYb0HjENd5HfYLfCsmllqDIE5rE+WPSE5ItEZLVsNMYc/V6K5QgGnHEW5LoJlvSPG8YNqWoEx2AEg9IUa2B0pEd1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpPo/ywa; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e3a6fe180bso644454241.2;
        Thu, 04 Apr 2024 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712261478; x=1712866278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjPJff2sg2YzMJe7DKQkjhJDQMLyOxul5rZyxHlPbrE=;
        b=UpPo/ywa8RYUorUlEHsIzYg1c8YxxpKIk3BW4o9/QHhEWWVR/EX/OBiCIssT84rME4
         Na1eLCWAR96o6hWcOY2dw4Lx3Bn0QrHJI/nK/yCXj8bCEM1BxBVkBZd3uCcUpHDBXSAa
         MXyhggDZlgHyJCPGKpEtuROanTc5ku14ClZr3FmZFfR1Le5LF4Qa9oUo/APjpuGF61M8
         j13oKHojUsWVLV++Pv2bbJM4zKV/mM15+dtby/KsOETIsKQcVAW6GPDaq1gV1wf4OPEf
         z2lIbHhqA5Xc+w1EZegtNS+d8dG+9rABNUCuhWAbKcOz67VFf0CN3OLMyrZnTn2vEPEI
         Pe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261478; x=1712866278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjPJff2sg2YzMJe7DKQkjhJDQMLyOxul5rZyxHlPbrE=;
        b=UM/7rKdddnV8UFElpfApxAXcUwRAyRF2YJDZSeSGMYkUAvx4uKUSyXU6TFKSOmabPC
         9XOHB3JY+UjiZMQ+zhfzFZzlzNcDj0E9Rx003Jg6bP2myVl17JYWDCZpxJRGM4dlP+Al
         ZOWmXkoZFzOLqLyvu10gAVmLcIESyTO38rcmqEUXoUy5GMmZD+bSDvIqhP3nrb9skPJq
         OGbLQ2n4RlpGSFoxLndH+6jSeXsY35Bn5KFLlo71OoFQ4fZAfRpPkmR2o55FYtwC08ks
         sADegmlnZa9UWxRy7sYsQEcCkC2KgD7VJ1ddrxynWzBoA7LSqndnJEtxyyoegmK8jrhX
         1ASA==
X-Forwarded-Encrypted: i=1; AJvYcCVfS6edXRI5je0cN+S6rPLyVnxZS77PMAL9I2JlQlttaRxbJux4KHfEQMNeyl4TIELQ+EWkX23jbo0gkOXcYtBtRAH6xMfbZD95WGjbOotUEQ8Zt7UDiivbC1hy5uvzo7eDobra
X-Gm-Message-State: AOJu0Yzm6yULJsr1dRjJhCqUl875YuAlCZrZUWnEPFywiV4gTsO7m/gU
	7cH+c/b5FFkid1hzVMAxbRVaIycAMdshZ8LJ2IMRdH8DfsQjfTTH
X-Google-Smtp-Source: AGHT+IERUiPcO7YKkrekeSdBQhRTR0raqdh0bkL/Rd5vl2K9OCFPKO5bBhKykLnsoGvvKIbbYvcNuw==
X-Received: by 2002:a05:6122:4591:b0:4da:9d3e:a7df with SMTP id de17-20020a056122459100b004da9d3ea7dfmr928443vkb.5.1712261476812;
        Thu, 04 Apr 2024 13:11:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fe4-20020a0562140b8400b00698facb19d5sm25978qvb.106.2024.04.04.13.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:11:15 -0700 (PDT)
Message-ID: <2e5e148b-1d5b-405f-bfdf-b55cf6ee5489@gmail.com>
Date: Thu, 4 Apr 2024 13:11:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240403175126.839589571@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 10:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.25-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


