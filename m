Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B908769933
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGaOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjGaOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:16:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68AAD8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B18861176
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0B5C433BA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690812956;
        bh=N6VodkJW/ivyWk15n1haH9P1k1P3MyTjQDb5k+QEWBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PUfpn8dpxcKPkxEEdWbhLVGphnhnz/ZACV+NZmNjo5cQGXgKmwNiJoxV4QldH52qI
         Z+UCh+qwgEWlIs46LByp13PDrKj1/Xv+ipy7hjtrU1fWEu8NoD4iCAsHrHGOjhBxog
         60jbZu4zUUrrmPmbyv5VkZ6YSjei27MvH8NDfMhk/LcXaI4BZHmh8RG58O8TS+yV9V
         9y5fiLvNCqIJ9+GKsyt3pMkfJCa3JQNgAjGue/4lw/eljzqOUEVZBDOZg2RMvDNIy9
         7mFqluiiG2AlKlucrTOLmAVFDVcBLpDSGGU+ZJbx/Gc56Fd7rdfIhFqyY3Q2j9GEMZ
         haYOSWuAwYROw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-522bc9556f5so2617360a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:15:56 -0700 (PDT)
X-Gm-Message-State: ABy/qLYzur8m4oObmH6DUsaQ06AoRxvv7Jve9VmuAhO3Ieum2ywZI60x
        ZTNEMJjF/7m4pW8b1f8n5Kjpwd5rjr7/D0tsqWk=
X-Google-Smtp-Source: APBJJlEPZBC9yMb8MKDA0PdnxVuDFgj0KW7MwQBZ/mZNmqz1cM3+TaM3W9/7LN//t71s+eQKxjKZL5m4BzWjOCvDRJ4=
X-Received: by 2002:a05:6402:702:b0:522:ae79:3ede with SMTP id
 w2-20020a056402070200b00522ae793edemr69251edx.11.1690812954996; Mon, 31 Jul
 2023 07:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230712031622.1888321-1-maobibo@loongson.cn> <20230712031622.1888321-4-maobibo@loongson.cn>
In-Reply-To: <20230712031622.1888321-4-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 31 Jul 2023 22:15:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5pHoFo7i8EpacLU=AWKKPckssJN1aThi+Bb8PPHn0gkA@mail.gmail.com>
Message-ID: <CAAhV-H5pHoFo7i8EpacLU=AWKKPckssJN1aThi+Bb8PPHn0gkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: mm: Add unified function populate_kernel_pte
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:16=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Function pcpu_populate_pte and fixmap_pte are similar, they populate
> one page from kernel address space. And there is confusion between
> pgd and p4d in function fixmap_pte, such as pgd_none always returns
> zero. This patch adds unified function populate_kernel_pte and replaces
> pcpu_populate_pte and fixmap_pte.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgalloc.h |  1 +
>  arch/loongarch/kernel/numa.c         | 40 +--------------------
>  arch/loongarch/mm/init.c             | 52 ++++++++++++++++------------
>  3 files changed, 32 insertions(+), 61 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/includ=
e/asm/pgalloc.h
> index af1d1e4a6965..ca17b573dba6 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -91,4 +91,5 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm=
, unsigned long address)
>
>  #endif /* __PAGETABLE_PUD_FOLDED */
>
> +extern pte_t * __init populate_kernel_pte(unsigned long addr);
>  #endif /* _ASM_PGALLOC_H */
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 778e1c20bfb0..24a693b76873 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -67,46 +67,8 @@ static int __init pcpu_cpu_distance(unsigned int from,=
 unsigned int to)
