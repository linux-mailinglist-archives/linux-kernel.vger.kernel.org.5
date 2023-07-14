Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFB753FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjGNQSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbjGNQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:17:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3B0535B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:17:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB8E1576;
        Fri, 14 Jul 2023 09:18:28 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527963F740;
        Fri, 14 Jul 2023 09:17:44 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 2/4] mm: Default implementation of arch_wants_pte_order()
Date:   Fri, 14 Jul 2023 17:17:31 +0100
Message-Id: <20230714161733.4144503-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714160407.4142030-1-ryan.roberts@arm.com>
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_wants_pte_order() can be overridden by the arch to return the
preferred folio order for pte-mapped memory. This is useful as some
architectures (e.g. arm64) can coalesce TLB entries when the physical
memory is suitably contiguous.

The first user for this hint will be FLEXIBLE_THP, which aims to
allocate large folios for anonymous memory to reduce page faults and
other per-page operation costs.

Here we add the default implementation of the function, used when the
architecture does not define it, which returns -1, implying that the HW
has no preference. In this case, mm will choose it's own default order.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b482e34f..2a1d83775837 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
 }
 #endif
 
+#ifndef arch_wants_pte_order
+/*
+ * Returns preferred folio order for pte-mapped memory. Must be in range [0,
+ * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
+ * to be at least order-2. Negative value implies that the HW has no preference
+ * and mm will choose it's own default order.
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
-- 
2.25.1

