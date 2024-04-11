Return-Path: <linux-kernel+bounces-141717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4A8A225D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE552B22D17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4B481DB;
	Thu, 11 Apr 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cguJLhq5"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241D45C14
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878702; cv=none; b=CX8/STtl7NzC85LsFdHkYIKipXRrD2StUAimnipzfcznHMpRlNz0ucMbsmo+95WrOIr8TT6FaRHRQAAhfyqcY0p2qIwarIT2ATrAW49pu/+LmaHpFKH7gWOUBXpDjOyZ13CNMeulOtefTWRRmQU8Rw60aWrdVnvxO2RpXc9wAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878702; c=relaxed/simple;
	bh=A5/2+I2e6Nc70pGxM00MEjaSowLN0ZxEDmyNCPx0VN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajBScrhKavpKzUkV5QhbGeSdFFQSkWo2poK+X9q/nam0Dn3jUg/M0TsLybbgOH9a2pEB8Qxv9bicdul0cLZDp2ABd9/CcT8UrePCvtOf9lC80B4Yqg+7Aj66A2iUtm9hg8lRlHmo9NhzUSriPWjTsL+HYUh8nyRZQuhNBZr+u/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cguJLhq5; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a29832cbdso511805ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712878699; x=1713483499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAzHKVIahMAAQYuXrEXLm3Ghx8zr2AF9oIEq5k/AJGk=;
        b=cguJLhq5RaG+VN10HZP1sxXs2UuAp2RTIx8A8q92nIfMIk25Y46WtkQnmk7yUBCKtx
         t8TUHzbN/iTniRrZmd6MTL1Qi+YSEm+/J6Z5fbEpsrAFDeJZLUkqRBz4binGqP6feQtV
         RiPjXx8vp4bR+lEG7kC4CaCx2xgvuGdGejQa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878699; x=1713483499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAzHKVIahMAAQYuXrEXLm3Ghx8zr2AF9oIEq5k/AJGk=;
        b=INj1fRSxphYklDgWItvsHFBykfX9Ex1A8u0BXKFxOyTxs2x9uCxtiqTRj5td5P7YYu
         A/4lAS1kBWKk1WpS5F9EJgxs5fVPh8uzEwFH4eOvocqNp5queztG5XgViyPLahLSjuNE
         V8VHec2hOiXygnUY83YVOAcpiiXQSbqkiqjJ/ITxOGiZny4rmRmM+WF2qXCjzUrFcFqS
         RYup0sZoO+x4fuwwGwUe3r0zmwgComUDrtEvLn7ObPSpYPx6GsfVAlkxEqmGCQdmqCUr
         dv2kmnyJwoazofDzsTmVX5SJD6lFjxZ1urjkdgxO6Je447gDfXdIEnl2aN900PyVWBns
         MnpA==
X-Forwarded-Encrypted: i=1; AJvYcCWKOxFpyjCVAbdFgTB3h8LxMC8lcYvcrJ8zkedEilODBYHDaVpRKSNa9DzdIUxj8DMgug35sa6oaahDIiglnGIQRLt2sSKn5sf+6nTa
X-Gm-Message-State: AOJu0Yzdk1gaey3u3YhMrC2P3KVnhzmV4sDSUtaslsjjpiYJ6Gyfp0nt
	84wrnVJpFaqtRm+wzH9umjOASz1M6JYQJSrAzTNmcJ+10zqve7EfByk02cnY2lY=
X-Google-Smtp-Source: AGHT+IGkHINz7dPYIPvNPoQg3hxjSUHSNt32HD/vaCd07WzPU0j6nBda9WqeCIZm5NUrqv1S6m3kRQ==
X-Received: by 2002:a05:6e02:c8f:b0:36a:f9aa:5757 with SMTP id b15-20020a056e020c8f00b0036af9aa5757mr1122549ile.2.1712878699144;
        Thu, 11 Apr 2024 16:38:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m17-20020a92d711000000b00369fb9df9fesm650283iln.8.2024.04.11.16.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:38:18 -0700 (PDT)
Message-ID: <f4255e0e-5b1a-4501-bc66-a47471f80c87@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:38:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


