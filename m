Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0803E798029
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjIHB3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIHB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:29:17 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 842A91BD7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 18:29:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8AxV_HkePpkO9YhAA--.2420S3;
        Fri, 08 Sep 2023 09:29:08 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfSPjePpkpqxxAA--.28198S2;
        Fri, 08 Sep 2023 09:29:07 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Add tlb_flush_threshold for tlb flush range
Date:   Fri,  8 Sep 2023 09:29:07 +0800
Message-Id: <20230908012907.2994001-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSPjePpkpqxxAA--.28198S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr4DXr45Kw43Wr1Utw1DJwc_yoW7XrW5pr
        sa9w45trs5Gr93XrWftryFgrn8Jr1kK3Waga1aqFySvr43tr17urWkKa4rAFy5Xa93GrWf
        ur9Iqr1aqFZ5J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is calculation in function flush_tlb_range to decide flush tlb
entries one by one or flush the whole tlbs. Instead the calculation can be
done during cpu probe stage rather than runtime flush period.

This patch adds percpu variable tlb_flush_threshold during cpu probe
stage, and removes unused percpu variabled like tlbsizemtlb,
tlbsizestlbsets/tlbsizestlbways etc.

Also this patch fixes function __update_hugetlb, it should be
effective for CONFIG_TRANSPARENT_HUGEPAGE also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/cpu-info.h |  4 +---
 arch/loongarch/kernel/cpu-probe.c     | 31 ++++++++++++++++-----------
 arch/loongarch/mm/tlb.c               | 11 +++-------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/include/asm/cpu-info.h
index 900589cb159d..523827216c1b 100644
--- a/arch/loongarch/include/asm/cpu-info.h
+++ b/arch/loongarch/include/asm/cpu-info.h
@@ -47,9 +47,7 @@ struct cpuinfo_loongarch {
 	unsigned int		cputype;
 	int			isa_level;
 	int			tlbsize;
-	int			tlbsizemtlb;
-	int			tlbsizestlbsets;
-	int			tlbsizestlbways;
+	int			tlb_flush_threshold;
 	int			cache_leaves_present; /* number of cache_leaves[] elements */
 	struct cache_desc	cache_leaves[CACHE_LEAVES_MAX];
 	int			core;   /* physical core number in package */
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index e925579c7a71..ffa0a1b1ae29 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -88,7 +88,7 @@ static void set_isa(struct cpuinfo_loongarch *c, unsigned int isa)
 
 static void cpu_probe_common(struct cpuinfo_loongarch *c)
 {
-	unsigned int config;
+	unsigned int config, stlbsets, stlbways, mtlbs;
 	unsigned long asid_mask;
 
 	c->options = LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR |
@@ -173,28 +173,35 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 	c->ksave_mask &= ~(EXC_KSAVE_MASK | PERCPU_KSAVE_MASK | KVM_KSAVE_MASK);
 
 	config = read_csr_prcfg3();
+	stlbsets = 0;
+	c->tlbsize = 0;
 	switch (config & CSR_CONF3_TLBTYPE) {
 	case 0:
-		c->tlbsizemtlb = 0;
-		c->tlbsizestlbsets = 0;
-		c->tlbsizestlbways = 0;
+		mtlbs = 0;
+		stlbsets = 0;
+		stlbways = 0;
 		c->tlbsize = 0;
 		break;
 	case 1:
-		c->tlbsizemtlb = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
-		c->tlbsizestlbsets = 0;
-		c->tlbsizestlbways = 0;
-		c->tlbsize = c->tlbsizemtlb + c->tlbsizestlbsets * c->tlbsizestlbways;
+		mtlbs = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
+		stlbsets = 0;
+		stlbways = 0;
+		c->tlbsize = mtlbs + stlbsets * stlbways;
 		break;
 	case 2:
-		c->tlbsizemtlb = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
-		c->tlbsizestlbsets = 1 << ((config & CSR_CONF3_STLBIDX) >> CSR_CONF3_STLBIDX_SHIFT);
-		c->tlbsizestlbways = ((config & CSR_CONF3_STLBWAYS) >> CSR_CONF3_STLBWAYS_SHIFT) + 1;
-		c->tlbsize = c->tlbsizemtlb + c->tlbsizestlbsets * c->tlbsizestlbways;
+		mtlbs = ((config & CSR_CONF3_MTLBSIZE) >> CSR_CONF3_MTLBSIZE_SHIFT) + 1;
+		stlbsets = 1 << ((config & CSR_CONF3_STLBIDX) >> CSR_CONF3_STLBIDX_SHIFT);
+		stlbways = ((config & CSR_CONF3_STLBWAYS) >> CSR_CONF3_STLBWAYS_SHIFT) + 1;
+		c->tlbsize = mtlbs + stlbsets * stlbways;
 		break;
 	default:
 		pr_warn("Warning: unknown TLB type\n");
 	}
+
+	if (stlbsets)
+		c->tlb_flush_threshold = c->tlbsize / 8;
+	else
+		c->tlb_flush_threshold = c->tlbsize / 2;
 }
 
 #define MAX_NAME_LEN	32
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index eb8572e201ea..d87627cb9e29 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -66,9 +66,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		start = round_down(start, PAGE_SIZE << 1);
 		end = round_up(end, PAGE_SIZE << 1);
 		size = (end - start) >> (PAGE_SHIFT + 1);
-		if (size <= (current_cpu_data.tlbsizestlbsets ?
-			     current_cpu_data.tlbsize / 8 :
-			     current_cpu_data.tlbsize / 2)) {
+		if (size <= current_cpu_data.tlb_flush_threshold) {
 			int asid = cpu_asid(cpu, mm);
 
 			while (start < end) {
@@ -91,10 +89,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	local_irq_save(flags);
 	size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
 	size = (size + 1) >> 1;
-	if (size <= (current_cpu_data.tlbsizestlbsets ?
-		     current_cpu_data.tlbsize / 8 :
-		     current_cpu_data.tlbsize / 2)) {
-
+	if (size <= current_cpu_data.tlb_flush_threshold) {
 		start &= (PAGE_MASK << 1);
 		end += ((PAGE_SIZE << 1) - 1);
 		end &= (PAGE_MASK << 1);
@@ -136,7 +131,7 @@ void local_flush_tlb_one(unsigned long page)
 
 static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
 {
-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	int idx;
 	unsigned long lo;
 	unsigned long flags;

base-commit: 744a759492b5c57ff24a6e8aabe47b17ad8ee964
-- 
2.27.0

