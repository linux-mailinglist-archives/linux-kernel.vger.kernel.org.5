Return-Path: <linux-kernel+bounces-40449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516383E0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1420287AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7272031F;
	Fri, 26 Jan 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqUygwxG"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5E1EB57
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290945; cv=none; b=qe2b0yAdLVd9QLoWQGKVXFRrvAKIg1nX1eBLXCMOiWAVsAHaoHImSwaYn+phy+RH2zFjp6WMv8tCj8zDKj8wKMaSVEzRLImS9RF+Awjw3i02Z6mywzgygfX10qiiTpnnts1MBqgDacnlT0sQ/OeK52MgnyLJwziFkRhqcGAXNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290945; c=relaxed/simple;
	bh=WvIwIYW8/5Br/3S2GSXNmtRD8y9rHmnPQ1GWm1TfEms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmK2PXuDfe+1roaSbELUZbo31J0VatimHavU3OJf1BlGmHou33/6puzoyPrirTonmhMeAd7E1GnMMploerYDQUr86IuS8m3hhy9MSfRgNgpX9u2NYh/vWZ0vf5J2QAqYMMWYrCv5F0k2a9vGRBd9q06ZnczOy4IlH82Ua/4x0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqUygwxG; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4bd2e945a35so112508e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706290942; x=1706895742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmDH8DdX1bep/4Odx9K/cgDggkjrOU0cEa6n2Qnxw8o=;
        b=IqUygwxGoIoMeD0L4FZ5P2I7f0Xwbx7zcklzloS7X/26Rl7mfqjsn3ZGsimE0vojSH
         CcMRTZ1Zem+LA+Dw8k5ZUvYjUiJNuEwvbJiw7XpXOejfOkKohic1wytJC0HLJgRM3Iqf
         088q9xhO56Kj+sH1oVPMVG47/p09ndQdzTrK3CxL/ldrZbYCtUkdVUpknBJfsztQsiPT
         d6DiUKPW4jztwdXYxMbQK0rISAGqb0ZmOP3VvgG7VN4gUUHWt2GBid1HoK2qw/W1/trB
         kCsbWi6Ug8BTJOSNd87jI2TA7umQaDFbJbKXPS/lV9L9oI8DGPp41JqHMR7RhBsbAqtR
         3sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706290942; x=1706895742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmDH8DdX1bep/4Odx9K/cgDggkjrOU0cEa6n2Qnxw8o=;
        b=kx/51gFTb6V31DS5FtsW2ZYYb4V6LlBPwt2uTsZAXjdMV11Ke9SnCiVdRHqg9RmRp7
         rHhRrIosraneOi7c1J+QdkMhjjXaFC4sQx82rMmx8Ozj4WgsYWElBWbICF3FIAC4Mk4e
         36c+m2Lv2LNRw301nf9o3czVkapxv47svqptjT9LVHEX0KhUdgZ/wo7oINNcANlX5RMp
         anjS7LbbeSLKUFUYnTCLQEC+OTCWMEhnYX9O028LEFtJ0i//yxSLbbY2h6eHMJ+HzFyl
         eacrEqEu1/s5ofoeN2LuWKUL8mQIhaLmCpmiW71nBPzNou146M+Q1X2xRAgCv2X0n6fV
         XyfQ==
X-Gm-Message-State: AOJu0YzIy+mr3OcT6GeTNsvQyHNCLMKRplCimsgmHBI5BWUickySvBuM
	M0LZxTWXdibWr2jCtecMyRDavkFNIwoue8JsJ/FJ+QpNOWmW4hwwNqWmT2yVdRL2ADgs/3aFjL2
	TmDPuhAi9k/BCYFdhB/oF03EcEY8=
X-Google-Smtp-Source: AGHT+IGb7vdvwXVg2mhOhFmq+Yb2iVBmdBsDqX/eBt0gN6dG24LIwPaBf/QYBLzPWxfsdZnIi5OvC3PbAGKWx0PmCts=
X-Received: by 2002:a05:6122:919:b0:4bd:8cb8:8c5 with SMTP id
 j25-20020a056122091900b004bd8cb808c5mr118653vka.28.1706290941765; Fri, 26 Jan
 2024 09:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125062044.63344-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240125062044.63344-1-cuiyunhui@bytedance.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 26 Jan 2024 17:41:55 +0000
