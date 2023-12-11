Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258C480C37C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjLKIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjLKIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:41:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F52712B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:41:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E446C433C8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702284103;
        bh=yUXy5KMGAXSGc2rYF6QzrrccUQw8a5P/gu1jqOP4kTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SqRbPNZi3Tzo1WjiBzZGiLtX2/w8UDGCBsHDl9dsCqAqNgnLrfiWj3xXdNW4M4sfa
         nHqHvcspUfdyjSS0lY/QEFAWu9Sp1x+BxCI/frlVeS02S4YfVi/GIREBpfkEWnsjUC
         uS44fMmoINQKQ9HQSIrnhPDHeWAHw6ElZsw9n7BVAZy1I26UKzmT4vXSuT0WWtjJfR
         DswCh7Sdg1U0EaJPbVZR7/yZmr8bOfCdgLZO1nqEfF8U1FQBQGmfqH4TYwjZxdPEZ1
         uu7e+gOMcZ/f1wUBsiX/cjYcV4kEqV/ACUWX5Qa34BBtfWuNre0R4kPN3wOFl2NW7o
         dOk8w84gLVLpw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso384523566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:41:42 -0800 (PST)
X-Gm-Message-State: AOJu0YzbGyqs6hhCUtAu9XFpw437078BgONf5IHlY+kyeDMam/fVidLR
        t4GGkIeEiyVG/M24BBLmxs9731wqHOq7r7gVbCo=
X-Google-Smtp-Source: AGHT+IHV09gn3uQwbmW4lHx+slaNMCE8kXMnmmfEp+gPk1a+gEbxMnAq96j16hTduHEvWLxgZ3w96DTajZR3GrRECyQ=
X-Received: by 2002:a17:907:7f1f:b0:a19:d40a:d1fd with SMTP id
 qf31-20020a1709077f1f00b00a19d40ad1fdmr1448805ejc.201.1702284101520; Mon, 11
 Dec 2023 00:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20231208151036.2458921-1-guoren@kernel.org> <CAHVXubjfuKZ1PBYQ8By41OX65YpAma3_kmSL7urT8L0PmMxFnQ@mail.gmail.com>
In-Reply-To: <CAHVXubjfuKZ1PBYQ8By41OX65YpAma3_kmSL7urT8L0PmMxFnQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 11 Dec 2023 16:41:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSB-4hDo8ncSLVKvbnOOEwLSrV716kQM9d9HrzXFs7D8A@mail.gmail.com>
Message-ID: <CAJF2gTSB-4hDo8ncSLVKvbnOOEwLSrV716kQM9d9HrzXFs7D8A@mail.gmail.com>
Subject: Re: [PATCH] riscv: pgtable: Enhance set_pte to prevent OoO risk
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        willy@infradead.org, david@redhat.com, muchun.song@linux.dev,
        will@kernel.org, peterz@infradead.org, rppt@kernel.org,
        paulmck@kernel.org, atishp@atishpatra.org, anup@brainfault.org,
        alex@ghiti.fr, mike.kravetz@oracle.com, dfustini@baylibre.com,
        wefu@redhat.com, jszhang@kernel.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 1:52=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Guo,
>
> On Fri, Dec 8, 2023 at 4:10=E2=80=AFPM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When changing from an invalid pte to a valid one for a kernel page,
> > there is no need for tlb_flush. It's okay for the TSO memory model, but
> > there is an OoO risk for the Weak one. eg:
> >
> > sd t0, (a0) // a0 =3D pte address, pteval is changed from invalid to va=
lid
> > ...
> > ld t1, (a1) // a1 =3D va of above pte
> >
> > If the ld instruction is executed speculatively before the sd
> > instruction. Then it would bring an invalid entry into the TLB, and whe=
n
> > the ld instruction retired, a spurious page fault occurred. Because the
> > vmemmap has been ignored by vmalloc_fault, the spurious page fault woul=
d
> > cause kernel panic.
> >
> > This patch was inspired by the commit: 7f0b1bf04511 ("arm64: Fix barrie=
rs
> > used for page table modifications"). For RISC-V, there is no requiremen=
t
> > in the spec to guarantee all tlb entries are valid and no requirement t=
o
> > PTW filter out invalid entries. Of course, micro-arch could give a more
> > robust design, but here, use a software fence to guarantee.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 294044429e8e..2fae5a5438e0 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -511,6 +511,13 @@ static inline int pte_same(pte_t pte_a, pte_t pte_=
b)
> >  static inline void set_pte(pte_t *ptep, pte_t pteval)
> >  {
> >         *ptep =3D pteval;
> > +
> > +       /*
> > +        * Only if the new pte is present and kernel, otherwise TLB
> > +        * maintenance or update_mmu_cache() have the necessary barrier=
s.
> > +        */
> > +       if (pte_val(pteval) & (_PAGE_PRESENT | _PAGE_GLOBAL))
> > +               RISCV_FENCE(rw,rw);
>
> Only a sfence.vma can guarantee that the PTW actually sees a new
> mapping, a fence is not enough. That being said, new kernel mappings
> (vmalloc ones) are correctly handled in the kernel by using
> flush_cache_vmap(). Did you observe something that this patch fixes?
Thx for the reply!

The sfence.vma is too expensive, so the situation is tricky. See the
arm64 commit: 7f0b1bf04511 ("arm64: Fix barriers used for page table
modifications"), which is similar. That is, linux assumes invalid pte
won't get into TLB. Think about memory hotplug:

mm/sparse.c: sparse_add_section() {
...
        memmap =3D section_activate(nid, start_pfn, nr_pages, altmap, pgmap=
);
        if (IS_ERR(memmap))
                return PTR_ERR(memmap);

        /*
         * Poison uninitialized struct pages in order to catch invalid flag=
s
         * combinations.
         */
        page_init_poison(memmap, sizeof(struct page) * nr_pages);
...
}
The section_activate would use set_pte to setup vmemmap, and
page_init_poison would access these pages' struct.

That means:
sd t0, (a0) // a0 =3D struct page's pte address, pteval is changed from
invalid to valid
 ...
lw/sw t1, (a1) // a1 =3D va of struct page

If the lw/sw instruction is executed speculatively before the set_pte,
we need a fence to prevent this.

>
> Thanks,
>
> Alex
>
> >  }
> >
> >  void flush_icache_pte(pte_t pte);
> > --
> > 2.40.1
> >



--=20
Best Regards
 Guo Ren
