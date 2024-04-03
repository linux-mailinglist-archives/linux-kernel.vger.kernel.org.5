Return-Path: <linux-kernel+bounces-130336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96358976ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDFD1F2F89C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3B16190D;
	Wed,  3 Apr 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzwJjvCq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C69161339;
	Wed,  3 Apr 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164773; cv=none; b=e0DuGuLDhsaEslqXQ/NCHgm4tbwhCBrgKqbf+2tKOq2K5a63uEK1oBAmc8r+g2YxLlvxmQiHT/MhwEQU7rV4ae1kuotiUXlA07goYkYfsuzA99jBF2hjeotkmZk9h9kmMs8tURpTjyBMwi+xBA8ozMPOcvWYKY+P7Yy1iubzy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164773; c=relaxed/simple;
	bh=8B1t4Px7dkhdKrJe3fy8ag6ypD3rsqA0jxk4Kv1UpP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2kY3aqLVBwKQFybDLt7xN5wpIEiwlYTehHz88mUnQ5dj/nQ7vsgaustbqdoVDJ3kyCJZnoaQcJ5wt7aLD/UztugJFBGC960KW1tN8bOmR5dqtU5ooe4xsaYn+BZ+mg71bZgMKF0/PbZTAfzfKjKAhOEEiR1W4hSfuKMxk74vgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzwJjvCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99249C433F1;
	Wed,  3 Apr 2024 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164772;
	bh=8B1t4Px7dkhdKrJe3fy8ag6ypD3rsqA0jxk4Kv1UpP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzwJjvCqEeVJI80ExCmfG1Opdsd1Pq+Fs4e+Qx9fV7FAYZe4fuPpD8zGkjbqSQaMp
	 Qdk/Fb2hS6TYsscuUziZs3BmSiB1vE69I/bnycpDnceYA80p6NTaVkEvOj/Fc9LLRg
	 mzWNJdwUik2xRmfieJIblYRbKh7uVaLNoY6H0qanIrlcHW4a//Yuy8gFWpipsl1FAz
	 VsCVEikNxuUGONYBAJ/VxslE6AE8rLGWUWu7eq+vArUfa/qYvpqvUpeqB+riLN3nAy
	 JHC8mENhx2vddIrtAHx1SEJt73NN5pBGgFMYXfbXR3pw6vxRQyvkFV3R/Hbd89/97D
	 qoWsJGQgsV8tA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.1 11/15] x86/xen: attempt to inflate the memory balloon on PVH
Date: Wed,  3 Apr 2024 13:18:55 -0400
Message-ID: <20240403171909.345570-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit 38620fc4e8934f1801c7811ef39a041914ac4c1d ]

When running as PVH or HVM Linux will use holes in the memory map as scratch
space to map grants, foreign domain pages and possibly miscellaneous other
stuff.  However the usage of such memory map holes for Xen purposes can be
problematic.  The request of holesby Xen happen quite early in the kernel boot
process (grant table setup already uses scratch map space), and it's possible
that by then not all devices have reclaimed their MMIO space.  It's not
unlikely for chunks of Xen scratch map space to end up using PCI bridge MMIO
window memory, which (as expected) causes quite a lot of issues in the system.

At least for PVH dom0 we have the possibility of using regions marked as
UNUSABLE in the e820 memory map.  Either if the region is UNUSABLE in the
native memory map, or it has been converted into UNUSABLE in order to hide RAM
regions from dom0, the second stage translation page-tables can populate those
areas without issues.

PV already has this kind of logic, where the balloon driver is inflated at
boot.  Re-use the current logic in order to also inflate it when running as
PVH.  onvert UNUSABLE regions up to the ratio specified in EXTRA_MEM_RATIO to
RAM, while reserving them using xen_add_extra_mem() (which is also moved so
it's no longer tied to CONFIG_PV).

[jgross: fixed build for CONFIG_PVH without CONFIG_XEN_PVH]

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20240220174341.56131-1-roger.pau@citrix.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/xen/hypervisor.h |  5 ++
 arch/x86/platform/pvh/enlighten.c     |  3 ++
 arch/x86/xen/enlighten.c              | 32 +++++++++++++
 arch/x86/xen/enlighten_pvh.c          | 68 +++++++++++++++++++++++++++
 arch/x86/xen/setup.c                  | 44 -----------------
 arch/x86/xen/xen-ops.h                | 14 ++++++
 drivers/xen/balloon.c                 |  2 -
 7 files changed, 122 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 16f548a661cf6..b3bfefdb7793a 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -59,6 +59,11 @@ void xen_arch_unregister_cpu(int num);
 #ifdef CONFIG_PVH
 void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
+#ifdef CONFIG_XEN_PVH
+void __init xen_reserve_extra_memory(struct boot_params *bootp);
+#else
+static inline void xen_reserve_extra_memory(struct boot_params *bootp) { }
+#endif
 #endif
 
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index ed0442e354344..f15dc1e3ad7dd 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -74,6 +74,9 @@ static void __init init_pvh_bootparams(bool xen_guest)
 	} else
 		xen_raw_printk("Warning: Can fit ISA range into e820\n");
 