Message-ID: <CA+V-a8s4No=U1S-KzLAmOLYa6vXd7repFP4HH1=SraLB2=qHRQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: add uniprocessor flush_tlb_range() support
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, ajones@ventanamicro.com, 
	mchitale@ventanamicro.com, dylan@andestech.com, 
	sergey.matyukevich@syntacore.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	jszhang@kernel.org, apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:23=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> Add support for flush_tlb_range() to improve TLB performance for
> UP systems. In order to avoid the mutual inclusion of tlbflush.h
> and hugetlb.h, the UP part is also implemented in tlbflush.c.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/tlbflush.h |  61 ++++++----
>  arch/riscv/mm/Makefile            |   2 +-
>  arch/riscv/mm/tlbflush.c          | 195 ++++++++++++++++++------------
>  3 files changed, 156 insertions(+), 102 deletions(-)
>
Boot tested with defconfig + rz/five enabled, no issues seen on
RZ/Five SMARC EVK.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 928f096dca21..426f043fb450 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -10,12 +10,21 @@
>  #include <linux/mm_types.h>
>  #include <asm/smp.h>
>  #include <asm/errata_list.h>
> +#include <asm/tlbbatch.h>
>
>  #define FLUSH_TLB_MAX_SIZE      ((unsigned long)-1)
>  #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
>
>  #ifdef CONFIG_MMU
>  extern unsigned long asid_mask;
> +DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
> +
> +struct flush_tlb_range_data {
> +       unsigned long asid;
> +       unsigned long start;
> +       unsigned long size;
> +       unsigned long stride;
> +};
>
>  static inline void local_flush_tlb_all(void)
>  {
> @@ -27,12 +36,40 @@ static inline void local_flush_tlb_page(unsigned long=
 addr)
>  {
>         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" =
(addr) : "memory"));
>  }
> +
> +static inline void local_flush_tlb_all_asid(unsigned long asid)
> +{
> +       if (asid !=3D FLUSH_TLB_NO_ASID)
> +               __asm__ __volatile__ ("sfence.vma x0, %0"
> +                               :
> +                               : "r" (asid)
> +                               : "memory");
> +       else
> +               local_flush_tlb_all();
> +}
> +
> +static inline void local_flush_tlb_page_asid(unsigned long addr,
> +               unsigned long asid)
> +{
> +       if (asid !=3D FLUSH_TLB_NO_ASID)
> +               __asm__ __volatile__ ("sfence.vma %0, %1"
> +                               :
> +                               : "r" (addr), "r" (asid)
> +                               : "memory");
> +       else
> +               local_flush_tlb_page(addr);
> +}
> +
> +static inline unsigned long get_mm_asid(struct mm_struct *mm)
> +{
> +       return static_branch_unlikely(&use_asid_allocator) ?
> +                       atomic_long_read(&mm->context.id) & asid_mask : F=
LUSH_TLB_NO_ASID;
> +}
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()                  do { } while (0)
>  #define local_flush_tlb_page(addr)             do { } while (0)
>  #endif /* CONFIG_MMU */
>
> -#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>  void flush_tlb_all(void);
>  void flush_tlb_mm(struct mm_struct *mm);
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> @@ -55,26 +92,4 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_un=
map_batch *batch,
>  void arch_flush_tlb_batched_pending(struct mm_struct *mm);
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>
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
> -
>  #endif /* _ASM_RISCV_TLBFLUSH_H */
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 2c869f8026a8..7c6c4c858a6b 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -19,7 +19,7 @@ obj-y +=3D context.o
>  obj-y +=3D pmem.o
>
>  ifeq ($(CONFIG_MMU),y)
> -obj-$(CONFIG_SMP) +=3D tlbflush.o
> +obj-y +=3D tlbflush.o
>  endif
>  obj-$(CONFIG_HUGETLB_PAGE) +=3D hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE) +=3D ptdump.o
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 8d12b26f5ac3..4765603fa08a 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -6,28 +6,36 @@
>  #include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
> +#include <asm/tlbflush.h>
>
> -static inline void local_flush_tlb_all_asid(unsigned long asid)
> +static unsigned long get_stride_size(struct vm_area_struct *vma)
>  {
> -       if (asid !=3D FLUSH_TLB_NO_ASID)
> -               __asm__ __volatile__ ("sfence.vma x0, %0"
> -                               :
> -                               : "r" (asid)
> -                               : "memory");
> -       else
> -               local_flush_tlb_all();
> -}
> +       unsigned long stride_size;
>
> -static inline void local_flush_tlb_page_asid(unsigned long addr,
> -               unsigned long asid)
> -{
> -       if (asid !=3D FLUSH_TLB_NO_ASID)
> -               __asm__ __volatile__ ("sfence.vma %0, %1"
> -                               :
> -                               : "r" (addr), "r" (asid)
> -                               : "memory");
> -       else
> -               local_flush_tlb_page(addr);
> +       if (!is_vm_hugetlb_page(vma))
> +               return PAGE_SIZE;
> +
> +       stride_size =3D huge_page_size(hstate_vma(vma));
> +
> +       /*
> +        * As stated in the privileged specification, every PTE in a
> +        * NAPOT region must be invalidated, so reset the stride in that
> +        * case.
> +        */
> +       if (has_svnapot()) {
> +               if (stride_size >=3D PGDIR_SIZE)
> +                       stride_size =3D PGDIR_SIZE;
> +               else if (stride_size >=3D P4D_SIZE)
> +                       stride_size =3D P4D_SIZE;
> +               else if (stride_size >=3D PUD_SIZE)
> +                       stride_size =3D PUD_SIZE;
> +               else if (stride_size >=3D PMD_SIZE)
> +                       stride_size =3D PMD_SIZE;
> +               else
> +                       stride_size =3D PAGE_SIZE;
> +       }
> +
> +       return stride_size;
>  }
>
>  /*
> @@ -66,31 +74,12 @@ static inline void local_flush_tlb_range_asid(unsigne=
d long start,
>                 local_flush_tlb_range_threshold_asid(start, size, stride,=
 asid);
>  }
>
> -void local_flush_tlb_kernel_range(unsigned long start, unsigned long end=
)
> -{
> -       local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_AS=
ID);
> -}
> -
> +#ifdef CONFIG_SMP
>  static void __ipi_flush_tlb_all(void *info)
>  {
>         local_flush_tlb_all();
>  }
>
> -void flush_tlb_all(void)
> -{
> -       if (riscv_use_ipi_for_rfence())
> -               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> -       else
> -               sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
> -}
> -
> -struct flush_tlb_range_data {
> -       unsigned long asid;
> -       unsigned long start;
> -       unsigned long size;
> -       unsigned long stride;
> -};
> -
>  static void __ipi_flush_tlb_range_asid(void *info)
>  {
>         struct flush_tlb_range_data *d =3D info;
> @@ -138,10 +127,18 @@ static void __flush_tlb_range(struct cpumask *cmask=
, unsigned long asid,
>                 put_cpu();
>  }
>
> -static inline unsigned long get_mm_asid(struct mm_struct *mm)
> +void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -       return static_branch_unlikely(&use_asid_allocator) ?
> -                       atomic_long_read(&mm->context.id) & asid_mask : F=
LUSH_TLB_NO_ASID;
> +       __flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm)=
,
> +                         addr, PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +void flush_tlb_all(void)
> +{
> +       if (riscv_use_ipi_for_rfence())
> +               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> +       else
> +               sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
>  }
>
>  void flush_tlb_mm(struct mm_struct *mm)
> @@ -158,41 +155,12 @@ void flush_tlb_mm_range(struct mm_struct *mm,
>                           start, end - start, page_size);
>  }
>
> -void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> -{
> -       __flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm)=
,
> -                         addr, PAGE_SIZE, PAGE_SIZE);
> -}
> -
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end)
>  {
>         unsigned long stride_size;
>
> -       if (!is_vm_hugetlb_page(vma)) {
> -               stride_size =3D PAGE_SIZE;
> -       } else {
> -               stride_size =3D huge_page_size(hstate_vma(vma));
> -
> -               /*
> -                * As stated in the privileged specification, every PTE i=
n a
> -                * NAPOT region must be invalidated, so reset the stride =
in that
> -                * case.
> -                */
> -               if (has_svnapot()) {
> -                       if (stride_size >=3D PGDIR_SIZE)
> -                               stride_size =3D PGDIR_SIZE;
> -                       else if (stride_size >=3D P4D_SIZE)
> -                               stride_size =3D P4D_SIZE;
> -                       else if (stride_size >=3D PUD_SIZE)
> -                               stride_size =3D PUD_SIZE;
> -                       else if (stride_size >=3D PMD_SIZE)
> -                               stride_size =3D PMD_SIZE;
> -                       else
> -                               stride_size =3D PAGE_SIZE;
> -               }
> -       }
> -
> +       stride_size =3D get_stride_size(vma);
>         __flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm)=
,
>                           start, end - start, stride_size);
>  }
> @@ -203,6 +171,12 @@ void flush_tlb_kernel_range(unsigned long start, uns=
igned long end)
>                           start, end - start, PAGE_SIZE);
>  }
>
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +       __flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
> +                         FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
>                         unsigned long end)
> @@ -212,6 +186,77 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma,=
 unsigned long start,
