Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F60D776F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjHJE13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHJE11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:27:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCA31702
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DD8B647E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F38C433C8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691641645;
        bh=fPA9xRRA6+BAzg1S3f5+BWPETMEsncjG024BmrqNAgI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R8D35EIdK7ElUXcavekflNdEHdZo3dt8eKdrwjQdZbTy6SOFW+0WD5kaOMeYBAAtX
         EIUDPwGdsU++nsQopAEQpyKpFJ0jelb0jcUau1bQNUWI8goTqNjr4EPiH0t7hNVnkl
         S3bbsDYjaJ3Z6s/OokP/izARQrsGmfkWJkoo4bcqIGP3Hq/si13WYdiAmapb5wlYqT
         tOyikTjKhGbYBu/3y/8y0SUOzKD/+sZkuL+SQXjWWsrpRD6P/cRnMl6DQedNHjBmjw
         oPdknnsxuZDKETFW4gtwxekPSNdUgB4OI1rUygDT1rL+nGuDd30rOxZ6BAzp8PpfAv
         Y+IkigrK1iC8Q==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99357737980so72011866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:27:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQm/60zxOa27CMGLXvn82VzvTUbvVHg4A+Pu7FOFeH8JUQVrrD
        qLJctnN+D9SMRrcW+ljpT2Mevkz5oYHA70VqFHU=
X-Google-Smtp-Source: AGHT+IFB9Cpc8XTuN88wcX4sLDnjrEO81HoYsjBr+Nl8UlL/7LtZzyv3JjbSmr+06NF3+liJIWF2AmB0MLtABGM5hms=
X-Received: by 2002:a17:906:11e:b0:99b:dca9:5b8f with SMTP id
 30-20020a170906011e00b0099bdca95b8fmr1096110eje.56.1691641644091; Wed, 09 Aug
 2023 21:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230712031622.1888321-1-maobibo@loongson.cn> <20230712031622.1888321-4-maobibo@loongson.cn>
 <CAAhV-H5pHoFo7i8EpacLU=AWKKPckssJN1aThi+Bb8PPHn0gkA@mail.gmail.com>
 <e6139ffa-92e5-8247-ba0b-71def4795104@loongson.cn> <CAAhV-H7Y9SGaLA3+x8-kMg0eWW3UeGLTGMnmcTp7xftJPiJSoA@mail.gmail.com>
 <b4b21efb-a0c7-4625-91e7-4d0c5b80a249@loongson.cn>
