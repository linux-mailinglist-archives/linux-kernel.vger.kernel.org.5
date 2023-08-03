Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8D76E411
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjHCJOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHCJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:14:27 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083CFAC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:14:24 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3739EJV0017070;
        Thu, 3 Aug 2023 17:14:19 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 3 Aug 2023
 17:14:16 +0800
Date:   Thu, 3 Aug 2023 17:14:15 +0800
From:   dylan <dylan@andestech.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: Implement flush_cache_vmap()
Message-ID: <ZMtv5+ut5z3pjlFJ@atctrx.andestech.com>
References: <20230725132246.817726-1-alexghiti@rivosinc.com>
 <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTRm59RAJvSf=L2uqbb3rHnANVheO+yLqrJGuVBh1w8Oug@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3739EJV0017070
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 01:08:17AM -0400, Guo Ren wrote:
> On Tue, Jul 25, 2023 at 9:22 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > The RISC-V kernel needs a sfence.vma after a page table modification: we
> > used to rely on the vmalloc fault handling to emit an sfence.vma, but
> > commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
> > vmalloc/modules area") got rid of this path for 64-bit kernels, so now we
> > need to explicitly emit a sfence.vma in flush_cache_vmap().
> >
> > Note that we don't need to implement flush_cache_vunmap() as the generic
> > code should emit a flush tlb after unmapping a vmalloc region.
> >
> > Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cacheflush.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> > index 8091b8bf4883..b93ffddf8a61 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page)
> >  #define flush_icache_user_page(vma, pg, addr, len) \
> >         flush_icache_mm(vma->vm_mm, 0)
> >
> > +#ifdef CONFIG_64BIT
> > +#define flush_cache_vmap(start, end)   flush_tlb_kernel_range(start, end)
> Sorry, I couldn't agree with the above in a PIPT cache machine. It's
> not worth for.
> 
> It would reduce the performance of vmap_pages_range,
> ioremap_page_range ... API, which may cause some drivers' performance
> issues when they install/uninstall memory frequently.
> 

Hi All,

I think functional correctness should be more important than system performance
in this case. The "preventive" SFENCE.VMA became necessary due to the RISC-V
specification allowing invalidation entries to be cached in the TLB.

The problem[1] we are currently encountering is caused by not updating the TLB
after the page table is created, and the solution to this problem can only be
solved by updating the TLB immediately after the page table is created.

There are currently two possible approaches to flush TLB:
1. Flush TLB in flush_cache_vmap()
2. Flush TLB in arch_sync_kernel_mappings()

But I'm not quite sure if it's a good idea to operate on the TLB inside flush_cache_vmap().
The name of this function indicates that it should be related to cache operations, maybe
it would be more appropriate to do TLB flush in arch_sync_kernel_mappings()?

[1]: http://lists.infradead.org/pipermail/linux-riscv/2023-August/037503.html

Best regards,
Dylan

> > +#endif
> > +
> >  #ifndef CONFIG_SMP
> >
> >  #define flush_icache_all() local_flush_icache_all()
> > --
> > 2.39.2
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
