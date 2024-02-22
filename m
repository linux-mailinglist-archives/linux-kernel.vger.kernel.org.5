Return-Path: <linux-kernel+bounces-76443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA66585F76D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF102827AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F0481A8;
	Thu, 22 Feb 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0f50Yjd"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9645C08
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602591; cv=none; b=cT9vjSjYPo2vnXi38c8I7NrI3ah/kgzKS83BjHcOdH/OzXGlR3vi+E3NZWah3GO2nG8bwANjdV3OadbZ6IJGx+l8u9f2rMWXBqVbvpoSfM6/NUg4ertP2B08z65cRpDTJBDiFWQQBIeUvn/eSNf59tixl6mtyNsm1aNLDmIBd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602591; c=relaxed/simple;
	bh=rwjqj3F5DEjDpzt7Wk5cef+rvi+l02SyQ3twXyL6rZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P39S4rzMFqo32oW7YXKaGHDnh/I/kefK99vg+DKCxjtb2PQvaJjMxGJ7CXPo5Ai0E776vSudfaACEc63AVtBY2dVdfncegcen+Y/2Ks53JoaC6yM69u64TmmRvq/OLcnLmwC9T1v0y80nbv+/GsmBRN5E/YxXKIVbLEtVWHSzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0f50Yjd; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7ce55932330so3123450241.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708602573; x=1709207373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXZywZ9bYzEPOeiOcQKWFDupoTVmbm/QeWT4cQk2MjY=;
        b=X0f50Yjd07xChxgzH9HRmoWpya1qyoQ8+fLn22QFTrnXOK4Es+7jfrPOexmoUMyPvW
         UldlRHNFFxsmcZJZgO8+LqSHievX/yLrHpNOSphNsvv3Ckb+X9vqM18FERQw7fwthKRR
         l5Brz9VoJhxsCobbzEpIj1gv5eV1+hvxMl0wN/VjrTN1R9hSwZiAqtXbHASFL5AF+rhW
         vhtfOngM8Pbfg8OUmwVrow3vTziJ7VCxnV2E0ce5SNHRwybEjcUP4aX2sMfvyLUEcW1k
         pTA5xekTEezDE6jr5DhuPYAiSdHLV8SVJUFnr1CHj+dhUwBClf2aeV8Fss7YlL7k/RL+
         IH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602573; x=1709207373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXZywZ9bYzEPOeiOcQKWFDupoTVmbm/QeWT4cQk2MjY=;
        b=mmYHrjuwFgtLiFL225Tc1ayRZe9eZqlOqAkaJfxGH1UzGNbHdop9K9uUUfKpsaq0sy
         rS3ioKdjrQEslZWYcY8n1gL9HsJlqvZV69i4LIXrFX0V4RjBVJGlKi9E+Ilt7S1efU/0
         7bVX5jVdYSRiD2z8k0IS+WlYHyx44Sr/N/iw2/+T3JRHHoDRGT36L1aI6+LgmSYFS5mv
         gVRTSKLKDByLzsVkI53SHJjKaL+D3gTrZGXDnL1TpzyghjwYi3dDJnQzOEPnvu9yMMZa
         jBYeldIUT6M6KpVkIY1C+4MgwiFz0RjHfu4vf7L48ZyVrwfF2JYNWKlRezRCDZO0pimF
         z6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUWpEgpa3aOR+2kdArQQBNsftJN23ICVXLoXk2Ztwml+PCjd7ZlS/SU+VcIbIQ7pdqwHZnxZgAki/8Jiwf/puLdxKX5Wl0HmYcjQcFu
X-Gm-Message-State: AOJu0YxlUuP4WkNK6soC8k4Yv/3fLcZImFVWw2OSyPOSkloSdwC5GVtD
	gBqKJPBrmT1KQPIOj3pqES601dZPwnxg1CGJOuISSff2Oa95jf6gwgc4tdS0gPGwNoLpfk1xF0F
	vuVs2V9I/H9mBvxmdz3XI36BKfX7S8vkXoBynfQ==
X-Google-Smtp-Source: AGHT+IGta4b8AQTI82Vy3bZ+I0eDJVomcLJAjLz5u0WRGMb36VgNJK8SiwxwZrfdsHu4htq+oh8pRtOm5apzgwmgUh4=
X-Received: by 2002:a05:6102:2334:b0:46d:3208:aec9 with SMTP id
 b20-20020a056102233400b0046d3208aec9mr14251737vsa.8.1708602572983; Thu, 22
 Feb 2024 03:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221130007.738356493@linuxfoundation.org>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 17:19:21 +0530
Message-ID: <CA+G9fYtNZrQYiZaR2CChtA868kwnrz4byqnvt7g-0hW_LXyWfQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Beyond <Wang.Beyond@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 18:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

The i386 allmodconfig builds failed on stable-rc 5.15, 5.10 and 5.4.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:133:
modules-only.symvers] Error 1

Steps to reproduce:
 tuxmake --runtime podman --target-arch i386 --toolchain gcc-12
--kconfig allmodconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

