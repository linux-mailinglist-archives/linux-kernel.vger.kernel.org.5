Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD0774F97
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjHHXz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHHXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CADBD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 080C162E4C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69714C433C8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691538925;
        bh=RwSkMPzlEv0n/ysC5jtakqo5PrpEeHBTGPBFueHpaoc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JEiEplZm8rq1XiAzsCh2vHKTp7ilICFwwvkDtS8Zx1jApgJqFObHSIs/ZrJzfiHhb
         270m4o1cyfTQk1PYvJlWISkbp4sPfEKW5+qo7jBX/RM3kqdQNqMtsvUOxNl3s7jFMT
         vyLE9WD0DKB7I12GgeN2d+bbpT2Lal1F3OvtjQzw6/UBf8+9oYceLN17itdsvX9SNO
         i44EWJ/xD8UoH2AjoSG1NLjBersImizsiEO77GLYxPBsBL3dk9XBfRnTKKXqsgYH9H
         5fzE3bcckM8Vv3rEmNA2s5wp/azuiEn10/8zXc46x+q1Z3nSJksikxmrFN7vwaKkWk
         zt2JUpiOHAklQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so95660961fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:55:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZW2kaX9U2GNixZUna4SERgVSLlO3JUVQte1t4aRz9NZvztUJ0
        TUCXU7yEt+fnTUL2PYgK22tCZfQbW2hgV7Ymih8=
X-Google-Smtp-Source: AGHT+IHV0QCXt00asqXo9i3wuEFtFortY2kxuOV37nEpwuSyXAdEHII97qwPajTrAibaFrnw+tTe4fkvgupRzhb+kuQ=
X-Received: by 2002:a2e:99d2:0:b0:2b9:dd5d:5d0c with SMTP id
 l18-20020a2e99d2000000b002b9dd5d5d0cmr646347ljj.52.1691538923401; Tue, 08 Aug
 2023 16:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
 <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com> <20230803-stadium-unusable-6cf00e35ec22@wendy>
 <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com>
 <ZMytNY2J8iyjbPPy@atctrx.andestech.com> <CAHVXubhwo7BQ3a3C5zr7955hxekqVQg3FWy9J2GqscZbbBtc7A@mail.gmail.com>
In-Reply-To: <CAHVXubhwo7BQ3a3C5zr7955hxekqVQg3FWy9J2GqscZbbBtc7A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Aug 2023 07:55:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSwoitnkm8qR15rfRPfqH3+oT+LDzP5oXYqAshLs0sF0g@mail.gmail.com>
Message-ID: <CAJF2gTSwoitnkm8qR15rfRPfqH3+oT+LDzP5oXYqAshLs0sF0g@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Dylan Jhong <dylan@andestech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 7:23=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Hey Dylan,
>
> Sorry I was busy debugging 6.5 failing to boot on the Unmatched (also
> TLB related, crazy everything converges to TLB issues lately :))
>
> On Fri, Aug 4, 2023 at 9:48=E2=80=AFAM Dylan Jhong <dylan@andestech.com> =
wrote:
> >
> > On Thu, Aug 03, 2023 at 11:48:36AM +0200, Alexandre Ghiti wrote:
> > > On Thu, Aug 3, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > >
> > > > On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
> > > > > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > > > > > On Tue, Jul 25, 2023 at 9:22=E2=80=AFAM Alexandre Ghiti <alexgh=
iti@rivosinc.com> wrote:
> > > > > > >
> > > > > > > The RISC-V kernel needs a sfence.vma after a page table modif=
ication: we
> > > > > > > used to rely on the vmalloc fault handling to emit an sfence.=
vma, but
> > > > > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > > > > > vmalloc/modules area") got rid of this path for 64-bit kernel=
s, so now we
> > > > > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > > > > > >
> > > > > > > Note that we don't need to implement flush_cache_vunmap() as =
the generic
> > > > > > > code should emit a flush tlb after unmapping a vmalloc region=
.
> > > > > > >
> > > > > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for=
 vmalloc/modules area")
> > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > > ---
> > > > > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv=
/include/asm/cacheflush.h
> > > > > > > index 8091b8bf4883..b93ffddf8a61 100644
> > > > > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struc=
t page *page)
> > > > > > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > > > > > >         flush_icache_mm(vma->vm_mm, 0)
> > > > > > >
> > > > > > > +#ifdef CONFIG_64BIT
> > > > > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_rang=
e(start, end)
> > > > > > Sorry, I couldn't agree with the above in a PIPT cache machine.=
 It's
> > > > > > not worth for.
> > > > > >
> > > > > > It would reduce the performance of vmap_pages_range,
> > > > > > ioremap_page_range ... API, which may cause some drivers' perfo=
rmance
> > > > > > issues when they install/uninstall memory frequently.
> > > > > >
> > > > >
> > > > > Hi All,
> > > > >
> > > > > I think functional correctness should be more important than syst=
em performance
> > > > > in this case. The "preventive" SFENCE.VMA became necessary due to=
 the RISC-V
