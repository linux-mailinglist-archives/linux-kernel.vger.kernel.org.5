Return-Path: <linux-kernel+bounces-92872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D6872747
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13751F22315
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4890241E0;
	Tue,  5 Mar 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FtAvrqdz"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F35BAE6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665517; cv=none; b=gizJkKmzN7YlODlIxFliC0IaB+oC9LZbBG01JHf1KsvTjJ+E9FfWMXk2Wf7XanTMQU1HMpuI5B2oHty3/VitXWHl8jAbLxJPBF81hbkQHahbzqC/1xKPBCt4JRxYmVs7WuSH0sKHinl8+JO45ZQgkhM1tGUpRVu4E20Ecftf+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665517; c=relaxed/simple;
	bh=pLKs2o9mN+L/TVn40Qf5nbTSPRtRFjwhZXU/y/3HgyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1xg21Zdq/uI2qRG40VZcQqKx7NCdH4L09qL99K21tTEVAUeEPxMPz32SshGsMIM2fRpVUU4ZVnxC/Mc2cIUYRpIe7f3pI0r/xpveNbVKWXoB/JiUpk/blQ47n/omHO3+yQbfjD46qKu3IEmw8eVVYwk1Pr90vw68BNHrfeEMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FtAvrqdz; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4ea48972cso757541a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709665515; x=1710270315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Bv6g4mYuzY5a2DeNIRGo0Wt9Avb45ARXee/OX48tck=;
        b=FtAvrqdzP9kVdo1hLyMXaq8VfRgeA3glKW/Y3qy8Dn8P37IrI9rxxKmqU1BPMR3O+M
         g+iZynyP+1m6deccAa+5xz20Y6woAf7x2QT0jsTmqwUEUivAnKT6FYGU6iPZSRQX0YSM
         nwi07i3LP7NQAgnaN3lW6hmAcHbj+WKg+JZ+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665515; x=1710270315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Bv6g4mYuzY5a2DeNIRGo0Wt9Avb45ARXee/OX48tck=;
        b=aGNAmphPDCvDxwr0cHqhSURrCYTfaHnTU/NHa4Kj7edFI6bTMr08U4VEVkHxMMSiZA
         JPmrXs4TcbWSuA4vZbBP0MMygi9aXZv6KbZz3JaEKHC1NAXx0orGdys1srRgbl2L+74F
         Ot036Gvao2+XTDqRs/CiGFt+O80Ihrzlethf0bU10IN/7Ce/ZFqRy3AJVWtKprv4GSKx
         foGAmcP8IBjNTbGfnoOvpf+AMdx3OUheaLkZQUW/vwHTrpQqtoNe5fa8zC5FoiroUNoa
         6Kujq8H0qCuFMeQFuBhmKTfOFQ3p0jaSJktID+wvAXPZN7yvkE1za69Z1DGC3QrbX8IX
         c4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXT76Whp4P2yNab7q1/XiB/FN6Z9y0WLmDiNJAZGjllQR0MpPyehMFZ9c/dE4ama8aQSlKMBUFXiKEpM+bO1ugs1Lrtvq7/I/GxBEhO
X-Gm-Message-State: AOJu0Yw+Dn3OyBADAgYmxFkIeLr6FPBBYJHYMQ9P6+i25bgHaqgn3gaP
	7vEgTIn4Y16nCZK2z/uZtJfFPdKgtbTt/ZXzhFyNA6AqPKNfxeLKsas5dBzulYQ=
X-Google-Smtp-Source: AGHT+IHwdrcOWBop+MehQAntWBGU3qhsJDffTHndvFcz3FuvKd2Tgbqpv0qQA4VKJ+ctmFsK1hWS1g==
X-Received: by 2002:a9d:4710:0:b0:6e4:e0e3:55d9 with SMTP id a16-20020a9d4710000000b006e4e0e355d9mr1456409otf.2.1709665514706;
        Tue, 05 Mar 2024 11:05:14 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e3-20020a05683013c300b006e4b446439dsm720336otq.70.2024.03.05.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:05:14 -0800 (PST)
Message-ID: <51239853-ee9a-408e-8328-7e74748e8b13@linuxfoundation.org>
Date: Tue, 5 Mar 2024 12:05:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 14:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

