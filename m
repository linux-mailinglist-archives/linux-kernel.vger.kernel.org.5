Return-Path: <linux-kernel+bounces-111976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C088738F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537E31F232C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC9676F1B;
	Fri, 22 Mar 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h6VAuxyq"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311583EA6F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134337; cv=none; b=DVUGtRO6ro+pUSkt/8eCuk4BoJ6hiQuHorixNtt8PvKW8iSq9XorViU1o+4QJjmvsDcgMAaApHviId+KdguJH3LPb8uoE15WxKkVquyvtC6Eh6qdmwF6D4vM6NCfONBxY6DqaJYmG99xuVs4raOZ2GRwvm0U/yEB9+LlhQmtx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134337; c=relaxed/simple;
	bh=C9oJwFIZ1oe+4/AgkgUGhFF5pFPrBfOvNgDiiaKFmQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FHna9L+5fW9M+I9dQdFNxH2F/KtIZmeLr5SmXN/Q2G60unV68MGjNMadjTYwMTbJqObjvy/5+nAgIMJbKmGL5iuKPmyXlj0NbYAb5/Ez4AvsjEofSn7sebQG/jE+0BLGew1gQvX3TEcDUa3djopF1tkhuUjTWmClbQzn8eCQWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h6VAuxyq; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-696609f5cf2so10750316d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711134334; x=1711739134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6WGCJ5v+lTsE9g6YW58u86G+mWvoH1YiexQxNMU+bg=;
        b=h6VAuxyqPy9RktM8F6yfOwHugT7MEG7gjtEOYYontrxHWZ54OApn3m629NbM054OSr
         B1/n5Z84qvW4idU4lBqTf5lb9mfLOt6js6C2lxqNGRAa7hqTK65ef3gCRlO5PkzGfsRP
         NTXc7fYCntN1xEFUqxA3gg2izm3uwpRFCpFl0sEhoR2VakyvqpEyyA3DwscPti/Lq+xe
         zHPdHYZsbkPAtr6MB3ybAHzgzwhJi/rwXF63sV/EK4hh+qewmoVgGiMBVeIlOcR6ecrG
         qpCotDMaMRQ7Y5H9tf25v9Ct+T6lV3QtEsPb/RmXo+tnRFVkIASk/XF0+Nq9uJjWz3ms
         pRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711134334; x=1711739134;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6WGCJ5v+lTsE9g6YW58u86G+mWvoH1YiexQxNMU+bg=;
        b=qPVxWz3uiUI1Jfn0jr47w6uKzpJ9ZA+65UjZoXwXI+oMbqbeX1nNal2q1F7TZMsYBp
         +vXjmM5e5CPYbllkty65pHtNIoSbzAx//dTiZFMRGI3+f5faEUlfiitKK0/J6MzAfouB
         FhyFISG7yIC/n83Wm34K6ZZgeNVLIXKPUT0CAucFm7bD8wViDMXdvFZxM9jRSWCNGAZq
         L942aMvlwjLtzBo+maLN0iLZhVMR5DkLxYb0TVelZQOd+rMd1mS2bIIEuJtT7ABIwbrL
         u5g3tYvNOSft6AkVTDH7EUYTM4vrPIlbMkXYVG7JUSj7U3i2swY63nvciinpbdkJ+hFb
         WVqw==
X-Forwarded-Encrypted: i=1; AJvYcCVpXGJmeLmJ02HUwsirmRn4pXRdAnp/a6LBT6R4QlY0OCxkDsEZhkCjc67YzjmM6uF6cq9vZZJ1ypG3XBkUuof6O87hLvXwC4xLPghJ
X-Gm-Message-State: AOJu0YyMHfan1TtmppMY+MeMKLj7mT/LGDt/WBhFU6mSNaz2O+D3QGDg
	dxN1WSwJmfIsD1iAi38CEGyAQ2btTqTjXJO/Uqe3aRMDzpv5BWXo/GYr/IkIqLkYbVpayn5PlgI
	5
X-Google-Smtp-Source: AGHT+IHQ5pFluRwp1jRQRBP0ScYuJl5DTFe5SBvmWRgRQLHsh0hGtceYDz92r8gVhFBKjlTPlcOqOw==
X-Received: by 2002:a05:6a21:2786:b0:1a3:6bd8:f487 with SMTP id rn6-20020a056a21278600b001a36bd8f487mr516475pzb.51.1711133871755;
        Fri, 22 Mar 2024 11:57:51 -0700 (PDT)
