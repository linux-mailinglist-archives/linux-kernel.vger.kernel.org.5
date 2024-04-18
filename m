Return-Path: <linux-kernel+bounces-149465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B88A917D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BBEB21273
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05114F891;
	Thu, 18 Apr 2024 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jzm7oYwG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF54F5F9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713410168; cv=none; b=FlrUPXTnki+jvvPEenyXcOWx3pAE9j2BloiJixPCeSJdEWoGo+Jju9KmgmR1J8AIrRNOXZzoD3WHtiUi/tfZXueNsqOe6p/IiMa/q5hxCLeIX5z0wa2DIBEqnNcfJuxO6Gt7C5yPYKz7PqXynJdy60z4zvtHgMYMbjUz7x8wfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713410168; c=relaxed/simple;
	bh=uA1Jx8MKID/IlqdiOOESESuGGYVzvm8+QwDJpRT4i2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spgSTjp15qxcmFOKd9bkovO3+3BCFXjZv4Bf5UrNOUdZ5IK3Fz6eJfwhLMn4sZIq+COuX8SQqkPMBNWU64bT5t+Ovjd3ptHNhK9+ME77AzpjAHIAx878nwS/7JW9M4BM2zBFo+rWryfFJhCiZkJKa0euHO42Mf0sV4lgkf7gUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jzm7oYwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B043BC4AF0B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713410167;
	bh=uA1Jx8MKID/IlqdiOOESESuGGYVzvm8+QwDJpRT4i2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jzm7oYwGGdgwup97MWSpv8bcEX7EsPa2Xk2kznnM8qeQx330g0ZJjyqTAXNJKX7wz
	 4xRAUKy74qv3rN+19qat1kYjYw+4esvhjcHqJGFoIEdDkes322W9vE894Ehh4onBUR
	 YMK9QShdvfmod+mrvN/yVYcwzHavCMqBhs5/rPcUEyXb7jnZyG0smNhnh8BHDGyk1/
	 wer8CfCbI2bfvFAgzwrXmDGl836e5Wl37D7IXTM46NVo2RHMmvVMt3PCJLFHJgheP9
	 trwkuemtcXwL06Ufib7UwCqrKmIZ6T/1qnP89TGOCDW5/a/TzbtssuJj5g8WS9p86O
	 cjBSq6C9ES35A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a554afec54eso32658566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq7Bwp/vmPblShCLggVhUpyWg8z4exn6g3HoNucgu6dq4F9OGZjLEsFeJeTlKd5Rc+Usny8l9iewiio8wgHJiSEfA3NEncgJI0h/xg
X-Gm-Message-State: AOJu0YyiUncXocNczQXoEVJig4BaZnZBNd0zj+ygB54H47BdPR6vNVU5
	TLffpoC7l71lHY+b8bWQUMFGj2OVonjqXh2oUIbf99663UapkxKnH0HRiVZhgg7nOeGGIYlwKn6
	7Aa2BCLyqw2dzYqB3i9+AVzs8f64=
X-Google-Smtp-Source: AGHT+IF0BYHUXOpbvRZ8ScmB8dqk/aUhAXMEUOY5zrAssKpYka5IHNhYqG34oTIGM4VaKPSZa+XwTF38DiEz0dGO8Vg=
X-Received: by 2002:a17:906:1458:b0:a51:abb0:a8a2 with SMTP id
 q24-20020a170906145800b00a51abb0a8a2mr735489ejc.42.1713410166235; Wed, 17 Apr
 2024 20:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417095951.2635-1-yangtiezhu@loongson.cn> <20240417095951.2635-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240417095951.2635-3-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Apr 2024 11:15:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7mZNw1rYfZFdh9+LA4+0WanVYQMvQaKBgVDcioXvtMHg@mail.gmail.com>
Message-ID: <CAAhV-H7mZNw1rYfZFdh9+LA4+0WanVYQMvQaKBgVDcioXvtMHg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] LoongArch: Modify ACPI S3 state function for non-SMP
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Wed, Apr 17, 2024 at 6:00=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, per_cpu_offset(x) is defined as __per_cpu_offset[x])
> only under CONFIG_SMP in include/asm-generic/percpu.h, that is
> to say, the implementation of loongarch_common_resume() which
> calls per_cpu_offset(0) is not suitable for the case of non-SMP,
> so do not write per_cpu_offset(0) to PERCPU_BASE_KS when resume,
> just save the value of PERCPU_BASE_KS when suspend and restore
> it when resume to avoid compiling error for non-SMP and make it
> work well for both SMP and non-SMP.
>
> This is preparation for later patch. Tested with the command
> "rtcwake -d rtc1 -s 20 -m mem", dmesg shows that "PM: suspend
> entry (deep)" and "PM: suspend exit".
This patch can be squashed to the 3rd patch.

Huacai
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/power/suspend.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspen=
d.c
> index 166d9e06a64b..8571818b93dc 100644
> --- a/arch/loongarch/power/suspend.c
> +++ b/arch/loongarch/power/suspend.c
> @@ -24,6 +24,7 @@ struct saved_registers {
>         u64 kpgd;
>         u32 pwctl0;
>         u32 pwctl1;
> +       u64 pcpu_base;
>  };
>  static struct saved_registers saved_regs;
>
> @@ -36,6 +37,7 @@ void loongarch_common_suspend(void)
>         saved_regs.pwctl1 =3D csr_read32(LOONGARCH_CSR_PWCTL1);
>         saved_regs.ecfg =3D csr_read32(LOONGARCH_CSR_ECFG);
>         saved_regs.euen =3D csr_read32(LOONGARCH_CSR_EUEN);
> +       saved_regs.pcpu_base =3D csr_read64(PERCPU_BASE_KS);
>
>         loongarch_suspend_addr =3D loongson_sysconf.suspend_addr;
>  }
> @@ -44,7 +46,7 @@ void loongarch_common_resume(void)
>  {
>         sync_counter();
>         local_flush_tlb_all();
> -       csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
> +       csr_write64(saved_regs.pcpu_base, PERCPU_BASE_KS);
>         csr_write64(eentry, LOONGARCH_CSR_EENTRY);
>         csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
>         csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
> --
> 2.42.0
>

