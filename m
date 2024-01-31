Return-Path: <linux-kernel+bounces-45664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9368433BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEA528E959
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227812E4B;
	Wed, 31 Jan 2024 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLIX9Apc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2418AFB;
	Wed, 31 Jan 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667567; cv=none; b=Ik5/Em6J9FL0+K84n7GoauM7/sVdDiDvS1UA9xNjBaaNKX9hYQt1qqT/1O15ASqhoaU5fDiW2pNNOtsh+0wbFzIimmOunupSfOnCdnG11kOd9EoZLE0ALWCVej5YEBVEztaVycuGWx0kqFe+n128nUHOJMsVQs26VQ8aGZdip7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667567; c=relaxed/simple;
	bh=yF0cmRPYM74Wroboq1Me4P8QG6U65gjWBJJ6qce166E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pka4vzOAqSk65SEz0++tJr3nHr5nJdRThrS8V85P2doYjdifKJqxIpPl6aaDEyn+zf+nxz9+qCBIBQvhMlW6OAc+lFxhdD0tuSmswCOJSTWjc94cudNDg1aZSPHuMkr2iKZ7fzMPFmfL/iyILbPBMOzV7wi8+Ga6lgz5OOBJ6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLIX9Apc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706667565; x=1738203565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yF0cmRPYM74Wroboq1Me4P8QG6U65gjWBJJ6qce166E=;
  b=HLIX9Apc1fylpMaVTVbTPVGRzc2bUQbTUv3y0z7ThzvMRIgvxy032zHP
   sG0yS28H1yNw4CDlz3Y80Lv5GRtMPX3tuWFdfIGSLANr80br8yespqGak
   LsII6a5sn3KqypX8A/xsb7g5NL2TvOu8wtKYPO/hcfumfL7KwML957wIx
   7lMmy8kpOs3kEzxSsEuFYjvtLhzmkFQMkgKrfrG/vzVrXs0Co7NpZ3PCi
   pT4Zf54wYaQ/MiMOi/2CMR5/CslRaKVueyGhpaTRS0FzBjbnSgPWXVDJ+
   gDZ16+ea65pBFGdacmEaD4oRM7XeCM31L77zmHEPEFMcE86CeLm4b4p69
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24939189"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="24939189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907714749"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907714749"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:19:16 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	sunilvl@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Baoquan He <bhe@redhat.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 3/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
Date: Wed, 31 Jan 2024 10:32:00 +0800
Message-Id: <799dcc07f41c2357328e9778fbbded7818af34a7.1706603678.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706603678.git.haibo1.xu@intel.com>
References: <cover.1706603678.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add acpi_numa.c file to enable parse NUMA information from
ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
memory nodes to proximity domain mapping, while SLIT table
provide the distance metrics between proximity domains.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/riscv/include/asm/acpi.h |  15 +++-
 arch/riscv/kernel/Makefile    |   1 +
 arch/riscv/kernel/acpi.c      |   5 --
 arch/riscv/kernel/acpi_numa.c | 133 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |   4 +-
 arch/riscv/kernel/smpboot.c   |   2 -
 drivers/acpi/numa/srat.c      |   3 +-
 include/linux/acpi.h          |   4 +
 8 files changed, 156 insertions(+), 11 deletions(-)
 create mode 100644 arch/riscv/kernel/acpi_numa.c

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 7dad0cf9d701..e0a1f84404f3 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 void acpi_init_rintc_map(void);
 struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
-u32 get_acpi_id_for_cpu(int cpu);
+static inline u32 get_acpi_id_for_cpu(int cpu)
+{
+	return acpi_cpu_get_madt_rintc(cpu)->uid;
+}
+
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
-static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
 #else
@@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
 
 #endif /* CONFIG_ACPI */
 
+#ifdef CONFIG_ACPI_NUMA
+int acpi_numa_get_nid(unsigned int cpu);
+void acpi_map_cpus_to_nodes(void);
+#else
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+static inline void acpi_map_cpus_to_nodes(void) { }
+#endif /* CONFIG_ACPI_NUMA */
+
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..5d3e9cf89b76 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -105,3 +105,4 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
 
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
+obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..040bdbfea2b4 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
 	return &cpu_madt_rintc[cpu];
 }
 
