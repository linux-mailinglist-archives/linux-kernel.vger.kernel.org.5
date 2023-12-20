Return-Path: <linux-kernel+bounces-7250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3281A3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC8D283215
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32046548;
	Wed, 20 Dec 2023 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyBJPb5z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62DB47764;
	Wed, 20 Dec 2023 16:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689E5C433C8;
	Wed, 20 Dec 2023 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088480;
	bh=1KlWZ9IZrE8/4wpFimvNAIsEdHVL7lO8r/7Dyx/Qixc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyBJPb5z8IImAa6auO2g0i3dgLRCzTsWP9K14sQ4R+V6F8BawiBLnukxR17RJKm2t
	 9v261usBm/zolmxQlgYm2HQURLR3oB+JAseGIzv9G0CtNL1FVquxk5kKJtHQhpvYuP
	 XcwlyRWCOwpZrI7ibpvyG0nVJxSITYP8RncLwyiw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.144
Date: Wed, 20 Dec 2023 17:07:48 +0100
Message-ID: <2023122047-cassette-attitude-4dd9@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023122047-doorbell-math-cc22@gregkh>
References: <2023122047-doorbell-math-cc22@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 3e6550575904..992cf6a636af 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 143
+SUBLEVEL = 144
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 699ecf119641..110eb69e9bee 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -59,13 +59,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 
 		low_mem_sz = size;
 		in_use = 1;
-		memblock_add_node(base, size, 0);
+		memblock_add_node(base, size, 0, MEMBLOCK_NONE);
 	} else {
 #ifdef CONFIG_HIGHMEM
 		high_mem_start = base;
 		high_mem_sz = size;
 		in_use = 1;
-		memblock_add_node(base, size, 1);
+		memblock_add_node(base, size, 1, MEMBLOCK_NONE);
 		memblock_reserve(base, size);
 #endif
 	}
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ed57717cd004..b5e969bc074d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -766,6 +766,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
+	/*
+	 * If we end up clearing hw dirtiness for a sw-dirty PTE, set hardware
+	 * dirtiness again.
+	 */
+	if (pte_sw_dirty(pte))
+		pte = pte_mkdirty(pte);
 	return pte;
 }
 
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 9817caba0702..1e9eaa107eb7 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -153,7 +153,7 @@ find_memory (void)
 	efi_memmap_walk(find_max_min_low_pfn, NULL);
 	max_pfn = max_low_pfn;
 
-	memblock_add_node(0, PFN_PHYS(max_low_pfn), 0);
+	memblock_add_node(0, PFN_PHYS(max_low_pfn), 0, MEMBLOCK_NONE);
 
 	find_initrd();
 
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 5c6da8d83c1a..5d165607bf35 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -378,7 +378,7 @@ int __init register_active_ranges(u64 start, u64 len, int nid)
 #endif
 
 	if (start < end)
-		memblock_add_node(__pa(start), end - start, nid);
+		memblock_add_node(__pa(start), end - start, nid, MEMBLOCK_NONE);
 	return 0;
 }
 
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index eac9dde65193..6f1f25125294 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -174,7 +174,8 @@ void __init cf_bootmem_alloc(void)
 	m68k_memory[0].addr = _rambase;
 	m68k_memory[0].size = _ramend - _rambase;
 
-	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0,
+			  MEMBLOCK_NONE);
 
 	/* compute total pages in system */
 	num_pages = PFN_DOWN(_ramend - _rambase);
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 9f3f77785aa7..2b05bb2bac00 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -410,7 +410,8 @@ void __init paging_init(void)
 
 	min_addr = m68k_memory[0].addr;
 	max_addr = min_addr + m68k_memory[0].size;
-	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0,
+			  MEMBLOCK_NONE);
 	for (i = 1; i < m68k_num_memory;) {
 		if (m68k_memory[i].addr < min_addr) {
 			printk("Ignoring memory chunk at 0x%lx:0x%lx before the first chunk\n",
@@ -421,7 +422,8 @@ void __init paging_init(void)
 				(m68k_num_memory - i) * sizeof(struct m68k_mem_info));
 			continue;
 		}
-		memblock_add_node(m68k_memory[i].addr, m68k_memory[i].size, i);
+		memblock_add_node(m68k_memory[i].addr, m68k_memory[i].size, i,
+				  MEMBLOCK_NONE);
 		addr = m68k_memory[i].addr + m68k_memory[i].size;
 		if (addr > max_addr)
 			max_addr = addr;
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index c454ef734c45..e007edd6b60a 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -14,7 +14,11 @@
 #define ADAPTER_ROM		8
 #define ACPI_TABLE		9
 #define SMBIOS_TABLE		10
-#define MAX_MEMORY_TYPE		11
+#define UMA_VIDEO_RAM		11
+#define VUMA_VIDEO_RAM		12
+#define MAX_MEMORY_TYPE		13
+
+#define MEM_SIZE_IS_IN_BYTES	(1 << 31)
 
 #define LOONGSON3_BOOT_MEM_MAP_MAX 128
 struct efi_memory_map_loongson {
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index c1498fdd5c79..3d147de87d3f 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -49,8 +49,7 @@ void virtual_early_config(void)
 void __init szmem(unsigned int node)
 {
 	u32 i, mem_type;
-	static unsigned long num_physpages;
-	u64 node_id, node_psize, start_pfn, end_pfn, mem_start, mem_size;
+	phys_addr_t node_id, mem_start, mem_size;
 
 	/* Otherwise come from DTB */
 	if (loongson_sysconf.fw_interface != LOONGSON_LEFI)
@@ -64,25 +63,38 @@ void __init szmem(unsigned int node)
 
 		mem_type = loongson_memmap->map[i].mem_type;
 		mem_size = loongson_memmap->map[i].mem_size;
-		mem_start = loongson_memmap->map[i].mem_start;
+
+		/* Memory size comes in MB if MEM_SIZE_IS_IN_BYTES not set */
+		if (mem_size & MEM_SIZE_IS_IN_BYTES)
+			mem_size &= ~MEM_SIZE_IS_IN_BYTES;
+		else
+			mem_size = mem_size << 20;
+
+		mem_start = (node_id << 44) | loongson_memmap->map[i].mem_start;
 
 		switch (mem_type) {
 		case SYSTEM_RAM_LOW:
 		case SYSTEM_RAM_HIGH:
-			start_pfn = ((node_id << 44) + mem_start) >> PAGE_SHIFT;
-			node_psize = (mem_size << 20) >> PAGE_SHIFT;
-			end_pfn  = start_pfn + node_psize;
-			num_physpages += node_psize;
-			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
-				(u32)node_id, mem_type, mem_start, mem_size);
-			pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
-				start_pfn, end_pfn, num_physpages);
-			memblock_add_node(PFN_PHYS(start_pfn), PFN_PHYS(node_psize), node);
+		case UMA_VIDEO_RAM:
+			pr_info("Node %d, mem_type:%d\t[%pa], %pa bytes usable\n",
+				(u32)node_id, mem_type, &mem_start, &mem_size);
+			memblock_add_node(mem_start, mem_size, node,
+					  MEMBLOCK_NONE);
 			break;
 		case SYSTEM_RAM_RESERVED:
-			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
-				(u32)node_id, mem_type, mem_start, mem_size);
-			memblock_reserve(((node_id << 44) + mem_start), mem_size << 20);
+		case VIDEO_ROM:
+		case ADAPTER_ROM:
+		case ACPI_TABLE:
+		case SMBIOS_TABLE:
+			pr_info("Node %d, mem_type:%d\t[%pa], %pa bytes reserved\n",
+				(u32)node_id, mem_type, &mem_start, &mem_size);
+			memblock_reserve(mem_start, mem_size);
+			break;
+		/* We should not reserve VUMA_VIDEO_RAM as it overlaps with MMIO */
+		case VUMA_VIDEO_RAM:
+		default:
+			pr_info("Node %d, mem_type:%d\t[%pa], %pa bytes unhandled\n",
+				(u32)node_id, mem_type, &mem_start, &mem_size);
 			break;
 		}
 	}
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 6173684b5aaa..adc2faeecf7c 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -341,7 +341,8 @@ static void __init szmem(void)
 				continue;
 			}
 			memblock_add_node(PFN_PHYS(slot_getbasepfn(node, slot)),
-					  PFN_PHYS(slot_psize), node);
+					  PFN_PHYS(slot_psize), node,
+					  MEMBLOCK_NONE);
 		}
 	}
 }
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index d636fc755f60..5b6ea1c33998 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -36,6 +36,9 @@ _GLOBAL(ftrace_regs_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0,LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -51,7 +54,7 @@ _GLOBAL(ftrace_regs_caller)
 	SAVE_GPRS(12, 31, r1)
 
 	/* Save previous stack pointer (r1) */
-	addi	r8, r1, SWITCH_FRAME_SIZE
+	addi	r8, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	std	r8, GPR1(r1)
 
 	/* Load special regs for save below */
@@ -64,6 +67,8 @@ _GLOBAL(ftrace_regs_caller)
 	mflr	r7
 	/* Save it as pt_regs->nip */
 	std     r7, _NIP(r1)
+	/* Also save it in B's stackframe header for proper unwind */
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	/* Save the read LR in pt_regs->link */
 	std     r0, _LINK(r1)
 
@@ -118,7 +123,7 @@ ftrace_regs_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi r1, r1, SWITCH_FRAME_SIZE
+	addi r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 #ifdef CONFIG_LIVEPATCH
         /* Based on the cmpd above, if the NIP was altered handle livepatch */
@@ -142,7 +147,7 @@ ftrace_no_trace:
 	mflr	r3
 	mtctr	r3
 	REST_GPR(3, r1)
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 	mtlr	r0
 	bctr
 
@@ -150,6 +155,9 @@ _GLOBAL(ftrace_caller)
 	/* Save the original return address in A's stack frame */
 	std	r0, LRSAVE(r1)
 
+	/* Create a minimal stack frame for representing B */
+	stdu	r1, -STACK_FRAME_MIN_SIZE(r1)
+
 	/* Create our stack frame + pt_regs */
 	stdu	r1, -SWITCH_FRAME_SIZE(r1)
 
@@ -163,6 +171,7 @@ _GLOBAL(ftrace_caller)
 	/* Get the _mcount() call site out of LR */
 	mflr	r7
 	std     r7, _NIP(r1)
+	std	r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
 
 	/* Save callee's TOC in the ABI compliant location */
 	std	r2, 24(r1)
@@ -197,7 +206,7 @@ ftrace_call:
 	ld	r2, 24(r1)
 
 	/* Pop our stack frame */
-	addi	r1, r1, SWITCH_FRAME_SIZE
+	addi	r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
 
 	/* Reload original LR */
 	ld	r0, LRSAVE(r1)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 4dfe37b06889..b7ce6c7c84c6 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -596,7 +596,8 @@ static void __init setup_resources(void)
 	 * part of the System RAM resource.
 	 */
 	if (crashk_res.end) {
-		memblock_add_node(crashk_res.start, resource_size(&crashk_res), 0);
+		memblock_add_node(crashk_res.start, resource_size(&crashk_res),
+				  0, MEMBLOCK_NONE);
 		memblock_reserve(crashk_res.start, resource_size(&crashk_res));
 		insert_resource(&iomem_resource, &crashk_res);
 	}
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 3049c646fa20..c8e1f9f0b466 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -140,13 +140,21 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 	unsigned int *box_offset, *ids;
 	int i;
 
-	if (WARN_ON_ONCE(!unit->ctl || !unit->ctl_offset || !unit->ctr_offset))
+	if (!unit->ctl || !unit->ctl_offset || !unit->ctr_offset) {
+		pr_info("Invalid address is detected for uncore type %d box %d, "
+			"Disable the uncore unit.\n",
+			unit->box_type, unit->box_id);
 		return;
+	}
 
 	if (parsed) {
 		type = search_uncore_discovery_type(unit->box_type);
-		if (WARN_ON_ONCE(!type))
+		if (!type) {
+			pr_info("A spurious uncore type %d is detected, "
+				"Disable the uncore type.\n",
+				unit->box_type);
 			return;
+		}
 		/* Store the first box of each die */
 		if (!type->box_ctrl_die[die])
 			type->box_ctrl_die[die] = unit->ctl;
@@ -181,8 +189,12 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		ids[i] = type->ids[i];
 		box_offset[i] = type->box_offset[i];
 
-		if (WARN_ON_ONCE(unit->box_id == ids[i]))
+		if (unit->box_id == ids[i]) {
+			pr_info("Duplicate uncore type %d box ID %d is detected, "
+				"Drop the duplicate uncore unit.\n",
+				unit->box_type, unit->box_id);
 			goto free_ids;
+		}
 	}
 	ids[i] = unit->box_id;
 	box_offset[i] = unit->ctl - type->box_ctrl;
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3ee4c1217b63..fd81a7370864 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -425,6 +425,7 @@ static void blkg_destroy_all(struct request_queue *q)
 {
 	struct blkcg_gq *blkg, *n;
 	int count = BLKG_DESTROY_BATCH_SIZE;
+	int i;
 
 restart:
 	spin_lock_irq(&q->queue_lock);
@@ -447,6 +448,18 @@ static void blkg_destroy_all(struct request_queue *q)
 		}
 	}
 
