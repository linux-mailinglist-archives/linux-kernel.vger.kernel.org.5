Return-Path: <linux-kernel+bounces-127187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9618947D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940011C21C76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416285730A;
	Mon,  1 Apr 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IQoiquCy"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CE56B9C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015026; cv=none; b=mcv82OD+aWP286rN+exs1adwAlj2YKxymhRjvlcpWtRzOU4R+rd9oQQIwD4RduUv4DCIyULX897/cDsKdBdKGn4LXCwQ8fLzu6e/K3RJdYehCVDJlhv16UK9tQeDbY1a9q2uftnLU47N8MiGgPuw5p+PMEiM+i/CNTIawe51yZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015026; c=relaxed/simple;
	bh=/aLX1T9kIfi/EGQc2BoJLbyZzAFpieW25xRpsLJAQhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V37K7n7q3Y3QotCULOt29iqbARdkr9sxX+InBCZ2W3RAyQ/WEsmanWGK5IcmsFP5X1fzuw2un8D9e38BEaSZwgPiLiLenjGMwd6IBw+sStdOx0POHD8+RFUHYxss1qVb4kVjPG2vg7U1LGpAKsvfJQcL6zNJRj/hUWk76SHn8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IQoiquCy; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso9334539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712015024; x=1712619824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sr9emmfv58xU3HXjhcchlx0IFZWjrl3OxfAHso5scdI=;
        b=IQoiquCyLWwHK3Q6GPQxHEjN9BaNIZfMZQFhplOgxOJ+l8MpkczyZ3aZ/gamwtSzo1
         v78gmD9DRXDEHYAd1jI3+ucL0HBU1jybOp1J1QZ6ccJHhkJJnNto4oTQNkGzvTahS3+m
         Kz1iFdkEvrjHX5xQ/OHAM6xsNP01mHgdNkKE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015024; x=1712619824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr9emmfv58xU3HXjhcchlx0IFZWjrl3OxfAHso5scdI=;
        b=tGtEBsqmDjFp7FQLkeHjWUC19Iy12hWWida4+Ff7B6LjhOeGirpBUDr8EsQ2MPUESv
         uVcDEtuXiZn5G2kpzNHzzO0GnDhKZbM0bP3XfrLh31tZfFddPYJcW30Wsc4K5nfRv9Dq
         gLg0jWp9rIUZDpr11Cofm0YBNrQ+oqY5iozfLeV84SBFxRLyHuV/dZvE1NBS2r/mr0xm
         u8ltnfsn0jQSfowGKQY/IsI9gv6jPCitvGv5Q+yCNsQX2XQIG87GZnZI/8UvwXBi2ZnI
         MnesQBPHXAV5S1TXa3hCPTt6i1EABhpC+UBKqki1FLl8HOKny5GMWzHQ7NVOa9bXDzbQ
         2RuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi2JkzLMiXILq2WQ2xMpmZtordQ+W79Q8jSrXduxDPleojczHwIfcH5myzbjNP3QTh5lwMT6/2gy5Qa51MRHu4dHhT80d8MuB/NAi+
X-Gm-Message-State: AOJu0Yyl9jpeYlyy5gaafnocxReuOAtqqh/ksUkUN/mEIXR3sX/F0xNf
	QE56lRG+ScJ8/imHAMrbzxVzMlptb2E9fNOAeKPoXouIAGauELr3Y+THv/DxgCM=
X-Google-Smtp-Source: AGHT+IGZ97KiCuSx2Zz5czL9EQLY26VKrwzyrpaH/+ls+eah1/8qinFt7a/eq+sOWXitaCCevB4xww==
X-Received: by 2002:a05:6e02:108:b0:366:b0bd:3a1a with SMTP id t8-20020a056e02010800b00366b0bd3a1amr11111338ilm.1.1712015024165;
        Mon, 01 Apr 2024 16:43:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x6-20020a92dc46000000b003686160b165sm2966117ilq.75.2024.04.01.16.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 16:43:43 -0700 (PDT)
Message-ID: <1331591c-623f-4c77-9c3e-98c0c7981ae0@linuxfoundation.org>
Date: Mon, 1 Apr 2024 17:43:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 09:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.84-rc1.gz
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

