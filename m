Return-Path: <linux-kernel+bounces-10019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C681CECF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0976A1F23704
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958A2EAEC;
	Fri, 22 Dec 2023 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g77HFlO0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674382E821;
	Fri, 22 Dec 2023 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273822; x=1734809822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xGjqrLykSTwB3EIMfRg1ZA2o/Dhb+jatNBEObJviGoc=;
  b=g77HFlO0/aM0rKUKqgai/xLj9+t9kwdxpaaNF6zBQ6jnZfCyjZTRUmf5
   wDaonNX8iKcthsMJsdDRaW+lVXpy1mji75LJFA7nkvKutfVg+X3mRJ+61
   fjJ5vc4YRrmCD+k8wukTIDxingwS1rKAAiZfdBIA1OYBomTo2BfVHitEq
   o=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="375893880"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:36:59 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 1F6A1A0864;
	Fri, 22 Dec 2023 19:36:51 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:8455]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.150:2525] with esmtp (Farcaster)
 id f844e829-bc2a-438e-a699-5c7865192502; Fri, 22 Dec 2023 19:36:51 +0000 (UTC)
X-Farcaster-Flow-ID: f844e829-bc2a-438e-a699-5c7865192502
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:51 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:47 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH v2 04/17] kexec: Add KHO parsing support
Date: Fri, 22 Dec 2023 19:35:54 +0000
Message-ID: <20231222193607.15474-5-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222193607.15474-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When we have a KHO kexec, we get a device tree, mem cache and scratch
region to populate the state of the system. Provide helper functions
that allow architecture code to easily handle memory reservations based
on them and give device drivers visibility into the KHO DT and memory
reservations so they can recover their own state.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - make kho_get_fdt() const
  - Add stubs for return_mem and claim_mem
---
 Documentation/ABI/testing/sysfs-firmware-kho |   9 +
 MAINTAINERS                                  |   1 +
 include/linux/kexec.h                        |  27 +-
 kernel/Makefile                              |   1 +
 kernel/kexec_kho_in.c                        | 298 +++++++++++++++++++
 5 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-kho
 create mode 100644 kernel/kexec_kho_in.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-kho b/Documentation/ABI/testing/sysfs-firmware-kho
new file mode 100644
index 000000000000..e4ed2cb7c810
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-kho
@@ -0,0 +1,9 @@
+What:		/sys/firmware/kho/dt
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		When the kernel was booted with Kexec HandOver (KHO),
+		the device tree that carries metadata about the previous
+		kernel's state is in this file. This file may disappear
+		when all consumers of it finished to interpret their
+		metadata.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a19bd282dd0..61bdfd47bb23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11713,6 +11713,7 @@ M:	Eric Biederman <ebiederm@xmission.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
+F:	Documentation/ABI/testing/sysfs-firmware-kho
 F:	Documentation/ABI/testing/sysfs-kernel-kho
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5d3b6b015838..765f71976230 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -528,13 +528,38 @@ enum kho_event {
 extern phys_addr_t kho_scratch_phys;
 extern phys_addr_t kho_scratch_len;
 
+/* ingest handover metadata */
+void kho_reserve_previous_mem(void);
+void kho_populate(phys_addr_t dt_phys, phys_addr_t scratch_phys, u64 scratch_len,
+		  phys_addr_t mem_phys, u64 mem_len);
+void kho_populate_refcount(void);
+const void *kho_get_fdt(void);
+void kho_return_mem(const struct kho_mem *mem);
+void *kho_claim_mem(const struct kho_mem *mem);
+static inline bool is_kho_boot(void)
+{
+	return !!kho_scratch_phys;
+}
+
 /* egest handover metadata */
 void kho_reserve_scratch(void);
 int register_kho_notifier(struct notifier_block *nb);
 int unregister_kho_notifier(struct notifier_block *nb);
 bool kho_is_active(void);
 #else
-static inline void kho_reserve_scratch(void) {}
+/* ingest handover metadata */
+static inline void kho_reserve_previous_mem(void) { }
+static inline void kho_populate(phys_addr_t dt_phys, phys_addr_t scratch_phys,
+				u64 scratch_len, phys_addr_t mem_phys,
+				u64 mem_len) { }
+static inline void kho_populate_refcount(void) { }
+static inline void *kho_get_fdt(void) { return NULL; }
+static inline void kho_return_mem(const struct kho_mem *mem) { }
+static inline void *kho_claim_mem(const struct kho_mem *mem) { return NULL; }
+static inline bool is_kho_boot(void) { return false; }
+
+/* egest handover metadata */
+static inline void kho_reserve_scratch(void) { }
 static inline int register_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
 static inline int unregister_kho_notifier(struct notifier_block *nb) { return -EINVAL; }
 static inline bool kho_is_active(void) { return false; }
diff --git a/kernel/Makefile b/kernel/Makefile
index a6bd31e22c09..7c3065e40c75 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KEXEC_KHO) += kexec_kho_in.o
 obj-$(CONFIG_KEXEC_KHO) += kexec_kho_out.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
