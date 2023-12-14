Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D14813598
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443706AbjLNQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjLNQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:02:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72A5811A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:03:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E6D2C15;
        Thu, 14 Dec 2023 08:03:51 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B66C3F5A1;
        Thu, 14 Dec 2023 08:03:03 -0800 (PST)
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Resolve some multi-size THP review nits
Date:   Thu, 14 Dec 2023 16:02:51 +0000
Message-Id: <20231214160251.3574571-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e2da3c78-85f7-4516-bbab-97fac9629dcc@suswa.mountain>
References: <e2da3c78-85f7-4516-bbab-97fac9629dcc@suswa.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy code based on review feedback for final version of multi-size THP:

 - Comment added to explain alloc_anon_folio() error protocol
 - ifdefery simplified for alloc_anon_folio()

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
Hi Andrew,

Hopefully this is the final tweak. Could you please squash this with the
"mm: thp: Support allocation of anonymous multi-size THP" patch in mm-unstable?

Or if you prefer me to re-post the entire series, just let me know.

Thanks,
Ryan


 mm/memory.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8f0b936b90b5..3c530b639559 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4137,9 +4137,9 @@ static bool pte_range_none(pte_t *pte, int nr_pages)
 	return true;
 }

-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long orders;
 	struct folio *folio;
@@ -4199,12 +4199,9 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	}

 fallback:
-	return vma_alloc_zeroed_movable_folio(vma, vmf->address);
-}
-#else
-#define alloc_anon_folio(vmf) \
-		vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->address)
 #endif
+	return vma_alloc_zeroed_movable_folio(vmf->vma, vmf->address);
+}

 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
@@ -4260,6 +4257,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Allocate our own private page. */
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
+	/* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the fault */
 	folio = alloc_anon_folio(vmf);
 	if (IS_ERR(folio))
 		return 0;
--
2.25.1

