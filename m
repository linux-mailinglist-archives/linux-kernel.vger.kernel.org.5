Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2467F7A67E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjISPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjISPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:21:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D2BC;
        Tue, 19 Sep 2023 08:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24372C433C9;
        Tue, 19 Sep 2023 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695136874;
        bh=5+eSDx+mZRsMsyCq+4PBIEWQ8iPMfyPMVGTHP6PbvEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqSx+biH81Tv5o9Xl8GFtCBbercD8l10L39nrHXjaKNYYyxwZrST7GvuiKCLOvj5f
         VPZWqHBqOH6vNmnH7cuMxwSVFRk3j0+7ymodo1T9SlKzzMUXIOzeraLoOOECxP72LV
         MvZKz6FueB4/rpeDfejKf14a2ocVjbC+unIXomQXdnNE6fwAEAUuQC5kHbDQQwN9w/
         1mxQZ8L89mcGxY4iEVlobfPA0yy7QtCoHvYIvKRLKsvWGJYq88joQ3JPO7XmzYjt6x
         z8N3UargQA8jiOX4GJ/1NiLKzxuMzuogwkM1j33jfEuDdytXJgJZ2bwbpA6gAOmtlD
         rSSuKoyRJAqog==
Date:   Tue, 19 Sep 2023 18:20:31 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot warning after merge of the mm tree
Message-ID: <20230919152031.GF3303@kernel.org>
References: <20230919162518.180fd9f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20230919162518.180fd9f3@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 19, 2023 at 04:25:18PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next qemu opbbt test (powerpc
> pseries_le_defconfig) produced this warning:
> 
> vmap allocation for size 131072 failed: use vmalloc=<size> to increase size
> swapper/0: vmalloc error: size 65536, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-06327-g52a3bc18f36c #1
> Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,HEAD pSeries
> Call Trace:
> [c00000000478f780] [c000000001174678] dump_stack_lvl+0x6c/0x9c (unreliable)
> [c00000000478f7b0] [c0000000004b7450] warn_alloc+0x150/0x210
> [c00000000478f850] [c0000000004abcd0] __vmalloc_node_range+0x4c0/0xab0
> [c00000000478f9d0] [c0000000005534dc] execmem_alloc+0xec/0x180
> [c00000000478fa70] [c0000000002c1ef8] alloc_insn_page+0x28/0x80
> [c00000000478fa90] [c0000000002c5624] __get_insn_slot+0x1c4/0x2a0
> [c00000000478fad0] [c00000000005cd68] arch_prepare_kprobe+0x168/0x2e0
> [c00000000478fb50] [c0000000002c69c0] register_kprobe+0x550/0x880
> [c00000000478fbc0] [c000000002012968] arch_init_kprobes+0x28/0x3c
> [c00000000478fbe0] [c000000002038a50] init_kprobes+0x118/0x1a0
> [c00000000478fc50] [c000000000010bc0] do_one_initcall+0x80/0x300
> [c00000000478fd20] [c000000002004848] kernel_init_freeable+0x1dc/0x3b4
> [c00000000478fdf0] [c0000000000111b0] kernel_init+0x30/0x1a0
> [c00000000478fe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
> --- interrupt: 0 at 0x0
> NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
> REGS: c00000000478fe80 TRAP: 0000   Not tainted  (6.6.0-rc2-06327-g52a3bc18f36c)
> MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
> CFAR: 0000000000000000 IRQMASK: 0 
> GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> NIP [0000000000000000] 0x0
> LR [0000000000000000] 0x0
> --- interrupt: 0
> Mem-Info:
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:0 dirty:0 writeback:0
>  slab_reclaimable:4 slab_unreclaimable:94
>  mapped:0 shmem:0 pagetables:1
>  sec_pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:31798 free_pcp:10 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:272kB pagetables:64kB sec_pagetables:0kB all_unreclaimable? no
> Node 0 Normal free:2035072kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:2097152kB managed:2043904kB mlocked:0kB bounce:0kB free_pcp:640kB local_pcp:640kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> Node 0 Normal: 4*64kB (M) 5*128kB (UM) 6*256kB (ME) 6*512kB (UME) 6*1024kB (UME) 6*2048kB (UME) 5*4096kB (UME) 5*8192kB (ME) 119*16384kB (M) = 2035072kB
> 0 total pagecache pages
> 0 pages in swap cache
> Free swap  = 0kB
> Total swap = 0kB
> 32768 pages RAM
> 0 pages HighMem/MovableOnly
> 832 pages reserved
> 0 pages cma reserved
> 
> Introduced by commit (via bisection)
> 
>   2d278773305d ("powerpc: extend execmem_params for kprobes allocations")

This fixes this commit:

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index bf2c62aef628..e4ecee1c87ef 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -138,8 +138,8 @@ struct execmem_params __init *execmem_arch_params(void)
 
 	range->pgprot = prot;
 
-	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
+	execmem_params.ranges[EXECMEM_KPROBES].start = range->start;
+	execmem_params.ranges[EXECMEM_KPROBES].end = range->end;
 
 	if (strict_module_rwx_enabled())
 		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
 
> I have reverted the following commits for today.
> 
>   be2e02ac422f ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
>   68f60fd96f9d ("kprobes: remove dependency on CONFIG_MODULES")
>   2177ac117a8e ("x86/ftrace: enable dynamic ftrace without CONFIG_MODULES")
>   3300c3af2009 ("arch: make execmem setup available regardless of CONFIG_MODULES")

And attached is the new version of "arch: make execmem setup available
regardless of CONFIG_MODULES" patch with resolved conflict.

Andrew, please let me know if you'd like me to send these differently. I'd
prefer to wait with v4 to see if there are other fallouts though.

>   2d278773305d ("powerpc: extend execmem_params for kprobes allocations")
> 
> -- 
> Cheers,
> Stephen Rothwell

-- 
Sincerely yours,
Mike.

--zYM0uCDKw75PZbzx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-arch-make-execmem-setup-available-regardless-of-CONF.patch"

From 6927a520f0153ef44824befbd57979f3b07d12b0 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (IBM)" <rppt@kernel.org>
Date: Wed, 31 May 2023 14:58:24 +0300
Subject: [PATCH] arch: make execmem setup available regardless of
 CONFIG_MODULES

execmem does not depend on modules, on the contrary modules use
execmem.

To make execmem available when CONFIG_MODULES=n, for instance for
kprobes, split execmem_params initialization out from
arch/kernel/module.c and compile it when CONFIG_EXECMEM=y

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/kernel/module.c       |  38 ----------
 arch/arm/mm/init.c             |  38 ++++++++++
 arch/arm64/kernel/module.c     | 130 --------------------------------
 arch/arm64/mm/init.c           | 132 +++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/module.c |  18 -----
 arch/loongarch/mm/init.c       |  20 +++++
 arch/mips/kernel/module.c      |  19 -----
 arch/mips/mm/init.c            |  20 +++++
 arch/parisc/kernel/module.c    |  17 -----
 arch/parisc/mm/init.c          |  22 +++++-
 arch/powerpc/kernel/module.c   |  60 ---------------
 arch/powerpc/mm/mem.c          |  62 ++++++++++++++++
 arch/riscv/kernel/module.c     |  39 ----------
 arch/riscv/mm/init.c           |  39 ++++++++++
 arch/s390/kernel/module.c      |  25 -------
 arch/s390/mm/init.c            |  28 +++++++
 arch/sparc/kernel/module.c     |  23 ------
 arch/sparc/mm/Makefile         |   2 +
 arch/sparc/mm/execmem.c        |  25 +++++++
 arch/x86/kernel/module.c       |  27 -------
 arch/x86/mm/init.c             |  29 ++++++++
 21 files changed, 416 insertions(+), 397 deletions(-)
 create mode 100644 arch/sparc/mm/execmem.c

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 2c7651a2d84c..3282f304f6b1 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -16,50 +16,12 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/gfp.h>
-#include <linux/execmem.h>
 
 #include <asm/sections.h>
 #include <asm/smp_plat.h>
 #include <asm/unwind.h>
 #include <asm/opcodes.h>
 
-#ifdef CONFIG_XIP_KERNEL
-/*
- * The XIP kernel text is mapped in the module area for modules and
- * some other stuff to work without any indirect relocations.
- * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
- * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
- */
-#undef MODULES_VADDR
-#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
-#endif
-
-#ifdef CONFIG_MMU
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
-
-	r->pgprot = PAGE_KERNEL_EXEC;
-
-	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS)) {
-		r->fallback_start = VMALLOC_START;
-		r->fallback_end = VMALLOC_END;
-	}
-
-	return &execmem_params;
-}
-#endif
-
 bool module_init_section(const char *name)
 {
 	return strstarts(name, ".init") ||
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a42e4cd11db2..c0b536e398b4 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/sizes.h>
 #include <linux/stop_machine.h>
 #include <linux/swiotlb.h>
+#include <linux/execmem.h>
 
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
@@ -486,3 +487,40 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
 #endif
+
+#ifdef CONFIG_XIP_KERNEL
+/*
+ * The XIP kernel text is mapped in the module area for modules and
+ * some other stuff to work without any indirect relocations.
+ * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
+ * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
+ */
+#undef MODULES_VADDR
+#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
+#endif
+
+#if defined(CONFIG_MMU) && defined(CONFIG_EXECMEM)
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
+
+	r->pgprot = PAGE_KERNEL_EXEC;
+
+	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS)) {
+		r->fallback_start = VMALLOC_START;
+		r->fallback_end = VMALLOC_END;
+	}
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index d27db168d2a2..eb1505128b75 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -20,142 +20,12 @@
 #include <linux/random.h>
 #include <linux/scs.h>
 #include <linux/vmalloc.h>
