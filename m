Return-Path: <linux-kernel+bounces-75675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540685ED40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE50282BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029212D76D;
	Wed, 21 Feb 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hf+myGHN"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275812D76C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558951; cv=none; b=enPUDpqTA0Mjf1aeuE6Z2PuRkgTppn4fS5HrOIu4Ssi6ty14X0A0A62gbBRtphMbqg1L5jk5cWbHL2xmG1EosMMY7/kHEuM6zIGaSjscSAV0vWi/nkV/P7I4fypoxV3IaVRaYZbHVKg5O+G2tZ1q7ZNReBRljS+9Ia0fyQ0YHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558951; c=relaxed/simple;
	bh=DRjQ2RMrvvFcgAl8DJc22OUJZXfHIMDxQKsf1bZcINU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdHOVaE2IpisDEi2+Rh0yQAteM1hfEIT/HU3Lfth6nBwevsrZyVOOp78Bls4skQXfgooPgOwZVTyU7DU3L5h5fxwYmC6+NCv1fxyOX/0EV7nLmN3qpJ2sQi2JaUfVxGzv9WdISqpbxafVpaijwG/VbguoTBxypqbJkkmMf7ZJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hf+myGHN; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-365306a6455so4225915ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708558949; x=1709163749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TToKF+RcIDqTyQ1ZlzqOBzZqj3ctKqshlDQrKFkCjgo=;
        b=hf+myGHN4xHbXOFVsFk1ShwPr9n5sQBvba86zxNKK7mukbSP+Or785Om5N9Fpnp2Oo
         I/lnDQVVRuvKGMVutzDRNxE85Q2TQwlz6CIsBllgzgIkxbJ+ghM5RzVGuyuHPZuk0Iba
         Swc0HHIAirBdzY/LiLYh9IGP2xQLtskvfKmQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558949; x=1709163749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TToKF+RcIDqTyQ1ZlzqOBzZqj3ctKqshlDQrKFkCjgo=;
        b=TGR1OZrsWeo1owxaHxYrljYTAOYjvf/HU8JkGJjusEIxc8azo6R6Z85D1ktmOblyjv
         LAF6uWZ/6L1xO6YrD4Kicf5yGBjfOwQFCYO076xNQU3Iku9F/dd9+/FPlVWZvUPVrtkq
         M9GC97/DDs3/yG1DAy2lfxxrmF2EMmPGn+Mu1a2tBnJD7aQqvBApcoVwf7ZGnoT4eCGO
         Hb2GCBkayLAePwd8ZBMgfQbCJRg2bIwGNB8/Ep/6IuvU87mCyxA85VIsDmc9X6goxtXF
         srUKMzlbAAE+rUiCkDrTB0+kb27fRYNVU9XNtW4/9aJCsOleKzTXwr59BsxMgJT4vHjH
         +UzA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4/hXP2VivFPnrMvdBuwggFlrYCBDmhF4ZsiheoGlxx4lswa5Kex+OPTOw96ZvO46/fdI9mV8TmbJHyS3y4z0FtH5RuohLetNRcOh
X-Gm-Message-State: AOJu0Yx62nODJihENgb59K4YHD1KEqLuNbzu9SJgcUdgGKsisHQFUBRV
	E6MIsdOK0eCbNrTZMoZ4eA6X6gDfL2A71JEsdtqW9cdeNjwFDGafJ208x4goi1A=
X-Google-Smtp-Source: AGHT+IHS5EsQmsWHtFblC+GYNPn2/aXeJ+RVQCDeZ9fkYYv60uAvnFKF7Vu3HzcvspHc3fuwT+z7QA==
X-Received: by 2002:a05:6e02:170e:b0:363:c82e:57d9 with SMTP id u14-20020a056e02170e00b00363c82e57d9mr16758159ill.3.1708558949053;
        Wed, 21 Feb 2024 15:42:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y11-20020a02904b000000b00473cdc58012sm2932344jaf.134.2024.02.21.15.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:42:28 -0800 (PST)
Message-ID: <988f0326-5895-4491-af82-c6619b048816@linuxfoundation.org>
Date: Wed, 21 Feb 2024 16:42:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/202] 4.19.307-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 06:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.307 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.307-rc1.gz
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

