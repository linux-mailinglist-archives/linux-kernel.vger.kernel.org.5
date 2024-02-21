Return-Path: <linux-kernel+bounces-75012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A58C85E180
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1B5B22901
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E68063D;
	Wed, 21 Feb 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IDY6k2Px"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551338060A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529994; cv=none; b=WLYIlfPH94QC32D3pXAxXyTUZXOpOg8SCv2ZaIpl54kgRPfldIuLNF5PR8HPzz7wGZHrvS3cvkisP5v77LPv1tHPJ5z0OuuF5QT9JBywi0Vvyi0y/4igbm0VlRSguH9Bhmr/XXPw8sV0dmLD+ZASbQFJGGqst3jXeZb3N/ebOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529994; c=relaxed/simple;
	bh=/hWKAeRud0kuMn433Dl2jo5S7vqk594oIcvCbmHWLfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlUscOriuy2iwPtPPV2q6R6lQvpsOYE0ZhZGXNv/2hgjRGDzdGN3HaRPhKUej+h/sSADlddB1B9JwYZD8U33cWA8raKIMP4e6eFSxP925bq+mnlcy+4d6zI/hLdy6zk1w9/MzZstsxR3J7R/pkcXCNesUdYjFXhq6UfrPbPKkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IDY6k2Px; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso111121339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708529992; x=1709134792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ihCoGD8YoiAtANW7gUYHEwJtMSG4/0XxP+tNu2DuZY=;
        b=IDY6k2PxHa7FiUpYLmI8mR2r7n86TCwNKBNB4unNmYINkg2j7BtZ5KEbezZETdXXjN
         KdxJi7LaHFZRT9WfTpfngO1Hch3JLKj6s52pOKyKa4DuUjRB8MBnbul7VeRM5kvfmUJ/
         Fi2lKTOLTn99ttTKFYhS+3sfHUehcGL7QIAI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529992; x=1709134792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ihCoGD8YoiAtANW7gUYHEwJtMSG4/0XxP+tNu2DuZY=;
        b=hIWz/nKF2rEyeuw4hAUCqWLsHiXiGtkjHhtaNNnITCY7NRi21xH+0C7Ko89eaHHBp0
         TaA5FuAjrmUr4xIUVU7w0tjhDIcKm0MLDvJF5ZIGtk5vLxcXTiyZeAiLtK+2J101R3lh
         4PhApqNU9etDqhVf+yJzNIOJEWpeJ2TjAfkw07dLTX1KvgaHQH01eED0MsTAI+0vGQcD
         Ga6Ix6OdN+lOOl16GWHQFtJY7xPqBmmXneRtZvT1PY19b4yh7ltbfHuRUGpne39XDwZP
         O1DiNG/24Iiv50XjNBClXRdgzAJN0R82S8+SnuFfTMg/emDShvd4EFR5dS7pcO/fLcR7
         /Guw==
X-Forwarded-Encrypted: i=1; AJvYcCV329HwFdXS87f6AHKN6CZ2Tn4lkEOVZt+SdPzKp41ZXZuWo1fVleC5eJXeceZ9iQPo7QJH08Ed3pns4jx/X35VJJYNJe/y5Ixs12U3
X-Gm-Message-State: AOJu0Yw4fSrjrwccRHIsWvMZa6tsXyF3sGRJkgnycFA5AO+yCt7Q08E7
	1zGVbo5hMwzBfXJWq+yXzbsjnYd6Fa6W/5W+guklj/+p1MmIMbQWHyhfEjDDjye7ADqMpfuLPNN
	V
X-Google-Smtp-Source: AGHT+IE40mVcFx9SdHZh/rfdZg9KERS45XtNgRegwEDd/xTtiSrXpdBzPTYo06768NFczi36UWEffw==
X-Received: by 2002:a05:6602:f15:b0:7c7:28f7:cc81 with SMTP id hl21-20020a0566020f1500b007c728f7cc81mr12863789iob.1.1708529992670;
        Wed, 21 Feb 2024 07:39:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id et19-20020a0566382a1300b004741e00a5d6sm2159096jab.63.2024.02.21.07.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:39:52 -0800 (PST)
Message-ID: <005a3dba-4092-44df-9544-7366f267de29@linuxfoundation.org>
Date: Wed, 21 Feb 2024 08:39:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/197] 6.1.79-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 13:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 Feb 2024 20:48:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

