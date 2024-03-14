Return-Path: <linux-kernel+bounces-103795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7A87C4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459D81F222AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641576417;
	Thu, 14 Mar 2024 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOxtBtYt"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DF76049;
	Thu, 14 Mar 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450800; cv=none; b=HcMflw6Ye34jV80jzo8Z6eoDbicFA5QEx/tcVDnkmwJWcTV91+K/4N11BAhj50u1uPKbwjBhUFQKcbHQj3qkyw6JLIpEVFJdIYfvE+RZZa6wrAdkXHwqz6gf3OejR+ByiZEC9Ztw5YTWYjBOosKxXtLWJig+ENq+6TeaSkxOMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450800; c=relaxed/simple;
	bh=GFr/S90szYQG2zf6ZPq88nO28LNGIy0tvdr1GazfT5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtHPyOTX+uCr/PuhDL5W7qj9Oi+fQtbs87bx7FFTZ9TuayemPqCrRxiOR8F6yWDbenFmmfCDUCP1P/xOv3RG3AYhUhghLSCBKfBh3NutN+y1qDoRqM2ZJ1nfjA4FCUienAK+M60YNk2jEoZFZTxjVXzBNLkRZEOpPqmdP26dNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOxtBtYt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690d75c73f4so8812196d6.2;
        Thu, 14 Mar 2024 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710450798; x=1711055598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrQJIovMot+Xn8+1lLqvjDrCoL0chwejNP1lQa4rfew=;
        b=KOxtBtYtKnWK7X7TmEjWKS4BDf0Y36CPAXIZCzg+p1Q7/KzNqpTEJue+jrXJd0/2YI
         GCFRnJNVccaKy9fhFS7fLg2dGyrRHiABLyUFtyBn3s0EQgJ63srRCDk1DPChWpT2F8Yz
         3Mdvg4KI6V9VxJyUT9+ogK9qV8icfB4ulSBjnbhLIZz1m16yHt9Iuj2C76uxnSYRbPw7
         Sgvo5kc+gCdHAesajz6I/9RvfdnIxX+4lhJ2r9R90M/XdbBMaF7dKPShhh/yQEml91Qw
         Eqs+HGRj+8RtjuXVGoLC0dZO+gNsTd8cZ+sIbqg57mv0HOxsyyPWJVoGSQ9OTSZ5fpCX
         K/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710450798; x=1711055598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrQJIovMot+Xn8+1lLqvjDrCoL0chwejNP1lQa4rfew=;
        b=r9LPq+F81iBL93yO7F468c4khTnmVHBz3BBN0uSwoYXavyjYqJFrDzl+0LZlHgHjtV
         Y4RDtAIP2oOJuXuwyM8GM/xtisYIB/TucTnRTPEvpGG8mmT2X+adQ1TwoD7FAHqshsvh
         4ltIqZLa/+I9O+czHOqDAXNL8csWoRdlTJdN5ixb6fjlSGeWWs30oUpr8e22RaU9wbMt
         rBaI5HK9vSk02vWKUMEWrMKM1K1iTDNqebXnPOYs9vnNFLtYPfxzHqse6BG1V16bU1ig
         jX1mQumx4Geq17k9HEWhALum5wJHK8159zzNRz4dUIOwbtLx6lA2F9XBncq7hnNiVw+M
         mP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKRFBmygLjVMgjqZq0pPYVCB8wwupxcniHbU1Pg8No5QNYltAvU7mcBcmCh0Z2K1kqVL1A9NHbK9jDPODcIUCxvzV4qzCSfLKtbZM4lMeFcz9EkztNWxSwKmbQNkRtYq/xNeyZ
X-Gm-Message-State: AOJu0Yyigy/C5nyB9qlnOhOcoWO2eY6+itT4QJaPMueVgSEpOLO3i06Y
	ZljiMrDjdVulv3tHyWKKtLAVwMdzTMjjm9BhVmNAIEDR/cUFkdvx
X-Google-Smtp-Source: AGHT+IFdeAoktNBjZwv8x/fbrsKUaoi598kLxmoeXmYXcV8dFLxRILytc4FgMYam4DK+fJsv2oQXjA==
X-Received: by 2002:a05:6214:972:b0:690:b256:4ec5 with SMTP id do18-20020a056214097200b00690b2564ec5mr2787996qvb.59.1710450797742;
        Thu, 14 Mar 2024 14:13:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 8-20020a05621420a800b00690db447fb7sm955816qvd.69.2024.03.14.14.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 14:13:17 -0700 (PDT)
Message-ID: <519cf5b9-2bc4-4f64-bd97-5531faba584c@gmail.com>
Date: Thu, 14 Mar 2024 14:13:14 -0700
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


