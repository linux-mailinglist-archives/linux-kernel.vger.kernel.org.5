Return-Path: <linux-kernel+bounces-75680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F85F85ED55
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5763B1F241ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E112BEBE;
	Wed, 21 Feb 2024 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kj7vU/Vn"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9112AAE2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559169; cv=none; b=GC0Vf5KhzLdcO2JhWUcF3xB+QcP/8ZBCiOVQUbhMoRFFkyaWMa57/y/kHM1ptvuTk8RIBlBu90WyX+wJFOkv1KdRRBEgsrXx1uBCmI/tC5d+6PKIHRSi6xssXQO5cLVmfKKSr/6pyDzCYFtC8cTn40cOs46D8i4NWPcCtbsTdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559169; c=relaxed/simple;
	bh=gt2zbHp09sQ4E0IXRMe5CLcXg4e6+9enng0YONTvvo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMBXgUBqeHJft+EWHfEBCLjpA+/fYBNMwh+0KNKGUWszxEOXgl+lLfkIaqJHB9foVaoxq1Z2vj2eA9tiqEdpHUWJpoPtdvF18ZMSy8iBZQZRWn5BSRiVrj48ROTGdMc4yp8LSiITCWvJISppnAp7GK5aQlPfWnDv/ZI8aQJqYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kj7vU/Vn; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso71278739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708559167; x=1709163967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAKcgOx4dnAtWUXFdt+Zxs9fPqeZZy1uNdBw2DnFh8U=;
        b=Kj7vU/Vn3mJbILJ0ZQe6NnB3yIvTWOjHOH2pShWdnMjTg+x78FKawvYRGwcijuQmcw
         KE5yBxyIhc1goKdYUH2vJjOl5wO3gbT4h7Rzqm9ty8Wnqjwz8qXJwRSFr0Tasvjw6BMk
         QmHhfbFk6LKHkSoe0hybaPTa5mLCDk0GLgwH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559167; x=1709163967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAKcgOx4dnAtWUXFdt+Zxs9fPqeZZy1uNdBw2DnFh8U=;
        b=LknwGTj5blJinmogamoq2V2okwMW4qgTbh1oybaDCizp0gF4XnMQNsSQ4M5LeDgfCx
         Msjr4ni3aC/V6ggLorB8GCkK4Zbi+HowZzpFUkgTFFUJ/GxtkEqVD+4I5oHxdin/S7tz
         aAaqCE5dRPJ7BFC2DDsWAmhIVJdwW5KyBGOD7jVjGLFt1EvUZfq7W5hPo/m5FpWMeexR
         WTHK60vn2y2zCojkPwMkwq+Mlb5AAYgSmaEQa2oL5c4ohAf8X2Sq3+efqSWmBJMcUJom
         T7FDdi5Wp/hkjyf56oOHuODj7G2x5KFFQnhgWXvMEUZZ5o47VmQ4zWHkOPqM7J0HX8EK
         ig7g==
X-Forwarded-Encrypted: i=1; AJvYcCWtRB6pEA7mLJw+jW3FjgihFNfd6j5l3yOKK9O4y8o6DhQCBHOI453vvDBzh3McBN/QcfKf3ehPuicNZtFMocx9Jr1j1z7ymQZDTbKk
X-Gm-Message-State: AOJu0YwoJhcZ1jdqo4DRIFUxtG67d9YKhHEl6QujO9vWVOOC2E8FZjIg
	tHOq0sbe1BOPY7OUMbyd6okQjzo7WCRU79lG6xBtG1TA//vAyzmEosWVtBbU3Yk=
X-Google-Smtp-Source: AGHT+IHUxQhgcp++EYtIQCs8Ay614fr69uXwCM/LhRP+kEK0r1PasMk0Q7ScDHW9tdbD2SQB9Lxj5g==
X-Received: by 2002:a05:6602:2545:b0:7c4:c985:145a with SMTP id cg5-20020a056602254500b007c4c985145amr835299iob.2.1708559167143;
        Wed, 21 Feb 2024 15:46:07 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b14-20020a05663801ae00b00473fbb3eb4asm2936835jaq.105.2024.02.21.15.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:46:06 -0800 (PST)
Message-ID: <46cb9bb2-2af1-441e-9a99-44600c1ca33e@linuxfoundation.org>
Date: Wed, 21 Feb 2024 16:46:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 06:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.269 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