+	/*
+	 * Mark policy deactivated since policy offline has been done, and
+	 * the free is scheduled, so future blkcg_deactivate_policy() can
+	 * be bypassed
+	 */
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (pol)
+			__clear_bit(pol->plid, q->blkcg_pols);
+	}
+
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 68cf8dbb4c67..4da4b25b12f4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1415,6 +1415,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1442,6 +1443,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e..d3c30a28c410 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -449,9 +449,9 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct sk_buff *skb;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_bh(&card->cli_queue_lock);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_bh(&card->cli_queue_lock);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
@@ -956,14 +956,14 @@ static void pclose(struct atm_vcc *vcc)
 	struct pkt_hdr *header;
 
 	/* Remove any yet-to-be-transmitted packets from the pending queue */
-	spin_lock(&card->tx_queue_lock);
+	spin_lock_bh(&card->tx_queue_lock);
 	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
 		if (SKB_CB(skb)->vcc == vcc) {
 			skb_unlink(skb, &card->tx_queue[port]);
 			solos_pop(vcc, skb);
 		}
 	}
-	spin_unlock(&card->tx_queue_lock);
+	spin_unlock_bh(&card->tx_queue_lock);
 
 	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
 	if (!skb) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f643b977b5f4..3ffbd3018074 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1660,6 +1660,32 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
+static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* SDMA 5.2.3 (RMB) FW doesn't seem to properly
+	 * disallow GFXOFF in some cases leading to
+	 * hangs in SDMA.  Disallow GFXOFF while SDMA is active.
+	 * We can probably just limit this to 5.2.3,
+	 * but it shouldn't hurt for other parts since
+	 * this GFXOFF will be disallowed anyway when SDMA is
+	 * active, this just makes it explicit.
+	 */
+	amdgpu_gfx_off_ctrl(adev, false);
+}
+
+static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* SDMA 5.2.3 (RMB) FW doesn't seem to properly
+	 * disallow GFXOFF in some cases leading to
+	 * hangs in SDMA.  Allow GFXOFF when SDMA is complete.
+	 */
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
 	.name = "sdma_v5_2",
 	.early_init = sdma_v5_2_early_init,
@@ -1707,6 +1733,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.test_ib = sdma_v5_2_ring_test_ib,
 	.insert_nop = sdma_v5_2_ring_insert_nop,
 	.pad_ib = sdma_v5_2_ring_pad_ib,
+	.begin_use = sdma_v5_2_ring_begin_use,
+	.end_use = sdma_v5_2_ring_end_use,
 	.emit_wreg = sdma_v5_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v5_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index f2264633be1b..d6781e54b335 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -680,6 +680,7 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 									  crtc);
 	struct mtk_crtc_state *mtk_crtc_state = to_mtk_crtc_state(crtc_state);
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	unsigned long flags;
 
 	if (mtk_crtc->event && mtk_crtc_state->base.event)
 		DRM_ERROR("new event while there is still a pending event\n");
@@ -687,7 +688,11 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
 	if (mtk_crtc_state->base.event) {
 		mtk_crtc_state->base.event->pipe = drm_crtc_index(crtc);
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
 		mtk_crtc->event = mtk_crtc_state->base.event;
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+
 		mtk_crtc_state->base.event = NULL;
 	}
 }
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 16832e79f6a8..493814f7f09c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -382,7 +382,7 @@ static int asus_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
-static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size)
+static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
 	unsigned char *dmabuf;
 	int ret;
@@ -405,7 +405,7 @@ static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size
 
 static int asus_kbd_init(struct hid_device *hdev)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	int ret;
 
@@ -419,7 +419,7 @@ static int asus_kbd_init(struct hid_device *hdev)
 static int asus_kbd_get_functions(struct hid_device *hdev,
 				  unsigned char *kbd_func)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
 	u8 *readbuf;
 	int ret;
 
@@ -450,7 +450,7 @@ static int asus_kbd_get_functions(struct hid_device *hdev,
 
 static int rog_nkey_led_init(struct hid_device *hdev)
 {
-	u8 buf_init_start[] = { FEATURE_KBD_LED_REPORT_ID1, 0xB9 };
+	const u8 buf_init_start[] = { FEATURE_KBD_LED_REPORT_ID1, 0xB9 };
 	u8 buf_init2[] = { FEATURE_KBD_LED_REPORT_ID1, 0x41, 0x53, 0x55, 0x53, 0x20,
 				0x54, 0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	u8 buf_init3[] = { FEATURE_KBD_LED_REPORT_ID1,
@@ -1014,6 +1014,24 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
+static int __maybe_unused asus_resume(struct hid_device *hdev) {
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret = 0;
+
+	if (drvdata->kbd_backlight) {
+		const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4,
+				drvdata->kbd_backlight->cdev.brightness };
+		ret = asus_kbd_set_report(hdev, buf, sizeof(buf));
+		if (ret < 0) {
+			hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
+			goto asus_resume_err;
+		}
+	}
+
+asus_resume_err:
+	return ret;
+}
+
 static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1305,6 +1323,7 @@ static struct hid_driver asus_driver = {
 	.input_configured       = asus_input_configured,
 #ifdef CONFIG_PM
 	.reset_resume           = asus_reset_resume,
+	.resume					= asus_resume,
 #endif
 	.event			= asus_event,
 	.raw_event		= asus_raw_event
diff --git a/drivers/hid/hid-glorious.c b/drivers/hid/hid-glorious.c
index 558eb08c19ef..281b3a7187ce 100644
--- a/drivers/hid/hid-glorious.c
+++ b/drivers/hid/hid-glorious.c
@@ -21,6 +21,10 @@ MODULE_DESCRIPTION("HID driver for Glorious PC Gaming Race mice");
  * Glorious Model O and O- specify the const flag in the consumer input
  * report descriptor, which leads to inputs being ignored. Fix this
  * by patching the descriptor.
+ *
+ * Glorious Model I incorrectly specifes the Usage Minimum for its
+ * keyboard HID report, causing keycodes to be misinterpreted.
+ * Fix this by setting Usage Minimum to 0 in that report.
  */
 static __u8 *glorious_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
@@ -32,6 +36,10 @@ static __u8 *glorious_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc[85] = rdesc[113] = rdesc[141] = \
 			HID_MAIN_ITEM_VARIABLE | HID_MAIN_ITEM_RELATIVE;
 	}
+	if (*rsize == 156 && rdesc[41] == 1) {
+		hid_info(hdev, "patching Glorious Model I keyboard report descriptor\n");
+		rdesc[41] = 0;
+	}
 	return rdesc;
 }
 
@@ -44,6 +52,8 @@ static void glorious_update_name(struct hid_device *hdev)
 		model = "Model O"; break;
 	case USB_DEVICE_ID_GLORIOUS_MODEL_D:
 		model = "Model D"; break;
+	case USB_DEVICE_ID_GLORIOUS_MODEL_I:
+		model = "Model I"; break;
 	}
 
 	snprintf(hdev->name, sizeof(hdev->name), "%s %s", "Glorious", model);
@@ -66,10 +76,12 @@ static int glorious_probe(struct hid_device *hdev,
 }
 
 static const struct hid_device_id glorious_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLORIOUS,
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINOWEALTH,
 		USB_DEVICE_ID_GLORIOUS_MODEL_O) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GLORIOUS,
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINOWEALTH,
 		USB_DEVICE_ID_GLORIOUS_MODEL_D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LAVIEW,
+		USB_DEVICE_ID_GLORIOUS_MODEL_I) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, glorious_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index caca5d6e95d6..06c53c817a02 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -482,10 +482,6 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
-#define USB_VENDOR_ID_GLORIOUS  0x258a
-#define USB_DEVICE_ID_GLORIOUS_MODEL_D 0x0033
-#define USB_DEVICE_ID_GLORIOUS_MODEL_O 0x0036
-
 #define I2C_VENDOR_ID_GOODIX		0x27c6
 #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
 
@@ -708,6 +704,9 @@
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
 
+#define USB_VENDOR_ID_LAVIEW		0x22D4
+#define USB_DEVICE_ID_GLORIOUS_MODEL_I	0x1503
+
 #define USB_VENDOR_ID_LCPOWER		0x1241
 #define USB_DEVICE_ID_LCPOWER_LC1000	0xf767
 
@@ -1094,6 +1093,10 @@
 #define USB_VENDOR_ID_SIGMATEL		0x066F
 #define USB_DEVICE_ID_SIGMATEL_STMP3780	0x3780
 
+#define USB_VENDOR_ID_SINOWEALTH  0x258a
+#define USB_DEVICE_ID_GLORIOUS_MODEL_D 0x0033
+#define USB_DEVICE_ID_GLORIOUS_MODEL_O 0x0036
+
 #define USB_VENDOR_ID_SIS_TOUCH		0x0457
 #define USB_DEVICE_ID_SIS9200_TOUCH	0x9200
 #define USB_DEVICE_ID_SIS817_TOUCH	0x0817
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 901c1959efed..965bddaa90ae 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -540,7 +540,8 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 		 * so set middlebutton_state to 3
 		 * to never apply workaround anymore
 		 */
