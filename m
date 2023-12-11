Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44780C820
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjLKLgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:36:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCAFBE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:36:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E843FC433D9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702294583;
        bh=T0BGJhovxxT8FvDrl5cKZLNRtopat7GLiz58lUIk/EE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KH0au+36Dghte3bJGHE0UcDzyHgp8EwcqAQbp/QJjOTnqYG8I+mIkOnilcKMAvKUw
         h13Vt5blLgNmP/pw8MosJcSxoZjl009vzHgx9bSWjeam+Mwp9m+PYY9vBLfHT4Wr1k
         KNIHunX4LKJbDMY+diAFZUiYwVJlOhcP5HKhPsB5Q3pcgWVchy8y9m18YLhl0UGu/7
         oH0XRVrWEpHVnhqM2yMnO4L9YwayLCCrFcPqk628zfSBuVlskZ1hrfUMz4mrGsFPcC
         KsYXC8ng92WfRzOHhMhmrtqcemEQ/cCMN/I6FUa6YjSmdWg4xSvHpEfIdXqoHZVdCM
         wItv2eu6EjQVg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a1f37fd4b53so510617466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:36:23 -0800 (PST)
X-Gm-Message-State: AOJu0Yw5Nlgsmo8tDJRmGLdaLAqqcrfJXLzPsHG7a7k9S6XsB2CGeBJF
        HpuZ7qQtwtNba9yK8jeQkSQBzRvRR+1WEGOx3Wk=
X-Google-Smtp-Source: AGHT+IF1HIhZ8NO6dZpSG7lXiNnBEaThLI46XiOIecam+3u97KBOQMpW8Y7CMMyYmEA/bo3t3JdzODEjZ7cqjTysC+M=
X-Received: by 2002:a17:907:2495:b0:a1d:86c0:7be7 with SMTP id
 zg21-20020a170907249500b00a1d86c07be7mr1906744ejb.126.1702294582316; Mon, 11
 Dec 2023 03:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20231208151036.2458921-1-guoren@kernel.org> <CAHVXubjfuKZ1PBYQ8By41OX65YpAma3_kmSL7urT8L0PmMxFnQ@mail.gmail.com>
 <CAJF2gTSB-4hDo8ncSLVKvbnOOEwLSrV716kQM9d9HrzXFs7D8A@mail.gmail.com> <CAHVXubiK0TXMuhZhYjLq7tyk_dhFP9W2uReacECWDC7HToYuXA@mail.gmail.com>
In-Reply-To: <CAHVXubiK0TXMuhZhYjLq7tyk_dhFP9W2uReacECWDC7HToYuXA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 11 Dec 2023 19:36:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSCZ4ytzkenibT+38TzqoYKjBebRRabzn7YQ79bY5yp3g@mail.gmail.com>
Message-ID: <CAJF2gTSCZ4ytzkenibT+38TzqoYKjBebRRabzn7YQ79bY5yp3g@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 5:04=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> On Mon, Dec 11, 2023 at 9:41=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Mon, Dec 11, 2023 at 1:52=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > Hi Guo,
> > >
> > > On Fri, Dec 8, 2023 at 4:10=E2=80=AFPM <guoren@kernel.org> wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > When changing from an invalid pte to a valid one for a kernel page,
> > > > there is no need for tlb_flush. It's okay for the TSO memory model,=
 but
> > > > there is an OoO risk for the Weak one. eg:
> > > >
> > > > sd t0, (a0) // a0 =3D pte address, pteval is changed from invalid t=
o valid
> > > > ...
> > > > ld t1, (a1) // a1 =3D va of above pte
> > > >
> > > > If the ld instruction is executed speculatively before the sd
> > > > instruction. Then it would bring an invalid entry into the TLB, and=
 when
> > > > the ld instruction retired, a spurious page fault occurred. Because=
 the
