Return-Path: <linux-kernel+bounces-30660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325638322B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4BF1F2388B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D92EDF;
	Fri, 19 Jan 2024 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1rgVtvJ"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C181E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625038; cv=none; b=CtxIv+OQFSbr7VhsMTRlLu6f9FEqevLgOjoYIQq4Sq/1HgAhoasgYfz0Wb7aVRtKjux0ibAiJhoH9+0cX2PUru4pRXuIwCnwrSSwjTYNwb6U12FU2TtShNdaGisrkOIkg7uOnPuMHPxxKoM7w/hAWcTE6dPrIix0E4jvXND9Vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625038; c=relaxed/simple;
	bh=iEOt26FHv1dAFpGXqs+FEKRSjCiULGc3fJ9ltubgUvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkWk5yKfB624XWGcS04QADMtBHYtAsVSNfETR97Ks+7ZFahQH18K6h6JdjqM6oHgEk049N/A+VDAzCQ/gtN30RPIV3yrREa2MOXP1gW7dN9sEK4irrRMPUb/4Ocw3GrVlhvQFhMT2wKk3oH2MxrwiJs7Otr8O8bOpgA2zceS6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1rgVtvJ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so3929739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705625036; x=1706229836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mqk1y/5vRcF2I/Xwt0pfdoXrpTt3gsfqcyccPyGpp3E=;
        b=I1rgVtvJox1Z9HGRTq3Jq8y2m/Mid1w4cQ8WLiX+LTtTYsyj8MEq/eqOM6uFLxGTB0
         KwUrPzI466Lt9aPFhNU8SqN6nAppPAAkVXBcr+P3HhrI/AVfLQDH4juqcvo5dHn+VD97
         +/oelGmFDqMNcDp8K+MZ5mYPa6KJJcR95AilM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625036; x=1706229836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqk1y/5vRcF2I/Xwt0pfdoXrpTt3gsfqcyccPyGpp3E=;
        b=AEXJUuMMQpz8CzoyNuvvbr+Dtq1N8bq3ma3BS8YWyp3dcn3GtJhZQSItm2fd/p2Bhk
         44SwtkXQCGbVQvi06YUz6lQiR61P07NIlUPVI0WceiOm2xZWxf7P4f9/PNFpomEy/RNI
         gcV402NqI7goPAbx/fKeX9IQfTK47LUZNkt28lq093/+kJGzRDxeNM/+Qfqx92le2b/J
         Kpt4CmyssxYIw34Zwmx8OzAwvI3aV0e5zolcq+DUx/pqf57sbfbTxqY23ymZwYMhL7zE
         MjrK5VntbG/aRZ60Id0HzGmYhpCLl4Z4fpHdmOvVt7z8Hpa++U5VwDwG0uKmUQQmGjkV
         K8Zw==
X-Gm-Message-State: AOJu0Yy9C81WYWAU8TSHaN2eyi8Z2/V119rrKoT4mYfCSRF2JuoWgvAi
	qNRYEHAPiiimWNAh5bYCfyEYNEiChsEtnIUVPUppr3LRUmRDVQHEKB8sJeE41cA=
X-Google-Smtp-Source: AGHT+IHzM1Ap52QP7u8OfoImncqXOWPvCKiXEJEsJqEihmXKRNLtszw7jjYTegV/B8ONiQog1sV5vw==
X-Received: by 2002:a05:6602:255b:b0:7be:e080:6869 with SMTP id cg27-20020a056602255b00b007bee0806869mr1122277iob.1.1705625036599;
        Thu, 18 Jan 2024 16:43:56 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l10-20020a056638144a00b0046d18e358b3sm1323950jad.63.2024.01.18.16.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:43:56 -0800 (PST)
Message-ID: <beb7c9b9-19a4-488c-98c6-1fe2d8172c5b@linuxfoundation.org>
Date: Thu, 18 Jan 2024 17:43:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 03:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
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