-		if (cptkbd_data->middlebutton_state == 1 &&
+		if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD &&
+				cptkbd_data->middlebutton_state == 1 &&
 				usage->type == EV_REL &&
 				(usage->code == REL_X || usage->code == REL_Y)) {
 			cptkbd_data->middlebutton_state = 3;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4ec8ca06a0bd..fc04538d93cb 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2046,6 +2046,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_HANVON_ALT,
 			USB_DEVICE_ID_HANVON_ALT_MULTITOUCH) },
 
+	/* HONOR GLO-GXXX panel */
+	{ .driver_data = MT_CLS_VTL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			0x347d, 0x7853) },
+
 	/* Ilitek dual touch panel */
 	{  .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 225138a39d32..fbce6e892fc8 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -33,6 +33,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM), HID_QUIRK_NOGET },
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index ad14c2404e94..e6851cffa40a 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1043,6 +1043,9 @@ irdma_sc_alloc_stag(struct irdma_sc_dev *dev,
 	u64 hdr;
 	enum irdma_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	if (info->page_size == 0x40000000)
 		page_size = IRDMA_PAGE_SIZE_1G;
 	else if (info->page_size == 0x200000)
@@ -1109,6 +1112,9 @@ irdma_sc_mr_reg_non_shared(struct irdma_sc_dev *dev,
 	u8 addr_type;
 	enum irdma_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	if (info->page_size == 0x40000000)
 		page_size = IRDMA_PAGE_SIZE_1G;
 	else if (info->page_size == 0x200000)
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 8b75e2610e5b..021dc9fe1d02 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1013,6 +1013,7 @@ struct irdma_allocate_stag_info {
 	bool remote_access:1;
 	bool use_hmc_fcn_index:1;
 	bool use_pf_rid:1;
+	bool all_memory:1;
 	u8 hmc_fcn_index;
 };
 
@@ -1040,6 +1041,7 @@ struct irdma_reg_ns_stag_info {
 	bool use_hmc_fcn_index:1;
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
+	bool all_memory:1;
 };
 
 struct irdma_fast_reg_stag_info {
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1af1df8a734b..8981bf834a58 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2528,7 +2528,8 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 			       struct irdma_mr *iwmr)
 {
 	struct irdma_allocate_stag_info *info;
-	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct irdma_pd *iwpd = to_iwpd(pd);
 	enum irdma_status_code status;
 	int err = 0;
 	struct irdma_cqp_request *cqp_request;
@@ -2545,6 +2546,7 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 	info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->len;
+	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = IRDMA_OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -2595,6 +2597,8 @@ static struct ib_mr *irdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	iwmr->type = IRDMA_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
+	/* Use system PAGE_SIZE as the sg page sizes are unknown at this point */
+	iwmr->len = max_num_sg * PAGE_SIZE;
 	status = irdma_get_pble(iwdev->rf->pble_rsrc, palloc, iwmr->page_cnt,
 				true);
 	if (status)
@@ -2666,7 +2670,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	struct irdma_reg_ns_stag_info *stag_info;
-	struct irdma_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct irdma_pd *iwpd = to_iwpd(pd);
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
 	enum irdma_status_code status;
 	int err = 0;
@@ -2686,6 +2691,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->total_len = iwmr->len;
 	stag_info->access_rights = irdma_get_mr_access(access);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
+	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
 		stag_info->addr_type = IRDMA_ADDR_TYPE_ZERO_BASED;
 	else
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 5fc989a6d452..21344aaf1bda 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -265,6 +265,7 @@ struct bcache_device {
 #define BCACHE_DEV_WB_RUNNING		3
 #define BCACHE_DEV_RATE_DW_RUNNING	4
 	int			nr_stripes;
+#define BCH_MIN_STRIPE_SZ		((4 << 20) >> SECTOR_SHIFT)
 	unsigned int		stripe_size;
 	atomic_t		*stripe_sectors_dirty;
 	unsigned long		*full_dirty_stripes;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index c7878ba35f3c..e22dfcf1ed6d 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -974,6 +974,9 @@ static struct btree *mca_alloc(struct cache_set *c, struct btree_op *op,
  *
  * The btree node will have either a read or a write lock held, depending on
  * level and op->lock.
+ *
+ * Note: Only error code or btree pointer will be returned, it is unncessary
+ *       for callers to check NULL pointer.
  */
 struct btree *bch_btree_node_get(struct cache_set *c, struct btree_op *op,
 				 struct bkey *k, int level, bool write,
@@ -1085,6 +1088,10 @@ static void btree_node_free(struct btree *b)
 	mutex_unlock(&b->c->bucket_lock);
 }
 
+/*
+ * Only error code or btree pointer will be returned, it is unncessary for
+ * callers to check NULL pointer.
+ */
 struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 				     int level, bool wait,
 				     struct btree *parent)
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 9e7a6c3faa42..8ec48d8a5821 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -909,6 +909,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	if (!d->stripe_size)
 		d->stripe_size = 1 << 31;
+	else if (d->stripe_size < BCH_MIN_STRIPE_SZ)
+		d->stripe_size = roundup(BCH_MIN_STRIPE_SZ, d->stripe_size);
 
 	n = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
 	if (!n || n > max_stripes) {
@@ -2022,7 +2024,7 @@ static int run_cache_set(struct cache_set *c)
 		c->root = bch_btree_node_get(c, NULL, k,
 					     j->btree_level,
 					     true, NULL);
-		if (IS_ERR_OR_NULL(c->root))
+		if (IS_ERR(c->root))
 			goto err;
 
 		list_del_init(&c->root->list);
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 3bc29ed633cb..1e96679afcf4 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -903,7 +903,7 @@ static int bch_dirty_init_thread(void *arg)
 	int cur_idx, prev_idx, skip_nr;
 
 	k = p = NULL;
-	cur_idx = prev_idx = 0;
+	prev_idx = 0;
 
 	bch_btree_iter_init(&c->root->keys, &iter, NULL);
 	k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 3d6f0a466a9e..f9f886289b97 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -328,9 +328,6 @@ static int ena_com_create_and_store_tx_meta_desc(struct ena_com_io_sq *io_sq,
 	 * compare it to the stored version, just create the meta
 	 */
 	if (io_sq->disable_meta_caching) {
-		if (unlikely(!ena_tx_ctx->meta_valid))
-			return -EINVAL;
-
 		*have_meta = true;
 		return ena_com_create_meta(io_sq, ena_meta);
 	}
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 08f4c7f66121..7d4b862be783 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -74,6 +74,8 @@ static void ena_unmap_tx_buff(struct ena_ring *tx_ring,
 			      struct ena_tx_buffer *tx_info);
 static int ena_create_io_tx_queues_in_range(struct ena_adapter *adapter,
 					    int first_index, int count);
+static void ena_free_all_io_tx_resources_in_range(struct ena_adapter *adapter,
+						  int first_index, int count);
 
 /* Increase a stat by cnt while holding syncp seqlock on 32bit machines */
 static void ena_increase_stat(u64 *statp, u64 cnt,
@@ -459,23 +461,22 @@ static void ena_init_all_xdp_queues(struct ena_adapter *adapter)
 
 static int ena_setup_and_create_all_xdp_queues(struct ena_adapter *adapter)
 {
+	u32 xdp_first_ring = adapter->xdp_first_ring;
+	u32 xdp_num_queues = adapter->xdp_num_queues;
 	int rc = 0;
 
-	rc = ena_setup_tx_resources_in_range(adapter, adapter->xdp_first_ring,
-					     adapter->xdp_num_queues);
+	rc = ena_setup_tx_resources_in_range(adapter, xdp_first_ring, xdp_num_queues);
 	if (rc)
 		goto setup_err;
 
-	rc = ena_create_io_tx_queues_in_range(adapter,
-					      adapter->xdp_first_ring,
-					      adapter->xdp_num_queues);
+	rc = ena_create_io_tx_queues_in_range(adapter, xdp_first_ring, xdp_num_queues);
 	if (rc)
 		goto create_err;
 
 	return 0;
 
 create_err:
-	ena_free_all_io_tx_resources(adapter);
+	ena_free_all_io_tx_resources_in_range(adapter, xdp_first_ring, xdp_num_queues);
 setup_err:
 	return rc;
 }
@@ -1625,20 +1626,23 @@ static void ena_set_rx_hash(struct ena_ring *rx_ring,
 	}
 }
 
-static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp)
+static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp, u16 num_descs)
 {
 	struct ena_rx_buffer *rx_info;
 	int ret;
 
+	/* XDP multi-buffer packets not supported */
+	if (unlikely(num_descs > 1)) {
+		netdev_err_once(rx_ring->adapter->netdev,
+				"xdp: dropped unsupported multi-buffer packets\n");
+		ena_increase_stat(&rx_ring->rx_stats.xdp_drop, 1, &rx_ring->syncp);
+		return ENA_XDP_DROP;
+	}
+
 	rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
 	xdp_prepare_buff(xdp, page_address(rx_info->page),
 			 rx_info->page_offset,
 			 rx_ring->ena_bufs[0].len, false);
-	/* If for some reason we received a bigger packet than
-	 * we expect, then we simply drop it
-	 */
-	if (unlikely(rx_ring->ena_bufs[0].len > ENA_XDP_MAX_MTU))
-		return ENA_XDP_DROP;
 
 	ret = ena_xdp_execute(rx_ring, xdp);
 
@@ -1707,7 +1711,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 			  ena_rx_ctx.l4_proto, ena_rx_ctx.hash);
 
 		if (ena_xdp_present_ring(rx_ring))
-			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp);
+			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp, ena_rx_ctx.descs);
 
 		/* allocate skb and fill it */
 		if (xdp_verdict == ENA_XDP_PASS)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e9c6f1fa0b1a..98e8997f8036 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -577,11 +577,14 @@ void aq_ring_free(struct aq_ring_s *self)
 		return;
 
 	kfree(self->buff_ring);
+	self->buff_ring = NULL;
 
-	if (self->dx_ring)
+	if (self->dx_ring) {
 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
 				  self->size * self->dx_size, self->dx_ring,
 				  self->dx_ring_pa);
+		self->dx_ring = NULL;
+	}
 }
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 4f669e7c7558..4509a29ff73f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -1924,8 +1924,7 @@ u16 bnx2x_select_queue(struct net_device *dev, struct sk_buff *skb,
 
 		/* Skip VLAN tag if present */
 		if (ether_type == ETH_P_8021Q) {
-			struct vlan_ethhdr *vhdr =
-				(struct vlan_ethhdr *)skb->data;
+			struct vlan_ethhdr *vhdr = skb_vlan_eth_hdr(skb);
 
 			ether_type = ntohs(vhdr->h_vlan_encapsulated_proto);
 		}
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index c14a3dbd075c..a61b368286e0 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1125,7 +1125,7 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 						  struct be_wrb_params
 						  *wrb_params)
 {
-	struct vlan_ethhdr *veh = (struct vlan_ethhdr *)skb->data;
+	struct vlan_ethhdr *veh = skb_vlan_eth_hdr(skb);
 	unsigned int eth_hdr_len;
 	struct iphdr *ip;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
index c39b866e2582..16d3c3610720 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
@@ -139,7 +139,8 @@ int dpaa2_switch_acl_entry_add(struct dpaa2_switch_filter_block *filter_block,
 	err = dpsw_acl_add_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				 filter_block->acl_id, acl_entry_cfg);
 
-	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
+	dma_unmap_single(dev, acl_entry_cfg->key_iova,
+			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE,
 			 DMA_TO_DEVICE);
 	if (err) {
 		dev_err(dev, "dpsw_acl_add_entry() failed %d\n", err);
@@ -181,8 +182,8 @@ dpaa2_switch_acl_entry_remove(struct dpaa2_switch_filter_block *block,
 	err = dpsw_acl_remove_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    block->acl_id, acl_entry_cfg);
 
-	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
-			 DMA_TO_DEVICE);
+	dma_unmap_single(dev, acl_entry_cfg->key_iova,
+			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE, DMA_TO_DEVICE);
 	if (err) {
 		dev_err(dev, "dpsw_acl_remove_entry() failed %d\n", err);
 		kfree(cmd_buff);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c0c96de7a9de..717d4bc5bac6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3436,31 +3436,26 @@ static int fec_set_features(struct net_device *netdev,
 	return 0;
 }
 
-static u16 fec_enet_get_raw_vlan_tci(struct sk_buff *skb)
-{
-	struct vlan_ethhdr *vhdr;
-	unsigned short vlan_TCI = 0;
-
-	if (skb->protocol == htons(ETH_P_ALL)) {
-		vhdr = (struct vlan_ethhdr *)(skb->data);
-		vlan_TCI = ntohs(vhdr->h_vlan_TCI);
-	}
-
-	return vlan_TCI;
-}
-
 static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
 				 struct net_device *sb_dev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u16 vlan_tag;
+	u16 vlan_tag = 0;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_AVB))
 		return netdev_pick_tx(ndev, skb, NULL);
 
