Return-Path: <linux-kernel+bounces-141909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9540E8A2507
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CA61C230DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71C1D6BD;
	Fri, 12 Apr 2024 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2F8IuTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CC18633
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895159; cv=none; b=pq/wMLQ8v3GiLxDKzaCj0mtbp3vM2BPgvMaHSezu4y5FiKdcOYSTQDtekKdiQqSmf+DhUVUnDuyvv0Hv/il2+Q0C84COL89eQDiBokE76pnBsEKF8qcjRRWzotUH0Lofrq8xeE7WopCbuqyVwlIRhZZTuE6cmyDljjSE02nzPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895159; c=relaxed/simple;
	bh=Cxe0KEo5HYGIG3uR4CS3mYn9ImiPTk34Rc1Q3j9rM4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQtmjITiWL6WeMmhroDUfQdmgWiSDcGV59ECSOjBxEUiJfR72+q3HcU56Eoj2zchnjZkCOhllk+cf25FhaKmDL7NgpGW75wWngjQ11GGo5GWfrRLq+1V1xoI7IzF8EtdiABGpGgHv5RmQxJstlHzOgtVJWF/+OYpGtAkNZM4NV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2F8IuTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D77C32781
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712895159;
	bh=Cxe0KEo5HYGIG3uR4CS3mYn9ImiPTk34Rc1Q3j9rM4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r2F8IuTK4sikJ+Pou47SWUWgxzG54/DdqSWoIc/+Mowpd67wIsCbkrxU10sgKECyy
	 BE+psPx0XOQVNpeM/1Pii9YkuCXK/npyCLdZOjYxF7R0Hgr53ArPYeM2zhHrUU5nNG
	 Y1z/ky8ppyF4829g1dTI3sMRBG+GQ1TjzxVpTiIs7Mh2ACCfwPFr6GJcs2CWqkpZh7
	 hH7RYcnweMDYZuglAN+6ueMY8T2OBjL8gO2MJh1TnX5GuST5qtUi8mzCdJA/CbUvpu
	 RERPTEo2ks+r7Kn/FjbuHZ+ca7iFqLl5SPHIxtLPp0Ew/WKjKcD/pQTxBaCxPPcD0Y
	 rq/BMiHzrWhjg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4702457ccbso48660066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:12:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQTLQZh/19Ftcq7SswNyMRKmG/4Jb5GVWpcVdFX/Hg7wQVU5rPqh8ojBwmxfbN9CS2BlzL8UpvX+pvx4etrpnVhdbT8sdDNRH/mFss
X-Gm-Message-State: AOJu0YxMC/qqFCbCVuq/+y2oxARlicDLfgv3vX1UHJcMFimyl+BxRGgy
	6Y5tkUMguxJVVIt3gjBuIBYX96sIZlP0LqLZz9F5EimxvdFwayCzvs6eQ1JfqQkT1cOYESj8HD2
	pOJfuxggXx6FMgaWt0NzkjoFCT6Q=
X-Google-Smtp-Source: AGHT+IHEN3YuDi9aWyK/O9J7zZTQ0B1yZp/YaIsLZymqc/hpdrQrpSqJyjbcQyaJVA4ZhFWO6g4su/V+eiAkxJDq1o4=
X-Received: by 2002:a17:906:80c7:b0:a52:2e54:7022 with SMTP id
 a7-20020a17090680c700b00a522e547022mr825073ejx.10.1712895157514; Thu, 11 Apr
 2024 21:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411010510.22135-1-yangtiezhu@loongson.cn> <20240411010510.22135-2-yangtiezhu@loongson.cn>
In-Reply-To: <20240411010510.22135-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Apr 2024 12:12:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6TVEEB=xdr_ymuUnDqPDXwtM7R7yJBj03YhWpCwqjAiA@mail.gmail.com>
Message-ID: <CAAhV-H6TVEEB=xdr_ymuUnDqPDXwtM7R7yJBj03YhWpCwqjAiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] LoongArch: Move CONFIG_HAVE_SETUP_PER_CPU_AREA
 related code to smp.c
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 9:05=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, if CONFIG_NUMA is not set but CONFIG_SMP is set, the arch
> specified setup_per_cpu_areas() in arch/loongarch/kernel/numa.c will
> not be built and the generic setup_per_cpu_areas() in mm/percpu.c is
> actually used, this is not reasonable and does not work as intended.
Why is the generic version not reasonable? We need a custom version
just because it can put the percpu variable in the best node. If NUMA
disabled, software can only see one node, how to optimize?

Huacai