In-Reply-To: <b4b21efb-a0c7-4625-91e7-4d0c5b80a249@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 10 Aug 2023 12:27:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7kBP-qME2mxwQKqYeggWu4ApqAJukz3eZxfqsYzRvGEA@mail.gmail.com>
Message-ID: <CAAhV-H7kBP-qME2mxwQKqYeggWu4ApqAJukz3eZxfqsYzRvGEA@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: mm: Add unified function populate_kernel_pte
To:     bibo mao <maobibo@loongson.cn>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:09=E2=80=AFPM bibo mao <maobibo@loongson.cn> wro=
te:
>
>
>
> =E5=9C=A8 2023/8/2 15:25, Huacai Chen =E5=86=99=E9=81=93:
> > On Tue, Aug 1, 2023 at 9:22=E2=80=AFAM bibo mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> =E5=9C=A8 2023/7/31 22:15, Huacai Chen =E5=86=99=E9=81=93:
> >>> On Wed, Jul 12, 2023 at 11:16=E2=80=AFAM Bibo Mao <maobibo@loongson.c=
n> wrote:
> >>>>
> >>>> Function pcpu_populate_pte and fixmap_pte are similar, they populate
> >>>> one page from kernel address space. And there is confusion between
> >>>> pgd and p4d in function fixmap_pte, such as pgd_none always returns
> >>>> zero. This patch adds unified function populate_kernel_pte and repla=
ces
> >>>> pcpu_populate_pte and fixmap_pte.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>  arch/loongarch/include/asm/pgalloc.h |  1 +
> >>>>  arch/loongarch/kernel/numa.c         | 40 +--------------------
> >>>>  arch/loongarch/mm/init.c             | 52 ++++++++++++++++---------=
---
> >>>>  3 files changed, 32 insertions(+), 61 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/i=
nclude/asm/pgalloc.h
> >>>> index af1d1e4a6965..ca17b573dba6 100644
> >>>> --- a/arch/loongarch/include/asm/pgalloc.h
> >>>> +++ b/arch/loongarch/include/asm/pgalloc.h
> >>>> @@ -91,4 +91,5 @@ static inline pud_t *pud_alloc_one(struct mm_struc=
t *mm, unsigned long address)
> >>>>
> >>>>  #endif /* __PAGETABLE_PUD_FOLDED */
> >>>>
> >>>> +extern pte_t * __init populate_kernel_pte(unsigned long addr);
> >>>>  #endif /* _ASM_PGALLOC_H */
> >>>> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/nu=
ma.c
> >>>> index 778e1c20bfb0..24a693b76873 100644
> >>>> --- a/arch/loongarch/kernel/numa.c
> >>>> +++ b/arch/loongarch/kernel/numa.c
> >>>> @@ -67,46 +67,8 @@ static int __init pcpu_cpu_distance(unsigned int =
from, unsigned int to)
> >>>>
> >>>>  void __init pcpu_populate_pte(unsigned long addr)
> >>>>  {
> >>>> -       pgd_t *pgd =3D pgd_offset_k(addr);
> >>>> -       p4d_t *p4d =3D p4d_offset(pgd, addr);
> >>>> -       pud_t *pud;
> >>>> -       pmd_t *pmd;
> >>>> -
> >>>> -       if (p4d_none(*p4d)) {
> >>>> -               pud =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> >>>> -               if (!pud)
> >>>> -                       goto err_alloc;
> >>>> -               p4d_populate(&init_mm, p4d, pud);
> >>>> -#ifndef __PAGETABLE_PUD_FOLDED
> >>>> -               pud_init(pud);
> >>>> -#endif
> >>>> -       }
> >>>> -
> >>>> -       pud =3D pud_offset(p4d, addr);
> >>>> -       if (pud_none(*pud)) {
> >>>> -               pmd =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> >>>> -               if (!pmd)
> >>>> -                       goto err_alloc;
> >>>> -               pud_populate(&init_mm, pud, pmd);
> >>>> -#ifndef __PAGETABLE_PMD_FOLDED
> >>>> -               pmd_init(pmd);
> >>>> -#endif
> >>>> -       }
> >>>> -
> >>>> -       pmd =3D pmd_offset(pud, addr);
> >>>> -       if (!pmd_present(*pmd)) {
> >>>> -               pte_t *pte;
> >>>> -
> >>>> -               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> >>>> -               if (!pte)
> >>>> -                       goto err_alloc;
> >>>> -               pmd_populate_kernel(&init_mm, pmd, pte);
> >>>> -       }
> >>>> -
> >>>> +       populate_kernel_pte(addr);
> >>>>         return;
> >>>> -
> >>>> -err_alloc:
> >>>> -       panic("%s: Failed to allocate memory\n", __func__);
> >>>>  }
> >>>>
> >>>>  void __init setup_per_cpu_areas(void)
> >>>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> >>>> index 3b7d8129570b..6cd2948373ae 100644
> >>>> --- a/arch/loongarch/mm/init.c
> >>>> +++ b/arch/loongarch/mm/init.c
> >>>> @@ -191,46 +191,49 @@ void vmemmap_free(unsigned long start, unsigne=
d long end, struct vmem_altmap *al
> >>>>  #endif
> >>>>  #endif
> >>>>
> >>>> -static pte_t *fixmap_pte(unsigned long addr)
> >>>> +pte_t * __init populate_kernel_pte(unsigned long addr)
> >>>>  {
> >>>> -       pgd_t *pgd;
> >>>> -       p4d_t *p4d;
> >>>> +       pgd_t *pgd =3D pgd_offset_k(addr);
> >>>> +       p4d_t *p4d =3D p4d_offset(pgd, addr);
> >>>>         pud_t *pud;
> >>>>         pmd_t *pmd;
> >>>>
> >>>> -       pgd =3D pgd_offset_k(addr);
> >>>> -       p4d =3D p4d_offset(pgd, addr);
> >>>> -
> >>>> -       if (pgd_none(*pgd)) {
> >>>> -               pud_t *new __maybe_unused;
> >>>> -
> >>>> -               new =3D memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> >>>> -               pgd_populate(&init_mm, pgd, new);
> >>>> +       if (p4d_none(*p4d)) {
> >>>> +               pud =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> >>>> +               if (!pud)
> >>>> +                       goto err_alloc;
> >>>> +               p4d_populate(&init_mm, p4d, pud);
> >>>>  #ifndef __PAGETABLE_PUD_FOLDED
> >>>> -               pud_init(new);
> >>>> +               pud_init(pud);
> >>>>  #endif
> >>>>         }
> >>>>
> >>>>         pud =3D pud_offset(p4d, addr);
> >>>>         if (pud_none(*pud)) {
> >>>> -               pmd_t *new __maybe_unused;
> >>>> -
> >>>> -               new =3D memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> >>>> -               pud_populate(&init_mm, pud, new);
> >>>> +               pmd =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> >>>> +               if (!pmd)
> >>>> +                       goto err_alloc;
> >>>> +               pud_populate(&init_mm, pud, pmd);
> >>>>  #ifndef __PAGETABLE_PMD_FOLDED
> >>>> -               pmd_init(new);
> >>>> +               pmd_init(pmd);
> >>>>  #endif
> >>>>         }
> >>>>
> >>>>         pmd =3D pmd_offset(pud, addr);
> >>>> -       if (pmd_none(*pmd)) {
> >>>> -               pte_t *new __maybe_unused;
> >>>> +       if (!pmd_present(*pmd)) {
> >>>> +               pte_t *pte;
> >>>>
> >>>> -               new =3D memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> >>>> -               pmd_populate_kernel(&init_mm, pmd, new);
> >>>> +               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> >>> I don't think memblock_alloc_low() here can be replaced by memblock_a=
lloc().
> >> Can you share me the points that pte table must be allocated with memb=
lock_alloc_low
> >> in this place?
> > I forget the reason now, so if you confirm memblock_alloc() works well
> > here, you can use it. But please don't use memblock_alloc_raw().
> what a mess, there is more comments if there is special reason, else ever=
yone can
> forgot by elapsed time.
>
> why the function memblock_alloc_raw can not be use? there is one useless =
page copy.
This is not a performance critical path, keeping consistency with
mm/percpu.c can make life easier.

Huacai

>
> Regards
> Bibo Mao
>
>
> >
> > Huacai
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>>
> >>> Huacai
> >>>> +               if (!pte)
> >>>> +                       goto err_alloc;
> >>>> +               pmd_populate_kernel(&init_mm, pmd, pte);
> >>>>         }
> >>>>
> >>>>         return pte_offset_kernel(pmd, addr);
> >>>> +
> >>>> +err_alloc:
> >>>> +       panic("%s: Failed to allocate memory\n", __func__);
> >>>> +       return NULL;
> >>>>  }
> >>>>
> >>>>  void __init __set_fixmap(enum fixed_addresses idx,
> >>>> @@ -241,7 +244,12 @@ void __init __set_fixmap(enum fixed_addresses i=
dx,
> >>>>
> >>>>         BUG_ON(idx <=3D FIX_HOLE || idx >=3D __end_of_fixed_addresse=
s);
> >>>>
> >>>> -       ptep =3D fixmap_pte(addr);
> >>>> +       /*
> >>>> +        * Now only FIX_EARLYCON_MEM_BASE fixed map is used
> >>>> +        * __set_fixmap must be called before mem_init since functio=
n
> >>>> +        * populate_kernel_pte allocates memory with memblock_alloc =
method.
> >>>> +        */
> >>>> +       ptep =3D populate_kernel_pte(addr);
> >>>>         if (!pte_none(*ptep)) {
> >>>>                 pte_ERROR(*ptep);
> >>>>                 return;
> >>>> --
> >>>> 2.27.0
> >>>>
> >>
> >>
>
>