-	vlan_tag = fec_enet_get_raw_vlan_tci(skb);
-	if (!vlan_tag)
+	/* VLAN is present in the payload.*/
+	if (eth_type_vlan(skb->protocol)) {
+		struct vlan_ethhdr *vhdr = skb_vlan_eth_hdr(skb);
+
+		vlan_tag = ntohs(vhdr->h_vlan_TCI);
+	/*  VLAN is present in the skb but not yet pushed in the payload.*/
+	} else if (skb_vlan_tag_present(skb)) {
+		vlan_tag = skb->vlan_tci;
+	} else {
 		return vlan_tag;
+	}
 
 	return fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 60e610ab976d..bbbafd8aa1b0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1512,7 +1512,7 @@ static int hns3_handle_vtags(struct hns3_enet_ring *tx_ring,
 	if (unlikely(rc < 0))
 		return rc;
 
-	vhdr = (struct vlan_ethhdr *)skb->data;
+	vhdr = skb_vlan_eth_hdr(skb);
 	vhdr->h_vlan_TCI |= cpu_to_be16((skb->priority << VLAN_PRIO_SHIFT)
 					 & VLAN_PRIO_MASK);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1d096141625e..cf8c3d480a4a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2975,7 +2975,7 @@ static inline int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 			rc = skb_cow_head(skb, 0);
 			if (rc < 0)
 				return rc;
-			vhdr = (struct vlan_ethhdr *)skb->data;
+			vhdr = skb_vlan_eth_hdr(skb);
 			vhdr->h_vlan_TCI = htons(tx_flags >>
 						 I40E_TX_FLAGS_VLAN_SHIFT);
 		} else {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index af824370a2f6..819169eaebe9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8696,7 +8696,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 
 			if (skb_cow_head(skb, 0))
 				goto out_drop;
-			vhdr = (struct vlan_ethhdr *)skb->data;
+			vhdr = skb_vlan_eth_hdr(skb);
 			vhdr->h_vlan_TCI = htons(tx_flags >>
 						 IXGBE_TX_FLAGS_VLAN_SHIFT);
 		} else {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index ba7ff776760d..40fbda152533 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -641,7 +641,7 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
 	if (!rvu_dl->devlink_wq)
-		goto err;
+		return -ENOMEM;
 
 	INIT_WORK(&rvu_reporters->intr_work, rvu_nix_intr_work);
 	INIT_WORK(&rvu_reporters->gen_work, rvu_nix_gen_work);
@@ -649,9 +649,6 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	INIT_WORK(&rvu_reporters->ras_work, rvu_nix_ras_work);
 
 	return 0;
-err:
-	rvu_nix_health_reporters_destroy(rvu_dl);
-	return -ENOMEM;
 }
 
 static int rvu_nix_health_reporters_create(struct rvu_devlink *rvu_dl)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index a3fd20d26b94..8b16738e249f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -664,6 +664,7 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	int blkaddr, ucast_idx, index;
 	struct nix_rx_action action = { 0 };
 	u64 relaxed_mask;
+	u8 flow_key_alg;
 
 	if (!hw->cap.nix_rx_multicast && is_cgx_vf(rvu, pcifunc))
 		return;
@@ -694,6 +695,8 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 		action.op = NIX_RX_ACTIONOP_UCAST;
 	}
 
+	flow_key_alg = action.flow_key_alg;
+
 	/* RX_ACTION set to MCAST for CGX PF's */
 	if (hw->cap.nix_rx_multicast && pfvf->use_mce_list &&
 	    is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc))) {
@@ -733,7 +736,7 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	req.vf = pcifunc;
 	req.index = action.index;
 	req.match_id = action.match_id;
-	req.flow_key_alg = action.flow_key_alg;
+	req.flow_key_alg = flow_key_alg;
 
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
@@ -839,6 +842,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	u8 mac_addr[ETH_ALEN] = { 0 };
 	struct nix_rx_action action = { 0 };
 	struct rvu_pfvf *pfvf;
+	u8 flow_key_alg;
 	u16 vf_func;
 
 	/* Only CGX PF/VF can add allmulticast entry */
@@ -865,6 +869,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
 							blkaddr, ucast_idx);
 
+	flow_key_alg = action.flow_key_alg;
 	if (action.op != NIX_RX_ACTIONOP_RSS) {
 		*(u64 *)&action = 0;
 		action.op = NIX_RX_ACTIONOP_UCAST;
@@ -901,7 +906,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	req.vf = pcifunc | vf_func;
 	req.index = action.index;
 	req.match_id = action.match_id;
-	req.flow_key_alg = action.flow_key_alg;
+	req.flow_key_alg = flow_key_alg;
 
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
@@ -967,11 +972,38 @@ static void npc_update_vf_flow_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	mutex_unlock(&mcam->lock);
 }
 
+static void npc_update_rx_action_with_alg_idx(struct rvu *rvu, struct nix_rx_action action,
+					      struct rvu_pfvf *pfvf, int mcam_index, int blkaddr,
+					      int alg_idx)
+
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_hwinfo *hw = rvu->hw;
+	int bank, op_rss;
+
+	if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, mcam_index))
+		return;
+
+	op_rss = (!hw->cap.nix_rx_multicast || !pfvf->use_mce_list);
+
+	bank = npc_get_bank(mcam, mcam_index);
+	mcam_index &= (mcam->banksize - 1);
+
+	/* If Rx action is MCAST update only RSS algorithm index */
+	if (!op_rss) {
+		*(u64 *)&action = rvu_read64(rvu, blkaddr,
+				NPC_AF_MCAMEX_BANKX_ACTION(mcam_index, bank));
+
+		action.flow_key_alg = alg_idx;
+	}
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_MCAMEX_BANKX_ACTION(mcam_index, bank), *(u64 *)&action);
+}
+
 void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 				    int group, int alg_idx, int mcam_index)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	struct rvu_hwinfo *hw = rvu->hw;
 	struct nix_rx_action action;
 	int blkaddr, index, bank;
 	struct rvu_pfvf *pfvf;
@@ -1027,15 +1059,16 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 	/* If PF's promiscuous entry is enabled,
 	 * Set RSS action for that entry as well
 	 */
-	if ((!hw->cap.nix_rx_multicast || !pfvf->use_mce_list) &&
-	    is_mcam_entry_enabled(rvu, mcam, blkaddr, index)) {
-		bank = npc_get_bank(mcam, index);
-		index &= (mcam->banksize - 1);
+	npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index, blkaddr,
+					  alg_idx);
 
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_MCAMEX_BANKX_ACTION(index, bank),
-			    *(u64 *)&action);
-	}
+	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
+					 nixlf, NIXLF_ALLMULTI_ENTRY);
+	/* If PF's allmulti  entry is enabled,
+	 * Set RSS action for that entry as well
+	 */
+	npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index, blkaddr,
+					  alg_idx);
 }
 
 void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 4eec574631c7..f9bb0e9e7359 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1589,6 +1589,21 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	mutex_unlock(&mbox->lock);
 }
 