+	if (xen_guest)
+		xen_reserve_extra_memory(&pvh_bootparams);
+
 	pvh_bootparams.hdr.cmd_line_ptr =
 		pvh_start_info.cmdline_paddr;
 
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 3c61bb98c10e2..a01ca255b0c64 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -6,6 +6,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/kexec.h>
+#include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/panic_notifier.h>
 
@@ -350,3 +351,34 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
+
+/* Amount of extra memory space we add to the e820 ranges */
+struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
+
+void __init xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns)
+{
+	unsigned int i;
+
+	/*
+	 * No need to check for zero size, should happen rarely and will only
+	 * write a new entry regarded to be unused due to zero size.
+	 */
+	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
+		/* Add new region. */
+		if (xen_extra_mem[i].n_pfns == 0) {
+			xen_extra_mem[i].start_pfn = start_pfn;
+			xen_extra_mem[i].n_pfns = n_pfns;
+			break;
+		}
+		/* Append to existing region. */
+		if (xen_extra_mem[i].start_pfn + xen_extra_mem[i].n_pfns ==
+		    start_pfn) {
+			xen_extra_mem[i].n_pfns += n_pfns;
+			break;
+		}
+	}
+	if (i == XEN_EXTRA_MEM_MAX_REGIONS)
+		printk(KERN_WARNING "Warning: not enough extra memory regions\n");
+
+	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
+}
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index ada3868c02c23..c28f073c1df52 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/mm.h>
 
 #include <xen/hvc-console.h>
 
@@ -72,3 +73,70 @@ void __init mem_map_via_hcall(struct boot_params *boot_params_p)
 	}
 	boot_params_p->e820_entries = memmap.nr_entries;
 }
+
+/*
+ * Reserve e820 UNUSABLE regions to inflate the memory balloon.
+ *
+ * On PVH dom0 the host memory map is used, RAM regions available to dom0 are
+ * located as the same place as in the native memory map, but since dom0 gets
+ * less memory than the total amount of host RAM the ranges that can't be
+ * populated are converted from RAM -> UNUSABLE.  Use such regions (up to the
+ * ratio signaled in EXTRA_MEM_RATIO) in order to inflate the balloon driver at
+ * boot.  Doing so prevents the guest (even if just temporary) from using holes
+ * in the memory map in order to map grants or foreign addresses, and
+ * hopefully limits the risk of a clash with a device MMIO region.  Ideally the
+ * hypervisor should notify us which memory ranges are suitable for creating
+ * foreign mappings, but that's not yet implemented.
+ */
+void __init xen_reserve_extra_memory(struct boot_params *bootp)
+{
+	unsigned int i, ram_pages = 0, extra_pages;
+
+	for (i = 0; i < bootp->e820_entries; i++) {
+		struct boot_e820_entry *e = &bootp->e820_table[i];
+
+		if (e->type != E820_TYPE_RAM)
+			continue;
+		ram_pages += PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr);
+	}
+
+	/* Max amount of extra memory. */
+	extra_pages = EXTRA_MEM_RATIO * ram_pages;
+
+	/*
+	 * Convert UNUSABLE ranges to RAM and reserve them for foreign mapping
+	 * purposes.
+	 */
+	for (i = 0; i < bootp->e820_entries && extra_pages; i++) {
+		struct boot_e820_entry *e = &bootp->e820_table[i];
+		unsigned long pages;
+
+		if (e->type != E820_TYPE_UNUSABLE)
+			continue;
+
+		pages = min(extra_pages,
+			PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr));
+
+		if (pages != (PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr))) {
+			struct boot_e820_entry *next;
+
+			if (bootp->e820_entries ==
+			    ARRAY_SIZE(bootp->e820_table))
+				/* No space left to split - skip region. */
+				continue;
+
+			/* Split entry. */
+			next = e + 1;
+			memmove(next, e,
+				(bootp->e820_entries - i) * sizeof(*e));
+			bootp->e820_entries++;
+			next->addr = PAGE_ALIGN(e->addr) + PFN_PHYS(pages);
+			e->size = next->addr - e->addr;
+			next->size -= e->size;
+		}
+		e->type = E820_TYPE_RAM;
+		extra_pages -= pages;
+
+		xen_add_extra_mem(PFN_UP(e->addr), pages);
+	}
+}
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 8db26f10fb1d9..72ab4a2f029bb 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -37,9 +37,6 @@
 
 #define GB(x) ((uint64_t)(x) * 1024 * 1024 * 1024)
 
