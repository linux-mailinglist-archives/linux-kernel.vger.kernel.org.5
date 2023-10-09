Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1468E7BDC41
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376452AbjJIMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346437AbjJIMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:36:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734138F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:36:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A3FC433C7;
        Mon,  9 Oct 2023 12:36:51 +0000 (UTC)
Message-ID: <afbe1955-5fae-415a-9f0a-1d7da7cb5fc9@linux-m68k.org>
Date:   Mon, 9 Oct 2023 22:36:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC] m68k: Add full preempt support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 7/10/23 00:49, Geert Uytterhoeven wrote:
> Currently, a Preemptible Kernel is only supported on the Coldfire CPU
> family.  Extend preempt support to the full Classic M68K CPU family
> (68020+ with MMU, and 68000-derivatives without MMU).
> 
> Make sure preemption is disabled in loops involving cache and TLB
> flushing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested on ARAnyM, using none/voluntary/full preemption.
> Compile-tested on 68000.
> 
> I don't know if all of the preempt_{dis,en}able() pairs are really
> needed, or if we need more of them.  I just followed what some other
> architectures are doing.
> 
> Without the preempt_{dis,en}able() pairs, the kernel panics on ARAnyM while
> starting early userspace (Debian 4.0), cfr. below.
> Does full preemption work on Coldfire without?

FWIW, I tested 6.6-rc5 with full pre-emption enabled (CONFIG_PREEMPT=y)
and it ran with no problems on the QEMU 5208 (so no MMU) and on an 5475
(so full MMU). Testing wasn't extensive, but it booted up and seemed
stable.

Regards
Greg



