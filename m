Return-Path: <linux-kernel+bounces-75745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454C85EE54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716DE1F23636
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86610111B2;
	Thu, 22 Feb 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAlr6kgP"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052210A1D;
	Thu, 22 Feb 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563361; cv=none; b=Vf493p3gHOmqboTOody02o//Ex3ODktB9OeAQj7U3dT1cm29jtCkMzXIrpq834xPakxim1UjKTjaC0hI85l2vAldAvR56d3hyMp74HPfQ8nNxyVyF3BeGaGaX4KzIr6GRlfOHiy3BB6szmeVodzhGnS+xkFqOAHUcZ+sniLGQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563361; c=relaxed/simple;
	bh=nOygF+tulfpl8khV6zhERbuIv8CNCUxTUNFrXzNgoOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xuidz6pxLfDzAq4bx63k0WC9vi7PHoelctSnm1VisbpmayGbUhD9/zvlmEpY/qkDH5u5uS2UlxccV0wpkjNWtjx7L7ReA2Ny3Bi99u6aFIpe0igszD+VDrILw5OPOS/P+N6Czz56R+YsgSvysBU7qtVaKdAE0Nrr7UhtYyKpNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAlr6kgP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so1922744a91.2;
        Wed, 21 Feb 2024 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708563359; x=1709168159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WL3spPkKq/SZseTrtmjIOQn2serUsFfggo7i5+exlHs=;
        b=DAlr6kgPYRzbP0KD/sKxXET8qTMRHyrwbM6hohQf+WOe3DJgv5RpNx62CDpPKinZmd
         pX1I0OA7aciyNC/mEKqBzilEu/Y+g3dYcdxtKeVQ5l778CsykkbCucq7x8HSFZS0rGlY
         /43Wjau3rzDYcdcnLCmpG+SGwIBAc+gXFC4Mdbt4apJCNoq6/99dAYPnJb4K7U0vQhqq
         LnB2dI8Y2PCOIP7RO9yLisifNv/iuaPqdskaVrAypV6PiOFiMNsEVfNFAPLH6Y9bCE5A
         USUI0idd9ITpWvr6EWAhKMiskLVjtszJ799DYkFnRDzcXitOXUewo5M3MTVcUd1n0bbU
         bWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563359; x=1709168159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL3spPkKq/SZseTrtmjIOQn2serUsFfggo7i5+exlHs=;
        b=NIM9c5dhYS7uutKzaPRRdtGgsdZiETMIFeoaRYqKc04esUTYMJ0m2bn2cuWy9roOrL
         CrYPIixuFLvactyoTOJfmO/VXmYhptzfOc19A3f6Azm7uwOvdvGHyv1ib2hvJiL8OWFG
         GidZHOLTvnYk6Xc5/ih7qawGcGi3y0vjA/E3VDAeAOPrwey6Hllm1PJ8Vrst/FAaUHrH
         IVc7qnapZMME9ofjH8Avulc11VmGjRXRXQFaLGFzmdXwvCXaTdrebGPkwLQA+dnOpexh
         t50Ky/hYN+XRxyyJNkt92MLkmkld4jbNG+PYEsl4i4a8kcGxzjIsJzJnYBc+CaTsxRpo
         ykHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhCvFr8ABJFv+8Q3FdDmbn8Or3XIXf11Hjf4TsgdQo9PV/enVLArqog5roIP5eG97mTfVQIULobAKVUs0l7NL7E1dvJk/B9aWjfdhuTa3eAs1LrfjjtJ8+Rerm/TkcIIas+Edx
X-Gm-Message-State: AOJu0Yx7+1tiDYPO2CIHud/D0C0Trds7nY5hQXMJ8Mi5P+0KaBCp9l6r
	vi1L597WTqXFzfLJHIZh73a4nsoAy4soyWfHA7VglTm21UeF0q1Z
X-Google-Smtp-Source: AGHT+IHGHvOImUTZQjA9JE22XMBCiWU5J8YqOmsuW6Tu+Y//TfZ5zD/Q6DNg/mCdyODiXiP/9aQMXw==
X-Received: by 2002:a17:90a:bb03:b0:298:a28a:e58c with SMTP id u3-20020a17090abb0300b00298a28ae58cmr16493010pjr.9.1708563359051;
        Wed, 21 Feb 2024 16:55:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l14-20020a17090aaa8e00b002997f192d4esm1629662pjq.1.2024.02.21.16.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:55:58 -0800 (PST)
Message-ID: <24a0eb8e-9007-4368-9ce7-7ef11c8e07b1@gmail.com>
Date: Wed, 21 Feb 2024 16:55:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240221125951.434262489@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 05:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc2.gz
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