-u32 get_acpi_id_for_cpu(int cpu)
-{
-	return acpi_cpu_get_madt_rintc(cpu)->uid;
-}
-
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
new file mode 100644
index 000000000000..493642a61457
--- /dev/null
+++ b/arch/riscv/kernel/acpi_numa.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI 6.6 based NUMA setup for RISCV
+ * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
+ *
+ * Copyright 2004 Andi Kleen, SuSE Labs.
+ * Copyright (C) 2013-2016, Linaro Ltd.
+ *		Author: Hanjun Guo <hanjun.guo@linaro.org>
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
+ *
+ * Called from acpi_numa_init while reading the SRAT and SLIT tables.
+ * Assumes all memory regions belonging to a single proximity domain
+ * are in one chunk. Holes between them will be included in the node.
+ */
+
+#define pr_fmt(fmt) "ACPI: NUMA: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitmap.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+#include <linux/mmzone.h>
+#include <linux/module.h>
+#include <linux/topology.h>
+
+#include <asm/numa.h>
+
+static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
+
+int __init acpi_numa_get_nid(unsigned int cpu)
+{
+	return acpi_early_node_map[cpu];
+}
+
+static inline int get_cpu_for_acpi_id(u32 uid)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (uid == get_acpi_id_for_cpu(cpu))
+			return cpu;
+
+	return -EINVAL;
+}
+
+static int __init acpi_parse_rintc_pxm(union acpi_subtable_headers *header,
+				      const unsigned long end)
+{
+	struct acpi_srat_rintc_affinity *pa;
+	int cpu, pxm, node;
+
+	if (srat_disabled())
+		return -EINVAL;
+
+	pa = (struct acpi_srat_rintc_affinity *)header;
+	if (!pa)
+		return -EINVAL;
+
+	if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
+		return 0;
+
+	pxm = pa->proximity_domain;
+	node = pxm_to_node(pxm);
+
+	/*
+	 * If we can't map the UID to a logical cpu this
+	 * means that the UID is not part of possible cpus
+	 * so we do not need a NUMA mapping for it, skip
+	 * the SRAT entry and keep parsing.
+	 */
+	cpu = get_cpu_for_acpi_id(pa->acpi_processor_uid);
+	if (cpu < 0)
+		return 0;
+
+	acpi_early_node_map[cpu] = node;
+	pr_info("SRAT: PXM %d -> HARTID 0x%lx -> Node %d\n", pxm,
+		cpuid_to_hartid_map(cpu), node);
+
+	return 0;
+}
+
+void __init acpi_map_cpus_to_nodes(void)
+{
+	int i;
+
+	/*
+	 * In ACPI, SMP and CPU NUMA information is provided in separate
+	 * static tables, namely the MADT and the SRAT.
+	 *
+	 * Thus, it is simpler to first create the cpu logical map through
+	 * an MADT walk and then map the logical cpus to their node ids
+	 * as separate steps.
+	 */
+	acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_srat),
+					    ACPI_SRAT_TYPE_RINTC_AFFINITY,
+					    acpi_parse_rintc_pxm, 0);
+
+	for (i = 0; i < nr_cpu_ids; i++)
+		early_map_cpu_to_node(i, acpi_numa_get_nid(i));
+}
+
+/* Callback for Proximity Domain -> logical node ID mapping */
+void __init acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa)
+{
+	int pxm, node;
+
+	if (srat_disabled())
+		return;
+
+	if (pa->header.length < sizeof(struct acpi_srat_rintc_affinity)) {
+		pr_err("SRAT: Invalid SRAT header length: %d\n",
+			pa->header.length);
+		bad_srat();
+		return;
+	}
+
+	if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
+		return;
+
+	pxm = pa->proximity_domain;
+	node = acpi_map_pxm_to_node(pxm);
+
+	if (node == NUMA_NO_NODE) {
+		pr_err("SRAT: Too many proximity domains %d\n", pxm);
+		bad_srat();
+		return;
+	}
+
+	node_set(node, numa_nodes_parsed);
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 4f73c0ae44b2..a2cde65b69e9 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -281,8 +281,10 @@ void __init setup_arch(char **cmdline_p)
 	setup_smp();
 #endif
 
-	if (!acpi_disabled)
+	if (!acpi_disabled) {
 		acpi_init_rintc_map();
+		acpi_map_cpus_to_nodes();
+	}
 
 	riscv_init_cbo_blocksizes();
 	riscv_fill_hwcap();
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 519b6bd946e5..b188d83d1ec4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -101,7 +101,6 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
 	if (hart == cpuid_to_hartid_map(0)) {
 		BUG_ON(found_boot_cpu);
 		found_boot_cpu = true;
-		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
 		return 0;
 	}
 
@@ -111,7 +110,6 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
 	}
 
 	cpuid_to_hartid_map(cpu_count) = hart;
-	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
 	cpu_count++;
 
 	return 0;
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 503abcf6125d..1f0462cef47c 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -219,7 +219,8 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
-#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
+#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH) || \
+	defined(CONFIG_RISCV)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
  * I/O localities since SRAT does not list them.  I/O localities are
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a65273db55c6..be78a9d28927 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -269,8 +269,12 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 
+#ifdef CONFIG_RISCV
+void acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa);
+#else
 static inline void
 acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
+#endif
 
 #ifndef PHYS_CPUID_INVALID
 typedef u32 phys_cpuid_t;
-- 
2.34.1


