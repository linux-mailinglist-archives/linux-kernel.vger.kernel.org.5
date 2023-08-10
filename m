Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B331E777AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjHJOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjHJOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:30:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A09F2723
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:30:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B756214BF;
        Thu, 10 Aug 2023 07:30:45 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05DF53F64C;
        Thu, 10 Aug 2023 07:30:00 -0700 (PDT)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/5] selftests/mm/cow: Generalize do_run_with_thp() helper
Date:   Thu, 10 Aug 2023 15:29:41 +0100
Message-Id: <20230810142942.3169679-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810142942.3169679-1-ryan.roberts@arm.com>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_run_with_thp() prepares THP memory into different states before
running tests. We would like to reuse this logic to also test large anon
folios. So let's add a size parameter which tells the function what size
of memory it should operate on.

Remove references to THP and replace with LARGE, and fix up all existing
call sites to pass thpsize as the required size.

No functional change intended here, but a separate commit will add new
large anon folio tests that use this new capability.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/cow.c | 118 ++++++++++++++++---------------
 1 file changed, 61 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 7324ce5363c0..304882bf2e5d 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -723,25 +723,25 @@ static void run_with_base_page_swap(test_fn fn, const char *desc)
 	do_run_with_base_page(fn, true);
 }
 
-enum thp_run {
-	THP_RUN_PMD,
-	THP_RUN_PMD_SWAPOUT,
-	THP_RUN_PTE,
-	THP_RUN_PTE_SWAPOUT,
-	THP_RUN_SINGLE_PTE,
-	THP_RUN_SINGLE_PTE_SWAPOUT,
-	THP_RUN_PARTIAL_MREMAP,
-	THP_RUN_PARTIAL_SHARED,
+enum large_run {
+	LARGE_RUN_PMD,
+	LARGE_RUN_PMD_SWAPOUT,
+	LARGE_RUN_PTE,
+	LARGE_RUN_PTE_SWAPOUT,
+	LARGE_RUN_SINGLE_PTE,
+	LARGE_RUN_SINGLE_PTE_SWAPOUT,
+	LARGE_RUN_PARTIAL_MREMAP,
+	LARGE_RUN_PARTIAL_SHARED,
 };
 
-static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
+static void do_run_with_large(test_fn fn, enum large_run large_run, size_t size)
 {
 	char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
-	size_t size, mmap_size, mremap_size;
+	size_t mmap_size, mremap_size;
 	int ret;
 
-	/* For alignment purposes, we need twice the thp size. */
-	mmap_size = 2 * thpsize;
+	/* For alignment purposes, we need twice the requested size. */
+	mmap_size = 2 * size;
 	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (mmap_mem == MAP_FAILED) {
@@ -749,36 +749,40 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 		return;
 	}
 
-	/* We need a THP-aligned memory area. */
-	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
+	/* We need to naturally align the memory area. */
+	mem = (char *)(((uintptr_t)mmap_mem + size) & ~(size - 1));
 
-	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
+	ret = madvise(mem, size, MADV_HUGEPAGE);
 	if (ret) {
 		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
 		goto munmap;
 	}
 
 	/*
-	 * Try to populate a THP. Touch the first sub-page and test if we get
-	 * another sub-page populated automatically.
+	 * Try to populate a large folio. Touch the first sub-page and test if
+	 * we get the last sub-page populated automatically.
 	 */
 	mem[0] = 0;
-	if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
-		ksft_test_result_skip("Did not get a THP populated\n");
+	if (!pagemap_is_populated(pagemap_fd, mem + size - pagesize)) {
+		ksft_test_result_skip("Did not get fully populated\n");
 		goto munmap;
 	}
-	memset(mem, 0, thpsize);
+	memset(mem, 0, size);
 
-	size = thpsize;
-	switch (thp_run) {
-	case THP_RUN_PMD:
-	case THP_RUN_PMD_SWAPOUT:
+	switch (large_run) {
+	case LARGE_RUN_PMD:
+	case LARGE_RUN_PMD_SWAPOUT:
+		if (size != thpsize) {
+			ksft_test_result_fail("test bug: can't PMD-map size\n");
+			goto munmap;
+		}
 		break;
-	case THP_RUN_PTE:
-	case THP_RUN_PTE_SWAPOUT:
+	case LARGE_RUN_PTE:
+	case LARGE_RUN_PTE_SWAPOUT:
 		/*
-		 * Trigger PTE-mapping the THP by temporarily mapping a single
-		 * subpage R/O.
+		 * Trigger PTE-mapping the large folio by temporarily mapping a
+		 * single subpage R/O. This is a noop if the large-folio is not
+		 * thpsize (and therefore already PTE-mapped).
 		 */
 		ret = mprotect(mem + pagesize, pagesize, PROT_READ);
 		if (ret) {
@@ -791,25 +795,25 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 			goto munmap;
 		}
 		break;
-	case THP_RUN_SINGLE_PTE:
-	case THP_RUN_SINGLE_PTE_SWAPOUT:
+	case LARGE_RUN_SINGLE_PTE:
+	case LARGE_RUN_SINGLE_PTE_SWAPOUT:
 		/*
-		 * Discard all but a single subpage of that PTE-mapped THP. What
-		 * remains is a single PTE mapping a single subpage.
+		 * Discard all but a single subpage of that PTE-mapped large
+		 * folio. What remains is a single PTE mapping a single subpage.
 		 */
-		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTNEED);
+		ret = madvise(mem + pagesize, size - pagesize, MADV_DONTNEED);
 		if (ret) {
 			ksft_test_result_fail("MADV_DONTNEED failed\n");
 			goto munmap;
 		}
 		size = pagesize;
 		break;
-	case THP_RUN_PARTIAL_MREMAP:
+	case LARGE_RUN_PARTIAL_MREMAP:
 		/*
-		 * Remap half of the THP. We need some new memory location
-		 * for that.
+		 * Remap half of the lareg folio. We need some new memory
+		 * location for that.
 		 */
-		mremap_size = thpsize / 2;
+		mremap_size = size / 2;
 		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
 				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (mem == MAP_FAILED) {
@@ -824,13 +828,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 		}
 		size = mremap_size;
 		break;
-	case THP_RUN_PARTIAL_SHARED:
+	case LARGE_RUN_PARTIAL_SHARED:
 		/*
-		 * Share the first page of the THP with a child and quit the
-		 * child. This will result in some parts of the THP never
-		 * have been shared.
+		 * Share the first page of the large folio with a child and quit
+		 * the child. This will result in some parts of the large folio
+		 * never have been shared.
 		 */
-		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTFORK);
+		ret = madvise(mem + pagesize, size - pagesize, MADV_DONTFORK);
 		if (ret) {
 			ksft_test_result_fail("MADV_DONTFORK failed\n");
 			goto munmap;
@@ -844,7 +848,7 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 		}
 		wait(&ret);
 		/* Allow for sharing all pages again. */
-		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DOFORK);
+		ret = madvise(mem + pagesize, size - pagesize, MADV_DOFORK);
 		if (ret) {
 			ksft_test_result_fail("MADV_DOFORK failed\n");
 			goto munmap;
@@ -854,10 +858,10 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 		assert(false);
 	}
 
-	switch (thp_run) {
-	case THP_RUN_PMD_SWAPOUT:
-	case THP_RUN_PTE_SWAPOUT:
-	case THP_RUN_SINGLE_PTE_SWAPOUT:
+	switch (large_run) {
+	case LARGE_RUN_PMD_SWAPOUT:
+	case LARGE_RUN_PTE_SWAPOUT:
+	case LARGE_RUN_SINGLE_PTE_SWAPOUT:
 		madvise(mem, size, MADV_PAGEOUT);
 		if (!range_is_swapped(mem, size)) {
 			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
@@ -878,49 +882,49 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 static void run_with_thp(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PMD);
+	do_run_with_large(fn, LARGE_RUN_PMD, thpsize);
 }
 
 static void run_with_thp_swap(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with swapped-out THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT);
+	do_run_with_large(fn, LARGE_RUN_PMD_SWAPOUT, thpsize);
 }
 
 static void run_with_pte_mapped_thp(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with PTE-mapped THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PTE);
+	do_run_with_large(fn, LARGE_RUN_PTE, thpsize);
 }
 
 static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT);
