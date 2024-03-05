Return-Path: <linux-kernel+bounces-92873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92E287274B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648E2289272
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56DE22F0C;
	Tue,  5 Mar 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U9YWgBB1"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56E17997
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665696; cv=none; b=HodsHV+bb1CWTqyfeWq0S/BSLRU9FxtGqrvcnxxgy/+llKLy4t9C5MUn5Kn5dp9XgzXVMad0Q1lqXgd7zRwjJ340CtpE1RKqXL8tLE+hbwuwSkpo81Yg3gLGyXN1eLH5wQn9r4e8XzRGH1NKWX0SWrmL0GkJIqs1bayPVcyo7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665696; c=relaxed/simple;
	bh=zb4IZTY/x87Ncc1bMkL3CTMPfWQYFZkRxFcrmtUHFnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ha5JDIv/iNEr46fWUP0TBZ7aLgaKFxpAi489QsJIAT338pWINTJf3UxXsVxnbOmLeluLacHnLARUn+Me+/29nguYexh5No8qKx/KMeR7rHDyRkEuiyhaGzI16AilN3J2/52/fVHoyM+Ic7tVQLFQkY5nfM/NswO16q+RBtrwQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U9YWgBB1; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso87561139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709665693; x=1710270493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/mpXL7vjAphJHDf2Fr/x+84U+2e2qh8Thkn8K9to5g=;
        b=U9YWgBB1KrXmi9gyDdHUB5+KxeilYDrxqcZiKozfKrkKFwsAnwwn4D8TVuTg4xMClq
         TEi8OPdeH3f/+zGA70Kkex0eippM9WrYMvAVOxadPBzM8XgAKWLFqBYbMA0ya+H5U7vj
         hHup4vUbHAU9Vgd2uqVbgDgOHWF73keFG6jt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665693; x=1710270493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/mpXL7vjAphJHDf2Fr/x+84U+2e2qh8Thkn8K9to5g=;
        b=hV/+5pMxPLkAvm1l2NSfn/26VPDr+dan7fO4h2W0G1z8lRZTfqy29JzmJjGFht0oK1
         cS3cpM08y4GA1MAmyWDbBOz9UiI89qPsqh/JnGc0BWJZXK3aPuJNtfC6kFUETJco27z3
         P6D2NUUamPnHrzHR63dDt7sZB1wzBaQAf/78xUswuLi2VLtXq50q2eyi3PBv6+x26Ffm
         c5/usgMqbJ2kDL493aV4qQMQPAOszOe7P8X1h6nq1AWljUA3PuGyce6w+thrUkQgLf2V
         E9ULYLOIiYyMcb5rOTw/vd1PNLJgDeFNLhgJQaO6ZkcvU+w6OCoooiiYZiq37uuW+cU2
         JVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf320hTSwPkx+mqOz+PuXUBNLo2BR/+gIn5OALcq6EoJ6ymWqd8Clpw5usF0w1icuGxxbR9YhfrF7YAYxtWBPRPGXjRQBqYikMW302
X-Gm-Message-State: AOJu0YwsujZgCX3GWz/CnCziOL5tV9/jGogQnG4vyXOIG5hTwto3g6a9
	1oDfJErq1NdKQ9KPFVenH5OQC74T8yT40//VTsVqu2Qi9vmP1GkpfSIli8bGUKw=
X-Google-Smtp-Source: AGHT+IHhaLRxwGXGGeY6kU0XLCNrsqy86E0hTy6A2CS0fhkBIb8OsxhB/njDQVKF0hsBaZ54VPxVaw==
X-Received: by 2002:a05:6e02:214e:b0:365:4e45:33ad with SMTP id d14-20020a056e02214e00b003654e4533admr1424775ilv.1.1709665693631;
        Tue, 05 Mar 2024 11:08:13 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m7-20020a056e020de700b00363909191b8sm3190492ilj.39.2024.03.05.11.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:08:13 -0800 (PST)
Message-ID: <b7ccb15a-4271-4bd4-abc7-038a7930657a@linuxfoundation.org>
Date: Tue, 5 Mar 2024 12:08:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/25] 5.4.271-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211535.741936181@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211535.741936181@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.271 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.271-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

