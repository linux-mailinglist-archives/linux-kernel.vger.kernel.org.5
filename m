Return-Path: <linux-kernel+bounces-83946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC5786A069
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA541C23215
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7D145323;
	Tue, 27 Feb 2024 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq9eRoSw"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43E1D6A8;
	Tue, 27 Feb 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063002; cv=none; b=ZD/baPT4XDe2Mt7OyEUN186P/CN6dYrRfdG+oWtxKJPh/RXLU5iLe/GGLrRzfCqOcvUrT53a1WOINOP6ITaCXlfmBJUdyLOnXL0zfbETj41vETrvPwORwBULxA0CRP+w9Jo3my/vjVWM7Ycix0M8sGlU5DAlCYerWAEmvQ43myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063002; c=relaxed/simple;
	bh=dqDyN+KRSfnOwkx8dVPjoi/6aut4zltvBRatniQunAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJr/RLshAGboF8JuCsaAZ4h8bs6r2sSsiQS6diqjBzSv0NCKIVETcjvLU4ZIE/7m57rgpHYHhG2rsVSUFIrUTs+5e2BSwIc4v9V0qv5CyO2Om7QaRlAv1smWckIZrgLXmioNx4XIYYdDO48tkOmIm1ROrdX8YBFJI+3DE0qHM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq9eRoSw; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7872614af89so10650585a.0;
        Tue, 27 Feb 2024 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709063000; x=1709667800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHRF9fotsc2Wn1fuFRo4Qf8oTaALfFUASU6mbW+XRdU=;
        b=Nq9eRoSwfFK4NJepVFepwc2x7ucwrnBcC1c+k37A19nFHfhEfNPp/QDY7gXY/09brX
         lK16/LhpJKuSnHgxkPAGqSR7YKJGTSws2qsQ2EG89jfPZ6KIlLkGzsXFiUf4pPo3ufrY
         BpGvCbME7qZO0y+bX8Pdyn15P0bd+qI5kG4jhsZQfSvwaJCMVWBRL04BTnutfymvUkHt
         RmHe+3gDxEnji12xdo6HnBm7c0XQe3zD23piDczbYixxkhPlMfZ9i2ugMIaSVbGicvbD
         oSsGuAGChCFS1kUhq7U/VWA7qLKlJ9GkHlMfKMxKUXIo+OdZyvIMbWePf1nDO6MT5Obn
         boIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709063000; x=1709667800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHRF9fotsc2Wn1fuFRo4Qf8oTaALfFUASU6mbW+XRdU=;
        b=fmKCllyFhOUtd08OKzUf+N5lLFupQDXO1N6QjRQWlUxiKbw6gW1EpF1EMllhBEdSfW
         7Jh44HblRnhvpyh1bPNUtBSemZDF9usxt3Mu1ve0mq+SQAEYYUGjPlhHIKGDjxoAb65m
         y3t58TCWebcZngs+M7RX4g09KzEOyzAyoeggujzqgMzv8wWD8i7XX+XMrimByvqrVPoR
         c7ybhMWCub0DMNpJjvvppJLekUSNjBBwabyH+0SVz9FrvptRzyCmIfEqKBBfP0I1YLBJ
         x71AqFuz7d5/juOW/JulHuO0q7+MvF4GqDQubIq4fZ8jqmnf1Fc/9ybCMaaMmNoKrFxw
         y9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmZAg33cfLEkILbGEvZ8cwW7KFgSEc/Odc5UNusFOtd2POT4zSwfvtvg6MYS7zWTBcdQJB4CfQ4M7NCT/J5xv7UQUcG9cADLFRchp10zP2844Rhm97m6uCUWWdV6Oy1hJaSUjz
X-Gm-Message-State: AOJu0Yz10Ajl6c1Zg4vYRdpEQOb5w4OY6lnqOY2Y0Bl9p8ZE0P0r3IWT
	vuQq2WMlo+3Mt4IdcmjavmLwhdBcY56okvY+z6OF4QbdmpJUGx5J
X-Google-Smtp-Source: AGHT+IE1Djm+XG9j2e22YAFWUsoNpcBWHxoMtJD1HFPL6vmVz2lBTbWoS8ibTv345dqt14KIXoooEA==
X-Received: by 2002:a0c:a701:0:b0:68f:b941:3463 with SMTP id u1-20020a0ca701000000b0068fb9413463mr455963qva.3.1709063000334;
        Tue, 27 Feb 2024 11:43:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ng7-20020a0562143bc700b0068ff79d8d97sm3787473qvb.41.2024.02.27.11.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:43:19 -0800 (PST)
Message-ID: <3919f8ea-15c0-41ec-816c-dcb8f97b4682@gmail.com>
Date: Tue, 27 Feb 2024 11:43:17 -0800
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
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240227131625.847743063@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 05:21, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


