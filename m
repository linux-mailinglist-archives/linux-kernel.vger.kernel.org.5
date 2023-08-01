Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8876B671
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjHAN4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHAN4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:56:15 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03DA185
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:56:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 548354000C;
        Tue,  1 Aug 2023 13:56:06 +0000 (UTC)
Message-ID: <dc26625b-6658-c078-76d2-7e975a04b1d4@ghiti.fr>
Date:   Tue, 1 Aug 2023 15:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] riscv: Flush stale TLB entry with VMAP_STACK enabled
To:     Dylan Jhong <dylan@andestech.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, wangkefeng.wang@huawei.com,
        tongtiangen@huawei.com, guoren@kernel.org,
        sergey.matyukevich@syntacore.com, gregkh@linuxfoundation.org,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor.dooley@microchip.com
Cc:     x5710999x@gmail.com, tim609@andestech.com, cl634@andestech.com,
        ycliang@andestech.com
References: <20230801090927.2018653-1-dylan@andestech.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230801090927.2018653-1-dylan@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,


On 01/08/2023 11:09, Dylan Jhong wrote:
> When VMAP_STACK is enabled, the kernel stack will be obtained through
> vmalloc(). Normally, we rely on the logic in vmalloc_fault() to update stale
> P*D entries covering the vmalloc space in a task's page tables when it first
> accesses the problematic region.


I guess that's for rv32 right? Because vmalloc_fault() has been removed 
for rv64 in 6.5.

Here you describe the issue as being caused by the vmap stack being in a 
new PGD which then needs a page table synchronization in 
vmalloc_fault(), which can't happen since vmalloc_fault() needs this 
same stack in the current page table.


>   Unfortunately, this is not sufficient when
> the kernel stack resides in the vmalloc region, because vmalloc_fault() is a
> C function that needs a stack to run. So we need to ensure that these P*D
> entries are up to date *before* the MM switch.
>
> Here's our symptom:
> core 0: A speculative load lead the kernel stack load to the TLB before the
>          corresponding kernel stack's page table is created.
> core 1: Create page table mapping of that kernel stack.
> core 0: After a context switch, the kernel attempts to use the stack region.
>          However, even if the page table is correct, the stack address mapping
>          in the TLB is invalid, leading to subsequent nested exceptions.


But here the problem you describe is different since it seems to be 
caused by the TLB caching invalid entries which then needs a sfence.vma 
for the page table walker to see the new correct entry.


>
> This fix is inspired by ARM's approach[*1], commit a1c510d0adc6 ("ARM:
> implement support for vmap'ed stacks"), it also performs a TLB flush after
> setting up the page tables in vmalloc().
> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>   arch/riscv/include/asm/page.h |  4 ++++
>   arch/riscv/mm/tlbflush.c      | 16 ++++++++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 349fad5e35de..c9b080a72855 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -21,6 +21,10 @@
>   #define HPAGE_MASK              (~(HPAGE_SIZE - 1))
>   #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
>   
> +#ifdef CONFIG_VMAP_STACK
> +#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PTE_MODIFIED
> +#endif
> +
>   /*
>    * PAGE_OFFSET -- the first address of the first page of memory.
>    * When not using MMU this corresponds to the first free page in
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index ef701fa83f36..0799978913ee 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -86,3 +86,19 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>   	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
>   }
>   #endif
> +
> +#ifdef CONFIG_VMAP_STACK
> +/*
> + * Normally, we rely on the logic in vmalloc_fault() to update stale P*D
> + * entries covering the vmalloc space in a task's page tables when it first
> + * accesses the problematic region. Unfortunately, this is not sufficient when
> + * the kernel stack resides in the vmalloc region, because vmalloc_fault() is a
> + * C function that needs a stack to run. So we need to ensure that these P*D
> + * entries are up to date *before* the MM switch.
> + */
> +void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
> +{
> +	if (start < VMALLOC_END && end > VMALLOC_START)
> +		flush_tlb_all();
> +}
> +#endif


And if that works for you, I'd say the problem is the latter: the TLB 
caching invalid entries, since you don't synchronize the page tables 
here. That looks a lot like the patch I proposed here 
https://patchwork.kernel.org/project/linux-riscv/patch/20230725132246.817726-1-alexghiti@rivosinc.com/ 
that implements flush_cache_vmap().

So I'm not mistaken, we have another problem in 32-bit: I guess that in 
your example core 0 and core 1 execute in the same address space (ie the 
same page table) and a simple sfence.vma gets rid of the invalid entry 
and things can go on. But what if 2 page tables are created with the 
same vmalloc mappings, one adds a PGD in the vmalloc mapping, then the 
other one does not have it in its page table but still allocates its 
vmap stack in this new PGD => the latter would never be able to recover 
from the vmalloc fault since it needs to update its page table with the 
new PGD and it needs the new PGD for that.

Let me know if I'm completely wrong here!

Thanks,

Alex


