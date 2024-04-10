Return-Path: <linux-kernel+bounces-138498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4989F24B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57E31F23E74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47D1158D6B;
	Wed, 10 Apr 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCd+86oo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2969DF4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752285; cv=none; b=SRcue9dnub76tgjq8i1VdUNMqyrvLGxEEdB/9fjVQdaZmRXSj2wrdu0PbwQI7MqVPU7aFxXZ3EpCaS83GXlQLzqD6owBhqk9WGwUD4f+DAY6gxU53bQ2wDa/1xY/TCvHTBLCSXbXOoQ5z3w0Q2uIzPH/VUj5gldQzcjfX2p38m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752285; c=relaxed/simple;
	bh=wJyBXBGOmxn34WjhWjROYKPAED2bzb6ynZPSkMqqr1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv+tl8zm4H/9HZK36oY6Mh1UEwRFCqksFkfZQ1iejVZB2pbNGl23/j8OAtCpIwwjnUgWsFl6xRsWgYpzhAxpV3eOq09fIoY6FYycorFA72nszafFko2nJbqOxUegC+i+Yj7MhW1qa/UJXtlogbOYamZ4uvn3X4RJQFSuRJNzZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCd+86oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C84C433C7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712752284;
	bh=wJyBXBGOmxn34WjhWjROYKPAED2bzb6ynZPSkMqqr1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aCd+86oo/rrOZZ5LDNvj/aQ2bXBFtSyGhIL/8yUg3Xv98vjhjY6/jzIuzmL/6Kw6n
	 6/QxUtJnQUTqO2eVMjnRln31RLHun0WmgfU9cvI2hdWrRUG3xt6DECNOC2dkqY/Kbn
	 VNmdFmOOXy1S6fpr1DyjW06hg4nhR0h2aw1SsvC3yJ8P07PwtCZtHHMM0bmhW2D0ay
	 bVV/aqSDQHJgUjPtxOx+f2l/1X3ounRNgDhyFgjtvHv4/aFMeLRHMTuWuXyJyjxCnZ
	 CKUbRR9xMUTAXw8J3yW+qbQ/PbHu5ba7xSxRmclSC2457x8Hf7UyyMfLaIkpPGd5vX
	 FLM1T8z41/R7w==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso86737381fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:31:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHDoN8GRWgauZF/ARRmUd1t0zsIrDvWoW9YUvZ0cL6X7xLocOeiyHBJeqscwjSjfb5ahDcZqNEiBhn0Ugw0yo3+bRQk+db53GWPT5B
X-Gm-Message-State: AOJu0Yxw2XoytuDFQ1tFgaPkZAFK1dibDFrjdO9r6CmfOU2c4hFbzgZJ
	5KWOkz831bAOpTPQExvZKCc6wVMb+K0M4U95/V5O941BBhNNGPgBF4O69PSqcahNmI4mBbE15gY
	G57h48zkxok5nBP53BazOAW/ikTw=
X-Google-Smtp-Source: AGHT+IHuT+XFJeaCh2hGEm5AckPvyGrE/Qv7aBbddDEfGsyOioWKVti/1UfUWWfzQXrhcXJDtYUrnzGBIVAch+SaVvU=
X-Received: by 2002:a05:651c:21c:b0:2d8:84a0:357a with SMTP id
 y28-20020a05651c021c00b002d884a0357amr1761988ljn.33.1712752283038; Wed, 10
 Apr 2024 05:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409164641.GC3219862@dev-arch.thelio-3990X>
 <20240410024126.21589-1-zhuqiuer1@huawei.com> <20240410024126.21589-2-zhuqiuer1@huawei.com>
In-Reply-To: <20240410024126.21589-2-zhuqiuer1@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 10 Apr 2024 14:31:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFdR49n2Je5jYSdbWRZbMGoZenfaqDX3iCQFVZUecrCmw@mail.gmail.com>
Message-ID: <CAMj1kXFdR49n2Je5jYSdbWRZbMGoZenfaqDX3iCQFVZUecrCmw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add a memory clobber to the fmrx instruction
To: zhuqiuer <zhuqiuer1@huawei.com>
Cc: nathan@kernel.org, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@armlinux.org.uk, llvm@lists.linux.dev, morbo@google.com, 
	ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 04:41, zhuqiuer <zhuqiuer1@huawei.com> wrote:
>
> The instruction fmrx is used throughout the kernel,
> where it is sometimes expected to be skipped
> by incrementing the program counter, such as in vfpmodule.c:vfp_init().
> Therefore, the instruction should not be reordered when it is not intended.
> Adding a barrier() instruction before and after this call cannot prevent
> reordering by the compiler, as the fmrx instruction is constrained
> by '=r', meaning it works on the general register but not on memory.
> To ensure the order of the instruction after compiling,
> adding a memory clobber is necessary.
>
> Below is the code snippet disassembled from the method:
> vfpmodule.c:vfp_init(), compiled by LLVM.
>
> Before the patching:
> xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> xxxxx:   xxxxx    mov r0, r4
> xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
> ...
> xxxxx:   xxxxx    bl  c0791c8c <printk>
> xxxxx:   xxxxx    movw    r5, #23132  ; 0x5a5c
> xxxxx:   xxxxx    vmrs    r4, fpsid  <- this is the fmrx instruction
>
> After the patching:
> xxxxx:   xxxxx    bl  c010c688 <register_undef_hook>
> xxxxx:   xxxxx    mov r0, r4
> xxxxx:   xxxxx    vmrs    r5, fpsid  <- this is the fmrx instruction
> xxxxx:   xxxxx    bl  c010c6e4 <unregister_undef_hook>
>
> Signed-off-by: zhuqiuer <zhuqiuer1@huawei.com>

This also fixes the issue I observed so

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> ---
>  arch/arm/vfp/vfpinstr.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> index 3c7938fd40aa..ae2c9b9b7701 100644
> --- a/arch/arm/vfp/vfpinstr.h
> +++ b/arch/arm/vfp/vfpinstr.h
> @@ -68,14 +68,14 @@
>         u32 __v;                        \
>         asm(".fpu       vfpv2\n"        \
>             "vmrs       %0, " #_vfp_    \
> -           : "=r" (__v) : : "cc");     \
> +           : "=r" (__v) : : "memory", "cc");   \
>         __v;                            \
>   })
>
>  #define fmxr(_vfp_,_var_)              \
>         asm(".fpu       vfpv2\n"        \
>             "vmsr       " #_vfp_ ", %0" \
> -          : : "r" (_var_) : "cc")
> +          : : "r" (_var_) : "memory", "cc")
>
>  #else
>
> --
> 2.12.3
>

