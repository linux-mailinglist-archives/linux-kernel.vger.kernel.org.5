Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EE280E281
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbjLLDIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:08:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0849C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:08:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D3C43391
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702350495;
        bh=JYGLebhaxKY94YGV32z1rxes4CY+cai+W0U5f3FyFgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFPSSzeeqlpe+2q4ASli1nCSUaxyClpv4WCoj0d1t39j8BeM+Dp/k6sPH5x9s8ayl
         B9RH5eI7sUP8HBAwQV1TF/BQB4rG+jsH1A956UVoM7zyEKINp64JIjJc2z774DRbUn
         FVdW7NM982wvgRl/0PoPiBtTY0of3Ggb9So8RmUhiXu1zMaox9wiX1/TiAym4utOF8
         ff/7/XzU0rkP4Zfic6IHCOz7dRvYo4wHBGsSP+NKnBuOshIBr9BeYGtdSIVGX+enLs
         qGJ1zjqb5rXtEVHBTS/+69xI2g+/kSCVG25E4BropD8bGDkKuqDSMKkqXzDudTGNRI
         Dkbc0Ww5orlhA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so638375666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:08:15 -0800 (PST)
X-Gm-Message-State: AOJu0Yzkeu2Agc4hGGfCQG3xpoqMSKrdteu+Jdf/7UFyc72R4qm89qxb
        tIciR/8CfNeSkveaggND+/NUMcfD5vz8eQCotVQ=
X-Google-Smtp-Source: AGHT+IGXr7ae2BWJft9h8JEOb/sSf8K5iF07E47tmBVS0fwPBOhl+VPU25Wmv1IiH8/z0FdVuT6ZcgjwLPT+rmGqD2w=
X-Received: by 2002:a17:907:7e95:b0:a1e:86c2:dcce with SMTP id
 qb21-20020a1709077e9500b00a1e86c2dccemr2248167ejc.11.1702350494003; Mon, 11
 Dec 2023 19:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20231208151036.2458921-1-guoren@kernel.org> <CAHVXubjfuKZ1PBYQ8By41OX65YpAma3_kmSL7urT8L0PmMxFnQ@mail.gmail.com>
 <CAJF2gTSB-4hDo8ncSLVKvbnOOEwLSrV716kQM9d9HrzXFs7D8A@mail.gmail.com>
 <CAHVXubiK0TXMuhZhYjLq7tyk_dhFP9W2uReacECWDC7HToYuXA@mail.gmail.com>
 <CAJF2gTSCZ4ytzkenibT+38TzqoYKjBebRRabzn7YQ79bY5yp3g@mail.gmail.com> <b9292e35-6870-4c6d-8831-c9b15a33f52f@sifive.com>
In-Reply-To: <b9292e35-6870-4c6d-8831-c9b15a33f52f@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Dec 2023 11:07:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRGjn+Tz-R3us057B4zm801XUZrue38V_dDyVAhy+1Zng@mail.gmail.com>
Message-ID: <CAJF2gTRGjn+Tz-R3us057B4zm801XUZrue38V_dDyVAhy+1Zng@mail.gmail.com>
Subject: Re: [PATCH] riscv: pgtable: Enhance set_pte to prevent OoO risk
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, willy@infradead.org, david@redhat.com,
        muchun.song@linux.dev, will@kernel.org, peterz@infradead.org,
        rppt@kernel.org, paulmck@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, alex@ghiti.fr, mike.kravetz@oracle.com,
        dfustini@baylibre.com, wefu@redhat.com, jszhang@kernel.org,
        falcon@tinylab.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
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

On Mon, Dec 11, 2023 at 11:27=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> On 2023-12-11 5:36 AM, Guo Ren wrote:
> > On Mon, Dec 11, 2023 at 5:04=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> >>
> >> On Mon, Dec 11, 2023 at 9:41=E2=80=AFAM Guo Ren <guoren@kernel.org> wr=
ote:
> >>>
> >>> On Mon, Dec 11, 2023 at 1:52=E2=80=AFPM Alexandre Ghiti <alexghiti@ri=
vosinc.com> wrote:
> >>>>
> >>>> Hi Guo,
> >>>>
> >>>> On Fri, Dec 8, 2023 at 4:10=E2=80=AFPM <guoren@kernel.org> wrote:
> >>>>>
> >>>>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>>>
> >>>>> When changing from an invalid pte to a valid one for a kernel page,
> >>>>> there is no need for tlb_flush. It's okay for the TSO memory model,=
 but
> >>>>> there is an OoO risk for the Weak one. eg:
> >>>>>
> >>>>> sd t0, (a0) // a0 =3D pte address, pteval is changed from invalid t=
o valid
> >>>>> ...
> >>>>> ld t1, (a1) // a1 =3D va of above pte
> >>>>>
> >>>>> If the ld instruction is executed speculatively before the sd
> >>>>> instruction. Then it would bring an invalid entry into the TLB, and=
 when
> >>>>> the ld instruction retired, a spurious page fault occurred. Because=
 the
