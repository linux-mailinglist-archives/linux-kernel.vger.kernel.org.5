Return-Path: <linux-kernel+bounces-66187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE40855847
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7B61C22801
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430BA50;
	Thu, 15 Feb 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsEhPsms"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62538B;
	Thu, 15 Feb 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707956533; cv=none; b=CZ3Z0wsEIZik6+QWNwAZZeByWeNJ8GeHYgX+Xt6FZ9CKrCvaevWAG5PWUfkG24lczBN69SrtEm7NXMzqczVHKZUeFGSpAly7V+i60tpXfRe8aRAFzzy/j60+KGECTYN2iMHvcggPLYD8Ys2sbokDE5y2Tleu2CvDIgH5KVBmu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707956533; c=relaxed/simple;
	bh=/IVDv8ZDRpkxRX1EmzLDaIDR5L1QLIzQ+L3RtGoXYck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR5n4iYfPnOPnjU5Y7RRn7WHF+MssxE3qg/Rj3Fsc85vs3QDkjcXncHFeiiaduVooLHC0jR6/aza99Jd/5vVywgr4Z0+Nk0Lq5vS1ilwOgfNh8WnTrepmp6pKiHclSdP/yQYRBXw2kh6Yp+RF2eQQLfnyiRyVwS4qVIsCMB6nX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsEhPsms; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6861538916cso2223606d6.3;
        Wed, 14 Feb 2024 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707956531; x=1708561331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGv9ICseLvTa6Gc2Hnpxim8An7iZ8HvjgY4ZwW+CUnQ=;
        b=RsEhPsmsf8THZgzixtSAlL+8ITshdMrSkt0AdzaXOuk7f5bt1ftPaNnLUbttVVP8Xu
         MOz3/zXu9RqcevPE99Vi4fXnK291nD1ie3hvfehB5PXJ4N1sDf5a+KFHwaVTfy9ZARLQ
         Djr4oommrBvC2JVhulRw7W1t2AtbHvdVdHV+xs8QryQtwff/+WkgnLrvm3ns/ldEIMgr
         xo/AINRl0/uN7x3C0VV1RmJ5X/n6r9aE6zNW4CWrd6BEDUS8ZarGp0uXpRgCkD8GWIR5
         JwojyIiVFkxryGBq7a9jnB5SxYJ4hOWUVVZD4dj8K93uUtIXyNVkVAMNq6Gm5NHjWqe4
         O7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707956531; x=1708561331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGv9ICseLvTa6Gc2Hnpxim8An7iZ8HvjgY4ZwW+CUnQ=;
        b=PpcwKs5053+lK8vjo7rTDryy9R5Vn0omMAFt2+kL2yuCbMZd8x1+OCmoBm1lXTIvXa
         y0tejHPndvwK+UFEGVLmUiOojKFSJvl51l+xsrlEjIIILBNVM9ljowTjQaxI+UnTMjmB
         kmnm/516yZzIQBzJVOgh6UU+tVYmUmxAMtXdQ/dDTPHmmGDeFv3+kPOc7fm2Lb65Y2B7
         COehKaVqDdyras2ZQqv/uBo4MYIwwTVRBIYqVn+wNVcnVUh+D67H9MOCLIqH8lj6F1Vu
         q1JdquAPwtqCju8Sa9ZZNWMM9zMs5RkSKiblDKvY+BtOsYMojVgSBZpvm319iuVtqtVj
         rqHg==
X-Forwarded-Encrypted: i=1; AJvYcCW1VEu9KP/RnnM8OO5tvRm3YwEM4bMmNdIgkzWbxgSsxpsyF7bSlabZYZVH56p6jNjfpF12YsbTgfPkZtP/pZk1xojhXiwHo9lA+anLakQFh+ub8HqVUu+UN9NvHc6Tz9oeIZI1
X-Gm-Message-State: AOJu0YzzUe552fEZIbNYSTTP14aGm02z3pvSrYYSrJE8yaCF2ZS04q1x
	9x08aY/v0uMagt3vQI1loRjHXizNIzj+3ZPRF2l+GCY/tKxRDe1A
X-Google-Smtp-Source: AGHT+IG6+oriiJxs9z+4QKuoEdbN+sEQ52JvCo5Zun0AX3fk9znaasW13XCxBp5KrK7UAOGxrxSt6A==
X-Received: by 2002:a05:6214:c4b:b0:68c:7395:1bf with SMTP id r11-20020a0562140c4b00b0068c739501bfmr346565qvj.8.1707956531258;
        Wed, 14 Feb 2024 16:22:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pa6-20020a056214480600b0068ca30a2a23sm94016qvb.133.2024.02.14.16.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 16:22:10 -0800 (PST)
Message-ID: <38b5f0cf-8d4c-4c2d-adb9-781b8d39e59f@gmail.com>
Date: Wed, 14 Feb 2024 16:22:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240214142244.209814342@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240214142244.209814342@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 06:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Feb 2024 14:22:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


