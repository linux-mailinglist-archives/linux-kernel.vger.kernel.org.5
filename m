Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5277B4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjHNI4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjHNIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE46E7D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:19 -0700 (PDT)
Message-ID: <20230814085113.705691574@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Vh23GAdKR2k+QgZKWm5uISvklevqGJQMFU6tYsix5zs=;
        b=4x/gIiJgvOC9ExMD46ZjigfBn1QjSxY1u9X3GzSq4Qs9joFiDkSa2pQ7ldUJXBjJJSCXqY
        /RnS/oWE1vuf+naobFOdd6N5FXzfvVs53TBU8l3qv77O95oQkMahD81HUIS/wKEiRKqA3x
        XnrgrSR6eTfI4aakdDTWyvuqi65OoRvtPtBQvqGH83y1A99x+tauKE6ie/xHsL3LRnL+GT
        Df38BPHrc0b/7UubWkcgsOAqWKEj64AtlrX/ZlXMzEC8i31Za+Vx2ftBZbB/TLSj9xG3iT
        LX/vhW3P600WvM2/kF+TkHkuiRmH82O+Jp6JggKHgzy7cwO2ytlmg9eLsSMT8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Vh23GAdKR2k+QgZKWm5uISvklevqGJQMFU6tYsix5zs=;
        b=x9tVDmMAAWHT2+ywu1Fu0gGVJPUwV0un4LeboWcKD+O19Fl0txixqGCXAeRNCtrzLJyky+
        eLZ2hTlWX4TNuABQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 28/41] x86/cpu: Provide a sane leaf 0xb/0x1f parser
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:17 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

detect_extended_topology() along with it's early() variant is a classic
example for duct tape engineering:

  - It evaluates an array of subleafs with a boatload of local variables
    for the relevant topology levels instead of using an array to save the
    enumerated information and propagate it to the right level

  - It has no boundary checks for subleafs

  - It prevents updating the die_id with a crude workaround instead of
    checking for leaf 0xb which does not provide die information.

  - It's broken vs. the number of dies evaluation as it uses:

      num_processors[DIE_LEVEL] / num_processors[CORE_LEVEL]

    which "works" only correctly if there is none of the intermediate
    topology levels (MODULE/TILE) enumerated.

There is zero value in trying to "fix" that code as the only proper fix is
to rewrite it from scratch.

Implement a sane parser with proper code documentation, which will be used
for the consolidated topology evaluation in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
V4: Handle unknown domain types gracefully - Rui
V2: Fixed up the comment alignment for registers - Peterz
---
 arch/x86/kernel/cpu/Makefile       |    2 
 arch/x86/kernel/cpu/topology.h     |   12 +++
 arch/x86/kernel/cpu/topology_ext.c |  132 +++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -18,7 +18,7 @@ KMSAN_SANITIZE_common.o := n
 KCSAN_SANITIZE_common.o := n
 
 obj-y			:= cacheinfo.o scattered.o
