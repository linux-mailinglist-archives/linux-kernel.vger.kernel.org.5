Return-Path: <linux-kernel+bounces-139605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2DF8A054B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC27B22275
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50246217D;
	Thu, 11 Apr 2024 01:05:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D429860B96
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797521; cv=none; b=Gi9Wsa8KEi5NPR8kH59DmKkgJFiaMKgJfhkbrUosWsm+s6CyRGpzjsa2qFJTGeBVgc1GENbVIkq+5dEvJW+OuBfGhzGPjkEtT7vdgFDuBzFZtfzqjN/kCECCL5KCSZ9E3+HjQ/2rpYcgdsZm/fwWFJG6QNuyw+egUnMjzqP1/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797521; c=relaxed/simple;
	bh=NeuRh8D5vX5nUv9iOk2eSOKmIKgQFNfWLUUhe4orCWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5llM12hBQ2Zup5gy0L4xC0I5PFxEPrDuEn2qfGRscCGdGkdZPeQnmbAYCs7GxFK2jPC5rtc3V4w4PJmY3WW2vKqW3qWo1W9mo7HX0ll+G9CXO4tPQ3siVSQcJiGRVV1xjebg+CiLcNNqzIDW0s7Zmv7/HaEP/06wdJkh9BHrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxjrtLNxdm6JAlAA--.6451S3;
	Thu, 11 Apr 2024 09:05:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhhFHNxdmnrx3AA--.22869S3;
	Thu, 11 Apr 2024 09:05:14 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 1/4] LoongArch: Move CONFIG_HAVE_SETUP_PER_CPU_AREA related code to smp.c
Date: Thu, 11 Apr 2024 09:05:07 +0800
Message-ID: <20240411010510.22135-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240411010510.22135-1-yangtiezhu@loongson.cn>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxhhFHNxdmnrx3AA--.22869S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4fZw4kZrW8XFW3Cr48uFX_yoW7ArW3pr
	WfC39xtrW3W3s8J398t3yDury5Jr1kK3yxXa13CFWru3W7ZFn8Wr4vvryDXFWUWaykWa1F
	vFZ5GF4UWF48JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Gii3UUUUU==

Currently, if CONFIG_NUMA is not set but CONFIG_SMP is set, the arch
specified setup_per_cpu_areas() in arch/loongarch/kernel/numa.c will
not be built and the generic setup_per_cpu_areas() in mm/percpu.c is
actually used, this is not reasonable and does not work as intended.

Let us select HAVE_SETUP_PER_CPU_AREA unconditionally and then move
CONFIG_HAVE_SETUP_PER_CPU_AREA related code from numa.c to smp.c to
avoid this problem.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig       |  2 +-
 arch/loongarch/kernel/numa.c | 58 -----------------------------------
 arch/loongarch/kernel/smp.c  | 59 ++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..64052ae2c2af 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -151,7 +151,7 @@ config LOONGARCH
 	select HAVE_RUST
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
-	select HAVE_SETUP_PER_CPU_AREA if NUMA
+	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_STACK_VALIDATION if HAVE_OBJTOOL
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 8fe21f868f72..49dc1d932ce2 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -48,64 +48,6 @@ EXPORT_SYMBOL(__cpuid_to_node);
 
 nodemask_t numa_nodes_parsed __initdata;
 
-#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
-unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
-EXPORT_SYMBOL(__per_cpu_offset);
-
-static int __init pcpu_cpu_to_node(int cpu)
-{
-	return early_cpu_to_node(cpu);
-}
-
-static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
-{
-	if (early_cpu_to_node(from) == early_cpu_to_node(to))
-		return LOCAL_DISTANCE;
-	else
-		return REMOTE_DISTANCE;
-}
-
-void __init pcpu_populate_pte(unsigned long addr)
-{
-	populate_kernel_pte(addr);
-}
-
-void __init setup_per_cpu_areas(void)
-{
-	unsigned long delta;
-	unsigned int cpu;
-	int rc = -EINVAL;
-
-	if (pcpu_chosen_fc == PCPU_FC_AUTO) {
-		if (nr_node_ids >= 8)
-			pcpu_chosen_fc = PCPU_FC_PAGE;
-		else
-			pcpu_chosen_fc = PCPU_FC_EMBED;
-	}
-
-	/*
-	 * Always reserve area for module percpu variables.  That's
-	 * what the legacy allocator did.
-	 */
-	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
-		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-					    PERCPU_DYNAMIC_RESERVE, PMD_SIZE,
-					    pcpu_cpu_distance, pcpu_cpu_to_node);
-		if (rc < 0)
-			pr_warn("%s allocator failed (%d), falling back to page size\n",
-				pcpu_fc_names[pcpu_chosen_fc], rc);
-	}
-	if (rc < 0)
-		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE, pcpu_cpu_to_node);
-	if (rc < 0)
-		panic("cannot initialize percpu area (err=%d)", rc);
-
-	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
-	for_each_possible_cpu(cpu)
-		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
-}
-#endif
-
 /*
  * Get nodeid by logical cpu number.
  * __cpuid_to_node maps phyical cpu id to node, so we
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index aabee0b280fe..88b9c6b68d1e 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -29,6 +29,7 @@
 #include <asm/loongson.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
+#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
 #include <asm/time.h>
@@ -717,3 +718,61 @@ void flush_tlb_one(unsigned long vaddr)
 	on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
 }
 EXPORT_SYMBOL(flush_tlb_one);
+
+#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
+unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(__per_cpu_offset);
+
+static int __init pcpu_cpu_to_node(int cpu)
+{
+	return early_cpu_to_node(cpu);
+}
+
+static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
+{
+	if (early_cpu_to_node(from) == early_cpu_to_node(to))
+		return LOCAL_DISTANCE;
+	else
+		return REMOTE_DISTANCE;
+}
+
+void __init pcpu_populate_pte(unsigned long addr)
+{
+	populate_kernel_pte(addr);
+}
+
+void __init setup_per_cpu_areas(void)
+{
+	unsigned long delta;
+	unsigned int cpu;
+	int rc = -EINVAL;
+
+	if (pcpu_chosen_fc == PCPU_FC_AUTO) {
+		if (nr_node_ids >= 8)
+			pcpu_chosen_fc = PCPU_FC_PAGE;
+		else
+			pcpu_chosen_fc = PCPU_FC_EMBED;
+	}
+
+	/*
+	 * Always reserve area for module percpu variables.  That's
+	 * what the legacy allocator did.
+	 */
+	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
+		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
+					    PERCPU_DYNAMIC_RESERVE, PMD_SIZE,
+					    pcpu_cpu_distance, pcpu_cpu_to_node);
+		if (rc < 0)
+			pr_warn("%s allocator failed (%d), falling back to page size\n",
+				pcpu_fc_names[pcpu_chosen_fc], rc);
+	}
+	if (rc < 0)
+		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE, pcpu_cpu_to_node);
+	if (rc < 0)
+		panic("cannot initialize percpu area (err=%d)", rc);
+
+	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
+	for_each_possible_cpu(cpu)
+		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
+}
+#endif
-- 
2.42.0


