Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570747F58BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjKWG6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjKWG6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:58:04 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D84D4F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso448122b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722667; x=1701327467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqqTxLyku7Pb+ctpWN2ROyQtTus2hT3Qjo5g/GoNKE8=;
        b=bSdmBoyatsC70jP2qVbTwOQEQL5FewEnZDj5ewfzd9O+GYmgfcwMO4DfWW4LsEdzpE
         17S5rtxQYklrnmejg5nIPAVqbBQ3fbhJqunPlzyzQATDDArIyAjgA+Qrhc0LOqO3ODPL
         d5EVLAhSnTYO0D5cXmlw1cKJxgnQXKoi37bwGcQcIzfZALrt/tv9gFh/lbIzXBqjW6LG
         kD67MbGfDZpw30db3aHHcyyQg+Dcr71paYHrCxc1KwFKnbE/t0tI8C7JndgqRG8ntx6I
         RWa/o8UQA/GEXt8Pu6NAP5s72r0nNR6D5FD1uCrfBo5jgZGQjMg/8mtcopHFw5u0Dq47
         Wa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722667; x=1701327467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqqTxLyku7Pb+ctpWN2ROyQtTus2hT3Qjo5g/GoNKE8=;
        b=VGvfpned0xVJ1AOONUKNnK0qYPPxDiwaylC5wzFudF9uPoRcs/3gIARmE2W07hmOvv
         CMckJ/lZsqwI74RBTmu6VvqV0waIMfK5zo58JfPNj4pQ30qZZ7lgSJxorUh2GhjskmgA
         JcMun9nEgoIcGoVA7+/YckGnroRLbBvhK9NXnUlSQIP2ZsaxA1R+rOm4e1sVujNqh1Ax
         sruhb4aZx33IyI/JBIp1tbxpi8qyWVxAt6Dmp7P44nhGh7OrN6GhKO3qpTvehBJni/4S
         /8KdjWmsrGF8+DRVqcfVGHtsIufJbNzqUcyxHLidjOd/ur/wQUzxOIs+iI1DK+mEgxdx
         IkCQ==
X-Gm-Message-State: AOJu0YwoxvPAEgJuDVqM/fyysxMRWVvO+REyQEvawKHu3XDu0UtA/6ug
        9SpELMqlq+qaEvATAgcoReV8Aw==
X-Google-Smtp-Source: AGHT+IFPkQpg+ey3ertHh/TcNBgUDX7fnhdQHqcFtkkyI3tzskgpcz/a4p2oxDN3tA6VRXfdP6SYzg==
X-Received: by 2002:a05:6a00:a11:b0:68f:c078:b0c9 with SMTP id p17-20020a056a000a1100b0068fc078b0c9mr3267435pfh.11.1700722667294;
        Wed, 22 Nov 2023 22:57:47 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.57.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:57:46 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 04/11] riscv: Adapt pte operations to gap between hw page and sw page
Date:   Thu, 23 Nov 2023 14:57:01 +0800
Message-Id: <20231123065708.91345-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU handles pages at a granularity of hardware page. That is, for 4K
MMU, the pfn decoded from page table entry will be regarded as 4K page
frame number, no matter how large the software page is. Thus, page table
entries should always be encoded at the granularity of hardware page.

This commit makes pte operations aware of the gap between hw page and sw
page. All pte operations now configure page table entries via hardware
page frame number.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/page.h       |  3 +++
 arch/riscv/include/asm/pgalloc.h    | 21 ++++++++++-----
 arch/riscv/include/asm/pgtable-32.h |  2 +-
 arch/riscv/include/asm/pgtable-64.h | 40 ++++++++++++++++++-----------
 arch/riscv/include/asm/pgtable.h    | 19 +++++++-------
 arch/riscv/mm/init.c                | 18 ++++++-------
 6 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index cbaa7e027f9a..12f2e73ed55b 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -177,6 +177,9 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 #define __pa(x)		__virt_to_phys((unsigned long)(x))
 #define __va(x)		((void *)__pa_to_va_nodebug((phys_addr_t)(x)))
 
