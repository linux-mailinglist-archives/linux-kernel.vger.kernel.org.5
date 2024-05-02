Return-Path: <linux-kernel+bounces-165933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A568B9393
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191A71F20F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8B18E06;
	Thu,  2 May 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJM0hy9F"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67718054
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619123; cv=none; b=hOpsK6PIIuC62WAtOe6hSBZEtXoHXN+en/SglAOdn6uKFEX5+n6nMHtepEVkeAUe+sswOfhcLdTyhDPKkLhPGjtBwKpSThqdqKRufX2j84JozqhWiVlwSwQzEl0MuuE2RqCXf7Kw77UKOHeqbVl5qfIj+lsb+7vTgG3yVcwcK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619123; c=relaxed/simple;
	bh=nfmYTsnX3AMaJEe/kqKIfKQICnp0SW1m5dBH5gihgn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu60IzkspEgyrRcg2XhM6BD3oxBuEt7qHCllz5xulY6VbP9vOU2CmY7ek+0pJcaYlyVN8JiY1j23fIszpUxr3+1NIerID3ywjw6BfYr5UzYyNP6gi8ix4rn2mg8D7XD+jznuilD+Nnqo9N5QrHZTU4VCPIr8GbeYOMZ9EbU5Jxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJM0hy9F; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7dedd08a6eeso20194639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714619121; x=1715223921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DS+1zXzwuR6V2/P2D9232/ZCNuYtFHvtaRPFbRgTEm8=;
        b=dJM0hy9FjODFbgX/wsR/Jw8VhflV0T22+2n43jv41KhCZ8XPOzKiA2uvNN8u+7k1LR
         E/J2iispKY2RdLpU7p2q0wonEGGKOf3VNRV2kGwhsnz8tE+dyn3zk2DzTmY0Y6pipEFU
         qHOzX/82qkV3o1y9BWNCNescwVN9W/Kg6PqkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619121; x=1715223921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DS+1zXzwuR6V2/P2D9232/ZCNuYtFHvtaRPFbRgTEm8=;
        b=I6hKuRF9HY2tJ4/JDpSG9XQlpwU1ln+sutzMgII8BDJ48xqPq4P6hwdBgW9zZ13epH
         8nM9OTZnQDS894GKhB9mVA2MrvaeIbsM/MNsjCwZunCeO0RRthgSTXwuB40vkXVUZpmi
         1gbmlm4NxEPRw3K3Q2b9OmhGUPWxeMTWoDgdfmSY7sREpjKvwVmT7lBiuWFXQpsx3NlI
         VhGCGGaKErBKplbmt4NhvXMOmIPm7XdpP0/kmAmvFJZw+7QbOGNVckkzU96mqdKk2/pF
         PmtdLRa5uG8/uhNjSdmdEZV0NFET6hg4YALoVbjYZWFIjhJcwkpA7dL/BfZFVtzdTIlY
         caVw==
X-Forwarded-Encrypted: i=1; AJvYcCVpyDCCW/BrBAG0WhQ+cceK4Y5Ajz7BmScd2mekDc9vrFRNOd4bWRXFzA+AQ4g8wETFPDMn18+/lXhUCjArC6BP6zglVkmiEKzb9b7n
X-Gm-Message-State: AOJu0YxVqDVMoNBhUa4ARSNLLsMAgJXOpq4XBUjbjR0H85LmMkax1Cii
	KJpIvFcpc1+lhCIh6LkMsCu59yzG7TVZl+zM76bINPNpRE/dR1FEKdlG3Zea8MI=
X-Google-Smtp-Source: AGHT+IHYtm+/PoEdKYe9tO6lc/PTgVluvUMmOJC2EdNkzkzCTQuyCCgqVcyWjO7QO4uKTaJEj3Phjw==
X-Received: by 2002:a05:6602:6002:b0:7de:f48e:36c3 with SMTP id fr2-20020a056602600200b007def48e36c3mr1740127iob.0.1714619121131;
        Wed, 01 May 2024 20:05:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id im15-20020a0566026d0f00b007dee04738d1sm11732iob.23.2024.05.01.20.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:05:20 -0700 (PDT)
Message-ID: <159ac07f-610c-4f49-acef-c67d981e3a56@linuxfoundation.org>
Date: Wed, 1 May 2024 21:05:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/80] 5.15.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.158 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.158-rc1.gz
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

