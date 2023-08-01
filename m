Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A876B638
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHANtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjHANte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:49:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A86F1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:49:31 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFbzc6qzdz1GDCV;
        Tue,  1 Aug 2023 21:48:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 21:49:29 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, <kirill@shutemov.name>,
        <joel@joelfernandes.org>, <william.kucharski@oracle.com>,
        <kaleshsingh@google.com>, <linux-mm@kvack.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <21cnbao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] arm64: hugetlb: enable __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
Date:   Tue, 1 Aug 2023 21:56:16 +0800
Message-ID: <20230801135616.165067-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801023145.17026-3-wangkefeng.wang@huawei.com>
References: <20230801023145.17026-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use huge page size instead of PAGE_SIZE
for stride when flush hugepage, which reduces the loop
in __flush_tlb_range().

Let's support arch's flush_hugetlb_tlb_range(), which is
used in hugetlb_unshare_all_pmds(), move_hugetlb_page_tables()
and hugetlb_change_protection() for now.

Note, for hugepages based on contiguous bit, it has to be
invalidated individually since the contiguous PTE bit is
just a hint, the hardware may or may not take it into account.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v3: add tlb_level hint by using flush_pud/pmd_tlb_range,
    suggested by Catalin Marinas

 arch/arm64/include/asm/hugetlb.h | 21 +++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h |  4 ++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 6a4a1ab8eb23..0acb1e8b41e9 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -60,4 +60,25 @@ extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 
 #include <asm-generic/hugetlb.h>
 
+#define __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
+static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
+					   unsigned long start,
+					   unsigned long end)
+{
+	unsigned long stride = huge_page_size(hstate_vma(vma));
+
+	switch (stride) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		flush_pud_tlb_range(vma, start, end);
+		break;
+#endif
+	case PMD_SIZE:
+		flush_pmd_tlb_range(vma, start, end);
+		break;
+	default:
+		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
+	}
+}
+
 #endif /* __ASM_HUGETLB_H */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0bd18de9fd97..def402afcbe9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -35,7 +35,7 @@
 #include <linux/sched.h>
 #include <linux/page_table_check.h>
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 
 /* Set stride and tlb_level in flush_*_tlb_range */
@@ -43,7 +43,7 @@
 	__flush_tlb_range(vma, addr, end, PMD_SIZE, false, 2)
 #define flush_pud_tlb_range(vma, addr, end)	\
 	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLB_PAGE */
 
 static inline bool arch_thp_swp_supported(void)
 {
-- 
2.41.0

