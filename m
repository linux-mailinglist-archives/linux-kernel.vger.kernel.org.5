Return-Path: <linux-kernel+bounces-104188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B687CA70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF031C2192C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA717BBA;
	Fri, 15 Mar 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwOdPTHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07817BA3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493820; cv=none; b=FSzm3s209GSAwF1CJhu7g4V0R1Clvf95K/MK8VYFuaO87U3gbrvPiYTUhqhymVLy8V0Xyx5LbVspMdCdtce4Lpaia9IRRzajB57MNTpsq1ZTnYFuOoYbCGAEEVV1zlmkg2QvWuBgquvSxKpo7L/9SQjxi0NVt4Fgad+PND8/fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493820; c=relaxed/simple;
	bh=3M7cvPH1k3x9ftE/ZOvgbDHT7rA//Ug1G4bN+Ml+v+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrrlIuFHsEi+2YsMURcNbgqFSbtBsDWnIH6s+JrzAhs4Krz1BxmBYDbI++3Qd5CX2Q/TcrUwzD9kzYvRWO3jK0Gi4vH+/uTKAtCAdEfSL2ukzL9aTsjXRQEapNKIC8jze2wvemSNye6GRXbrwXQVfV8CsqTP6x2xXG69iSlvPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwOdPTHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF63BC433F1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710493819;
	bh=3M7cvPH1k3x9ftE/ZOvgbDHT7rA//Ug1G4bN+Ml+v+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BwOdPTHYPOJ33HSPsxBh7Hp6bmO+KIhdCGO6jMFGIDzWinwP4WjgdlDPB0HtMHatc
	 rd3gqo3A+PSlG7YwrpMyMYuuU4lEcYyCwU6lmwE90iLjLjqQdKoVSP3fzXsRlBTwdW
	 D+mfwFzMaGhh/wiW1UBJs2qAqhr6pTcPhtAq06R9FsHDYzKwwEJAzstU7o5mrGrrzT
	 MGeObGBWRjzOk5AXz9iCwBwAvH84Atq8rhFzH3n2UJ3tIMDc36ZkdABU+H0NIqofuD
	 GE++7MmBNT6ANJWJCIpLuhQGE1LLRowaGwrwfqGrX0fTfYia6vP5UjyAg8R5NZC+qM
	 QEIgqvPIb8gMw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2509c66daso25331361fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:10:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2McRgWOHIDETkw3/LMEkagrWNezMeVfajbU0+PtlcVh0716ZXfCpzTTvsD6GWTmr9SRqTLSqfOpfpiltOMMn948Mt2WdnSRNV1vzx
X-Gm-Message-State: AOJu0YwQn2XIgaAZhLzoSqjKVYV7fgtw7R/TqaB2RRFS42E9VkB+jEoJ
	SRrhnZwSX6fTic8A+c6hAISsMQvQTWnsJuOAa5I7x/+AI7UDOI270Haw288VzCrQMhYuwbIEOz5
	i/jODYBtqb1CNhV+o53zuChcn80M=
X-Google-Smtp-Source: AGHT+IHqkEFrSRTs8aYm5dHeOCvYtafK2Ub7abrQ+WZqubDu0eXRsRdLbNdNPuHclPxv2y1LDXkgSarjoEYdOmttaAQ=
X-Received: by 2002:a2e:95c8:0:b0:2d4:d50:2358 with SMTP id
 y8-20020a2e95c8000000b002d40d502358mr2741236ljh.18.1710493818205; Fri, 15 Mar
 2024 02:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315041420.12802-1-richard.weiyang@gmail.com>
In-Reply-To: <20240315041420.12802-1-richard.weiyang@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 10:10:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFRG8notqdt7toS9n3V-Y0KPHZBr3kZBJredCACMSubfw@mail.gmail.com>
Message-ID: <CAMj1kXFRG8notqdt7toS9n3V-Y0KPHZBr3kZBJredCACMSubfw@mail.gmail.com>
Subject: Re: [PATCH] x86/head_64: move parameter close to call function
To: Wei Yang <richard.weiyang@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, 
	Michael Roth <michael.roth@amd.com>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello Richard,

On Fri, 15 Mar 2024 at 05:14, Wei Yang <richard.weiyang@gmail.com> wrote:
>
> startup_64_setup_env is first introduced by 'commit 866b556efa12
> ("x86/head/64: Install startup GDT")'. Then 'commit 469693d8f622
> ("x86/head/64: Re-enable stack protection")' insert some code which
> leverage %rdi, which is removed by 'commit 8f6be6d870e8 ("x86/smpboot:
> Remove initial_gs")'.
>
> This left the parameter of startup_64_setup_env a little far away from
> where it is used. Let's move them together for better understanding.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Joerg Roedel <jroedel@suse.de>
> CC: Michael Roth <michael.roth@amd.com>
> CC: Brian Gerst <brgerst@gmail.com>
> CC: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head_64.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

The code that you are fixing here no longer exists.

If you are going to send patches in the middle of the merge window,
please make sure that you are at least up to date with Linus's tree at
the time you send the patch.


> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 3dbd05f93859..5fb8bb7cdabe 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -69,8 +69,6 @@ SYM_CODE_START_NOALIGN(startup_64)
>         /* Set up the stack for verify_cpu() */
>         leaq    (__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %rsp
>
> -       leaq    _text(%rip), %rdi
> -
>         /* Setup GSBASE to allow stack canary access for C code */
>         movl    $MSR_GS_BASE, %ecx
>         leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> @@ -78,6 +76,7 @@ SYM_CODE_START_NOALIGN(startup_64)
>         shrq    $32,  %rdx
>         wrmsr
>
> +       leaq    _text(%rip), %rdi
>         call    startup_64_setup_env
>
>         /* Now switch to __KERNEL_CS so IRET works reliably */
> --
> 2.34.1
>

