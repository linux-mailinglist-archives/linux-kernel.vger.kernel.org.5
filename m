Return-Path: <linux-kernel+bounces-87819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9401E86D96C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B7A1C22AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4440E3A1DD;
	Fri,  1 Mar 2024 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fz/2mDkx"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948D3A1D3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259163; cv=none; b=nsLNWN0PwDnCE7mGfQ7LPmfhrjiqTUjVb4VmKx63B+m8Hgj8fgEpQn8x4Lk3nqmF/dG758ykwLT0g10VW6vIB+UPv5MfKlSi3aG0mbl0cQAhXmiPLPItV+Dh+0kWwPCOSXyoz8soWYQocqKv1Mdh98M8fo07JOhyE8Gg/Pk45VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259163; c=relaxed/simple;
	bh=F6imE7VUqeNvS8GH4g1TUlNBqlHzfcl/SlrXlpPHr9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZdmIAWmL9ZuPHLld1W0G09f6JCWUcEUIfOVAOk3G9+bc66IszXM7880ERQXrwbJZWeqMBrRHtxJKzeeb7ODMnCwCccfk1xmEI0bBUJ06hMjjfLCi+TQ3NjiTrRAbkJgre/LKVnRpuOE4SVKmR+9HBDG8zBygljaGKxWVm8UX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fz/2mDkx; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e49833ccdfso705884a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709259160; x=1709863960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3SFfjWGyTSE99qrr0Tnrw16LTdrZNolz0yFIJjwrxw=;
        b=fz/2mDkxrEjsACUhJUDXyiR0+ya5ChyDRVIuaEzya47QaDAYi0AF9ClW7zi9Z5vYRQ
         c4EcRgDaYDOJGpLRhqheizNNw7YG6Q8QH0bLFxMFr0PA/Efax1UCd7ZZwSwCXjRs0CT0
         WJLmmHekSVEyptN6dVS6ZXAXFDQfGc4bYv+HAPoIeLvfRLtUuJBa9FxrpqJJYglxssKr
         sPs8Bzhe8kqYW8r9LcznlWlkcplLdtDndFHNYru56RNG2AXX5sgYu+sxFw1lIF3EliB7
         QwpJWpzgw99hKbdtQlxBAYI+O27XG8sHmhGCjTiSgk7TyiONpYiUVfh9wgKBozqdUcga
         XDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709259160; x=1709863960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3SFfjWGyTSE99qrr0Tnrw16LTdrZNolz0yFIJjwrxw=;
        b=Jp5hKS4veVy8P8YW7SXOpfDI+vow+vQgvtPmJRc4bUATUB73Q0qXV1ve4V4H7OUvUa
         Pk4ujgKmacZSFmPFY2l0clDZTv0Ng9zm1muQl5w3Cp3ah2E2OHtTGMb55kdwGBQnEEGA
         sjN4Pj0wueswIDXMAidmlsjn6MkIqE1xWFmliuhUr6bz29zxv/TxFFYpLNrPw/M/73SC
         HsS4zMQAzrwLUJUI/XdNoFVL1SzIOnuzsASJsl1DxdCcT2xuA5w2Si09se0pVQMEq0/Y
         OHIW9QuTmmHUmeCVOYplq+q0fCOU1GCDVRv9gO7yt52eoBSOmSgOTmCJpwvnOuehBtdt
         jKew==
X-Forwarded-Encrypted: i=1; AJvYcCWvxYhPs6DdDReqh/U7Ypyrq+Hx6l3HeeGTKHR9qAXjJwcdM8SxFYksjT3D6bpr1/25K8IU7qFZ2FWdvXeSK9GcIHpwNIFaN/yT50eI
X-Gm-Message-State: AOJu0YyE28rDyHytYBwiY30OcoQU6bkYWM+xu19dlugzwM6JpImLLZpk
	MIO1U+9CZGvSXvTJ6N2svvB1ptPlFge1eYGzkY04UCmqpZ3ShMrKakBilO+JwAeYW6LiVkwK+m4
	fT//gBP2sa6A3ViaXmyOuaubcOWJrz7ZHBBZJ8g==
X-Google-Smtp-Source: AGHT+IHo//tiM479EyQm3qLlzScCeQGdZKUojNRzyefzcHNqYrNX/D/mumQN7bmlRV1/paZVkvfk9qXQoBjLMcEk9aI=
X-Received: by 2002:a05:6870:2b19:b0:220:abe0:8efb with SMTP id
 ld25-20020a0568702b1900b00220abe08efbmr375688oab.13.1709259159890; Thu, 29
 Feb 2024 18:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229232211.161961-1-samuel.holland@sifive.com> <20240229232211.161961-7-samuel.holland@sifive.com>