-#include <linux/execmem.h>
 
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
 
-static u64 module_direct_base __ro_after_init = 0;
-static u64 module_plt_base __ro_after_init = 0;
-
-/*
- * Choose a random page-aligned base address for a window of 'size' bytes which
- * entirely contains the interval [start, end - 1].
- */
-static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
-{
-	u64 max_pgoff, pgoff;
-
-	if ((end - start) >= size)
-		return 0;
-
-	max_pgoff = (size - (end - start)) / PAGE_SIZE;
-	pgoff = get_random_u32_inclusive(0, max_pgoff);
-
-	return start - pgoff * PAGE_SIZE;
-}
-
-/*
- * Modules may directly reference data and text anywhere within the kernel
- * image and other modules. References using PREL32 relocations have a +/-2G
- * range, and so we need to ensure that the entire kernel image and all modules
- * fall within a 2G window such that these are always within range.
- *
- * Modules may directly branch to functions and code within the kernel text,
- * and to functions and code within other modules. These branches will use
- * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
- * that the entire kernel text and all module text falls within a 128M window
- * such that these are always within range. With PLTs, we can expand this to a
- * 2G window.
- *
- * We chose the 128M region to surround the entire kernel image (rather than
- * just the text) as using the same bounds for the 128M and 2G regions ensures
- * by construction that we never select a 128M region that is not a subset of
- * the 2G region. For very large and unusual kernel configurations this means
- * we may fall back to PLTs where they could have been avoided, but this keeps
- * the logic significantly simpler.
- */
-static int __init module_init_limits(void)
-{
-	u64 kernel_end = (u64)_end;
-	u64 kernel_start = (u64)_text;
-	u64 kernel_size = kernel_end - kernel_start;
-
-	/*
-	 * The default modules region is placed immediately below the kernel
-	 * image, and is large enough to use the full 2G relocation range.
-	 */
-	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
-	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
-
-	if (!kaslr_enabled()) {
-		if (kernel_size < SZ_128M)
-			module_direct_base = kernel_end - SZ_128M;
-		if (kernel_size < SZ_2G)
-			module_plt_base = kernel_end - SZ_2G;
-	} else {
-		u64 min = kernel_start;
-		u64 max = kernel_end;
-
-		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
-			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
-		} else {
-			module_direct_base = random_bounding_box(SZ_128M, min, max);
-			if (module_direct_base) {
-				min = module_direct_base;
-				max = module_direct_base + SZ_128M;
-			}
-		}
-
-		module_plt_base = random_bounding_box(SZ_2G, min, max);
-	}
-
-	pr_info("%llu pages in range for non-PLT usage",
-		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
-	pr_info("%llu pages in range for PLT usage",
-		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
-
-	return 0;
-}
-
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-		},
-		[EXECMEM_KPROBES] = {
-			.start = VMALLOC_START,
-			.end = VMALLOC_END,
-			.alignment = 1,
-		},
-		[EXECMEM_BPF] = {
-			.start = VMALLOC_START,
-			.end = VMALLOC_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
-
-	module_init_limits();
-
-	r->pgprot = PAGE_KERNEL;
-
-	if (module_direct_base) {
-		r->start = module_direct_base;
-		r->end = module_direct_base + SZ_128M;
-
-		if (module_plt_base) {
-			r->fallback_start = module_plt_base;
-			r->fallback_end = module_plt_base + SZ_2G;
-		}
-	} else if (module_plt_base) {
-		r->start = module_plt_base;
-		r->end = module_plt_base + SZ_2G;
-	}
-
-	execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
-	execmem_params.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-
 enum aarch64_reloc_op {
 	RELOC_OP_NONE,
 	RELOC_OP_ABS,
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8a0f8604348b..9b7716b4d84c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/hugetlb.h>
 #include <linux/acpi_iort.h>
 #include <linux/kmemleak.h>
+#include <linux/execmem.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -547,3 +548,134 @@ void dump_mem_limit(void)
 		pr_emerg("Memory Limit: none\n");
 	}
 }