+	do_run_with_large(fn, LARGE_RUN_PTE_SWAPOUT, thpsize);
 }
 
 static void run_with_single_pte_of_thp(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with single PTE of THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_SINGLE_PTE);
+	do_run_with_large(fn, LARGE_RUN_SINGLE_PTE, thpsize);
 }
 
 static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT);
+	do_run_with_large(fn, LARGE_RUN_SINGLE_PTE_SWAPOUT, thpsize);
 }
 
 static void run_with_partial_mremap_thp(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP);
+	do_run_with_large(fn, LARGE_RUN_PARTIAL_MREMAP, thpsize);
 }
 
 static void run_with_partial_shared_thp(test_fn fn, const char *desc)
 {
 	ksft_print_msg("[RUN] %s ... with partially shared THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED);
+	do_run_with_large(fn, LARGE_RUN_PARTIAL_SHARED, thpsize);
 }
 
 static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
@@ -1338,7 +1342,7 @@ static void run_anon_thp_test_cases(void)
 		struct test_case const *test_case = &anon_thp_test_cases[i];
 
 		ksft_print_msg("[RUN] %s\n", test_case->desc);
-		do_run_with_thp(test_case->fn, THP_RUN_PMD);
+		do_run_with_large(test_case->fn, LARGE_RUN_PMD, thpsize);
 	}
 }
 
-- 
2.25.1