> > > > vmemmap has been ignored by vmalloc_fault, the spurious page fault =
would
> > > > cause kernel panic.
> > > >
> > > > This patch was inspired by the commit: 7f0b1bf04511 ("arm64: Fix ba=
rriers
> > > > used for page table modifications"). For RISC-V, there is no requir=
ement
> > > > in the spec to guarantee all tlb entries are valid and no requireme=
nt to
> > > > PTW filter out invalid entries. Of course, micro-arch could give a =
more
> > > > robust design, but here, use a software fence to guarantee.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/pgtable.h | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/=
asm/pgtable.h
> > > > index 294044429e8e..2fae5a5438e0 100644
> > > > --- a/arch/riscv/include/asm/pgtable.h
> > > > +++ b/arch/riscv/include/asm/pgtable.h
> > > > @@ -511,6 +511,13 @@ static inline int pte_same(pte_t pte_a, pte_t =
pte_b)
> > > >  static inline void set_pte(pte_t *ptep, pte_t pteval)
> > > >  {
> > > >         *ptep =3D pteval;
> > > > +
> > > > +       /*
> > > > +        * Only if the new pte is present and kernel, otherwise TLB
> > > > +        * maintenance or update_mmu_cache() have the necessary bar=
riers.
> > > > +        */
> > > > +       if (pte_val(pteval) & (_PAGE_PRESENT | _PAGE_GLOBAL))
> > > > +               RISCV_FENCE(rw,rw);
> > >
> > > Only a sfence.vma can guarantee that the PTW actually sees a new
> > > mapping, a fence is not enough. That being said, new kernel mappings
> > > (vmalloc ones) are correctly handled in the kernel by using
> > > flush_cache_vmap(). Did you observe something that this patch fixes?
> > Thx for the reply!
> >
> > The sfence.vma is too expensive, so the situation is tricky. See the
> > arm64 commit: 7f0b1bf04511 ("arm64: Fix barriers used for page table
> > modifications"), which is similar. That is, linux assumes invalid pte
> > won't get into TLB. Think about memory hotplug:
> >
> > mm/sparse.c: sparse_add_section() {
> > ...
> >         memmap =3D section_activate(nid, start_pfn, nr_pages, altmap, p=
gmap);
> >         if (IS_ERR(memmap))
> >                 return PTR_ERR(memmap);
> >
> >         /*
> >          * Poison uninitialized struct pages in order to catch invalid =
flags
> >          * combinations.
> >          */
> >         page_init_poison(memmap, sizeof(struct page) * nr_pages);
> > ...
> > }
> > The section_activate would use set_pte to setup vmemmap, and
> > page_init_poison would access these pages' struct.
>
> So I think the generic code must be fixed by adding a
> flush_cache_vmap() in vmemmap_populate_range() or similar: several
> architectures implement flush_cache_vmap() because they need to do
> "something" after a new mapping is established, so vmemmap should not
> be any different.
Perhaps generic code assumes TLB won't contain invalid entries. When
invalid -> valid, Linux won't do any tlb_flush, ref:

* Use set_p*_safe(), and elide TLB flushing, when confident that *no*
 * TLB flush will be required as a result of the "set". For example, use
 * in scenarios where it is known ahead of time that the routine is
 * setting non-present entries, or re-setting an existing entry to the
 * same value. Otherwise, use the typical "set" helpers and flush the
 * TLB.

>
> >
> > That means:
> > sd t0, (a0) // a0 =3D struct page's pte address, pteval is changed from
> > invalid to valid
> >  ...
> > lw/sw t1, (a1) // a1 =3D va of struct page
> >
> > If the lw/sw instruction is executed speculatively before the set_pte,
> > we need a fence to prevent this.
>
> Yes I agree, but to me we need the fence property of sfence.vma to
> make sure the PTW sees the new pte, unless I'm mistaken and something
> in the privileged specification states that a fence is enough?
All PTW are triggered by IFU & load/store. For the "set" scenarios, we
just need to prevent the access va before the set_pte. So:
 - Don't worry about IFU, which fetches the code sequentially.
 - Use a fence prevent load/store before set_pte.

Sfence.vma is used for invalidate TLB, not for invalid -> valid.

>
> >
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > > >  }
> > > >
> > > >  void flush_icache_pte(pte_t pte);
> > > > --
> > > > 2.40.1
> > > >
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren
