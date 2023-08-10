Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9EC777AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjHJOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjHJOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:30:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2502BFA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:30:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B52150C;
        Thu, 10 Aug 2023 07:30:48 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 937D63F64C;
        Thu, 10 Aug 2023 07:30:03 -0700 (PDT)
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
Subject: [PATCH v5 5/5] selftests/mm/cow: Add large anon folio tests
Date:   Thu, 10 Aug 2023 15:29:42 +0100
Message-Id: <20230810142942.3169679-6-ryan.roberts@arm.com>
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

Add tests similar to the existing THP tests, but which operate on memory
backed by large anonymous folios, which are smaller than THP.

This reuses all the existing infrastructure. If the test suite detects
that large anonyomous folios are not supported by the kernel, the new
tests are skipped.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/cow.c | 111 +++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 304882bf2e5d..932242c965a4 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -33,6 +33,7 @@
 static size_t pagesize;
 static int pagemap_fd;
 static size_t thpsize;
+static size_t lafsize;
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 static int gup_fd;
@@ -927,6 +928,42 @@ static void run_with_partial_shared_thp(test_fn fn, const char *desc)
 	do_run_with_large(fn, LARGE_RUN_PARTIAL_SHARED, thpsize);
 }
 
+static void run_with_laf(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with large anon folio\n", desc);
+	do_run_with_large(fn, LARGE_RUN_PTE, lafsize);
+}
+
+static void run_with_laf_swap(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with swapped-out large anon folio\n", desc);
+	do_run_with_large(fn, LARGE_RUN_PTE_SWAPOUT, lafsize);
+}
+
+static void run_with_single_pte_of_laf(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with single PTE of large anon folio\n", desc);
+	do_run_with_large(fn, LARGE_RUN_SINGLE_PTE, lafsize);
+}
+
+static void run_with_single_pte_of_laf_swap(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out large anon folio\n", desc);
+	do_run_with_large(fn, LARGE_RUN_SINGLE_PTE_SWAPOUT, lafsize);
+}
+
+static void run_with_partial_mremap_laf(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with partially mremap()'ed large anon folio\n", desc);
+	do_run_with_large(fn, LARGE_RUN_PARTIAL_MREMAP, lafsize);
+}
+
+static void run_with_partial_shared_laf(test_fn fn, const char *desc)
+{
+	ksft_print_msg("[RUN] %s ... with partially shared large anon folio\n", desc);
+	do_run_with_large(fn, LARGE_RUN_PARTIAL_SHARED, lafsize);
+}
+
 static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
 {
 	int flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
@@ -1105,6 +1142,14 @@ static void run_anon_test_case(struct test_case const *test_case)
 		run_with_partial_mremap_thp(test_case->fn, test_case->desc);
 		run_with_partial_shared_thp(test_case->fn, test_case->desc);
 	}
+	if (lafsize) {
+		run_with_laf(test_case->fn, test_case->desc);
+		run_with_laf_swap(test_case->fn, test_case->desc);
+		run_with_single_pte_of_laf(test_case->fn, test_case->desc);
+		run_with_single_pte_of_laf_swap(test_case->fn, test_case->desc);
+		run_with_partial_mremap_laf(test_case->fn, test_case->desc);
+		run_with_partial_shared_laf(test_case->fn, test_case->desc);
+	}
 	for (i = 0; i < nr_hugetlbsizes; i++)
 		run_with_hugetlb(test_case->fn, test_case->desc,
 				 hugetlbsizes[i]);
@@ -1126,6 +1171,8 @@ static int tests_per_anon_test_case(void)
 
 	if (thpsize)
 		tests += 8;
+	if (lafsize)
+		tests += 6;
 	return tests;
 }
 
@@ -1680,15 +1727,74 @@ static int tests_per_non_anon_test_case(void)
 	return tests;
 }
 
+static size_t large_anon_folio_size(void)
+{
+	/*
+	 * There is no interface to query this. But we know that it must be less
+	 * than thpsize. So we map a thpsize area, aligned to thpsize offset by
+	 * thpsize/2 (to avoid a hugepage being allocated), then touch the first
+	 * page and see how many pages get faulted in.
+	 */
+
+	int max_order = __builtin_ctz(thpsize);
+	size_t mmap_size = thpsize * 3;
+	char *mmap_mem = NULL;
+	int order = 0;
+	char *mem;
+	size_t offset;
+	int ret;
+
+	/* For alignment purposes, we need 2.5x the requested size. */
+	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mmap_mem == MAP_FAILED)
+		goto out;
+
+	/* Align the memory area to thpsize then offset it by thpsize/2. */
+	mem = (char *)(((uintptr_t)mmap_mem + thpsize) & ~(thpsize - 1));
+	mem += thpsize / 2;
+
+	/* We might get a bigger large anon folio when MADV_HUGEPAGE is set. */
+	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
+	if (ret)
+		goto out;
+
+	/* Probe the memory to see how much is populated. */
+	mem[0] = 0;
+	for (order = 0; order < max_order; order++) {
+		offset = (1 << order) * pagesize;
+		if (!pagemap_is_populated(pagemap_fd, mem + offset))
+			break;
+	}
+
+out:
+	if (mmap_mem)
+		munmap(mmap_mem, mmap_size);
+
+	if (order == 0)
+		return 0;
+
+	return offset;
+}
+
 int main(int argc, char **argv)
 {
 	int err;
 
+	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	if (pagemap_fd < 0)
+		ksft_exit_fail_msg("opening pagemap failed\n");
+
 	pagesize = getpagesize();
 	thpsize = read_pmd_pagesize();
 	if (thpsize)
 		ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
 			       thpsize / 1024);
+	lafsize = large_anon_folio_size();
+	if (lafsize)
+		ksft_print_msg("[INFO] detected large anon folio size: %zu KiB\n",
+			       lafsize / 1024);
 	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
 						    ARRAY_SIZE(hugetlbsizes));
 	detect_huge_zeropage();
@@ -1698,11 +1804,6 @@ int main(int argc, char **argv)
 		      ARRAY_SIZE(anon_thp_test_cases) * tests_per_anon_thp_test_case() +
 		      ARRAY_SIZE(non_anon_test_cases) * tests_per_non_anon_test_case());
 
-	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
-	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
-	if (pagemap_fd < 0)
-		ksft_exit_fail_msg("opening pagemap failed\n");
-
 	run_anon_test_cases();
 	run_anon_thp_test_cases();
 	run_non_anon_test_cases();
-- 
2.25.1