> >>>>> vmemmap has been ignored by vmalloc_fault, the spurious page fault =
would
> >>>>> cause kernel panic.
> >>>>>
> >>>>> This patch was inspired by the commit: 7f0b1bf04511 ("arm64: Fix ba=
rriers
> >>>>> used for page table modifications"). For RISC-V, there is no requir=
ement
> >>>>> in the spec to guarantee all tlb entries are valid and no requireme=
nt to
> >>>>> PTW filter out invalid entries. Of course, micro-arch could give a =
more
> >>>>> robust design, but here, use a software fence to guarantee.
> >>>>>
> >>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>> ---
> >>>>>  arch/riscv/include/asm/pgtable.h | 7 +++++++
> >>>>>  1 file changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/=
asm/pgtable.h
> >>>>> index 294044429e8e..2fae5a5438e0 100644
> >>>>> --- a/arch/riscv/include/asm/pgtable.h
> >>>>> +++ b/arch/riscv/include/asm/pgtable.h
> >>>>> @@ -511,6 +511,13 @@ static inline int pte_same(pte_t pte_a, pte_t =
pte_b)
> >>>>>  static inline void set_pte(pte_t *ptep, pte_t pteval)
> >>>>>  {
> >>>>>         *ptep =3D pteval;
> >>>>> +
> >>>>> +       /*
> >>>>> +        * Only if the new pte is present and kernel, otherwise TLB
> >>>>> +        * maintenance or update_mmu_cache() have the necessary bar=
riers.
> >>>>> +        */
> >>>>> +       if (pte_val(pteval) & (_PAGE_PRESENT | _PAGE_GLOBAL))
> >>>>> +               RISCV_FENCE(rw,rw);
> >>>>
> >>>> Only a sfence.vma can guarantee that the PTW actually sees a new
> >>>> mapping, a fence is not enough. That being said, new kernel mappings
> >>>> (vmalloc ones) are correctly handled in the kernel by using
> >>>> flush_cache_vmap(). Did you observe something that this patch fixes?
> >>> Thx for the reply!
> >>>
> >>> The sfence.vma is too expensive, so the situation is tricky. See the
> >>> arm64 commit: 7f0b1bf04511 ("arm64: Fix barriers used for page table
> >>> modifications"), which is similar. That is, linux assumes invalid pte
> >>> won't get into TLB. Think about memory hotplug:
> >>>
> >>> mm/sparse.c: sparse_add_section() {
> >>> ...
> >>>         memmap =3D section_activate(nid, start_pfn, nr_pages, altmap,=
 pgmap);
> >>>         if (IS_ERR(memmap))
> >>>                 return PTR_ERR(memmap);
> >>>
> >>>         /*
> >>>          * Poison uninitialized struct pages in order to catch invali=
d flags
> >>>          * combinations.
> >>>          */
> >>>         page_init_poison(memmap, sizeof(struct page) * nr_pages);
> >>> ...
> >>> }
> >>> The section_activate would use set_pte to setup vmemmap, and
> >>> page_init_poison would access these pages' struct.
> >>
> >> So I think the generic code must be fixed by adding a
> >> flush_cache_vmap() in vmemmap_populate_range() or similar: several
> >> architectures implement flush_cache_vmap() because they need to do
> >> "something" after a new mapping is established, so vmemmap should not
> >> be any different.
> > Perhaps generic code assumes TLB won't contain invalid entries. When
> > invalid -> valid, Linux won't do any tlb_flush, ref:
> >
> > * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
> >  * TLB flush will be required as a result of the "set". For example, us=
e
> >  * in scenarios where it is known ahead of time that the routine is
> >  * setting non-present entries, or re-setting an existing entry to the
> >  * same value. Otherwise, use the typical "set" helpers and flush the
> >  * TLB.
> >
> >>
> >>>
> >>> That means:
> >>> sd t0, (a0) // a0 =3D struct page's pte address, pteval is changed fr=
om
> >>> invalid to valid
> >>>  ...
> >>> lw/sw t1, (a1) // a1 =3D va of struct page
> >>>
> >>> If the lw/sw instruction is executed speculatively before the set_pte=
,
> >>> we need a fence to prevent this.
> >>
> >> Yes I agree, but to me we need the fence property of sfence.vma to
> >> make sure the PTW sees the new pte, unless I'm mistaken and something
> >> in the privileged specification states that a fence is enough?
> > All PTW are triggered by IFU & load/store. For the "set" scenarios, we
> > just need to prevent the access va before the set_pte. So:
> >  - Don't worry about IFU, which fetches the code sequentially.
> >  - Use a fence prevent load/store before set_pte.
> >
> > Sfence.vma is used for invalidate TLB, not for invalid -> valid.
>
> I think the problem is that, architecturally, you can't prevent a PTW by
> preventing access to the virtual address. The RISC-V privileged spec allo=
ws
> caching the results of PTWs from speculative execution, and it allows cac=
hing
> invalid PTEs. So effectively, as soon as satp is written, software must b=
e able
> to handle _any_ virtual address being in the TLB.
>
> To avoid the sfence.vma in the invalid->valid case, you need to handle th=
e
> possible page fault, like in Alex's series here:
>
> https://lore.kernel.org/linux-riscv/20231207150348.82096-1-alexghiti@rivo=
sinc.com/
Just as this patch series said:

+ * The RISC-V kernel does not eagerly emit a sfence.vma after each
+ * new vmalloc mapping, which may result in exceptions:
+ * - if the uarch caches invalid entries, the new mapping would not be
+ *   observed by the page table walker and an invalidation is needed.
+ * - if the uarch does not cache invalid entries, a reordered access
+ *   could "miss" the new mapping and traps: in that case, we only need
+ *   to retry the access, no sfence.vma is required.

I'm talking about "uarch does not cache invalid entries, a reordered
access could "miss" the new mapping and traps".
Using a fence in set_pte is another solution, and better than
retrying. Of course the premise is that the fence is not expensive for
micro-arch.

 - Arm64 used this way: commit: 7f0b1bf04511 ("arm64: Fix barriers
 - X86 is similar, because it's TSO, so any load + store instructions
between set_pte & next access would give a barrier, eg:
   set_pte va
   load (acquire)
   store (release)
   load/store va


Another topic is about "retry the access", this is about kernel
virtual address space spurious page fault right? And Alex is
preventing that in the riscv linux kernel and it would cause a lot of
side effects.

>
> Regards,
> Samuel
>


--=20
Best Regards
 Guo Ren
