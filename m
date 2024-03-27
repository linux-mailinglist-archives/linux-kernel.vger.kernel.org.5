Return-Path: <linux-kernel+bounces-120367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D193F88D658
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018021C24796
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EDF1DA24;
	Wed, 27 Mar 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lep/P1gP"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8D17551
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520649; cv=none; b=Y4HThmtWUG6CmLiYKe0oqCVeRBbd1jCrz7ttclP8sIAY5KKLMw8z4YKDP2VYKXRmCmiymATFFdKC0QJs53fhl8yTMRI/dfbxl27cTSSQ1C2wpF2wYC5SbpVqflLOpoMIm0PeLq8nERpNSeaFufHG+NXpQ8iDEwHai+iH1a0djVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520649; c=relaxed/simple;
	bh=ga9bfBr31Esbeh5JU8UkHQ8sBr/NkIwCdZHwCMcn5ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/Qk+842lAynW/m+vozIiLaVqCcakJXtg56gdASzuli37MibaY9OzB46qmPhdUxKxow9Fg3N0Dtdc1KmperHACOHGu5/wOD4WZh1uNFvthsYc7Df4LohwluQgXjlje+mURVZO6XgXI8McFH2xBEMfZUfS9i55V8NKlvQiAvc824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lep/P1gP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e67d42422aso3823579a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711520647; x=1712125447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oWEwBijHMiAPbYhHlQ1tO5hUF/k22snxI3OcFkt4Sg=;
        b=Lep/P1gPMmhh1UONcBLTaZQ4zay7i+C6TL6CiGA7fOwa4WLzpyo9TnU5QljrjrTmeh
         /pTPitlnlgT1IzkD/4wNW0CEkHCHaJcbxoCDLG08G+SdReFoJpMUBI7iL/YCFIsut2Ro
         U0PIApEL4TOVSZiNrfekDkL1aBmsU61OVfPevs+1LWcrXuqPuvpixODSKQob4+p3731c
         nYsGS4cz+MDnhii4msblmrqcj5Ue7SLqU8gksqTa3Cbenq0EUB4b7sonnCWh8dUyvnSv
         1lFnjBpvn4D7aydLLTXtU7OlT+XpRdPzxqK6u7f+Z6lochRzSJHRPb2k97rxrN4kqUPS
         vwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711520647; x=1712125447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oWEwBijHMiAPbYhHlQ1tO5hUF/k22snxI3OcFkt4Sg=;
        b=IeVHNa7D8sky0xL0vyjXR7sGxo0olOjXV7EuzGXClbj/Hyoh0bW/itMseaxKWhY8og
         ZWlMG0qDx0RgXvKXoA0HtOxVjN5nL1Hts+eLpVY/E/0g5RPN/kCW/2f48eXKzsk43SA8
         yzsL/IAEwJiHUdAI0dsX1awfh913TJjCY9JQXgkhvSYNYJ4POm1iPaBkyd//ycQ4gfqE
         Ok0LSkgPWcLTHYXHMrwcYOpNd/pLeAF5rTWJg3jv+ykQpRi94QjaCPTXW7mVoxdZn7ZG
         vYOMFaApLtUMhgC8swYHyc68FLTaHAARj5El9yeH+a8mIgGhIfDZjGkiF9xqIBWqomyo
         wbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNcEHxNJLX2mJg344qUXTka1nzEr7cL3m8yiCtvulz7N+4JVYp2tL2wt17wtbK83ZNDVubNxnzb9nhwLAoHTXjOPFddZsZ5mkgqzh1
X-Gm-Message-State: AOJu0Yz8fPjYFkAstONM3zW5cV8qTEIDGdxsBVmT+3HLjkQ98LOTKRkX
	xPXu/IIB/+zRUFF1EyIPlKVOJzEzsuu54E3F+BjcsupwDUY5cI97shwvRoRiaV2htrVDCY1Pd+/
	nDhBDHsjKnF8Rg6fSdII1MmYVKoAxqP/wC6JD2g==
X-Google-Smtp-Source: AGHT+IFhEeq410DvQa9oQZkS0m0EYwn1s+oHwhpUn2R8jvumRu2oImrFD/ysHx9vuZwjm+EIqRm8Kd2Z30d1RvDrk8A=
X-Received: by 2002:a05:6870:788c:b0:22a:107c:4dd6 with SMTP id
 hc12-20020a056870788c00b0022a107c4dd6mr3948186oab.40.1711520646891; Tue, 26
 Mar 2024 23:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327045035.368512-1-samuel.holland@sifive.com> <20240327045035.368512-7-samuel.holland@sifive.com>
In-Reply-To: <20240327045035.368512-7-samuel.holland@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 27 Mar 2024 14:23:56 +0800
Message-ID: <CAEEQ3wk=0+_vofamg=UWoxFXbH5wZ722vcm5+QuwSdUT6998yw@mail.gmail.com>
Subject: Re: [External] [PATCH v6 06/13] riscv: mm: Combine the SMP and UP TLB
 flush code
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, Mar 27, 2024 at 12:51=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
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
>  arch/riscv/include/asm/tlbflush.h | 31 +++----------------------------
>  arch/riscv/mm/Makefile            |  5 +----
>  3 files changed, 5 insertions(+), 33 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..442532819a44 100644
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
> index 4112cc8d1d69..4f86424b1ba5 100644
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
> @@ -54,28 +49,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_un=
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
> -#define local_flush_tlb_kernel_range(start, end) flush_tlb_all()
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

This is cleaner than my previous modification to support UP __flush_tlb_ran=
ge.
So:
Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks,
Yunhui

