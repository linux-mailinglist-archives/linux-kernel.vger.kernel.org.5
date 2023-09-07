Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1CC796ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbjIGCJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIGCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:09:46 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38AFCE66
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:09:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8AxqOjjMPlkRfsgAA--.29672S3;
        Thu, 07 Sep 2023 10:09:39 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCPjMPlk_NJvAA--.52643S2;
        Thu, 07 Sep 2023 10:09:39 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] LoongArch: Clear invalid tlb when set huge page PTE entry
Date:   Thu,  7 Sep 2023 10:09:36 +0800
Message-Id: <20230907020936.2692542-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCPjMPlk_NJvAA--.52643S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr1fZrWxCr1UKryxuFy8JFc_yoW5Zw1xpF
        9rC3Z5Xr4fGr97Arn2yr4q9F43Ja1kK3y2g3Z3Jay0v3W3Wr1Uuryxt398Za48W39xG3yf
        W3yagr1DKF1DXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxU4s2-UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LoongArch machines where hardware page table walk is not
support, if hugetlb pte entry is invalid, invalid tlb with normal
page will be filled and triggers page fault exception from HW.

During page fault handling, current thread maybe migrates to other
CPUs and set huge page pte entry. And if the thread migrates to
the old CPU, stale tlb with normal page exists still, there will
be confliction. So the invalid tlb need be flushed when set  huge
page pte entry like set_huge_pte_at and set_pmd_at function.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309062224.jKf5JY7H-lkp@intel.com/
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
Changes in v2:
 Put function set_huge_pte_at in file hugetlbpage.c to remove
compiling warning.

---
 arch/loongarch/include/asm/hugetlb.h |  4 ++++
 arch/loongarch/mm/hugetlbpage.c      | 18 ++++++++++++++++++
 arch/loongarch/mm/pgtable.c          |  8 +++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index aa44b3fe43dd..62cd7528a07f 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -59,6 +59,10 @@ static inline int huge_pte_none(pte_t pte)
 	return !val || (val == (unsigned long)invalid_pte_table);
 }
 
+#define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
+extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte);
+
 #define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr,
diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index ba138117b124..cc31c090d4ba 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -85,3 +85,21 @@ uint64_t pmd_to_entrylo(unsigned long pmd_val)
 
 	return val;
 }
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte)
+{
+	/*
+	 * If huge pte entry is none, tlb entry with normal page size is filled
+	 * for machines which does not support hardware page walking.
+	 *
+	 * Thread maybe migrates to other CPUs after page fault happends and
+	 * migrates back again after hugepage pte is set, tlbs with normal page
+	 * about invalid_pte_table need be flushed
+	 */
+	if (!cpu_has_ptw && huge_pte_none(*ptep))
+		flush_tlb_mm(mm);
+
+	set_pte_at(mm, addr, ptep, pte);
+}
+
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index b14343e211b6..dfae34484f43 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -116,8 +116,14 @@ pmd_t mk_pmd(struct page *page, pgprot_t prot)
 void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
+	/*
+	 * The similar with function set_huge_pte_at
+	 * Need flush invalid normal page pte if hw ptw is not supported
+	 */
+	if (!cpu_has_ptw && pmd_none(*pmdp))
+		flush_tlb_mm(mm);
+
 	*pmdp = pmd;
-	flush_tlb_all();
 }
 
 void __init pagetable_init(void)

base-commit: 744a759492b5c57ff24a6e8aabe47b17ad8ee964
-- 
2.27.0

