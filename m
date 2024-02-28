Return-Path: <linux-kernel+bounces-85400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB686B564
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7C9289D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54815DBCA;
	Wed, 28 Feb 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fUc750sA"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6799208B2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139450; cv=none; b=H0vigzxKbvfFDxqsJLGL/CyC0e+ZG7VStBYTvkR0MOklSVfPYv8v+O0Hq5JygVm5ALiQ5sBOOpBEszG4ez041I2wJ0897oA+I/IiWwYgNvY5aUqobEIYmE3Silc6SUwqm/KLSpwv3oemIE+IInwrmaYV8OeOU+Hq9uDRCqeN4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139450; c=relaxed/simple;
	bh=/2Azqu1VyiRaiAF7AA3juHS2VEk/q1WqTNt34zVPHsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k99axeuODL+cupU1P8GNPLP8JXFJe5FB87qhOdhuqwDimsGDkWIou+VrnDZWm5723nDjZ0x7QfbqiAvR0ExGvw34US5MACRnc3WQ+KjgMaolw+jQDDYjrBmIcRdipezhSjgEUp5rK0kAqT2c6u/ifp6TULA7mYn3nXon20XfTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fUc750sA; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so57237239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709139447; x=1709744247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNUHzB6bTR8lkrQrwB9JvKFIHk8OQ9UNvaD+yVEbMY0=;
        b=fUc750sAFxkfAwL2xCN8vk2E3aaNJkHVaqoP4wIew8jDZ0K82+NmNHjhneAKgIoamY
         cNgfN5dc0PnWnLchxYWNszlUpc280bk5g250901utF8NBer/j/bmcoRyjdTCvIOx1zor
         dzRnkIdkqos/pObvqOt73+0+PYIKkI4YHHWHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139447; x=1709744247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNUHzB6bTR8lkrQrwB9JvKFIHk8OQ9UNvaD+yVEbMY0=;
        b=SyilFU1gRuWT2+Kj1CeGMH74wwFZEJdROfiJ+C/XkbzmOFQz5PjV8Fal6j9xQM+EOq
         VddBjts9YBCkYLoQno20mj8QSWEOPlHygza4J9bU4eukY1VJS6KNyMqpmXxKFRHE6rdx
         2FTn4fDcurWeM40+aflvdcrKCqAD0lQMycZPDbXCuQS029BwfMUOjuSc7wbO32bQ9rqk
         w/ppHCWqFObk4hz/QsC/x1P+yL10Szv0LsqYztduHzbbhXdQLQUA03gVZo+MK+35OaMk
         BMX8pLJS9jcRQJGbDI0ruZoPFitzqGiP1m/HyirxWdU071x0Ivoif3D0tnZ5DZvmdi53
         l+0g==
X-Forwarded-Encrypted: i=1; AJvYcCVBn6XszqmujLdOGGWNmoJxVzL1Fc++ijuk/0Uw6bjoZvjNJnGc4x1YubyWKlxbekqEHU/BO9GG5bL3cd3x0RF5TXYlg0awP7yBljIh
X-Gm-Message-State: AOJu0YzxPyUUG4eV4xbZRrTrREV1F1XGEbUMBWpWfFj7sU8Qh8FLYmrC
	O/8bpEmjdzKCM8lvbUWuwut2aCKn4Qla9ne14Er63/atp5mD7VVypHy4RC+wOhk=
X-Google-Smtp-Source: AGHT+IEYqpBKyp8I8JnTiZT8VG1R5X6EV3Xdx0Ok2vStet+qqfgqgLz4QUj/IMZf8xcfL3JAP7OUlQ==
X-Received: by 2002:a92:cda6:0:b0:365:4e45:33ad with SMTP id g6-20020a92cda6000000b003654e4533admr12522573ild.1.1709139446863;
        Wed, 28 Feb 2024 08:57:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bn29-20020a056e02339d00b0036533cae5afsm623565ilb.60.2024.02.28.08.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:57:26 -0800 (PST)
Message-ID: <fa711f78-98b0-48a3-95cf-594ff41e0998@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/84] 5.4.270-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.270 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.270-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