+static bool otx2_promisc_use_mce_list(struct otx2_nic *pfvf)
+{
+	int vf;
+
+	/* The AF driver will determine whether to allow the VF netdev or not */
+	if (is_otx2_vf(pfvf->pcifunc))
+		return true;
+
+	/* check if there are any trusted VFs associated with the PF netdev */
+	for (vf = 0; vf < pci_num_vf(pfvf->pdev); vf++)
+		if (pfvf->vf_configs[vf].trusted)
+			return true;
+	return false;
+}
+
 static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 {
 	struct net_device *netdev = pf->netdev;
@@ -1621,7 +1636,8 @@ static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 	if (netdev->flags & (IFF_ALLMULTI | IFF_MULTICAST))
 		req->mode |= NIX_RX_MODE_ALLMULTI;
 
-	req->mode |= NIX_RX_MODE_USE_MCE;
+	if (otx2_promisc_use_mce_list(pf))
+		req->mode |= NIX_RX_MODE_USE_MCE;
 
 	otx2_sync_mbox_msg(&pf->mbox);
 	mutex_unlock(&pf->mbox.lock);
@@ -2440,11 +2456,14 @@ static int otx2_ndo_set_vf_trust(struct net_device *netdev, int vf,
 	pf->vf_configs[vf].trusted = enable;
 	rc = otx2_set_vf_permissions(pf, vf, OTX2_TRUSTED_VF);
 
-	if (rc)
+	if (rc) {
 		pf->vf_configs[vf].trusted = !enable;
-	else
+	} else {
 		netdev_info(pf->netdev, "VF %d is %strusted\n",
 			    vf, enable ? "" : "not ");
+		otx2_set_rx_mode(netdev);
+	}
+
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 344ea1143454..ed14d7a4d867 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -1861,7 +1861,7 @@ netxen_tso_check(struct net_device *netdev,
 
 	if (protocol == cpu_to_be16(ETH_P_8021Q)) {
 
-		vh = (struct vlan_ethhdr *)skb->data;
+		vh = skb_vlan_eth_hdr(skb);
 		protocol = vh->h_vlan_encapsulated_proto;
 		flags = FLAGS_VLAN_TAGGED;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index cb0f2a3a1ac9..7d8401da6f22 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -933,6 +933,7 @@ static void qed_ilt_shadow_free(struct qed_hwfn *p_hwfn)
 		p_dma->virt_addr = NULL;
 	}
 	kfree(p_mngr->ilt_shadow);
+	p_mngr->ilt_shadow = NULL;
 }
 
 static int qed_ilt_blk_alloc(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 29cdcb2285b1..4c511f4a99ce 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -317,7 +317,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 
 	if (adapter->flags & QLCNIC_VLAN_FILTERING) {
 		if (protocol == ETH_P_8021Q) {
-			vh = (struct vlan_ethhdr *)skb->data;
+			vh = skb_vlan_eth_hdr(skb);
 			vlan_id = ntohs(vh->h_vlan_TCI);
 		} else if (skb_vlan_tag_present(skb)) {
 			vlan_id = skb_vlan_tag_get(skb);
@@ -467,7 +467,7 @@ static int qlcnic_tx_pkt(struct qlcnic_adapter *adapter,
 	u32 producer = tx_ring->producer;
 
 	if (protocol == ETH_P_8021Q) {
-		vh = (struct vlan_ethhdr *)skb->data;
+		vh = skb_vlan_eth_hdr(skb);
 		flags = QLCNIC_FLAGS_VLAN_TAGGED;
 		vlan_tci = ntohs(vh->h_vlan_TCI);
 		protocol = ntohs(vh->h_vlan_encapsulated_proto);
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethernet/qualcomm/qca_debug.c
index d59fff2fbcc6..8b61bebd96e4 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -30,6 +30,8 @@
 
 #define QCASPI_MAX_REGS 0x20
 
+#define QCASPI_RX_MAX_FRAMES 4
+
 static const u16 qcaspi_spi_regs[] = {
 	SPI_REG_BFR_SIZE,
 	SPI_REG_WRBUF_SPC_AVA,
@@ -250,31 +252,30 @@ qcaspi_get_ringparam(struct net_device *dev, struct ethtool_ringparam *ring)
 {
 	struct qcaspi *qca = netdev_priv(dev);
 
-	ring->rx_max_pending = 4;
+	ring->rx_max_pending = QCASPI_RX_MAX_FRAMES;
 	ring->tx_max_pending = TX_RING_MAX_LEN;
-	ring->rx_pending = 4;
+	ring->rx_pending = QCASPI_RX_MAX_FRAMES;
 	ring->tx_pending = qca->txr.count;
 }
 
 static int
 qcaspi_set_ringparam(struct net_device *dev, struct ethtool_ringparam *ring)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct qcaspi *qca = netdev_priv(dev);
 
-	if ((ring->rx_pending) ||
+	if (ring->rx_pending != QCASPI_RX_MAX_FRAMES ||
 	    (ring->rx_mini_pending) ||
 	    (ring->rx_jumbo_pending))
 		return -EINVAL;
 
-	if (netif_running(dev))
-		ops->ndo_stop(dev);
+	if (qca->spi_thread)
+		kthread_park(qca->spi_thread);
 
 	qca->txr.count = max_t(u32, ring->tx_pending, TX_RING_MIN_LEN);
 	qca->txr.count = min_t(u16, qca->txr.count, TX_RING_MAX_LEN);
 
-	if (netif_running(dev))
-		ops->ndo_open(dev);
+	if (qca->spi_thread)
+		kthread_unpark(qca->spi_thread);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index a047bab1d7c7..e02f6ac0125d 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -581,6 +581,18 @@ qcaspi_spi_thread(void *data)
 	netdev_info(qca->net_dev, "SPI thread created\n");
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_park()) {
+			netif_tx_disable(qca->net_dev);
+			netif_carrier_off(qca->net_dev);
+			qcaspi_flush_tx_ring(qca);
+			kthread_parkme();
+			if (qca->sync == QCASPI_SYNC_READY) {
+				netif_carrier_on(qca->net_dev);
+				netif_wake_queue(qca->net_dev);
+			}
+			continue;
+		}
+
 		if ((qca->intr_req == qca->intr_svc) &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();
@@ -609,11 +621,17 @@ qcaspi_spi_thread(void *data)
 			if (intr_cause & SPI_INT_CPU_ON) {
 				qcaspi_qca7k_sync(qca, QCASPI_EVENT_CPUON);
 
+				/* Frame decoding in progress */
+				if (qca->frm_handle.state != qca->frm_handle.init)
+					qca->net_dev->stats.rx_dropped++;
+
+				qcafrm_fsm_init_spi(&qca->frm_handle);
+				qca->stats.device_reset++;
+
 				/* not synced. */
 				if (qca->sync != QCASPI_SYNC_READY)
 					continue;
 
-				qca->stats.device_reset++;
 				netif_wake_queue(qca->net_dev);
 				netif_carrier_on(qca->net_dev);
 			}
diff --git a/drivers/net/ethernet/sfc/tx_tso.c b/drivers/net/ethernet/sfc/tx_tso.c
index 898e5c61d908..d381d8164f07 100644
--- a/drivers/net/ethernet/sfc/tx_tso.c
+++ b/drivers/net/ethernet/sfc/tx_tso.c
@@ -147,7 +147,7 @@ static __be16 efx_tso_check_protocol(struct sk_buff *skb)
 	EFX_WARN_ON_ONCE_PARANOID(((struct ethhdr *)skb->data)->h_proto !=
 				  protocol);
 	if (protocol == htons(ETH_P_8021Q)) {
-		struct vlan_ethhdr *veh = (struct vlan_ethhdr *)skb->data;
+		struct vlan_ethhdr *veh = skb_vlan_eth_hdr(skb);
 
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 929cfc22cd0c..d19844be9fe5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -253,7 +253,7 @@ config DWMAC_INTEL
 config DWMAC_LOONGSON
 	tristate "Loongson PCI DWMAC support"
 	default MACH_LOONGSON64
-	depends on STMMAC_ETH && PCI
+	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
 	depends on COMMON_CLK
 	help
 	  This selects the LOONGSON PCI bus support for the stmmac driver,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2ae59f94afe1..cef9734ef259 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -68,17 +68,15 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	if (!plat)
 		return -ENOMEM;
 
+	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
+					   sizeof(*plat->mdio_bus_data),
+					   GFP_KERNEL);
+	if (!plat->mdio_bus_data)
+		return -ENOMEM;
+
 	plat->mdio_node = of_get_child_by_name(np, "mdio");
 	if (plat->mdio_node) {
 		dev_info(&pdev->dev, "Found MDIO subnode\n");
-
-		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
-						   sizeof(*plat->mdio_bus_data),
-						   GFP_KERNEL);
-		if (!plat->mdio_bus_data) {
-			ret = -ENOMEM;
-			goto err_put_node;
-		}
 		plat->mdio_bus_data->needs_reset = true;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7042abc6979a..08693d7458d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4494,13 +4494,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 {
-	struct vlan_ethhdr *veth;
-	__be16 vlan_proto;
+	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
+	__be16 vlan_proto = veth->h_vlan_proto;
 	u16 vlanid;
 
-	veth = (struct vlan_ethhdr *)skb->data;
-	vlan_proto = veth->h_vlan_proto;
-
 	if ((vlan_proto == htons(ETH_P_8021Q) &&
 	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
 	    (vlan_proto == htons(ETH_P_8021AD) &&
@@ -7242,9 +7239,9 @@ int stmmac_dvr_probe(struct device *device,
 		/* MDIO bus Registration */
 		ret = stmmac_mdio_register(ndev);
 		if (ret < 0) {
-			dev_err(priv->device,
-				"%s: MDIO bus (id: %d) registration failed",
-				__func__, priv->plat->bus_id);
+			dev_err_probe(priv->device, ret,
+				      "%s: MDIO bus (id: %d) registration failed\n",
+				      __func__, priv->plat->bus_id);
 			goto error_mdio_register;
 		}
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index a5d150c5f3d8..94f731f1d936 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -489,8 +489,12 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
-		dev_err(dev, "Cannot register the MDIO bus\n");
+	if (err == -ENODEV) {
+		err = 0;
+		dev_info(dev, "MDIO bus is disabled\n");
+		goto bus_register_fail;
+	} else if (err) {
+		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}
 
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 44275094906c..8edfc8984e2c 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -285,8 +285,10 @@ static int __team_options_register(struct team *team,
 	return 0;
 
 inst_rollback:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		__team_option_inst_del_option(team, dst_opts[i]);
+		list_del(&dst_opts[i]->list);
+	}
 
 	i = option_count;
 alloc_rollback:
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index e8d49886d695..bc5e3f45c499 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1079,17 +1079,17 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	u16 pkt_count = 0;
 	u64 desc_hdr = 0;
 	u16 vlan_tag = 0;
-	u32 skb_len = 0;
+	u32 skb_len;
 
 	if (!skb)
 		goto err;
 
-	if (skb->len == 0)
+	skb_len = skb->len;
+	if (skb_len < sizeof(desc_hdr))
 		goto err;
 
-	skb_len = skb->len;
 	/* RX Descriptor Header */
-	skb_trim(skb, skb->len - sizeof(desc_hdr));
+	skb_trim(skb, skb_len - sizeof(desc_hdr));
 	desc_hdr = le64_to_cpup((u64 *)skb_tail_pointer(skb));
 
 	/* Check these packets */
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 5c516bf4d3a5..846ace9830d3 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1286,6 +1286,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x19d2, 0x0168, 4)},
 	{QMI_FIXED_INTF(0x19d2, 0x0176, 3)},
 	{QMI_FIXED_INTF(0x19d2, 0x0178, 3)},
+	{QMI_FIXED_INTF(0x19d2, 0x0189, 4)},    /* ZTE MF290 */
 	{QMI_FIXED_INTF(0x19d2, 0x0191, 4)},	/* ZTE EuFi890 */
 	{QMI_FIXED_INTF(0x19d2, 0x0199, 1)},	/* ZTE MF820S */
 	{QMI_FIXED_INTF(0x19d2, 0x0200, 1)},
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 54779caf18f9..e8fd743a1509 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8281,43 +8281,6 @@ static bool rtl_check_vendor_ok(struct usb_interface *intf)
 	return true;
 }
 
-static bool rtl_vendor_mode(struct usb_interface *intf)
-{
-	struct usb_host_interface *alt = intf->cur_altsetting;
-	struct usb_device *udev;
-	struct usb_host_config *c;
-	int i, num_configs;
-
-	if (alt->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC)
-		return rtl_check_vendor_ok(intf);
-
-	/* The vendor mode is not always config #1, so to find it out. */
-	udev = interface_to_usbdev(intf);
-	c = udev->config;
-	num_configs = udev->descriptor.bNumConfigurations;
-	if (num_configs < 2)
-		return false;
-
-	for (i = 0; i < num_configs; (i++, c++)) {
-		struct usb_interface_descriptor	*desc = NULL;
-
-		if (c->desc.bNumInterfaces > 0)
-			desc = &c->intf_cache[0]->altsetting->desc;
-		else
-			continue;
-
-		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
-			usb_driver_set_configuration(udev, c->desc.bConfigurationValue);
-			break;
-		}
-	}
-
-	if (i == num_configs)
-		dev_err(&intf->dev, "Unexpected Device\n");
-
-	return false;
-}
-
 static int rtl8152_pre_reset(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
@@ -9545,9 +9508,8 @@ static int rtl_fw_init(struct r8152 *tp)
 	return 0;
 }
 
-u8 rtl8152_get_version(struct usb_interface *intf)
+static u8 __rtl_get_hw_ver(struct usb_device *udev)
 {
-	struct usb_device *udev = interface_to_usbdev(intf);
 	u32 ocp_data = 0;
 	__le32 *tmp;
 	u8 version;
@@ -9617,10 +9579,19 @@ u8 rtl8152_get_version(struct usb_interface *intf)
 		break;
 	default:
 		version = RTL_VER_UNKNOWN;
-		dev_info(&intf->dev, "Unknown version 0x%04x\n", ocp_data);
+		dev_info(&udev->dev, "Unknown version 0x%04x\n", ocp_data);
 		break;
 	}
 
+	return version;
+}
+
+u8 rtl8152_get_version(struct usb_interface *intf)
+{
+	u8 version;
+
+	version = __rtl_get_hw_ver(interface_to_usbdev(intf));
+
 	dev_dbg(&intf->dev, "Detected version 0x%04x\n", version);
 
 	return version;
@@ -9639,7 +9610,10 @@ static int rtl8152_probe(struct usb_interface *intf,
 	if (version == RTL_VER_UNKNOWN)
 		return -ENODEV;
 
-	if (!rtl_vendor_mode(intf))
+	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
+		return -ENODEV;
+
+	if (!rtl_check_vendor_ok(intf))
 		return -ENODEV;
 
 	usb_reset_device(udev);
@@ -9848,43 +9822,37 @@ static void rtl8152_disconnect(struct usb_interface *intf)
 	}
 }
 
-#define REALTEK_USB_DEVICE(vend, prod)	{ \
-	USB_DEVICE_INTERFACE_CLASS(vend, prod, USB_CLASS_VENDOR_SPEC), \
-}, \
-{ \
-	USB_DEVICE_AND_INTERFACE_INFO(vend, prod, USB_CLASS_COMM, \
-			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE), \
-}
-
 /* table of devices that work with this driver */
 static const struct usb_device_id rtl8152_table[] = {
 	/* Realtek */
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8050),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8053),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8152),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8153),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8155),
-	REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8156),
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8050) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8053) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8152) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8153) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8155) },
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x8156) },
 
 	/* Microsoft */
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab),
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07c6),
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927),
-	REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e),
-	REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3054),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3062),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3069),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3082),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7205),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x720c),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7214),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x721e),
-	REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0xa387),
-	REALTEK_USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041),
-	REALTEK_USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff),
-	REALTEK_USB_DEVICE(VENDOR_ID_TPLINK,  0x0601),
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab) },
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07c6) },
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
+	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
+	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
+	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
+	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
+	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
+	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
 
