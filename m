Return-Path: <linux-kernel+bounces-72916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC385BAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326DC1C22F11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808967756;
	Tue, 20 Feb 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uToNTKce"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201F664DA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429009; cv=none; b=koXCyAt6tlbRNHScvSO4Tz8dkyaJWPRndPJgPsyoDT6v2WfVMnYCsIdtlBQg/ffDThn1HBPElrNw3Iw9zT8dYDfc52BswiDdu7Ofs9dRZlSOS8mkVXNENLotnoPivY65AF1Rdi8Ij8xlCweLXyCK0iR86CwLZxUgkdZViZdIplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429009; c=relaxed/simple;
	bh=i1KUZO8kcnqHx6Si3/efkQrMbL+9QgCcJYZ+WwxHSUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwR7tJ5uzoIRGzTyH26p6i8jBLmd6eVzKnocQA7q2OYrN/aI/bb0lkQG4F6Bomsfiwuok2dh8YnVEC0IengxSPHIorYq7Nqp/CK9sQnGvVFVYwniDOxEoVLEWa233B0LTwFFkmJsXX5rh0zCouIK3aSVw9uAEzHq9mYvUQJNMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uToNTKce; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708429003; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JSYhCb57oa38pPWTM61fSg+qWb0F6lgVWkBFuWunCfg=;
	b=uToNTKcepUPJmLjn29CJ/qW+4A1i3tE3T3k+nA4BzwMOxj/8UmIYFhpgbW4CQn5CnZOxT9A3v7T8Ps/GSVBa4x45Ly0LmRYvq4bb/J1TgU1jVl/+sVPblfhEqnDYgkFdtYY8Wpy6JoCM2yI8ru6s2OUytyV1QeXUTJ+qRn5BID4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0wabrT_1708429001;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0W0wabrT_1708429001)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 19:36:42 +0800
From: Rongwei Wang <rongwei.wang@linux.alibaba.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	pierre.gondois@arm.com,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	teng.ma@linux.alibaba.com
Subject: [PATCH v1 2/2] numa: introduce numa emulation for genertic arch
Date: Tue, 20 Feb 2024 19:36:02 +0800
Message-Id: <20240220113602.6943-3-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
 <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, x86 has already support numa
emulation for a long time. That's enabled
by CONFIG_NUMA_EMU. This patch mainly to
introduce numa emulation for genertic
arch (refer to x86 implementation).

In order to avoid changing APIs (especially
related to NUMA), and more coupling, maintaining
x86 and other genertic archs separately
would be a better choice. So a new configure
CONFIG_NUMA_FAKE used to enable it, also avoid
some conflicts with CONFIG_NUMA_EMU.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
Signed-off-by: Teng Ma <teng.ma@linux.alibaba.com>
---
 drivers/base/Kconfig          |   9 +
 drivers/base/Makefile         |   1 +
 drivers/base/arch_numa.c      |  30 ++
 drivers/base/numa_emulation.c | 909 ++++++++++++++++++++++++++++++++++
 drivers/base/numa_emulation.h |  41 ++
 5 files changed, 990 insertions(+)
 create mode 100644 drivers/base/numa_emulation.c
 create mode 100644 drivers/base/numa_emulation.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..c162aedf1458 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,6 +230,15 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config NUMA_FAKE
+	bool "NUMA emulation"
+	depends on NUMA
+	depends on GENERIC_ARCH_NUMA
+	help
+	  Enable NUMA emulation. A flat machine will be split
+	  into virtual nodes when booted with "numa=fake=N", where N is the
+	  number of nodes. This is only useful for debugging.
+
 config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	bool "sync_state() behavior defaults to timeout instead of strict"
 	help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 3079bfe53d04..23976a1babae 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -34,3 +34,4 @@ ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 # define_trace.h needs to know how to find our header
 CFLAGS_trace.o		:= -I$(src)
 obj-$(CONFIG_TRACING)	+= trace.o
