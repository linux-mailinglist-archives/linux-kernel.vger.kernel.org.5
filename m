Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139C87C6310
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377058AbjJLCte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjJLCs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:48:58 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30D9A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:48:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VtykMhN_1697078932;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VtykMhN_1697078932)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:48:53 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        tj@kernel.org, mingo@redhat.com
Subject: [PATCH RFC 5/5] mm/numa: migrate leftover numa emulation into mm/numa.c
Date:   Thu, 12 Oct 2023 10:48:42 +0800
Message-Id: <20231012024842.99703-6-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here moving original x86/mm/numa_emulation.c into
mm/numa.c. And next to enable it for arm64.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 drivers/base/arch_numa.c   |   2 +
 include/asm-generic/numa.h |   3 +
 mm/numa.c                  | 586 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 587 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 67bdbcd0caf9..c6f5ceadb9e1 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -64,6 +64,7 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif
 
+#ifndef CONFIG_NUMA_EMU
 static void numa_update_cpu(unsigned int cpu, bool remove)
 {
 	int nid = cpu_to_node(cpu);
@@ -92,6 +93,7 @@ void numa_clear_node(unsigned int cpu)
 	numa_remove_cpu(cpu);
 	set_cpu_numa_node(cpu, NUMA_NO_NODE);
 }
+#endif
 
 /*
  * Allocate node_to_cpumask_map based on number of available nodes
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index 4658155a070a..9969ec7f59a4 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -55,6 +55,7 @@ struct numa_meminfo {
 #define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
 
 extern struct numa_meminfo numa_meminfo;
+extern int emu_nid_to_phys[MAX_NUMNODES];
 extern char *emu_cmdline __initdata;
 
 int numa_emu_cmdline(char *str);
@@ -62,6 +63,8 @@ int __init numa_register_memblks(struct numa_meminfo *mi);
 int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
 void __init numa_emulation(struct numa_meminfo *numa_meminfo,
 			   int numa_dist_cnt);
+int __init numa_add_memblk_to(int nid, u64 start, u64 end,
+			      struct numa_meminfo *mi);
 #else
 static inline int numa_emu_cmdline(char *str)
 {
diff --git a/mm/numa.c b/mm/numa.c
index 3cc01f06a2a6..a6e9652498c9 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/* Most of this file comes from x86/numa_emulation.c */
 #include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -16,10 +17,6 @@
 struct numa_meminfo numa_meminfo __initdata_or_meminfo;
 struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
 
-#ifdef CONFIG_NUMA_EMU
-char *emu_cmdline __initdata;
-#endif
-
 /*
  * Set nodes, which have memory in @mi, in *@nodemask.
  */
@@ -302,9 +299,590 @@ int __weak __init numa_register_memblks(struct numa_meminfo *mi)
 }
 
 #ifdef CONFIG_NUMA_EMU
+int emu_nid_to_phys[MAX_NUMNODES];
+char *emu_cmdline __initdata;
+
 int __init numa_emu_cmdline(char *str)
 {
 	emu_cmdline = str;
 	return 0;
 }
