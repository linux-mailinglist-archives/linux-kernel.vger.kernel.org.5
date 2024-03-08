Return-Path: <linux-kernel+bounces-96443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A91A875C49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE762833CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515F224CC;
	Fri,  8 Mar 2024 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmW1RkoI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706F33DF;
	Fri,  8 Mar 2024 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864198; cv=none; b=msAlsa8fKGyg9OU+c9sIa6EXuw3R6WJ+IlSt04KTly2pkscSJ/xMxMGeW5BmIxIQ9IOfNkVRCYWdAFfyK53rvAW6oJkG2l+Oe2vYds/oZO1JlC/Z4JJpVFSqe2pRSk49ckN+vuN0FgUDRLVH2hdflrI68D8uVXANlmhbC9lDblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864198; c=relaxed/simple;
	bh=RCTXtHDuyluD9s9SEqOxYt+UGzzBuaP50dQGyMet+og=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mzFtf59UxB11EzEeDuLQCHrZWU1BvZDT3ETasux9OjxfQvGUuTYdBLYyP9CGRPpRlRK8B7PAchX6mQd8W9rgfzpbBGnB+UaTIqo73ZRf/pi6XWGxA0+3K1oXQuaWvEdjlM77+YrF6ZKf2L2cv3zUGHhjX38qSQxfIxn5XAyI7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmW1RkoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEE6C43390;
	Fri,  8 Mar 2024 02:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709864197;
	bh=RCTXtHDuyluD9s9SEqOxYt+UGzzBuaP50dQGyMet+og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NmW1RkoIaAo/DXKailQntLzNBuQZI/vWPk66K0KtxHJMJEPCTVcF6G86K6TIgLw6q
	 eQUX2HZpyZisru26ne5i92Z1WZV6Se/YB8q5eSjOcJLVEE1nFgKqkSkVQotNgJcQqW
	 Mhw/xjJkG16rSlMs6E/WhdOKEKX8ygDpcUb5yvxlh8EQg5tH+vQXS/NZfue6Mm/dvd
	 9bMa1Urdq/OunJHyEmkltjAUJoBV2prpCjffzLY82phfTiJs5A0BvhP/AIO2RKUdP4
	 YqAEW1A4Fde3PPSojVG9s/X0hSS6FdGWh4xVaxRK1++PlNMOsgbcNTHfqeVnUibpH+
	 VcOXLgys8kD7Q==
Date: Fri, 8 Mar 2024 11:16:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Calvin Owens <jcalvinowens@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Naveen N Rao
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, David S Miller <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/4] module: mm: Make module_alloc() generally
 available
Message-Id: <20240308111631.99c4b3157c3e4b1286f6eeca@kernel.org>
In-Reply-To: <a6b162aed1e6fea7f565ef9dd0204d6f2284bcce.1709676663.git.jcalvinowens@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
	<a6b162aed1e6fea7f565ef9dd0204d6f2284bcce.1709676663.git.jcalvinowens@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Calvin,

On Wed,  6 Mar 2024 12:05:08 -0800
Calvin Owens <jcalvinowens@gmail.com> wrote:

> Both BPF_JIT and KPROBES depend on CONFIG_MODULES, but only require
> module_alloc() itself, which can be easily separated into a standalone
> allocator for executable kernel memory.

Thanks for your work!
As Luis pointed, it is better to use different name because this
is not only for modules and it does not depend on CONFIG_MODULES.

> 
> Thomas Gleixner sent a patch to do that for x86 as part of a larger
> series a couple years ago:
> 
>     https://lore.kernel.org/all/20220716230953.442937066@linutronix.de/
> 
> I've simply extended that approach to the whole kernel.

I would like to see a series of patches for each architecture so that
architecture maintainers carefully check and test this feature.

What about introducing CONFIG_HAVE_EXEC_ALLOC and enable it on
each architecture? Then you can start small set of major architectures
and expand it later. 

Thank you,

