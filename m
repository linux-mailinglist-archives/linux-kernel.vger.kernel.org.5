Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80F803010
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbjLDKVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjLDKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:21:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAC1A11F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:21:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F386169E;
        Mon,  4 Dec 2023 02:22:06 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7774C3F6C4;
        Mon,  4 Dec 2023 02:21:16 -0800 (PST)
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
        Alistair Popple <apopple@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/10] selftests/mm/cow: Generalize do_run_with_thp() helper
Date:   Mon,  4 Dec 2023 10:20:26 +0000
Message-Id: <20231204102027.57185-10-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204102027.57185-1-ryan.roberts@arm.com>
References: <20231204102027.57185-1-ryan.roberts@arm.com>
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

do_run_with_thp() prepares (PMD-sized) THP memory into different states
before running tests. With the introduction of multi-size THP, we would
like to reuse this logic to also test those smaller THP sizes. So let's
add a thpsize parameter which tells the function what size THP it should
operate on.

A separate commit will utilize this change to add new tests for
multi-size THP, where available.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/cow.c | 121 +++++++++++++++++--------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 7324ce5363c0..4d0b5a125d3c 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -32,7 +32,7 @@
 
 static size_t pagesize;
 static int pagemap_fd;
-static size_t thpsize;
+static size_t pmdsize;
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 static int gup_fd;
@@ -734,7 +734,7 @@ enum thp_run {
 	THP_RUN_PARTIAL_SHARED,
 };
 
-static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
+static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
 {
 	char *mem, *mmap_mem, *tmp, *mremap_mem = MAP_FAILED;
 	size_t size, mmap_size, mremap_size;
@@ -759,11 +759,11 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 	}
 
 	/*
-	 * Try to populate a THP. Touch the first sub-page and test if we get
-	 * another sub-page populated automatically.
+	 * Try to populate a THP. Touch the first sub-page and test if
+	 * we get the last sub-page populated automatically.
 	 */
 	mem[0] = 0;
-	if (!pagemap_is_populated(pagemap_fd, mem + pagesize)) {
+	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
 		ksft_test_result_skip("Did not get a THP populated\n");
 		goto munmap;
 	}
@@ -773,12 +773,14 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 	switch (thp_run) {
 	case THP_RUN_PMD:
 	case THP_RUN_PMD_SWAPOUT:
+		assert(thpsize == pmdsize);
 		break;
 	case THP_RUN_PTE:
 	case THP_RUN_PTE_SWAPOUT:
 		/*
 		 * Trigger PTE-mapping the THP by temporarily mapping a single
-		 * subpage R/O.
+		 * subpage R/O. This is a noop if the THP is not pmdsize (and
+		 * therefore already PTE-mapped).
 		 */
 		ret = mprotect(mem + pagesize, pagesize, PROT_READ);
 		if (ret) {
@@ -875,52 +877,60 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run)
 		munmap(mremap_mem, mremap_size);
 }
 
-static void run_with_thp(test_fn fn, const char *desc)
+static void run_with_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PMD);
+	ksft_print_msg("[RUN] %s ... with THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_PMD, size);
 }
 
-static void run_with_thp_swap(test_fn fn, const char *desc)
+static void run_with_thp_swap(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with swapped-out THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT);
+	ksft_print_msg("[RUN] %s ... with swapped-out THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT, size);
 }
 
-static void run_with_pte_mapped_thp(test_fn fn, const char *desc)
+static void run_with_pte_mapped_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with PTE-mapped THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PTE);
+	ksft_print_msg("[RUN] %s ... with PTE-mapped THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_PTE, size);
 }
 
-static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc)
+static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT);
+	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT, size);
 }
 
-static void run_with_single_pte_of_thp(test_fn fn, const char *desc)
+static void run_with_single_pte_of_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with single PTE of THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_SINGLE_PTE);
+	ksft_print_msg("[RUN] %s ... with single PTE of THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_SINGLE_PTE, size);
 }
 
-static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc)
+static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT);
+	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT, size);
 }
 
-static void run_with_partial_mremap_thp(test_fn fn, const char *desc)
+static void run_with_partial_mremap_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP);
+	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP, size);
 }
 
-static void run_with_partial_shared_thp(test_fn fn, const char *desc)
+static void run_with_partial_shared_thp(test_fn fn, const char *desc, size_t size)
 {
-	ksft_print_msg("[RUN] %s ... with partially shared THP\n", desc);
-	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED);
+	ksft_print_msg("[RUN] %s ... with partially shared THP (%zu kB)\n",
+		desc, size / 1024);
+	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED, size);
 }
 
 static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
@@ -1091,15 +1101,15 @@ static void run_anon_test_case(struct test_case const *test_case)
 
 	run_with_base_page(test_case->fn, test_case->desc);
 	run_with_base_page_swap(test_case->fn, test_case->desc);
