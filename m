Return-Path: <linux-kernel+bounces-30661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DEC8322B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7C5287BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D01109;
	Fri, 19 Jan 2024 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AliS7Sjk"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3DECF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625067; cv=none; b=rcfu3n/5L9C7zhD80fnS4v11w2A9rkAB4Xw55UwANGT7jn2Rsu9VFV5nj2jtDz/a7qScgekQ6NFQgeNzsR0Pq/mV7ixXO3UQ9EzzGdCsh/cN9ycOPiUCG9zEqp+WGVHx7Uupr96uIGGjAg1QiRcn/F+J7XCPrfFl+qeBynh0LTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625067; c=relaxed/simple;
	bh=NhNSIFSj5aUXE+QTTjNv47GccG4WWL8n1fqMzGxB0Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHDWGl2Mkc+g3t1LHDCkeK/B6MQ8plWgd66lCmXAQfUMgE6JSpqQtZ1LBXA/szjE45AkFYuR5sL5Yv1kXtnJGDMqIPD0WaiI2ZlzsB4sU5K0nWpVlgjtM8/NNCE6sl3ott5BJ9Fqw1HiXJTRmZrovWk3zixhcH6Vjs/N4E+s4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AliS7Sjk; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so3932539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705625065; x=1706229865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4QJjs3CBTSn4kYRm7kePCBqPYpjZWflZ8aVDGne+Lc=;
        b=AliS7SjkhAj8Gzfj/m7N65r3edfRv239QyPUEbchMNuI/6wb8Zng4y147YJ9Sd3xt7
         QZv16GwYeKFTd8SNpIyCg0vJQK2hYrvAMz8FIwndFLHCqCicFv0zKo5m/F4+ribnxtIx
         eAHyYtJSw0Gk73DSnYmdn7rIF2RTfA0PxL7L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625065; x=1706229865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4QJjs3CBTSn4kYRm7kePCBqPYpjZWflZ8aVDGne+Lc=;
        b=PRtbD1iZDaGbRGJwlYqealRViTXJff7UC1VE62obUNcJdSRyqFJoC511AM/m38ubRZ
         k951CR7DrJhVxSM6L0KabLgar8ztgFLiNWndR9b4x3P/rpejNgxfFEVlwgKfXH3yIAdi
         TYL7S+30/TOBBpl6D8EzIg8eJjpZlZCiF3CUV35II27LZsf2Gw61dTsMODc2dALjW2wY
         5A5ysPL2SGAGcoFWOhWzFk5z8o4WjjmD82ZH6W5U8qNw6e8uW6Yc7CTVOfeELleyK3s0
         da0OYI1050RBtlBYOwkglT+dGBkRl5qA5GtvS+t0v3WG8LlFc44y7x7a9iwiwtpILJeL
         WXlQ==
X-Gm-Message-State: AOJu0YwAnJb30ajSHk9iZkgQeSaNliAVAvsApAEvShqMSpYlfQHjTw6F
	lUZM5AOSUazIaNCjtp4Ku1cV/jWNnkYD/KjTNmb2OI0DHuZc5QWTSrcfrcNhXkw=
X-Google-Smtp-Source: AGHT+IEzKBDhU5ko5vWu4xZJmpYcfFyuo9g09ySkVHfAtQDtjkz4Xi73BJZ5kZmOang3z1mK3rWCLA==
X-Received: by 2002:a05:6602:255b:b0:7be:e080:6869 with SMTP id cg27-20020a056602255b00b007bee0806869mr1123197iob.1.1705625065102;
        Thu, 18 Jan 2024 16:44:25 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l10-20020a056638144a00b0046d18e358b3sm1323950jad.63.2024.01.18.16.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:44:24 -0800 (PST)
Message-ID: <1c27da34-1134-42ae-b6c6-925e6e94e64f@linuxfoundation.org>
Date: Thu, 18 Jan 2024 17:44:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 03:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
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

