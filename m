Return-Path: <linux-kernel+bounces-73832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D944885CC27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B14284723
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934E154C04;
	Tue, 20 Feb 2024 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jgZxWmHV"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509B40BFD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472581; cv=none; b=i75ZHeOBgNqxIGJ4Hw8MMe+UwAKTHHb/Q4D3ikxFTzcYvFMhaC0cb8JPLmeLBXJnA+dajhOF6Wx/lzr0h4TJ2aFFfdZWspqYIlbmdoJ1vnGrkiIWuxqs0UskT4uKlHWkBTiOhDp1cipALsxs3hKq3GNjMruvvWDtVSwBtGdlDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472581; c=relaxed/simple;
	bh=7jqO1lHIVsE5d+e0YtanS1tzyQWv/2YIqeBJHjsSe8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci1ldkZnz2/6gH1cw1Llol6RhqakPZeaN2QKk3rDcNwtXPgdEJOPMVcgp6GrRp98RryPozHVEz2raXNqgQy/PEPR3EZEI7b+FIL6ii6XmdGneCNPtPm9Wn2YfHLdrbk0sSWM+iEy59NMJbvr/f1LRvggG0PK93xG34gG8MqR5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jgZxWmHV; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6bcc78so4521510b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708472577; x=1709077377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUPZxx4yc0Fym2aKmm76DxOfwl43+C+AKFEvJFvt0CE=;
        b=jgZxWmHVx6coL9tdqlJp3iqFiVJbgQWwli+Fr2EeoFsjmse3rPqDWcnl2UU42Hz+9D
         kEbWm3oCzZ2GX1kEkt4Cn0BBkuu6C7rgOOSGK9LhrwFDpdRRfpXubxCH/DLw0P14T2Ia
         AXXuQBcnQQtFboeMKICzNo11svf9xEYF0rD/mX0V9WIj3Rk3Ua0+kx4B5nqyhOqXs4MC
         axjcN4x5RcKuS7CHvf5zEjHwyFzTPlgcOlmw4rC0mJNf9nDYmsO7uCCYWtX1RoT1QZmu
         TIcqtmn+T80pU+N/e6lHZwVvuQyy0Gg7/cRgbVkWzV9m0i0uTpRZ60xGxhTM4DokvfQf
         lDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708472577; x=1709077377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUPZxx4yc0Fym2aKmm76DxOfwl43+C+AKFEvJFvt0CE=;
        b=Kk+lw7zsPGkDTOdrFd1WomVpQnwqEaj/Nue8d+zDhiQC+AXbG7PYwa6u61ObFqy8so
         m69yUsbnIY412hJsQZyiLnsZ0Wk3ELCYGqT94Obcte4D7nMWNLybIPvap8efV00ZOCJ+
         Af/a+Fz+934FdGkAH9K0nehUKKPuMmomeyANthNwhmxlirRtn3UhoZ8ENA0Jjr60SmwR
         o7D0sFvpy7jFFzalVP6/BWLvTTnU2zwsgILwsIIBy5QqVSP+Rqtlb6fj4lUZW9IDlMQ5
         LDVSRgCzM4nTN1R2ztdVIXH6D9waHMkE3Tdk36CpGRXFSMh3plVMb53FN6BW2UBuv7mL
         hQeg==
X-Forwarded-Encrypted: i=1; AJvYcCXAfh1i97jClg485h1vhy9EWgJO/5w0D82PF2XBXfPY/EV6Mr8DHqqRo6p0Teb0tS5aEPV6BJE1jaqarV9iGisGbqOKm4cLZhSYQncf
X-Gm-Message-State: AOJu0YzzZDqLbkgYtDrTuq2aiH3j9PbUh34mHXN1zMzNSmBmokpsZ4a1
	quDrXtFj/H8BHgr8FjfYpJ3qs7JQGEpUb4P2wrqiguHmwEsyu//vlOAu6SJCtiM=
X-Google-Smtp-Source: AGHT+IGB8ll+ozYI3O381NSidlwWWtxrXnCXwOmpDex8sV8coE6I7gWpQPn7NnyYF6GY6vUHK3eedA==
X-Received: by 2002:a05:6808:2f11:b0:3c1:5d20:179b with SMTP id gu17-20020a0568082f1100b003c15d20179bmr8468422oib.9.1708472576861;
        Tue, 20 Feb 2024 15:42:56 -0800 (PST)
Received: from [10.0.16.226] ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id o19-20020a637313000000b005dbed0ffb10sm7179064pgc.83.2024.02.20.15.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:42:56 -0800 (PST)
Message-ID: <3cd9c332-1187-4204-94c9-34a3c4f5958c@rivosinc.com>
Date: Tue, 20 Feb 2024 15:42:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: hwprobe: export Zihintpause ISA extension
Content-Language: en-US
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Robbin Ehn <rehn@rivosinc.com>
References: <20240219154905.528301-1-cleger@rivosinc.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240219154905.528301-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/24 07:49, Clément Léger wrote:
> Export the Zihintpause ISA extension through hwprobe which allows using
> "pause" instructions. Some userspace applications (OpenJDK for
> instance) uses this to handle some locking back-off.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
>   Documentation/arch/riscv/hwprobe.rst  | 4 ++++
>   arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>   arch/riscv/kernel/sys_hwprobe.c       | 1 +
>   3 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index b2bcc9eed9aa..0012c8433613 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -188,6 +188,10 @@ The following keys are defined:
>          manual starting from commit 95cf1f9 ("Add changes requested by Ved
>          during signoff")
>   
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extension is
> +       supported as defined in the RISC-V ISA manual starting from commit commit
> +       d8ab5c78c207 ("Zihintpause is ratified").
> +
>   * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
>     information about the selected set of processors.
>   
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 9f2a8e3ff204..31c570cbd1c5 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -59,6 +59,7 @@ struct riscv_hwprobe {
>   #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
>   #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
>   #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
> +#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
>   #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>   #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>   #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index a7c56b41efd2..1008d25880e1 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -111,6 +111,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>   		EXT_KEY(ZTSO);
>   		EXT_KEY(ZACAS);
>   		EXT_KEY(ZICOND);
> +		EXT_KEY(ZIHINTPAUSE);
>   
>   		if (has_vector()) {
>   			EXT_KEY(ZVBB);

Reviewed-by: Atish Patra <atishp@rivosinc.com>



