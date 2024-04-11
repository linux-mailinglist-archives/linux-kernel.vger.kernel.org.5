Return-Path: <linux-kernel+bounces-141726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5541D8A229C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E984E1F232BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E022D4AEEA;
	Thu, 11 Apr 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GxmSpXlm"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BE481C2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879478; cv=none; b=bZDpZ3g8gda1bx1ocv8rhT2aTJxNrT32aklG80mR5SpQ9pxHnWx493fL557/442Vub9Cvf4ghqiWjRGbuY0NxOK0zUqQ7UKgqAKZ/MmD4DlutfYx5xFFiUE8OjezGZlwvE9hUzMI8h0LmjDFJLxAxRYGjMv4fwxroQa9UFDebJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879478; c=relaxed/simple;
	bh=5n/c10tZw8i8ramDDL8gGaAfX2dPojeKb0kPmPkSSRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4hmBcpJ4cfuvTECHwhyxIJXTUipnxdQ6qIGhMQD1c5qtdkfKhPvTeGC5mo1i2Trv+d+CXrzd2eB7QiyBM3pdboTn2Fvjd5HOC5adq3Whn2ckISq9LiVwqlMvv3Sa7k0smjZZRQqGOZ/DamAtOkZch6TRlxUNc4rKVoKicvH+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GxmSpXlm; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a1c0bf9faso296445ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712879476; x=1713484276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTOuSbb8hB+vYzGueSyEZMnAtdrSDuj/9HdWkOKBA30=;
        b=GxmSpXlm5JWGeS61UaT5VjpJFM7Dr/iTtUJgdr0aGjKIE7rRqt2F53hC1NxEuhFDN7
         1aayl2Fe13Pr9TcXVnUCH0UxawBEOUUgVwlJyN+0uoNGiOrbcXItwsHVrWrHQ339Nqx7
         Ss0T6v8vYFxj/vz0+s9Qe7PapOpy5iojZv4rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712879476; x=1713484276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTOuSbb8hB+vYzGueSyEZMnAtdrSDuj/9HdWkOKBA30=;
        b=LFzTYlIWrRKPzd3SCyLU/NyhmlwV1dZv0pkCaLTMt7/tmpGni4l5sm3TOEVga0m2im
         0oV1+rcqUDBKEt0EnlmkiT6yeQA6Yw/jelYMX9RsP7J5nsRnIu1RsyxvZn6PXz47eSYw
         7klDXKkE+IlW3iOLV+fs/Ml8pLF6bBACOob+RQzR4Jk6U7/JLSsemxjb/w/FmFhXC4Kb
         kZA4jLX1RHyQvXB5rU5btRz6TzNwde9CLW+d+48z4/ArMS0/N7MKCV7L2urJf8Pj9lqC
         3fhbwq+JiBGcKqNY7OpW66AfJv1WIZom928mWON5c14FeC8c/MpIqVt136J3Z7I5VQ8F
         XEbw==
X-Forwarded-Encrypted: i=1; AJvYcCVD5C0EM8bPggu3IYCIloJ3sfJ78qy10fvoLyaXhBBMmFhjfDJBejiPYlV76Bs0EcI91+F+YxYfb5R2M75Xh/K88e9vcS25jvhVVDw2
X-Gm-Message-State: AOJu0YznXX5rQrEg3omLrFiVlMkEzjvyyNYkM5fXrb2Meyv7SR5f/ipH
	QCoO0j4m0JJg8Ns2I6zC9shUMmGHWgybaUI5l4SHtkQlGeiKYLBZLhvsbaWAnqw=
X-Google-Smtp-Source: AGHT+IELDyd3FIIEpM35tZjAK3mc3g8KNLKNwq9rZRUw1w9eybeYd4+fTEfh95HgJWqypKO3mqmkXw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr1352400ioh.1.1712879476075;
        Thu, 11 Apr 2024 16:51:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id is13-20020a056638850d00b004829581b0d4sm680676jab.111.2024.04.11.16.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:51:15 -0700 (PDT)
Message-ID: <2fc1e5fa-07ef-4045-ae31-654a14844efa@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:51:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.274-rc1.gz
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