+#define pfn_to_hwpfn(pfn)	(pfn << (PAGE_SHIFT - HW_PAGE_SHIFT))
+#define hwpfn_to_pfn(hwpfn)	(hwpfn >> (PAGE_SHIFT - HW_PAGE_SHIFT))
+
 #define phys_to_pfn(phys)	(PFN_DOWN(phys))
 #define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
 
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index d169a4f41a2e..eab75d5f7093 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -19,32 +19,36 @@ static inline void pmd_populate_kernel(struct mm_struct *mm,
 	pmd_t *pmd, pte_t *pte)
 {
 	unsigned long pfn = virt_to_pfn(pte);
+	unsigned long hwpfn = pfn_to_hwpfn(pfn);
 
-	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	set_pmd(pmd, __pmd((hwpfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
 
 static inline void pmd_populate(struct mm_struct *mm,
 	pmd_t *pmd, pgtable_t pte)
 {
 	unsigned long pfn = virt_to_pfn(page_address(pte));
+	unsigned long hwpfn = pfn_to_hwpfn(pfn);
 
-	set_pmd(pmd, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	set_pmd(pmd, __pmd((hwpfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
 	unsigned long pfn = virt_to_pfn(pmd);
+	unsigned long hwpfn = pfn_to_hwpfn(pfn);
 
-	set_pud(pud, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	set_pud(pud, __pud((hwpfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
 
 static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 {
 	if (pgtable_l4_enabled) {
 		unsigned long pfn = virt_to_pfn(pud);
+		unsigned long hwpfn = pfn_to_hwpfn(pfn);
 
-		set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+		set_p4d(p4d, __p4d((hwpfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
 
@@ -53,9 +57,10 @@ static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
 {
 	if (pgtable_l4_enabled) {
 		unsigned long pfn = virt_to_pfn(pud);
+		unsigned long hwpfn = pfn_to_hwpfn(pfn);
 
 		set_p4d_safe(p4d,
-			     __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+			     __p4d((hwpfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
 
@@ -63,8 +68,9 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 {
 	if (pgtable_l5_enabled) {
 		unsigned long pfn = virt_to_pfn(p4d);
+		unsigned long hwpfn = pfn_to_hwpfn(pfn);
 
-		set_pgd(pgd, __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+		set_pgd(pgd, __pgd((hwpfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
 
@@ -73,9 +79,10 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 {
 	if (pgtable_l5_enabled) {
 		unsigned long pfn = virt_to_pfn(p4d);
+		unsigned long hwpfn = pfn_to_hwpfn(pfn);
 
 		set_pgd_safe(pgd,
-			     __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+			     __pgd((hwpfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 	}
 }
 
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 00f3369570a8..dec436e146ae 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -20,7 +20,7 @@
 /*
  * rv32 PTE format:
  * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *       PFN      reserved for SW   D   A   G   U   X   W   R   V
+ *     HW_PFN     reserved for SW   D   A   G   U   X   W   R   V
  */
 #define _PAGE_PFN_MASK  GENMASK(31, 10)
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index c08db54594a9..1926727698fc 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -50,7 +50,7 @@ typedef struct {
 
 #define p4d_val(x)	((x).p4d)
 #define __p4d(x)	((p4d_t) { (x) })
-#define PTRS_PER_P4D	(PAGE_SIZE / sizeof(p4d_t))
+#define PTRS_PER_P4D	(HW_PAGE_SIZE / sizeof(p4d_t))
 
 /* Page Upper Directory entry */
 typedef struct {
@@ -59,7 +59,7 @@ typedef struct {
 
 #define pud_val(x)      ((x).pud)
 #define __pud(x)        ((pud_t) { (x) })
-#define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
+#define PTRS_PER_PUD    (HW_PAGE_SIZE / sizeof(pud_t))
 
 /* Page Middle Directory entry */
 typedef struct {
@@ -69,12 +69,12 @@ typedef struct {
 #define pmd_val(x)      ((x).pmd)
 #define __pmd(x)        ((pmd_t) { (x) })
 
-#define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
+#define PTRS_PER_PMD    (HW_PAGE_SIZE / sizeof(pmd_t))
 
 /*
  * rv64 PTE format:
  * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
+ *   N      MT     RSV    HW_PFN   reserved for SW   D   A   G   U   X   W   R   V
  */
 #define _PAGE_PFN_MASK  GENMASK(53, 10)
 
@@ -94,13 +94,23 @@ enum napot_cont_order {
 	NAPOT_ORDER_MAX,
 };
 
-#define for_each_napot_order(order)						\
-	for (order = NAPOT_CONT_ORDER_BASE; order < NAPOT_ORDER_MAX; order++)
-#define for_each_napot_order_rev(order)						\
-	for (order = NAPOT_ORDER_MAX - 1;					\
-	     order >= NAPOT_CONT_ORDER_BASE; order--)
-#define napot_cont_order(val)							\
-	(__builtin_ctzl((pte_val(val) >> _PAGE_PFN_SHIFT) << 1))
+#define NAPOT_PAGE_ORDER_BASE						\
+	((NAPOT_CONT_ORDER_BASE >= (PAGE_SHIFT - HW_PAGE_SHIFT)) ?	\
+	 (NAPOT_CONT_ORDER_BASE - (PAGE_SHIFT - HW_PAGE_SHIFT)) : 1)
+#define NAPOT_PAGE_ORDER_MAX						\
+	((NAPOT_ORDER_MAX > (PAGE_SHIFT - HW_PAGE_SHIFT)) ?		\
+	 (NAPOT_ORDER_MAX - (PAGE_SHIFT - HW_PAGE_SHIFT)) :		\
+	 NAPOT_PAGE_ORDER_BASE)
+
+#define for_each_napot_order(order)					\
+	for (order = NAPOT_PAGE_ORDER_BASE;				\
+			order < NAPOT_PAGE_ORDER_MAX; order++)
+#define for_each_napot_order_rev(order)					\
+	for (order = NAPOT_PAGE_ORDER_MAX - 1;				\
+			order >= NAPOT_PAGE_ORDER_BASE; order--)
+#define napot_cont_order(val)						\
+	(__builtin_ctzl((pte_val(val) >> _PAGE_PFN_SHIFT) << 1)		\
+	 - (PAGE_SHIFT - HW_PAGE_SHIFT))
 
 #define napot_cont_shift(order)	((order) + PAGE_SHIFT)
 #define napot_cont_size(order)	BIT(napot_cont_shift(order))
@@ -108,7 +118,7 @@ enum napot_cont_order {
 #define napot_pte_num(order)	BIT(order)
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-#define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_CONT_ORDER_BASE))
+#define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_PAGE_ORDER_BASE))
 #else
 #define HUGE_MAX_HSTATE		2
 #endif
@@ -213,7 +223,7 @@ static inline void pud_clear(pud_t *pudp)
 
 static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
 {
-	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+	return __pud((pfn_to_hwpfn(pfn) << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
 static inline unsigned long _pud_pfn(pud_t pud)
@@ -257,7 +267,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 
 	ALT_THEAD_PMA(prot_val);
 
-	return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return __pmd((pfn_to_hwpfn(pfn) << _PAGE_PFN_SHIFT) | prot_val);
 }
 
 static inline unsigned long _pmd_pfn(pmd_t pmd)
@@ -316,7 +326,7 @@ static inline void p4d_clear(p4d_t *p4d)
 
 static inline p4d_t pfn_p4d(unsigned long pfn, pgprot_t prot)
 {
-	return __p4d((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+	return __p4d((pfn_to_hwpfn(pfn) << _PAGE_PFN_SHIFT) | pgprot_val(prot));
 }
 
 static inline unsigned long _p4d_pfn(p4d_t p4d)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 342be2112fd2..d50c4588c1ed 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -26,9 +26,9 @@
 #endif
 
 /* Number of entries in the page global directory */
-#define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
+#define PTRS_PER_PGD    (HW_PAGE_SIZE / sizeof(pgd_t))
 /* Number of entries in the page table */
-#define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
+#define PTRS_PER_PTE    (HW_PAGE_SIZE / sizeof(pte_t))
 
 /*
  * Half of the kernel address space (1/4 of the entries of the page global
@@ -118,7 +118,8 @@
 #include <linux/mm_types.h>
 #include <asm/compat.h>
 
-#define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
+#define __page_val_to_hwpfn(_val) (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
+#define __page_val_to_pfn(_val) hwpfn_to_pfn(__page_val_to_hwpfn(_val))
 
 #ifdef CONFIG_64BIT
 #include <asm/pgtable-64.h>
@@ -287,7 +288,7 @@ static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 
 	ALT_THEAD_PMA(prot_val);
 
-	return __pgd((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return __pgd((pfn_to_hwpfn(pfn) << _PAGE_PFN_SHIFT) | prot_val);
 }
 
 static inline unsigned long _pgd_pfn(pgd_t pgd)
@@ -351,12 +352,12 @@ static inline unsigned long pte_napot(pte_t pte)
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	unsigned long res  = __page_val_to_pfn(pte_val(pte));
+	unsigned long res  = __page_val_to_hwpfn(pte_val(pte));
 
 	if (has_svnapot() && pte_napot(pte))
 		res = res & (res - 1UL);
 
-	return res;
+	return hwpfn_to_pfn(res);
 }
 
 #define pte_page(x)     pfn_to_page(pte_pfn(x))
@@ -368,7 +369,7 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 
 	ALT_THEAD_PMA(prot_val);
 
-	return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
+	return __pte((pfn_to_hwpfn(pfn) << _PAGE_PFN_SHIFT) | prot_val);
 }
 
 #define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
@@ -723,14 +724,14 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 	return __pmd(pmd_val(pmd) & ~(_PAGE_PRESENT|_PAGE_PROT_NONE));
 }
 
-#define __pmd_to_phys(pmd)  (__page_val_to_pfn(pmd_val(pmd)) << PAGE_SHIFT)
+#define __pmd_to_phys(pmd)  (__page_val_to_hwpfn(pmd_val(pmd)) << HW_PAGE_SHIFT)
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
 }
 
-#define __pud_to_phys(pud)  (__page_val_to_pfn(pud_val(pud)) << PAGE_SHIFT)
+#define __pud_to_phys(pud)  (__page_val_to_hwpfn(pud_val(pud)) << HW_PAGE_SHIFT)
 
 static inline unsigned long pud_pfn(pud_t pud)
 {
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e011cbddf3a..a768b2b3ff05 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -466,7 +466,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 		pte_phys = pt_ops.alloc_pte(va);
 		pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(pte_phys), PAGE_TABLE);
 		ptep = pt_ops.get_pte_virt(pte_phys);
-		memset(ptep, 0, PAGE_SIZE);
+		memset(ptep, 0, PTRS_PER_PTE * sizeof(pte_t));
 	} else {
 		pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_idx]));
 		ptep = pt_ops.get_pte_virt(pte_phys);
@@ -569,7 +569,7 @@ static void __init create_pud_mapping(pud_t *pudp,
 		next_phys = pt_ops.alloc_pmd(va);
 		pudp[pud_index] = pfn_pud(PFN_DOWN(next_phys), PAGE_TABLE);
 		nextp = pt_ops.get_pmd_virt(next_phys);
-		memset(nextp, 0, PAGE_SIZE);
+		memset(nextp, 0, PTRS_PER_PMD * sizeof(pmd_t));
 	} else {
 		next_phys = PFN_PHYS(_pud_pfn(pudp[pud_index]));
 		nextp = pt_ops.get_pmd_virt(next_phys);
@@ -596,7 +596,7 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 		next_phys = pt_ops.alloc_pud(va);
 		p4dp[p4d_index] = pfn_p4d(PFN_DOWN(next_phys), PAGE_TABLE);
 		nextp = pt_ops.get_pud_virt(next_phys);
-		memset(nextp, 0, PAGE_SIZE);
+		memset(nextp, 0, PTRS_PER_PUD * sizeof(pud_t));
 	} else {
 		next_phys = PFN_PHYS(_p4d_pfn(p4dp[p4d_index]));
 		nextp = pt_ops.get_pud_virt(next_phys);
@@ -654,7 +654,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 		next_phys = alloc_pgd_next(va);
 		pgdp[pgd_idx] = pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
 		nextp = get_pgd_next_virt(next_phys);
-		memset(nextp, 0, PAGE_SIZE);
+		memset(nextp, 0, PTRS_PER_P4D * sizeof(p4d_t));
 	} else {
 		next_phys = PFN_PHYS(_pgd_pfn(pgdp[pgd_idx]));
 		nextp = get_pgd_next_virt(next_phys);
@@ -815,16 +815,16 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 	if (hw_satp != identity_satp) {
 		if (pgtable_l5_enabled) {
 			disable_pgtable_l5();
-			memset(early_pg_dir, 0, PAGE_SIZE);
+			memset(early_pg_dir, 0, PTRS_PER_PGD * sizeof(pgd_t));
 			goto retry;
 		}
 		disable_pgtable_l4();
 	}
 
-	memset(early_pg_dir, 0, PAGE_SIZE);
-	memset(early_p4d, 0, PAGE_SIZE);
-	memset(early_pud, 0, PAGE_SIZE);
-	memset(early_pmd, 0, PAGE_SIZE);
+	memset(early_pg_dir, 0, PTRS_PER_PGD * sizeof(pgd_t));
+	memset(early_p4d, 0, PTRS_PER_P4D * sizeof(p4d_t));
+	memset(early_pud, 0, PTRS_PER_PUD * sizeof(pud_t));
+	memset(early_pmd, 0, PTRS_PER_PMD * sizeof(pmd_t));
 }
 #endif
 
-- 
2.20.1

