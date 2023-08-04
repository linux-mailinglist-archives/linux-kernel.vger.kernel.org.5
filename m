Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C8976FB59
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjHDHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHDHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:48:21 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB4E421E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:48:18 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3747m8i9028840;
        Fri, 4 Aug 2023 15:48:08 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Fri, 4 Aug 2023
 15:48:05 +0800
Date:   Fri, 4 Aug 2023 15:48:05 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
Message-ID: <ZMytNY2J8iyjbPPy@atctrx.andestech.com>
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
 <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com>
 <20230803-stadium-unusable-6cf00e35ec22@wendy>
 <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubiz-7LaxCJLW=-ekr7TBFswXojr1ODU4mo59Z1OBmjieg@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3747m8i9028840
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:48:36AM +0200, Alexandre Ghiti wrote:
> On Thu, Aug 3, 2023 at 11:25 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > On Thu, Aug 03, 2023 at 05:14:15PM +0800, dylan wrote:
> > > On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> > > > On Tue, Jul 25, 2023 at 9:22 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> > > > >
> > > > > The RISC-V kernel needs a sfence.vma after a page table modification: we
> > > > > used to rely on the vmalloc fault handling to emit an sfence.vma, but
> > > > > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > > > > vmalloc/modules area") got rid of this path for 64-bit kernels, so now we
> > > > > need to explicitly emit a sfence.vma in flush_cache_vmap().
> > > > >
> > > > > Note that we don't need to implement flush_cache_vunmap() as the generic
> > > > > code should emit a flush tlb after unmapping a vmalloc region.
> > > > >
> > > > > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area")
> > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> > > > > index 8091b8bf4883..b93ffddf8a61 100644
> > > > > --- a/arch/riscv/include/asm/cacheflush.h
> > > > > +++ b/arch/riscv/include/asm/cacheflush.h
> > > > > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page)
> > > > >  #define flush_icache_user_page(vma, pg, addr, len) \
> > > > >         flush_icache_mm(vma->vm_mm, 0)
> > > > >
> > > > > +#ifdef CONFIG_64BIT
> > > > > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(start, end)
> > > > Sorry, I couldn't agree with the above in a PIPT cache machine. It's
> > > > not worth for.
> > > >
> > > > It would reduce the performance of vmap_pages_range,
> > > > ioremap_page_range ... API, which may cause some drivers' performance
> > > > issues when they install/uninstall memory frequently.
> > > >
> > >
> > > Hi All,
> > >
> > > I think functional correctness should be more important than system performance
> > > in this case. The "preventive" SFENCE.VMA became necessary due to the RISC-V
> > > specification allowing invalidation entries to be cached in the TLB.
> >
> > We are at -rc4 and this stuff is broken. Taking the bigger hammer, which
> > can be reverted later when a more targeted fix shows up, to make sure
> > that v6.5 doesn't end up broken, sounds rather prudent. Otherwise, the
> > original commit should probably be reverted.
> 
> The original commit that removed vmalloc_fault() is required, handling
> vmalloc faults in the page fault path is not possible (see the links
> in the description of 7d3332be011e and the example that I gave in the
> thread https://lore.kernel.org/linux-riscv/dc26625b-6658-c078-76d2-7e975a04b1d4@ghiti.fr/).
> 
> I totally agree with Dylan that we'll work (I'm currently working on
> that) on the performance side of the problem in the next release, we
> need correctness and for that we need a preventive global sfence.vma
> as we have no means (for now) to distinguish between uarch that cache
> or not invalid entries.
> 
> >
> > > The problem[1] we are currently encountering is caused by not updating the TLB
> > > after the page table is created, and the solution to this problem can only be
> > > solved by updating the TLB immediately after the page table is created.
> > >
> > > There are currently two possible approaches to flush TLB:
> > > 1. Flush TLB in flush_cache_vmap()
> > > 2. Flush TLB in arch_sync_kernel_mappings()
> > >
> > > But I'm not quite sure if it's a good idea to operate on the TLB inside flush_cache_vmap().
> > > The name of this function indicates that it should be related to cache operations, maybe
> > > it would be more appropriate to do TLB flush in arch_sync_kernel_mappings()?
> 
> TLDR: The downsides to implementing arch_sync_kernel_mappings()
> instead of flush_cache_vmap():
> 
> - 2 global flushes for vunmap instead of 1 for flush_cache_vmap()
> - flushes the tlb in the noflush suffixed functions so it prevents any
> flush optimization (ie: a loop of vmap_range_noflush() without flush
> and then a final flush afterwards)
> 
> So I'd favour the flush_cache_vmap() implementation which seems
> lighter. powerpc does that
> https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/cacheflush.h#L27
> (but admits that it may not be the right place)
> 
> Here is the long story (my raw notes):
> 
> * arch_sync_kernel_mappings() is called from:
> - _apply_to_page_range(): would only emit global sfence.vma if vmalloc
> addresses, I guess that's ok.
> - __vunmap_range_noflush(): it is noted here
> https://elixir.bootlin.com/linux/latest/source/mm/vmalloc.c#L406 that
> any caller must call flush_tlb_kernel_range(). Then the implementation
> of arch_sync_kernel_mappings() would result in 2 global tlb flushes.
> - vmap_range_noflush(): does not fit well with the noflush() suffix.
> 
> * flush_cache_vmap() is called from:
> - kasan_populate_vmalloc(): legit since it bypasses vmap api (but
> called right a apply_to_page_range() so your patch would work here)
> - kmsan_vunmap_range_noflush(): called twice for the mappings kmsan
> establishes and flush_tlb_kernel_range() must be called afterwards =>
> 3 global tlb flushes but the 3 are needed as they target different
> addresses. Implementing only arch_sync_kernel_mappings() would result
> in way more global flushes (see the loop here
> https://elixir.bootlin.com/linux/latest/source/mm/kmsan/hooks.c#L151
> where  __vmap_pages_range_noflush() would result in more
> flush_tlb_all())
> - kmsan_vmap_pages_range_noflush(): here we would flush twice, but
> same thing for the arch_sync_kernel_mappings() implementation.
> - ioremap_page_range(): legit, same as arch_sync_kernel_mappings()
> implementation.
> - vmap_pages_range(): legit, same as arch_sync_kernel_mappings() implementation.
> 
> Let me know what you think!
> 
> Alex
> 
Hi Alex,

Thank you for the detailed explanation. It is indeed undeniable that in certain
situations, there might be a possibility of repeated flushing TLB. But I think
there are some potential problem in flush_cache_vmap().

In most case, vmap_range_noflush() and flush_cache_vmap() will appear at the same
time, so it should be no problem to choose one of them to do the TLB flush. But
flush_cache_vmap() does not cover all the places where apply_to_page_range()
appears (please correct me if I'm wrong), such as vmap_pfn()[1].

The function you mentioned here, each will eventually call:
    vmap_range_noflush() -> arch_sync_kernel_mappings() -> TLB Flush

As for the performance, because the current parameter of flush_tlb_page() needs to
pass *vma, we cannot pass in this parameter so we can only choose flush_tlb_all().
If it can be changed to flush_tlb_page() in the future, the performance should be improved.

[1]: https://elixir.bootlin.com/linux/v6.5-rc4/source/mm/vmalloc.c#L2977

Best regards,
Dylan Jhong

> > >
> > > [1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/037503.html
> >
