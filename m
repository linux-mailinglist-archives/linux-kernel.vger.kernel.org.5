Return-Path: <linux-kernel+bounces-29093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D348D830865
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F70B23E78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8923208C5;
	Wed, 17 Jan 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CUTz5A+2"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357211F608;
	Wed, 17 Jan 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502849; cv=none; b=itEARhJ562ue09q7zJyLbsMtFHvYvP5O2kQFPqukysw/Z1M7nveHGq06MGN37Y5WKsW7U5QYgAjXyNkEksHVH47eLaPXvlCHLgbHH8QIkJO7awoplI64li2URln5AxBNeYP9y82H4hQ228GOPiECw+Q+nSgy03iGTzs/mdE76Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502849; c=relaxed/simple;
	bh=FuWXotw+6TssWdelnK2PDSgKEfk0nkyrJ/CdHXTstHU=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=lhDFysd5YTbPcnwidbgXuS3Kafg4U9VqVjQaVBAUNmoY2OWTY7QhcyFIOOJid45IobH6Cr/D0hrTrK/joMxMOEVNT4Tmnu4oue+bw8LHWurJ0CkAtOGCffNuE9rx//vO10uGhMzrXsDAYVoJiQwcclHO0Fk4BNmjJYJLDrSV0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CUTz5A+2; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502849; x=1737038849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a2h6MdQV2mRD+J8ifFNwhQS6K40unvsObC+/dn67/aI=;
  b=CUTz5A+2IQEOGBrjqdNQHhL0l/kVMc9Ed3M3ctmQBoeiavNwVaggglKW
   BA/3WRZlCslRZbcIBqMoYQZSooiw/JBqCSHPIHWd6hcqeYaKIxPIgCSIr
   kYvakZLeWJZOawDFrOnoVNQE6wbXgr/4o41QV9NSWckg/oUc+dl6vyQx1
   8=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="266627607"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:47:25 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 5B3C44A003;
	Wed, 17 Jan 2024 14:47:15 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63957]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.181:2525] with esmtp (Farcaster)
 id 9b1bf5c5-3ab5-41b4-846a-4e8c86c9acd2; Wed, 17 Jan 2024 14:47:14 +0000 (UTC)
X-Farcaster-Flow-ID: 9b1bf5c5-3ab5-41b4-846a-4e8c86c9acd2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:47:14 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:47:10 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 01/17] mm,memblock: Add support for scratch memory
Date: Wed, 17 Jan 2024 14:46:48 +0000
Message-ID: <20240117144704.602-2-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With KHO (Kexec HandOver), we need a way to ensure that the new kernel
does not allocate memory on top of any memory regions that the previous
kernel was handing over. But to know where those are, we need to include
them in the reserved memblocks array which may not be big enough to hold
all allocations. To resize the array, we need to allocate memory. That
brings us into a catch 22 situation.

The solution to that is the scratch region: a safe region to operate in.
KHO provides a "scratch region" as part of its metadata. This scratch
region is a single, contiguous memory block that we know does not
contain any KHO allocations. We can exclusively allocate from there until
we finish kernel initialization to a point where it knows about all the
KHO memory reservations. We introduce a new memblock_set_scratch_only()
function that allows KHO to indicate that any memblock allocation must
happen from the scratch region.

Later, we may want to perform another KHO kexec. For that, we reuse the
same scratch region. To ensure that no eventually handed over data gets
allocated inside that scratch region, we flip the semantics of the scratch
region with memblock_clear_scratch_only(): After that call, no allocations
may happen from scratch memblock regions. We will lift that restriction
in the next patch.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/memblock.h | 19 +++++++++++++
 mm/Kconfig               |  4 +++
 mm/memblock.c            | 61 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b695f9e946da..7e9788f05dea 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -42,6 +42,10 @@ extern unsigned long long max_possible_pfn;
  * kernel resource tree.
  * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are
  * not initialized (only for reserved regions).
