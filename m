Return-Path: <linux-kernel+bounces-74999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A985E138
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BC9284982
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1798062A;
	Wed, 21 Feb 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UywHCwMC"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DC280C08
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529564; cv=none; b=ieu7wChfCF+cewxYsD429DOMdbjb0i6BHUs/n54g9YRP/gLsGKM/1gCS4NzqV2GPktohP9O1F3NP1uxbQhqT925Fc2rAKBgYYhTY6Kq144kTzT647890WyfIbzGOJsD7bqtyPE0KagOCM5//QXJpY6OfrgIbUjMfngO1dyCukdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529564; c=relaxed/simple;
	bh=V7d0HSjRnHzOfU+EEKSUCWwEtLbsiZEB5+rydMOHck8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXiBcXhAEvd5VrBI8HiN6hCGQg2Sw+lmgwUavguvNe8BjXWB8xz6xoW82P4DZC+CwbXAG/gYoKBtmnul93Q5RDgn+JR5ps3vowUzTUAoQQdRKBsJw23UbYSv+gxp96aM+6vvyhkot6BoCwBkQgVquBOuuQyCu+BHs3H7DX8Y7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UywHCwMC; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso110967539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708529562; x=1709134362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTUWS3ITPqTvVHNlrNDdtxwJD4AyTQiAHNyBeZPU4ps=;
        b=UywHCwMCyRhpzKcw84pCaY/tJ0RV+xQE+s/etFllRxxYUfTQ+EcZkGZSpxCMQ0+AkJ
         vU/i6bxXmPX8koM7nzRH3V6wfw0NvMOTrwa8rBIQzG1qa7Q71ZP4LGVXBSIiR7XgpDgG
         DFDwvgiRRN17NEEyxVG7i1ahm/lALiBCt3zBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529562; x=1709134362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTUWS3ITPqTvVHNlrNDdtxwJD4AyTQiAHNyBeZPU4ps=;
        b=H2KEAN4NCyakA270K3d2jNBs7pu0VXuivT5d2oyon2RNNRH7jm0xqD9qL6MQ5UYroB
         4htzMK2j/ehzdHzewfT1jqa641NIoTXpB3gneDsvbAc2n1GL1dYpLCXpF7nXu/L9ObGp
         NTu0DP5fZSQkc85gbSRzOrjqtGOFLXVV8FtNHNX/YxjKnMxQQDSYp/SFalYejgUkx9SV
         rs0JQOhfN95bssPth1hWThHKH6U0ftUNehtty3iiwxdE9PiO+fYnbIpxPfM3h02EbVp8
         jcpkh4iFey0JXbl8ePS0D27cF72hDBii+HYIsSNHiixUJRxst4frl5IJY12qZKBeYFXh
         UHPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUISAahrlJRwrSY98wder+hBgTJANClmz5fqy6CydJ9V8VLtYmoebBLjgaVZhaiQGp1zsh6nG4wBOCEOG4GJugizckDLWjHcI5wiMMm
X-Gm-Message-State: AOJu0YzO84Cbf/qn9T3995UyRzx4UWHHPyLoCWvNsRa1hzA5cdVW1u9N
	+atOd5S3eA/75s6oBJA+gvQBT2mxR+1a6asBGqrOtkfJTBtlNR0KdFtUia3N8GM=
X-Google-Smtp-Source: AGHT+IGsafhl7SWuEo6yvVNtfR8RuWLkNqrVmSIk/bzAZaHH0TBGFMabmNdsRvlZhXzy453/7nPXrw==
X-Received: by 2002:a05:6602:1d47:b0:7c4:655:6e05 with SMTP id hi7-20020a0566021d4700b007c406556e05mr17213245iob.2.1708529562000;
        Wed, 21 Feb 2024 07:32:42 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q11-20020a0566380ecb00b00474269ff209sm1796067jas.119.2024.02.21.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:32:41 -0800 (PST)
Message-ID: <bc6e74d1-4354-4881-929f-ae45ea1e35c6@linuxfoundation.org>
Date: Wed, 21 Feb 2024 08:32:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 13:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc1.gz
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


