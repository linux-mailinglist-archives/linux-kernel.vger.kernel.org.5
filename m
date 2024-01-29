Return-Path: <linux-kernel+bounces-43604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532184167D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ADB1C23281
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B162151C51;
	Mon, 29 Jan 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aDLr5zs0"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F651C38
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569562; cv=none; b=K1jUjZhXRiDc0wrd6MVYUljk4a0eoICvYdKmhUxVcC/3lSwt4GLkIUp3P5qZxTJLjCCWwe6KkQP/0uSVnHP2GyWpmjhuyj+8Zi1F8NwytZjyi8kvtwoP+0UvLYaNvtVaXjK+cCerYw7x48bNPs7fsMOeV8C07iJoak7agUysNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569562; c=relaxed/simple;
	bh=T1i+0Z7ACB0e1waX+DNelGsHpBxFRWm1UAJdYGSjW3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWo/RY+3NpdORoyznMwCjkMpuaqgzDUQQJrdRuxWA8EbgrGqXAkVqbCmZDSHMuFRS0NvCiRqS0qo3sMgxzD44a2BIfNJoCuiRryxLXcR8cZ8wNf7UTKr7zWrGrSmJpotgNSuvu7mgVCl6ElJ3HT+rInKcXjlVS8EJrHK2YEl75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aDLr5zs0; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so3974739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706569559; x=1707174359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtZNDuZTycih5i2sdrujtgrVVk9yC+uswOIOzkl33jM=;
        b=aDLr5zs0/rTnaP4tr0X0Fvc2D7IABQDbLWl+oYH1uUWKApamAFTJn6u5E5BWvlQckw
         KVVbA5R2/tdMpLjdzJx2d39lCHZSpC3VoJNSLJFVbpNyGfBFHuc/XUn5nnBjDR8JBj5J
         8Mpa4veB4v0eKU2IOhFlKGh+oOA5WcD4kBij4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569559; x=1707174359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtZNDuZTycih5i2sdrujtgrVVk9yC+uswOIOzkl33jM=;
        b=LyaJEZ6zP2Cm75FOccQUeYFOi51KA+wNRnOL5pAPqLhzNJhw5j0IR8t11Kg2lFJjge
         roUbJnp0Y9WOuDgO6HtJwNLkAEJwqOkCmZ4TaE8GsQ4os+JPg0hs80RwqbcgkvqcQSsH
         C/knF5wEoLuPp+p4zBDsH+lVomkFe1JZcN5V2DxaEPs8keOuB5dB0vsb0gUrva6Y1+5X
         LyQqhmwwQ78WJIru4eM8mSIsPViK7J4HWIiO4ZWiaJEx40pyh0Bo0dH27wUa2kbQpdXA
         l6o4/5Uu/0WX7jo2wq0f9OZ2yhh60c0wrdvyreaKJrtUrLlD9IaJGNR2Cu07H5Y/r6mW
         Bsrg==
X-Gm-Message-State: AOJu0YwFtHuzGqEVjZzT+tJhB1rHwQpOx/W8DWatCyx1LIni3GvYwutH
	Gk1aSD8TTnnrNpdrmAM3cbW6+NvS7saZeVEKv56NhIqIa2A4qyH+FIKp1EhooWU=
X-Google-Smtp-Source: AGHT+IE6XcnK4WKeliuDrDTChW1y9AdUOP8cK1betdjliW8+3UzXaLc7J+q720eiwMh/frzYuEP3zg==
X-Received: by 2002:a05:6e02:1c8c:b0:363:812d:d6a0 with SMTP id w12-20020a056e021c8c00b00363812dd6a0mr4567440ill.0.1706569559541;
        Mon, 29 Jan 2024 15:05:59 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e12-20020a056e0204ac00b0036382acbf8fsm822713ils.24.2024.01.29.15.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 15:05:58 -0800 (PST)
Message-ID: <b74d661a-a857-4c7a-99a2-e5902f174052@linuxfoundation.org>
Date: Mon, 29 Jan 2024 16:05:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 10:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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