+
+#ifdef CONFIG_EXECMEM
+static u64 module_direct_base __ro_after_init = 0;
+static u64 module_plt_base __ro_after_init = 0;
+
+/*
+ * Choose a random page-aligned base address for a window of 'size' bytes which
+ * entirely contains the interval [start, end - 1].
+ */
+static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
+{
+	u64 max_pgoff, pgoff;
+
+	if ((end - start) >= size)
+		return 0;
+
+	max_pgoff = (size - (end - start)) / PAGE_SIZE;
+	pgoff = get_random_u32_inclusive(0, max_pgoff);
+
+	return start - pgoff * PAGE_SIZE;
+}
+
+/*
+ * Modules may directly reference data and text anywhere within the kernel
+ * image and other modules. References using PREL32 relocations have a +/-2G
+ * range, and so we need to ensure that the entire kernel image and all modules
+ * fall within a 2G window such that these are always within range.
+ *
+ * Modules may directly branch to functions and code within the kernel text,
+ * and to functions and code within other modules. These branches will use
+ * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
+ * that the entire kernel text and all module text falls within a 128M window
+ * such that these are always within range. With PLTs, we can expand this to a
+ * 2G window.
+ *
+ * We chose the 128M region to surround the entire kernel image (rather than
+ * just the text) as using the same bounds for the 128M and 2G regions ensures
+ * by construction that we never select a 128M region that is not a subset of
+ * the 2G region. For very large and unusual kernel configurations this means
+ * we may fall back to PLTs where they could have been avoided, but this keeps
+ * the logic significantly simpler.
+ */
+static int __init module_init_limits(void)
+{
+	u64 kernel_end = (u64)_end;
+	u64 kernel_start = (u64)_text;
+	u64 kernel_size = kernel_end - kernel_start;
+
+	/*
+	 * The default modules region is placed immediately below the kernel
+	 * image, and is large enough to use the full 2G relocation range.
+	 */
+	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
+	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
+
+	if (!kaslr_enabled()) {
+		if (kernel_size < SZ_128M)
+			module_direct_base = kernel_end - SZ_128M;
+		if (kernel_size < SZ_2G)
+			module_plt_base = kernel_end - SZ_2G;
+	} else {
+		u64 min = kernel_start;
+		u64 max = kernel_end;
+
+		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
+			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
+		} else {
+			module_direct_base = random_bounding_box(SZ_128M, min, max);
+			if (module_direct_base) {
+				min = module_direct_base;
+				max = module_direct_base + SZ_128M;
+			}
+		}
+
+		module_plt_base = random_bounding_box(SZ_2G, min, max);
+	}
+
+	pr_info("%llu pages in range for non-PLT usage",
+		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
+	pr_info("%llu pages in range for PLT usage",
+		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
+
+	return 0;
+}
+
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+		},
+		[EXECMEM_KPROBES] = {
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	struct execmem_range *r = &execmem_params.ranges[EXECMEM_DEFAULT];
+
+	module_init_limits();
+
+	r->pgprot = PAGE_KERNEL;
+
+	if (module_direct_base) {
+		r->start = module_direct_base;
+		r->end = module_direct_base + SZ_128M;
+
+		if (module_plt_base) {
+			r->fallback_start = module_plt_base;
+			r->fallback_end = module_plt_base + SZ_2G;
+		}
+	} else if (module_plt_base) {
+		r->start = module_plt_base;
+		r->end = module_plt_base + SZ_2G;
+	}
+
+	execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
+	execmem_params.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index a1d8fe9796fa..181b5f8b09f1 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -18,7 +18,6 @@
 #include <linux/ftrace.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/inst.h>
 
@@ -470,23 +469,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-
-	return &execmem_params;
-}
-
 static void module_init_ftrace_plt(const Elf_Ehdr *hdr,
 				   const Elf_Shdr *sechdrs, struct module *mod)
 {
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index f3fe8c06ba4d..26b10a51309c 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/gfp.h>
 #include <linux/hugetlb.h>
 #include <linux/mmzone.h>
+#include <linux/execmem.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -247,3 +248,22 @@ EXPORT_SYMBOL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 1c959074b35f..ebf9496f5db0 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -33,25 +33,6 @@ struct mips_hi16 {
 static LIST_HEAD(dbe_list);
 static DEFINE_SPINLOCK(dbe_lock);
 
-#ifdef MODULE_START
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.start = MODULE_START,
-			.end = MODULE_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-#endif
-
 static void apply_r_mips_32(u32 *location, u32 base, Elf_Addr v)
 {
 	*location = base + v;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5dcb525a8995..55e7869d03f2 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/initrd.h>
+#include <linux/execmem.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -573,3 +574,22 @@ EXPORT_SYMBOL_GPL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
+
+#if defined(CONFIG_EXECMEM) && defined(MODULE_START)
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.start = MODULE_START,
+			.end = MODULE_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 0c6dfd1daef3..fecd2760b7a6 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -174,23 +174,6 @@ static inline int reassemble_22(int as22)
 		((as22 & 0x0003ff) << 3));
 }
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL_RWX,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
-
-	return &execmem_params;
-}
-
 #ifndef CONFIG_64BIT
 static inline unsigned long count_gots(const Elf_Rela *rela, unsigned long n)
 {
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index a088c243edea..c87fed38e38e 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/nodemask.h>	/* for node_online_map */
 #include <linux/pagemap.h>	/* for release_pages */
 #include <linux/compat.h>
+#include <linux/execmem.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -479,7 +480,7 @@ void free_initmem(void)
 	/* finally dump all the instructions which were cached, since the
 	 * pages are no-longer executable */
 	flush_icache_range(init_begin, init_end);
-	
+
 	free_initmem_default(POISON_FREE_INITMEM);
 
 	/* set up a new led state on systems shipped LED State panel */
@@ -919,3 +920,22 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_RWX
 };
 DECLARE_VM_GET_PAGE_PROT
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL_RWX,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index e4ecee1c87ef..b30e00964a60 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -10,7 +10,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/bug.h>
-#include <linux/execmem.h>
 #include <asm/module.h>
 #include <linux/uaccess.h>
 #include <asm/firmware.h>
