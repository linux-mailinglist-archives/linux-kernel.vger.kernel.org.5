Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915F77B31A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjI2Lpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjI2LpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:45:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88AC11B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:44:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C4B61007;
        Fri, 29 Sep 2023 04:45:36 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1783F59C;
        Fri, 29 Sep 2023 04:44:55 -0700 (PDT)
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
Subject: [PATCH v6 9/9] selftests/mm/cow: Add tests for small-order anon THP
Date:   Fri, 29 Sep 2023 12:44:20 +0100
Message-Id: <20230929114421.3761121-10-ryan.roberts@arm.com>
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

Add tests similar to the existing THP tests, but which operate on memory
backed by smaller-order, PTE-mapped THP. This reuses all the existing
infrastructure. If the test suite detects that small-order THP is not
supported by the kernel, the new tests are skipped.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/cow.c | 93 ++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index d887ce454e34..6c5e37d8bb69 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -33,10 +33,13 @@
 static size_t pagesize;
 static int pagemap_fd;
 static size_t pmdsize;
+static size_t ptesize;
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 static int gup_fd;
 static bool has_huge_zeropage;
+static unsigned int orig_anon_orders;
+static bool orig_anon_orders_valid;
 
 static void detect_huge_zeropage(void)
 {
@@ -1118,6 +1121,14 @@ static void run_anon_test_case(struct test_case const *test_case)
 		run_with_partial_mremap_thp(test_case->fn, test_case->desc, pmdsize);
 		run_with_partial_shared_thp(test_case->fn, test_case->desc, pmdsize);
 	}
+	if (ptesize) {
+		run_with_pte_mapped_thp(test_case->fn, test_case->desc, ptesize);
+		run_with_pte_mapped_thp_swap(test_case->fn, test_case->desc, ptesize);
+		run_with_single_pte_of_thp(test_case->fn, test_case->desc, ptesize);
+		run_with_single_pte_of_thp_swap(test_case->fn, test_case->desc, ptesize);
+		run_with_partial_mremap_thp(test_case->fn, test_case->desc, ptesize);
+		run_with_partial_shared_thp(test_case->fn, test_case->desc, ptesize);
+	}
 	for (i = 0; i < nr_hugetlbsizes; i++)
 		run_with_hugetlb(test_case->fn, test_case->desc,
 				 hugetlbsizes[i]);
@@ -1139,6 +1150,8 @@ static int tests_per_anon_test_case(void)
 
 	if (pmdsize)
 		tests += 8;
+	if (ptesize)
+		tests += 6;
 	return tests;
 }
 
@@ -1693,6 +1706,80 @@ static int tests_per_non_anon_test_case(void)
 	return tests;
 }
 
+#define ANON_ORDERS_FILE "/sys/kernel/mm/transparent_hugepage/anon_orders"
+
+static int read_anon_orders(unsigned int *orders)
+{
+	ssize_t buflen = 80;
+	char buf[buflen];
+	int fd;
+
+	fd = open(ANON_ORDERS_FILE, O_RDONLY);
+	if (fd == -1)
+		return -1;
+
+	buflen = read(fd, buf, buflen);
+	close(fd);
+
+	if (buflen < 1)
+		return -1;
+
+	*orders = strtoul(buf, NULL, 16);
+
+	return 0;
+}
+
+static int write_anon_orders(unsigned int orders)
+{
+	ssize_t buflen = 80;
+	char buf[buflen];
+	int fd;
+
+	fd = open(ANON_ORDERS_FILE, O_WRONLY);
+	if (fd == -1)
+		return -1;
+
+	buflen = snprintf(buf, buflen, "0x%08x\n", orders);
+	buflen = write(fd, buf, buflen);
+	close(fd);
+
+	if (buflen < 1)
+		return -1;
+
+	return 0;
+}
+
+static size_t save_thp_anon_orders(void)
+{
+	/*
+	 * If the kernel supports multiple orders for anon THP (indicated by the
+	 * presence of anon_orders file), configure it for the PMD-order and the
+	 * PMD-order - 1, which we will report back and use as the PTE-order THP
+	 * size. Save the original value so that it can be restored on exit. If
+	 * the kernel does not support multiple orders, report back 0 for the
+	 * PTE-size so those tests are skipped.
+	 */
+
+	int pteorder = sz2ord(pmdsize) - 1;
+	unsigned int orders = (1UL << sz2ord(pmdsize)) | (1UL << pteorder);
+
+	if (read_anon_orders(&orig_anon_orders))
+		return 0;
+
+	orig_anon_orders_valid = true;
+
+	if (write_anon_orders(orders))
+		return 0;
+
+	return pagesize << pteorder;
+}
+
+static void restore_thp_anon_orders(void)
+{
+	if (orig_anon_orders_valid)
+		write_anon_orders(orig_anon_orders);
+}
+
 int main(int argc, char **argv)
 {
 	int err;
@@ -1702,6 +1789,10 @@ int main(int argc, char **argv)
 	if (pmdsize)
 		ksft_print_msg("[INFO] detected PMD-mapped THP size: %zu KiB\n",
 			       pmdsize / 1024);
+	ptesize = save_thp_anon_orders();
+	if (ptesize)
+		ksft_print_msg("[INFO] configured PTE-mapped THP size: %zu KiB\n",
+			       ptesize / 1024);
 	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
 						    ARRAY_SIZE(hugetlbsizes));
 	detect_huge_zeropage();
@@ -1720,6 +1811,8 @@ int main(int argc, char **argv)
 	run_anon_thp_test_cases();
 	run_non_anon_test_cases();
 
+	restore_thp_anon_orders();
+
 	err = ksft_get_fail_cnt();
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
-- 
2.25.1

