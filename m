Return-Path: <linux-kernel+bounces-156011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A188AFC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E42834F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21BB3EA95;
	Tue, 23 Apr 2024 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX2GRL2f"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CF18B04;
	Tue, 23 Apr 2024 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915152; cv=none; b=fg+RTvMPUMMw+AFoLGWtESEv9/la4yc80XzactmBDEI7/z6dFdoTDTwI/UWu5v80LuFLcit+J5DiCGgKa1ZIOxMLOisGLF9vmf1HQ4VdtOkcbGOPOswIOvq+X2I5ZYQJPwjovtlE6ukgZxyhfkv54/D0JGpoieWZdjVq94wquGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915152; c=relaxed/simple;
	bh=23hS/brzScawZeSs4fKtuEAynjjzvMh/uEnoc2P5GwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL5Fdycce8rReejVMCG+y1yFn8A6OtMf0LsNGFPRecoOtRVUMOktEHrxo2zBkoWtCWnYo+JgDOiljLDBB4sdXCELxtsi0f4cQYLSBoZHMtu73n/E5ACbmPLlbRtpMHDxRKW0TV+Zmv/j3Qvg8reRx3epoIdU1RObr1j++iOF4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX2GRL2f; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439656c1b3eso24165801cf.1;
        Tue, 23 Apr 2024 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713915148; x=1714519948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmXyH9dvxmCU3cg83hUuLVi3PIy6mOxfY3AEbqVj3JQ=;
        b=NX2GRL2fs+CMcu79f8uk09ZYZdudE9XbIseYd6TW35XNvUpqvFIK2M9aSbHOf7wZZK
         NqX0cxDn4UowaXnReBqxO7q4M64TSf+flBXM+I8JwczN5+GReoA0QRu3kZxW15J839rJ
         XpmOZCw5u069W9EQ+4iVgUftNjkzdLX56xy1IyM06AtK4hXike476lZsePDCcWdiqlXg
         d33vhDD8AsebuZd5b94mGiXBbVd3E16CVicB4MyYZ0IWMURZ0X1f+Ua36SaVATkxVy7u
         SIu37+CtVvnIR2tKScPK2qLWN0PwbngA03QjOqBkT7UkKCBOvV3anS+kJWehjgFuIonI
         ZAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713915148; x=1714519948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmXyH9dvxmCU3cg83hUuLVi3PIy6mOxfY3AEbqVj3JQ=;
        b=bwfAawtPxSlnMGOfYr8gKXYZYkjksw+hN7UvrfDRu9qHa+Tz69E27CtRZuOx+O2CLd
         ln2icgYSxZpAI1T9o4cYZ0D6fRM1ZE53nqv+bH4xA99YtWn1Noo0um+QFzKml5PqieXs
         gnlwHFwp88buq9x0mbazBPyIj5I4FqzFwh2ZifNL4l+Cma82vphov65pWF3Ta81wCsBQ
         AQfCKYMyFS8DguosUzaSyvpY+0u4Mqbb4NXk9hpfbaN3lDMTO6d/RTSzO+QA0sLcDOmb
         PyJg10VObchumuLgAslUkz688CX307yPIl2QpJb+1142VC6QpXh2mMg1HkhK3RuzhwrE
         c+2g==
X-Forwarded-Encrypted: i=1; AJvYcCV/iAxmBu7+TxtVm3sHaSplHKDcmnmVvalaPEUIqvVloAqkXr0JNUIgBTlOOuWwPPsdsDxgcmOIvGMNzIWM2P7a9OanmBmi61bzFjM4nzEw7rpvLIxhCh3JMEmd8RT1xkIlxxR1
X-Gm-Message-State: AOJu0YwjH2TAtGeVTKj8irPn6Vf7nQZm/DOMF+cgcy0ai63POXI5oLef
	nK99yqWHy+kgRrWlbvjjZRpM+1gg5l+PDLrSG4Art72+lltNyGhO
X-Google-Smtp-Source: AGHT+IEIcF45RXhALXWmglYUuAQPe/v3F5iDAqUKYfrtp96kJ8HQ44745LYH4NAQQPDcZT7LMAumjg==
X-Received: by 2002:a05:622a:5a0e:b0:43a:15c9:34b9 with SMTP id fy14-20020a05622a5a0e00b0043a15c934b9mr1058320qtb.28.1713915148115;
        Tue, 23 Apr 2024 16:32:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ic10-20020a05622a68ca00b00436510ddc5esm5588027qtb.34.2024.04.23.16.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 16:32:27 -0700 (PDT)
Message-ID: <79e05a74-0de6-48de-b570-cea567d9aca9@gmail.com>
Date: Tue, 23 Apr 2024 16:32:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213844.122920086@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 14:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


