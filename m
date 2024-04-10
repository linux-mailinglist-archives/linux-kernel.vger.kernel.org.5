Return-Path: <linux-kernel+bounces-137767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC989E6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE971C21132
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04883EDE;
	Wed, 10 Apr 2024 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceQgYR5F"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D3621
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709003; cv=none; b=BN8zRgNhqtXgHzobVKY7X1KZ6KXA7Yj1sMjmNJhF2Wav+iR1amjyajS+8Eke0q1HWQFTaKVhqhc/gHFxOfOnl6PFxqTrvkjxwEXddE5Nz0crB1at86d3DpykRYnEH73hkhyqmQmPBYYbaqgv1jO9/ZRZeQb8dY76ntuXa21pzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709003; c=relaxed/simple;
	bh=Aohoo5m436ATY06E6fE2TkDvoVmQmitw2MESEWpP18s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpSjTk2sPmF0XdsBw1/GVFkROBsOWbjz18+J4dl5SV3+l13/hz7xq+KkXPEtFq0xYoCpSd5EK1QcX5FV7IFFuOH7gUBH96vMm1ZfGLIvMKuOrzAfN/nkC4Wt+qYakIFp/B2oqVTAoLPf0U8Anvyr3VG7dkHuOCPkvoLCVrMLcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceQgYR5F; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so138094139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712709000; x=1713313800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0mPzJYDDs9NjRkVwk8PAW+ML3/n48vFMOCW1SPs8DY=;
        b=ceQgYR5FETQPBankUtRw22T7xG8JP64BXw2NpD1bhAyweV1wg2R6kdKTa7AkI+fRi3
         hLCreG+brzvnKv8fnRawmjrYGkcOYVF9ksTEDyMR4MGGy62XaNSIyQQN3anu4eLr/PD/
         g5D9cnYFTAfi7mo3tsXOjs08SF9BNeXgv0R8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709000; x=1713313800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0mPzJYDDs9NjRkVwk8PAW+ML3/n48vFMOCW1SPs8DY=;
        b=etvR91MHqB0rKMmf0goKs7m/Oxzo9xmGAWc4g9BibEE45nn+8CA4EytiRTcddwYlUq
         roDTQBtQw1xpDYsHEb/rwzy/u3IgDsh5jAwYi8c21m05YU6cw+Oihpxs/tCkb33BNul3
         p0ol57C4ly2uM3IakPnS+VHz2o2WZOGU/wnJncLvmPJqMZeydoe/K6KW/PtCSgE31FFi
         A/oLGJ0id+BN4yWgk4JWqLiebOMU+PrlkAyNtTkyR2PDDKSOWFiO0MM8oK4mh/mlMa5s
         JJc0K+AT0DGLVJFHeuo6cSxybfAGSlP7zLXzeNoSTxZmaD3k4/orELBJ6cRA+wGCFeGK
         z4PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiJooceE77IQJ/st7YCCxqbfMdFrzrrBA9wsuX05/z4Ks0C3BISixToPRqAzfSM8jasA6Kt9aeEXYC/75jQbPIGvzwIvJM0zbpuoFQ
X-Gm-Message-State: AOJu0YxkHLnMP7slmULGBYCsglKHVpsujq/PsAtWhya83nSV892u42DL
	W66vrEHt5gn7oAxyfQ26OQ44jPBuuYAnH4BMORhqL5dS5hgzG/nZTJtjp7iijss=
X-Google-Smtp-Source: AGHT+IGyUInGdc0DiRUYiPJpwVzrArmK5Ss4VpPR1wgMi7o4wISsmAZTzTzpqZ+Stn80wxBkyrIwvQ==
X-Received: by 2002:a05:6602:120b:b0:7d0:c0e7:b577 with SMTP id y11-20020a056602120b00b007d0c0e7b577mr1407387iot.2.1712709000699;
        Tue, 09 Apr 2024 17:30:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k2-20020a056638140200b0047d68340fd9sm3564684jad.32.2024.04.09.17.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:30:00 -0700 (PDT)
Message-ID: <2dd6255c-ae7f-48d9-bf7e-ffeec074cab1@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:29:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc1.gz
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

