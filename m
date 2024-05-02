Return-Path: <linux-kernel+bounces-165938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A118B939F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5CB283AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B218E28;
	Thu,  2 May 2024 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yccow8Dx"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A014292
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619617; cv=none; b=teFrjWXhF3DYa9RoSitFL/TvGz3avxTMkLqRi37kRAysTXQRRKA0jgI3V7zzpsmKs2pbXT6ya1ZJLoyA1SLuDNCu7/N2zzuEu6nDIPiGPRBW0ySoCkq8aMRIDmft8O+j6LybioQJkhVWkC4jTx2gH5P3HL9xdSxdQGhTVzeuoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619617; c=relaxed/simple;
	bh=5XTfPr4IRbJ7mVGRcfndFaOJC4COJuxR/NwIjpIlx2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/ISpzTx1l8Q7uPbVBYzCFeay3+CNpoHS2s6cPulFXcEQWV/uID3X1bd0nwjPE20mfME+2QkzCZ3PpUMoaeVSpzy3wqlBuaFLSqMnT/X71opVrr29E/5Rr/TAijtVovibFhPTlxm9ZZaFOC4mBVqpSXY5FLnj5a0mK6kkV6CqaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yccow8Dx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7dec9c65057so31207939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714619615; x=1715224415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWSztiZ0J905gZ/ofKM8FZjwM5J8mddj2PYT/nPR83k=;
        b=Yccow8DxMX1tcgsAeDQ2ZznLzIIeBabatEjJ4Fu7/EmPMiot6ShZDlgKRjHiXUeXNx
         WJdefOGqd7eFp2dPQ+3VsJDtJ72aj03LUPPILDxU9ooh1+ZGVIjYwzJPKUS/1mCWgwUr
         AotlrexwYrPCtfBFHrgiQYONbbJOTmV4w79Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619615; x=1715224415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWSztiZ0J905gZ/ofKM8FZjwM5J8mddj2PYT/nPR83k=;
        b=Xj+G4VdDh9Q6ccllCvnyuDo6YKXVM535UDeeEYbuMnhVE3l5h5HJHeGkofsyES7WJd
         MkXyI57KZyg+5gAHFsNUXHIOknj8s8JzZ4eKGfSm0c0WUA2rQa7prXGhdrwvk3EQpOUf
         N/UuKFYtA39/eVy7GaWUVhONJYX1BtADpIycLReaHXjrdTn1ZPA3jTXLRUsWVyA09puF
         E93yv1SuAJIVfoM2nW8llhF506SIDWgsSDgvhVMSkHhS0rWgH9H0iE8bxZXJ6Sb20ksc
         i0YDfjQsOrPFKwx/2nQE0S6ZVuQZOi15vajWVh8AMn4y0SGwPx75RGdA9kWA04VfqQq1
         CKwg==
X-Forwarded-Encrypted: i=1; AJvYcCUEhylQ/BroqLA46HQJgRz9dX1e6/R7g10JXID3U2aSmMNdzp+iRH8cP7x9Cipc6zP9Oxgg9WY4ZVEZwNBj4i9qQiJCv5WQ5TELWEyV
X-Gm-Message-State: AOJu0Yy/v0q8m0QCXq4jbKwR3mYOLau9/jQQQHWMkNTX5ll1mfJXoQih
	isxGkcMua1vHRCZZFtUBEpHp7GKZJssnKS29o0m4gInH4oTGCiE4U4pRZzyhSRE=
X-Google-Smtp-Source: AGHT+IGflx79ER+Vhq1h7akcsKhdeZmwayTvTxHYAuKOu0N6/C9SX0Nukp7IpIEJP73j4ChlCLBcFg==
X-Received: by 2002:a05:6e02:13a5:b0:368:974b:f7c7 with SMTP id h5-20020a056e0213a500b00368974bf7c7mr5573879ilo.0.1714619614970;
        Wed, 01 May 2024 20:13:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m3-20020a056e02158300b0036c6bb70d9csm15814ilu.10.2024.05.01.20.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:13:34 -0700 (PDT)
Message-ID: <e1b6cabd-adef-44f3-a4e8-739629037632@linuxfoundation.org>
Date: Wed, 1 May 2024 21:13:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/77] 4.19.313-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.313 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.313-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

