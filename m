Return-Path: <linux-kernel+bounces-43485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8598414A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C5A1F25548
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08E153BC4;
	Mon, 29 Jan 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl2GmNcl"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47154278
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561142; cv=none; b=sUSxUT4j15aXspV89X6loOzPASFN5bRoG7gvFQ3oquDJT1TabUkykCmPZU9QUQftyNQqdIIq0/ZF76foS5JK06mZtino7h+7J1Y/WlMJdvUDL7bFNOUkg1ZCXWv3XGshqkyHvKqw4bC5yYHPaOCEy+NK2iBLUGX52csNUqUTUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561142; c=relaxed/simple;
	bh=sMEE39ct6RdrfIqJWMqTT2miEq/qjAkE9JJ03GsK2oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWb+X+dL3X91+Irl+HkoLiR1LpISP7pPEf01T0fjm4tEtzOebl87WYOzIOCX/dPVaTffwKNp+yROfuumYb0jaazoOE6yZNh8iWJav0t3Cim6VjSA4Y5KNWcVNTCUWv/ObOnR8w9wCuyt0nEnjZyr/az31e/hY0fCGhd7Iz3TE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl2GmNcl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ed356a6ecso28452665e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706561138; x=1707165938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKP9s1fPlgpzq7TnTgaJGwWqGuyNQA6clVmR/5qf3Ds=;
        b=Vl2GmNclbXDMJDFiIw5KHJ3FgI4jvRrWToMco4y8paDHb/jenmnuKVTrYJweF9308O
         7/SpXErs6W1IW85jFm0f9iM3IltLuK+tUGfXUxAHlP545YAYW9U5JthZkgs7ir9/wlfa
         0h0RNR3G8WBrXzsxYQphfqkl3qvKiGx+MaLafNCnQNeHIlWDTWvtUyoumfLQMDDzH1nu
         Id9i73PSJFi/VKrHzo9UI61vSMGaRqB06W/VMOU5S83QZQGWD05EdHDeswcP/ArpNzwz
         tP8AGBxeeufZYEaVOlJYp2xXBuO7NWAs9qHjmey1OGPjXhyQZf6gF9VeqGIicOZS70Zp
         DCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706561138; x=1707165938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKP9s1fPlgpzq7TnTgaJGwWqGuyNQA6clVmR/5qf3Ds=;
        b=dXn8DXdbIFOflZYgyapirFhL68w8Q08KjJCcJ6LxvxnXV93ko57ftIyBCHN0mKnjJd
         6IDznF+M3Cc57VcD4FOllBtty++6HJwnhqKkDN15WoXCKDxRRKPL6gm6AjGACSBqRXOn
         mbss7+ZlZQXe0Nw0SlDocpygzRs6RUpHddYgG+NWmJhMZMcurCUtiILqHeg+rRc4U3cn
         V/TGGOxxoaSUpW7klezjrz6DgF+J5/7iJDJTpssOndThVQ032QhkDs1QWDyue3tHlYLj
         94+Y5oOmPowVb+kUQBSmzMd1tPILsjENJbPIzrqlMqR5WpsT8jhT6VCfMSsBmeOu/Tvd
         a2dg==
X-Gm-Message-State: AOJu0Yx4WR7QrIkH8Mn2nDXnaPYb5P9Rkl9gqwV6rAAWLN4ceQC/RT2h
	QWq69qSjN0tOjutnUuQ9yv+/Zl0smIOLl1OilZlJXG9S0Bfb9KdwJCwJDkQrulQn1/ZUSa4+gj9
	DW28pjrn+/A2MPWO8T2U9WZ/VbQA=
