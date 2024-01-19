Return-Path: <linux-kernel+bounces-30659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DC88322B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2E91C22EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B1EDF;
	Fri, 19 Jan 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrszUyZg"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48580D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625015; cv=none; b=abjfmmjHymB1EmxBMDKG+uSHkNrwvEBDwrT81JBVYm9xruaWTA6ar/0rRyPMXA0eVfc0jdFPRS1c4t0U/uDwO9QZVdgyBVdDasqSJmM6e9Kmq/aY1BYugt3DXlUnZyaDoHa6yXJCnv24aZh51+UuHNvKV2DJWtlKwdiR+ruBp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625015; c=relaxed/simple;
	bh=We9kek1QvfzEG/FHp8foZ8D3EJ3QMcjcRoKlbrKIHMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG+lKMuzXlKaC6gtcagWSc5edDOtC25JsBnWzMlmNijT/XnoRvzB2dE+1ycVrOXk3LwNimvKh3HF8ablMj8BoXzbXx5WAbuemRfg7FH5EukN5zW0WikLFI6ZxBgAwIxBZlbuYqJ5D5TqxXL762SmqK9iIq+kpXhtiQ0SgfRPljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrszUyZg; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso2843539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705625012; x=1706229812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBnv0RUX3TFCqj0nPUuecW/H+DxKfFYP4y4/hu5UPJQ=;
        b=hrszUyZg6JDrf1fkbsD+lhdy10AoiaUho8RU54510dPD6enT/XSN9i+IRK44yOZwyZ
         RLaru7v04ka7dyIK4/0NpFKhR8kF/0qq3f+G7cP7h91ACOpdhjfkdVUe40NXYjiUw920
         kYKxZlrQ8vsRIP8a2nqeco8u5obXxpkPjnSRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625012; x=1706229812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBnv0RUX3TFCqj0nPUuecW/H+DxKfFYP4y4/hu5UPJQ=;
        b=rDYOsxoSZuxs+lQgf5WxbESsUMbJSli7OE/OlgsMryavBmyoX+QJFpni5tonH/+twn
         jusnm+7966B4SJj5lZaijv3eALjZLkRc0Y2hnTmLECouUTIU5yTRbEUNyGSuJBo14Eaf
         LuPQV9MkHP5qVfYPGga7Y3AVCOTDIoR383Xk7HAE4AMiS5aA8niVrvhJkt79rE8etJWO
         4M4JNVErMnQyHcL5tBhxF8psymAlwJ74j1njdOj8SYyEC7di4KaHYDEefxGbwMwH9dZZ
         NUO3l1Jh/QAcwP7uF7rkEmz5y4sL9eJw6QYd2jn/eevCCSKh4VqmqNGF8kgDVrF+hKRm
         Q6mw==
X-Gm-Message-State: AOJu0YyK8xj74jp2roW/nufq0pJ9zsAThBvS3p3HfOqU8rvcUYBLLLZz
	LLZc5vkcPWhyBDlecNkNsZ0HvNFwNGOQQBfNu3chePCoSSzlfVEflCtcBQGjJWs=
X-Google-Smtp-Source: AGHT+IG8zgueDzfS9LD6Z4yYM7R29y4jllvVjdL4m76mwgub+kiIq1WXMB2z8d6G4+aySIfGkX8nxA==
X-Received: by 2002:a05:6602:1233:b0:7bc:207d:5178 with SMTP id z19-20020a056602123300b007bc207d5178mr3402541iot.2.1705625012057;
        Thu, 18 Jan 2024 16:43:32 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l10-20020a056638144a00b0046d18e358b3sm1323950jad.63.2024.01.18.16.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:43:31 -0800 (PST)
Message-ID: <459b489a-d9b2-40bc-b1f2-7a3650fa71ee@linuxfoundation.org>
Date: Thu, 18 Jan 2024 17:43:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240118104301.249503558@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 03:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
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

