Return-Path: <linux-kernel+bounces-75679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44185ED52
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25841F23F80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C512DD81;
	Wed, 21 Feb 2024 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRmnhHTv"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A912B179
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559037; cv=none; b=MLlGHvUOt9+CyHa8sG4aQY+M9s7BVI5eniox5cpYbEn5STLV26hMDvMzcHt7P69ESIx92G4qhLcrDVwdlslAnrJUtHrpb+g9LGk7vnCxyV91H1w+WSCUwOUpWimnv8yV/ZEtLm9coMw1ieUd7RLlGOF2kz99GUC5fiMqNQaPDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559037; c=relaxed/simple;
	bh=izhq5kbtt0E2GDvdNjtl4p/OrqRO7ylffD7YEBfaC94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjEFTyyIfqZPcOGnGYIp6OWvhft8VbnvKMtKdUzi+YWKADhxPMG3QtoZMJUxC9VultYxQEXTajFKE9GgJfam1gwiFiifXKDaFgXLPrStNmZPSm35F6hH8v4x/nR1MCg558DMIeYhhtTsV+OkYj79IsgKrJ901RQzK/5cZ3w/g9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRmnhHTv; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso120538739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708559034; x=1709163834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUJnSIPTMCvPPD3P+M+IMvy1Y/adsahfRadjAt5ZUzQ=;
        b=MRmnhHTvZXoyDMbwyLjqEMHp1ogN7wyoSsAFyUqTjQ8gxfvfD6EXecV7RqHouQ98j1
         +3o0oXYJ4V9R+mWlfi9C3m7kFGWBRdBGwrz0WqSaTiY0O8umSQHTBTVsaNmtWjxWzY60
         qqZ44tMs9biEilrZqUuLh4tXXjPJzv5ceB3xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559034; x=1709163834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUJnSIPTMCvPPD3P+M+IMvy1Y/adsahfRadjAt5ZUzQ=;
        b=lyqXAIQJTiKymgAXGDclx5tnJ/ydbC7x7NFkZl+upZrGp4j70evGoqJgQmf0qoh94w
         cj6I7UqLlZdSj82L3HJ1nNFq9VvAdeNJv/bfp7Wopmi4/1I+ca9j4y6nM218Z59G2a+0
         mjuhDQTAeotqEEsj/apt16KsJbgmeEt8P+wb9OHRHdcUCMv5FChPKEt4oVcdmHmcQd1c
         HUWyLi2iIPIYLnJ+ludg2+D8VnDAzXh6lA2v+JOghp6j80dW3NjES7YC8v/Gazt/juDF
         W7sYeilPctvT9j9IwPIfbNgWOgfYYBsy8Qq+Xx4Tc1+rbar8Bfg+iWJ5Zt8WLnutRR3o
         9BCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWPiTOqFffyDJJzMEGRkwTzVAbsHmrjfyPUEA7zPvo18VWzHKcy3O+G/kEPyAZe7x/B/qeKuUT9oHYK4LQlLKnZsXH4NF+uChZ1x7l
X-Gm-Message-State: AOJu0YwwcmajKb1HsOUHWujV8i0QIoEm1wMtzsO5pKGBMj7G1pKiujOV
	xsqd5UAnbHKWykeNQ4qGX2dQp/+tRUfylu3VUrf5dRgJZyQOW4o0ocpyFtmqlOY=
X-Google-Smtp-Source: AGHT+IEtUrvA3B1IBymiy547pK5kT58ah7a9oEbpT3JrqGJ0gP1CK6rxJMySRIt2X1VUIz9rI7Pq1A==
X-Received: by 2002:a05:6e02:20e1:b0:365:1967:e665 with SMTP id q1-20020a056e0220e100b003651967e665mr12362408ilv.2.1708559034103;
        Wed, 21 Feb 2024 15:43:54 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y11-20020a02904b000000b00473cdc58012sm2932344jaf.134.2024.02.21.15.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:43:53 -0800 (PST)
Message-ID: <928af94d-20dd-4c44-b73d-e48833413056@linuxfoundation.org>
Date: Wed, 21 Feb 2024 16:43:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