> 
> Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> ---
>  arch/Kconfig                     |   2 +-
>  arch/arm/kernel/module.c         |  35 ---------
>  arch/arm/mm/Makefile             |   2 +
>  arch/arm/mm/module_alloc.c       |  40 ++++++++++
>  arch/arm64/kernel/module.c       | 127 ------------------------------
>  arch/arm64/mm/Makefile           |   1 +
>  arch/arm64/mm/module_alloc.c     | 130 +++++++++++++++++++++++++++++++
>  arch/loongarch/kernel/module.c   |   6 --
>  arch/loongarch/mm/Makefile       |   2 +
>  arch/loongarch/mm/module_alloc.c |  10 +++
>  arch/mips/kernel/module.c        |  10 ---
>  arch/mips/mm/Makefile            |   2 +
>  arch/mips/mm/module_alloc.c      |  13 ++++
>  arch/nios2/kernel/module.c       |  20 -----
>  arch/nios2/mm/Makefile           |   2 +
>  arch/nios2/mm/module_alloc.c     |  22 ++++++
>  arch/parisc/kernel/module.c      |  12 ---
>  arch/parisc/mm/Makefile          |   1 +
>  arch/parisc/mm/module_alloc.c    |  15 ++++
>  arch/powerpc/kernel/module.c     |  36 ---------
>  arch/powerpc/mm/Makefile         |   1 +
>  arch/powerpc/mm/module_alloc.c   |  41 ++++++++++
>  arch/riscv/kernel/module.c       |  11 ---
>  arch/riscv/mm/Makefile           |   1 +
>  arch/riscv/mm/module_alloc.c     |  17 ++++
>  arch/s390/kernel/module.c        |  37 ---------
>  arch/s390/mm/Makefile            |   1 +
>  arch/s390/mm/module_alloc.c      |  42 ++++++++++
>  arch/sparc/kernel/module.c       |  31 --------
>  arch/sparc/mm/Makefile           |   2 +
>  arch/sparc/mm/module_alloc.c     |  31 ++++++++
>  arch/x86/kernel/ftrace.c         |   2 +-
>  arch/x86/kernel/module.c         |  56 -------------
>  arch/x86/mm/Makefile             |   2 +
>  arch/x86/mm/module_alloc.c       |  59 ++++++++++++++
>  fs/proc/kcore.c                  |   2 +-
>  kernel/module/Kconfig            |   1 +
>  kernel/module/main.c             |  17 ----
>  mm/Kconfig                       |   3 +
>  mm/Makefile                      |   1 +
>  mm/module_alloc.c                |  21 +++++
>  mm/vmalloc.c                     |   2 +-
>  42 files changed, 467 insertions(+), 402 deletions(-)
>  create mode 100644 arch/arm/mm/module_alloc.c
>  create mode 100644 arch/arm64/mm/module_alloc.c
>  create mode 100644 arch/loongarch/mm/module_alloc.c
>  create mode 100644 arch/mips/mm/module_alloc.c
>  create mode 100644 arch/nios2/mm/module_alloc.c
>  create mode 100644 arch/parisc/mm/module_alloc.c
>  create mode 100644 arch/powerpc/mm/module_alloc.c
>  create mode 100644 arch/riscv/mm/module_alloc.c
>  create mode 100644 arch/s390/mm/module_alloc.c
>  create mode 100644 arch/sparc/mm/module_alloc.c
>  create mode 100644 arch/x86/mm/module_alloc.c
>  create mode 100644 mm/module_alloc.c
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a5af0edd3eb8..cfc24ced16dd 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1305,7 +1305,7 @@ config ARCH_HAS_STRICT_MODULE_RWX
>  
>  config STRICT_MODULE_RWX
>  	bool "Set loadable kernel module data as NX and text as RO" if ARCH_OPTIONAL_KERNEL_RWX
> -	depends on ARCH_HAS_STRICT_MODULE_RWX && MODULES
> +	depends on ARCH_HAS_STRICT_MODULE_RWX && MODULE_ALLOC
>  	default !ARCH_OPTIONAL_KERNEL_RWX || ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>  	help
>  	  If this is set, module text and rodata memory will be made read-only,
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index e74d84f58b77..1c8798732d12 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -4,15 +4,12 @@
>   *
>   *  Copyright (C) 2002 Russell King.
>   *  Modified for nommu by Hyok S. Choi
> - *
> - * Module allocation method suggested by Andi Kleen.
>   */
>  #include <linux/module.h>
>  #include <linux/moduleloader.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/elf.h>
> -#include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/string.h>
>  #include <linux/gfp.h>
> @@ -22,38 +19,6 @@
>  #include <asm/unwind.h>
>  #include <asm/opcodes.h>
>  
> -#ifdef CONFIG_XIP_KERNEL
> -/*
> - * The XIP kernel text is mapped in the module area for modules and
> - * some other stuff to work without any indirect relocations.
> - * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
> - * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
> - */
> -#undef MODULES_VADDR
> -#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
> -#endif
> -
> -#ifdef CONFIG_MMU
> -void *module_alloc(unsigned long size)
> -{
> -	gfp_t gfp_mask = GFP_KERNEL;
> -	void *p;
> -
> -	/* Silence the initial allocation */
> -	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
> -		gfp_mask |= __GFP_NOWARN;
> -
> -	p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				gfp_mask, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> -				__builtin_return_address(0));
> -	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
> -		return p;
> -	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
> -				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> -				__builtin_return_address(0));
> -}
> -#endif
> -
>  bool module_init_section(const char *name)
>  {
>  	return strstarts(name, ".init") ||
> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
> index 71b858c9b10c..a05a6701a884 100644
> --- a/arch/arm/mm/Makefile
> +++ b/arch/arm/mm/Makefile
> @@ -100,3 +100,5 @@ obj-$(CONFIG_CACHE_UNIPHIER)	+= cache-uniphier.o
>  
>  KASAN_SANITIZE_kasan_init.o	:= n
>  obj-$(CONFIG_KASAN)		+= kasan_init.o
> +
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
> diff --git a/arch/arm/mm/module_alloc.c b/arch/arm/mm/module_alloc.c
> new file mode 100644
> index 000000000000..e48be48b2b5f
> --- /dev/null
> +++ b/arch/arm/mm/module_alloc.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +
> +#ifdef CONFIG_XIP_KERNEL
> +/*
> + * The XIP kernel text is mapped in the module area for modules and
> + * some other stuff to work without any indirect relocations.
> + * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
> + * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
> + */
> +#undef MODULES_VADDR
> +#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
> +#endif
> +
> +/*
> + * Module allocation method suggested by Andi Kleen.
> + */
> +
> +#ifdef CONFIG_MMU
> +void *module_alloc(unsigned long size)
> +{
> +	gfp_t gfp_mask = GFP_KERNEL;
> +	void *p;
> +
> +	/* Silence the initial allocation */
> +	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
> +		gfp_mask |= __GFP_NOWARN;
> +
> +	p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> +				gfp_mask, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +				__builtin_return_address(0));
> +	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
> +		return p;
> +	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
> +				GFP_KERNEL, PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +				__builtin_return_address(0));
> +}
> +#endif
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index dd851297596e..78758ed818b0 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -13,143 +13,16 @@
>  #include <linux/elf.h>
>  #include <linux/ftrace.h>
>  #include <linux/gfp.h>
> -#include <linux/kasan.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/moduleloader.h>
> -#include <linux/random.h>
>  #include <linux/scs.h>
> -#include <linux/vmalloc.h>
>  
>  #include <asm/alternative.h>
>  #include <asm/insn.h>
>  #include <asm/scs.h>
>  #include <asm/sections.h>
>  
> -static u64 module_direct_base __ro_after_init = 0;
> -static u64 module_plt_base __ro_after_init = 0;
> -
> -/*
> - * Choose a random page-aligned base address for a window of 'size' bytes which
> - * entirely contains the interval [start, end - 1].
> - */
> -static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
> -{
> -	u64 max_pgoff, pgoff;
> -
> -	if ((end - start) >= size)
> -		return 0;
> -
> -	max_pgoff = (size - (end - start)) / PAGE_SIZE;
> -	pgoff = get_random_u32_inclusive(0, max_pgoff);
> -
> -	return start - pgoff * PAGE_SIZE;
> -}
> -
> -/*
> - * Modules may directly reference data and text anywhere within the kernel
> - * image and other modules. References using PREL32 relocations have a +/-2G
> - * range, and so we need to ensure that the entire kernel image and all modules
> - * fall within a 2G window such that these are always within range.
> - *
> - * Modules may directly branch to functions and code within the kernel text,
> - * and to functions and code within other modules. These branches will use
> - * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
> - * that the entire kernel text and all module text falls within a 128M window
> - * such that these are always within range. With PLTs, we can expand this to a
> - * 2G window.
> - *
> - * We chose the 128M region to surround the entire kernel image (rather than
> - * just the text) as using the same bounds for the 128M and 2G regions ensures
> - * by construction that we never select a 128M region that is not a subset of
> - * the 2G region. For very large and unusual kernel configurations this means
> - * we may fall back to PLTs where they could have been avoided, but this keeps
> - * the logic significantly simpler.
> - */
> -static int __init module_init_limits(void)
> -{
> -	u64 kernel_end = (u64)_end;
> -	u64 kernel_start = (u64)_text;
> -	u64 kernel_size = kernel_end - kernel_start;
> -
> -	/*
> -	 * The default modules region is placed immediately below the kernel
> -	 * image, and is large enough to use the full 2G relocation range.
> -	 */
> -	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
> -	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
> -
> -	if (!kaslr_enabled()) {
> -		if (kernel_size < SZ_128M)
> -			module_direct_base = kernel_end - SZ_128M;
> -		if (kernel_size < SZ_2G)
> -			module_plt_base = kernel_end - SZ_2G;
> -	} else {
> -		u64 min = kernel_start;
> -		u64 max = kernel_end;
> -
> -		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
> -			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
> -		} else {
> -			module_direct_base = random_bounding_box(SZ_128M, min, max);
> -			if (module_direct_base) {
> -				min = module_direct_base;
> -				max = module_direct_base + SZ_128M;
> -			}
> -		}
> -
> -		module_plt_base = random_bounding_box(SZ_2G, min, max);
> -	}
> -
> -	pr_info("%llu pages in range for non-PLT usage",
> -		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
> -	pr_info("%llu pages in range for PLT usage",
> -		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
> -
> -	return 0;
> -}
> -subsys_initcall(module_init_limits);
> -
> -void *module_alloc(unsigned long size)
> -{
> -	void *p = NULL;
> -
> -	/*
> -	 * Where possible, prefer to allocate within direct branch range of the
> -	 * kernel such that no PLTs are necessary.
> -	 */
> -	if (module_direct_base) {
> -		p = __vmalloc_node_range(size, MODULE_ALIGN,
> -					 module_direct_base,
> -					 module_direct_base + SZ_128M,
> -					 GFP_KERNEL | __GFP_NOWARN,
> -					 PAGE_KERNEL, 0, NUMA_NO_NODE,
> -					 __builtin_return_address(0));
> -	}
> -
> -	if (!p && module_plt_base) {
> -		p = __vmalloc_node_range(size, MODULE_ALIGN,
> -					 module_plt_base,
> -					 module_plt_base + SZ_2G,
> -					 GFP_KERNEL | __GFP_NOWARN,
> -					 PAGE_KERNEL, 0, NUMA_NO_NODE,
> -					 __builtin_return_address(0));
> -	}
> -
> -	if (!p) {
> -		pr_warn_ratelimited("%s: unable to allocate memory\n",
> -				    __func__);
> -	}
> -
> -	if (p && (kasan_alloc_module_shadow(p, size, GFP_KERNEL) < 0)) {
> -		vfree(p);
> -		return NULL;
> -	}
> -
> -	/* Memory is intended to be executable, reset the pointer tag. */
> -	return kasan_reset_tag(p);
> -}
> -
>  enum aarch64_reloc_op {
>  	RELOC_OP_NONE,
>  	RELOC_OP_ABS,
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index dbd1bc95967d..cf616635a80d 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
>  obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
>  obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
>  obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
>  KASAN_SANITIZE_physaddr.o	+= n
>  
>  obj-$(CONFIG_KASAN)		+= kasan_init.o
> diff --git a/arch/arm64/mm/module_alloc.c b/arch/arm64/mm/module_alloc.c
> new file mode 100644
> index 000000000000..302642ea9e26
> --- /dev/null
> +++ b/arch/arm64/mm/module_alloc.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/kasan.h>
> +#include <linux/random.h>
> +
> +static u64 module_direct_base __ro_after_init = 0;
> +static u64 module_plt_base __ro_after_init = 0;
> +
> +/*
> + * Choose a random page-aligned base address for a window of 'size' bytes which
> + * entirely contains the interval [start, end - 1].
> + */
> +static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
> +{
> +	u64 max_pgoff, pgoff;
> +
> +	if ((end - start) >= size)
> +		return 0;
> +
> +	max_pgoff = (size - (end - start)) / PAGE_SIZE;
> +	pgoff = get_random_u32_inclusive(0, max_pgoff);
> +
> +	return start - pgoff * PAGE_SIZE;
> +}
> +
> +/*
> + * Modules may directly reference data and text anywhere within the kernel
> + * image and other modules. References using PREL32 relocations have a +/-2G
> + * range, and so we need to ensure that the entire kernel image and all modules
> + * fall within a 2G window such that these are always within range.
> + *
> + * Modules may directly branch to functions and code within the kernel text,
> + * and to functions and code within other modules. These branches will use
> + * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
> + * that the entire kernel text and all module text falls within a 128M window
> + * such that these are always within range. With PLTs, we can expand this to a
> + * 2G window.
> + *
> + * We chose the 128M region to surround the entire kernel image (rather than
> + * just the text) as using the same bounds for the 128M and 2G regions ensures
> + * by construction that we never select a 128M region that is not a subset of
> + * the 2G region. For very large and unusual kernel configurations this means
> + * we may fall back to PLTs where they could have been avoided, but this keeps
> + * the logic significantly simpler.
> + */
> +static int __init module_init_limits(void)
> +{
> +	u64 kernel_end = (u64)_end;
> +	u64 kernel_start = (u64)_text;
> +	u64 kernel_size = kernel_end - kernel_start;
> +
> +	/*
> +	 * The default modules region is placed immediately below the kernel
> +	 * image, and is large enough to use the full 2G relocation range.
> +	 */
> +	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
> +	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
> +
> +	if (!kaslr_enabled()) {
> +		if (kernel_size < SZ_128M)
> +			module_direct_base = kernel_end - SZ_128M;
> +		if (kernel_size < SZ_2G)
> +			module_plt_base = kernel_end - SZ_2G;
> +	} else {
> +		u64 min = kernel_start;
> +		u64 max = kernel_end;
> +
> +		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
> +			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
> +		} else {
> +			module_direct_base = random_bounding_box(SZ_128M, min, max);
> +			if (module_direct_base) {
> +				min = module_direct_base;
> +				max = module_direct_base + SZ_128M;
> +			}
> +		}
> +
> +		module_plt_base = random_bounding_box(SZ_2G, min, max);
> +	}
> +
> +	pr_info("%llu pages in range for non-PLT usage",
> +		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
> +	pr_info("%llu pages in range for PLT usage",
> +		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
> +
> +	return 0;
> +}
> +subsys_initcall(module_init_limits);
> +
> +void *module_alloc(unsigned long size)
> +{
> +	void *p = NULL;
> +
> +	/*
> +	 * Where possible, prefer to allocate within direct branch range of the
> +	 * kernel such that no PLTs are necessary.
> +	 */
> +	if (module_direct_base) {
> +		p = __vmalloc_node_range(size, MODULE_ALIGN,
> +					 module_direct_base,
> +					 module_direct_base + SZ_128M,
> +					 GFP_KERNEL | __GFP_NOWARN,
> +					 PAGE_KERNEL, 0, NUMA_NO_NODE,
> +					 __builtin_return_address(0));
> +	}
> +
> +	if (!p && module_plt_base) {
> +		p = __vmalloc_node_range(size, MODULE_ALIGN,
> +					 module_plt_base,
> +					 module_plt_base + SZ_2G,
> +					 GFP_KERNEL | __GFP_NOWARN,
> +					 PAGE_KERNEL, 0, NUMA_NO_NODE,
> +					 __builtin_return_address(0));
> +	}
> +
> +	if (!p) {
> +		pr_warn_ratelimited("%s: unable to allocate memory\n",
> +				    __func__);
> +	}
> +
> +	if (p && (kasan_alloc_module_shadow(p, size, GFP_KERNEL) < 0)) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	/* Memory is intended to be executable, reset the pointer tag. */
> +	return kasan_reset_tag(p);
> +}
> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> index b13b2858fe39..7f03166513b3 100644
> --- a/arch/loongarch/kernel/module.c
> +++ b/arch/loongarch/kernel/module.c
> @@ -489,12 +489,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>  	return 0;
>  }
>  
> -void *module_alloc(unsigned long size)
> -{
> -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
> -}
> -
>  static void module_init_ftrace_plt(const Elf_Ehdr *hdr,
>  				   const Elf_Shdr *sechdrs, struct module *mod)
>  {
> diff --git a/arch/loongarch/mm/Makefile b/arch/loongarch/mm/Makefile
> index e4d1e581dbae..3966fc6118f1 100644
> --- a/arch/loongarch/mm/Makefile
> +++ b/arch/loongarch/mm/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>  obj-$(CONFIG_KASAN)		+= kasan_init.o
>  
>  KASAN_SANITIZE_kasan_init.o     := n
> +
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
> diff --git a/arch/loongarch/mm/module_alloc.c b/arch/loongarch/mm/module_alloc.c
> new file mode 100644
> index 000000000000..24b0cb3a2088
> --- /dev/null
> +++ b/arch/loongarch/mm/module_alloc.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +
> +void *module_alloc(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> +			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
> +}
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index 7b2fbaa9cac5..ba0f62d8eff5 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -13,7 +13,6 @@
>  #include <linux/elf.h>
>  #include <linux/mm.h>
>  #include <linux/numa.h>
> -#include <linux/vmalloc.h>
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/string.h>
> @@ -31,15 +30,6 @@ struct mips_hi16 {
>  static LIST_HEAD(dbe_list);
>  static DEFINE_SPINLOCK(dbe_lock);
>  
> -#ifdef MODULE_START
> -void *module_alloc(unsigned long size)
> -{
> -	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
> -				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				__builtin_return_address(0));
> -}
> -#endif
> -
>  static void apply_r_mips_32(u32 *location, u32 base, Elf_Addr v)
>  {
>  	*location = base + v;
> diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
> index 304692391519..b9cfe37e41e4 100644
> --- a/arch/mips/mm/Makefile
> +++ b/arch/mips/mm/Makefile
> @@ -45,3 +45,5 @@ obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
>  obj-$(CONFIG_SCACHE_DEBUGFS)	+= sc-debugfs.o
>  
>  obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
> +
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
> diff --git a/arch/mips/mm/module_alloc.c b/arch/mips/mm/module_alloc.c
> new file mode 100644
> index 000000000000..fcdbdece42f3
> --- /dev/null
> +++ b/arch/mips/mm/module_alloc.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +
> +#ifdef MODULE_START
> +void *module_alloc(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
> +				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				__builtin_return_address(0));
> +}
> +#endif
> diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
> index 76e0a42d6e36..f4483243578d 100644
> --- a/arch/nios2/kernel/module.c
> +++ b/arch/nios2/kernel/module.c
> @@ -13,7 +13,6 @@
>  #include <linux/moduleloader.h>
>  #include <linux/elf.h>
>  #include <linux/mm.h>
> -#include <linux/vmalloc.h>
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/string.h>
> @@ -21,25 +20,6 @@
>  
>  #include <asm/cacheflush.h>
>  
> -/*
> - * Modules should NOT be allocated with kmalloc for (obvious) reasons.
> - * But we do it for now to avoid relocation issues. CALL26/PCREL26 cannot reach
> - * from 0x80000000 (vmalloc area) to 0xc00000000 (kernel) (kmalloc returns
> - * addresses in 0xc0000000)
> - */
> -void *module_alloc(unsigned long size)
> -{
> -	if (size == 0)
> -		return NULL;
> -	return kmalloc(size, GFP_KERNEL);
> -}
> -
> -/* Free memory returned from module_alloc */
> -void module_memfree(void *module_region)
> -{
> -	kfree(module_region);
> -}
> -
>  int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
>  			unsigned int symindex, unsigned int relsec,
>  			struct module *mod)
> diff --git a/arch/nios2/mm/Makefile b/arch/nios2/mm/Makefile
> index 9d37fafd1dd1..facbb3e60013 100644
> --- a/arch/nios2/mm/Makefile
> +++ b/arch/nios2/mm/Makefile
> @@ -13,3 +13,5 @@ obj-y	+= mmu_context.o
>  obj-y	+= pgtable.o
>  obj-y	+= tlb.o
>  obj-y	+= uaccess.o
> +
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
> diff --git a/arch/nios2/mm/module_alloc.c b/arch/nios2/mm/module_alloc.c
> new file mode 100644
> index 000000000000..92c7c32ef8b3
> --- /dev/null
> +++ b/arch/nios2/mm/module_alloc.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/moduleloader.h>
> +#include <linux/slab.h>
> +
> +/*
> + * Modules should NOT be allocated with kmalloc for (obvious) reasons.
> + * But we do it for now to avoid relocation issues. CALL26/PCREL26 cannot reach
> + * from 0x80000000 (vmalloc area) to 0xc00000000 (kernel) (kmalloc returns
> + * addresses in 0xc0000000)
> + */
> +void *module_alloc(unsigned long size)
> +{
> +	if (size == 0)
> +		return NULL;
> +	return kmalloc(size, GFP_KERNEL);
> +}
> +
> +/* Free memory returned from module_alloc */
> +void module_memfree(void *module_region)
> +{
> +	kfree(module_region);
> +}
> diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
> index d214bbe3c2af..4e5d991b2b65 100644
> --- a/arch/parisc/kernel/module.c
> +++ b/arch/parisc/kernel/module.c
> @@ -41,7 +41,6 @@
>  
>  #include <linux/moduleloader.h>
>  #include <linux/elf.h>
> -#include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/ftrace.h>
>  #include <linux/string.h>
> @@ -173,17 +172,6 @@ static inline int reassemble_22(int as22)
>  		((as22 & 0x0003ff) << 3));
>  }
>  
> -void *module_alloc(unsigned long size)
> -{
> -	/* using RWX means less protection for modules, but it's
> -	 * easier than trying to map the text, data, init_text and
> -	 * init_data correctly */
> -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -				    GFP_KERNEL,
> -				    PAGE_KERNEL_RWX, 0, NUMA_NO_NODE,
> -				    __builtin_return_address(0));
> -}
> -
>  #ifndef CONFIG_64BIT
>  static inline unsigned long count_gots(const Elf_Rela *rela, unsigned long n)
>  {
> diff --git a/arch/parisc/mm/Makefile b/arch/parisc/mm/Makefile
> index ffdb5c0a8cc6..95a6d4469785 100644
> --- a/arch/parisc/mm/Makefile
> +++ b/arch/parisc/mm/Makefile
> @@ -5,3 +5,4 @@
>  
>  obj-y	 := init.o fault.o ioremap.o fixmap.o
>  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> +obj-$(CONFIG_MODULE_ALLOC) += module_alloc.o
> diff --git a/arch/parisc/mm/module_alloc.c b/arch/parisc/mm/module_alloc.c
> new file mode 100644
> index 000000000000..5ad9bfc3ffab
> --- /dev/null
> +++ b/arch/parisc/mm/module_alloc.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +
> +void *module_alloc(unsigned long size)
> +{
> +	/* using RWX means less protection for modules, but it's
> +	 * easier than trying to map the text, data, init_text and
> +	 * init_data correctly */
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +				    GFP_KERNEL,
> +				    PAGE_KERNEL_RWX, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +}
> diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
> index f6d6ae0a1692..b5fe9c61e527 100644
> --- a/arch/powerpc/kernel/module.c
> +++ b/arch/powerpc/kernel/module.c
> @@ -89,39 +89,3 @@ int module_finalize(const Elf_Ehdr *hdr,
>  	return 0;
>  }
>  
> -static __always_inline void *
> -__module_alloc(unsigned long size, unsigned long start, unsigned long end, bool nowarn)
> -{
> -	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
> -	gfp_t gfp = GFP_KERNEL | (nowarn ? __GFP_NOWARN : 0);
> -
> -	/*
> -	 * Don't do huge page allocations for modules yet until more testing
> -	 * is done. STRICT_MODULE_RWX may require extra work to support this
> -	 * too.
> -	 */
> -	return __vmalloc_node_range(size, 1, start, end, gfp, prot,
> -				    VM_FLUSH_RESET_PERMS,
> -				    NUMA_NO_NODE, __builtin_return_address(0));
> -}
> -
> -void *module_alloc(unsigned long size)
> -{
> -#ifdef MODULES_VADDR
> -	unsigned long limit = (unsigned long)_etext - SZ_32M;
> -	void *ptr = NULL;
> -
> -	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
> -
> -	/* First try within 32M limit from _etext to avoid branch trampolines */
> -	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit)
> -		ptr = __module_alloc(size, limit, MODULES_END, true);
> -
> -	if (!ptr)
> -		ptr = __module_alloc(size, MODULES_VADDR, MODULES_END, false);
> -
> -	return ptr;
> -#else
> -	return __module_alloc(size, VMALLOC_START, VMALLOC_END, false);
> -#endif
> -}
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 503a6e249940..4572273a838f 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
>  obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
>  obj-$(CONFIG_PTDUMP_CORE)	+= ptdump/
>  obj-$(CONFIG_KASAN)		+= kasan/
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
> diff --git a/arch/powerpc/mm/module_alloc.c b/arch/powerpc/mm/module_alloc.c
> new file mode 100644
> index 000000000000..818e5cd8fbc6
> --- /dev/null
> +++ b/arch/powerpc/mm/module_alloc.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +
> +static __always_inline void *
> +__module_alloc(unsigned long size, unsigned long start, unsigned long end, bool nowarn)
> +{
> +	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
> +	gfp_t gfp = GFP_KERNEL | (nowarn ? __GFP_NOWARN : 0);
> +
> +	/*
> +	 * Don't do huge page allocations for modules yet until more testing
> +	 * is done. STRICT_MODULE_RWX may require extra work to support this
> +	 * too.
> +	 */
> +	return __vmalloc_node_range(size, 1, start, end, gfp, prot,
> +				    VM_FLUSH_RESET_PERMS,
> +				    NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +
> +void *module_alloc(unsigned long size)
> +{
> +#ifdef MODULES_VADDR
> +	unsigned long limit = (unsigned long)_etext - SZ_32M;
> +	void *ptr = NULL;
> +
> +	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
> +
> +	/* First try within 32M limit from _etext to avoid branch trampolines */
> +	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit)
> +		ptr = __module_alloc(size, limit, MODULES_END, true);
> +
> +	if (!ptr)
> +		ptr = __module_alloc(size, MODULES_VADDR, MODULES_END, false);
> +
> +	return ptr;
> +#else
> +	return __module_alloc(size, VMALLOC_START, VMALLOC_END, false);
> +#endif
> +}
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 5e5a82644451..53d7005fdbdb 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -11,7 +11,6 @@
>  #include <linux/kernel.h>
>  #include <linux/log2.h>
>  #include <linux/moduleloader.h>
> -#include <linux/vmalloc.h>
>  #include <linux/sizes.h>
>  #include <linux/pgtable.h>
>  #include <asm/alternative.h>
> @@ -905,16 +904,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>  	return 0;
>  }
>  
> -#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> -void *module_alloc(unsigned long size)
> -{
> -	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> -				    MODULES_END, GFP_KERNEL,
> -				    PAGE_KERNEL, VM_FLUSH_RESET_PERMS,
> -				    NUMA_NO_NODE,
> -				    __builtin_return_address(0));
> -}
> -#endif
>  
>  int module_finalize(const Elf_Ehdr *hdr,
>  		    const Elf_Shdr *sechdrs,
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 2c869f8026a8..fba8e3595459 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -36,3 +36,4 @@ endif
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
>  obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
>  obj-$(CONFIG_RISCV_NONSTANDARD_CACHE_OPS) += cache-ops.o
> +obj-$(CONFIG_MODULE_ALLOC) += module_alloc.o
> diff --git a/arch/riscv/mm/module_alloc.c b/arch/riscv/mm/module_alloc.c
> new file mode 100644
> index 000000000000..2c1fb95a57e2
> --- /dev/null
> +++ b/arch/riscv/mm/module_alloc.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/pgtable.h>
> +#include <asm/alternative.h>
> +#include <asm/sections.h>
> +
> +#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> +void *module_alloc(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> +				    MODULES_END, GFP_KERNEL,
> +				    PAGE_KERNEL, VM_FLUSH_RESET_PERMS,
> +				    NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +}
> +#endif
> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index 42215f9404af..ef8a7539bb0b 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -36,43 +36,6 @@
>  
>  #define PLT_ENTRY_SIZE 22
>  
> -static unsigned long get_module_load_offset(void)
> -{
> -	static DEFINE_MUTEX(module_kaslr_mutex);
> -	static unsigned long module_load_offset;
> -
> -	if (!kaslr_enabled())
> -		return 0;
> -	/*
> -	 * Calculate the module_load_offset the first time this code
> -	 * is called. Once calculated it stays the same until reboot.
> -	 */
> -	mutex_lock(&module_kaslr_mutex);
> -	if (!module_load_offset)
> -		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
> -	mutex_unlock(&module_kaslr_mutex);
> -	return module_load_offset;
> -}
> -
> -void *module_alloc(unsigned long size)
> -{
> -	gfp_t gfp_mask = GFP_KERNEL;
> -	void *p;
> -
> -	if (PAGE_ALIGN(size) > MODULES_LEN)
> -		return NULL;
> -	p = __vmalloc_node_range(size, MODULE_ALIGN,
> -				 MODULES_VADDR + get_module_load_offset(),
> -				 MODULES_END, gfp_mask, PAGE_KERNEL,
> -				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
> -				 NUMA_NO_NODE, __builtin_return_address(0));
> -	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
> -		vfree(p);
> -		return NULL;
> -	}
> -	return p;
> -}
> -
>  #ifdef CONFIG_FUNCTION_TRACER
>  void module_arch_cleanup(struct module *mod)
>  {
> diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
> index 352ff520fd94..4f44c4096c6d 100644
> --- a/arch/s390/mm/Makefile
> +++ b/arch/s390/mm/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE)	+= dump_pagetables.o
>  obj-$(CONFIG_PGSTE)		+= gmap.o
>  obj-$(CONFIG_PFAULT)		+= pfault.o
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
> diff --git a/arch/s390/mm/module_alloc.c b/arch/s390/mm/module_alloc.c
> new file mode 100644
> index 000000000000..88eadce4bc68
> --- /dev/null
> +++ b/arch/s390/mm/module_alloc.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/kasan.h>
> +
> +static unsigned long get_module_load_offset(void)
> +{
> +	static DEFINE_MUTEX(module_kaslr_mutex);
> +	static unsigned long module_load_offset;
> +
> +	if (!kaslr_enabled())
> +		return 0;
> +	/*
> +	 * Calculate the module_load_offset the first time this code
> +	 * is called. Once calculated it stays the same until reboot.
> +	 */
> +	mutex_lock(&module_kaslr_mutex);
> +	if (!module_load_offset)
> +		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
> +	mutex_unlock(&module_kaslr_mutex);
> +	return module_load_offset;
> +}
> +
> +void *module_alloc(unsigned long size)
> +{
> +	gfp_t gfp_mask = GFP_KERNEL;
> +	void *p;
> +
> +	if (PAGE_ALIGN(size) > MODULES_LEN)
> +		return NULL;
> +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> +				 MODULES_VADDR + get_module_load_offset(),
> +				 MODULES_END, gfp_mask, PAGE_KERNEL,
> +				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
> +				 NUMA_NO_NODE, __builtin_return_address(0));
> +	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
> +		vfree(p);
> +		return NULL;
> +	}
> +	return p;
> +}
> diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> index 66c45a2764bc..0611a41cd586 100644
> --- a/arch/sparc/kernel/module.c
> +++ b/arch/sparc/kernel/module.c
> @@ -8,7 +8,6 @@
>  #include <linux/moduleloader.h>
>  #include <linux/kernel.h>
>  #include <linux/elf.h>
> -#include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/gfp.h>
>  #include <linux/string.h>
> @@ -21,36 +20,6 @@
>  
>  #include "entry.h"
>  
> -#ifdef CONFIG_SPARC64
> -
> -#include <linux/jump_label.h>
> -
> -static void *module_map(unsigned long size)
> -{
> -	if (PAGE_ALIGN(size) > MODULES_LEN)
> -		return NULL;
> -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				__builtin_return_address(0));
> -}
> -#else
> -static void *module_map(unsigned long size)
> -{
> -	return vmalloc(size);
> -}
> -#endif /* CONFIG_SPARC64 */
> -
> -void *module_alloc(unsigned long size)
> -{
> -	void *ret;
> -
> -	ret = module_map(size);
> -	if (ret)
> -		memset(ret, 0, size);
> -
> -	return ret;
> -}
> -
>  /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
>  int module_frob_arch_sections(Elf_Ehdr *hdr,
>  			      Elf_Shdr *sechdrs,
> diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
> index 809d993f6d88..a8e9ba46679a 100644
> --- a/arch/sparc/mm/Makefile
> +++ b/arch/sparc/mm/Makefile
> @@ -14,3 +14,5 @@ obj-$(CONFIG_SPARC32)   += leon_mm.o
>  
>  # Only used by sparc64
>  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> +
> +obj-$(CONFIG_MODULE_ALLOC) += module_alloc.o
> diff --git a/arch/sparc/mm/module_alloc.c b/arch/sparc/mm/module_alloc.c
> new file mode 100644
> index 000000000000..14aef0f75650
> --- /dev/null
> +++ b/arch/sparc/mm/module_alloc.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +
> +#ifdef CONFIG_SPARC64
> +static void *module_map(unsigned long size)
> +{
> +	if (PAGE_ALIGN(size) > MODULES_LEN)
> +		return NULL;
> +	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> +				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				__builtin_return_address(0));
> +}
> +#else
> +static void *module_map(unsigned long size)
> +{
> +	return vmalloc(size);
> +}
> +#endif /* CONFIG_SPARC64 */
> +
> +void *module_alloc(unsigned long size)
> +{
> +	void *ret;
> +
> +	ret = module_map(size);
> +	if (ret)
> +		memset(ret, 0, size);
> +
> +	return ret;
> +}
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 12df54ff0e81..99f242e11f88 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -260,7 +260,7 @@ void arch_ftrace_update_code(int command)
>  /* Currently only x86_64 supports dynamic trampolines */
>  #ifdef CONFIG_X86_64
>  
> -#ifdef CONFIG_MODULES
> +#if IS_ENABLED(CONFIG_MODULE_ALLOC)
>  #include <linux/moduleloader.h>
>  /* Module allocation simplifies allocating memory for code */
>  static inline void *alloc_tramp(unsigned long size)
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index e18914c0e38a..ad7e3968ee8f 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -8,21 +8,14 @@
>  
>  #include <linux/moduleloader.h>
>  #include <linux/elf.h>
> -#include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/string.h>
>  #include <linux/kernel.h>
> -#include <linux/kasan.h>
>  #include <linux/bug.h>
> -#include <linux/mm.h>
> -#include <linux/gfp.h>
>  #include <linux/jump_label.h>
> -#include <linux/random.h>
>  #include <linux/memory.h>
>  
>  #include <asm/text-patching.h>
> -#include <asm/page.h>
> -#include <asm/setup.h>
>  #include <asm/unwind.h>
>  
>  #if 0
> @@ -36,56 +29,7 @@ do {							\
>  } while (0)
>  #endif
>  
> -#ifdef CONFIG_RANDOMIZE_BASE
> -static unsigned long module_load_offset;
>  
> -/* Mutex protects the module_load_offset. */
> -static DEFINE_MUTEX(module_kaslr_mutex);
> -
> -static unsigned long int get_module_load_offset(void)
> -{
> -	if (kaslr_enabled()) {
> -		mutex_lock(&module_kaslr_mutex);
> -		/*
> -		 * Calculate the module_load_offset the first time this
> -		 * code is called. Once calculated it stays the same until
> -		 * reboot.
> -		 */
> -		if (module_load_offset == 0)
> -			module_load_offset =
> -				get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
> -		mutex_unlock(&module_kaslr_mutex);
> -	}
> -	return module_load_offset;
> -}
> -#else
> -static unsigned long int get_module_load_offset(void)
> -{
> -	return 0;
> -}
> -#endif
> -
> -void *module_alloc(unsigned long size)
> -{
> -	gfp_t gfp_mask = GFP_KERNEL;
> -	void *p;
> -
> -	if (PAGE_ALIGN(size) > MODULES_LEN)
> -		return NULL;
> -
> -	p = __vmalloc_node_range(size, MODULE_ALIGN,
> -				 MODULES_VADDR + get_module_load_offset(),
> -				 MODULES_END, gfp_mask, PAGE_KERNEL,
> -				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
> -				 NUMA_NO_NODE, __builtin_return_address(0));
> -
> -	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
> -		vfree(p);
> -		return NULL;
> -	}
> -
> -	return p;
> -}
>  
>  #ifdef CONFIG_X86_32
>  int apply_relocate(Elf32_Shdr *sechdrs,
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index c80febc44cd2..b9e42770a002 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -67,3 +67,5 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
>  
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
>  obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
> +
> +obj-$(CONFIG_MODULE_ALLOC)	+= module_alloc.o
> diff --git a/arch/x86/mm/module_alloc.c b/arch/x86/mm/module_alloc.c
> new file mode 100644
> index 000000000000..00391c15e1eb
> --- /dev/null
> +++ b/arch/x86/mm/module_alloc.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/kasan.h>
> +#include <linux/random.h>
> +#include <linux/mutex.h>
> +#include <asm/setup.h>
> +
> +#ifdef CONFIG_RANDOMIZE_BASE
> +static unsigned long module_load_offset;
> +
> +/* Mutex protects the module_load_offset. */
> +static DEFINE_MUTEX(module_kaslr_mutex);
> +
> +static unsigned long int get_module_load_offset(void)
> +{
> +	if (kaslr_enabled()) {
> +		mutex_lock(&module_kaslr_mutex);
> +		/*
> +		 * Calculate the module_load_offset the first time this
> +		 * code is called. Once calculated it stays the same until
> +		 * reboot.
> +		 */
> +		if (module_load_offset == 0)
> +			module_load_offset =
> +				get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
> +		mutex_unlock(&module_kaslr_mutex);
> +	}
> +	return module_load_offset;
> +}
> +#else
> +static unsigned long int get_module_load_offset(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +void *module_alloc(unsigned long size)
> +{
> +	gfp_t gfp_mask = GFP_KERNEL;
> +	void *p;
> +
> +	if (PAGE_ALIGN(size) > MODULES_LEN)
> +		return NULL;
> +
> +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> +				 MODULES_VADDR + get_module_load_offset(),
> +				 MODULES_END, gfp_mask, PAGE_KERNEL,
> +				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
> +				 NUMA_NO_NODE, __builtin_return_address(0));
> +
> +	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
> +		vfree(p);
> +		return NULL;
> +	}
> +
> +	return p;
> +}
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 6422e569b080..b8f4dcf92a89 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -668,7 +668,7 @@ static void __init proc_kcore_text_init(void)
>  }
>  #endif
>  
> -#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> +#if defined(CONFIG_MODULE_ALLOC) && defined(MODULES_VADDR)
>  /*
>   * MODULES_VADDR has no intersection with VMALLOC_ADDR.
>   */
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 0ea1b2970a23..a49460022350 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig MODULES
>  	bool "Enable loadable module support"
> +	select MODULE_ALLOC
>  	modules
>  	help
>  	  Kernel modules are small pieces of compiled code which can
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 36681911c05a..085bc6e75b3f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1179,16 +1179,6 @@ resolve_symbol_wait(struct module *mod,
>  	return ksym;
>  }
>  
> -void __weak module_memfree(void *module_region)
> -{
> -	/*
> -	 * This memory may be RO, and freeing RO memory in an interrupt is not
> -	 * supported by vmalloc.
> -	 */
> -	WARN_ON(in_interrupt());
> -	vfree(module_region);
> -}
> -
>  void __weak module_arch_cleanup(struct module *mod)
>  {
>  }
> @@ -1610,13 +1600,6 @@ static void free_modinfo(struct module *mod)
>  	}
>  }
>  
> -void * __weak module_alloc(unsigned long size)
> -{
> -	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> -			NUMA_NO_NODE, __builtin_return_address(0));
> -}
> -
>  bool __weak module_init_section(const char *name)
>  {
>  	return strstarts(name, ".init");
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ffc3a2ba3a8c..92bfb5ae2e95 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1261,6 +1261,9 @@ config LOCK_MM_AND_FIND_VMA
>  config IOMMU_MM_DATA
>  	bool
>  
> +config MODULE_ALLOC
> +	def_bool n
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index e4b5b75aaec9..731bd2c20ceb 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -134,3 +134,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
> +obj-$(CONFIG_MODULE_ALLOC) += module_alloc.o
> diff --git a/mm/module_alloc.c b/mm/module_alloc.c
> new file mode 100644
> index 000000000000..821af49e9a7c
> --- /dev/null
> +++ b/mm/module_alloc.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +
> +void * __weak module_alloc(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> +			NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +
> +void __weak module_memfree(void *module_region)
> +{
> +	/*
> +	 * This memory may be RO, and freeing RO memory in an interrupt is not
> +	 * supported by vmalloc.
> +	 */
> +	WARN_ON(in_interrupt());
> +	vfree(module_region);
> +}
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c17..b7d963fe0707 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -642,7 +642,7 @@ int is_vmalloc_or_module_addr(const void *x)
>  	 * and fall back on vmalloc() if that fails. Others
>  	 * just put it in the vmalloc space.
>  	 */
> -#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> +#if defined(CONFIG_MODULE_ALLOC) && defined(MODULES_VADDR)
>  	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>  	if (addr >= MODULES_VADDR && addr < MODULES_END)
>  		return 1;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

