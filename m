Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C447BCB89
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 03:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbjJHBUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 21:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJHBUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:20:45 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E6B68F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 18:20:39 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8Dxg_DlAyJlGewvAA--.26924S3;
        Sun, 08 Oct 2023 09:20:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxjd7lAyJlY34aAA--.58224S2;
        Sun, 08 Oct 2023 09:20:37 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] LoongArch: Share the same pmd between vDSO space and stack
Date:   Sun,  8 Oct 2023 09:20:36 +0800
Message-Id: <20231008012036.1415883-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxjd7lAyJlY34aAA--.58224S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFWrKryrXrWfXFy8AryxZwc_yoW7Xr13pF
        ZrAFs2qrW5GryxKrWUt34kZw15tas3Kw42gay2y39xAF15XF1UZw1kAr98ZF4Utw4kAw1I
        gFySkrZ09a15ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
        JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8fsqJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently vDSO virtual address space is randomed within range 64M
below TASK_SIZE, and next is randomed stack space within generic
range 8M. so vDSO space uses different pmd entry with stack.

With idea from x86, vDSO space can share the same pmd entry with
stack, only that randomed range is smaller than before. This will
save one PTE table page for every thread. And vDSO base is set as
even page aligned if there is enough VA space, so that less TLB entries
can be used for vDSO.

Also this patch removes ____cacheline_aligned_in_smp property for
vdso_pcpu_data structure, cache line aligned property is generally
used for frequently modified data like lock to avoid cache-thrash
on smp system. The struct element node is almost constant in
struct vdso_pcpu_data, so cache line aligned property is not
necessary, and it will use more memory.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
Changes in v3:
 1. Code refined for vDSO addr calculation for even page 

Changes in v2:
 1. Set vDSO base address as even page address if possible, less TLB
entries may be used for vDSO since per TLB entry contains two pages.
 2. Add PF_RANDOMIZE flag checking to set random address for vDSO.

---
 arch/loongarch/include/asm/processor.h |  2 --
 arch/loongarch/include/asm/vdso/vdso.h |  2 +-
 arch/loongarch/kernel/process.c        |  4 ---
 arch/loongarch/kernel/vdso.c           | 50 +++++++++++++++++++++-----
 4 files changed, 43 insertions(+), 15 deletions(-)

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
index 14941e4be66d..aa472fc6b128 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -148,16 +148,49 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
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
+static inline unsigned long vdso_base(unsigned long start, unsigned int len)
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
+
+	/* Round the lowest possible end address up to a PMD boundary. */
+	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
+	if (end >= TASK_SIZE)
+		end = TASK_SIZE;
+	end -= len;
+
+	if (end > start) {
+		offset = 0;
+		if (current->flags & PF_RANDOMIZE)
+			offset = get_random_u32_below(end - start);
+		addr = PAGE_ALIGN_DOWN(start + offset);
+
+		/*
+		 * There are two pages per TLB entry on LoongArch system.
+		 * Set vDSO base address as even page so that there is no
+		 * invalid odd pair page, less TLB entries are used for vDSO
+		 */
+		if (addr & PAGE_SIZE)
+			addr += PAGE_SIZE;
+	} else
+		addr = start;
 
-	return base;
+	return addr;
 }
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
@@ -177,7 +210,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 */
 	size = VVAR_SIZE + info->size;
 
-	data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
+	data_addr = get_unmapped_area(NULL, vdso_base(mm->start_stack, size),
+					size, 0, 0);
 	if (IS_ERR_VALUE(data_addr)) {
 		ret = data_addr;
 		goto out;

base-commit: 7de25c855b63453826ef678420831f98331d85fd
-- 
2.39.3

