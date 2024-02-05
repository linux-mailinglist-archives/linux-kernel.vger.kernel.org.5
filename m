Return-Path: <linux-kernel+bounces-52667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC670849B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353C9B27054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB8F2C6B9;
	Mon,  5 Feb 2024 12:56:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD61CA82
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137759; cv=none; b=qDwB3oRnhU0GtYJQKK/Fc3sys13rB0FubGfvrFKVst6BatthhOJGDjxvark5KUn52rLtEZWcynTYbRJlnpoL5T65xAxpjYL4sAs5fgX7th/iLb38trFUd9aCkDnvMhKzP/SR3RtKBj9pPtinGvbeq2moOBhtf8GjUiviXXIzvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137759; c=relaxed/simple;
	bh=lKF8U8QoAA9cfRCh85seNuwJO12DUaG+V/HoXOV6Xoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG/8BurPf86DQtBdZ0d7va4hHJlXWCO1nH4HofSV2PYq6Spj6bm2coJcAqcFK6ODLd7Nzq4u/pLRmOAT3IUGCWDtKiFlutJnjHebolv615HJa/8Ss8jcc+aSTvsIZ5FSPemqWSTdRgFKsmofx76Jj8hbnjJbpZh/yAwP5gwKUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2591FB;
	Mon,  5 Feb 2024 04:56:39 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5E893F762;
	Mon,  5 Feb 2024 04:55:55 -0800 (PST)
Date: Mon, 5 Feb 2024 12:55:53 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Print provenance information for addresses in
 registers
Message-ID: <ZcDa2RXC6z7XuwAD@FVFF77S0Q05N>
References: <20240201153811.1793120-1-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201153811.1793120-1-stefan.wiehler@nokia.com>

