Return-Path: <linux-kernel+bounces-127163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC08947A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F81C20D90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCA5731F;
	Mon,  1 Apr 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U5Lsxdwj"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4854F9D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712013719; cv=none; b=gXNPFvGumdTSzej4csaVb8jjXFdxFzrzB3l1Yc8mGJHBQW0LF1Y5jvmfOQOqhoKSpLLFH2jw96F94h83WnHWlxkSAa7winc13iQpo3dOchHSyWm5A+eeTy4Yo5u6WHz5kgRXgQH6gY8HHGMQy6BcRb63vwUo7gctwCOaVp19Dig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712013719; c=relaxed/simple;
	bh=8MycgY6BBfBwIqPrlKKu8i5qHFblaOltdcEb722PSF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn9RvOBVK03bzckGG/GdxPzpcn7qLplxbCcHW9TqN+/URDgybDkOI4gUbqwCjlDFQHPcfCTMumvva7vqAWQlo9rMOWK4TljYA+0/bWrmHJIpghhyjqGv3CbU8j4u1E8NN21lNxkFqb40zQOx40VKUriL4SZgMB9U7UYYnanX3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U5Lsxdwj; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso27900939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712013717; x=1712618517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCZR9iH38Kb9dRhiV0AiJEI7O/X7Yfb+ffKd0ZTHNVo=;
        b=U5LsxdwjgEf5BDyqAtlBtA71+aaq+J4SE38j+3f9NuJb1HXNdLypYByQWcQKFSZUa2
         LMkJDbZaKg5iqZlXLUZvq94saTxmXwpdLZPNKqblyn1cD2MlC9NBB3hBySP2UuTe52ux
         3Goxx5Kd81SunsiE7W4bMrlL6AtEz1uycepAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712013717; x=1712618517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCZR9iH38Kb9dRhiV0AiJEI7O/X7Yfb+ffKd0ZTHNVo=;
        b=jko+xALV8la6DoSswvy3aWuo7P0oGSYDcE+sImViqK6vCb5mBw4EqEH7qPnx7k2Y2z
         Rf5Io8MT0MDFVs5voTVmpZiOskTitzpIlERdzxcmiVhD4MUA8bJLBvnqFbbdDSKyX4nf
         tStel3bvGzaD4+5m3cDwwQdG2jhysFCkt9uCTs8TvUUdko9z5+Zt9+M41FE4sAbE+vep
         ZRYfgMvyY5qeIWzn2O/kxCdPm9pv1oWCW2ReFJS3D6v2OTxUk75n8gSIOXUEZlGj2mB8
         ZD/MkGYZcGLbjMiCpG++tPvGNqcG9MRAsiMHe50tDdIla6+tk4LGu9JmjAG/ekPUNgAB
         tB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+cxsUk3AFU45VSii5N5zqhrOuveR+ZvEgsastjNSuX/3DGDbZ/ejn1Q8N2qGrF/xMDxm4zgb/U4u+rXuBComvqs0fe4U3fE6Pc9dg
X-Gm-Message-State: AOJu0YwTfmk5813wEjju8nUS2xqi1rfuJVbmEAH6Vk3wMUp7od0xdnLR
	6vjvQheTYoANPznD60B9FR49xstP+HuYA0/f4cxXM2h9asLRDfkQZlreH37Les1iilc0fuGNNkG
	M
X-Google-Smtp-Source: AGHT+IF8ovOp27CLqqDuGxdKtbnjLY2RcArOFGplCXQfB5OLQmRKKrV46W3Xn7g9VqmCuWiC3TVymw==
X-Received: by 2002:a6b:5907:0:b0:7c8:d514:9555 with SMTP id n7-20020a6b5907000000b007c8d5149555mr10177279iob.1.1712013717443;
        Mon, 01 Apr 2024 16:21:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r25-20020a056602235900b007d09c2f302asm2258679iot.39.2024.04.01.16.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 16:21:56 -0700 (PDT)
Message-ID: <8b497cb8-dbdb-4c9e-ac1b-a71c6c6fd939@linuxfoundation.org>
Date: Mon, 1 Apr 2024 17:21:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 09:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
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