@@ -9904,7 +9872,68 @@ static struct usb_driver rtl8152_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(rtl8152_driver);
+static int rtl8152_cfgselector_probe(struct usb_device *udev)
+{
+	struct usb_host_config *c;
+	int i, num_configs;
+
+	/* Switch the device to vendor mode, if and only if the vendor mode
+	 * driver supports it.
+	 */
+	if (__rtl_get_hw_ver(udev) == RTL_VER_UNKNOWN)
+		return 0;
+
+	/* The vendor mode is not always config #1, so to find it out. */
+	c = udev->config;
+	num_configs = udev->descriptor.bNumConfigurations;
+	for (i = 0; i < num_configs; (i++, c++)) {
+		struct usb_interface_descriptor	*desc = NULL;
+
+		if (!c->desc.bNumInterfaces)
+			continue;
+		desc = &c->intf_cache[0]->altsetting->desc;
+		if (desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC)
+			break;
+	}
+
+	if (i == num_configs)
+		return -ENODEV;
+
+	if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
+		dev_err(&udev->dev, "Failed to set configuration %d\n",
+			c->desc.bConfigurationValue);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct usb_device_driver rtl8152_cfgselector_driver = {
+	.name =		MODULENAME "-cfgselector",
+	.probe =	rtl8152_cfgselector_probe,
+	.id_table =	rtl8152_table,
+	.generic_subclass = 1,
+	.supports_autosuspend = 1,
+};
+
+static int __init rtl8152_driver_init(void)
+{
+	int ret;
+
+	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
+	if (ret)
+		return ret;
+	return usb_register(&rtl8152_driver);
+}
+
+static void __exit rtl8152_driver_exit(void)
+{
+	usb_deregister(&rtl8152_driver);
+	usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+}
+
+module_init(rtl8152_driver_init);
+module_exit(rtl8152_driver_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index e73e18a73833..8b40b45590a0 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -65,13 +65,49 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
+/*
+ * Some Loongson PCIe ports have hardware limitations on their Maximum Read
+ * Request Size. They can't handle anything larger than this.  Sane
+ * firmware will set proper MRRS at boot, so we only need no_inc_mrrs for
+ * bridges. However, some MIPS Loongson firmware doesn't set MRRS properly,
+ * so we have to enforce maximum safe MRRS, which is 256 bytes.
+ */
+#ifdef CONFIG_MIPS
+static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
+{
+	struct pci_bus *bus = pdev->bus;
+	struct pci_dev *bridge;
+	static const struct pci_device_id bridge_devids[] = {
+		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
+		{ 0, },
+	};
+
+	/* look for the matching bridge */
+	while (!pci_is_root_bus(bus)) {
+		bridge = bus->self;
+		bus = bus->parent;
+
+		if (pci_match_id(bridge_devids, bridge)) {
+			if (pcie_get_readrq(pdev) > 256) {
+				pci_info(pdev, "limiting MRRS to 256\n");
+				pcie_set_readrq(pdev, 256);
+			}
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_set_min_mrrs_quirk);
+#endif
+
 static void loongson_mrrs_quirk(struct pci_dev *pdev)
 {
-	/*
-	 * Some Loongson PCIe ports have h/w limitations of maximum read
-	 * request size. They can't handle anything larger than this. So
-	 * force this limit on any devices attached under these ports.
-	 */
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 
 	bridge->no_inc_mrrs = 1;
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 0a37967b0a93..f031302ad401 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -503,15 +503,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					if (pci_is_root_bus(bus))
-						__pci_bus_size_bridges(dev->subordinate, &add_list);
+					__pci_bus_size_bridges(dev->subordinate,
+							       &add_list);
 				}
 			}
 		}
-		if (pci_is_root_bus(bus))
-			__pci_bus_assign_resources(bus, &add_list, NULL);
-		else
-			pci_assign_unassigned_bridge_resources(bus->self);
+		__pci_bus_assign_resources(bus, &add_list, NULL);
 	}
 
 	acpiphp_sanitize_bus(bus);
diff --git a/drivers/platform/x86/intel/telemetry/core.c b/drivers/platform/x86/intel/telemetry/core.c
index fdf55b5d6948..e4be40f73eeb 100644
--- a/drivers/platform/x86/intel/telemetry/core.c
+++ b/drivers/platform/x86/intel/telemetry/core.c
@@ -102,7 +102,7 @@ static const struct telemetry_core_ops telm_defpltops = {
 /**
  * telemetry_update_events() - Update telemetry Configuration
  * @pss_evtconfig: PSS related config. No change if num_evts = 0.
- * @pss_evtconfig: IOSS related config. No change if num_evts = 0.
+ * @ioss_evtconfig: IOSS related config. No change if num_evts = 0.
  *
  * This API updates the IOSS & PSS Telemetry configuration. Old config
  * is overwritten. Call telemetry_reset_events when logging is over
@@ -176,7 +176,7 @@ EXPORT_SYMBOL_GPL(telemetry_reset_events);
 /**
  * telemetry_get_eventconfig() - Returns the pss and ioss events enabled
  * @pss_evtconfig: Pointer to PSS related configuration.
- * @pss_evtconfig: Pointer to IOSS related configuration.
+ * @ioss_evtconfig: Pointer to IOSS related configuration.
  * @pss_len:	   Number of u32 elements allocated for pss_evtconfig array
  * @ioss_len:	   Number of u32 elements allocated for ioss_evtconfig array
  *
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 2a900aa302a3..8f9f4ee7860c 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -744,14 +744,15 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
  * sdw_ml_sync_bank_switch: Multilink register bank switch
  *
  * @bus: SDW bus instance
+ * @multi_link: whether this is a multi-link stream with hardware-based sync
  *
  * Caller function should free the buffers on error
  */
-static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
+static int sdw_ml_sync_bank_switch(struct sdw_bus *bus, bool multi_link)
 {
 	unsigned long time_left;
 
-	if (!bus->multi_link)
+	if (!multi_link)
 		return 0;
 
 	/* Wait for completion of transfer */
@@ -847,7 +848,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			bus->bank_switch_timeout = DEFAULT_BANK_SWITCH_TIMEOUT;
 
 		/* Check if bank switch was successful */
-		ret = sdw_ml_sync_bank_switch(bus);
+		ret = sdw_ml_sync_bank_switch(bus, multi_link);
 		if (ret < 0) {
 			dev_err(bus->dev,
 				"multi link bank switch failed: %d\n", ret);
diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 3c680ed4429c..1f0283fc1d2c 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -350,7 +350,7 @@ static s32 gdm_lte_tx_nic_type(struct net_device *dev, struct sk_buff *skb)
 	/* Get ethernet protocol */
 	eth = (struct ethhdr *)skb->data;
 	if (ntohs(eth->h_proto) == ETH_P_8021Q) {
-		vlan_eth = (struct vlan_ethhdr *)skb->data;
+		vlan_eth = skb_vlan_eth_hdr(skb);
 		mac_proto = ntohs(vlan_eth->h_vlan_encapsulated_proto);
 		network_data = skb->data + VLAN_ETH_HLEN;
 		nic_type |= NIC_TYPE_F_VLAN;
@@ -436,7 +436,7 @@ static netdev_tx_t gdm_lte_tx(struct sk_buff *skb, struct net_device *dev)
 	 * driver based on the NIC mac
 	 */
 	if (nic_type & NIC_TYPE_F_VLAN) {
-		struct vlan_ethhdr *vlan_eth = (struct vlan_ethhdr *)skb->data;
+		struct vlan_ethhdr *vlan_eth = skb_vlan_eth_hdr(skb);
 
 		nic->vlan_id = ntohs(vlan_eth->h_vlan_TCI) & VLAN_VID_MASK;
 		data_buf = skb->data + (VLAN_ETH_HLEN - ETH_HLEN);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 6c05a3a9b542..4f50a8e18d91 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1451,8 +1451,6 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
 			udc->driver->function);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-
 	usb_gadget_disconnect(udc->gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (udc->gadget->irq)
@@ -1462,6 +1460,8 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 
 	udc->driver = NULL;
 	udc->gadget->dev.driver = NULL;
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 }
 
 /**
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index e3de7fea3643..f7305f2791fe 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -420,7 +420,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	if (call->async) {
 		if (cancel_work_sync(&call->async_work))
 			afs_put_call(call);
-		afs_put_call(call);
+		afs_set_call_complete(call, ret, 0);
 	}
 
 	ac->error = ret;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f93d15833f9d..233e465647fd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1855,6 +1855,15 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
+		} else if (btrfs_ino(BTRFS_I(src_inode)) != BTRFS_FIRST_FREE_OBJECTID) {
+			/*
+			 * Snapshots must be made with the src_inode referring
+			 * to the subvolume inode, otherwise the permission
+			 * checking above is useless because we may have
+			 * permission on a lower directory but not the subvol
+			 * itself.
+			 */
+			ret = -EINVAL;
 		} else {
 			ret = btrfs_mksnapshot(&file->f_path, mnt_userns,
 					       name, namelen,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f3dc84ff0efa..e44c28ceb9cd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4137,6 +4137,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
 			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
 
+	/* avoid unnecessary preallocation that may trigger assertions */
+	if (start + size > EXT_MAX_BLOCKS)
+		size = EXT_MAX_BLOCKS - start;
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 281d79f8b3d3..3e7aafe2e953 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1227,6 +1227,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
 	if (fc->dax) {
 		fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
 		kfree(fc->dax);
+		fc->dax = NULL;
 	}
 }
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 656c627d1bdf..a7973b7012e9 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7068,6 +7068,7 @@ int smb2_lock(struct ksmbd_work *work)
 						      smb2_remove_blocked_lock,
 						      argv);
 				if (rc) {
+					kfree(argv);
 					err = -ENOMEM;
 					goto out;
 				}
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..95cfcfb8a3b4 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -41,7 +41,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !atomic_read(&lock.val);
+	return !lock.val.counter;
 }
 
 /**
diff --git a/include/linux/cred.h b/include/linux/cred.h
index fcbc6885cc09..5e0fa7f25cf6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -108,7 +108,7 @@ static inline int groups_search(const struct group_info *group_info, kgid_t grp)
  * same context as task->real_cred.
  */
 struct cred {
-	atomic_t	usage;
+	atomic_long_t	usage;
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	atomic_t	subscribers;	/* number of processes subscribed */
 	void		*put_addr;
@@ -228,7 +228,7 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
+	atomic_long_inc(&cred->usage);
 	return cred;
 }
 
@@ -260,7 +260,7 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
-	if (!atomic_inc_not_zero(&nonconst_cred->usage))
+	if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	validate_creds(cred);
 	nonconst_cred->non_rcu = 0;
@@ -284,7 +284,7 @@ static inline void put_cred(const struct cred *_cred)
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (atomic_long_dec_and_test(&(cred)->usage))
 			__put_cred(cred);
 	}
 }
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4e7e72f3da5b..ce6714bec65f 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -60,6 +60,14 @@ static inline struct vlan_ethhdr *vlan_eth_hdr(const struct sk_buff *skb)
 	return (struct vlan_ethhdr *)skb_mac_header(skb);
 }
 
