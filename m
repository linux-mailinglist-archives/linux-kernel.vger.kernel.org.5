Return-Path: <linux-kernel+bounces-117619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2588AD53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7389B3623BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871A12838F;
	Mon, 25 Mar 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gY5iRAbU"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14867548F5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388633; cv=none; b=HjfItByhE7thoL5lz3NSU/OhIAEfKOacLItl7YfzM5dSH86cWuK7UoevubhGKAtrdAQ7cYItooqmF2nSyYACpjYU/yKXv843O3aORdntN8qmNp0SvsbsyQF5QHRTXJ6DfxUW8hAVBx5mc1xm/C4G/2SVkcoHCYZR3dJyJzCwpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388633; c=relaxed/simple;
	bh=7YJ8xLb1+mdXej6sC8h+bM6GjrVQfPa+4fUIfZlmK8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cILvcf19zmOKInzmZMGv8TlYd9jiAFFuLpg0oh4iP1AT7nxtXI0rq/0dY8stlbo0sMluSy4E1vU47g4FRybE9UuJ0IrzDoatAVeDsRWN+LJJMrEIGivpxdLfxMkPTfpBJyEeSfZUOkTxZ5kBbZ6eX1GB/1nAWo7mZNiFZReDY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gY5iRAbU; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6b01c3dc3so2737332a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711388631; x=1711993431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBroIUnK/6NwPBkeGi/EpBPRMqiGdh9Ka1UHUq5GsTE=;
        b=gY5iRAbU/3rDcFV/yfxjXds4nlsCEZDpL5fP22Zkn+PtH7QDbT5m6bI6dnJXkbu+0q
         A+ATHP5OMurxQAwnbPOHhlZuPH5gE1RaTejMxIISLkusy1Hl8p+hvbYf5kHrENxgGXh0
         a3q/9CzTnXgLO3Ock7uaB3EpU+2ytlbsQNgeJp8QWK9M+2gqNwSf8AvzWSd4TLY3WMIl
         XQXSJ6XgKM1xrQKDuDl+Wx/WdkV0uYBYS41KiU5upAjFxqdmSHZjzk4w9+9XUNZz58kH
         WM0hSXNrCqLtHH/Y0O8DKZnnVGR2qcpQbrIX8okVH4/CjrrsIH+cxVHUwYftZW1MxTtp
         CMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388631; x=1711993431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBroIUnK/6NwPBkeGi/EpBPRMqiGdh9Ka1UHUq5GsTE=;
        b=unqaOVHR2z3z5UCYzNVtwXw5XboLWk2GlX1TX0wvsYBNS4HWC/GLCYCYJ1JcC+m9gX
         9hyM75YNAMO3KQnU3nw8QiLIw4ostkwJVTGttepiJIgYoPUESNaMkbgYPYkJkCUwzmOc
         SMeg7VlEf0pGKmipaGaOJ7d68NQV+SApfpYB85DYbPuiC5dA+XMGF5+QZfEUj1JzBMOc
         JYBJmoEJ5Wq3Vk9m4LmvUNNN5lD2QzZIbzVBKQDLdtwspGPuGkDIXv2i3qBdYX+mn3F0
         Mom7Q7IQQUQ8tW9QbrHfZ42NYDa0CHvnfIfW1xA6UK2Wu1mwWxv4CkKH45OZSMPv/U1p
         rzVg==
X-Forwarded-Encrypted: i=1; AJvYcCWD0pCL9Pu9autTysXJ8VaHefrx6DzkHD1vVPpX5vraIOXcV+2wfA0W2+g+qA6m6w3m93RJLHVu31G6c5t3Qp1MKJKqZLRsCQJ1PWVJ
X-Gm-Message-State: AOJu0YyqWI2uzm5Q4ijPGb1BBSlIQ/oEpxtDSI9Ccg64j5TAFEbpGWma
	Px5zJnzdC3UjUlljnO00PjPM2mWoguszvh/tMpalGuWLTMfqU8RIHCKHNXrigeY=
X-Google-Smtp-Source: AGHT+IEOjTDCJtTUMROYN/GXr/M9nKUsy9+AuRcx+ouebVC3sCr8Xdg+0PuDiib3kTsRF6Dd2i9zDg==
X-Received: by 2002:a9d:4e8c:0:b0:6e6:a2ea:5488 with SMTP id v12-20020a9d4e8c000000b006e6a2ea5488mr9488667otk.35.1711388631136;
        Mon, 25 Mar 2024 10:43:51 -0700 (PDT)
Received: from [192.168.17.16] ([148.222.132.226])
        by smtp.gmail.com with ESMTPSA id v20-20020a056830141400b006e6e348aa86sm111815otp.41.2024.03.25.10.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:43:50 -0700 (PDT)
Message-ID: <56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.org>
Date: Mon, 25 Mar 2024 11:43:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 samitolvanen@google.com
References: <20240325120003.1767691-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 25/03/24 6:00 a. m., Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

We see *lots* of new warnings in RISC-V with Clang 17. Here's one:

-----8<-----
   /builds/linux/mm/oom_kill.c:1195:1: warning: unused function '___se_sys_process_mrelease' [-Wunused-function]
    1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /builds/linux/include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE2'
     221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /builds/linux/include/linux/syscalls.h:231:2: note: expanded from macro 'SYSCALL_DEFINEx'
     231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:81:2: note: expanded from macro '__SYSCALL_DEFINEx'
      81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)                         \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:40:14: note: expanded from macro '__SYSCALL_SE_DEFINEx'
      40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
         |                     ^~~~~~~~~~~~~~~~~~~~
   <scratch space>:30:1: note: expanded from here
      30 | ___se_sys_process_mrelease
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.
----->8-----

Bisection points to:

   commit 9b4a60bd0b1fa521e786c809ec8815291f150c47
   Author: Sami Tolvanen <samitolvanen@google.com>
   Date:   Mon Mar 11 19:31:44 2024 +0000

       riscv: Fix syscall wrapper for >word-size arguments
       
       [ Upstream commit a9ad73295cc1e3af0253eee7d08943b2419444c4 ]

Reverting that patch makes the (300+) warnings disappear.

Reproducer:

   tuxmake --runtime podman --target-arch riscv --toolchain clang-17 --kconfig allnoconfig --kconfig-add rv32_defconfig LLVM=1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