+
+static int __init emu_find_memblk_by_nid(int nid, const struct numa_meminfo *mi)
+{
+	int i;
+
+	for (i = 0; i < mi->nr_blks; i++)
+		if (mi->blk[i].nid == nid)
+			return i;
+	return -ENOENT;
+}
+
+static u64 __init mem_hole_size(u64 start, u64 end)
+{
+	unsigned long start_pfn = PFN_UP(start);
+	unsigned long end_pfn = PFN_DOWN(end);
+
+	if (start_pfn < end_pfn)
+		return PFN_PHYS(absent_pages_in_range(start_pfn, end_pfn));
+	return 0;
+}
+
+/*
+ * Sets up nid to range from @start to @end.  The return value is -errno if
+ * something went wrong, 0 otherwise.
+ */
+static int __init emu_setup_memblk(struct numa_meminfo *ei,
+				   struct numa_meminfo *pi,
+				   int nid, int phys_blk, u64 size)
+{
+	struct numa_memblk *eb = &ei->blk[ei->nr_blks];
+	struct numa_memblk *pb = &pi->blk[phys_blk];
+
+	if (ei->nr_blks >= NR_NODE_MEMBLKS) {
+		pr_err("NUMA: Too many emulated memblks, failing emulation\n");
+		return -EINVAL;
+	}
+
+	ei->nr_blks++;
+	eb->start = pb->start;
+	eb->end = pb->start + size;
+	eb->nid = nid;
+
+	if (emu_nid_to_phys[nid] == NUMA_NO_NODE)
+		emu_nid_to_phys[nid] = pb->nid;
+
+	pb->start += size;
+	if (pb->start >= pb->end) {
+		WARN_ON_ONCE(pb->start > pb->end);
+		numa_remove_memblk_from(phys_blk, pi);
+	}
+
+	printk(KERN_INFO "Faking node %d at [mem %#018Lx-%#018Lx] (%LuMB)\n",
+	       nid, eb->start, eb->end - 1, (eb->end - eb->start) >> 20);
+	return 0;
+}
+
+/*
+ * Sets up nr_nodes fake nodes interleaved over physical nodes ranging from addr
+ * to max_addr.
+ *
+ * Returns zero on success or negative on error.
+ */
+static int __init split_nodes_interleave(struct numa_meminfo *ei,
+					 struct numa_meminfo *pi,
+					 u64 addr, u64 max_addr, int nr_nodes)
+{
+	nodemask_t physnode_mask = numa_nodes_parsed;
+	u64 size;
+	int big;
+	int nid = 0;
+	int i, ret;
+
+	if (nr_nodes <= 0)
+		return -1;
+	if (nr_nodes > MAX_NUMNODES) {
+		pr_info("numa=fake=%d too large, reducing to %d\n",
+			nr_nodes, MAX_NUMNODES);
+		nr_nodes = MAX_NUMNODES;
+	}
+
+	/*
+	 * Calculate target node size.  x86_32 freaks on __udivdi3() so do
+	 * the division in ulong number of pages and convert back.
+	 */
+	size = max_addr - addr - mem_hole_size(addr, max_addr);
+	size = PFN_PHYS((unsigned long)(size >> PAGE_SHIFT) / nr_nodes);
+
+	/*
+	 * Calculate the number of big nodes that can be allocated as a result
+	 * of consolidating the remainder.
+	 */
+	big = ((size & ~FAKE_NODE_MIN_HASH_MASK) * nr_nodes) /
+		FAKE_NODE_MIN_SIZE;
+
+	size &= FAKE_NODE_MIN_HASH_MASK;
+	if (!size) {
+		pr_err("Not enough memory for each node.  "
+			"NUMA emulation disabled.\n");
+		return -1;
+	}
+
+	/*
+	 * Continue to fill physical nodes with fake nodes until there is no
+	 * memory left on any of them.
+	 */
+	while (!nodes_empty(physnode_mask)) {
+		for_each_node_mask(i, physnode_mask) {
+#ifdef CONFIG_X86
+			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
+#endif
+			u64 start, limit, end;
+			int phys_blk;
+
+			phys_blk = emu_find_memblk_by_nid(i, pi);
+			if (phys_blk < 0) {
+				node_clear(i, physnode_mask);
+				continue;
+			}
+			start = pi->blk[phys_blk].start;
+			limit = pi->blk[phys_blk].end;
+			end = start + size;
+
+			if (nid < big)
+				end += FAKE_NODE_MIN_SIZE;
+
+			/*
+			 * Continue to add memory to this fake node if its
+			 * non-reserved memory is less than the per-node size.
+			 */
+			while (end - start - mem_hole_size(start, end) < size) {
+				end += FAKE_NODE_MIN_SIZE;
+				if (end > limit) {
+					end = limit;
+					break;
+				}
+			}
+
+#ifdef CONFIG_X86
+			/*
+			 * If there won't be at least FAKE_NODE_MIN_SIZE of
+			 * non-reserved memory in ZONE_DMA32 for the next node,
+			 * this one must extend to the boundary.
+			 */
+			if (end < dma32_end && dma32_end - end -
+			    mem_hole_size(end, dma32_end) < FAKE_NODE_MIN_SIZE)
+				end = dma32_end;
+#endif
+
+			/*
+			 * If there won't be enough non-reserved memory for the
+			 * next node, this one must extend to the end of the
+			 * physical node.
+			 */
+			if (limit - end - mem_hole_size(end, limit) < size)
+				end = limit;
+
+			ret = emu_setup_memblk(ei, pi, nid++ % nr_nodes,
+					       phys_blk,
+					       min(end, limit) - start);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Returns the end address of a node so that there is at least `size' amount of
+ * non-reserved memory or `max_addr' is reached.
+ */
+static u64 __init find_end_of_node(u64 start, u64 max_addr, u64 size)
+{
+	u64 end = start + size;
+
+	while (end - start - mem_hole_size(start, end) < size) {
+		end += FAKE_NODE_MIN_SIZE;
+		if (end > max_addr) {
+			end = max_addr;
+			break;
+		}
+	}
+	return end;
+}
+
+static u64 uniform_size(u64 max_addr, u64 base, u64 hole, int nr_nodes)
+{
+	unsigned long max_pfn = PHYS_PFN(max_addr);
+	unsigned long base_pfn = PHYS_PFN(base);
+	unsigned long hole_pfns = PHYS_PFN(hole);
+
+	return PFN_PHYS((max_pfn - base_pfn - hole_pfns) / nr_nodes);
+}
+
+/*
+ * Sets up fake nodes of `size' interleaved over physical nodes ranging from
+ * `addr' to `max_addr'.
+ *
+ * Returns zero on success or negative on error.
+ */
+static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
+					      struct numa_meminfo *pi,
+					      u64 addr, u64 max_addr, u64 size,
+					      int nr_nodes, struct numa_memblk *pblk,
+					      int nid)
+{
+	nodemask_t physnode_mask = numa_nodes_parsed;
+	int i, ret, uniform = 0;
+	u64 min_size;
+
+	if ((!size && !nr_nodes) || (nr_nodes && !pblk))
+		return -1;
+
+	/*
+	 * In the 'uniform' case split the passed in physical node by
+	 * nr_nodes, in the non-uniform case, ignore the passed in
+	 * physical block and try to create nodes of at least size
+	 * @size.
+	 *
+	 * In the uniform case, split the nodes strictly by physical
+	 * capacity, i.e. ignore holes. In the non-uniform case account
+	 * for holes and treat @size as a minimum floor.
+	 */
+	if (!nr_nodes)
+		nr_nodes = MAX_NUMNODES;
+	else {
+		nodes_clear(physnode_mask);
+		node_set(pblk->nid, physnode_mask);
+		uniform = 1;
+	}
+
+	if (uniform) {
+		min_size = uniform_size(max_addr, addr, 0, nr_nodes);
+		size = min_size;
+	} else {
+		/*
+		 * The limit on emulated nodes is MAX_NUMNODES, so the
+		 * size per node is increased accordingly if the
+		 * requested size is too small.  This creates a uniform
+		 * distribution of node sizes across the entire machine
+		 * (but not necessarily over physical nodes).
+		 */
+		min_size = uniform_size(max_addr, addr,
+				mem_hole_size(addr, max_addr), nr_nodes);
+	}
+	min_size = ALIGN(max(min_size, FAKE_NODE_MIN_SIZE), FAKE_NODE_MIN_SIZE);
+	if (size < min_size) {
+		pr_err("Fake node size %LuMB too small, increasing to %LuMB\n",
+			size >> 20, min_size >> 20);
+		size = min_size;
+	}
+	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
+
+	/*
+	 * Fill physical nodes with fake nodes of size until there is no memory
+	 * left on any of them.
+	 */
+	while (!nodes_empty(physnode_mask)) {
+		for_each_node_mask(i, physnode_mask) {
+#ifdef CONFIG_X86
+			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
+#endif
+			u64 start, limit, end;
+			int phys_blk;
+
+			phys_blk = emu_find_memblk_by_nid(i, pi);
+			if (phys_blk < 0) {
+				node_clear(i, physnode_mask);
+				continue;
+			}
+
+			start = pi->blk[phys_blk].start;
+			limit = pi->blk[phys_blk].end;
+
+			if (uniform)
+				end = start + size;
+			else
+				end = find_end_of_node(start, limit, size);
+
+#ifdef CONFIG_X86
+			/*
+			 * If there won't be at least FAKE_NODE_MIN_SIZE of
+			 * non-reserved memory in ZONE_DMA32 for the next node,
+			 * this one must extend to the boundary.
+			 */
+			if (end < dma32_end && dma32_end - end -
+			    mem_hole_size(end, dma32_end) < FAKE_NODE_MIN_SIZE)
+				end = dma32_end;
+#endif
+
+			/*
+			 * If there won't be enough non-reserved memory for the
+			 * next node, this one must extend to the end of the
+			 * physical node.
+			 */
+			if ((limit - end - mem_hole_size(end, limit) < size)
+					&& !uniform)
+				end = limit;
+
+			ret = emu_setup_memblk(ei, pi, nid++ % MAX_NUMNODES,
+					       phys_blk,
+					       min(end, limit) - start);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return nid;
+}
+
+static int __init split_nodes_size_interleave(struct numa_meminfo *ei,
+					      struct numa_meminfo *pi,
+					      u64 addr, u64 max_addr, u64 size)
+{
+	return split_nodes_size_interleave_uniform(ei, pi, addr, max_addr, size,
+			0, NULL, 0);
+}
+
+static int __init setup_emu2phys_nid(int *dfl_phys_nid)
+{
+	int i, max_emu_nid = 0;
+
+	*dfl_phys_nid = NUMA_NO_NODE;
+	for (i = 0; i < ARRAY_SIZE(emu_nid_to_phys); i++) {
+		if (emu_nid_to_phys[i] != NUMA_NO_NODE) {
+			max_emu_nid = i;
+			if (*dfl_phys_nid == NUMA_NO_NODE)
+				*dfl_phys_nid = emu_nid_to_phys[i];
+		}
+	}
+
+	return max_emu_nid;
+}
+
+/**
+ * numa_emulation - Emulate NUMA nodes
+ * @numa_meminfo: NUMA configuration to massage
+ * @numa_dist_cnt: The size of the physical NUMA distance table
+ *
+ * Emulate NUMA nodes according to the numa=fake kernel parameter.
+ * @numa_meminfo contains the physical memory configuration and is modified
+ * to reflect the emulated configuration on success.  @numa_dist_cnt is
+ * used to determine the size of the physical distance table.
+ *
+ * On success, the following modifications are made.
+ *
+ * - @numa_meminfo is updated to reflect the emulated nodes.
+ *
+ * - __apicid_to_node[] is updated such that APIC IDs are mapped to the
+ *   emulated nodes.
+ *
+ * - NUMA distance table is rebuilt to represent distances between emulated
+ *   nodes.  The distances are determined considering how emulated nodes
+ *   are mapped to physical nodes and match the actual distances.
+ *
+ * - emu_nid_to_phys[] reflects how emulated nodes are mapped to physical
+ *   nodes.  This is used by numa_add_cpu() and numa_remove_cpu().
+ *
+ * If emulation is not enabled or fails, emu_nid_to_phys[] is filled with
+ * identity mapping and no other modification is made.
+ */
+void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
+{
+	static struct numa_meminfo ei __initdata;
+	static struct numa_meminfo pi __initdata;
+	const u64 max_addr = PFN_PHYS(max_pfn);
+	u8 *phys_dist = NULL;
+	size_t phys_size = numa_dist_cnt * numa_dist_cnt * sizeof(phys_dist[0]);
+	int max_emu_nid, dfl_phys_nid;
+	int i, j, ret;
+
+	if (!emu_cmdline)
+		goto no_emu;
+
+	memset(&ei, 0, sizeof(ei));
+	pi = *numa_meminfo;
+
+	for (i = 0; i < MAX_NUMNODES; i++)
+		emu_nid_to_phys[i] = NUMA_NO_NODE;
+
+	/*
+	 * If the numa=fake command-line contains a 'M' or 'G', it represents
+	 * the fixed node size.  Otherwise, if it is just a single number N,
+	 * split the system RAM into N fake nodes.
+	 */
+	if (strchr(emu_cmdline, 'U')) {
+		nodemask_t physnode_mask = numa_nodes_parsed;
+		unsigned long n;
+		int nid = 0;
+
+		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
+		ret = -1;
+		for_each_node_mask(i, physnode_mask) {
+			/*
+			 * The reason we pass in blk[0] is due to
+			 * numa_remove_memblk_from() called by
+			 * emu_setup_memblk() will delete entry 0
+			 * and then move everything else up in the pi.blk
+			 * array. Therefore we should always be looking
+			 * at blk[0].
+			 */
+			ret = split_nodes_size_interleave_uniform(&ei, &pi,
+					pi.blk[0].start, pi.blk[0].end, 0,
+					n, &pi.blk[0], nid);
+			if (ret < 0)
+				break;
+			if (ret < n) {
+				pr_info("%s: phys: %d only got %d of %ld nodes, failing\n",
+						__func__, i, ret, n);
+				ret = -1;
+				break;
+			}
+			nid = ret;
+		}
+	} else if (strchr(emu_cmdline, 'M') || strchr(emu_cmdline, 'G')) {
+		u64 size;
+
+		size = memparse(emu_cmdline, &emu_cmdline);
+		ret = split_nodes_size_interleave(&ei, &pi, 0, max_addr, size);
+	} else {
+		unsigned long n;
+
+		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
+		ret = split_nodes_interleave(&ei, &pi, 0, max_addr, n);
+	}
+	if (*emu_cmdline == ':')
+		emu_cmdline++;
+
+	if (ret < 0)
+		goto no_emu;
+
+	if (numa_cleanup_meminfo(&ei) < 0) {
+		pr_warn("NUMA: Warning: constructed meminfo invalid, disabling emulation\n");
+		goto no_emu;
+	}
+
+	/* copy the physical distance table */
+	if (numa_dist_cnt) {
+		u64 phys;
+
+		phys = memblock_phys_alloc_range(phys_size, PAGE_SIZE, 0,
+						 MEMBLOCK_ALLOC_ACCESSIBLE);
+		if (!phys) {
+			pr_warn("NUMA: Warning: can't allocate copy of distance table, disabling emulation\n");
+			goto no_emu;
+		}
+		phys_dist = __va(phys);
+
+		for (i = 0; i < numa_dist_cnt; i++)
+			for (j = 0; j < numa_dist_cnt; j++)
+				phys_dist[i * numa_dist_cnt + j] =
+					node_distance(i, j);
+	}
+
+	/*
+	 * Determine the max emulated nid and the default phys nid to use
+	 * for unmapped nodes.
+	 */
+	max_emu_nid = setup_emu2phys_nid(&dfl_phys_nid);
+
+	/* commit */
+	*numa_meminfo = ei;
+
+	/* Make sure numa_nodes_parsed only contains emulated nodes */
+	nodes_clear(numa_nodes_parsed);
+	for (i = 0; i < ARRAY_SIZE(ei.blk); i++)
+		if (ei.blk[i].start != ei.blk[i].end &&
+		    ei.blk[i].nid != NUMA_NO_NODE)
+			node_set(ei.blk[i].nid, numa_nodes_parsed);
+
+#ifdef CONFIG_X86
+	/*
+	 * Transform __apicid_to_node table to use emulated nids by
+	 * reverse-mapping phys_nid.  The maps should always exist but fall
+	 * back to zero just in case.
+	 */
+	for (i = 0; i < ARRAY_SIZE(__apicid_to_node); i++) {
+		if (__apicid_to_node[i] == NUMA_NO_NODE)
+			continue;
+		for (j = 0; j < ARRAY_SIZE(emu_nid_to_phys); j++)
+			if (__apicid_to_node[i] == emu_nid_to_phys[j])
+				break;
+		__apicid_to_node[i] = j < ARRAY_SIZE(emu_nid_to_phys) ? j : 0;
+	}
+#endif
+
+	/* make sure all emulated nodes are mapped to a physical node */
+	for (i = 0; i < ARRAY_SIZE(emu_nid_to_phys); i++)
+		if (emu_nid_to_phys[i] == NUMA_NO_NODE)
+			emu_nid_to_phys[i] = dfl_phys_nid;
+
+	/* transform distance table */
+	numa_free_distance();
+	for (i = 0; i < max_emu_nid + 1; i++) {
+		for (j = 0; j < max_emu_nid + 1; j++) {
+			int physi = emu_nid_to_phys[i];
+			int physj = emu_nid_to_phys[j];
+			int dist;
+
+			if (get_option(&emu_cmdline, &dist) == 2)
+				;
+			else if (physi >= numa_dist_cnt || physj >= numa_dist_cnt)
+				dist = physi == physj ?
+					LOCAL_DISTANCE : REMOTE_DISTANCE;
+			else
+				dist = phys_dist[physi * numa_dist_cnt + physj];
+
+			numa_set_distance(i, j, dist);
+		}
+	}
+
+	/* free the copied physical distance table */
+	memblock_free(phys_dist, phys_size);
+	return;
+
+no_emu:
+	/* No emulation.  Build identity emu_nid_to_phys[] for numa_add_cpu() */
+	for (i = 0; i < ARRAY_SIZE(emu_nid_to_phys); i++)
+		emu_nid_to_phys[i] = i;
+}
+
+#ifndef CONFIG_DEBUG_PER_CPU_MAPS
+extern int early_cpu_to_node(unsigned int cpu);
+
+void numa_add_cpu(unsigned int cpu)
+{
+	int physnid, nid;
+
+	nid = early_cpu_to_node(cpu);
+	BUG_ON(nid == NUMA_NO_NODE || !node_online(nid));
+
+	physnid = emu_nid_to_phys[nid];
+
+	/*
+	 * Map the cpu to each emulated node that is allocated on the physical
+	 * node of the cpu's apic id.
+	 */
+	for_each_online_node(nid)
+		if (emu_nid_to_phys[nid] == physnid)
+			cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
+}
+
+void numa_remove_cpu(unsigned int cpu)
+{
+	int i;
+
+	for_each_online_node(i)
+		cpumask_clear_cpu(cpu, node_to_cpumask_map[i]);
+}
+#else	/* !CONFIG_DEBUG_PER_CPU_MAPS */
+static void numa_set_cpumask(int cpu, bool enable)
+{
+	int nid, physnid;
+
+	nid = early_cpu_to_node(cpu);
+	if (nid == NUMA_NO_NODE) {
+		/* early_cpu_to_node() already emits a warning and trace */
+		return;
+	}
+
+	physnid = emu_nid_to_phys[nid];
+
+	for_each_online_node(nid) {
+		if (emu_nid_to_phys[nid] != physnid)
+			continue;
+
+		debug_cpumask_set_cpu(cpu, nid, enable);
+	}
+}
+
+void numa_add_cpu(unsigned int cpu)
+{
+	numa_set_cpumask(cpu, true);
+}
+
+void numa_remove_cpu(unsigned int cpu)
+{
+	numa_set_cpumask(cpu, false);
+}
+#endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 #endif
-- 
2.32.0.3.gf3a3e56d6