On Thu, Feb 01, 2024 at 04:38:11PM +0100, Stefan Wiehler wrote:
> Like commit 5aa6b70ed182 ("arm: print alloc free paths for address in
> registers") already does for 32-bit ARM, print available provenance information
> for addresses in registers in case of internal error as a debugging aid:
> 
>   Unable to handle kernel write to read-only memory at virtual address ffffffc00117cd5c
>   ...
>   x2 : 0000000000001b98 x1 : 0000000000000000 x0 : ffffffc00117cd5c
>   ...
>   Register x0 information: 14-page vmalloc region starting at 0xffffffc00117a000 allocated at load_module+0x15c4/0x2bc0
>   Register x1 information: NULL pointer
>   Register x2 information: non-paged memory
>   ...

Regardless of what 32-bit ARM does, I don't think it makes sense to dump this
for all the GPRs. It's incredibly verbose and not all that helpful, e.g.
testing with the LKDTM WRITE_RO test I get:

| # echo WRITE_RO > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry WRITE_RO
| lkdtm: attempting bad rodata write at ffffadee958c1bf0
| Unable to handle kernel write to read-only memory at virtual address ffffadee958c1bf0
| Mem abort info:
|   ESR = 0x000000009600004e
|   EC = 0x25: DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
|   FSC = 0x0e: level 2 permission fault
| Data abort info:
|   ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
|   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
|   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
| swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d6d000
| [ffffadee958c1bf0] pgd=100000043ffff803, p4d=100000043ffff803, pud=100000043fffe803, pmd=0060000041600f81
| Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
| Modules linked in:
| CPU: 4 PID: 147 Comm: sh Not tainted 6.8.0-rc3-00001-gc66454d88811 #1
| Hardware name: linux,dummy-virt (DT)
| pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
| pc : lkdtm_WRITE_RO+0x3c/0x54
| lr : lkdtm_WRITE_RO+0x24/0x54
| sp : ffff800080913c80
| x29: ffff800080913c80 x28: ffff0000c09ca200 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000aaaaee418930
| x23: ffff0000c0645780 x22: ffff800080913df0 x21: ffffadee96c957a0
| x20: 0000000000000009 x19: ffffadee958c1000 x18: 0000000000000006
| x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080913720
| x14: 0000000000000000 x13: ffffadee969310b0 x12: 0000000000000432
| x11: 0000000000000166 x10: ffffadee969890b0 x9 : ffffadee969310b0
| x8 : 00000000ffffefff x7 : ffffadee969890b0 x6 : 80000000fffff000
| x5 : ffff0003fdfb5cc8 x4 : 0000000000000000 x3 : 0000000000000000
| x2 : 00000000abcd1234 x1 : 000000000198b861 x0 : ffffadee95e334a0
| Call trace:
|  lkdtm_WRITE_RO+0x3c/0x54
|  lkdtm_do_action+0x1c/0x30
|  direct_entry+0xbc/0x144
|  full_proxy_write+0x60/0xb4
|  vfs_write+0xd0/0x35c
|  ksys_write+0x70/0x104
|  __arm64_sys_write+0x1c/0x28
|  invoke_syscall+0x48/0x110
|  el0_svc_common.constprop.0+0x40/0xe0
|  do_el0_svc+0x1c/0x28
|  el0_svc+0x34/0xb4
|  el0t_64_sync_handler+0x120/0x12c
|  el0t_64_sync+0x190/0x194
| Register x0 information: 0-page vmalloc region starting at 0xffffadee95470000 allocated at paging_init+0x148/0x6f4
| Register x1 information: non-paged memory
| Register x2 information: non-paged memory
| Register x3 information: NULL pointer
| Register x4 information: NULL pointer
| Register x5 information: non-slab/vmalloc memory
| Register x6 information: non-paged memory
| Register x7 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
| Register x8 information: non-paged memory
| Register x9 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
| Register x10 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
| Register x11 information: non-paged memory
| Register x12 information: non-paged memory
| Register x13 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
| Register x14 information: NULL pointer
| Register x15 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
| Register x16 information: NULL pointer
| Register x17 information: NULL pointer
| Register x18 information: non-paged memory
| Register x19 information: 0-page vmalloc region starting at 0xffffadee95470000 allocated at paging_init+0x148/0x6f4
| Register x20 information: non-paged memory
| Register x21 information: 0-page vmalloc region starting at 0xffffadee96910000 allocated at paging_init+0x1d8/0x6f4
| Register x22 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
| Register x23 information: slab dentry start ffff0000c0645780 pointer offset 0 size 192
| Register x24 information: non-paged memory
| Register x25 information: NULL pointer
| Register x26 information: NULL pointer
| Register x27 information: NULL pointer
| Register x28 information: slab task_struct start ffff0000c09ca200 pointer offset 0 size 4352
| Register x29 information: 4-page vmalloc region starting at 0xffff800080910000 allocated at kernel_clone+0x64/0x360
| Code: f2b579a2 900089c0 ca020021 91128000 (f905fa61)
| ---[ end trace 0000000000000000 ]---

Looking at the dump, the vast majority of those "Register X?? information:"
lines are irrelevant, and it's difficult to see the wood for the trees.

Why do we need this for (almost) all registers, rather than just the faulting
address?

In die_kernel_fault() we already print some information regarding the psecific
faulting address:

| static void die_kernel_fault(const char *msg, unsigned long addr,
|                              unsigned long esr, struct pt_regs *regs)
| {
|         bust_spinlocks(1);
| 
|         pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
|                  addr);
| 
|         kasan_non_canonical_hook(addr);
| 
|         mem_abort_decode(esr);
| 
|         show_pte(addr);
|         die("Oops", regs, esr);
|         bust_spinlocks(0);
|         make_task_dead(SIGKILL);
| }

.. and IMO it'd make more sense to call mem_dump_obj() there, e.g.

| static void die_kernel_fault(const char *msg, unsigned long addr,
|                              unsigned long esr, struct pt_regs *regs)
| {
|         bust_spinlocks(1);
| 
|         pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
|                  addr);
| 
|         pr_alert("Fauling address:");
|         mem_dump_obj((void *)addr);
|         kasan_non_canonical_hook(addr);
| 
|         mem_abort_decode(esr);
| 
|         show_pte(addr);
|         die("Oops", regs, esr);
|         bust_spinlocks(0);
|         make_task_dead(SIGKILL);
| }

