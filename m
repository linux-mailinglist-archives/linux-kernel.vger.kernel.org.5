Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D167B319E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjI2LpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjI2Lo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:44:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E8D7CD3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:44:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 523D91007;
        Fri, 29 Sep 2023 04:45:28 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7040B3F59C;
        Fri, 29 Sep 2023 04:44:47 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 6/9] mm: thp: Add "recommend" option for anon_orders
Date:   Fri, 29 Sep 2023 12:44:17 +0100
Message-Id: <20230929114421.3761121-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929114421.3761121-1-ryan.roberts@arm.com>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to passing a bitfield of folio orders to enable for THP,
allow the string "recommend" to be written, which has the effect of
causing the system to enable the orders preferred by the architecture
and by the mm. The user can see what these orders are by subsequently
reading back the file.

Note that these recommended orders are expected to be static for a given
boot of the system, and so the keyword "auto" was deliberately not used,
as I want to reserve it for a possible future use where the "best" order
is chosen more dynamically at runtime.

Recommended orders are determined as follows:
  - PMD_ORDER: The traditional THP size
  - arch_wants_pte_order() if implemented by the arch
  - PAGE_ALLOC_COSTLY_ORDER: The largest order kept on per-cpu free list

arch_wants_pte_order() can be overridden by the architecture if desired.
Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
set of ptes map physically contigious, naturally aligned memory, so this
mechanism allows the architecture to optimize as required.

Here we add the default implementation of arch_wants_pte_order(), used
when the architecture does not define it, which returns -1, implying
that the HW has no preference.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  4 ++++
 include/linux/pgtable.h                    | 13 +++++++++++++
 mm/huge_memory.c                           | 14 +++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 732c3b2f4ba8..d6363d4efa3a 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -187,6 +187,10 @@ pages (=16K if the page size is 4K). The example above enables order-9
 By enabling multiple orders, allocation of each order will be
 attempted, highest to lowest, until a successful allocation is made.
 If the PMD-order is unset, then no PMD-sized THPs will be allocated.
+It is also possible to enable the recommended set of orders, which
+will be optimized for the architecture and mm::
+
+	echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
 
 The kernel will ignore any orders that it does not support so read the
 file back to determine which orders are enabled::
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..0e110ce57cc3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -393,6 +393,19 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef arch_wants_pte_order
+/*
+ * Returns preferred folio order for pte-mapped memory. Must be in range [0,
+ * PMD_ORDER) and must not be order-1 since THP requires large folios to be at
+ * least order-2. Negative value implies that the HW has no preference and mm
+ * will choose it's own default order.
+ */
+static inline int arch_wants_pte_order(void)
+{
+	return -1;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bcecce769017..e2e2d3906a21 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -464,10 +464,18 @@ static ssize_t anon_orders_store(struct kobject *kobj,
 	int err;
 	int ret = count;
 	unsigned int orders;
+	int arch;
 
-	err = kstrtouint(buf, 0, &orders);
-	if (err)
-		ret = -EINVAL;
+	if (sysfs_streq(buf, "recommend")) {
+		arch = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
+		orders = BIT(arch);
+		orders |= BIT(PAGE_ALLOC_COSTLY_ORDER);
+		orders |= BIT(PMD_ORDER);
+	} else {
+		err = kstrtouint(buf, 0, &orders);
+		if (err)
+			ret = -EINVAL;
+	}
 
 	if (ret > 0) {
 		orders &= THP_ORDERS_ALL_ANON;
-- 
2.25.1