+obj-$(CONFIG_NUMA_FAKE)	+=  numa_emulation.o
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 90519d981471..77ea423e2bf9 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -24,12 +24,25 @@ static int numa_distance_cnt;
 static u8 *numa_distance;
 bool numa_off;
 
+#ifdef CONFIG_NUMA_FAKE
+extern struct numa_meminfo numa_meminfo;
+
+extern void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt);
+extern int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
+extern int __init numa_register_memblks(struct numa_meminfo *mi);
+extern int __init numa_add_memblk_to(int nid, u64 start, u64 end,
+				     struct numa_meminfo *mi);
+extern int __init numa_emu_cmdline(char *str);
+#endif
+
 static __init int numa_parse_early_param(char *opt)
 {
 	if (!opt)
 		return -EINVAL;
 	if (str_has_prefix(opt, "off"))
 		numa_off = true;
+	if (!strncmp(opt, "fake=", 5))
+		return numa_emu_cmdline(opt + 5);
 
 	return 0;
 }
@@ -61,6 +74,7 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif
 
+#ifndef CONFIG_NUMA_FAKE
 static void numa_update_cpu(unsigned int cpu, bool remove)
 {
 	int nid = cpu_to_node(cpu);
@@ -89,6 +103,7 @@ void numa_clear_node(unsigned int cpu)
 	numa_remove_cpu(cpu);
 	set_cpu_numa_node(cpu, NUMA_NO_NODE);
 }