-obj-y			+= topology_common.o topology.o
+obj-y			+= topology_common.o topology_ext.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -16,6 +16,7 @@ void cpu_init_topology(struct cpuinfo_x8
 void cpu_parse_topology(struct cpuinfo_x86 *c);
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 		      unsigned int shift, unsigned int ncpus);
+bool cpu_parse_topology_ext(struct topo_scan *tscan);
 
 static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
 {
@@ -36,4 +37,15 @@ static inline u32 topo_domain_mask(enum
 	return (1U << x86_topo_system.dom_shifts[dom]) - 1;
 }
 
+/*
+ * Update a domain level after the fact without propagating. Used to fixup
+ * broken CPUID enumerations.
+ */
+static inline void topology_update_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
+				       unsigned int shift, unsigned int ncpus)
+{
+	tscan->dom_shifts[dom] = shift;
+	tscan->dom_ncpus[dom] = ncpus;
+}
+
 #endif /* ARCH_X86_TOPOLOGY_H */
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+
+#include <asm/apic.h>
+#include <asm/memtype.h>
+#include <asm/processor.h>
+
+#include "cpu.h"
+
+enum topo_types {
+	INVALID_TYPE	= 0,
+	SMT_TYPE	= 1,
+	CORE_TYPE	= 2,
+	MODULE_TYPE	= 3,
+	TILE_TYPE	= 4,
+	DIE_TYPE	= 5,
+	DIEGRP_TYPE	= 6,
+	MAX_TYPE	= 7,
+};
+
+/*
+ * Use a lookup table for the case that there are future types > 6 which
+ * describe an intermediate domain level which does not exist today.
+ *
+ * A table will also be handy to parse the new AMD 0x80000026 leaf which
+ * has defined different domain types, but otherwise uses the same layout
+ * with some of the reserved bits used for new information.
+ */
+static const unsigned int topo_domain_map[MAX_TYPE] = {
+	[SMT_TYPE]	= TOPO_SMT_DOMAIN,
+	[CORE_TYPE]	= TOPO_CORE_DOMAIN,
+	[MODULE_TYPE]	= TOPO_MODULE_DOMAIN,
+	[TILE_TYPE]	= TOPO_TILE_DOMAIN,
+	[DIE_TYPE]	= TOPO_DIE_DOMAIN,
+	[DIEGRP_TYPE]	= TOPO_PKG_DOMAIN,
+};
+
+static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
+				unsigned int *last_dom)
+{
+	unsigned int dom, maxtype = leaf == 0xb ? CORE_TYPE + 1 : MAX_TYPE;
+	struct {
+		// eax
+		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
+					      // for the topology ID at the next level
+			__rsvd0		: 27; // Reserved
+		// ebx
+		u32	num_processors	: 16, // Number of processors at current level
+			__rsvd1		: 16; // Reserved
+		// ecx
+		u32	level		:  8, // Current topology level. Same as sub leaf number
+			type		:  8, // Level type. If 0, invalid
+			__rsvd2		: 16; // Reserved
+		// edx
+		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor
+	} sl;
+
+	cpuid_subleaf(leaf, subleaf, &sl);
+
+	if (!sl.num_processors || sl.type == INVALID_TYPE)
+		return false;
+
+	if (sl.type >= maxtype) {
+		pr_err_once("Topology: leaf 0x%x:%d Unknown domain type %u\n",
+			    leaf, subleaf, sl.type);
+		/*
+		 * The subleafs are ordered in domain level order so
+		 * propagate it into the next domain level carefully: if
+		 * the last domain level was PKG, then overwrite PKG
+		 * as otherwise this would end up in the root domain.
+		 *
+		 * It really would have been too obvious to make the domain
+		 * type space sparse and leave a few reserved types between
+		 * the points which might change instead of following the
+		 * usual "this can be fixed in software" principle.
+		 */
+		dom = *last_dom == TOPO_PKG_DOMAIN ? TOPO_PKG_DOMAIN : *last_dom + 1;
+	} else {
+		dom = topo_domain_map[sl.type];
+		*last_dom = dom;
+	}
+
+	if (!dom) {
+		tscan->c->topo.initial_apicid = sl.x2apic_id;
+	} else if (tscan->c->topo.initial_apicid != sl.x2apic_id) {
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf %d APIC ID mismatch %x != %x\n",
+			     leaf, subleaf, tscan->c->topo.initial_apicid, sl.x2apic_id);
+	}
+
+	topology_set_dom(tscan, dom, sl.x2apic_shift, sl.num_processors);
+	return true;
+}
+
+static bool parse_topology_leaf(struct topo_scan *tscan, u32 leaf)
+{
+	unsigned int last_dom;
+	u32 subleaf;
+
+	if (tscan->c->cpuid_level < leaf)
+		return false;
+
+	/* Read all available subleafs and populate the levels */
+	for (subleaf = 0, last_dom = 0; topo_subleaf(tscan, leaf, subleaf, &last_dom); subleaf++);
+
+	/* If subleaf 0 failed to parse, give up */
+	if (!subleaf)
+		return false;
+
+	/*
+	 * There are machines in the wild which have shift 0 in the subleaf
+	 * 0, but advertise 2 logical processors at that level. They are
+	 * truly SMT.
+	 */
+	if (!tscan->dom_shifts[TOPO_SMT_DOMAIN] && tscan->dom_ncpus[TOPO_SMT_DOMAIN] > 1) {
+		unsigned int sft = get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs\n",
+			     leaf, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+		topology_update_dom(tscan, TOPO_SMT_DOMAIN, sft, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+	}
+
+	set_cpu_cap(tscan->c, X86_FEATURE_XTOPOLOGY);
+	return true;
+}
+
+bool cpu_parse_topology_ext(struct topo_scan *tscan)
+{
+	/* Try lead 0x1F first. If not available try leaf 0x0b */
+	if (parse_topology_leaf(tscan, 0x1f))
+		return true;
+	return parse_topology_leaf(tscan, 0x0b);
+}