>
>  void __init pcpu_populate_pte(unsigned long addr)
>  {
> -       pgd_t *pgd =3D pgd_offset_k(addr);
> -       p4d_t *p4d =3D p4d_offset(pgd, addr);
> -       pud_t *pud;
> -       pmd_t *pmd;
> -
> -       if (p4d_none(*p4d)) {
> -               pud =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> -               if (!pud)
> -                       goto err_alloc;
> -               p4d_populate(&init_mm, p4d, pud);
> -#ifndef __PAGETABLE_PUD_FOLDED
> -               pud_init(pud);
> -#endif
> -       }
> -
> -       pud =3D pud_offset(p4d, addr);
> -       if (pud_none(*pud)) {
> -               pmd =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> -               if (!pmd)
> -                       goto err_alloc;
> -               pud_populate(&init_mm, pud, pmd);
> -#ifndef __PAGETABLE_PMD_FOLDED
> -               pmd_init(pmd);
> -#endif
> -       }
> -
> -       pmd =3D pmd_offset(pud, addr);
> -       if (!pmd_present(*pmd)) {
> -               pte_t *pte;
> -
> -               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -               if (!pte)
> -                       goto err_alloc;
> -               pmd_populate_kernel(&init_mm, pmd, pte);
> -       }
> -
> +       populate_kernel_pte(addr);
>         return;
> -
> -err_alloc:
> -       panic("%s: Failed to allocate memory\n", __func__);
>  }
>
>  void __init setup_per_cpu_areas(void)
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index 3b7d8129570b..6cd2948373ae 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -191,46 +191,49 @@ void vmemmap_free(unsigned long start, unsigned lon=
g end, struct vmem_altmap *al
>  #endif
>  #endif
>
> -static pte_t *fixmap_pte(unsigned long addr)
> +pte_t * __init populate_kernel_pte(unsigned long addr)
>  {
> -       pgd_t *pgd;
> -       p4d_t *p4d;
> +       pgd_t *pgd =3D pgd_offset_k(addr);
> +       p4d_t *p4d =3D p4d_offset(pgd, addr);
>         pud_t *pud;
>         pmd_t *pmd;
>
> -       pgd =3D pgd_offset_k(addr);
> -       p4d =3D p4d_offset(pgd, addr);
> -
> -       if (pgd_none(*pgd)) {
> -               pud_t *new __maybe_unused;
> -
> -               new =3D memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> -               pgd_populate(&init_mm, pgd, new);
> +       if (p4d_none(*p4d)) {
> +               pud =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> +               if (!pud)
> +                       goto err_alloc;
> +               p4d_populate(&init_mm, p4d, pud);
>  #ifndef __PAGETABLE_PUD_FOLDED
> -               pud_init(new);
> +               pud_init(pud);
>  #endif
>         }
>
>         pud =3D pud_offset(p4d, addr);
>         if (pud_none(*pud)) {
> -               pmd_t *new __maybe_unused;
> -
> -               new =3D memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> -               pud_populate(&init_mm, pud, new);
> +               pmd =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> +               if (!pmd)
> +                       goto err_alloc;
> +               pud_populate(&init_mm, pud, pmd);
>  #ifndef __PAGETABLE_PMD_FOLDED
> -               pmd_init(new);
> +               pmd_init(pmd);
>  #endif
>         }
>
>         pmd =3D pmd_offset(pud, addr);
> -       if (pmd_none(*pmd)) {
> -               pte_t *new __maybe_unused;
> +       if (!pmd_present(*pmd)) {
> +               pte_t *pte;
>
> -               new =3D memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> -               pmd_populate_kernel(&init_mm, pmd, new);
> +               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
I don't think memblock_alloc_low() here can be replaced by memblock_alloc()=
.


Huacai
> +               if (!pte)
> +                       goto err_alloc;
> +               pmd_populate_kernel(&init_mm, pmd, pte);
>         }
>
>         return pte_offset_kernel(pmd, addr);
> +
> +err_alloc:
> +       panic("%s: Failed to allocate memory\n", __func__);
> +       return NULL;
>  }
>
>  void __init __set_fixmap(enum fixed_addresses idx,
> @@ -241,7 +244,12 @@ void __init __set_fixmap(enum fixed_addresses idx,
>
>         BUG_ON(idx <=3D FIX_HOLE || idx >=3D __end_of_fixed_addresses);
>
> -       ptep =3D fixmap_pte(addr);
> +       /*
> +        * Now only FIX_EARLYCON_MEM_BASE fixed map is used
> +        * __set_fixmap must be called before mem_init since function
> +        * populate_kernel_pte allocates memory with memblock_alloc metho=
d.
> +        */
> +       ptep =3D populate_kernel_pte(addr);
>         if (!pte_none(*ptep)) {
>                 pte_ERROR(*ptep);
>                 return;
> --
> 2.27.0
>