@@ -89,62 +88,3 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 	return 0;
 }
-
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.alignment = 1,
-		},
-		[EXECMEM_KPROBES] = {
-			.alignment = 1,
-		},
-		[EXECMEM_MODULE_DATA] = {
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
-	struct execmem_range *range = &execmem_params.ranges[EXECMEM_DEFAULT];
-
-	/*
-	 * BOOK3S_32 and 8xx define MODULES_VADDR for text allocations and
-	 * allow allocating data in the entire vmalloc space
-	 */
-#ifdef MODULES_VADDR
-	struct execmem_range *data = &execmem_params.ranges[EXECMEM_MODULE_DATA];
-	unsigned long limit = (unsigned long)_etext - SZ_32M;
-
-	/* First try within 32M limit from _etext to avoid branch trampolines */
-	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit) {
-		range->start = limit;
-		range->end = MODULES_END;
-		range->fallback_start = MODULES_VADDR;
-		range->fallback_end = MODULES_END;
-	} else {
-		range->start = MODULES_VADDR;
-		range->end = MODULES_END;
-	}
-	data->start = VMALLOC_START;
-	data->end = VMALLOC_END;
-	data->pgprot = PAGE_KERNEL;
-	data->alignment = 1;
-#else
-	range->start = VMALLOC_START;
-	range->end = VMALLOC_END;
-#endif
-
-	range->pgprot = prot;
-
-	execmem_params.ranges[EXECMEM_KPROBES].start = range->start;
-	execmem_params.ranges[EXECMEM_KPROBES].end = range->end;
-
-	if (strict_module_rwx_enabled())
-		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
-	else
-		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
-
-	return &execmem_params;
-}
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8b121df7b08f..466e912181af 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -16,6 +16,7 @@
 #include <linux/highmem.h>
 #include <linux/suspend.h>
 #include <linux/dma-direct.h>
