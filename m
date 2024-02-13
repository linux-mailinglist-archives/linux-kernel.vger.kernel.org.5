Return-Path: <linux-kernel+bounces-64325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB6853D15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FEB28DB29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48808629F0;
	Tue, 13 Feb 2024 21:19:24 +0000 (UTC)
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99008629EB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859163; cv=none; b=Vk67vOiDezriZdn7ABV0NYJ7JZ0M6lcu4u2RLej4wRhm73kJkHeSSr8U/J3ZvK6okMpIaxOexBzNymjmesKs5FaZWwkjiR4qBNFTZc3nJW4n3InbrMHGB4I+H+CFt20+hELgyNQ9IpHDHVoenZJO74NEBqEaDRA/NmeJ6tJ3UpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859163; c=relaxed/simple;
	bh=5Nd1k/lI6t5KsdtReJT+oMYTJ+uRP6DM5fZF427GcXU=;
	h=From:Date:Subject:To:Cc:In-Reply-To:Message-Id; b=R5XU36jnxXqMZ9hNYbo9QZliBVMq3TZ7QhoBCTgBWfGlW1pqbZTpQaMxzuDwcw41/JcFec6PuyXXKn6p6UUHMuHG0XKVZ5FRv+Jg2lzILGFKcyVZO5ZnWztQqa7kF08EXURREp2fQuveQFMwA03xDerX4vfmM/kyhMq5NfWEdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.lenovo.com; spf=pass smtp.mailfrom=motorola.com; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.17.1.24/8.17.1.24) with ESMTP id 41DIquMJ018802;
	Tue, 13 Feb 2024 21:18:27 GMT
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by m0355090.ppops.net (PPS) with ESMTPS id 3w88298ydq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 21:18:27 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4TZDhL6Pr5z51Q8g;
	Tue, 13 Feb 2024 21:18:26 +0000 (UTC)
Received: from ilclbld243.mot.com (ilclbld243.mot.com [100.64.22.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4TZDhL5C5Hz3p8NW;
	Tue, 13 Feb 2024 21:18:26 +0000 (UTC)
X-Mailbox-Line: From 4f16ba94cfe7625362d1df20642fee9b9ecec226 Mon Sep 17 00:00:00 2001
From: Maxwell Bland <mbland@debian.lenovo.com>
Date: Tue, 13 Feb 2024 14:18:15 -0600
Subject: Re: [PATCH] arm64: allow post-init vmalloc PXNTable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>,
        "david@redhat.com" <david@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gshan@redhat.com" <gshan@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Andrew Wheeler <awheeler@motorola.com>
In-Reply-To: <2024021321-scooter-citrus-233c@gregkh>
Message-Id: <4TZDhL5C5Hz3p8NW@ilclmmrp02.lenovo.com>
X-Proofpoint-ORIG-GUID: fM-dRVtHmGGBuWF6Pm8rfHSnF0drw95I
X-Proofpoint-GUID: fM-dRVtHmGGBuWF6Pm8rfHSnF0drw95I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_13,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 clxscore=1034 priorityscore=1501 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130167
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Ensures that PXNTable can be set on all table descriptors allocated
through vmalloc. Normally, PXNTable is set only during initial memory
mapping and does not apply thereafter, making it possible for attackers
to target post-init allocated writable PTEs as a staging region for
injection of their code into the kernel. Presently it is not possible to
efficiently prevent these attacks as VMALLOC_END overlaps with _text,
e.g.:

VMALLOC_START ffff800080000000 VMALLOC_END fffffbfff0000000
_text         ffffb6c0c1400000 _end        ffffb6c0c3e40000

Setting VMALLOC_END to _text in init would resolve this issue with the
caveat of a sizeable reduction in the size of available vmalloc memory
(~70,000 GB) due to requirements on aslr randomness. However, we need to
support the enforcement of PXNTable dynamically for our static
assignment of this flag during mm initialization to be effective.

Because the address of _text is aslr-sensitive and this patch associates
this value with VMALLOC_END, we remove the use of VMALLOC_END in a print
statement in mm/percpu.c. However, only the format string is updated in
crash_core.c, since we are dead at that point regardless. VMALLOC_END is
updated in kernel/setup.c to associate the feature closely with aslr and
region allocation code.

bpf_jit_comp.c must also be remediated to ensure that the module_alloc
rather than vmalloc interface is used, so that regions used for BPF
allocations are appropriately located into the _text region.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---

This is an attempt to get Moto's SMTP server to send the patch without ruining
the formatting. Based on Mark R.'s comments, though, it sounds like:

1) I need to figure out a way to reduce the reduction in virtual memory.
2) I need to actually enforce PXNTable dynamically, to make it clear this is a
real upstream issue.
3) I need some testing and quantification to make sure this does not ruin BPF
and module allocations.

https://lore.kernel.org/all/ZcurbvkUR-BoGTxu@FVFF77S0Q05N.cambridge.arm.com/

