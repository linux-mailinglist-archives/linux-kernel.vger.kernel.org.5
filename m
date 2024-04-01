Return-Path: <linux-kernel+bounces-127182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C048947CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224811C203BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1856B99;
	Mon,  1 Apr 2024 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G1lqbLKf"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA057301
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014618; cv=none; b=aJ6tD+58KtTm/3ioPN2GHo8zwXWUeK3t2MNzj7SpjP4H3+DINok4ql6oTDqJ9lKnR74FqPrF/M7SX0bxjO+2qWaetEJUDXdH18YBjtyPgRsY00hng+yCxvP5w1S7HYDryvme9+LxYTlbsQqgF7mdiN++Vk4bScZTiYkCC23pWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014618; c=relaxed/simple;
	bh=CqfeARlug8+zcjr8pia+tcq62XchzGu/UcL4fzI7plM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAx6TRmXWF0MxwvnzJl/QULpoB4dTecuoXhFnJ00o95u+Dn5xQQ85CZmpMv4eAX2RRruArYrfjdjKVu7cXjR/uNbo7T/8zi49lTJ+1oC61V/kh1U94YQup2S05jd3sdkqW9VdE1zAegNhCw4pyJ7ezhUrwwPu1fMqwB9zKwLZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G1lqbLKf; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc67249181so35849039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712014614; x=1712619414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwQzHTQg7aKASMwhwisC553WH/Sq/sNTw6BLGLLQEgs=;
        b=G1lqbLKf3SRoT8O1nrQVgZYcHiPCsHOFEO/iXPBDJRwjuoWpBUaeDUNdERpHMpGll9
         syKyykJg9HxrYdakpO0J4uwADGFDWuOaRzk0YI6yss7HeEB+rU+/eeLT3z0BjfQrVtx+
         7AefySGK/lA7ZdN16oI79rjwxNws3lZGAcNVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014614; x=1712619414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwQzHTQg7aKASMwhwisC553WH/Sq/sNTw6BLGLLQEgs=;
        b=AxcIbNxk6ifbjSZQ8oC6866sh3lzA2sn21KB8h6kU693kgfvEb/QOUAMFQoFqOEjF9
         /XaUMPBctRYmhXKEBvlyCjS/q6niaBxVkeKHx/5b70yCY1GzOa6ZUHPLBZFsySRQuQrT
         KqcNyUKjjneQEDXH20q2FdzRNbSqy1chnDMrlUikStiX//+kVufCi09PcU4y9F8N5nv7
         Cgzo/gv46GyUlO//+hslY+eSn6jWcO0vxU6Yhtdp4YhLLc+pqKBpm8k/sz0IgDlt+QvK
         6VsQmsaEHKigFYausblsjZ6MeeGtqB9q1hPJa5MM+hfek5SIHpL0XMtJ8QzO6mEZEcud
         jQIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZgFj5F0L3DrWIUEFZKqLkTesND8rCJpt8ISrcB0YRffdeZAg56kV+0hAru/Cul+jLFUlXnqaVWx6tdJ6GSOhBwVmF5WkRcJteLJu/
X-Gm-Message-State: AOJu0Yw2E+LHkj5uz5v+EKk6BDfRxryAyMZu2c1cjkddF7nC0xqykzHq
	BRrdEVkhPo3MkBOzpTdxcaANnXbIY1tB7kGBBqhO5B1BONN9DP2YwLoSs2RHEEI=
X-Google-Smtp-Source: AGHT+IF9VDrAkw8zM+JlSY1VR4/oU7l/OgNtFNLNupYNJ/J4MEr7YxZTlgnNdnDmkWerLIX7U/KH+g==
X-Received: by 2002:a92:cc46:0:b0:368:9b64:fa7a with SMTP id t6-20020a92cc46000000b003689b64fa7amr9893308ilq.0.1712014614629;
        Mon, 01 Apr 2024 16:36:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id v2-20020a92c6c2000000b00366a9dc823dsm2959187ilm.55.2024.04.01.16.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 16:36:54 -0700 (PDT)
Message-ID: <92c40e6d-3db6-4cbb-838b-f4c875e747ea@linuxfoundation.org>
Date: Mon, 1 Apr 2024 17:36:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 09:39, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
> 
> ------------------------------------------
> 
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
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