+#include <linux/execmem.h>
 
 #include <asm/swiotlb.h>
 #include <asm/machdep.h>
@@ -406,3 +407,64 @@ int devmem_is_allowed(unsigned long pfn)
  * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
  */
 EXPORT_SYMBOL_GPL(walk_system_ram_range);
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.alignment = 1,
+		},
+		[EXECMEM_KPROBES] = {
+			.alignment = 1,
+		},
+		[EXECMEM_MODULE_DATA] = {
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
+	struct execmem_range *range = &execmem_params.ranges[EXECMEM_DEFAULT];
+
+	/*
+	 * BOOK3S_32 and 8xx define MODULES_VADDR for text allocations and
+	 * allow allocating data in the entire vmalloc space
+	 */
+#ifdef MODULES_VADDR
+	struct execmem_range *data = &execmem_params.ranges[EXECMEM_MODULE_DATA];
+	unsigned long limit = (unsigned long)_etext - SZ_32M;
+
+	/* First try within 32M limit from _etext to avoid branch trampolines */
+	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit) {
+		range->start = limit;
+		range->end = MODULES_END;
+		range->fallback_start = MODULES_VADDR;
+		range->fallback_end = MODULES_END;
+	} else {
+		range->start = MODULES_VADDR;
+		range->end = MODULES_END;
+	}
+	data->start = VMALLOC_START;
+	data->end = VMALLOC_END;
+	data->pgprot = PAGE_KERNEL;
+	data->alignment = 1;
+#else
+	range->start = VMALLOC_START;
+	range->end = VMALLOC_END;
+#endif
+
+	range->pgprot = prot;
+
+	execmem_params.ranges[EXECMEM_KPROBES].start = range->start;
+	execmem_params.ranges[EXECMEM_KPROBES].end = range->end;
+
+	if (strict_module_rwx_enabled())
+		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
+	else
+		execmem_params.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 31505ecb5c72..8af08d5449bf 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -11,7 +11,6 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
-#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
 