> Thanks for your comments!
> 
>      BUG: Bad rss-counter state mm:93ade98e type:MM_FILEPAGES val:-7
>      BUG: Bad rss-counter state mm:93ade98e type:MM_ANONPAGES val:-1
>      Kernel panic - not syncing: table already free!
>      CPU: 0 PID: 377 Comm: ntpdate-debian Not tainted 6.6.0-rc4-atari-01879-g107ed88a05ab #1592
>      Stack from 018d5cf4:
> 	    018d5cf4 004898d7 004898d7 00000000 00000001 003c0256 004898d7 003b9142
> 	    00000001 00000001 013c0000 01a36580 01a36a18 000cf24e 018d5e3a 0000639a
> 	    0047c616 c0189000 eff00000 013c0900 c0189000 c0000000 ee000000 01a36580
> 	    01a36a18 000cfc10 013c0900 00000001 ffffffff 018d5e1a 00000000 000cfa38
> 	    c0000000 0187da20 0187da20 003a95da 000dbc0e 000d5480 c0180000 c0188fff
> 	    c0188fff edffffff 000cfc90 018d5e3a c0000000 c0189000 00000000 eff0e000
>      Call Trace: [<003c0256>] dump_stack+0xc/0x10
>       [<003b9142>] panic+0xd8/0x256
>       [<000cf24e>] pmd_offset.isra.0+0x0/0x20
>       [<0000639a>] free_pointer_table+0x68/0x126
>       [<000cfc10>] free_pgd_range+0x1d8/0x1ea
>       [<000cfa38>] free_pgd_range+0x0/0x1ea
>       [<003a95da>] mas_find+0x0/0x4c
>       [<000dbc0e>] unlink_anon_vmas+0x0/0x108
>       [<000d5480>] unlink_file_vma+0x0/0x40
>       [<000cfc90>] free_pgtables+0x6e/0x80
>       [<00045d94>] up_read+0x0/0x62
>       [<000d6300>] exit_mmap+0x118/0x1ee
>       [<000f9b44>] arch_local_irq_enable+0x0/0x1c
>       [<000cbb74>] kfree+0x0/0x44
>       [<0000ffff>] EXPTBL+0x38f/0x400
>       [<00021e6c>] __mmput+0x18/0xae
>       [<000fb86e>] begin_new_exec+0x57e/0x7fa
>       [<003b23ce>] memcmp+0x0/0x5c
>       [<000cbb74>] kfree+0x0/0x44
>       [<00139ed0>] load_elf_phdrs+0x0/0x6e
>       [<0013aede>] load_elf_binary+0xce/0xb34
>       [<0013b00e>] load_elf_binary+0x1fe/0xb34
>       [<00004004>] do_notify_resume+0x390/0x4a0
>       [<000fad78>] bprm_execve+0x2ee/0x3f2
>       [<000fa33c>] copy_string_kernel+0x0/0xd8
>       [<000fa1c6>] copy_strings+0x0/0x176
>       [<000fafba>] do_execveat_common+0x13e/0x158
>       [<000fbb10>] sys_execve+0x26/0x30
>       [<0000259e>] syscall+0x8/0xc
>       [<0010c00d>] atime_needs_update+0x5/0x136
> 
>      ---[ end Kernel panic - not syncing: table already free! ]---
> 
> ---
>   arch/m68k/68000/entry.S               | 15 +++++++++++++++
>   arch/m68k/Kconfig                     |  1 -
>   arch/m68k/coldfire/cache.c            |  6 ++++++
>   arch/m68k/include/asm/cacheflush_mm.h | 23 +++++++++++++++++++++++
>   arch/m68k/include/asm/tlbflush.h      | 16 ++++++++++++++++
>   arch/m68k/kernel/entry.S              | 16 ++++++++++++++++
>   arch/m68k/mm/cache.c                  | 15 +++++++++++++++
>   7 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
> index 72e95663b62ffd54..1f79deb91da4dcbb 100644
> --- a/arch/m68k/68000/entry.S
> +++ b/arch/m68k/68000/entry.S
> @@ -87,6 +87,21 @@ ret_from_exception:
>   	btst	#5,%sp@(PT_OFF_SR)	/* check if returning to kernel*/
>   	jeq	Luser_return		/* if so, skip resched, signals*/
>   
> +#ifdef CONFIG_PREEMPTION
> +	movel	%sp,%d1			/* get thread_info pointer */
> +	andl	#-THREAD_SIZE,%d1	/* at base of kernel stack */
> +	movel	%d1,%a0
> +	movel	%a0@(TINFO_FLAGS),%d1	/* get thread_info->flags */
> +	btst	#TIF_NEED_RESCHED,%d1
> +	jeq	Lkernel_return
> +
> +	movel	%a0@(TINFO_PREEMPT),%d1
> +	jne	Lkernel_return
> +
> +	pea	Lkernel_return
> +	jmp	preempt_schedule_irq	/* preempt the kernel */
> +#endif /* CONFIG_PREEMPTION */
> +
>   Lkernel_return:
>   	RESTORE_ALL
>   
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 3e96486d9528cafc..4fd188c2a9ad092b 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -10,7 +10,6 @@ config M68K
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
>   	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
> -	select ARCH_NO_PREEMPT if !COLDFIRE
>   	select ARCH_USE_MEMTEST if MMU_MOTOROLA
>   	select ARCH_WANT_IPC_PARSE_VERSION
>   	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
> diff --git a/arch/m68k/coldfire/cache.c b/arch/m68k/coldfire/cache.c
> index 98ee89b87439cdc4..592fd1d579bef348 100644
> --- a/arch/m68k/coldfire/cache.c
> +++ b/arch/m68k/coldfire/cache.c
> @@ -10,6 +10,8 @@
>   /***************************************************************************/
>   
>   #include <linux/kernel.h>
> +#include <linux/preempt.h>
> +
>   #include <asm/coldfire.h>
>   #include <asm/mcfsim.h>
>   
> @@ -25,6 +27,8 @@
>   
>   void mcf_cache_push(void)
>   {
> +	preempt_disable();
> +
>   	__asm__ __volatile__ (
>   		"clrl	%%d0\n\t"
>   		"1:\n\t"
> @@ -42,6 +46,8 @@ void mcf_cache_push(void)
>   		  "i" (DCACHE_SIZE / CACHE_WAYS),
>   		  "i" (CACHE_WAYS)
>   		: "d0", "a0" );
> +
> +	preempt_enable();
>   }
>   
>   /***************************************************************************/
> diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
> index ed12358c4783b468..d58aa237bd91a139 100644
> --- a/arch/m68k/include/asm/cacheflush_mm.h
> +++ b/arch/m68k/include/asm/cacheflush_mm.h
> @@ -3,6 +3,8 @@
>   #define _M68K_CACHEFLUSH_H
>   
>   #include <linux/mm.h>
> +#include <linux/preempt.h>
> +
>   #ifdef CONFIG_COLDFIRE
>   #include <asm/mcfsim.h>
>   #endif
> @@ -63,6 +65,8 @@ static inline void flush_cf_icache(unsigned long start, unsigned long end)
>   {
>   	unsigned long set;
>   
> +	preempt_disable();
> +
>   	for (set = start; set <= end; set += (0x10 - 3)) {
>   		__asm__ __volatile__ (
>   			"cpushl %%ic,(%0)\n\t"
> @@ -75,12 +79,16 @@ static inline void flush_cf_icache(unsigned long start, unsigned long end)
>   			: "=a" (set)
>   			: "a" (set));
>   	}
> +
> +	preempt_enable();
>   }
>   
>   static inline void flush_cf_dcache(unsigned long start, unsigned long end)
>   {
>   	unsigned long set;
>   
> +	preempt_disable();
> +
>   	for (set = start; set <= end; set += (0x10 - 3)) {
>   		__asm__ __volatile__ (
>   			"cpushl %%dc,(%0)\n\t"
> @@ -93,12 +101,16 @@ static inline void flush_cf_dcache(unsigned long start, unsigned long end)
>   			: "=a" (set)
>   			: "a" (set));
>   	}
> +
> +	preempt_enable();
>   }
>   
>   static inline void flush_cf_bcache(unsigned long start, unsigned long end)
>   {
>   	unsigned long set;
>   
> +	preempt_disable();
> +
>   	for (set = start; set <= end; set += (0x10 - 3)) {
>   		__asm__ __volatile__ (
>   			"cpushl %%bc,(%0)\n\t"
> @@ -111,6 +123,8 @@ static inline void flush_cf_bcache(unsigned long start, unsigned long end)
>   			: "=a" (set)
>   			: "a" (set));
>   	}
> +
> +	preempt_enable();
>   }
>   
>   /*
> @@ -227,14 +241,21 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
>   		addr = ((unsigned long) vaddr) & ~(PAGE_SIZE - 1);
>   		start = addr & ICACHE_SET_MASK;
>   		end = (addr + nr * PAGE_SIZE - 1) & ICACHE_SET_MASK;
> +
> +		preempt_disable();
> +
>   		if (start > end) {
>   			flush_cf_bcache(0, end);
>   			end = ICACHE_MAX_ADDR;
>   		}
>   		flush_cf_bcache(start, end);
> +
> +		preempt_enable();
>   	} else if (CPU_IS_040_OR_060) {
>   		unsigned long paddr = __pa(vaddr);
>   
> +		preempt_disable();
> +
>   		do {
>   			__asm__ __volatile__("nop\n\t"
>   					     ".chip 68040\n\t"
> @@ -243,6 +264,8 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
>   					     : : "a" (paddr));
>   			paddr += PAGE_SIZE;
>   		} while (--nr);
> +
> +		preempt_enable();
>   	} else {
>   		unsigned long _tmp;
>   		__asm__ __volatile__("movec %%cacr,%0\n\t"
> diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
> index 6d42e2906887931b..f95a8e9c9912a3e8 100644
> --- a/arch/m68k/include/asm/tlbflush.h
> +++ b/arch/m68k/include/asm/tlbflush.h
> @@ -101,6 +101,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>   
>   #else
>   
> +#include <linux/preempt.h>
>   
>   /* Reserved PMEGs. */
>   extern char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
> @@ -115,6 +116,8 @@ static inline void flush_tlb_all(void)
>   	unsigned long addr;
>   	unsigned char ctx, oldctx;
>   
> +	preempt_disable();
> +
>   	oldctx = sun3_get_context();
>   	for (addr = 0x00000000; addr < TASK_SIZE; addr += SUN3_PMEG_SIZE) {
>   		for (ctx = 0; ctx < 8; ctx++) {
> @@ -133,6 +136,8 @@ static inline void flush_tlb_all(void)
>   			pmeg_vaddr[addr] = 0;
>   		}
>   	}
> +
> +	preempt_enable();
>   }
>   
>   /* Clear user TLB entries within the context named in mm */
> @@ -142,6 +147,8 @@ static inline void flush_tlb_mm (struct mm_struct *mm)
>   	unsigned char seg;
>   	unsigned long i;
>   
> +	preempt_disable();
> +
>   	oldctx = sun3_get_context();
>   	sun3_put_context(mm->context);
>   
> @@ -157,6 +164,8 @@ static inline void flush_tlb_mm (struct mm_struct *mm)
>   	}
>   
>   	sun3_put_context(oldctx);
> +
> +	preempt_enable();
>   }
>   
>   /* Flush a single TLB page. In this case, we're limited to flushing a
> @@ -167,6 +176,8 @@ static inline void flush_tlb_page (struct vm_area_struct *vma,
>   	unsigned char oldctx;
>   	unsigned char i;
>   
> +	preempt_disable();
> +
>   	oldctx = sun3_get_context();
>   	sun3_put_context(vma->vm_mm->context);
>   	addr &= ~SUN3_PMEG_MASK;
> @@ -179,6 +190,7 @@ static inline void flush_tlb_page (struct vm_area_struct *vma,
>   	}
>   	sun3_put_context(oldctx);
>   
> +	preempt_enable();
>   }
>   /* Flush a range of pages from TLB. */
>   
> @@ -190,6 +202,8 @@ static inline void flush_tlb_range (struct vm_area_struct *vma,
>   
>   	start &= ~SUN3_PMEG_MASK;
>   
> +	preempt_disable();
> +
>   	oldctx = sun3_get_context();
>   	sun3_put_context(mm->context);
>   
> @@ -207,6 +221,8 @@ static inline void flush_tlb_range (struct vm_area_struct *vma,
>   		start += SUN3_PMEG_SIZE;
>   	}
>   	sun3_put_context(oldctx);
> +
> +	preempt_enable();
>   }
>   
>   static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
> index 3bcdd32a6b36613d..9933679ea28b44ab 100644
> --- a/arch/m68k/kernel/entry.S
> +++ b/arch/m68k/kernel/entry.S
> @@ -241,7 +241,23 @@ syscall_exit_work:
>   ENTRY(ret_from_exception)
>   .Lret_from_exception:
>   	btst	#5,%sp@(PT_OFF_SR)	| check if returning to kernel
> +#ifdef CONFIG_PREEMPTION
> +	jeq	2f
> +
> +	movel   %curptr@(TASK_STACK),%a0
> +	tstb	%a0@(TINFO_FLAGS+3)	| check TIF_NEED_RESCHED
> +	jpl	1f
> +
> +	movel	%a0@(TINFO_PREEMPT),%d1
> +	jne	1f
> +
> +	pea	1f
> +	jmp	preempt_schedule_irq	| preempt the kernel
> +#else /* !CONFIG_PREEMPTION */
>   	bnes	1f			| if so, skip resched, signals
> +#endif /* !CONFIG_PREEMPTION */
> +
> +2:
>   	| only allow interrupts when we are really the last one on the
>   	| kernel stack, otherwise stack overflow can occur during
>   	| heavy interrupt load
> diff --git a/arch/m68k/mm/cache.c b/arch/m68k/mm/cache.c
> index dde978e66f14fb31..d23958bc2a815ea7 100644
> --- a/arch/m68k/mm/cache.c
> +++ b/arch/m68k/mm/cache.c
> @@ -8,6 +8,8 @@
>    */
>   
>   #include <linux/module.h>
> +#include <linux/preempt.h>
> +
>   #include <asm/cacheflush.h>
>   #include <asm/traps.h>
>   
> @@ -62,14 +64,21 @@ void flush_icache_user_range(unsigned long address, unsigned long endaddr)
>   		unsigned long start, end;
>   		start = address & ICACHE_SET_MASK;
>   		end = endaddr & ICACHE_SET_MASK;
> +
> +		preempt_disable();
> +
>   		if (start > end) {
>   			flush_cf_icache(0, end);
>   			end = ICACHE_MAX_ADDR;
>   		}
>   		flush_cf_icache(start, end);
> +
> +		preempt_enable();
>   	} else if (CPU_IS_040_OR_060) {
>   		address &= PAGE_MASK;
>   
> +		preempt_disable();
> +
>   		do {
>   			asm volatile ("nop\n\t"
>   				      ".chip 68040\n\t"
> @@ -78,6 +87,8 @@ void flush_icache_user_range(unsigned long address, unsigned long endaddr)
>   				      : : "a" (virt_to_phys_slow(address)));
>   			address += PAGE_SIZE;
>   		} while (address < endaddr);
> +
> +		preempt_enable();
>   	} else {
>   		unsigned long tmp;
>   		asm volatile ("movec %%cacr,%0\n\t"
> @@ -103,12 +114,16 @@ void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
>   		unsigned long start, end;
>   		start = addr & ICACHE_SET_MASK;
>   		end = (addr + len) & ICACHE_SET_MASK;
> +
> +		preempt_disable();
> +
>   		if (start > end) {
>   			flush_cf_icache(0, end);
>   			end = ICACHE_MAX_ADDR;
>   		}
>   		flush_cf_icache(start, end);
>   
> +		preempt_enable();
>   	} else if (CPU_IS_040_OR_060) {
>   		asm volatile ("nop\n\t"
>   			      ".chip 68040\n\t"
