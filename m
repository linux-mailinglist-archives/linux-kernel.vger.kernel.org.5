Return-Path: <linux-kernel+bounces-127186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4998947D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F821C218CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D0C58100;
	Mon,  1 Apr 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DhoMaQJj"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AF57319
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014818; cv=none; b=lZUQNL8TNpDCXf4eHflKNzasIiEN3rgM2p+pw1EueJTsezs13BR7TKuQDB3xsBj+6FVNNSAZ+nlhQqv4PMk61B3D7DRoIEBSEkJBmOfv8PG0dp3jzOT0fUgmzQV948ujfvVA1MPfYGr1AXs8d1hkWtIzhqgIrp9foCix/Ft2MOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014818; c=relaxed/simple;
	bh=ZANE8iSaaHTuiCj1Edk/R46hIcM40ALkebRemnzrjm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF1LY7uGsxUq5Ny4oAZRjuXVIr1M4vpe7eivEUjnYk6jf57z2ikE8iFZ4nkYQ5pwcL0PlKjkm+LcTMfAGwdG5Ni62AANjPZBTRSKVhtOjsyElnoTB8QW1/wMp3QWM4zB/FCQEUfMNbo7ApJwMxA4xLHE8Jtbo+xeRUDZNK7N6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DhoMaQJj; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a47680a806so1340339eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712014814; x=1712619614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jl/3ugUzIx8xqjqXwcOaRMc2nOK0CyZ8ADAA4iIyIY=;
        b=DhoMaQJj+hcico3ZhV7sEEm0QzZkyhPwfixbDOR7oIA8wLURRC9T+/hVMawZsjuiNV
         7Zewup6k4NJzG5Yb/HoxISjFziJ7PnlqhIFALsRcmyZGmUCPDoh0iDdrW2YoerZD2hKz
         /cEnj5zWxT0Bs3oDh4K/P1PL/xw6h9COYXLA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014814; x=1712619614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jl/3ugUzIx8xqjqXwcOaRMc2nOK0CyZ8ADAA4iIyIY=;
        b=P+8VE4zWrsG4k53Ww5/ivcWE14BU8SfmHWd9cgqs5IpKrUwAMtvicyga9r8GqC3gz1
         1cwQH/cxzwDfefLEnZlm//iIPKixw860u7iU5+/Y+RngrQ7RaL7nYtsdP49crvHg4R7W
         XT0X3VjdeWZTjgtyyLqGvYUBqt6cYO90HWnNdiAb7UTXv+gipyJTBzVifk0G3+domDgl
         MIT8PsFKsREq6Q5+MhrTbphbNKiaaCpD+GY/2Rp6KZIDUGXpCz9JHZp6u6FrojsNR/Xx
         c/TV9W/OpnTT3zgEoBW7OCdVUPlfFMjHcTk9QQGBS7NknuekXAPrA0lqbGhVtiThTrnb
         +xrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ShENYbq9z6KyzJlacoe/sp/Y3/TxNXh8GLO5d/DpQ8cpsuzWG10DM6nt86y1WL3YGxeO67R8XLCWYLGzAw4omUjA1+VYmgd8Zkhv
X-Gm-Message-State: AOJu0YygRF9uGBH/oCQ/XWfY/qaKlbt6uqvnlyetR6Y9ki89nfwYHxNM
	BKtL++u9akx5dQtUG7gA1/DwOhleO15xpYdGrf21ADm+Y6h30UjS6J6QMWBBh7SehKmBKedvbQK
	s
X-Google-Smtp-Source: AGHT+IGnhHZrR/gWiM2r8q0KacGseXDqszQ4vZbPvMDgaZ3DeIBfjuJgHJB4VqqNj0DRkKeo4sY/fg==
X-Received: by 2002:a05:6830:1659:b0:6e8:8d89:ed55 with SMTP id h25-20020a056830165900b006e88d89ed55mr7343253otr.2.1712014814667;
        Mon, 01 Apr 2024 16:40:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g8-20020a056830308800b006e67fcd0ff1sm2096704ots.10.2024.04.01.16.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 16:40:14 -0700 (PDT)
Message-ID: <bf6598de-545d-43b0-808f-aca2d5ce0e08@linuxfoundation.org>
Date: Mon, 1 Apr 2024 17:40:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 09:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