diff --git a/kernel/kexec_kho_in.c b/kernel/kexec_kho_in.c
new file mode 100644
index 000000000000..5f8e0d9f9e12
--- /dev/null
+++ b/kernel/kexec_kho_in.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_kho_in.c - kexec handover code to ingest metadata.
+ * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kexec.h>
+#include <linux/device.h>
+#include <linux/compiler.h>
+#include <linux/io.h>
+#include <linux/kmsg_dump.h>
+#include <linux/memblock.h>
+
+/* The kho dt during runtime */
+static void *fdt;
+
+/* Globals to hand over phys/len from early to runtime */
+static phys_addr_t handover_phys __initdata;
+static u32 handover_len __initdata;
+
+static phys_addr_t mem_phys __initdata;
+static u32 mem_len __initdata;
+
+phys_addr_t kho_scratch_phys;
+phys_addr_t kho_scratch_len;
+
+const void *kho_get_fdt(void)
+{
+	return fdt;
+}
+EXPORT_SYMBOL_GPL(kho_get_fdt);
+
+/**
+ * kho_populate_refcount - Scan the DT for any memory ranges. Increase the
+ * affected pages' refcount by 1 for each.
+ */
+__init void kho_populate_refcount(void)
+{
+	const void *fdt = kho_get_fdt();
+	void *mem_virt = __va(mem_phys);
+	int offset = 0, depth = 0, initial_depth = 0, len;
+
+	if (!fdt)
+		return;
+
+	/* Go through the mem list and add 1 for each reference */
+	for (offset = 0;
+	     offset >= 0 && depth >= initial_depth;
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		const struct kho_mem *mems;
+		u32 i;
+
+		mems = fdt_getprop(fdt, offset, "mem", &len);
+		if (!mems || len & (sizeof(*mems) - 1))
+			continue;
+
+		for (i = 0; i < len; i += sizeof(*mems)) {
+			const struct kho_mem *mem = ((void *)mems) + i;
+			u64 start_pfn = PFN_DOWN(mem->addr);
+			u64 end_pfn = PFN_UP(mem->addr + mem->len);
+			u64 pfn;
+
+			for (pfn = start_pfn; pfn < end_pfn; pfn++)
+				get_page(pfn_to_page(pfn));
+		}
+	}
+
+	/*
+	 * Then reduce the reference count by 1 to offset the initial ref count
+	 * of 1. In addition, unreserve the page. That way, we can free_page()
+	 * it for every consumer and automatically free it to the global memory
+	 * pool when everyone is done.
+	 */
+	for (offset = 0; offset < mem_len; offset += sizeof(struct kho_mem)) {
+		struct kho_mem *mem = mem_virt + offset;
+		u64 start_pfn = PFN_DOWN(mem->addr);
+		u64 end_pfn = PFN_UP(mem->addr + mem->len);
+		u64 pfn;
+
+		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+			struct page *page = pfn_to_page(pfn);
+
+			/*
+			 * This is similar to free_reserved_page(), but
+			 * preserves the reference count
+			 */
+			ClearPageReserved(page);
+			__free_page(page);
+			adjust_managed_page_count(page, 1);
+		}
+	}
+}
+
+static void kho_return_pfn(ulong pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+
+	if (WARN_ON(!page))
+		return;
+	__free_page(page);
+}
+
+/**
+ * kho_return_mem - Notify the kernel that initially reserved memory is no
+ * longer needed. When the last consumer of a page returns their mem, kho
+ * returns the page to the buddy allocator as free page.
+ */
+void kho_return_mem(const struct kho_mem *mem)
+{
+	uint64_t start_pfn, end_pfn, pfn;
+
+	start_pfn = PFN_DOWN(mem->addr);
+	end_pfn = PFN_UP(mem->addr + mem->len);
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++)
+		kho_return_pfn(pfn);
+}
+EXPORT_SYMBOL_GPL(kho_return_mem);
+
+static void kho_claim_pfn(ulong pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+
+	WARN_ON(!page);
+	if (WARN_ON(page_count(page) != 1))
+		pr_err("Claimed non kho pfn %lx", pfn);
+}
+
+/**
+ * kho_claim_mem - Notify the kernel that a handed over memory range is now in
+ * use by a kernel subsystem and considered an allocated page. This function
+ * removes the reserved state for all pages that the mem spans.
+ */
+void *kho_claim_mem(const struct kho_mem *mem)
+{
+	u64 start_pfn, end_pfn, pfn;
+	void *va = __va(mem->addr);
+
+	start_pfn = PFN_DOWN(mem->addr);
+	end_pfn = PFN_UP(mem->addr + mem->len);
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++)
+		kho_claim_pfn(pfn);
+
+	return va;
+}
+EXPORT_SYMBOL_GPL(kho_claim_mem);
+
+/**
+ * kho_reserve_previous_mem - Adds all memory reservations into memblocks
+ * and moves us out of the scratch only phase. Must be called after page tables
+ * are initialized and memblock_allow_resize().
+ */
+void __init kho_reserve_previous_mem(void)
+{
+	void *mem_virt = __va(mem_phys);
+	int off, err;
+
+	if (!handover_phys || !mem_phys)
+		return;
+
+	/*
+	 * We reached here because we are running inside a working linear map
+	 * that allows us to resize memblocks dynamically. Use the chance and
+	 * populate the global fdt pointer
+	 */
+	fdt = __va(handover_phys);
+
+	off = fdt_path_offset(fdt, "/");
+	if (off < 0) {
+		fdt = NULL;
+		return;
+	}
+
+	err = fdt_node_check_compatible(fdt, off, "kho-v1");
+	if (err) {
+		pr_warn("KHO has invalid compatible, disabling.");
+		return;
+	}
+
+	/* Then populate all preserved memory areas as reserved */
+	for (off = 0; off < mem_len; off += sizeof(struct kho_mem)) {
+		struct kho_mem *mem = mem_virt + off;
+
+		memblock_reserve(mem->addr, mem->len);
+	}
+
+	/* Unreserve the mem cache - we don't need it from here on */
+	memblock_phys_free(mem_phys, mem_len);
+
+	/*
+	 * Now we know about all memory reservations, release the scratch only
+	 * constraint and allow normal allocations from the scratch region.
+	 */
+	memblock_clear_scratch_only();
+}
+
+/* Handling for /sys/firmware/kho */
+static struct kobject *kho_kobj;
+
+static ssize_t raw_read(struct file *file, struct kobject *kobj,
+			struct bin_attribute *attr, char *buf,
+			loff_t pos, size_t count)
+{
+	memcpy(buf, attr->private + pos, count);
+	return count;
+}
+
+static BIN_ATTR(dt, 0400, raw_read, NULL, 0);
+
+static __init int kho_in_init(void)
+{
+	int ret = 0;
+
+	if (!fdt)
+		return 0;
+
+	kho_kobj = kobject_create_and_add("kho", firmware_kobj);
+	if (!kho_kobj) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	bin_attr_dt.size = fdt_totalsize(fdt);
+	bin_attr_dt.private = fdt;
+	ret = sysfs_create_bin_file(kho_kobj, &bin_attr_dt);
+	if (ret)
+		goto err;
+
+err:
+	return ret;
+}
+subsys_initcall(kho_in_init);
+
+void __init kho_populate(phys_addr_t handover_dt_phys, phys_addr_t scratch_phys,
+			 u64 scratch_len, phys_addr_t mem_cache_phys,
+			 u64 mem_cache_len)
+{
+	void *handover_dt;
+
+	/* Determine the real size of the DT */
+	handover_dt = early_memremap(handover_dt_phys, sizeof(struct fdt_header));
+	if (!handover_dt) {
+		pr_warn("setup: failed to memremap kexec FDT (0x%llx)\n", handover_dt_phys);
+		return;
+	}
+
+	if (fdt_check_header(handover_dt)) {
+		pr_warn("setup: kexec handover FDT is invalid (0x%llx)\n", handover_dt_phys);
+		early_memunmap(handover_dt, PAGE_SIZE);
+		return;
+	}
+
+	handover_len = fdt_totalsize(handover_dt);
+	handover_phys = handover_dt_phys;
+
+	/* Reserve the DT so we can still access it in late boot */
+	memblock_reserve(handover_phys, handover_len);
+
+	/* Reserve the mem cache so we can still access it later */
+	memblock_reserve(mem_cache_phys, mem_cache_len);
+
+	/*
+	 * We pass a safe contiguous block of memory to use for early boot purporses from
+	 * the previous kernel so that we can resize the memblock array as needed.
+	 */
+	memblock_add(scratch_phys, scratch_len);
+
+	if (WARN_ON(memblock_mark_scratch(scratch_phys, scratch_len))) {
+		pr_err("Kexec failed to mark the scratch region. Disabling KHO.");
+		handover_len = 0;
+		handover_phys = 0;
+		return;
+	}
+	pr_debug("Marked 0x%lx+0x%lx as scratch", (long)scratch_phys, (long)scratch_len);
+
+	/*
+	 * Now that we have a viable region of scratch memory, let's tell the memblocks
+	 * allocator to only use that for any allocations. That way we ensure that nothing
+	 * scribbles over in use data while we initialize the page tables which we will need
+	 * to ingest all memory reservations from the previous kernel.
+	 */
+	memblock_set_scratch_only();
+
+	early_memunmap(handover_dt, sizeof(struct fdt_header));
+
+	/* Remember the mem cache location for kho_reserve_previous_mem() */
+	mem_len = mem_cache_len;
+	mem_phys = mem_cache_phys;
+
+	/* Remember the scratch block - we will reuse it again for the next kexec */
+	kho_scratch_phys = scratch_phys;
+	kho_scratch_len = scratch_len;
+
+	pr_info("setup: Found kexec handover data. Will skip init for some devices\n");
+}
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




