Return-Path: <linux-kernel+bounces-85402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A190286B567
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BED289FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1355C32;
	Wed, 28 Feb 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLPcbDN5"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D217208D5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139510; cv=none; b=E2aG/BDIrmxoFyP+ltx4l7SWS7coiux+aBVrbZ/JxNXzW/II4EqLwbJHtdfuEJi5rwXy3oqbOZgGDHhQYFscECDv6PzxYfpoy7go3HoN2a/UDh5nyAEk4IvVDLdvZI+oAZ39aBZLZrdFK3IhT7TYkFvi4gLXVZOC6ye2hMjBQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139510; c=relaxed/simple;
	bh=bMlDs7yBQYCcu4DKHS4UqUXWxsAp/yIjHTqNlIRq6mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZwo3eqDcAUUc/imcP2RF19tkCImtHvUOZkvkIMU6P4rADslYCtKoYDiJW94H3Fe74bJBQdwkAGufa9cXL+L4IddzoCdlv9rITCwO/H1I+ReUJTh9S8HGHL6C9O9Wo2kjysUMy1L/jpaUxh7GkUeCu1CcEZzo2jpysIDzbHoevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLPcbDN5; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso114382339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709139508; x=1709744308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYAQxmYZbaAZw17MlObOfiOcMGN2Gwvik4DkJbgp85c=;
        b=hLPcbDN5iplNoKVUID8bl3gl65rj1hI5sEUilwd+YiCPyJVRZMAnlDiJ74xEyGQ5qq
         olYiSrPffrcF/LvSrB8d7fEVJv76ZE3ufhRGaI5u13/KTeqT/o1VtQRJSURPG7Jtl9R5
         TW8kRNgmx02g1RTa0ULVqpC2gRbJESiHoxcfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139508; x=1709744308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYAQxmYZbaAZw17MlObOfiOcMGN2Gwvik4DkJbgp85c=;
        b=TaejaooY0dZi+xkAKlf1WYqlZXQpN0dT0/CmDpLLcjaHugaGiy+bRiJlnURt0bNmfp
         LcDKQuV49xoek8rEiK7x7vk+q9Fi1OI0hOCtxRIKVQRrYcquLglXXZMp8KwgsrcVMMcn
         NFjCmpYJiGjSYZgNuwnIRyi+Ii3MrQ67NSH5gYFqEauR3or3dTFTwJbaLpB4LvGvMhQv
         mCy4lKG/T1lJqeXQHjTzZNYi0aB8Iyj9Hd+3LTNUQjO28+5BDm0WWl/EiNbXqCsTm049
         8GxFYEv1/zav+QprOg2Gqp5iWUqOMMPqRczBIag+juraQLsBaJnOfiDJVVh2xs6qCYkS
         Jvog==
X-Forwarded-Encrypted: i=1; AJvYcCX8vzpR6LA0AcfcjCiVPeaUsG8H2WfDQd+TuRDDCPjq3ZFlU44ahZpC5ljcLF8YgtmVJ/7uJ06sbW/oihBLbsSxiZWa0oxf5cgQL7DJ
X-Gm-Message-State: AOJu0Yz/pAUD6JV/UATbJFUH2xPQHzlur0nq/uU1qiionoPyBa2ctsvA
	ufQ9XaTKGLwVuTbiW3dMgB6jSrM/OUoVLcNZZ3Qic8Z+SRtu6/s8yLB1OJjsbVo=
X-Google-Smtp-Source: AGHT+IF7HKqsk7OlJFFWRmBCmrY8cVas7yNe8MrolNXPjuqX96G3BVToSjl5cGRFw0X7TvetVBi6yA==
X-Received: by 2002:a92:cda6:0:b0:365:4e45:33ad with SMTP id g6-20020a92cda6000000b003654e4533admr12524621ild.1.1709139508320;
        Wed, 28 Feb 2024 08:58:28 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bn29-20020a056e02339d00b0036533cae5afsm623565ilb.60.2024.02.28.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:58:27 -0800 (PST)
Message-ID: <2902f57c-4438-4761-b48e-d40bfc019de7@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:58:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/52] 4.19.308-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131548.514622258@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.308 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.308-rc1.gz
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