Regardless, here's the original patch on the current Github linux main.

 arch/arm64/Kconfig                   | 13 +++++++++++++
 arch/arm64/include/asm/pgtable.h     |  6 ++++++
 arch/arm64/include/asm/vmalloc-pxn.h |  9 +++++++++
 arch/arm64/kernel/crash_core.c       |  2 +-
 arch/arm64/kernel/setup.c            |  9 +++++++++
 arch/arm64/net/bpf_jit_comp.c        |  5 +++--
 mm/percpu.c                          |  4 ++--
 7 files changed, 43 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/vmalloc-pxn.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..5f1e75d70e14 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2165,6 +2165,19 @@ config ARM64_DEBUG_PRIORITY_MASKING
          If unsure, say N
 endif # ARM64_PSEUDO_NMI

+config ARM64_VMALLOC_PXN
+       bool "Ensures table descriptors pointing to kernel data are PXNTable"
+       help
+         Reduces the range of the kernel data vmalloc region to remove any
+         overlap with kernel code, making it possible to enable the PXNTable
+         bit on table descriptors allocated after the kernel's initial memory
+         mapping.
+
+         This increases the performance of security monitors which protect
+         against malicious updates to page table entries.
+
+         If unsure, say N.
+
 config RELOCATABLE
        bool "Build a relocatable kernel image" if EXPERT
        select ARCH_HAS_RELR
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 79ce70fbb751..49f64ea77c81 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -22,7 +22,9 @@
  *     and fixed mappings
  */
 #define VMALLOC_START          (MODULES_END)
+#ifndef CONFIG_ARM64_VMALLOC_PXN
 #define VMALLOC_END            (VMEMMAP_START - SZ_256M)
+#endif

 #define vmemmap                        ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))

@@ -35,6 +37,10 @@
 #include <linux/sched.h>
 #include <linux/page_table_check.h>

+#ifdef CONFIG_ARM64_VMALLOC_PXN
+#include <asm/vmalloc-pxn.h>
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE

diff --git a/arch/arm64/include/asm/vmalloc-pxn.h b/arch/arm64/include/asm/vmalloc-pxn.h
new file mode 100644
index 000000000000..d054427e2804
--- /dev/null
+++ b/arch/arm64/include/asm/vmalloc-pxn.h
@@ -0,0 +1,9 @@
+#ifndef _ASM_ARM64_VMALLOC_PXN_H
+#define _ASM_ARM64_VMALLOC_PXN_H
+
+#ifdef CONFIG_ARM64_VMALLOC_PXN
+extern u64 __vmalloc_end __ro_after_init;
+#define VMALLOC_END (__vmalloc_end)
+#endif /* CONFIG_ARM64_VMALLOC_PXN */
+
+#endif /* _ASM_ARM64_VMALLOC_PXN_H */
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index 66cde752cd74..39dccae11a40 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -24,7 +24,7 @@ void arch_crash_save_vmcoreinfo(void)
        vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
        vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
        vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
-       vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+       vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%llx\n", VMALLOC_END);
        vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
        vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
        vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42c690bb2d60..b7ccee672743 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -54,6 +54,11 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/mmu_context.h>

+#ifdef CONFIG_ARM64_VMALLOC_PXN
+u64 __vmalloc_end __ro_after_init = VMEMMAP_START - SZ_256M;
+EXPORT_SYMBOL(__vmalloc_end);
+#endif /* CONFIG_ARM64_VMALLOC_PXN */
+
 static int num_standard_resources;
 static struct resource *standard_resources;

@@ -298,6 +303,10 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)

        kaslr_init();

+#ifdef CONFIG_ARM64_VMALLOC_PXN
+       __vmalloc_end = ALIGN_DOWN((u64) _text, PMD_SIZE);
+#endif
+
        /*
         * If know now we are going to need KPTI then use non-global
         * mappings from the start, avoiding the cost of rewriting
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8955da5c47cf..1fe0d637792c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
+#include <linux/moduleloader.h>
 #include <linux/printk.h>
 #include <linux/slab.h>

@@ -1690,12 +1691,12 @@ u64 bpf_jit_alloc_exec_limit(void)
 void *bpf_jit_alloc_exec(unsigned long size)
 {
        /* Memory is intended to be executable, reset the pointer tag. */
-       return kasan_reset_tag(vmalloc(size));
+       return kasan_reset_tag(module_alloc(size));
 }

 void bpf_jit_free_exec(void *addr)
 {
-       return vfree(addr);
+       return module_memfree(addr);
 }

 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..a902500ebfa0 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3128,8 +3128,8 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,

        /* warn if maximum distance is further than 75% of vmalloc space */
        if (max_distance > VMALLOC_TOTAL * 3 / 4) {
-               pr_warn("max_distance=0x%lx too large for vmalloc space 0x%lx\n",
-                               max_distance, VMALLOC_TOTAL);
+               pr_warn("max_distance=0x%lx too large for vmalloc space\n",
+                               max_distance);
 #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
                /* and fail if we have fallback */
                rc = -EINVAL;
--
2.39.2