> > > > > specification allowing invalidation entries to be cached in the T=
LB.
> > > >
> > > > We are at -rc4 and this stuff is broken. Taking the bigger hammer, =
which
> > > > can be reverted later when a more targeted fix shows up, to make su=
re
> > > > that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, =
the
> > > > original commit should probably be reverted.
> > >
> > > The original commit that removed vmalloc_fault() is required, handlin=
g
> > > vmalloc faults in the page fault path is not possible (see the links
> > > in the description of 7d3332be011e and the example that I gave in the
> > > thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e=
975a04b1d4@ghiti.fr/).
> > >
> > > I totally agree with Dylan that we'll work (I'm currently working on
> > > that) on the performance side of the problem in the next release, we
> > > need correctness and for that we need a preventive global sfence.vma
> > > as we have no means (for now) to distinguish between uarch that cache
> > > or not invalid entries.
> > >
> > > >
> > > > > The problem[1] we are currently encountering is caused by not upd=
ating the TLB
> > > > > after the page table is created, and the solution to this problem=
 can only be
> > > > > solved by updating the TLB immediately after the page table is cr=
eated.
> > > > >
> > > > > There are currently two possible approaches to flush TLB:
> > > > > 1. Flush TLB in flush_cache_vmap()
> > > > > 2. Flush TLB in arch_sync_kernel_mappings()
> > > > >
> > > > > But I'm not quite sure if it's a good idea to operate on the TLB =
inside flush_cache_vmap().
> > > > > The name of this function indicates that it should be related to =
cache operations, maybe
> > > > > it would be more appropriate to do TLB flush in arch_sync_kernel_=
mappings()?
> > >
> > > TLDR: The downsides to implementing arch_sync_kernel_mappings()
> > > instead of flush_cache_vmap():
> > >
> > > - 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
> > > - flushes the tlb in the noflush suffixed functions so it prevents an=
y
> > > flush optimization (ie: a loop of vmap_range_noflush() without flush
> > > and then a final flush afterwards)
> > >
> > > So I'd favour the flush_cache_vmap() implementation which seems
> > > lighter. powerpc does that
> > > https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/a=
sm/cacheflush.h#L27
> > > (but admits that it may not be the right place)
> > >
> > > Here is the long story (my raw notes):
> > >
> > > * arch_sync_kernel_mappings() is called from:
> > > - _apply_to_page_range(): would only emit global sfence.vma if vmallo=
c
> > > addresses, I guess that's ok.
> > > - __vunmap_range_noflush(): it is noted here
> > > https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
> > > any caller must call flush_tlb_kernel_range(). Then the implementatio=
n
> > > of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
> > > - vmap_range_noflush(): does not fit well with the noflush() suffix.
> > >
> > > * flush_cache_vmap() is called from:
> > > - kasan_populate_vmalloc(): legit since it bypasses vmap api (but
> > > called right a apply_to_page_range() so your patch would work here)
> > > - kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
> > > establishes and flush_tlb_kernel_range() must be called afterwards =
=3D>
> > > 3 global tlb flushes but the 3 are needed as they target different
> > > addresses. Implementing only arch_sync_kernel_mappings() would result
> > > in way more global flushes (see the loop here
> > > https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
> > > where  __vmap_pages_range_noflush() would result in more
> > > flush_tlb_all())
> > > - kmsan_vmap_pages_range_noflush(): here we would flush twice, but
> > > same thing for the arch_sync_kernel_mappings() implementation.
> > > - ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
> > > implementation.
> > > - vmap_pages_range(): legit, same as arch_sync_kernel_mappings() impl=
ementation.
> > >
> > > Let me know what you think!
> > >
> > > Alex
> > >
> > Hi Alex,
> >
> > Thank you for the detailed explanation. It is indeed undeniable that in=
 certain
> > situations, there might be a possibility of repeated flushing TLB. But =
I think
> > there are some potential problem in flush_cache_vmap().
> >
> > In most case, vmap_range_noflush() and flush_cache_vmap() will appear a=
t the same
> > time, so it should be no problem to choose one of them to do the TLB fl=
ush. But
> > flush_cache_vmap() does not cover all the places where apply_to_page_ra=
nge()
> > appears (please correct me if I'm wrong), such as vmap_pfn()[1].
>
> That's a good catch, but shouldn't there be a flush_cache_vmap() in
> vmap_pfn()? What happens to architectures that implement
> flush_cache_vmap() and not arch_sync_kernel_mappings() (most of them)?
>
> >
> > The function you mentioned here, each will eventually call:
> >     vmap_range_noflush() -> arch_sync_kernel_mappings() -> TLB Flush
> >
> > As for the performance, because the current parameter of flush_tlb_page=
() needs to
> > pass *vma, we cannot pass in this parameter so we can only choose flush=
_tlb_all().
> > If it can be changed to flush_tlb_page() in the future, the performance=
 should be improved.
>
> We should call only flush_tlb_kernel_range() on kernel addresses, so
> that won't be a problem.
Another idea for reference:
 1. keep vmalloc_fault()
 2. flush_tlb_page() for vmap_stack when creating kernel thread.

>
> >
> > [1]: https://elixir.bootlin.com/linux/v6.5-rc4/source/mm/vmalloc.c#L297=
7
> >
> > Best regards,
> > Dylan Jhong
> >
> > > > >
> > > > > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August=
/037503.html
> > > >



--=20
Best Regards
 Guo Ren