>  }
>  #endif
>
> +#else
> +static void __flush_tlb_range_up(struct mm_struct *mm, unsigned long sta=
rt,
> +                                unsigned long size, unsigned long stride=
)
> +{
> +       unsigned long asid =3D FLUSH_TLB_NO_ASID;
> +
> +       if (mm)
> +               asid =3D get_mm_asid(mm);
> +
> +       local_flush_tlb_range_asid(start, size, stride, asid);
> +}
> +
> +void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> +{
> +       local_flush_tlb_page(addr);
> +}
> +
> +void flush_tlb_all(void)
> +{
> +       local_flush_tlb_all();
> +}
> +
> +void flush_tlb_mm(struct mm_struct *mm)
> +{
> +       __flush_tlb_range_up(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +
> +void flush_tlb_mm_range(struct mm_struct *mm,
> +                       unsigned long start, unsigned long end,
> +                       unsigned int page_size)
> +{
> +       __flush_tlb_range_up(mm, start, end - start, page_size);
> +}
> +
> +void flush_tlb_range(struct vm_area_struct *vma,
> +               unsigned long start, unsigned long end)
> +{
> +       unsigned long stride_size;
> +
> +       stride_size =3D get_stride_size(vma);
> +       __flush_tlb_range_up(vma->vm_mm, start, end - start, stride_size)=
;
> +}
> +
> +/* Flush a range of kernel pages */
> +void flush_tlb_kernel_range(unsigned long start,
> +       unsigned long end)
> +{
> +       __flush_tlb_range_up(NULL, start, end - start, PAGE_SIZE);
> +}
> +
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +       __flush_tlb_range_up(NULL, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
> +                       unsigned long end)
> +{
> +       __flush_tlb_range_up(vma->vm_mm, start, end - start, PMD_SIZE);
> +}
> +#endif
> +
> +#endif
> +
> +void local_flush_tlb_kernel_range(unsigned long start, unsigned long end=
)
> +{
> +       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE,
> +                                  FLUSH_TLB_NO_ASID);
> +}
> +
>  bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>  {
>         return true;
> @@ -228,9 +273,3 @@ void arch_flush_tlb_batched_pending(struct mm_struct =
*mm)
>  {
>         flush_tlb_mm(mm);
>  }
> -
> -void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> -{
> -       __flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
> -                         FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> -}
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