In-Reply-To: <20240229232211.161961-7-samuel.holland@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 1 Mar 2024 10:12:28 +0800
Message-ID: <CAEEQ3wnCAqPjXEnSXc9Vce-kWETmbUpyzBdXi_2K+h+NZt4SqQ@mail.gmail.com>
Subject: Re: [External] [PATCH v5 06/13] riscv: mm: Combine the SMP and UP TLB
 flush code
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri, Mar 1, 2024 at 7:22=E2=80=AFAM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> In SMP configurations, all TLB flushing narrower than flush_tlb_all()
> goes through __flush_tlb_range(). Do the same in UP configurations.
>
> This allows UP configurations to take advantage of recent improvements
> to the code in tlbflush.c, such as support for huge pages and flushing
> multiple-page ranges.
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v4)
>
> Changes in v4:
>  - Merge the two copies of __flush_tlb_range() and rely on the compiler
>    to optimize out the broadcast path (both clang and gcc do this)
>  - Merge the two copies of flush_tlb_all() and rely on constant folding
>
> Changes in v2:
>  - Move the SMP/UP merge earlier in the series to avoid build issues
>  - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
>  - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)
>
>  arch/riscv/Kconfig                |  2 +-
>  arch/riscv/include/asm/tlbflush.h | 30 +++---------------------------
>  arch/riscv/mm/Makefile            |  5 +----
>  3 files changed, 5 insertions(+), 32 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bfcfec67ed5..de9b6f2279ff 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -60,7 +60,7 @@ config RISCV
>         select ARCH_USE_MEMTEST
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_USES_CFI_TRAPS if CFI_CLANG
> -       select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
> +       select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if MMU
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>         select ARCH_WANT_FRAME_POINTERS
>         select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 928f096dca21..4f86424b1ba5 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -27,12 +27,7 @@ static inline void local_flush_tlb_page(unsigned long =
addr)
>  {
>         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" =
(addr) : "memory"));
>  }
> -#else /* CONFIG_MMU */
> -#define local_flush_tlb_all()                  do { } while (0)
> -#define local_flush_tlb_page(addr)             do { } while (0)
> -#endif /* CONFIG_MMU */
>
> -#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>  void flush_tlb_all(void);
>  void flush_tlb_mm(struct mm_struct *mm);
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> @@ -54,27 +49,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_un=
map_batch *batch,
>                                unsigned long uaddr);
>  void arch_flush_tlb_batched_pending(struct mm_struct *mm);
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> -
> -#else /* CONFIG_SMP && CONFIG_MMU */
> -
> -#define flush_tlb_all() local_flush_tlb_all()
> -#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
> -
> -static inline void flush_tlb_range(struct vm_area_struct *vma,
> -               unsigned long start, unsigned long end)
> -{
> -       local_flush_tlb_all();
> -}
> -
> -/* Flush a range of kernel pages */
> -static inline void flush_tlb_kernel_range(unsigned long start,
> -       unsigned long end)
> -{
> -       local_flush_tlb_all();
> -}
> -
> -#define flush_tlb_mm(mm) flush_tlb_all()
> -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> -#endif /* !CONFIG_SMP || !CONFIG_MMU */
> +#else /* CONFIG_MMU */
> +#define local_flush_tlb_all()                  do { } while (0)
> +#endif /* CONFIG_MMU */
>
>  #endif /* _ASM_RISCV_TLBFLUSH_H */
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 2c869f8026a8..cbe4d775ef56 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -13,14 +13,11 @@ endif
>  KCOV_INSTRUMENT_init.o :=3D n
>
>  obj-y +=3D init.o
> -obj-$(CONFIG_MMU) +=3D extable.o fault.o pageattr.o pgtable.o
> +obj-$(CONFIG_MMU) +=3D extable.o fault.o pageattr.o pgtable.o tlbflush.o
>  obj-y +=3D cacheflush.o
>  obj-y +=3D context.o
>  obj-y +=3D pmem.o
>
> -ifeq ($(CONFIG_MMU),y)
> -obj-$(CONFIG_SMP) +=3D tlbflush.o
> -endif
>  obj-$(CONFIG_HUGETLB_PAGE) +=3D hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE) +=3D ptdump.o
>  obj-$(CONFIG_KASAN)   +=3D kasan_init.o
> --
> 2.43.1
>

git am the patch failed. Was it a patch based on the top commit of linux-ne=
xt ?

Thanks,
Yunhui

