Return-Path: <linux-kernel+bounces-112426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B48879A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B55B210FE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605150271;
	Sat, 23 Mar 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSw4qaD+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F02940B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214101; cv=none; b=CkeiBhJHSB8F0jgnojHh8JWsSW+fvF5lWqEzZOr3M0ADVmGnKYMeV7hrHOAT08r9Kq1IGBW4n27Xf+WM/uR+g2i2xjhtsf4WMXUyp5BzHVXdFJiPwbCgGIq71bspo7UKPqUKDkJ5NFoy0D2EXERx92aB5k2CwX4mgDkbZOHy9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214101; c=relaxed/simple;
	bh=cUXSVq8t93vPl32zeOpcojFKSK+ASn+M8Bs9QK3e3mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0WuD2ZRSJDmp8ye61cfhBMurAZ/QQ+4tMljrgRojtfGFxdjM6MVVa2TRMCFb1jdpsAeHBybKknw344te7LVaWTyC5hiKk2DrTm0bKpxUvLS7Q+Hqh78+nOO1NHIb2M9iEsBUzatKOOQORY7cf6X1kf5eMaHOqQYvYWg9PcIx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSw4qaD+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so58796751fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711214098; x=1711818898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFTaBnhavmAkBN3jLG25kOgUWz/tDDfCXNNpRgSXeWs=;
        b=mSw4qaD+UB3A0KGH9pJ28FHekDptnjxET0bqfp+MzTaDfMdkbCmP4ia6mp/u/GM1uQ
         eIwGnkTiU+WOfnyZEg0R2N1+MevltiSeuVVGqsINhGwhQb3DILLO3p4JIWveUzXYq6vr
         kIGclvDtkJTU+IsC/JNf+KBToydn2mKlR/fBhJery1B3uWQiQBrGHrWGavqFOfWbk/5T
         tN4x05epKO3ttMuCF8JJxUxYJI7I3qwlmODntJrk7PnegWrSYDS3Ikaq7bGl6UfnSLxw
         YFu5nc+Cl5NRf0me76xOAUWeo8wl1ttGhXXhBkdKYmBMKF3n2DXhBgBtEz1kNFw9Ch85
         uZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711214098; x=1711818898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFTaBnhavmAkBN3jLG25kOgUWz/tDDfCXNNpRgSXeWs=;
        b=vMyxO8lbfrAb+mCrYD/itOVu9Zs930ubqduymt3v5an/yg1G2HN3no9ZPESfRWre9r
         XUQ+R0D+VXknUEz7KFKNfKGUxcxGKPGFupHCiAFtqint+z39aWjGcyWGVscY0HUHLbCA
         xhWq6lLGcUX1Ye6zbaLdhdVgbAxBXKBPa2Q00sdPpSFg8LI0XwepnWX0yLW8GCou7r7o
         HQnUAzuP0K38uyeu8ocP8e9W+808SeR6sbVNz1H5UiDWrJvQcocafFFzcuUWNZmOfSSy
         Ou0gqplhOCxOMQ3JvQGTWm8ptOp1mRaKjI5TDs+AoaQUIfMAleW7pEY/yaEWvmIWmMIH
         5n2Q==
X-Gm-Message-State: AOJu0YytQ1WGXPgY5QGFqH2dgAr+e+ziHbEbMNIQ26+hDdl/5yrcjxTs
	EeJKTjd/5iMOTaJDazs4EXx/NtibJCmxG3QBvqOCpQQXUEUof/JnnET8R+YFyWImcA7UHnjWSaX
	Ij+XNqGmt95ERxYBDttgj87130DU=
X-Google-Smtp-Source: AGHT+IF6fES5xyKdKaNE5kr3hEf8QVd6qhFdNj2Xxc+A1Kpv8z5xOUdueRFG0lAqKE+Lj0WyE01zhX34lLsjwZ//TSA=
X-Received: by 2002:a2e:9241:0:b0:2d6:84a4:99b4 with SMTP id
 v1-20020a2e9241000000b002d684a499b4mr2053535ljg.20.1711214098170; Sat, 23 Mar
 2024 10:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <20240322165233.71698-11-brgerst@gmail.com>
In-Reply-To: <20240322165233.71698-11-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 23 Mar 2024 18:14:56 +0100
Message-ID: <CAFULd4bzp-dn5QKtUGbZCkkeyFd9573D7XAnKnrr4KZ633g4zQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/16] x86/percpu/64: Remove fixed_percpu_data
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Now that the stack protector canary value is a normal percpu variable,
> fixed_percpu_data is unused and can be removed.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/processor.h | 8 --------
>  arch/x86/kernel/cpu/common.c     | 4 ----
>  arch/x86/kernel/vmlinux.lds.S    | 1 -
>  arch/x86/tools/relocs.c          | 1 -
>  4 files changed, 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 40d6add8ff31..1f15a7bee876 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -386,14 +386,6 @@ struct irq_stack {
>  } __aligned(IRQ_STACK_SIZE);
>
>  #ifdef CONFIG_X86_64
> -struct fixed_percpu_data {
> -       char            gs_base[40];
> -       unsigned long   reserved;
> -};
> -
> -DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __vis=
ible;
> -DECLARE_INIT_PER_CPU(fixed_percpu_data);
> -
>  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
>  {
>  #ifdef CONFIG_SMP
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index f49e8f5b858d..395a8831d507 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1997,10 +1997,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
>  EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
>
>  #ifdef CONFIG_X86_64
> -DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
> -                    fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
> -EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
> -
>  static void wrmsrl_cstar(unsigned long val)
>  {
>         /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 0b152f96c24e..667202ebd37f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -473,7 +473,6 @@ SECTIONS
>   */
>  #define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
>  INIT_PER_CPU(gdt_page);
> -INIT_PER_CPU(fixed_percpu_data);
>  INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_MITIGATION_UNRET_ENTRY
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 016650ddaf7f..65e6f3d6d890 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -834,7 +834,6 @@ static void percpu_init(void)
>   *     __per_cpu_load
>   *
>   * The "gold" linker incorrectly associates:
> - *     init_per_cpu__fixed_percpu_data
>   *     init_per_cpu__gdt_page
>   */
>  static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
> --
> 2.44.0
>