>
> Let us select HAVE_SETUP_PER_CPU_AREA unconditionally and then move
> CONFIG_HAVE_SETUP_PER_CPU_AREA related code from numa.c to smp.c to
> avoid this problem.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig       |  2 +-
>  arch/loongarch/kernel/numa.c | 58 -----------------------------------
>  arch/loongarch/kernel/smp.c  | 59 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 59 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..64052ae2c2af 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -151,7 +151,7 @@ config LOONGARCH
>         select HAVE_RUST
>         select HAVE_SAMPLE_FTRACE_DIRECT
>         select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> -       select HAVE_SETUP_PER_CPU_AREA if NUMA
> +       select HAVE_SETUP_PER_CPU_AREA
>         select HAVE_STACK_VALIDATION if HAVE_OBJTOOL
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 8fe21f868f72..49dc1d932ce2 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -48,64 +48,6 @@ EXPORT_SYMBOL(__cpuid_to_node);
>
>  nodemask_t numa_nodes_parsed __initdata;
>
> -#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
> -unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
> -EXPORT_SYMBOL(__per_cpu_offset);
> -
> -static int __init pcpu_cpu_to_node(int cpu)
> -{
> -       return early_cpu_to_node(cpu);
> -}
> -
> -static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
> -{
> -       if (early_cpu_to_node(from) =3D=3D early_cpu_to_node(to))
> -               return LOCAL_DISTANCE;
> -       else
> -               return REMOTE_DISTANCE;
> -}
> -
> -void __init pcpu_populate_pte(unsigned long addr)
> -{
> -       populate_kernel_pte(addr);
> -}
> -
> -void __init setup_per_cpu_areas(void)
> -{
> -       unsigned long delta;
> -       unsigned int cpu;
> -       int rc =3D -EINVAL;
> -
> -       if (pcpu_chosen_fc =3D=3D PCPU_FC_AUTO) {
> -               if (nr_node_ids >=3D 8)
> -                       pcpu_chosen_fc =3D PCPU_FC_PAGE;
> -               else
> -                       pcpu_chosen_fc =3D PCPU_FC_EMBED;
> -       }
> -
> -       /*
> -        * Always reserve area for module percpu variables.  That's
> -        * what the legacy allocator did.
> -        */
> -       if (pcpu_chosen_fc !=3D PCPU_FC_PAGE) {
> -               rc =3D pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
> -                                           PERCPU_DYNAMIC_RESERVE, PMD_S=
IZE,
> -                                           pcpu_cpu_distance, pcpu_cpu_t=
o_node);
> -               if (rc < 0)
> -                       pr_warn("%s allocator failed (%d), falling back t=
o page size\n",
> -                               pcpu_fc_names[pcpu_chosen_fc], rc);
> -       }
> -       if (rc < 0)
> -               rc =3D pcpu_page_first_chunk(PERCPU_MODULE_RESERVE, pcpu_=
cpu_to_node);
> -       if (rc < 0)
> -               panic("cannot initialize percpu area (err=3D%d)", rc);
> -
> -       delta =3D (unsigned long)pcpu_base_addr - (unsigned long)__per_cp=
u_start;
> -       for_each_possible_cpu(cpu)
> -               __per_cpu_offset[cpu] =3D delta + pcpu_unit_offsets[cpu];
> -}
> -#endif
> -
>  /*
>   * Get nodeid by logical cpu number.
>   * __cpuid_to_node maps phyical cpu id to node, so we
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index aabee0b280fe..88b9c6b68d1e 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -29,6 +29,7 @@
>  #include <asm/loongson.h>
>  #include <asm/mmu_context.h>
>  #include <asm/numa.h>
> +#include <asm/pgalloc.h>
>  #include <asm/processor.h>
>  #include <asm/setup.h>
>  #include <asm/time.h>
> @@ -717,3 +718,61 @@ void flush_tlb_one(unsigned long vaddr)
>         on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
>  }
>  EXPORT_SYMBOL(flush_tlb_one);
> +
> +#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
> +unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
> +EXPORT_SYMBOL(__per_cpu_offset);
> +
> +static int __init pcpu_cpu_to_node(int cpu)
> +{
> +       return early_cpu_to_node(cpu);
> +}
> +
> +static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
> +{
> +       if (early_cpu_to_node(from) =3D=3D early_cpu_to_node(to))
> +               return LOCAL_DISTANCE;
> +       else
> +               return REMOTE_DISTANCE;
> +}
> +
> +void __init pcpu_populate_pte(unsigned long addr)
> +{
> +       populate_kernel_pte(addr);
> +}
> +
> +void __init setup_per_cpu_areas(void)
> +{
> +       unsigned long delta;
> +       unsigned int cpu;
> +       int rc =3D -EINVAL;
> +
> +       if (pcpu_chosen_fc =3D=3D PCPU_FC_AUTO) {
> +               if (nr_node_ids >=3D 8)
> +                       pcpu_chosen_fc =3D PCPU_FC_PAGE;
> +               else
> +                       pcpu_chosen_fc =3D PCPU_FC_EMBED;
> +       }
> +
> +       /*
> +        * Always reserve area for module percpu variables.  That's
> +        * what the legacy allocator did.
> +        */
> +       if (pcpu_chosen_fc !=3D PCPU_FC_PAGE) {
> +               rc =3D pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
> +                                           PERCPU_DYNAMIC_RESERVE, PMD_S=
IZE,
> +                                           pcpu_cpu_distance, pcpu_cpu_t=
o_node);
> +               if (rc < 0)
> +                       pr_warn("%s allocator failed (%d), falling back t=
o page size\n",
> +                               pcpu_fc_names[pcpu_chosen_fc], rc);
> +       }
> +       if (rc < 0)
> +               rc =3D pcpu_page_first_chunk(PERCPU_MODULE_RESERVE, pcpu_=
cpu_to_node);
> +       if (rc < 0)
> +               panic("cannot initialize percpu area (err=3D%d)", rc);
> +
> +       delta =3D (unsigned long)pcpu_base_addr - (unsigned long)__per_cp=
u_start;
> +       for_each_possible_cpu(cpu)
> +               __per_cpu_offset[cpu] =3D delta + pcpu_unit_offsets[cpu];
> +}
> +#endif
> --
> 2.42.0
>
>