+ * @MEMBLOCK_SCRATCH: memory region that kexec can pass to the next kernel in
+ * handover mode. During early boot, we do not know about all memory reservations
+ * yet, so we get scratch memory from the previous kernel that we know is good
+ * to use. It is the only memory that allocations may happen from in this phase.
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -50,6 +54,7 @@ enum memblock_flags {
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
+	MEMBLOCK_SCRATCH	= 0x20,	/* scratch memory for kexec handover */
 };
 
 /**
@@ -130,6 +135,8 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
+int memblock_mark_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_clear_scratch(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
 void memblock_free(void *ptr, size_t size);
@@ -274,6 +281,11 @@ static inline bool memblock_is_driver_managed(struct memblock_region *m)
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
 }
 
+static inline bool memblock_is_scratch(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_SCRATCH;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
@@ -611,5 +623,12 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end) { }
 static inline void memtest_report_meminfo(struct seq_file *m) { }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_SCRATCH
+void memblock_set_scratch_only(void);
+void memblock_clear_scratch_only(void);
+#else
+static inline void memblock_set_scratch_only(void) { }
+static inline void memblock_clear_scratch_only(void) { }
+#endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 1902cfe4cc4f..6cd5e16203ba 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -489,6 +489,10 @@ config ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
+# Enable memblock support for scratch memory which is needed for KHO
+config MEMBLOCK_SCRATCH
+	bool
+
 config HAVE_FAST_GUP
 	depends on MMU
 	bool
diff --git a/mm/memblock.c b/mm/memblock.c
index 8c194d8afeec..fbb98981a202 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -106,6 +106,13 @@ unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
+#ifdef CONFIG_MEMBLOCK_SCRATCH
+/* When set to true, only allocate from MEMBLOCK_SCRATCH ranges */
+static bool scratch_only;
+#else
+#define scratch_only false
+#endif
+
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_MEMORY_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -168,6 +175,10 @@ bool __init_memblock memblock_has_mirror(void)
 
 static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
+	/* skip non-scratch memory for kho early boot allocations */
+	if (scratch_only)
+		return MEMBLOCK_SCRATCH;
+
 	return system_has_some_mirror ? MEMBLOCK_MIRROR : MEMBLOCK_NONE;
 }
 
@@ -643,7 +654,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 #ifdef CONFIG_NUMA
 			WARN_ON(nid != memblock_get_region_node(rgn));
 #endif
-			WARN_ON(flags != rgn->flags);
+			WARN_ON(flags != (rgn->flags & ~MEMBLOCK_SCRATCH));
 			nr_new++;
 			if (insert) {
 				if (start_rgn == -1)
@@ -924,6 +935,18 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_SCRATCH
+__init_memblock void memblock_set_scratch_only(void)
+{
+	scratch_only = true;
+}
+
+__init_memblock void memblock_clear_scratch_only(void)
+{
+	scratch_only = false;
+}
+#endif
+
 /**
  * memblock_setclr_flag - set or clear flag for a memory region
  * @type: memblock type to set/clear flag for
@@ -1049,6 +1072,33 @@ int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t
 				    MEMBLOCK_RSRV_NOINIT);
 }
 
+/**
+ * memblock_mark_scratch - Mark a memory region with flag MEMBLOCK_SCRATCH.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Only memory regions marked with %MEMBLOCK_SCRATCH will be considered for
+ * allocations during early boot with kexec handover.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_scratch(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_SCRATCH);
+}
+
+/**
+ * memblock_clear_scratch - Clear flag MEMBLOCK_SCRATCH for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_scratch(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_SCRATCH);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -1080,6 +1130,14 @@ static bool should_skip_region(struct memblock_type *type,
 	if (!(flags & MEMBLOCK_DRIVER_MANAGED) && memblock_is_driver_managed(m))
 		return true;
 
+	/* In early alloc during kho, we can only consider scratch allocations */
+	if ((flags & MEMBLOCK_SCRATCH) && !memblock_is_scratch(m))
+		return true;
+
+	/* Leave scratch memory alone after scratch-only phase */
+	if (!(flags & MEMBLOCK_SCRATCH) && memblock_is_scratch(m))
+		return true;
+
 	return false;
 }
 
@@ -2246,6 +2304,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
 	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
+	[ilog2(MEMBLOCK_SCRATCH)] = "SCRATCH",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




