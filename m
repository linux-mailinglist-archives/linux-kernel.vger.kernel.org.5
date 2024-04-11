Return-Path: <linux-kernel+bounces-141719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF78A2263
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA21F22DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8EA482ED;
	Thu, 11 Apr 2024 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z0KaXxnK"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F05481D0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878802; cv=none; b=l8Adr30xfLsIHvrf1Yd6I6AChYNHStmnZPGSUqpIWVgraN6kxnNaM4XE3gv2plAPrZQ48Qi4nZN8VNPWapmtC9kPaFCRicYZ0d+D2cO9DteqWqKvtmE8BvOVRARpy+Tr2dfMhzgKqvUo436+Sjh1n2zN+CrHz678nkgq0DxtNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878802; c=relaxed/simple;
	bh=3JWDnoDfMPkjhXx88KBMxUpX/9HZtRbJH9rKO+JRuxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQYUjr28RsAzXdHj60IAN1BY0N72WbDdhmsqW0yXxBh7q/n48mdB0xjphiNDH8rwVqZfW4rh85dE4l90u+bXz6JzgMNY7GxCdmsUZB4oy4rIh2SGOCN150tMcvOv8XEuehZIWVT8mWkS8DXMs2SvJ4arqscYsLVYIIyw6F/Yaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z0KaXxnK; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso7781439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712878799; x=1713483599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hc/GAob5w76tlQZgUUc4pUFMO+5LudlrplUXRVaDAdE=;
        b=Z0KaXxnKhit9y80K2KCeHCUzQOUtOaA9pIiegoC8chHHsSkOgoKsd5gU4xHtOPhjcv
         yWArSrxsOZoMYME6Bi4lM3AVGxIeBVa6Fq7wwZUUGvl7yEcL9c0nNXAFagkbQ9cyYeAn
         +0CSQC4Ku8ZmPckirHPe39CjdLjvkTT7JHoRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878799; x=1713483599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc/GAob5w76tlQZgUUc4pUFMO+5LudlrplUXRVaDAdE=;
        b=Q0jAPa/U/dQwjrm8eqBiRPa5oXYim/WYj+llLZExDMWaokqBA0pMs2Z1kdtLbsEdus
         1FzJav5Y5McvqtymZcvykwA50bbfTDl92iPlM7R8QCQQFgMqhT21uFgsbDunljCIr/t2
         B99qxM/YcWNunO2GRqAlhOKPNjrm12JowDYMMz3XJ9eKpeVYK6Y2+gd8hSQd8JSIEbzW
         dYeS/cyBexVjpA7WGRq2PcnyV4wqp5uTMI3Tox28r8s7wE5nV76baFBjGNrjmcZd5S1x
         FR3VZBT9HUZ/ASNNQdSkODq08UWBDxUfGlpzOjJPqK0Rcs8fnggGrxeZmD+sybVTrlXp
         oIVA==
X-Forwarded-Encrypted: i=1; AJvYcCXMGwM5x0IwhuraI/Q9x8ft6pAl8hfWLUoCxkQFsy753Dw3EiqA2gtT8cQqQBJnMzcK1Q+7ZconEAyUQ0iYJQxAjoMqt7LuJKdgzepV
X-Gm-Message-State: AOJu0YwpChURulvyxAZkLEWm0320go+v3TYRlIYBKnsVkNaszoJ7tfpM
	kLd/EsolNHaNEUj+TbJgB9hJ5M8RWQZqY/56b8VBIjDFXy6BIbkgF4vZEJZU0To=
X-Google-Smtp-Source: AGHT+IHeqyhkA1lLsoFAE0ibKpNUK+X0VssnmLz1GgchJ8SMV8YCLDXLuO55xm6rUMnlvE7Fyq1z/g==
X-Received: by 2002:a05:6602:2cc6:b0:7d6:a792:3e32 with SMTP id j6-20020a0566022cc600b007d6a7923e32mr599539iow.1.1712878799132;
        Thu, 11 Apr 2024 16:39:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g6-20020a05663816c600b004828703cf44sm672846jat.95.2024.04.11.16.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:39:58 -0700 (PDT)
Message-ID: <f571fca0-ec78-464b-a42e-69ceae0b0860@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:39:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

