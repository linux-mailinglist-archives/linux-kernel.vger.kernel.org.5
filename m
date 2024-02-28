Return-Path: <linux-kernel+bounces-85380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2716986B52E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728F8B25416
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CCC3FB8C;
	Wed, 28 Feb 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EUxnTEKA"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421936EF1D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138393; cv=none; b=aZpyn14Jljr5hUvgC8kuVDnYFuWByveMQSrmjy9mHc85MyVVe8UkJ6MK3sQdOZr9i52EleU0X9SAQGH9BS3xo+M7uT+roeDlAXITw+PAcBp7e9+mEb665koclw8IOotfxVyRkJ3TYkXz7YMitAFBsknE8itLp8aloR0W1pKqK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138393; c=relaxed/simple;
	bh=PZDf6Z6qf0DHOIC6Adf/nEul4voHVYJq7s+h7EnxYbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByyD8tsl7OkHCNXUzcJQRIvyGazdoxwr/ejU76Z2ZhFdg5TzlbNxdI0yIL45CnM/6bO16h/JAcEzugaTfqVVju/uK3nb4lfbGXOLsHfpNOSUvsRCjaWe6s4bunJA0/LJYzCUdRdEwoXNoSuPnCrFu/RCUHrB3PKpYEA7/Xbbs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EUxnTEKA; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso113925939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709138391; x=1709743191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YwFcibZYyn4TURE65NeFWD6oR0EJNbwhkMgk/B8ptM=;
        b=EUxnTEKA1TzZ6A7vYUkJKZHjZnwUKrL8SIpmV8glKkivFOmWN7PqzUagFkf/3aNC08
         dXeL3/KGKfoMvNNbLCJs8160DyazfpKqxdC5pRvZdE/xgdp/WkV+Z9FXmsSSgn+1aqAw
         uFZleNzb7s31ERlYzYcVI5t8GhOltSBmniddQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138391; x=1709743191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YwFcibZYyn4TURE65NeFWD6oR0EJNbwhkMgk/B8ptM=;
        b=INifivnZIOeXZ/Mvbar5bt3XJGCNYQwusiLj0i8MeHokrNbADt/xuOqpjmH8aeOkBc
         J6eUg2Yj6MwXlGrydudgfHtw0L449d7kmJLgiSseGLKW1CTz/KdcxGkdvHPVcflkFUb7
         H3rEEzLm/vGo4A0O6q0ZWl+2p/hIND4wYfZ5vctDgn/Spnhd+o+wtPlAZ0QmpknBWPpB
         yLYtE6QxAqTFAR0s/Zg4q/A3MlABXNJ0Z4OYUYUNG02fiee8xJYkDReQG2cT3TmdbZEk
         S3wchaARl92oCfbVYe6Js7BYxubAdArAdw4SNqgDgUXwjpAmS0QSNGWSzVXR9N4bcEOW
         ni1w==
X-Forwarded-Encrypted: i=1; AJvYcCXPBSJIB9ggFoaZZ+Qx7NJhn9A77Sa2MfaqA6fCRO+Iptd5LBL7jQVVt+TNwKn92csjscO7Pwfzs6wFG3Nq8cO020f2cWQjiGfHKgNw
X-Gm-Message-State: AOJu0Yzyv8jkiq9uh/d39fKxw2YD21xBqGFBgFwK9dYTOzuJS//CGgkb
	cfo1G6I9Nmn++UHqu1c+NhvooRA/LGsPRTXrXkLVjYWBAcqbcCGPOQUDHNfy54E=
X-Google-Smtp-Source: AGHT+IHiLzT9E2N49Fi6K/4Pl1Twu2MlJpcKH7yo5vXyNT87r4Mo0hghCzsyOdKBkevlIl9igVRSDw==
X-Received: by 2002:a05:6e02:1c43:b0:365:25a2:1896 with SMTP id d3-20020a056e021c4300b0036525a21896mr13469149ilg.0.1709138391488;
        Wed, 28 Feb 2024 08:39:51 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bs17-20020a056e02241100b003642400c96bsm2891272ilb.63.2024.02.28.08.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:39:51 -0800 (PST)
Message-ID: <ef1161a2-8c85-40d7-b8de-8d668f9d8625@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:39:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.19-rc1.gz
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


