Return-Path: <linux-kernel+bounces-165914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAC48B9350
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FD31F2339C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D417997;
	Thu,  2 May 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SSSnOVcB"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB917543
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615864; cv=none; b=iu/avwI8MRV7jxU8kViLg7p+fpulltaCUIYT4jk4PEwdGved5uz9soJtsc9WlvLFWhol+/T541xoybPINyeYPCnd9LK/zj9Yg85+I3gbIQ1GhL6oGyI6+6UBI6Lf2cbqpGyPUpH7KSWAxm/fmXLetKhcz9pxxZ/JupjNRC6/ToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615864; c=relaxed/simple;
	bh=iRqFjcp2JS4wJru6lJM4cL35QVmiTQNsqCV46bY/XCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZZ5YXN5HL6oSaRNwso89ADqEga914otgmWz167QBRjGAjOJTlcrctvgzOogKEs8pIteWGyduMqMrkLJeHu1JYMdCs+S9fVoQIxn8BVI7WfQp8M2RDw99TTLZOuLRDY86dxowN2RHjckaa6tbx5FFjHQoG3ACglrfWyRKBmveUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SSSnOVcB; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7dec804bd19so18371239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714615862; x=1715220662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ux36Du+V3TKAlinHlEmK9kfOgnPDluyCdGYd1Ayjxyk=;
        b=SSSnOVcBQmU6t2ygOIroqfD94FLOK1j1wKpWbRTOMFao7q7ufeA9Z6t6TiYO4++bro
         QQiJ0+adkiN3s1XYgEGVfo+Q1fM7D++KlzuSoN4GVs6pIpSfKK6hVCumNQUXZ77osG8k
         KX0Ee1bX6twiyor8aMcoKmcrC3urP9KN9fPsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714615862; x=1715220662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux36Du+V3TKAlinHlEmK9kfOgnPDluyCdGYd1Ayjxyk=;
        b=EdDFMUW53j6NcHC1W6pzHdSEbBspaL09Ryis3cNlScnuL2Th6JCATVf4GJpMpSlI4A
         fp/qUSOPcgK7jd4vMQ3ZVbhHHUv8QZ+wPBRYrp+8PoPy40bDjadyBj9eYlBHK65s2Tw6
         0/b70cTP6GRWZh3VDLb2bqp2QXSkLE6zS4EK79+CMVRqOjQbrZ26/a0X99lus9GgLj1Z
         9VvVpFGd29z+SzpO7D8PZYD1AJCYRlo5CfrzghZO+tcUlVXhpFTkF7dUQ+DsUfhLqjbU
         mldqzmpMuDpcdQ/yVTUMnUinKqjTfxuTGKLeEypSARNnperR3RGRwcG2Y61Bn1YVb6vy
         GgfA==
X-Forwarded-Encrypted: i=1; AJvYcCUNMiiz50V5KjeKHXZFeBQpqT7d3KRsLx+Q/mccENRx4XaRq4s+gp5l36XNIi5hM8q7nQlCYyDgFmKi7n9mjHRtKtYXGNzPlHr2tF9Q
X-Gm-Message-State: AOJu0YzAN8NtfNcJ3Xs2baa0yPafOAIYB6jCeHhZQm7CTPrcGE9tXpcH
	4aWyU3mcGnbRto7iyxN4sIDi5CllOdtLyb+qYJDS6LKClJdMT9194nolbqKI7wQ=
X-Google-Smtp-Source: AGHT+IFk7Iv7uzyxXIfPDJ7VEbUGp3sjzrH395PU9dimMM9OWz98WD5XY4sa+Y76BZDYtMhmCFUdQg==
X-Received: by 2002:a05:6e02:1fe5:b0:36c:5572:f69d with SMTP id dt5-20020a056e021fe500b0036c5572f69dmr5487322ilb.1.1714615862413;
        Wed, 01 May 2024 19:11:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id s12-20020a056e02216c00b0036c5d1d1cf3sm923789ilv.87.2024.05.01.19.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 19:11:01 -0700 (PDT)
Message-ID: <fc4fff68-3012-4c90-beea-3d28dd1d7d61@linuxfoundation.org>
Date: Wed, 1 May 2024 20:11:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.9-rc1.gz
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