+#endif
 
 /*
  * Allocate node_to_cpumask_map based on number of available nodes
@@ -202,6 +217,9 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 {
 	int ret;
 
+	if (IS_ENABLED(CONFIG_NUMA_FAKE))
+		return numa_add_memblk_to(nid, start, end, &numa_meminfo);
+
 	ret = memblock_set_node(start, (end - start), &memblock.memory, nid);
 	if (ret < 0) {
 		pr_err("memblock [0x%llx - 0x%llx] failed to add on node %d\n",
@@ -395,6 +413,18 @@ static int __init numa_init(int (*init_func)(void))
 		goto out_free_distance;
 	}
 
+#ifdef CONFIG_NUMA_FAKE
+	ret = numa_cleanup_meminfo(&numa_meminfo);
+	if (ret < 0)
+		return ret;
+
+	numa_emulation(&numa_meminfo, numa_distance_cnt);
+
+	ret = numa_register_memblks(&numa_meminfo);
+	if (ret < 0)
+		return ret;
+#endif
+
 	ret = numa_register_nodes();
 	if (ret < 0)
 		goto out_free_distance;
diff --git a/drivers/base/numa_emulation.c b/drivers/base/numa_emulation.c
new file mode 100644
index 000000000000..379e52b30327
--- /dev/null
+++ b/drivers/base/numa_emulation.c
@@ -0,0 +1,909 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NUMA emulation
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/topology.h>
+#include <linux/memblock.h>
+#include <asm/dma.h>
+#include "numa_emulation.h"
+
+static int emu_nid_to_phys[MAX_NUMNODES];
+static char *emu_cmdline __initdata;
+
+struct numa_meminfo numa_meminfo __initdata_or_meminfo;
+static struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
+
+void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
+void __init numa_reset_distance(void);
+
+int __init numa_emu_cmdline(char *str)
+{
+	emu_cmdline = str;
+	return 0;
+}
+
+/**
+ * numa_remove_memblk_from - Remove one numa_memblk from a numa_meminfo
+ * @idx: Index of memblk to remove
+ * @mi: numa_meminfo to remove memblk from
+ *
+ * Remove @idx'th numa_memblk from @mi by shifting @mi->blk[] and
+ * decrementing @mi->nr_blks.
+ */
+void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
+{
+	mi->nr_blks--;
+	memmove(&mi->blk[idx], &mi->blk[idx + 1],
+		(mi->nr_blks - idx) * sizeof(mi->blk[0]));
+}
+
+/**
+ * numa_move_tail_memblk - Move a numa_memblk from one numa_meminfo to another
+ * @dst: numa_meminfo to append block to
+ * @idx: Index of memblk to remove
+ * @src: numa_meminfo to remove memblk from
+ */
+static void __init numa_move_tail_memblk(struct numa_meminfo *dst, int idx,
+					 struct numa_meminfo *src)
+{
+	dst->blk[dst->nr_blks++] = src->blk[idx];
+	numa_remove_memblk_from(idx, src);
+}
+
+int __init numa_add_memblk_to(int nid, u64 start, u64 end,
+			      struct numa_meminfo *mi)
+{
+	/* ignore zero length blks */
+	if (start == end)
+		return 0;
+
+	/* whine about and ignore invalid blks */
+	if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
+		pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
+			nid, start, end - 1);
+		return 0;
+	}
+
+	if (mi->nr_blks >= NR_NODE_MEMBLKS) {
+		pr_err("too many memblk ranges\n");
+		return -EINVAL;
+	}
+
+	mi->blk[mi->nr_blks].start = start;
+	mi->blk[mi->nr_blks].end = end;
+	mi->blk[mi->nr_blks].nid = nid;
+	mi->nr_blks++;
+	return 0;
+}
+
+/**
+ * numa_cleanup_meminfo - Cleanup a numa_meminfo
+ * @mi: numa_meminfo to clean up
+ *
+ * Sanitize @mi by merging and removing unnecessary memblks.  Also check for
+ * conflicts and clear unused memblks.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
+{
+	const u64 low = 0;
+	const u64 high = PFN_PHYS(max_pfn);
+	int i, j, k;
+
+	/* first, trim all entries */
+	for (i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		/* move / save reserved memory ranges */
+		if (!memblock_overlaps_region(&memblock.memory,
+					bi->start, bi->end - bi->start)) {
+			numa_move_tail_memblk(&numa_reserved_meminfo, i--, mi);
+			continue;
+		}
+
+		/* make sure all non-reserved blocks are inside the limits */
+		bi->start = max(bi->start, low);
+
+		/* preserve info for non-RAM areas above 'max_pfn': */
+		if (bi->end > high) {
+			numa_add_memblk_to(bi->nid, high, bi->end,
+					   &numa_reserved_meminfo);
+			bi->end = high;
+		}
+
+		/* and there's no empty block */
+		if (bi->start >= bi->end)
+			numa_remove_memblk_from(i--, mi);
+	}
+
+	/* merge neighboring / overlapping entries */
+	for (i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		for (j = i + 1; j < mi->nr_blks; j++) {
+			struct numa_memblk *bj = &mi->blk[j];
+			u64 start, end;
+
+			/*
+			 * See whether there are overlapping blocks.  Whine
+			 * about but allow overlaps of the same nid.  They
+			 * will be merged below.
+			 */
+			if (bi->end > bj->start && bi->start < bj->end) {
+				if (bi->nid != bj->nid) {
+					pr_err("node %d [mem %#010Lx-%#010Lx] overlaps with node %d [mem %#010Lx-%#010Lx]\n",
+					       bi->nid, bi->start, bi->end - 1,
+					       bj->nid, bj->start, bj->end - 1);
+					return -EINVAL;
+				}
+				pr_warn("Warning: node %d [mem %#010Lx-%#010Lx] overlaps with itself [mem %#010Lx-%#010Lx]\n",
+					bi->nid, bi->start, bi->end - 1,
+					bj->start, bj->end - 1);
+			}
+
+			/*
+			 * Join together blocks on the same node, holes
+			 * between which don't overlap with memory on other
+			 * nodes.
+			 */
+			if (bi->nid != bj->nid)
+				continue;
+			start = min(bi->start, bj->start);
+			end = max(bi->end, bj->end);
+			for (k = 0; k < mi->nr_blks; k++) {
+				struct numa_memblk *bk = &mi->blk[k];
+
+				if (bi->nid == bk->nid)
+					continue;
+				if (start < bk->end && end > bk->start)
+					break;
+			}
+			if (k < mi->nr_blks)
+				continue;
+			printk(KERN_INFO "NUMA: Node %d [mem %#010Lx-%#010Lx] + [mem %#010Lx-%#010Lx] -> [mem %#010Lx-%#010Lx]\n",
+			       bi->nid, bi->start, bi->end - 1, bj->start,
+			       bj->end - 1, start, end - 1);
+			bi->start = start;
+			bi->end = end;
+			numa_remove_memblk_from(j--, mi);
+		}
+	}
+
+	/* clear unused ones */
+	for (i = mi->nr_blks; i < ARRAY_SIZE(mi->blk); i++) {
+		mi->blk[i].start = mi->blk[i].end = 0;
+		mi->blk[i].nid = NUMA_NO_NODE;
+	}
+
+	return 0;
+}
+
+/*
+ * Mark all currently memblock-reserved physical memory (which covers the
+ * kernel's own memory ranges) as hot-unswappable.
+ */
+static void __init numa_clear_kernel_node_hotplug(void)
+{
+	nodemask_t reserved_nodemask = NODE_MASK_NONE;
+	struct memblock_region *mb_region;
+	int i;
+
+	/*
+	 * We have to do some preprocessing of memblock regions, to
+	 * make them suitable for reservation.
+	 *
+	 * At this time, all memory regions reserved by memblock are
+	 * used by the kernel, but those regions are not split up
+	 * along node boundaries yet, and don't necessarily have their
+	 * node ID set yet either.
+	 *
+	 * So iterate over all memory known to the x86 architecture,
+	 * and use those ranges to set the nid in memblock.reserved.
+	 * This will split up the memblock regions along node
+	 * boundaries and will set the node IDs as well.
+	 */
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = numa_meminfo.blk + i;
+		int ret;
+
+		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
+		WARN_ON_ONCE(ret);
+	}
+
+	/*
+	 * Now go over all reserved memblock regions, to construct a
+	 * node mask of all kernel reserved memory areas.
+	 *
+	 * [ Note, when booting with mem=nn[kMG] or in a kdump kernel,
+	 *   numa_meminfo might not include all memblock.reserved
+	 *   memory ranges, because quirks such as trim_snb_memory()
+	 *   reserve specific pages for Sandy Bridge graphics. ]
+	 */
+	for_each_reserved_mem_region(mb_region) {
+		int nid = memblock_get_region_node(mb_region);
+
+		if (nid != MAX_NUMNODES)
+			node_set(nid, reserved_nodemask);
+	}
+
+	/*
+	 * Finally, clear the MEMBLOCK_HOTPLUG flag for all memory
+	 * belonging to the reserved node mask.
+	 *
+	 * Note that this will include memory regions that reside
+	 * on nodes that contain kernel memory - entire nodes
+	 * become hot-unpluggable:
+	 */
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = numa_meminfo.blk + i;
+
+		if (!node_isset(mb->nid, reserved_nodemask))
+			continue;
+
+		memblock_clear_hotplug(mb->start, mb->end - mb->start);
+	}
+}
+
+/*
+ * Set nodes, which have memory in @mi, in *@nodemask.
+ */
+static void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
+					      const struct numa_meminfo *mi)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mi->blk); i++)
+		if (mi->blk[i].start != mi->blk[i].end &&
+		    mi->blk[i].nid != NUMA_NO_NODE)
+			node_set(mi->blk[i].nid, *nodemask);
+}
+
+int __init numa_register_memblks(struct numa_meminfo *mi)
+{
+	int i;
+
+	/* Account for nodes with cpus and no memory */
+	node_possible_map = numa_nodes_parsed;
+	numa_nodemask_from_meminfo(&node_possible_map, mi);
+	if (WARN_ON(nodes_empty(node_possible_map)))
+		return -EINVAL;
+
+	for (i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *mb = &mi->blk[i];
+		memblock_set_node(mb->start, mb->end - mb->start,
+				  &memblock.memory, mb->nid);
+	}
+
+	/*
+	 * At very early time, the kernel have to use some memory such as
+	 * loading the kernel image. We cannot prevent this anyway. So any
+	 * node the kernel resides in should be un-hotpluggable.
+	 *
+	 * And when we come here, alloc node data won't fail.
+	 */
+	numa_clear_kernel_node_hotplug();
+
+	/*
+	 * If sections array is gonna be used for pfn -> nid mapping, check
+	 * whether its granularity is fine enough.
+	 */
+	if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
+		unsigned long pfn_align = node_map_pfn_alignment();
+
+		if (pfn_align && pfn_align < PAGES_PER_SECTION) {
+			pr_warn("Node alignment %LuMB < min %LuMB, rejecting NUMA config\n",
+				PFN_PHYS(pfn_align) >> 20,
+				PFN_PHYS(PAGES_PER_SECTION) >> 20);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
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
+#ifdef CONFIG_ZONE_DMA32
+			unsigned long dma32_max_pfn = PFN_DOWN(min(4UL * SZ_1G, memblock_end_of_DRAM() - 1) + 1);
+			u64 dma32_end = PFN_PHYS(dma32_max_pfn);
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
+#ifdef CONFIG_ZONE_DMA32
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
+#ifdef CONFIG_ZONE_DMA32
+			unsigned long dma32_max_pfn = PFN_DOWN(min(4UL * SZ_1G, memblock_end_of_DRAM() - 1) + 1);
+			u64 dma32_end = PFN_PHYS(dma32_max_pfn);
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
+#ifdef CONFIG_ZONE_DMA32
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
+static void debug_cpumask_set_cpu(int cpu, int node, bool enable)
+{
+	struct cpumask *mask;
+
+	if (node == NUMA_NO_NODE) {
+		/* early_cpu_to_node() already emits a warning and trace */
+		return;
+	}
+	mask = node_to_cpumask_map[node];
+	if (!cpumask_available(mask)) {
+		pr_err("node_to_cpumask_map[%i] NULL\n", node);
+		dump_stack();
+		return;
+	}
+
+	if (enable)
+		cpumask_set_cpu(cpu, mask);
+	else
+		cpumask_clear_cpu(cpu, mask);
+
+	printk(KERN_DEBUG "%s cpu %d node %d: mask now %*pbl\n",
+		enable ? "numa_add_cpu" : "numa_remove_cpu",
+		cpu, node, cpumask_pr_args(mask));
+	return;
+}
+
+static void numa_set_cpumask(unsigned int cpu, bool enable)
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
diff --git a/drivers/base/numa_emulation.h b/drivers/base/numa_emulation.h
new file mode 100644
index 000000000000..c54642006b7f
--- /dev/null
+++ b/drivers/base/numa_emulation.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NUMA_FAKE_H
+#define __NUMA_FAKE_H
+
+#include <linux/types.h>
+#include <asm/numa.h>
+
+struct numa_memblk {
+	u64			start;
+	u64			end;
+	int			nid;
+};
+
+struct numa_meminfo {
+	int			nr_blks;
+	struct numa_memblk	blk[NR_NODE_MEMBLKS];
+};
+
+#ifdef CONFIG_NUMA_FAKE
+#define FAKE_NODE_MIN_SIZE	((u64)32 << 20)
+#define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
+int numa_emu_cmdline(char *str);
+
+void __init numa_emulation(struct numa_meminfo *numa_meminfo,
+			   int numa_dist_cnt);
+int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
+int __init numa_register_memblks(struct numa_meminfo *mi);
+int __init numa_add_memblk_to(int nid, u64 start, u64 end,
+			      struct numa_meminfo *mi);
+int __init numa_emu_cmdline(char *str);
+#else /* CONFIG_NUMA_FAKE */
+static inline void numa_emulation(struct numa_meminfo *numa_meminfo,
+				  int numa_dist_cnt)
+{ }
+
+static inline int numa_emu_cmdline(char *str)
+{
+	return -EINVAL;
+}
+#endif
+#endif
-- 
2.32.0.3.gf3a3e56d6


