Return-Path: <linux-kernel+bounces-99769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12843878D01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58734282BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B46FC5;
	Tue, 12 Mar 2024 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jS3BWCrH"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB217F7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210666; cv=none; b=lMI4qYX1eVe00+nm/qUjceqJ2lqBOVXKBus49/jnHY+CUcu5HVHqPFOaRh/O/l0/OTXfhPuSVvN8F42SnlYGrLQ+rLWzzHN2Q2nwny8ImCrtxZx8zj15MYpwm4u4RPNbBhrAaljz96SgqCm14ILV61U8f+xfh94sunksqqa2dxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210666; c=relaxed/simple;
	bh=Jp4oGdEKemG1pRpVyq3OL4lJnQ8GpDIBUxxHSm5gwbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkZ7jQTLsqke/Hu9lzbowR43zxxXmjVB/N0F0Y1yPRYfhl6S4yF370j6VbgHLyD5wFCqzg3GM1ONLpGoweIpNDxxb+oRc3++14d8JhplnYsBdIBGGjeVpZtSSeA6qhe3FoMkaVTnjIBElNRXsc+eueo9QdtAPXGXuvnizIMhZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jS3BWCrH; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690b8788b12so26761416d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710210663; x=1710815463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5OTy+HMNxO2KNNfosD/+LOKbpZJTKz1P/Ivks1Gea8=;
        b=jS3BWCrHA9bnKRyoo45I5We6Z0e285kjMHarkPQdWvec0vXqyXaq5sGLAlbybvOFrU
         eTseKEgZEFEkO3ASqm0DMoXPfEBh9CHSlVqc0+xc/19LVseQfyTp90+miRgoT6YU6dmj
         CXQ42k4/Ilm525eCWgEqDQ/oc5TIPV7dU31tGEanyZXS6GgoZsm6QzschCxYPbdOXLv9
         dg8nUOr2iui/644uJrMy56Ff49t3TLCUe1qCmzC8R5qrPIUWmdx/uYfrBawOG4kWPGs6
         6x5IqsbfYUGk5rybm94knP9PEuUCnYpx2dfzixmh/cOp+Wq2ZpW3JPljVNG5GOXVTYB9
         xnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710210663; x=1710815463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5OTy+HMNxO2KNNfosD/+LOKbpZJTKz1P/Ivks1Gea8=;
        b=cO99xmuvGDs3GT8VCTv/1GwU0LV1LkhJnu2sSN2R7mCBbidyOKQMdmO7+yUoeVVgOO
         ZWYM63Hfl1E6Xa/QReHYH2jLXQDPS6Y4rz+iaPTgbruNuoqnURQoj4BP/DDk4032EmYl
         yVpTZjwmjxLupg4Vm99le7lUzBUr36/7CzxyMym7tFOPHG76CF7Q+vUCtTZouM+ZAT1n
         In7hNiqgDRxbzftWFpIZqeYBAcMYEuXKiSbOOPUt+CAWdWDQEaJJn87Lrwig/0dBRTLY
         8uxPX/wEmvbYKHRy+YOAn1SJGTvRd49oj/ETjpS8P81GfmZOrZdojMcmVU/z3ee5iU15
         dxXg==
X-Forwarded-Encrypted: i=1; AJvYcCVGIMaDNpUe3QivcygPAIj2thnQztsIKwXUs44M30xOK2C9Noy7aFkHpaGsoOukjQRGRGP0kuM/zGb1X/KQbKsTXJ+4ZUgjry+GDmtR
X-Gm-Message-State: AOJu0Yydzy3fbHWh1lG3aLupKOaCCJ17eMEV3Zvfw6lyTwBuKYjGFrif
	gdyft1utPnqRdefN5RLPpZ0MIwLkZMehmDv+UdKDhQkRgR/iROKp0Gjd20vbzFs=