Received: from ?IPV6:2601:647:4180:9630::546? ([2601:647:4180:9630::546])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001dee9d80bdcsm70160pln.107.2024.03.22.11.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:57:51 -0700 (PDT)
Message-ID: <a4d340f0-960f-47bc-b45c-f89053526a22@rivosinc.com>
Date: Fri, 22 Mar 2024 11:57:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Improve sbi_ecall() code generation by reordering
 arguments
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240322112629.68170-1-alexghiti@rivosinc.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240322112629.68170-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 04:26, Alexandre Ghiti wrote:
> The sbi_ecall() function arguments are not in the same order as the
> ecall arguments, so we end up re-ordering the registers before the
> ecall which is useless and costly.
> 
> So simply reorder the arguments in the same way as expected by ecall.
> Instead of reordering directly the arguments of sbi_ecall(), use a proxy
> macro since the current ordering is more natural.
> 
> Before:
> 
> Dump of assembler code for function sbi_ecall:
>     0xffffffff800085e0 <+0>: add sp,sp,-32
>     0xffffffff800085e2 <+2>: sd s0,24(sp)
>     0xffffffff800085e4 <+4>: mv t1,a0
>     0xffffffff800085e6 <+6>: add s0,sp,32
>     0xffffffff800085e8 <+8>: mv t3,a1
>     0xffffffff800085ea <+10>: mv a0,a2
>     0xffffffff800085ec <+12>: mv a1,a3
>     0xffffffff800085ee <+14>: mv a2,a4
>     0xffffffff800085f0 <+16>: mv a3,a5
>     0xffffffff800085f2 <+18>: mv a4,a6
>     0xffffffff800085f4 <+20>: mv a5,a7
>     0xffffffff800085f6 <+22>: mv a6,t3
>     0xffffffff800085f8 <+24>: mv a7,t1
>     0xffffffff800085fa <+26>: ecall
>     0xffffffff800085fe <+30>: ld s0,24(sp)
>     0xffffffff80008600 <+32>: add sp,sp,32
>     0xffffffff80008602 <+34>: ret
> 
> After:
> 
> Dump of assembler code for function __sbi_ecall:
>     0xffffffff8000b6b2 <+0>:	add	sp,sp,-32
>     0xffffffff8000b6b4 <+2>:	sd	s0,24(sp)
>     0xffffffff8000b6b6 <+4>:	add	s0,sp,32
>     0xffffffff8000b6b8 <+6>:	ecall
>     0xffffffff8000b6bc <+10>:	ld	s0,24(sp)
>     0xffffffff8000b6be <+12>:	add	sp,sp,32
>     0xffffffff8000b6c0 <+14>:	ret
> 

Nice!

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   arch/riscv/include/asm/sbi.h | 10 ++++++----
>   arch/riscv/kernel/sbi.c      | 10 +++++-----
>   2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..9041b009d3b5 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -292,10 +292,12 @@ struct sbiret {
>   };
>   
>   void sbi_init(void);
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -			unsigned long arg1, unsigned long arg2,
> -			unsigned long arg3, unsigned long arg4,
> -			unsigned long arg5);
> +struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> +			  unsigned long arg2, unsigned long arg3,
> +			  unsigned long arg4, unsigned long arg5,
> +			  int fid, int ext);
> +#define sbi_ecall(e, f, a0, a1, a2, a3, a4, a5)	\
> +		__sbi_ecall(a0, a1, a2, a3, a4, a5, f, e)
>   
>   #ifdef CONFIG_RISCV_SBI_V01
>   void sbi_console_putchar(int ch);
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index e66e0999a800..5719fa03c3d1 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -24,10 +24,10 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
>   			   unsigned long start, unsigned long size,
>   			   unsigned long arg4, unsigned long arg5) __ro_after_init;
>   
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -			unsigned long arg1, unsigned long arg2,
> -			unsigned long arg3, unsigned long arg4,
> -			unsigned long arg5)
> +struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> +			  unsigned long arg2, unsigned long arg3,
> +			  unsigned long arg4, unsigned long arg5,
> +			  int fid, int ext)
>   {
>   	struct sbiret ret;
>   
> @@ -48,7 +48,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(sbi_ecall);
> +EXPORT_SYMBOL(__sbi_ecall);
>   
>   int sbi_err_map_linux_errno(int err)
>   {

Reviewed-by: Atish Patra <atishp@rivosinc.com>