@@ -436,44 +435,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-#ifdef CONFIG_MMU
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-		[EXECMEM_KPROBES] = {
-			.pgprot = PAGE_KERNEL_READ_EXEC,
-			.alignment = 1,
-		},
-		[EXECMEM_BPF] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-#ifdef CONFIG_64BIT
-	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-#else
-	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
-#endif
-
-	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
-	execmem_params.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
-
-	execmem_params.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
-	execmem_params.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
-
-	return &execmem_params;
-}
-#endif
-
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..b0f7848f39e3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #endif
 #include <linux/kfence.h>
+#include <linux/execmem.h>
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
@@ -1564,3 +1565,41 @@ void __init pgtable_cache_init(void)
 		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
 }
 #endif
+
+#if defined(CONFIG_MMU) && defined(CONFIG_EXECMEM)
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+		[EXECMEM_KPROBES] = {
+			.pgprot = PAGE_KERNEL_READ_EXEC,
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+#ifdef CONFIG_64BIT
+	execmem_params.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+#else
+	execmem_params.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+#endif
+
+	execmem_params.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_params.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
+
+	execmem_params.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
+	execmem_params.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 538d5f24af66..81a8d92ca092 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -37,31 +37,6 @@
 
 #define PLT_ENTRY_SIZE 22
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-			.pgprot = PAGE_KERNEL,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	unsigned long module_load_offset = 0;
-	unsigned long start;
-
-	if (kaslr_enabled())
-		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
-
-	start = MODULES_VADDR + module_load_offset;
-	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-
-	return &execmem_params;
-}
-
 #ifdef CONFIG_FUNCTION_TRACER
 void module_arch_cleanup(struct module *mod)
 {
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8b94d2212d33..2e6d6512fc5f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
+#include <linux/execmem.h>
 #include <asm/pgalloc.h>
 #include <asm/kfence.h>
 #include <asm/ptdump.h>
@@ -311,3 +312,30 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	vmem_remove_mapping(start, size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+			.pgprot = PAGE_KERNEL,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	unsigned long module_load_offset = 0;
+	unsigned long start;
+
+	if (kaslr_enabled())
+		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
+
+	start = MODULES_VADDR + module_load_offset;
+	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_params;
+}
+#endif
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 1d8d1fba95b9..dff1d85ba202 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/mm.h>
-#include <linux/execmem.h>
 #ifdef CONFIG_SPARC64
 #include <linux/jump_label.h>
 #endif
@@ -25,28 +24,6 @@
 
 #include "entry.h"
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-#ifdef CONFIG_SPARC64
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-#else
-			.start = VMALLOC_START,
-			.end = VMALLOC_END,
-#endif
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-
 /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 871354aa3c00..87e2cf7efb5b 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_SPARC32)   += leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+
