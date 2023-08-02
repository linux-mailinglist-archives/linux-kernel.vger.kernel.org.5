Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574C276CD6C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjHBMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjHBMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:47:22 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82455212D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:46:55 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 372CkPZs081155;
        Wed, 2 Aug 2023 20:46:25 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 2 Aug 2023
 20:46:25 +0800
Date:   Wed, 2 Aug 2023 20:46:25 +0800
From:   dylan <dylan@andestech.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <wangkefeng.wang@huawei.com>, <tongtiangen@huawei.com>,
        <guoren@kernel.org>, <sergey.matyukevich@syntacore.com>,
        <gregkh@linuxfoundation.org>, <ajones@ventanamicro.com>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor.dooley@microchip.com>,
        <x5710999x@gmail.com>, <tim609@andestech.com>,
        <cl634@andestech.com>, <ycliang@andestech.com>
Subject: Re: [PATCH] riscv: Flush stale TLB entry with VMAP_STACK enabled
Message-ID: <ZMpQIXXfFLCFeOtg@atctrx.andestech.com>
References: <20230801090927.2018653-1-dylan@andestech.com>
 <dc26625b-6658-c078-76d2-7e975a04b1d4@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc26625b-6658-c078-76d2-7e975a04b1d4@ghiti.fr>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 372CkPZs081155
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:56:06PM +0200, Alexandre Ghiti wrote:

Hi Alex,

Thanks for the comment.

> Hi Dylan,
> 
> 
> On 01/08/2023 11:09, Dylan Jhong wrote:
> > When VMAP_STACK is enabled, the kernel stack will be obtained through
> > vmalloc(). Normally, we rely on the logic in vmalloc_fault() to update stale
> > P*D entries covering the vmalloc space in a task's page tables when it first
> > accesses the problematic region.
> 
> 
> I guess that's for rv32 right? Because vmalloc_fault() has been removed for
> rv64 in 6.5.
> 
> Here you describe the issue as being caused by the vmap stack being in a new
> PGD which then needs a page table synchronization in vmalloc_fault(), which
> can't happen since vmalloc_fault() needs this same stack in the current page
> table.
> 

No. This problem only occurs on rv64. It is triggered when the kernel stack is
allocated via vmalloc(), which is only eligible if VMAP_STACK is enabled.
According to riscv/Kconfig, VMAP_STACK can only be enabled under rv64.

Sorry I forgot to mention that I was developing on Linux 6.1 LTS, And I did not
notice that vmalloc_fault() was removed in Linux 6.5. But this should not impact
the problem this patch aims to solve, as the kernel stack is accessed in
handle_exception()[1] long before vmalloc_fault() is called.

To verify this, I also backported the "remove vmalloc_fault()" patch [2] to
Linux 6.1 LTS. The experiment revealed that the problem still persists.

[*1]: https://github.com/torvalds/linux/blob/master/arch/riscv/kernel/entry.S#L42
[*2]: https://lore.kernel.org/linux-mm/871qiyfhpe.fsf@all.your.base.are.belong.to.us/T/

> 
> >   Unfortunately, this is not sufficient when
> > the kernel stack resides in the vmalloc region, because vmalloc_fault() is a
> > C function that needs a stack to run. So we need to ensure that these P*D
> > entries are up to date *before* the MM switch.
> > 
> > Here's our symptom:
> > core 0: A speculative load lead the kernel stack load to the TLB before the
> >          corresponding kernel stack's page table is created.
> > core 1: Create page table mapping of that kernel stack.
> > core 0: After a context switch, the kernel attempts to use the stack region.
> >          However, even if the page table is correct, the stack address mapping
> >          in the TLB is invalid, leading to subsequent nested exceptions.
> 
> 
> But here the problem you describe is different since it seems to be caused
> by the TLB caching invalid entries which then needs a sfence.vma for the
> page table walker to see the new correct entry.
> 

TLB caching invalid entries is exactly the problem we encountered, so my modification
is trying to update the TLB through the arch_sync_kernel_mappings() after vmalloc
creates the page table.

let me describe the situation we encountered more clearly:

