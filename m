Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B0775B49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjHILQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHILQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:16:12 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22151FCE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:16:09 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 379BG0TM087502;
        Wed, 9 Aug 2023 19:16:00 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 9 Aug 2023
 19:16:01 +0800
Date:   Wed, 9 Aug 2023 19:16:00 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <ajones@ventanamicro.com>,
        <alexghiti@rivosinc.com>, <anup@brainfault.org>, <rppt@kernel.org>,
        <samuel@sholland.org>, <panqinglin2020@iscas.ac.cn>,
        <sergey.matyukevich@syntacore.com>, <maz@kernel.org>,
        <linux-riscv@lists.infradead.org>, <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <ycliang@andestech.com>,
        <x5710999x@gmail.com>, <tim609@andestech.com>
Subject: Re: [PATCH 1/1] riscv: Implement arch_sync_kernel_mappings() for
 "preventive" TLB flush
Message-ID: <ZNN1cEO1jMrPlPfj@atctrx.andestech.com>
References: <20230807082305.198784-1-dylan@andestech.com>
 <20230807082305.198784-2-dylan@andestech.com>
 <5681817e-2751-0166-b823-df03aebedf9f@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5681817e-2751-0166-b823-df03aebedf9f@ghiti.fr>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 379BG0TM087502
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 12:16:50PM +0200, Alexandre Ghiti wrote:
> Hi Dylan,
> 
> On 07/08/2023 10:23, Dylan Jhong wrote:
> > Since RISC-V is a microarchitecture that allows caching invalid entries in the TLB,
> > it is necessary to issue a "preventive" SFENCE.VMA to ensure that each core obtains
> > the correct kernel mapping.
> > 
> > The patch implements TLB flushing in arch_sync_kernel_mappings(), ensuring that kernel
> > page table mappings created via vmap/vmalloc() are updated before switching MM.
> > 
> > Signed-off-by: Dylan Jhong <dylan@andestech.com>
> > ---
> >   arch/riscv/include/asm/page.h |  2 ++
> >   arch/riscv/mm/tlbflush.c      | 12 ++++++++++++
> >   2 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index b55ba20903ec..6c86ab69687e 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -21,6 +21,8 @@
> >   #define HPAGE_MASK              (~(HPAGE_SIZE - 1))
> >   #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
> > +#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PTE_MODIFIED
> > +
> >   /*
> >    * PAGE_OFFSET -- the first address of the first page of memory.
> >    * When not using MMU this corresponds to the first free page in
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 77be59aadc73..d63364948c85 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -149,3 +149,15 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >   	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
> >   }
> >   #endif
> > +
> > +/*
> > + * Since RISC-V is a microarchitecture that allows caching invalid entries in the TLB,
> > + * it is necessary to issue a "preventive" SFENCE.VMA to ensure that each core obtains
> > + * the correct kernel mapping. arch_sync_kernel_mappings() will ensure that kernel
> > + * page table mappings created via vmap/vmalloc() are updated before switching MM.
> > + */
> > +void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
> > +{
> > +	if (start < VMALLOC_END && end > VMALLOC_START)
> 
> 
> This test is too restrictive, it should catch the range [MODULES_VADDR; 
> MODULES_END[ too, sorry I did not notice that at first.
> 
> 
> > +		flush_tlb_all();
> > +}
> > \ No newline at end of file
> 
> 
> I have to admit that I *think* both your patch and mine are wrong: one of
> the problem that led to the removal of vmalloc_fault() is the possibility
> for tracing functions to actually allocate vmalloc regions in the vmalloc
> page fault path, which could give rise to nested exceptions (see
> https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/).
> 
> Here, everytime we allocate a vmalloc region, we send an IPI. If a vmalloc
> allocation happens in this path (if it is traced for example), it will give
> rise to an IPI...and so on.
> 
> So I came to the conclusion that the only way to actually fix this issue is
> by resolving the vmalloc faults very early in the page fault path (by
> emitting a sfence.vma on uarch that cache invalid entries), before the
> kernel stack is even accessed. That's the best solution since it would
> completely remove all the preventive sfence.vma in
> flush_cache_vmap()/arch_sync_kernel_mappings(), we would rely on faulting
> which I assume should not happen a lot (?).
> 

Hi Alex,

Agree. 

If we could introduce a "new vmalloc_fault()" function before accessing the kernel stack,
which would trigger an SFENCE.VMA instruction, then each time we call vmalloc() or vmap()
to create new kernel mappings, we wouldn't need to execute flush_cache_vmap() or
arch_sync_kernel_mappings() to update the TLB. This should be able to balance both
performance and correctness.

> I'm implementing this solution, but I'm pretty sure it won't be ready for
> 6.5. In the meantime, we need either your patch or mine to fix your issue...
> 

If there are no others reporting this issues, I believe encountering this TLB flush problem
might not be so common. Perhaps we could wait until you've finished implementing the
"new vmalloc_fault()" feature. If anyone encounters problems in the meantime, I think they
can temporarily apply either my patch or yours to workaround the issue of updating TLB for
vmalloc.

Best regards,
Dylan Jhong

