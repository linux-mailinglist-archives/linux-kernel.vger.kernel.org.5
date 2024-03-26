Return-Path: <linux-kernel+bounces-119553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E494588CA61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0615322DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878585280;
	Tue, 26 Mar 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eB2ezHa0"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFA8527D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472915; cv=none; b=PDvEHgjBhptCYQ++2hMd+QcgItny14zGx1oG5q9UC66OAvmlIosPj21Ax+vKH2zSZF720IzI2t7SipKxULv4Vxmz6glgsdZB8mAi2YczLmiqOlTa/RJBnsVOOyt8E91V0TSLZ0cu6XmAOEWnoZF0lKl4qd4USpNBe96Db7geIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472915; c=relaxed/simple;
	bh=a3GRJTyVtPaora8i9TFnln9ovQ9cDRnFSNqM2n3wIXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5AbFiyL7EjU6cR3wwd5G90XUusnCaQD54ol/LsNFdntR+pFCnsZJI1yAJ0qqCrNIQ38nINho5viHScejZQz/5WdMwFHMFbZec5hT9L/aPkcWwS5sMyje/7hnXScVexn8xfcbTBQDy2e5qD/a+YNYVPnoiMyE9DYGRjZDR6zPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eB2ezHa0; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3688f1b7848so375295ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711472912; x=1712077712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHB53pAWBp1T0qlQ8wQNsdw4RtYHLdu3JSmQ0g88I=;
        b=eB2ezHa0Iq+uYyMotaEYa2xl/u1774kPDiSHX+QeiZ/K1/gCeDgakI2H254mDMlXg5
         DUlqlb93ETgI0diPo1fT10k2Jv5I9XvrgSSZTN+Z/0ddpMbx1fKovNSHdACxbucyMLFW
         QmGclUhNI/5NsKfj47KeWoJUM88BpvIrt7n9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472912; x=1712077712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHB53pAWBp1T0qlQ8wQNsdw4RtYHLdu3JSmQ0g88I=;
        b=SnieIPIGgF9q/4Eg6xF9rgcF7lxuOQgKGUZBrWpvRGWvM2+igVUytf15DELv3Q9m1J
         VMGQosA1q0GeLzKJDWNFhEh4SoZYr9ddahFgBCaD7Gk8Kpran8u92hkJgPVxZ8rO9nCz
         v2rdEP5wep1+EfOhORvKA6O3ZgDLzIp21kntbGPWlovu0QVEL9OiE6LeUnRQKUA11KQA
         AyN3gtZ6+XiCUnZ2MTWlXRRwEJ5lVbqfbq7nUdb/UcuoZgx7HFyJkb6fM2jyFvd3UjLu
         wiRnN/uS/jM69wXzo436gRZXNxGg2VMOvOwRfW+byPV0/i8bgktj5WK6ruRTtF/HTemV
         ZtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHAruxKuN1v2IENf8f0O71dDKVCvhnG01+9b0KDC86CNoI8jdPub7KT55zONFtQ2fA3V40XVAvH7bUDx6CgsgqWjpNmlvfRtDdLLB2
X-Gm-Message-State: AOJu0YxEbscptPM1WVF1jD+jpuasp/BX3NwudxkTnMCSKIwKBL/oCZEG
	g3KQlIQrfWF8n8VfeLhvCvTHHGb+QVXFD5fal943XhzgE9/2lYJJpF+1V8NWitfnnFiWYsYS1cI
	A
X-Google-Smtp-Source: AGHT+IFpDE/DM7o8b/z0YlYs+qLFUH3WJqjCOqigf2riKsDgjAvrpcxhI8f09vf2rXtDTdZAi/le4g==
X-Received: by 2002:a05:6602:88:b0:7d0:2e1b:3135 with SMTP id h8-20020a056602008800b007d02e1b3135mr10601604iob.2.1711472912498;
        Tue, 26 Mar 2024 10:08:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a22-20020a027356000000b0047d6ece7413sm450480jae.102.2024.03.26.10.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:08:32 -0700 (PDT)
Message-ID: <330ade13-2810-46f6-bb94-2718547a9597@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:08:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325115939.1766258-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:59, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