X-Google-Smtp-Source: AGHT+IE3jUExO30zal8fm27lYAMbEGlk4X8+tg7va5ZCzdoLMgtsJSDXPNSw5kv5bL+JTt8cVDV4YA==
X-Received: by 2002:ad4:40ca:0:b0:690:7928:87bf with SMTP id x10-20020ad440ca000000b00690792887bfmr8724160qvp.22.1710210663622;
        Mon, 11 Mar 2024 19:31:03 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id qh6-20020a0562144c0600b0069049298fccsm3196085qvb.65.2024.03.11.19.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 19:31:03 -0700 (PDT)
Message-ID: <2d4eac35-26f8-484e-9994-2167f0bbec33@sifive.com>
Date: Mon, 11 Mar 2024 21:31:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] riscv: Use Kconfig to set unaligned access speed
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Eric Biggers <ebiggers@kernel.org>, Elliot Berman
 <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-03-08 12:25 PM, Charlie Jenkins wrote:
> If the hardware unaligned access speed is known at compile time, it is
> possible to avoid running the unaligned access speed probe to speedup
> boot-time.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v9:
> - Clarify wording for RISCV_MISALIGNED Kconfig option
> - Link to v8: https://lore.kernel.org/r/20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com
> 
> Changes in v8:
> - Minor commit message changes (Conor)
> - Clean up hwprobe_misaligned() (Conor)
> - Link to v7: https://lore.kernel.org/r/20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com
> 
> Changes in v7:
> - Fix check_unaligned_access_emulated_all_cpus to return false when any
>   cpu has emulated accesses
> - Fix wording in Kconfig (Conor)
> - Link to v6: https://lore.kernel.org/r/20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com
> 
> Changes in v6:
> - Consolidate Kconfig into 4 options (probe, emulated, slow,
>   efficient)
> - Change the behavior of "emulated" to allow hwprobe to return "slow" if
>   unaligned accesses are not emulated by the kernel
> - With this consolidation, check_unaligned_access_emulated is able to be
>   moved back into the original file (traps_misaligned.c)
> - Link to v5: https://lore.kernel.org/r/20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com
> 
> Changes in v5:
> - Clarify Kconfig options from Conor's feedback
> - Use "unaligned" instead of "misaligned" in introduced file/function.
>   This is a bit hard to standardize because the riscv manual says
>   "misaligned" but the existing Linux configs say "unaligned".
> - Link to v4: https://lore.kernel.org/r/20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com
> 
> Changes in v4:
> - Add additional Kconfig options for the other unaligned access speeds
> - Link to v3: https://lore.kernel.org/r/20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com
> 
> Changes in v3:
> - Revert change to csum (Eric)
> - Change ifndefs for ifdefs (Eric)
> - Change config in Makefile (Elliot/Eric)
> - Link to v2: https://lore.kernel.org/r/20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com
> 
> Changes in v2:
> - Move around definitions to reduce ifdefs (Clément)
> - Make RISCV_MISALIGNED depend on !HAVE_EFFICIENT_UNALIGNED_ACCESS
>   (Clément)
> - Link to v1: https://lore.kernel.org/r/20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com
> 
> ---
> Charlie Jenkins (4):
>       riscv: lib: Introduce has_fast_unaligned_access()
>       riscv: Only check online cpus for emulated accesses
>       riscv: Decouple emulated unaligned accesses from access speed
>       riscv: Set unaligned access speed at compile time
> 
>  arch/riscv/Kconfig                         |  58 ++++--
>  arch/riscv/include/asm/cpufeature.h        |  31 ++--
>  arch/riscv/kernel/Makefile                 |   4 +-
>  arch/riscv/kernel/cpufeature.c             | 255 --------------------------
>  arch/riscv/kernel/sys_hwprobe.c            |  13 ++
>  arch/riscv/kernel/traps_misaligned.c       |  17 +-
>  arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
>  arch/riscv/lib/csum.c                      |   7 +-
>  8 files changed, 374 insertions(+), 293 deletions(-)

With the fix from [1] applied:

Tested-by: Samuel Holland <samuel.holland@sifive.com>

in all four configurations.

[1]: https://lore.kernel.org/linux-riscv/20240312022030.320789-1-samuel.holland@sifive.com/

> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240131-disable_misaligned_probe_config-043aea375f93