+obj-$(CONFIG_EXECMEM) += execmem.o
diff --git a/arch/sparc/mm/execmem.c b/arch/sparc/mm/execmem.c
new file mode 100644
index 000000000000..fb53a859869a
--- /dev/null
+++ b/arch/sparc/mm/execmem.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/execmem.h>
+
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+#ifdef CONFIG_SPARC64
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+#else
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+#endif
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 9d37375e2f05..c52d591c0f3f 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -19,7 +19,6 @@
 #include <linux/jump_label.h>
 #include <linux/random.h>
 #include <linux/memory.h>
-#include <linux/execmem.h>
 
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -37,32 +36,6 @@ do {							\
 } while (0)
 #endif
 
-static struct execmem_params execmem_params __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-		},
-	},
-};
-
-struct execmem_params __init *execmem_arch_params(void)
-{
-	unsigned long module_load_offset = 0;
-	unsigned long start;
-
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
-		module_load_offset =
-			get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
-
-	start = MODULES_VADDR + module_load_offset;
-	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
-	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_params;
-}
-
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..022af7ab50f9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -7,6 +7,7 @@
 #include <linux/swapops.h>
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
+#include <linux/execmem.h>
 
 #include <asm/set_memory.h>
 #include <asm/cpu_device_id.h>
@@ -1099,3 +1100,31 @@ unsigned long arch_max_swapfile_size(void)
 	return pages;
 }
 #endif
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_params execmem_params __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+		},
+	},
+};
+
+struct execmem_params __init *execmem_arch_params(void)
+{
+	unsigned long module_load_offset = 0;
+	unsigned long start;
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
+		module_load_offset =
+			get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
+
+	start = MODULES_VADDR + module_load_offset;
+	execmem_params.ranges[EXECMEM_DEFAULT].start = start;
+	execmem_params.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+	execmem_params.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_params;
+}
+#endif /* CONFIG_EXECMEM */
-- 
2.39.2


--zYM0uCDKw75PZbzx--
