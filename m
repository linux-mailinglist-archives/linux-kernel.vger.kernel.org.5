Return-Path: <linux-kernel+bounces-85379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A086B52A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A51C22AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919F200D9;
	Wed, 28 Feb 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X3f9VYqa"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11638200C4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138368; cv=none; b=DmDvLDV7wjv7orRdgGzTryRWzs+aWckwuR+x/A22rD++oUeBxk9SFc/V0j4TulaCC63zNvqJnv8iN7YAOhdTlPIRXmDam43qTGvQ7X6Astu3/wGw2WLT/282gBxMvbrmAM5mpKFZCCy6N4ep/m8dY0Akj/3lbKJJD7s8n1gVrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138368; c=relaxed/simple;
	bh=ZZYZjjBoPY25nB94qJ/iXB7sLKjUp5eutwi9DVAvdO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG02qTQYn19oFAga1/jFLUJirBRboZQwnQN1JdkxgfAi5Y5eg/AGgmTMbjvbLCX4dr08R7uSMkwVJdxBc6ifNg1XQWYR3UyndkqSTT22obgY6HM2LU9Z5VgmSUviqbR8cF+XIgaYnsMlUeOO/BWMh2Rd3HfgM2zTKzFkUMz6olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X3f9VYqa; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-365b5050622so1385435ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709138364; x=1709743164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywQ2N+51LDfOyR1ODhnc+p+KZScDU+E/nSoRgEWr78U=;
        b=X3f9VYqayxx/dZocQVhTvf7sS4HNw4BTPdUavVD8Qzzs+nbdO1F3a5VXSm43UwCfiV
         DdAZWgK23/GD7VBrzEv2vgleltHCtuXYLChFRfn16g8qxwnYlNe8ImwUAYc6v8S1EMJ9
         A1xKdOfE/akJwUlmfpwBUD9xppTlDFi/yqSyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138364; x=1709743164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywQ2N+51LDfOyR1ODhnc+p+KZScDU+E/nSoRgEWr78U=;
        b=KzM7cFbKWhfbjO/MPnXt9dc8eSgPPDjRXuzO+s2NIGSleyfeqZwMf9195kNqWYbl/Q
         uCOiP6M89sys13lpqZjIKeeDxTdTU+ivdcuL4WVeeipzi9vxWrJQyr+Eob/1p08fMwHa
         Wr6xz92r5UIrCcCp/HEl2L5BnKmPUSkDvTRKEHu+F92N9O93obbietFSUs9kOSeCEJGx
         swh7hmc5wl0n+qHGEJQBgRxZ9JHLVYByKMJAzCwgD3XaihjBnFX0F63+HQlKSpFXDBvI
         09zUTFJxqMlnA3Qjb2D4hD4tdlhsEDGdbhXVeapTcdKME0ed8Uboji+Hd7b0EQ1a7EOO
         JExw==
X-Forwarded-Encrypted: i=1; AJvYcCVCk8TO/NzneuqXS7aeRqvLLk+Detwwkg+qhcdg7GeXrecCvFeeVnimljk4o9vVqCn/z+1bvUu0Jvvrsm9U83nV/iH2YOYZ10Ckmd3b
X-Gm-Message-State: AOJu0YxFOV0ozVbi25jZgBCzUByvaBPp2erbeaKw63MeYg5V6bUeuG0N
	pJVZQX3MmjexeSWgt4PbGHp0+j1D+AcYkejQJq/dDyKOq+v153xMSJeE93hD2Qg=
X-Google-Smtp-Source: AGHT+IGsF9/a+7Ca+mGlICoWd8c8ICEa5PoYE/zWk1d7/NEcuLYBJkjLS0sP29zqANvE8DiQhmIt0w==
X-Received: by 2002:a05:6e02:1d86:b0:363:b545:3a97 with SMTP id h6-20020a056e021d8600b00363b5453a97mr12989996ila.0.1709138363186;
        Wed, 28 Feb 2024 08:39:23 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056e02241100b003642400c96bsm2891272ilb.63.2024.02.28.08.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:39:22 -0800 (PST)
Message-ID: <1d657e86-c1f1-440f-99a0-5705a29dc2a3@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
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