.. which produces significantly more legible output, e.g.

| # echo WRITE_RO > /sys/kernel/debug/provoke-crash/DIRECT 
| lkdtm: Performing direct entry WRITE_RO
| lkdtm: attempting bad rodata write at ffffa66f5e2c1bf0
| Unable to handle kernel write to read-only memory at virtual address ffffa66f5e2c1bf0
| Fauling address: 0-page vmalloc region starting at 0xffffa66f5de70000 allocated at paging_init+0x148/0x6f4
| Mem abort info:
|   ESR = 0x000000009600004e
|   EC = 0x25: DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
|   FSC = 0x0e: level 2 permission fault
| Data abort info:
|   ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
|   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
|   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
| swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041d6d000
| [ffffa66f5e2c1bf0] pgd=100000043ffff803, p4d=100000043ffff803, pud=100000043fffe803, pmd=0060000041600f81
| Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
| Modules linked in:
| CPU: 3 PID: 148 Comm: sh Not tainted 6.8.0-rc3-00002-gf95e3bd06270-dirty #2
| Hardware name: linux,dummy-virt (DT)
| pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
| pc : lkdtm_WRITE_RO+0x3c/0x54
| lr : lkdtm_WRITE_RO+0x24/0x54
| sp : ffff80008098bc80
| x29: ffff80008098bc80 x28: ffff0000c144a200 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000aaab235e21d0
| x23: ffff0000c06459c0 x22: ffff80008098bdf0 x21: ffffa66f5f6957a0
| x20: 0000000000000009 x19: ffffa66f5e2c1000 x18: 0000000000000006
| x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008098b720
| x14: 0000000000000000 x13: ffffa66f5f3310b0 x12: 0000000000000432
| x11: 0000000000000166 x10: ffffa66f5f3890b0 x9 : ffffa66f5f3310b0
| x8 : 00000000ffffefff x7 : ffffa66f5f3890b0 x6 : 80000000fffff000
| x5 : ffff0003fdf9fcc8 x4 : 0000000000000000 x3 : 0000000000000000
| x2 : 00000000abcd1234 x1 : 000000000198b861 x0 : ffffa66f5e8334b0
| Call trace:
|  lkdtm_WRITE_RO+0x3c/0x54
|  lkdtm_do_action+0x1c/0x30
|  direct_entry+0xbc/0x144
|  full_proxy_write+0x60/0xb4
|  vfs_write+0xd0/0x35c
|  ksys_write+0x70/0x104
|  __arm64_sys_write+0x1c/0x28
|  invoke_syscall+0x48/0x110
|  el0_svc_common.constprop.0+0x40/0xe0
|  do_el0_svc+0x1c/0x28
|  el0_svc+0x34/0xb4
|  el0t_64_sync_handler+0x120/0x12c
|  el0t_64_sync+0x190/0x194
| Code: f2b579a2 900089c0 ca020021 9112c000 (f905fa61) 
| ---[ end trace 0000000000000000 ]---

.. and likewise even when we hit addresses without KASAN shadow:

