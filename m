Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C17B10B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjI1COp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1COo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:14:44 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39B5CAC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:14:42 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8BxY_CQ4RRlWaItAA--.21847S3;
        Thu, 28 Sep 2023 10:14:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy+Q4RRlNecUAA--.43050S2;
        Thu, 28 Sep 2023 10:14:40 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Share the same pmd between vDSO space and stack
Date:   Thu, 28 Sep 2023 10:14:40 +0800
Message-Id: <20230928021440.698982-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy+Q4RRlNecUAA--.43050S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw48KrW5JF43AFWkXw13trc_yoWrZw4kpF
        ZrCFs7XrWUGr97Kry7tw1kWr15Jas7Kw42ga12y393AF1YqF13Zw1kAryDZF4UtanY9a10
        gFyfKrZ09a15XwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently vDSO virtual address space is randomed within range 64M
below TASK_SIZE, and the next is stack space randomed within generic
range 8M. so vDSO space uses different pmd entry with stack.

With idea from x86, vDSO space can share the same pmd entry with
stack, only that randomed range is smaller than before. This will
save one PTE page for every thread.

Also this patch removes ____cacheline_aligned_in_smp property for
vdso_pcpu_data structure, cache line aligned property for small size
is generally used for frequently modified data like lock to avoid
cache-thrashing on smp system. The struct element node is almost constant
in struct vdso_pcpu_data, so cache line aligned property is not
necessary, and it will use more memory.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/processor.h |  2 --
 arch/loongarch/include/asm/vdso/vdso.h |  2 +-
 arch/loongarch/kernel/process.c        |  4 ---
 arch/loongarch/kernel/vdso.c           | 44 +++++++++++++++++++++-----
 4 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index c3bc44b5f5b3..5870b2785968 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -43,8 +43,6 @@
 
 #endif
 
-#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_64M)
-
 unsigned long stack_top(void);
 #define STACK_TOP stack_top()
 
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index 5a12309d9fb5..d57de1887bb2 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -12,7 +12,7 @@
 
 struct vdso_pcpu_data {
 	u32 node;
-} ____cacheline_aligned_in_smp;
+};
 
 struct loongarch_vdso_data {
 	struct vdso_pcpu_data pdata[NR_CPUS];
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 767d94cce0de..059e52d59297 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -296,10 +296,6 @@ unsigned long stack_top(void)
 	top -= PAGE_ALIGN(current->thread.vdso->size);
 	top -= VVAR_SIZE;
 
-	/* Space to randomize the VDSO base */
-	if (current->flags & PF_RANDOMIZE)
-		top -= VDSO_RANDOMIZE_SIZE;
-
 	return top;
 }
 
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 14941e4be66d..5cc27c12dce1 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -148,16 +148,44 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 }
 #endif
 
-static unsigned long vdso_base(void)
+/*
+ * Put the vdso above the (randomized) stack with another randomized
+ * offset.  This way there is no hole in the middle of address space.
+ * To save memory make sure it is still in the same PTE as the stack
+ * top.  This doesn't give that many random bits.
+ *
+ * Note that this algorithm is imperfect: the distribution of the vdso
+ * start address within a PMD is biased toward the end.
+ */
+static unsigned long vdso_addr(unsigned long start, unsigned int len)
 {
-	unsigned long base = STACK_TOP;
+	unsigned long addr, end;
+	unsigned long offset;
 
-	if (current->flags & PF_RANDOMIZE) {
-		base += get_random_u32_below(VDSO_RANDOMIZE_SIZE);
-		base = PAGE_ALIGN(base);
-	}
+	/*
+	 * Round up the start address.  It can start out unaligned as a result
+	 * of stack start randomization.
+	 */
+	start = PAGE_ALIGN(start);
 
-	return base;
+	/* Round the lowest possible end address up to a PMD boundary. */
+	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
+	if (end >= TASK_SIZE)
+		end = TASK_SIZE;
+	end -= len;
+
+	if (end > start) {
+		offset = get_random_u32_below((end - start) >> PAGE_SHIFT);
+		addr = start + (offset << PAGE_SHIFT);
+	} else
+		addr = start;
+
+	return addr;
+}
+
+static inline unsigned long vdso_base(unsigned int len)
+{
+	return vdso_addr(current->mm->start_stack, len);
 }
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
@@ -177,7 +205,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 */
 	size = VVAR_SIZE + info->size;
 
-	data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
+	data_addr = get_unmapped_area(NULL, vdso_base(size), size, 0, 0);
 	if (IS_ERR_VALUE(data_addr)) {
 		ret = data_addr;
 		goto out;
-- 
2.39.3

