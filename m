Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3B75FE44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGXRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGXRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:45:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613B211E;
        Mon, 24 Jul 2023 10:44:20 -0700 (PDT)
Message-ID: <20230724172844.690165660@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=06B9R9WWu/NhNpfU00ZEswPMdWoo9h5RCVxg3fwFQnQ=;
        b=ZNu7GBtxM04eRgFjYxj5my2dx3a3xSrXvcBxlg8D/ugwc2TxPAI7E9UI+Qfi9pdGEBKmMG
        5UUNGaHkNptidA87cUEeH26hWQdhpkFMKT6tGvNzvDBo0pX2mgF3rHRABS580jnWM/wUaR
        YhcTT29oBpaUxBhVEyDU+pI4XVkhmNCFgUx99Kemi9Q9YeqFiv9+URiMVYXFQuREGzpc8e
        o9Vn8vo7K/EBPUBmK69gVktfQPkvtDbeTSi781umjjocPyR8/bLxJaR63iWdr/7KZ8A9VO
        lL5fv8MFEMq83Flqev9tLcV7kx1XAJyNrW+Y0lF9MHoBisb7h505OlZvmChG5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=06B9R9WWu/NhNpfU00ZEswPMdWoo9h5RCVxg3fwFQnQ=;
        b=66PTgASlt00ZrUuJ8Wdio6yRkFe8mdJ6+PHqNOAuSdooc+HNdWWRBrBp3foWmfDZ5LZgYh
        lkMH+th0aXnKuhAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 17/29] x86/cpu: Provide a sane leaf 0xb/0x1f parser
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:17 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 arch/x86/kernel/cpu/Makefile       |    2 
 arch/x86/kernel/cpu/topology.h     |   12 +++
 arch/x86/kernel/cpu/topology_ext.c |  136 +++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)

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
 
 static inline u16 topo_shift_apicid(u16 apicid, enum x86_topology_domains dom)
 {
@@ -31,4 +32,15 @@ static inline u16 topo_relative_domain_i
 	return apicid & (x86_topo_system.dom_size[dom] - 1);
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
@@ -0,0 +1,136 @@
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
+static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf)
+{
+	unsigned int dom, maxtype = leaf == 0xb ? CORE_TYPE + 1 : MAX_TYPE;
+	struct {
+		// eax
+		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
+					      // for the topology ID at the next level
+			__rsvd0		: 27; // Reserved
+					      // ebx
+		u32	num_processors	: 16, // Number of processors at current level
+			__rsvd1		: 16; // Reserved
+					      // ecx
+		u32	level		:  8, // Current topology level. Same as sub leaf number
+			type		:  8, // Level type. If 0, invalid
+			__rsvd2		: 16; // Reserved
+					      // edx
+		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor
+	} sl;
+
+	cpuid_subleaf(leaf, subleaf, &sl);
+
+	if (!sl.num_processors || sl.type == INVALID_TYPE)
+		return false;
+
+	if (sl.type >= maxtype) {
+		/*
+		 * As the subleafs are ordered in domain level order, this
+		 * could be recovered in theory by propagating the
+		 * information at the last parsed level.
+		 *
+		 * But if the infinite wisdom of hardware folks decides to
+		 * create a new domain type between CORE and MODULE or DIE
+		 * and DIEGRP, then that would overwrite the CORE or DIE
+		 * information.
+		 *
+		 * It really would have been too obvious to make the domain
+		 * type space sparse and leave a few reserved types between
+		 * the points which might change instead of forcing
+		 * software to either create a monstrosity of workarounds
+		 * or just being up the creek without a paddle.
+		 *
+		 * Refuse to implement monstrosity, emit an error and try
+		 * to survive.
+		 */
+		pr_err_once("Topology: leaf 0x%x:%d Unknown domain type %u\n",
+			    leaf, subleaf, sl.type);
+		return true;
+	}
+
+	dom = topo_domain_map[sl.type];
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
+	u32 subleaf;
+
+	if (tscan->c->cpuid_level < leaf)
+		return false;
+
+	/* Read all available subleafs and populate the levels */
+	for (subleaf = 0; topo_subleaf(tscan, leaf, subleaf); subleaf++);
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
+		u16 sft = get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
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

