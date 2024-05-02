Return-Path: <linux-kernel+bounces-165931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4728B9390
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB611F21501
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB018E1D;
	Thu,  2 May 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4aEFbw2"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD618054
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618938; cv=none; b=RBjYyNwYiqVMMzmunF4TqpaaX2tM87baHcxKkoT+meRHhsTekFcLZ0JYWmsVZdivkMMm/U6RqVrz68TC4U1rDcv/cTmUVIPr9Bk7MTrnULKLCjHq30vgzV2sPe9Pmk3xTVvdh3Z8wLXrYMRYPi3Xo+DUil4qH4HneQly2fHETqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618938; c=relaxed/simple;
	bh=BrO6sR36R5N0le0PyCco3GLRO439I9ECeSVrhMyd9Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUPW8AnGS/IcccP1Lw332fajnakzJPjHNCEoVj9wV5SphF3yoPy9veFtHwIVnqUmwUgy1KGZv8mF98R2iynmNRRTEnZfAI2VganLcxNj5LhwDAyFCJhCqcJZtJrhLGTIGjvMfHImyRagW0hcPdXVkuEV/+3NByTrvYiGglucr5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4aEFbw2; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7dedd08a6eeso20182939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714618936; x=1715223736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjNlz/0kd2mNH4T0WxI7TxdTu+LxmeVSYgKdgcdHPyQ=;
        b=f4aEFbw2qcQDPOooAgI2/HgmjIfwI6SlYB7fTbxNGNmMpP6mAqPJ1DCvUQUyBvCyJU
         zo7zgT4kn8hZ4XGdaY++GdMgNnD7NRp6wsuzZ9WxV2uFjAFZLYhvjLBXWwNve7yoR6Bm
         d9OUC4vrCZ/0LtNDgN0D0k+EMil9mvVbki0yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714618936; x=1715223736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjNlz/0kd2mNH4T0WxI7TxdTu+LxmeVSYgKdgcdHPyQ=;
        b=B8gfx1mMtSObjlb0QSE+tifRjuE2CUy9fSMcX5ieQk7YZ6SArrzh6XOPqBbLpW/NtD
         yGwR8heyF7rjKmfFo1DzZ9cL/HSqW7JEUIL72Pp1NVJTor+wtGgvMhwBdlCFSvaO4Rc8
         mFmeEPLQOzNtTTvlTi7EC9alkec5HNngi8sZ8SyrqaPc0iRLAC2bhWcwMx2j0kDqD1ni
         spZn2It4HM80562BHahdx/MSxyfDIfEHjLSatK+mvthCHEa9rqdoy1sMi5FQOmv48GPg
         zPNg0SaEhMX5LzSunK6sdaAdB1Oz7yU/FGWa4HGyi8ACFwo47bqkHXbgm9Enj7d/FIJh
         yCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVttKTPzuTkVVZaregekuwKDXv8apo3dBtIx5Z64UamS60zc+GUHPX/dVp+vSvpky7iSG2wSte+C/OZ+hDg8/AonQnohJVFNkBwp+gN
X-Gm-Message-State: AOJu0YxLmv+2COw9PhfeIWLVqDWky0S+ge7m5WzuAMYK4+gO9pNSnvYr
	JEPwh7X+yexwc+jPjys/WRV90lrgqA4HFbNBhv39S/+Ij96GrHbg+ZsNobXHaoo=
X-Google-Smtp-Source: AGHT+IEOuAgdk9W4YMfkruIQU7JI4kuh9SNxi71Q6WgY62QwA9r9Ov3Tyn+mqjPjcs8/YxqfbXwpJQ==
X-Received: by 2002:a05:6e02:13a4:b0:369:f53b:6c2 with SMTP id h4-20020a056e0213a400b00369f53b06c2mr5302970ilo.1.1714618936102;
        Wed, 01 May 2024 20:02:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r5-20020a92cd85000000b0036a3e54b6b1sm11450ilb.13.2024.05.01.20.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:02:15 -0700 (PDT)
Message-ID: <bf2aff2a-d243-4b5c-93eb-3b6ad371b24a@linuxfoundation.org>
Date: Wed, 1 May 2024 21:02:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.90-rc1.gz
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

