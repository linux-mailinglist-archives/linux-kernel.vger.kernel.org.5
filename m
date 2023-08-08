Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5E0774946
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjHHTuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjHHTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:50:29 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2852E9B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:56:57 -0700 (PDT)
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 76CD6D5BAA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:17:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E6DC1BF204;
        Tue,  8 Aug 2023 10:16:51 +0000 (UTC)
Message-ID: <5681817e-2751-0166-b823-df03aebedf9f@ghiti.fr>
Date:   Tue, 8 Aug 2023 12:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] riscv: Implement arch_sync_kernel_mappings() for
 "preventive" TLB flush
To:     Dylan Jhong <dylan@andestech.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        sergey.matyukevich@syntacore.com, maz@kernel.org,
        linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
        linux-kernel@vger.kernel.org
Cc:     ycliang@andestech.com, x5710999x@gmail.com, tim609@andestech.com
References: <20230807082305.198784-1-dylan@andestech.com>
 <20230807082305.198784-2-dylan@andestech.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230807082305.198784-2-dylan@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,

On 07/08/2023 10:23, Dylan Jhong wrote:
> Since RISC-V is a microarchitecture that allows caching invalid entries in the TLB,
> it is necessary to issue a "preventive" SFENCE.VMA to ensure that each core obtains
> the correct kernel mapping.
>
> The patch implements TLB flushing in arch_sync_kernel_mappings(), ensuring that kernel
> page table mappings created via vmap/vmalloc() are updated before switching MM.
>
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>   arch/riscv/include/asm/page.h |  2 ++
>   arch/riscv/mm/tlbflush.c      | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index b55ba20903ec..6c86ab69687e 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -21,6 +21,8 @@
>   #define HPAGE_MASK              (~(HPAGE_SIZE - 1))
>   #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
>   
> +#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PTE_MODIFIED
> +
>   /*
>    * PAGE_OFFSET -- the first address of the first page of memory.
>    * When not using MMU this corresponds to the first free page in
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 77be59aadc73..d63364948c85 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -149,3 +149,15 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>   	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
>   }
>   #endif
> +
> +/*
> + * Since RISC-V is a microarchitecture that allows caching invalid entries in the TLB,
> + * it is necessary to issue a "preventive" SFENCE.VMA to ensure that each core obtains
> + * the correct kernel mapping. arch_sync_kernel_mappings() will ensure that kernel
> + * page table mappings created via vmap/vmalloc() are updated before switching MM.
> + */
> +void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
> +{
> +	if (start < VMALLOC_END && end > VMALLOC_START)


This test is too restrictive, it should catch the range [MODULES_VADDR;  
MODULES_END[ too, sorry I did not notice that at first.


> +		flush_tlb_all();
> +}
> \ No newline at end of file


I have to admit that I *think* both your patch and mine are wrong: one 
of the problem that led to the removal of vmalloc_fault() is the 
possibility for tracing functions to actually allocate vmalloc regions 
in the vmalloc page fault path, which could give rise to nested 
exceptions (see 
https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/).

Here, everytime we allocate a vmalloc region, we send an IPI. If a 
vmalloc allocation happens in this path (if it is traced for example), 
it will give rise to an IPI...and so on.

So I came to the conclusion that the only way to actually fix this issue 
is by resolving the vmalloc faults very early in the page fault path (by 
emitting a sfence.vma on uarch that cache invalid entries), before the 
kernel stack is even accessed. That's the best solution since it would 
completely remove all the preventive sfence.vma in 
flush_cache_vmap()/arch_sync_kernel_mappings(), we would rely on 
faulting which I assume should not happen a lot (?).

I'm implementing this solution, but I'm pretty sure it won't be ready 
for 6.5. In the meantime, we need either your patch or mine to fix your 
issue...