-/* Amount of extra memory space we add to the e820 ranges */
-struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
-
 /* Number of pages released from the initial allocation. */
 unsigned long xen_released_pages;
 
@@ -60,18 +57,6 @@ static struct {
 } xen_remap_buf __initdata __aligned(PAGE_SIZE);
 static unsigned long xen_remap_mfn __initdata = INVALID_P2M_ENTRY;
 
-/*
- * The maximum amount of extra memory compared to the base size.  The
- * main scaling factor is the size of struct page.  At extreme ratios
- * of base:extra, all the base memory can be filled with page
- * structures for the extra memory, leaving no space for anything
- * else.
- *
- * 10x seems like a reasonable balance between scaling flexibility and
- * leaving a practically usable system.
- */
-#define EXTRA_MEM_RATIO		(10)
-
 static bool xen_512gb_limit __initdata = IS_ENABLED(CONFIG_XEN_512GB);
 
 static void __init xen_parse_512gb(void)
@@ -92,35 +77,6 @@ static void __init xen_parse_512gb(void)
 	xen_512gb_limit = val;
 }
 
-static void __init xen_add_extra_mem(unsigned long start_pfn,
-				     unsigned long n_pfns)
-{
-	int i;
-
-	/*
-	 * No need to check for zero size, should happen rarely and will only
-	 * write a new entry regarded to be unused due to zero size.
-	 */
-	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
-		/* Add new region. */
-		if (xen_extra_mem[i].n_pfns == 0) {
-			xen_extra_mem[i].start_pfn = start_pfn;
-			xen_extra_mem[i].n_pfns = n_pfns;
-			break;
-		}
-		/* Append to existing region. */
-		if (xen_extra_mem[i].start_pfn + xen_extra_mem[i].n_pfns ==
-		    start_pfn) {
-			xen_extra_mem[i].n_pfns += n_pfns;
-			break;
-		}
-	}
-	if (i == XEN_EXTRA_MEM_MAX_REGIONS)
-		printk(KERN_WARNING "Warning: not enough extra memory regions\n");
-
-	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
-}
-
 static void __init xen_del_extra_mem(unsigned long start_pfn,
 				     unsigned long n_pfns)
 {
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index b2b2f4315b78d..8c715a4f06c02 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -162,4 +162,18 @@ void xen_hvm_post_suspend(int suspend_cancelled);
 static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
 #endif
 
+/*
+ * The maximum amount of extra memory compared to the base size.  The
+ * main scaling factor is the size of struct page.  At extreme ratios
+ * of base:extra, all the base memory can be filled with page
+ * structures for the extra memory, leaving no space for anything
+ * else.
+ *
+ * 10x seems like a reasonable balance between scaling flexibility and
+ * leaving a practically usable system.
+ */
+#define EXTRA_MEM_RATIO		(10)
+
+void xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns);
+
 #endif /* XEN_OPS_H */
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 617a7f4f07a80..4e23b398e2882 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -691,7 +691,6 @@ EXPORT_SYMBOL(xen_free_ballooned_pages);
 
 static void __init balloon_add_regions(void)
 {
-#if defined(CONFIG_XEN_PV)
 	unsigned long start_pfn, pages;
 	unsigned long pfn, extra_pfn_end;
 	unsigned int i;
@@ -715,7 +714,6 @@ static void __init balloon_add_regions(void)
 
 		balloon_stats.total_pages += extra_pfn_end - start_pfn;
 	}
-#endif
 }
 
 static int __init balloon_init(void)
-- 
2.43.0