X-Google-Smtp-Source: AGHT+IE5Ek671tBA0IqHCVBSxhjZm1CfNJzWQWzdhO7fBSo8tQSiw6n0P10zAyQyvczyQa4Udz8EOrMemvDjIiFXt/M=
X-Received: by 2002:a05:600c:524c:b0:40e:f62b:eec0 with SMTP id
 fc12-20020a05600c524c00b0040ef62beec0mr4015551wmb.17.1706561137853; Mon, 29
 Jan 2024 12:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129134652.4004931-1-tongtiangen@huawei.com> <20240129134652.4004931-6-tongtiangen@huawei.com>
In-Reply-To: <20240129134652.4004931-6-tongtiangen@huawei.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 29 Jan 2024 21:45:26 +0100
Message-ID: <CA+fCnZf-mkSJ+8kMPi+mWOjtYzD+FAKi_ciiHt=yrbksY9W-KA@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] arm64: support copy_mc_[user]_highpage()
To: Peter Collingbourne <pcc@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com, 
	Guohanjun <guohanjun@huawei.com>, Tong Tiangen <tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:47=E2=80=AFPM Tong Tiangen <tongtiangen@huawei.co=
m> wrote:
>
> Currently, many scenarios that can tolerate memory errors when copying pa=
ge
> have been supported in the kernel[1][2][3], all of which are implemented =
by
> copy_mc_[user]_highpage(). arm64 should also support this mechanism.
>
> Due to mte, arm64 needs to have its own copy_mc_[user]_highpage()
> architecture implementation, macros __HAVE_ARCH_COPY_MC_HIGHPAGE and
> __HAVE_ARCH_COPY_MC_USER_HIGHPAGE have been added to control it.
>
> Add new helper copy_mc_page() which provide a page copy implementation wi=
th
> machine check safe. The copy_mc_page() in copy_mc_page.S is largely borro=
ws
> from copy_page() in copy_page.S and the main difference is copy_mc_page()
> add extable entry to every load/store insn to support machine check safe.
>
> Add new extable type EX_TYPE_COPY_MC_PAGE_ERR_ZERO which used in
> copy_mc_page().
>
> [1]a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults"=
)
> [2]5f2500b93cc9 ("mm/khugepaged: recover from poisoned anonymous memory")
> [3]6b970599e807 ("mm: hwpoison: support recovery from ksm_might_need_to_c=
opy()")
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/arm64/include/asm/asm-extable.h | 15 ++++++
>  arch/arm64/include/asm/assembler.h   |  4 ++
>  arch/arm64/include/asm/mte.h         |  5 ++
>  arch/arm64/include/asm/page.h        | 10 ++++
>  arch/arm64/lib/Makefile              |  2 +
>  arch/arm64/lib/copy_mc_page.S        | 78 ++++++++++++++++++++++++++++
>  arch/arm64/lib/mte.S                 | 27 ++++++++++
>  arch/arm64/mm/copypage.c             | 66 ++++++++++++++++++++---
>  arch/arm64/mm/extable.c              |  7 +--
>  include/linux/highmem.h              |  8 +++
>  10 files changed, 213 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm64/lib/copy_mc_page.S
>
> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/as=
m/asm-extable.h
> index 980d1dd8e1a3..819044fefbe7 100644
> --- a/arch/arm64/include/asm/asm-extable.h
> +++ b/arch/arm64/include/asm/asm-extable.h
> @@ -10,6 +10,7 @@
>  #define EX_TYPE_UACCESS_ERR_ZERO       2
>  #define EX_TYPE_KACCESS_ERR_ZERO       3
>  #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD 4
> +#define EX_TYPE_COPY_MC_PAGE_ERR_ZERO  5
>
>  /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
>  #define EX_DATA_REG_ERR_SHIFT  0
> @@ -51,6 +52,16 @@
>  #define _ASM_EXTABLE_UACCESS(insn, fixup)                              \
>         _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
>
> +#define _ASM_EXTABLE_COPY_MC_PAGE_ERR_ZERO(insn, fixup, err, zero)     \
> +       __ASM_EXTABLE_RAW(insn, fixup,                                  \
> +                         EX_TYPE_COPY_MC_PAGE_ERR_ZERO,                \
> +                         (                                             \
> +                           EX_DATA_REG(ERR, err) |                     \
> +                           EX_DATA_REG(ZERO, zero)                     \
> +                         ))
> +
> +#define _ASM_EXTABLE_COPY_MC_PAGE(insn, fixup)                         \
> +       _ASM_EXTABLE_COPY_MC_PAGE_ERR_ZERO(insn, fixup, wzr, wzr)
>  /*
>   * Create an exception table entry for uaccess `insn`, which will branch=
 to `fixup`
>   * when an unhandled fault is taken.
> @@ -59,6 +70,10 @@
>         _ASM_EXTABLE_UACCESS(\insn, \fixup)
>         .endm
>
> +       .macro          _asm_extable_copy_mc_page, insn, fixup
> +       _ASM_EXTABLE_COPY_MC_PAGE(\insn, \fixup)
> +       .endm
> +
>  /*
>   * Create an exception table entry for `insn` if `fixup` is provided. Ot=
herwise
>   * do nothing.
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/=
assembler.h
> index 513787e43329..e1d8ce155878 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -154,6 +154,10 @@ lr .req    x30             // link register
>  #define CPU_LE(code...) code
>  #endif
>
> +#define CPY_MC(l, x...)                \
> +9999:   x;                     \
> +       _asm_extable_copy_mc_page    9999b, l
> +
>  /*
>   * Define a macro that constructs a 64-bit value by concatenating two
>   * 32-bit registers. Note that on big endian systems the order of the
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 91fbd5c8a391..9cdded082dd4 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -92,6 +92,7 @@ static inline bool try_page_mte_tagging(struct page *pa=
ge)
>  void mte_zero_clear_page_tags(void *addr);
>  void mte_sync_tags(pte_t pte, unsigned int nr_pages);
>  void mte_copy_page_tags(void *kto, const void *kfrom);
> +int mte_copy_mc_page_tags(void *kto, const void *kfrom);
>  void mte_thread_init_user(void);
>  void mte_thread_switch(struct task_struct *next);
>  void mte_cpu_setup(void);
> @@ -128,6 +129,10 @@ static inline void mte_sync_tags(pte_t pte, unsigned=
 int nr_pages)
>  static inline void mte_copy_page_tags(void *kto, const void *kfrom)
>  {
>  }
> +static inline int mte_copy_mc_page_tags(void *kto, const void *kfrom)
> +{
> +       return 0;
> +}
>  static inline void mte_thread_init_user(void)
>  {
>  }
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.=
h
> index 2312e6ee595f..304cc86b8a10 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -29,6 +29,16 @@ void copy_user_highpage(struct page *to, struct page *=
from,
>  void copy_highpage(struct page *to, struct page *from);
>  #define __HAVE_ARCH_COPY_HIGHPAGE
>
> +#ifdef CONFIG_ARCH_HAS_COPY_MC
> +int copy_mc_page(void *to, const void *from);
> +int copy_mc_highpage(struct page *to, struct page *from);
> +#define __HAVE_ARCH_COPY_MC_HIGHPAGE
> +
> +int copy_mc_user_highpage(struct page *to, struct page *from,
> +               unsigned long vaddr, struct vm_area_struct *vma);
> +#define __HAVE_ARCH_COPY_MC_USER_HIGHPAGE
> +#endif
> +
>  struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>                                                 unsigned long vaddr);
>  #define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 29490be2546b..a2fd865b816d 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -15,6 +15,8 @@ endif
>
>  lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) +=3D uaccess_flushcache.o
>
> +lib-$(CONFIG_ARCH_HAS_COPY_MC) +=3D copy_mc_page.o
> +
>  obj-$(CONFIG_CRC32) +=3D crc32.o
>
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
> diff --git a/arch/arm64/lib/copy_mc_page.S b/arch/arm64/lib/copy_mc_page.=
S
> new file mode 100644
> index 000000000000..524534d26d86
> --- /dev/null
> +++ b/arch/arm64/lib/copy_mc_page.S
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + */
> +
> +#include <linux/linkage.h>
> +#include <linux/const.h>
> +#include <asm/assembler.h>
> +#include <asm/page.h>
> +#include <asm/cpufeature.h>
> +#include <asm/alternative.h>
> +#include <asm/asm-extable.h>
> +
> +/*
> + * Copy a page from src to dest (both are page aligned) with machine che=
ck
> + *
> + * Parameters:
> + *     x0 - dest
> + *     x1 - src
> + * Returns:
> + *     x0 - Return 0 if copy success, or -EFAULT if anything goes wrong
> + *          while copying.
> + */
> +SYM_FUNC_START(__pi_copy_mc_page)
> +CPY_MC(9998f, ldp      x2, x3, [x1])
> +CPY_MC(9998f, ldp      x4, x5, [x1, #16])
> +CPY_MC(9998f, ldp      x6, x7, [x1, #32])
> +CPY_MC(9998f, ldp      x8, x9, [x1, #48])
> +CPY_MC(9998f, ldp      x10, x11, [x1, #64])
> +CPY_MC(9998f, ldp      x12, x13, [x1, #80])
> +CPY_MC(9998f, ldp      x14, x15, [x1, #96])
> +CPY_MC(9998f, ldp      x16, x17, [x1, #112])
> +
> +       add     x0, x0, #256
> +       add     x1, x1, #128
> +1:
> +       tst     x0, #(PAGE_SIZE - 1)
> +
> +CPY_MC(9998f, stnp     x2, x3, [x0, #-256])
> +CPY_MC(9998f, ldp      x2, x3, [x1])
> +CPY_MC(9998f, stnp     x4, x5, [x0, #16 - 256])
> +CPY_MC(9998f, ldp      x4, x5, [x1, #16])
> +CPY_MC(9998f, stnp     x6, x7, [x0, #32 - 256])
> +CPY_MC(9998f, ldp      x6, x7, [x1, #32])
> +CPY_MC(9998f, stnp     x8, x9, [x0, #48 - 256])
> +CPY_MC(9998f, ldp      x8, x9, [x1, #48])
> +CPY_MC(9998f, stnp     x10, x11, [x0, #64 - 256])
> +CPY_MC(9998f, ldp      x10, x11, [x1, #64])
> +CPY_MC(9998f, stnp     x12, x13, [x0, #80 - 256])
> +CPY_MC(9998f, ldp      x12, x13, [x1, #80])
> +CPY_MC(9998f, stnp     x14, x15, [x0, #96 - 256])
> +CPY_MC(9998f, ldp      x14, x15, [x1, #96])
> +CPY_MC(9998f, stnp     x16, x17, [x0, #112 - 256])
> +CPY_MC(9998f, ldp      x16, x17, [x1, #112])
> +
> +       add     x0, x0, #128
> +       add     x1, x1, #128
> +
> +       b.ne    1b
> +
> +CPY_MC(9998f, stnp     x2, x3, [x0, #-256])
> +CPY_MC(9998f, stnp     x4, x5, [x0, #16 - 256])
> +CPY_MC(9998f, stnp     x6, x7, [x0, #32 - 256])
> +CPY_MC(9998f, stnp     x8, x9, [x0, #48 - 256])
> +CPY_MC(9998f, stnp     x10, x11, [x0, #64 - 256])
> +CPY_MC(9998f, stnp     x12, x13, [x0, #80 - 256])
> +CPY_MC(9998f, stnp     x14, x15, [x0, #96 - 256])
> +CPY_MC(9998f, stnp     x16, x17, [x0, #112 - 256])
> +
> +       mov x0, #0
> +       ret
> +
> +9998:  mov x0, #-EFAULT
> +       ret
> +
> +SYM_FUNC_END(__pi_copy_mc_page)
> +SYM_FUNC_ALIAS(copy_mc_page, __pi_copy_mc_page)
> +EXPORT_SYMBOL(copy_mc_page)
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 5018ac03b6bf..2b748e83f6cf 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -80,6 +80,33 @@ SYM_FUNC_START(mte_copy_page_tags)
>         ret
>  SYM_FUNC_END(mte_copy_page_tags)
>
> +/*
> + * Copy the tags from the source page to the destination one wiht machin=
e check safe
> + *   x0 - address of the destination page
> + *   x1 - address of the source page
> + * Returns:
> + *   x0 - Return 0 if copy success, or
> + *        -EFAULT if anything goes wrong while copying.
> + */
> +SYM_FUNC_START(mte_copy_mc_page_tags)
> +       mov     x2, x0
> +       mov     x3, x1
> +       multitag_transfer_size x5, x6
> +1:
> +CPY_MC(2f, ldgm        x4, [x3])
> +CPY_MC(2f, stgm        x4, [x2])
> +       add     x2, x2, x5
> +       add     x3, x3, x5
> +       tst     x2, #(PAGE_SIZE - 1)
> +       b.ne    1b
> +
> +       mov x0, #0
> +       ret
> +
> +2:     mov x0, #-EFAULT
> +       ret
> +SYM_FUNC_END(mte_copy_mc_page_tags)
> +
>  /*
>   * Read tags from a user buffer (one tag per byte) and set the correspon=
ding
>   * tags at the given kernel address. Used by PTRACE_POKEMTETAGS.
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index a7bb20055ce0..9765e40cde6c 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -14,6 +14,25 @@
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
>
> +static int do_mte(struct page *to, struct page *from, void *kto, void *k=
from, bool mc)
> +{
> +       int ret =3D 0;
> +
> +       if (system_supports_mte() && page_mte_tagged(from)) {
> +               /* It's a new page, shouldn't have been tagged yet */
> +               WARN_ON_ONCE(!try_page_mte_tagging(to));
> +               if (mc)
> +                       ret =3D mte_copy_mc_page_tags(kto, kfrom);
> +               else
> +                       mte_copy_page_tags(kto, kfrom);
> +
> +               if (!ret)
> +                       set_page_mte_tagged(to);
> +       }
> +
> +       return ret;
> +}
> +
>  void copy_highpage(struct page *to, struct page *from)
>  {
>         void *kto =3D page_address(to);
> @@ -24,12 +43,7 @@ void copy_highpage(struct page *to, struct page *from)
>         if (kasan_hw_tags_enabled())
>                 page_kasan_tag_reset(to);
>
> -       if (system_supports_mte() && page_mte_tagged(from)) {
> -               /* It's a new page, shouldn't have been tagged yet */
> -               WARN_ON_ONCE(!try_page_mte_tagging(to));
> -               mte_copy_page_tags(kto, kfrom);
> -               set_page_mte_tagged(to);
> -       }
> +       do_mte(to, from, kto, kfrom, false);
>  }
>  EXPORT_SYMBOL(copy_highpage);
>
> @@ -40,3 +54,43 @@ void copy_user_highpage(struct page *to, struct page *=
from,
>         flush_dcache_page(to);
>  }
>  EXPORT_SYMBOL_GPL(copy_user_highpage);
> +
> +#ifdef CONFIG_ARCH_HAS_COPY_MC
> +/*
> + * Return -EFAULT if anything goes wrong while copying page or mte.
> + */
> +int copy_mc_highpage(struct page *to, struct page *from)
> +{
> +       void *kto =3D page_address(to);
> +       void *kfrom =3D page_address(from);
> +       int ret;
> +
> +       ret =3D copy_mc_page(kto, kfrom);
> +       if (ret)
> +               return -EFAULT;
> +
> +       if (kasan_hw_tags_enabled())
> +               page_kasan_tag_reset(to);
> +
> +       ret =3D do_mte(to, from, kto, kfrom, true);
> +       if (ret)
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(copy_mc_highpage);
> +
> +int copy_mc_user_highpage(struct page *to, struct page *from,
> +                       unsigned long vaddr, struct vm_area_struct *vma)
> +{
> +       int ret;
> +
> +       ret =3D copy_mc_highpage(to, from);
> +
> +       if (!ret)
> +               flush_dcache_page(to);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_mc_user_highpage);
> +#endif
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 28ec35e3d210..bdc81518d207 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -16,7 +16,7 @@ get_ex_fixup(const struct exception_table_entry *ex)
>         return ((unsigned long)&ex->fixup + ex->fixup);
>  }
>
> -static bool ex_handler_uaccess_err_zero(const struct exception_table_ent=
ry *ex,
> +static bool ex_handler_fixup_err_zero(const struct exception_table_entry=
 *ex,
>                                         struct pt_regs *regs)
>  {
>         int reg_err =3D FIELD_GET(EX_DATA_REG_ERR, ex->data);
> @@ -69,7 +69,7 @@ bool fixup_exception(struct pt_regs *regs)
>                 return ex_handler_bpf(ex, regs);
>         case EX_TYPE_UACCESS_ERR_ZERO:
>         case EX_TYPE_KACCESS_ERR_ZERO:
> -               return ex_handler_uaccess_err_zero(ex, regs);
> +               return ex_handler_fixup_err_zero(ex, regs);
>         case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
>                 return ex_handler_load_unaligned_zeropad(ex, regs);
>         }
> @@ -87,7 +87,8 @@ bool fixup_exception_mc(struct pt_regs *regs)
>
>         switch (ex->type) {
>         case EX_TYPE_UACCESS_ERR_ZERO:
> -               return ex_handler_uaccess_err_zero(ex, regs);
> +       case EX_TYPE_COPY_MC_PAGE_ERR_ZERO:
> +               return ex_handler_fixup_err_zero(ex, regs);
>         }
>
>         return false;
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index c5ca1a1fc4f5..a42470ca42f2 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -332,6 +332,7 @@ static inline void copy_highpage(struct page *to, str=
uct page *from)
>  #endif
>
>  #ifdef copy_mc_to_kernel
> +#ifndef __HAVE_ARCH_COPY_MC_USER_HIGHPAGE
>  /*
>   * If architecture supports machine check exception handling, define the
>   * #MC versions of copy_user_highpage and copy_highpage. They copy a mem=
ory
> @@ -354,7 +355,9 @@ static inline int copy_mc_user_highpage(struct page *=
to, struct page *from,
>
>         return ret ? -EFAULT : 0;
>  }
> +#endif
>
> +#ifndef __HAVE_ARCH_COPY_MC_HIGHPAGE
>  static inline int copy_mc_highpage(struct page *to, struct page *from)
>  {
>         unsigned long ret;
> @@ -370,20 +373,25 @@ static inline int copy_mc_highpage(struct page *to,=
 struct page *from)
>
>         return ret ? -EFAULT : 0;
>  }
> +#endif
>  #else
> +#ifndef __HAVE_ARCH_COPY_MC_USER_HIGHPAGE
>  static inline int copy_mc_user_highpage(struct page *to, struct page *fr=
om,
>                                         unsigned long vaddr, struct vm_ar=
ea_struct *vma)
>  {
>         copy_user_highpage(to, from, vaddr, vma);
>         return 0;
>  }
> +#endif
>
> +#ifndef __HAVE_ARCH_COPY_MC_HIGHPAGE
>  static inline int copy_mc_highpage(struct page *to, struct page *from)
>  {
>         copy_highpage(to, from);
>         return 0;
>  }
>  #endif
> +#endif
>
>  static inline void memcpy_page(struct page *dst_page, size_t dst_off,
>                                struct page *src_page, size_t src_off,
> --
> 2.25.1
>

+Peter