When we execute a multi-threaded user space program on rv64 SMP CPU, we eventually
encounter the issue of nested exceptions caused by the TLB not being updated.


CPU0                                           CPU1
- (Thread 1) Create page table
- (Thread 1) Do plist_check_list() to
  check the kernel stack used by thread 1
  is valid. But a speculative load will
  be triggered here, causing the kernel
  stack address of thread 2 to be loaded
  to the TLB of CPU0, and thread 2 has
  not yet been established at this time.
                                               - (Thread 2) Create page table
                                               - (Thread 2) Do plist_check_list().
                                               - Switch MM
- (Thread 2) Keep executing user program
  (thread 2) Enter handle_exception().
  In Handle_excption() will try to access
  kernel stack to store registers. But the
  kernel stack mapping in TLB is invalid.
  So another page fault exception is raised.
  The nested exception occurs here. System hang.

Therefore, the main intention of this patch is to flush the TLB of all CPUs
after the page table created by vmalloc() before switching MM.

> 
> > 
> > This fix is inspired by ARM's approach[*1], commit a1c510d0adc6 ("ARM:
> > implement support for vmap'ed stacks"), it also performs a TLB flush after
> > setting up the page tables in vmalloc().
> > Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> > Signed-off-by: Dylan Jhong <dylan@andestech.com>
> > ---
> >   arch/riscv/include/asm/page.h |  4 ++++
> >   arch/riscv/mm/tlbflush.c      | 16 ++++++++++++++++
> >   2 files changed, 20 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index 349fad5e35de..c9b080a72855 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -21,6 +21,10 @@
> >   #define HPAGE_MASK              (~(HPAGE_SIZE - 1))
> >   #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
> > +#ifdef CONFIG_VMAP_STACK
> > +#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PTE_MODIFIED
> > +#endif
> > +
> >   /*
> >    * PAGE_OFFSET -- the first address of the first page of memory.
> >    * When not using MMU this corresponds to the first free page in
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index ef701fa83f36..0799978913ee 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -86,3 +86,19 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >   	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
> >   }
> >   #endif
> > +
> > +#ifdef CONFIG_VMAP_STACK
> > +/*
> > + * Normally, we rely on the logic in vmalloc_fault() to update stale P*D
> > + * entries covering the vmalloc space in a task's page tables when it first
> > + * accesses the problematic region. Unfortunately, this is not sufficient when
> > + * the kernel stack resides in the vmalloc region, because vmalloc_fault() is a
> > + * C function that needs a stack to run. So we need to ensure that these P*D
> > + * entries are up to date *before* the MM switch.
> > + */
> > +void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
> > +{
> > +	if (start < VMALLOC_END && end > VMALLOC_START)
> > +		flush_tlb_all();
> > +}
> > +#endif
> 
> 
> And if that works for you, I'd say the problem is the latter: the TLB
> caching invalid entries, since you don't synchronize the page tables here.
> That looks a lot like the patch I proposed here https://patchwork.kernel.org/project/linux-riscv/patch/20230725132246.817726-1-alexghiti@rivosinc.com/
> that implements flush_cache_vmap().
> 

Updating the TLB in flush_cache_vmap() might address the problem I encountered,
And I noticed that ARM accomplishes this through arch_sync_kernel_mappings()[3].
As a result, I chose to adopt a similar approach to ARM's solution.

[3]: https://github.com/torvalds/linux/blob/5d0c230f1de8c7515b6567d9afba1f196fb4e2f4/arch/arm/kernel/traps.c#L962

> So I'm not mistaken, we have another problem in 32-bit: I guess that in your
> example core 0 and core 1 execute in the same address space (ie the same
> page table) and a simple sfence.vma gets rid of the invalid entry and things
> can go on. But what if 2 page tables are created with the same vmalloc
> mappings, one adds a PGD in the vmalloc mapping, then the other one does not
> have it in its page table but still allocates its vmap stack in this new PGD
> => the latter would never be able to recover from the vmalloc fault since it
> needs to update its page table with the new PGD and it needs the new PGD for
> that.
> 
> Let me know if I'm completely wrong here!
> 
> Thanks,
> 
> Alex
> 
> 

Best regards,
Dylan Jhong


