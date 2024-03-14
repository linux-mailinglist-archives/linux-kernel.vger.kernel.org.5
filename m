Return-Path: <linux-kernel+bounces-103797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AEB87C4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C3D1C21830
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45B76419;
	Thu, 14 Mar 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFCyv6tz"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DB482D3;
	Thu, 14 Mar 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450883; cv=none; b=L95TAxjCDWA+QrUUaWurVteADNOiU7cT0eNoRqFfK+rlMn/HQ1bfRgMQIrgO7PpX0MTWsLqTNdXCus87ONu7ZB+vOxjTik8Bic7CmXkiBYk++TQBIRHKeCPWRKlQRBUOs/9Fm9Cb4ricAFUxLnLPzHqme/MSbysLjHYEiLP+/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450883; c=relaxed/simple;
	bh=GFr/S90szYQG2zf6ZPq88nO28LNGIy0tvdr1GazfT5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1Rz39p25PCw1pm/nuEXYnj54+amf42DW6PVc+ImApAdELkLlbjLEUC4f5e0vaL1TbIIWiSpYOstehrgsESdkyyM/hNTt1DozJhYV+4TbkAiwu0F2pMHbcH8lKqhtzTRL7WUvAGXzzllnfXOb1jNsQVNQbK/NvLdbvcryRmYsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFCyv6tz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690b24973beso20100046d6.0;
        Thu, 14 Mar 2024 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710450881; x=1711055681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrQJIovMot+Xn8+1lLqvjDrCoL0chwejNP1lQa4rfew=;
        b=EFCyv6tzNJHZzgFySFSrqAjvbG1CDHgOme9HmfYLi+cxLNL0uaHhWx26ADX/JK5bfQ
         9PqTfnepfZLnQ+xu6h/NrxnpX7Au1isOuceSqSfp6GkqKIXQW427qEIrX8c1+HV3NFm3
         qsd9h/2X9tgBsBviSoz7u/AB/u5F3tXLMYu9t2Xbv2occgPSo8vjeG2XsvnX9sOAAbaK
         BWK05bMq09Z9V05z0ZXOUL2496ZVw2SUy3DckGKMNHzUjqqbFgQaHMKkB5suil8Xclw5
         EtgfGmWDCdf01wKwHtyz4EcGQ1KWl3suxZbjHZJksFhGIMljvQ912qB4hpcYPG5bXDsF
         RkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710450881; x=1711055681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrQJIovMot+Xn8+1lLqvjDrCoL0chwejNP1lQa4rfew=;
        b=qY/5nZ7O0NfZXI1gsi8MxvnCYVogqucpVlKlJcy92o8cyWcZe9HYzUOs01xVlV9LUe
         BS2AiWePchODlaPELh31uIKPazsE1ZBmaa1h5SPCl3e4Ww2cMF8xf77MsoFFAqKTGYzJ
         nuHKgPSwCNKjFmYbwazcw8akcMAPNkughqGGUXGFuF2s4J8u7oVfivtkkn7IjKog96Vk
         iFLaSbIdLehxxwKSvK8iwLpk5TwJ8xL2Iz9UscdJF2O8cGfQXjCBgCk0mYR/R3tvpbaN
         22lhuKtRdSzcY9ZtiSlaI0lFVDAuxXjSYWI4iCou7XHheBT7wY62E9eqS1srO2N6QBYU
         m7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUN3OPl6se3/vGmThPNT2Da31owAN/0dP7rGzKLIVObv8yRPA1wUKUdyoX7/zvgMEjIs7/Z6Mp1z2hMDl1k96+7LC24zmXxYAkPhy1FpmcPfvpaiIry66SOjczH24lIEZNlJsEP
X-Gm-Message-State: AOJu0YzeucksIRblH42C99/waizMV5WRlztp/BHwZewgXEMqApcfg6E7
	I0h1J8h5bUGk9AzOKDEevr2YuPBkZ8lhwyIXD9qTwmLIOCc86xfk
X-Google-Smtp-Source: AGHT+IHlFf7sQ1rhp5kcv18tizCBpL7nS70zM8qltKYA2tcAssv5F0ECt34Svib1Wj2fQ5l3B3MfZQ==
X-Received: by 2002:a05:6214:529a:b0:68f:de5f:44b4 with SMTP id kj26-20020a056214529a00b0068fde5f44b4mr6840166qvb.10.1710450881027;
        Thu, 14 Mar 2024 14:14:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 8-20020a05621420a800b00690db447fb7sm955816qvd.69.2024.03.14.14.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 14:14:40 -0700 (PDT)
Message-ID: <e33493aa-960a-4c0a-aad7-18c6426c143d@gmail.com>
Date: Thu, 14 Mar 2024 14:14:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 00/61] 6.7.10-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163236.613880-1-sashal@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 09:31, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.7.10 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:32:27 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.9
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