+/* Prefer this version in TX path, instead of
+ * skb_reset_mac_header() + vlan_eth_hdr()
+ */
+static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_buff *skb)
+{
+	return (struct vlan_ethhdr *)skb->data;
+}
+
 #define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
 #define VLAN_PRIO_SHIFT		13
 #define VLAN_CFI_MASK		0x1000 /* Canonical Format Indicator / Drop Eligible Indicator */
@@ -526,7 +534,7 @@ static inline void __vlan_hwaccel_put_tag(struct sk_buff *skb,
  */
 static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 {
-	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb->data;
+	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
 
 	if (!eth_type_vlan(veth->h_vlan_proto))
 		return -EINVAL;
@@ -727,7 +735,7 @@ static inline bool skb_vlan_tagged_multi(struct sk_buff *skb)
 		if (unlikely(!pskb_may_pull(skb, VLAN_ETH_HLEN)))
 			return false;
 
-		veh = (struct vlan_ethhdr *)skb->data;
+		veh = skb_vlan_eth_hdr(skb);
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5df38332e413..307cab05d67e 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -100,7 +100,8 @@ static inline void memblock_discard(void) {}
 #endif
 
 void memblock_allow_resize(void);
-int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
+int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
+		      enum memblock_flags flags);
 int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_free(phys_addr_t base, phys_addr_t size);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a27a6b58d374..5692055f202c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2454,7 +2454,7 @@ static inline unsigned long get_num_physpages(void)
  * unsigned long max_zone_pfns[MAX_NR_ZONES] = {max_dma, max_normal_pfn,
  * 							 max_highmem_pfn};
  * for_each_valid_physical_page_range()
- * 	memblock_add_node(base, size, nid)
+ *	memblock_add_node(base, size, nid, MEMBLOCK_NONE)
  * free_area_init(max_zone_pfns);
  */
 void free_area_init(unsigned long *max_zone_pfn);
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 20d88b1defc3..33a4c146dc19 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -29,6 +29,8 @@
 #define VENDOR_ID_LINKSYS		0x13b1
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
+#define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 53627afab104..700a19e0455e 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -31,17 +31,22 @@ struct prefix_info {
 	__u8			length;
 	__u8			prefix_len;
 
+	union __packed {
+		__u8		flags;
+		struct __packed {
 #if defined(__BIG_ENDIAN_BITFIELD)
-	__u8			onlink : 1,
+			__u8	onlink : 1,
 			 	autoconf : 1,
 				reserved : 6;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8			reserved : 6,
+			__u8	reserved : 6,
 				autoconf : 1,
 				onlink : 1;
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
+		};
+	};
 	__be32			valid;
 	__be32			prefered;
 	__be32			reserved2;
@@ -49,6 +54,9 @@ struct prefix_info {
 	struct in6_addr		prefix;
 };
 
+/* rfc4861 4.6.2: IPv6 PIO is 32 bytes in size */
+static_assert(sizeof(struct prefix_info) == 32);
+
 #include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <net/if_inet6.h>
diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index 8ec0878a90a7..4f3e77e7581b 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -22,10 +22,6 @@
 #define IF_RS_SENT	0x10
 #define IF_READY	0x80000000
 
-/* prefix flags */
-#define IF_PREFIX_ONLINK	0x01
-#define IF_PREFIX_AUTOCONF	0x02
-
 enum {
 	INET6_IFADDR_STATE_PREDAD,
 	INET6_IFADDR_STATE_DAD,
diff --git a/kernel/cred.c b/kernel/cred.c
index 933155c96922..925211466616 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -99,17 +99,17 @@ static void put_cred_rcu(struct rcu_head *rcu)
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	if (cred->magic != CRED_MAGIC_DEAD ||
-	    atomic_read(&cred->usage) != 0 ||
+	    atomic_long_read(&cred->usage) != 0 ||
 	    read_cred_subscribers(cred) != 0)
 		panic("CRED: put_cred_rcu() sees %p with"
-		      " mag %x, put %p, usage %d, subscr %d\n",
+		      " mag %x, put %p, usage %ld, subscr %d\n",
 		      cred, cred->magic, cred->put_addr,
-		      atomic_read(&cred->usage),
+		      atomic_long_read(&cred->usage),
 		      read_cred_subscribers(cred));
 #else
-	if (atomic_read(&cred->usage) != 0)
-		panic("CRED: put_cred_rcu() sees %p with usage %d\n",
-		      cred, atomic_read(&cred->usage));
+	if (atomic_long_read(&cred->usage) != 0)
+		panic("CRED: put_cred_rcu() sees %p with usage %ld\n",
+		      cred, atomic_long_read(&cred->usage));
 #endif
 
 	security_cred_free(cred);
@@ -134,11 +134,11 @@ static void put_cred_rcu(struct rcu_head *rcu)
  */
 void __put_cred(struct cred *cred)
 {
-	kdebug("__put_cred(%p{%d,%d})", cred,
-	       atomic_read(&cred->usage),
+	kdebug("__put_cred(%p{%ld,%d})", cred,
+	       atomic_long_read(&cred->usage),
 	       read_cred_subscribers(cred));
 
-	BUG_ON(atomic_read(&cred->usage) != 0);
+	BUG_ON(atomic_long_read(&cred->usage) != 0);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(cred) != 0);
 	cred->magic = CRED_MAGIC_DEAD;
@@ -161,8 +161,8 @@ void exit_creds(struct task_struct *tsk)
 {
 	struct cred *cred;
 
-	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	kdebug("exit_creds(%u,%p,%p,{%ld,%d})", tsk->pid, tsk->real_cred, tsk->cred,
+	       atomic_long_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	cred = (struct cred *) tsk->real_cred;
@@ -221,7 +221,7 @@ struct cred *cred_alloc_blank(void)
 	if (!new)
 		return NULL;
 
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
@@ -267,7 +267,7 @@ struct cred *prepare_creds(void)
 	memcpy(new, old, sizeof(struct cred));
 
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -355,8 +355,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		p->real_cred = get_cred(p->cred);
 		get_cred(p->cred);
 		alter_cred_subscribers(p->cred, 2);
-		kdebug("share_creds(%p{%d,%d})",
-		       p->cred, atomic_read(&p->cred->usage),
+		kdebug("share_creds(%p{%ld,%d})",
+		       p->cred, atomic_long_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
 		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 		return 0;
@@ -449,8 +449,8 @@ int commit_creds(struct cred *new)
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
 
-	kdebug("commit_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("commit_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	BUG_ON(task->cred != old);
@@ -459,7 +459,7 @@ int commit_creds(struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(atomic_long_read(&new->usage) < 1);
 
 	get_cred(new); /* we will require a ref for the subj creds too */
 
@@ -532,14 +532,14 @@ EXPORT_SYMBOL(commit_creds);
  */
 void abort_creds(struct cred *new)
 {
-	kdebug("abort_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("abort_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(new) != 0);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(atomic_long_read(&new->usage) < 1);
 	put_cred(new);
 }
 EXPORT_SYMBOL(abort_creds);
@@ -555,8 +555,8 @@ const struct cred *override_creds(const struct cred *new)
 {
 	const struct cred *old = current->cred;
 
-	kdebug("override_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("override_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	validate_creds(old);
@@ -578,8 +578,8 @@ const struct cred *override_creds(const struct cred *new)
 	rcu_assign_pointer(current->cred, new);
 	alter_cred_subscribers(old, -1);
 
-	kdebug("override_creds() = %p{%d,%d}", old,
-	       atomic_read(&old->usage),
+	kdebug("override_creds() = %p{%ld,%d}", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 	return old;
 }
@@ -596,8 +596,8 @@ void revert_creds(const struct cred *old)
 {
 	const struct cred *override = current->cred;
 
-	kdebug("revert_creds(%p{%d,%d})", old,
-	       atomic_read(&old->usage),
+	kdebug("revert_creds(%p{%ld,%d})", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 
 	validate_creds(old);
@@ -729,7 +729,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 
 	*new = *old;
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
@@ -843,8 +843,8 @@ static void dump_invalid_creds(const struct cred *cred, const char *label,
 	       cred == tsk->cred ? "[eff]" : "");
 	printk(KERN_ERR "CRED: ->magic=%x, put_addr=%p\n",
 	       cred->magic, cred->put_addr);
-	printk(KERN_ERR "CRED: ->usage=%d, subscr=%d\n",
-	       atomic_read(&cred->usage),
+	printk(KERN_ERR "CRED: ->usage=%ld, subscr=%d\n",
+	       atomic_long_read(&cred->usage),
 	       read_cred_subscribers(cred));
 	printk(KERN_ERR "CRED: ->*uid = { %d,%d,%d,%d }\n",
 		from_kuid_munged(&init_user_ns, cred->uid),
@@ -916,9 +916,9 @@ EXPORT_SYMBOL(__validate_process_creds);
  */
 void validate_creds_for_do_exit(struct task_struct *tsk)
 {
-	kdebug("validate_creds_for_do_exit(%p,%p{%d,%d})",
+	kdebug("validate_creds_for_do_exit(%p,%p{%ld,%d})",
 	       tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       atomic_long_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	__validate_process_creds(tsk, __FILE__, __LINE__);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 521d64b355ef..ada7ef0eb639 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2032,6 +2032,16 @@ static bool perf_event_validate_size(struct perf_event *event)
 				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	/*
+	 * When creating a new group leader, group_leader->ctx is initialized
+	 * after the size has been validated, but we cannot safely use
+	 * for_each_sibling_event() until group_leader->ctx is set. A new group
+	 * leader cannot have any siblings yet, so we can safely skip checking
+	 * the non-existent siblings.
+	 */
+	if (event == group_leader)
+		return true;
+
 	for_each_sibling_event(sibling, group_leader) {
 		if (__perf_event_read_size(sibling->attr.read_format,
 					   group_leader->nr_siblings + 1) > 16*1024)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 16fce72a7601..5fb88b5519dd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -697,6 +697,9 @@ static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	unsigned long cnt2, top2, bottom2;
 	u64 val;
 
+	/* Any interruptions in this function should cause a failure */
+	cnt = local_read(&t->cnt);
+
 	/* The cmpxchg always fails if it interrupted an update */
 	 if (!__rb_time_read(t, &val, &cnt2))
 		 return false;
@@ -704,7 +707,6 @@ static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	 if (val != expect)
 		 return false;
 
-	 cnt = local_read(&t->cnt);
 	 if ((cnt & 3) != cnt2)
 		 return false;
 
@@ -1765,6 +1767,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
+	free_page((unsigned long)cpu_buffer->free_page);
+
 	kfree(cpu_buffer);
 }
 
@@ -2365,7 +2369,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+	if ((iter->head + length) > commit || length > BUF_PAGE_SIZE)
 		/* Writer corrupted the read? */
 		goto reset;
 
@@ -3533,7 +3537,10 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		 * absolute timestamp.
 		 * Don't bother if this is the start of a new page (w == 0).
 		 */
-		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
+		if (!w) {
+			/* Use the sub-buffer timestamp */
+			info->delta = 0;
+		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
 			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
@@ -3556,26 +3563,19 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	/* See if we shot pass the end of this buffer page */
 	if (unlikely(write > BUF_PAGE_SIZE)) {
-		/* before and after may now different, fix it up*/
-		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		if (a_ok && b_ok && info->before != info->after)
-			(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
-					      info->before, info->after);
-		if (a_ok && b_ok)
-			check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
+		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 
 	if (likely(tail == w)) {
-		u64 save_before;
-		bool s_ok;
-
 		/* Nothing interrupted us between A and C */
  /*D*/		rb_time_set(&cpu_buffer->write_stamp, info->ts);
-		barrier();
- /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
-		RB_WARN_ON(cpu_buffer, !s_ok);
+		/*
+		 * If something came in between C and D, the write stamp
+		 * may now not be in sync. But that's fine as the before_stamp
+		 * will be different and then next event will just be forced
+		 * to use an absolute timestamp.
+		 */
 		if (likely(!(info->add_timestamp &
 			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
@@ -3583,24 +3583,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		else
 			/* Just use full timestamp for interrupting event */
 			info->delta = info->ts;
-		barrier();
 		check_buffer(cpu_buffer, info, tail);
-		if (unlikely(info->ts != save_before)) {
-			/* SLOW PATH - Interrupted between C and E */
-
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-			RB_WARN_ON(cpu_buffer, !a_ok);
-
-			/* Write stamp must only go forward */
-			if (save_before > info->after) {
-				/*
-				 * We do not care about the result, only that
-				 * it gets updated atomically.
-				 */
-				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
-						      info->after, save_before);
-			}
-		}
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
@@ -3691,6 +3674,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
+		if (info.length > BUF_MAX_DATA_SIZE)
+			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
 	}
@@ -5071,7 +5056,8 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	if (!iter)
 		return NULL;
 
-	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	/* Holds the entire event: data and meta data */
+	iter->event = kmalloc(BUF_PAGE_SIZE, flags);
 	if (!iter->event) {
 		kfree(iter);
 		return NULL;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 657ecb8f0354..d1b7dbffbfe4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6243,7 +6243,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
-	/* Do not allow tracing while resizng ring buffer */
+	/* Do not allow tracing while resizing ring buffer */
 	tracing_stop_tr(tr);
 
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
@@ -6251,7 +6251,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!tr->current_trace->use_max_tr)
+	if (!tr->allocated_snapshot)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
diff --git a/mm/memblock.c b/mm/memblock.c
index 2b7397781c99..2f2094b16416 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -661,6 +661,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
  * @base: base address of the new region
  * @size: size of the new region
  * @nid: nid of the new region
+ * @flags: flags of the new region
  *
  * Add new memblock region [@base, @base + @size) to the "memory"
  * type. See memblock_add_range() description for mode details
@@ -669,14 +670,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
  * 0 on success, -errno on failure.
  */
 int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
-				       int nid)
+				      int nid, enum memblock_flags flags)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] nid=%d %pS\n", __func__,
-		     &base, &end, nid, (void *)_RET_IP_);
+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
+		     &base, &end, nid, flags, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.memory, base, size, nid, 0);
+	return memblock_add_range(&memblock.memory, base, size, nid, flags);
 }
 
 /**
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bf611c55fc66..2d8e9fb4ce0b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1384,8 +1384,11 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	mem_hotplug_begin();
 
-	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
-		memblock_add_node(start, size, nid);
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
+		ret = memblock_add_node(start, size, nid, MEMBLOCK_NONE);
+		if (ret)
+			goto error_mem_hotplug_end;
+	}
 
 	ret = __try_online_node(nid, false);
 	if (ret < 0)
@@ -1458,6 +1461,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		rollback_node_hotadd(nid);
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		memblock_remove(start, size);
+error_mem_hotplug_end:
 	mem_hotplug_done();
 	return ret;
 }
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index bf5736c1d458..8daa3a1bfa4c 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1812,15 +1812,14 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case TIOCINQ: {
-		/*
-		 * These two are safe on a single CPU system as only
-		 * user tasks fiddle here
-		 */
-		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
+		struct sk_buff *skb;
 		long amount = 0;
 
+		spin_lock_irq(&sk->sk_receive_queue.lock);
+		skb = skb_peek(&sk->sk_receive_queue);
 		if (skb)
 			amount = skb->len - sizeof(struct ddpehdr);
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		rc = put_user(amount, (int __user *)argp);
 		break;
 	}
diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 838ebf0cabbf..f81f8d56f5c0 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -73,14 +73,17 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 	case SIOCINQ:
 	{
 		struct sk_buff *skb;
+		int amount;
 
 		if (sock->state != SS_CONNECTED) {
 			error = -EINVAL;
 			goto done;
 		}
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
-		error = put_user(skb ? skb->len : 0,
-				 (int __user *)argp) ? -EFAULT : 0;
+		amount = skb ? skb->len : 0;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
+		error = put_user(amount, (int __user *)argp) ? -EFAULT : 0;
 		goto done;
 	}
 	case ATM_SETSC:
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 99cd8aef0735..bff86ccadc2c 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -444,7 +444,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
-		vhdr = (struct vlan_ethhdr *)skb->data;
+		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
 		if (vhdr->h_vlan_encapsulated_proto != htons(ETH_P_BATMAN))
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8032ccb69463..d8817d6c7b96 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3171,7 +3171,13 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (skb_still_in_host_queue(sk, skb))
 		return -EBUSY;
 
+start:
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
+		if (unlikely(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
+			TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
+			TCP_SKB_CB(skb)->seq++;
+			goto start;
+		}
 		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 441f60170c85..1e4eedf7f212 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6093,11 +6093,7 @@ static int inet6_fill_prefix(struct sk_buff *skb, struct inet6_dev *idev,
 	pmsg->prefix_len = pinfo->prefix_len;
 	pmsg->prefix_type = pinfo->type;
 	pmsg->prefix_pad3 = 0;
-	pmsg->prefix_flags = 0;
-	if (pinfo->onlink)
-		pmsg->prefix_flags |= IF_PREFIX_ONLINK;
-	if (pinfo->autoconf)
-		pmsg->prefix_flags |= IF_PREFIX_AUTOCONF;
+	pmsg->prefix_flags = pinfo->flags;
 
 	if (nla_put(skb, PREFIX_ADDRESS, sizeof(pinfo->prefix), &pinfo->prefix))
 		goto nla_put_failure;
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index daee46cf62ab..d1dcf5b2e92e 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -214,7 +214,7 @@ static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
 
 		offset = i + priv->offset;
 		if (priv->flags & NFT_EXTHDR_F_PRESENT) {
-			*dest = 1;
+			nft_reg_store8(dest, 1);
 		} else {
 			if (priv->len % NFT_REG32_SIZE)
 				dest[priv->len / NFT_REG32_SIZE] = 0;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index b10ce732b337..1fd4b2054e8f 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -140,11 +140,15 @@ void nft_fib_store_result(void *reg, const struct nft_fib *priv,
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
 		index = dev ? dev->ifindex : 0;
-		*dreg = (priv->flags & NFTA_FIB_F_PRESENT) ? !!index : index;
+		if (priv->flags & NFTA_FIB_F_PRESENT)
+			nft_reg_store8(dreg, !!index);
+		else
+			*dreg = index;
+
 		break;
 	case NFT_FIB_RESULT_OIFNAME:
 		if (priv->flags & NFTA_FIB_F_PRESENT)
-			*dreg = !!dev;
+			nft_reg_store8(dreg, !!dev);
 		else
 			strncpy(reg, dev ? dev->name : "", IFNAMSIZ);
 		break;
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 86c93cf1744b..b3e7a92f1ec1 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1307,9 +1307,11 @@ static int rose_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case TIOCINQ: {
 		struct sk_buff *skb;
 		long amount = 0L;
-		/* These two are safe on a single CPU system as only user tasks fiddle here */
+
+		spin_lock_irq(&sk->sk_receive_queue.lock);
 		if ((skb = skb_peek(&sk->sk_receive_queue)) != NULL)
 			amount = skb->len;
+		spin_unlock_irq(&sk->sk_receive_queue.lock);
 		return put_user(amount, (unsigned int __user *) argp);
 	}
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 3a12aee33e92..00e8b60af0f8 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -565,7 +565,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 7434e9ea926e..12acc70e5a7a 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 				     CMS_NOSMIMECAP | use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
+		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
 		    "CMS_final");
 
 #else
@@ -341,10 +341,10 @@ int main(int argc, char **argv)
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) != 1,
 			    "%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+			ERR(i2d_PKCS7_bio(b, pkcs7) != 1,
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
@@ -374,9 +374,9 @@ int main(int argc, char **argv)
 
 	if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -396,7 +396,7 @@ int main(int argc, char **argv)
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
 	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) != 1, "%s", dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 3cd3b5c49e45..20a899db2f15 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1964,7 +1964,10 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8715, "HP", 1),
+	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
+	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1309f8775b84..8219ef80d7f9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9050,6 +9050,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84ae, "HP 15-db0403ng", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),