-	if (thpsize) {
-		run_with_thp(test_case->fn, test_case->desc);
-		run_with_thp_swap(test_case->fn, test_case->desc);
-		run_with_pte_mapped_thp(test_case->fn, test_case->desc);
-		run_with_pte_mapped_thp_swap(test_case->fn, test_case->desc);
-		run_with_single_pte_of_thp(test_case->fn, test_case->desc);
-		run_with_single_pte_of_thp_swap(test_case->fn, test_case->desc);
-		run_with_partial_mremap_thp(test_case->fn, test_case->desc);
-		run_with_partial_shared_thp(test_case->fn, test_case->desc);
+	if (pmdsize) {
+		run_with_thp(test_case->fn, test_case->desc, pmdsize);
+		run_with_thp_swap(test_case->fn, test_case->desc, pmdsize);
+		run_with_pte_mapped_thp(test_case->fn, test_case->desc, pmdsize);
+		run_with_pte_mapped_thp_swap(test_case->fn, test_case->desc, pmdsize);
+		run_with_single_pte_of_thp(test_case->fn, test_case->desc, pmdsize);
+		run_with_single_pte_of_thp_swap(test_case->fn, test_case->desc, pmdsize);
+		run_with_partial_mremap_thp(test_case->fn, test_case->desc, pmdsize);
+		run_with_partial_shared_thp(test_case->fn, test_case->desc, pmdsize);
 	}
 	for (i = 0; i < nr_hugetlbsizes; i++)
 		run_with_hugetlb(test_case->fn, test_case->desc,
@@ -1120,7 +1130,7 @@ static int tests_per_anon_test_case(void)
 {
 	int tests = 2 + nr_hugetlbsizes;
 
-	if (thpsize)
+	if (pmdsize)
 		tests += 8;
 	return tests;
 }
@@ -1329,7 +1339,7 @@ static void run_anon_thp_test_cases(void)
 {
 	int i;
 
-	if (!thpsize)
+	if (!pmdsize)
 		return;
 
 	ksft_print_msg("[INFO] Anonymous THP tests\n");
@@ -1338,13 +1348,13 @@ static void run_anon_thp_test_cases(void)
 		struct test_case const *test_case = &anon_thp_test_cases[i];
 
 		ksft_print_msg("[RUN] %s\n", test_case->desc);
-		do_run_with_thp(test_case->fn, THP_RUN_PMD);
+		do_run_with_thp(test_case->fn, THP_RUN_PMD, pmdsize);
 	}
 }
 
 static int tests_per_anon_thp_test_case(void)
 {
-	return thpsize ? 1 : 0;
+	return pmdsize ? 1 : 0;
 }
 
 typedef void (*non_anon_test_fn)(char *mem, const char *smem, size_t size);
@@ -1419,7 +1429,7 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	}
 
 	/* For alignment purposes, we need twice the thp size. */
-	mmap_size = 2 * thpsize;
+	mmap_size = 2 * pmdsize;
 	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (mmap_mem == MAP_FAILED) {
@@ -1434,11 +1444,11 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	}
 
 	/* We need a THP-aligned memory area. */
-	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
-	smem = (char *)(((uintptr_t)mmap_smem + thpsize) & ~(thpsize - 1));
+	mem = (char *)(((uintptr_t)mmap_mem + pmdsize) & ~(pmdsize - 1));
+	smem = (char *)(((uintptr_t)mmap_smem + pmdsize) & ~(pmdsize - 1));
 
-	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
-	ret |= madvise(smem, thpsize, MADV_HUGEPAGE);
+	ret = madvise(mem, pmdsize, MADV_HUGEPAGE);
+	ret |= madvise(smem, pmdsize, MADV_HUGEPAGE);
 	if (ret) {
 		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
 		goto munmap;
@@ -1457,7 +1467,7 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 		goto munmap;
 	}
 
-	fn(mem, smem, thpsize);
+	fn(mem, smem, pmdsize);
 munmap:
 	munmap(mmap_mem, mmap_size);
 	if (mmap_smem != MAP_FAILED)
@@ -1650,7 +1660,7 @@ static void run_non_anon_test_case(struct non_anon_test_case const *test_case)
 	run_with_zeropage(test_case->fn, test_case->desc);
 	run_with_memfd(test_case->fn, test_case->desc);
 	run_with_tmpfile(test_case->fn, test_case->desc);
-	if (thpsize)
+	if (pmdsize)
 		run_with_huge_zeropage(test_case->fn, test_case->desc);
 	for (i = 0; i < nr_hugetlbsizes; i++)
 		run_with_memfd_hugetlb(test_case->fn, test_case->desc,
@@ -1671,7 +1681,7 @@ static int tests_per_non_anon_test_case(void)
 {
 	int tests = 3 + nr_hugetlbsizes;
 
-	if (thpsize)
+	if (pmdsize)
 		tests += 1;
 	return tests;
 }
@@ -1681,10 +1691,13 @@ int main(int argc, char **argv)
 	int err;
 
 	pagesize = getpagesize();
-	thpsize = read_pmd_pagesize();
-	if (thpsize)
+	pmdsize = read_pmd_pagesize();
+	if (pmdsize) {
+		ksft_print_msg("[INFO] detected PMD size: %zu KiB\n",
+			       pmdsize / 1024);
 		ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
-			       thpsize / 1024);
+			       pmdsize / 1024);
+	}
 	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
 						    ARRAY_SIZE(hugetlbsizes));
 	detect_huge_zeropage();
-- 
2.25.1

