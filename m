Return-Path: <linux-kernel+bounces-141628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C58A20DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4628B230AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C438388;
	Thu, 11 Apr 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep75+e1B"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1339AF8;
	Thu, 11 Apr 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870808; cv=none; b=WxPZtJMObIjdcRKd7H+LusCpwPzgiZKqX5L0KbTISeDUpnssJDyFX4aV1QeDjhsS+KDoG37ea4IAMEfwQ84BEdXOUfh+qrIWHSLACBcoBGwPAkeuCDLRqlYUSb/QMkpGCwpx1cISGYEumNPr/cRUACoVplG6fOaSql1H1AW/kFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870808; c=relaxed/simple;
	bh=dTe7FkItBUZI1l41myPu0rwtwFhiq0cNM2woC0XI+Mc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sZN8JG8eYdbY0d3L16LF2jJur4SMML1QOCmB8uw/oFq/+kg0eTZJr8ef+9dB9nQbhBb15X868tNrrbm5+a4WRp4hJW0DRCzx2BoCXxMto/uKgXipZXLkQPTnMGMqt9mhQe6kuOBCFQCRYf5KNdsLc5/H4rVmOX+mv9jUNj2dfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep75+e1B; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso288114b3a.1;
        Thu, 11 Apr 2024 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712870805; x=1713475605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gbf/39brftwXwA8DEazWrbnV3/FuPWeJ2MAkVbGs5+I=;
        b=ep75+e1BoRH9qqzkgid7jyNQdsq9fmWeNPQ/PUQYupQHlFuxqzrAHGbdHuTJoqTfHy
         hX8/XX24Py5LGkB/kMOZlxzOBbmiP8hnG0Jm1Tvmpddw4c4n4n5VhExwVUBGfO6HQTZr
         JhWt+GNbsyYFz2vNMM29y9ifXjh+rbguZ48/9T/Ms5HVPAMusaZbIKukc6DRSz4irlDy
         sXuYtf75ErCsyo8Wbz6beOX07Cy6QSnMb9uRnfXHSS7lxP5MfTkPJ2hBll2zz0mMBAEN
         rm5LDwClWIyjgmUyk7CleSUQgN82cmWyye19DJo1Vsh1xAya9f/rMphZHVaA1tEgGpdX
         zM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712870805; x=1713475605;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gbf/39brftwXwA8DEazWrbnV3/FuPWeJ2MAkVbGs5+I=;
        b=v1APdmi1oSw8PhJLUD19QqgeDeJ+AfirLjpdQ7Q9nQHz4kKYckA7Hn+kOJXkMwhirQ
         8guX1XKvOfhsH5GKM95ETvdttMiYY89GFEIhkTB7AHl90vdW3lyHjIrGgvvtFiTKVe8/
         3nSGdyGBZJNUPNq1OaEqJjrh8UExeMP+eC8JNwP5yrzY4Ok3BZe1gLCnFEshVaR+VFEL
         iSXpR/w/NvIUiwrf3jZ2PVdDUEh39FiHbaGLEBTB1XXrdHBvQ6Aa9v7QFLU79RbFxxLS
         KAuGQOwIJgS9KxvB4G5Pnpn6gtRAkB4bEHpNsduIKNjaKYFkNM4AqDxpMXCbL5rLADPL
         A4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlEvz8dBliCoeHgz10GqVsVWk9cGmGXsSWU7nmRQOz4vgDgPD0ESWCybi6+E88WglmPLjfFGD2YHN41wasyqvQ2nzjY7IuwCxJNvRP0dpce5O9XnepNJZTWnhviCRx0fH6wNR7
X-Gm-Message-State: AOJu0Yya5p9NMLyua5vPWYJ6aHXJwc7u3cHOlbNrtuj1mrOmlhLTEZj3
	8oM/4japPRRJ6mGw4N2ZcUW/zaSmSsaEVRg47I4ef7/eDoih8bcH
X-Google-Smtp-Source: AGHT+IFEjsGMBmJN6OEXD5BFBpztYTefinZEo8eD5PTbhOvhMO1g6CNKipz396gcfmsNN60L1LKe1A==
X-Received: by 2002:a05:6a20:de91:b0:1a3:ae12:e610 with SMTP id la17-20020a056a20de9100b001a3ae12e610mr1003741pzb.35.1712870805378;
        Thu, 11 Apr 2024 14:26:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u32-20020a056a0009a000b006eaf43bbcb5sm1614913pfg.114.2024.04.11.14.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:26:44 -0700 (PDT)
Message-ID: <4f1d0cc5-6673-48bf-be4b-7b7978cabddb@gmail.com>
Date: Thu, 11 Apr 2024 14:26:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095435.633465671@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 02:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.215 release.
> There are 294 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.215-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


