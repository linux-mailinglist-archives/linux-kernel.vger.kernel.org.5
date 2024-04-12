Return-Path: <linux-kernel+bounces-141915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9401C8A2512
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9FE281F46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421017C95;
	Fri, 12 Apr 2024 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onlePDWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797751B5AA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895536; cv=none; b=TOQ3SqtY5Id01Rl91Y8gj60IC1cvphD7ObH4BhywjHUjj8BiPWvr0yDIJRa6YDNQwNospEtH7mv8Wjk84BVexiIH1ThWepFIV/cgYz2Nb0hlFijwvdZSYC4QNv85N0aUe9MjZK+Ql976QMNhkgkzYVl26rctfUavSEAFEO7Vpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895536; c=relaxed/simple;
	bh=9qZzQZ/0gGIJAQ+03rAWiljV9/jUKUWMrXaa+HpiIv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/lC4AURrZhxv/9/yQHMxO/Jz+yQUJfpf//9+ei+y9pQYsjiYZZES+/BLOYdYdqt6MPTucn9EPhU4P7GPYJO9e1+rw5KRICZASdokibja7sv7TE94p1xMz9TAfAphJlKNtRKHyA20uwNRie3pnOjjNFg1Z0/yjgq6sRc1PZfKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onlePDWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BB1C4AF07
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712895536;
	bh=9qZzQZ/0gGIJAQ+03rAWiljV9/jUKUWMrXaa+HpiIv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=onlePDWkN9uI2Lx4cugi/tuUAzigRCYq13jXCu+K8rPuxcm4xep0+KH5u0xhUmecg
	 zS6oCXBn06utl5tfVEVoi7Xllylf15OBeV2zCdzIibLA2KwskOq2BuqvABQEKhBsO6
	 0aUVBgX1WLL8hEnLfhJO21gyBaDb5PkKLd0h9SJhmdDlABVfWySVJLmShMItMDWX20
	 YRBAcFlpL5bIO2HiltyvrqBM1FZH6ikEZWUU7KztjllziiPSxBRJAI/3ovfzArqkcn
	 CLz+a2mIgaQmCjdlfDaSq8GZHDfUWk0YDls8IMW1xRLmckApTt/0v3okrqpkrTQdv7
	 vCs6eK03RwJCg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51addddbd4so51672366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvNq84Xyth1WV8O7GzFhJLe6u7wwtMm2z2j9vK/dcnSG9FE6j9dLR7J5LFQWfcCMjY9dPZxWgyrBgILdejvdckAeXHGHz6NRNHt0Ak
X-Gm-Message-State: AOJu0YycvL11cUkO9jE5/VCHgSddTuKypTrTu7O1Aq99N8qXE90p1Tz/
	JchAiwJZoRzxsGa2YOV5Zq48RHD9fwbe1xKmIS+dfE75mxIx3jx0vrKrwQvJer3hCPkRpEXjygc
	PKDiI3tqZ6xs4LwsqQXVeEPtU3kM=
X-Google-Smtp-Source: AGHT+IEyx8qHzPwepEzMA5MbbIViqFwGNoPy2RbyMnJvYxSKB+yXOtEDYUZJd40DLh/VXFETeaDLQ5rmqfVyqNR5j7c=
X-Received: by 2002:a17:907:868b:b0:a52:3654:e42 with SMTP id
 qa11-20020a170907868b00b00a5236540e42mr410913ejc.0.1712895534906; Thu, 11 Apr
 2024 21:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411010510.22135-1-yangtiezhu@loongson.cn> <20240411010510.22135-4-yangtiezhu@loongson.cn>
In-Reply-To: <20240411010510.22135-4-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Apr 2024 12:18:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7SqudMeyK6_+j0ah=N=ywsv=4kk_b=hxocEQFsKZ+0bA@mail.gmail.com>
Message-ID: <CAAhV-H7SqudMeyK6_+j0ah=N=ywsv=4kk_b=hxocEQFsKZ+0bA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] LoongArch: Save and restore PERCPU_BASE_KS for
 ACPI S3 state
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Thu, Apr 11, 2024 at 9:05=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, per_cpu_offset(x) is defined as __per_cpu_offset[x])
> only under CONFIG_SMP in include/asm-generic/percpu.h, that is
> to say, the implementation of loongarch_common_resume() which
> calls per_cpu_offset(0) is not suitable for the case of non-SMP,
> so do not write per_cpu_offset(0) to PERCPU_BASE_KS when resume,
> just save the value of PERCPU_BASE_KS when suspend and restore
> it when resume to make it work well for both SMP and non-SMP.
For non-SMP you need PERCPU_BASE_KS to do what?

Huacai

>
> Tested with the command "rtcwake -d rtc1 -s 20 -m mem -v", dmesg
> shows that "PM: suspend entry (deep)" and "PM: suspend exit".
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/power/suspend.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspen=
d.c
> index 166d9e06a64b..7a97949ddade 100644
> --- a/arch/loongarch/power/suspend.c
> +++ b/arch/loongarch/power/suspend.c
> @@ -16,6 +16,7 @@
>  #include <asm/tlbflush.h>
>
>  u64 loongarch_suspend_addr;
> +static u64 saved_pcpu_base;
>
>  struct saved_registers {
>         u32 ecfg;
> @@ -36,6 +37,7 @@ void loongarch_common_suspend(void)
>         saved_regs.pwctl1 =3D csr_read32(LOONGARCH_CSR_PWCTL1);
>         saved_regs.ecfg =3D csr_read32(LOONGARCH_CSR_ECFG);
>         saved_regs.euen =3D csr_read32(LOONGARCH_CSR_EUEN);
> +       saved_pcpu_base =3D csr_read64(PERCPU_BASE_KS);
>
>         loongarch_suspend_addr =3D loongson_sysconf.suspend_addr;
>  }
> @@ -44,7 +46,7 @@ void loongarch_common_resume(void)
>  {
>         sync_counter();
>         local_flush_tlb_all();
> -       csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
> +       csr_write64(saved_pcpu_base, PERCPU_BASE_KS);
>         csr_write64(eentry, LOONGARCH_CSR_EENTRY);
>         csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
>         csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
> --
> 2.42.0
>
>

