Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB54879DC97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbjILXU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjILXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:20:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2010FF;
        Tue, 12 Sep 2023 16:20:21 -0700 (PDT)
Date:   Tue, 12 Sep 2023 23:20:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694560820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mYU0selPhg3hRjpXhCjC0zhFwMcYcNp4koJ7xBtLCdI=;
        b=zONDiRHCQF5VFr7qR993QoN6k/XqPTplUPE9Emj5u7maw4uerd2hkITNe6HAUzEMuvsCFs
        2WbJqDdfAL0SBBCxFjAEJ4O4MdeJQJ2+8yna8Iw0NZogxY2IL06hzyS8+eHY0+l64Lptki
        /0Ro955TwjmUOzI4IIjJ51KTl9LMgB2JOvqU4TWBH5a05kFocBmbMWyHSUT6NPFutCQ1nF
        qc/zBjn/PIiGVj3dvI9UX5X3/lPVkmOqFzwC29zkI1tFiONI2ocxknKlAKI1wCqrPPNCS3
        91/lwtc5ffh54iFL0xW+m1btdLEYLBUJxV3lNyKmaljD05qJ5m8SwZMaF55C0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694560820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mYU0selPhg3hRjpXhCjC0zhFwMcYcNp4koJ7xBtLCdI=;
        b=qv4GtN6SkcK7jyhmqIWaTr59JzBn8mjTMyCdzWiTCfPzm7P2c6GJV9dsGJOBEf4H7eI/IM
        yLWXJ8S0sn9ckyBw==
From:   "tip-bot2 for Alison Schofield" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/numa: Introduce numa_fill_memblks()
Cc:     Derick Marks <derick.w.marks@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169456081929.27769.3963257312584363355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8f012db27c9516be1a7aca93ea4a6ca9c75056c9
Gitweb:        https://git.kernel.org/tip/8f012db27c9516be1a7aca93ea4a6ca9c75056c9
Author:        Alison Schofield <alison.schofield@intel.com>
AuthorDate:    Mon, 10 Jul 2023 13:02:58 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Sep 2023 16:13:05 -07:00

x86/numa: Introduce numa_fill_memblks()

numa_fill_memblks() fills in the gaps in numa_meminfo memblks
over an physical address range.

The ACPI driver will use numa_fill_memblks() to implement a new Linux
policy that prescribes extending proximity domains in a portion of a
CFMWS window to the entire window.

Dan Williams offered this explanation of the policy:
A CFWMS is an ACPI data structure that indicates *potential* locations
where CXL memory can be placed. It is the playground where the CXL
driver has free reign to establish regions. That space can be populated
by BIOS created regions, or driver created regions, after hotplug or
other reconfiguration.

When BIOS creates a region in a CXL Window it additionally describes
that subset of the Window range in the other typical ACPI tables SRAT,
SLIT, and HMAT. The rationale for BIOS not pre-describing the entire
CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
future. I.e. there is nothing stopping higher or lower performance
devices being placed in the same Window. Compare that to ACPI memory
hotplug that just onlines additional capacity in the proximity domain
with little freedom for dynamic performance differentiation.

That leaves the OS with a choice, should unpopulated window capacity
match the proximity domain of an existing region, or should it allocate
a new one? This patch takes the simple position of minimizing proximity
domain proliferation by reusing any proximity domain intersection for
the entire Window. If the Window has no intersections then allocate a
new proximity domain. Note that SRAT, SLIT and HMAT information can be
enumerated dynamically in a standard way from device provided data.
Think of CXL as the end of ACPI needing to describe memory attributes,
CXL offers a standard discovery model for performance attributes, but
Linux still needs to interoperate with the old regime.

Reported-by: Derick Marks <derick.w.marks@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Derick Marks <derick.w.marks@intel.com>
Link: https://lore.kernel.org/all/ef078a6f056ca974e5af85997013c0fda9e3326d.1689018477.git.alison.schofield%40intel.com
---
 arch/x86/include/asm/sparsemem.h |  2 +-
 arch/x86/mm/numa.c               | 80 +++++++++++++++++++++++++++++++-
 include/linux/numa.h             |  7 +++-
 3 files changed, 89 insertions(+)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 64df897..1be13b2 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+extern int numa_fill_memblks(u64 start, u64 end);
+#define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb20..c01c550 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -11,6 +11,7 @@
 #include <linux/nodemask.h>
 #include <linux/sched.h>
 #include <linux/topology.h>
+#include <linux/sort.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
@@ -961,4 +962,83 @@ int memory_add_physaddr_to_nid(u64 start)
 	return nid;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+
+static int __init cmp_memblk(const void *a, const void *b)
+{
+	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
+	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
+
+	return ma->start - mb->start;
+}
+
+static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
+
+/**
+ * numa_fill_memblks - Fill gaps in numa_meminfo memblks
+ * @start: address to begin fill
+ * @end: address to end fill
+ *
+ * Find and extend numa_meminfo memblks to cover the @start-@end
+ * physical address range, such that the first memblk includes
+ * @start, the last memblk includes @end, and any gaps in between
+ * are filled.
+ *
+ * RETURNS:
+ * 0		  : Success
+ * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
+ */
+
+int __init numa_fill_memblks(u64 start, u64 end)
+{
+	struct numa_memblk **blk = &numa_memblk_list[0];
+	struct numa_meminfo *mi = &numa_meminfo;
+	int count = 0;
+	u64 prev_end;
+
+	/*
+	 * Create a list of pointers to numa_meminfo memblks that
+	 * overlap start, end. Exclude (start == bi->end) since
+	 * end addresses in both a CFMWS range and a memblk range
+	 * are exclusive.
+	 *
+	 * This list of pointers is used to make in-place changes
+	 * that fill out the numa_meminfo memblks.
+	 */
+	for (int i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		if (start < bi->end && end >= bi->start) {
+			blk[count] = &mi->blk[i];
+			count++;
+		}
+	}
+	if (!count)
+		return NUMA_NO_MEMBLK;
+
+	/* Sort the list of pointers in memblk->start order */
+	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
+
+	/* Make sure the first/last memblks include start/end */
+	blk[0]->start = min(blk[0]->start, start);
+	blk[count - 1]->end = max(blk[count - 1]->end, end);
+
+	/*
+	 * Fill any gaps by tracking the previous memblks
+	 * end address and backfilling to it if needed.
+	 */
+	prev_end = blk[0]->end;
+	for (int i = 1; i < count; i++) {
+		struct numa_memblk *curr = blk[i];
+
+		if (prev_end >= curr->start) {
+			if (prev_end < curr->end)
+				prev_end = curr->end;
+		} else {
+			curr->start = prev_end;
+			prev_end = curr->end;
+		}
+	}
+	return 0;
+}
+
 #endif
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 59df211..0f512c0 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -12,6 +12,7 @@
 #define MAX_NUMNODES    (1 << NODES_SHIFT)
 
 #define	NUMA_NO_NODE	(-1)
+#define	NUMA_NO_MEMBLK	(-1)
 
 /* optionally keep NUMA memory info available post init */
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
@@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
 	return 0;
 }
 #endif
+#ifndef numa_fill_memblks
+static inline int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+#endif
 #else /* !CONFIG_NUMA */
 static inline int numa_map_to_online_node(int node)
 {
