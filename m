Return-Path: <linux-kernel+bounces-93078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3668872ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF7D283EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8912D21A;
	Tue,  5 Mar 2024 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAc907sH"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688B12CDBD;
	Tue,  5 Mar 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679997; cv=none; b=q3cEnYpg7OwcYZfNlT61dM17XyRcym9SZ3f2ms+yl2XxdX0yTli30cC9+Lfg1/xYj6xkcgGZxmwtXPa5VbIN9qYUmbfXOctP+Vo/wlXyxI8pVkUus80Us5ZXTco23ASKEtPjevlt3+HZENDrirMUHR3gJSuN28ylAh/X5fhGBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679997; c=relaxed/simple;
	bh=YTtpCG8yLDYQlDCH454jlYbABLTnRC9zq2IxaUTjdr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIIoXwetqhcT+PCOOrck6qfEdoKqGG2ENfpiDpYd9p+SgwajMAob2pfOcDFaBO2GRwOV+p1ii+4g6J1RPfYO6Q6C5Q7O//9R+LZtnCsIVe8BAx0lS/Pm1DPPZSlPr7QM8UuAirnCQ+cW1eQN11Kz2ZOBbi00vxtnrsbeOZuEJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAc907sH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-595aa5b1fe0so796602eaf.2;
        Tue, 05 Mar 2024 15:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709679995; x=1710284795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cevpF1BZFUtfs7XjcRFcHcD08DG6ELAhoOWrEllOay0=;
        b=nAc907sHOz+zINN2+xWxqBPn+UlYt6GmyE6C4vWYqiPGrJntWOCxyVuP2RgTUsp24o
         SkE1nBlOUYPbY3IlcWRnJVkAPiMpXizy5HAQqSxAXvERSlziMttwLYRMBzcS9g0gyUk8
         RL21zRRPIQ3Nmb+T0UYmUA0E79ehR6O1AlTrW/+KQZ0P1Z8jOijRWHFPKMkSwWb7fOau
         yy41Pe1aFdkL691VURjratzk/13+7vhVCeb3WPbkwOmOKb95DFMQlOFxFoI08JLly3sZ
         KEzlC0hkHowKhC1/2qpSFYdjQJHxb4G1JWnUEHu2uKnr2h14ShvdIBXm3n41FTbp+2eb
         m+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709679995; x=1710284795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cevpF1BZFUtfs7XjcRFcHcD08DG6ELAhoOWrEllOay0=;
        b=ddv+AxZzNz4ZOtGjH2daTO2abUQwDogZiayR19Uc752UoB9Vkyd9oSISePHaAVbLCK
         N+p5tZOnFrDftABgOP9qxSfCniipceb4HUbo2AeqDXP7wgIPHx3+x3pqHcI6BevKl/I2
         qjgQN8yMMeWIVwwT6qj4IWEUaojDxwE8jlvSJhaq0IJUvuu/6JVZiirZ/7S11oybYTxB
         s8BJ5PB+hFuVLLAo7BqYQu36F3QIZQLc7CgQTZud782Q8+TVG+njK7E0eKt1qzlYvNWw
         GPVO7x1ewuA8Cs59q/Y6Rov42lhHOsF3m5UZpalAmvg4nwHCeuDpG37p1DE4hKxlCQW2
         QttQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1BMlIDMUaeWfydwOcCiE3mwvy5B71uakYoxA/9khWQbciZVUcfmcx90WZfgE/fVEd8oqxxRiDEgMsJ5St4bvaecHV6673etQi/Skm3OX1osZJaE8xZFxRhPOd1eqkP2nV+FE1
X-Gm-Message-State: AOJu0YzoWkpqm4Xy3h31yzCxjl/n8/GUcR+wS08B/PY3hkrUBE9iKQxl
	o9dN8+7OI0xoBH5phhwXUMNv0vuB/g6h0GsVvXKDo7KGWAI6Zcu4swGHqOkg3uw=
X-Google-Smtp-Source: AGHT+IGs/vlJPLVVwCDRUjVLZh4t8NOqV2Tmf8QSHPN2So9mEF0BvcyrHVH0gXWrh47sDgJUBamTEQ==
X-Received: by 2002:a05:6359:4103:b0:17a:d4c0:d59f with SMTP id kh3-20020a056359410300b0017ad4c0d59fmr3861708rwc.4.1709679994927;
        Tue, 05 Mar 2024 15:06:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id op29-20020a056214459d00b0068fa815b517sm6736815qvb.6.2024.03.05.15.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:06:33 -0800 (PST)
Message-ID: <d2884c34-fe74-45f4-b7f4-3a096c9aa64e@gmail.com>
Date: Tue, 5 Mar 2024 15:06:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240304211549.876981797@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 13:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.21-rc1.gz
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