| # echo ACCESS_NULL > /sys/kernel/debug/provoke-crash/DIRECT 
| lkdtm: Performing direct entry ACCESS_NULL
| lkdtm: attempting bad read at 0000000000000000
| Unable to handle kernel paging request at virtual address dfff800000000000
| Fauling address: non-paged memory
| KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
| Mem abort info:
|   ESR = 0x0000000096000005
|   EC = 0x25: DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
|   FSC = 0x05: level 1 translation fault
| Data abort info:
|   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
|   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
|   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
| [dfff800000000000] address between user and kernel address ranges
| Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 2 PID: 149 Comm: sh Not tainted 6.8.0-rc3-00002-gf95e3bd06270-dirty #3
| Hardware name: linux,dummy-virt (DT)
| pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
| pc : lkdtm_ACCESS_NULL+0x2c/0xa4
| lr : lkdtm_ACCESS_NULL+0x24/0xa4
| sp : ffff800080d87ab0
| x29: ffff800080d87ab0 x28: ffff0000c5296f14 x27: 1fffe00018a52df5
| x26: ffff0000c5296fa0 x25: 1fffe00018a52df4 x24: ffff0000c8fcda00
| x23: 0000aaaadb0a7040 x22: ffff800080d87d70 x21: ffffcb98b050dae0
| x20: 000000000000000c x19: ffffcb98acd53f40 x18: ffff0003fdff56c0
| x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
| x14: 0000000000000000 x13: 3030303030303030 x12: ffff7000101b0ee1
| x11: 1ffff000101b0ee0 x10: ffff7000101b0ee0 x9 : dfff800000000000
| x8 : 00008fffefe4f120 x7 : ffff800080d87707 x6 : 0000000000000001
| x5 : ffff800080d87700 x4 : 1fffe000191f9b41 x3 : 0000000000000000
| x2 : 0000000000000000 x1 : ffff0000c8fcda00 x0 : dfff800000000000
| Call trace:
|  lkdtm_ACCESS_NULL+0x2c/0xa4
|  lkdtm_do_action+0x3c/0x68
|  direct_entry+0x130/0x228
|  full_proxy_write+0xd4/0x140
|  vfs_write+0x1e4/0x8ec
|  ksys_write+0xf4/0x1e0
|  __arm64_sys_write+0x6c/0x9c
|  invoke_syscall+0x6c/0x254
|  el0_svc_common.constprop.0+0xac/0x230
|  do_el0_svc+0x40/0x58
|  el0_svc+0x38/0x70
|  el0t_64_sync_handler+0x120/0x12c
|  el0t_64_sync+0x190/0x194
| Code: aa1303e0 97adbc11 d2d00000 f2fbffe0 (39c00000) 
| ---[ end trace 0000000000000000 ]---

> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  arch/arm64/include/asm/system_misc.h |  1 +
>  arch/arm64/kernel/process.c          | 11 +++++++++++
>  arch/arm64/kernel/traps.c            |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
> index c34344256762..5b9b02fee988 100644
> --- a/arch/arm64/include/asm/system_misc.h
> +++ b/arch/arm64/include/asm/system_misc.h
> @@ -31,6 +31,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned long,
>  
>  struct mm_struct;
>  extern void __show_regs(struct pt_regs *);
> +extern void __show_regs_alloc_free(struct pt_regs *);
>  
>  #endif	/* __ASSEMBLY__ */
>  
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 7387b68c745b..b6fc2ac6e007 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -197,6 +197,17 @@ static void print_pstate(struct pt_regs *regs)
>  	}
>  }
>  
> +void __show_regs_alloc_free(struct pt_regs *regs)
> +{
> +	int i;
> +
> +	/* check for x0 - x29 only */
> +	for (i = 0; i < 30; i++) {
> +		pr_alert("Register x%d information:", i);
> +		mem_dump_obj((void *)regs->regs[i]);
> +	}
> +}

As above, I don't think it makes sense to dump this for a bunch of GPRs, and
I'd strongly prefer that we just do this for the faulting address.

I would also note that X30 can be used as a scratch register in the body of
functions and might hold an interesting address, whereas x2 *should* always
point to a frame record on the stack. So I don't understand why we'd both
dumping x29 but skip x30.

>  void __show_regs(struct pt_regs *regs)
>  {
>  	int i, top_reg;
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 215e6d7f2df8..b7bf22f1b33f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -197,6 +197,7 @@ static int __die(const char *str, long err, struct pt_regs *regs)
>  
>  	print_modules();
>  	show_regs(regs);
> +	__show_regs_alloc_free(regs);
>  
>  	dump_kernel_instr(KERN_EMERG, regs);

We call die() (and consequently __die()) for a number of errors where the
provenance information isn't interesting (e.g. UNDEF, BTI, FPAC, BUG). As above
I think it makes more sense to only dump this in die_kernel_fault(), and only
for the actual faulting address.

Thanks,
Mark.

