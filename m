Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B34803008
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbjLDKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbjLDKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:21:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E6E1103
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:21:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81DC8169C;
        Mon,  4 Dec 2023 02:22:03 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A9563F6C4;
        Mon,  4 Dec 2023 02:21:13 -0800 (PST)
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
Subject: [PATCH v8 08/10] selftests/mm/khugepaged: Enlighten for multi-size THP
Date:   Mon,  4 Dec 2023 10:20:25 +0000
Message-Id: <20231204102027.57185-9-ryan.roberts@arm.com>
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

The `collapse_max_ptes_none` test was previously failing when a THP size
less than PMD-size had enabled="always". The root cause is because the
test faults in 1 page less than the threshold it set for collapsing. But
when THP is enabled always, we "over allocate" and therefore the
threshold is passed, and collapse unexpectedly succeeds.

Solve this by enlightening khugepaged selftest. Add a command line
option to pass in the desired THP size that should be used for all
anonymous allocations. The harness will then explicitly configure a THP
size as requested and modify the `collapse_max_ptes_none` test so that
it faults in the threshold minus the number of pages in the configured
THP size. If no command line option is provided, default to order 0, as
per previous behaviour.

I chose to use an order in the command line interface, since this makes
the interface agnostic of base page size, making it easier to invoke
from run_vmtests.sh.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/khugepaged.c   | 48 +++++++++++++++++------
 tools/testing/selftests/mm/run_vmtests.sh |  2 +
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 7bd3baa9d34b..829320a519e7 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -28,6 +28,7 @@
 static unsigned long hpage_pmd_size;
 static unsigned long page_size;
 static int hpage_pmd_nr;
+static int anon_order;
 
 #define PID_SMAPS "/proc/self/smaps"
 #define TEST_FILE "collapse_test_file"
@@ -607,6 +608,11 @@ static bool is_tmpfs(struct mem_ops *ops)
 	return ops == &__file_ops && finfo.type == VMA_SHMEM;
 }
 
+static bool is_anon(struct mem_ops *ops)
+{
+	return ops == &__anon_ops;
+}
+
 static void alloc_at_fault(void)
 {
 	struct thp_settings settings = *thp_current_settings();
@@ -673,6 +679,7 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
 	int max_ptes_none = hpage_pmd_nr / 2;
 	struct thp_settings settings = *thp_current_settings();
 	void *p;
+	int fault_nr_pages = is_anon(ops) ? 1 << anon_order : 1;
 
 	settings.khugepaged.max_ptes_none = max_ptes_none;
 	thp_push_settings(&settings);
@@ -686,10 +693,10 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
 		goto skip;
 	}
 
-	ops->fault(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
+	ops->fault(p, 0, (hpage_pmd_nr - max_ptes_none - fault_nr_pages) * page_size);
 	c->collapse("Maybe collapse with max_ptes_none exceeded", p, 1,
 		    ops, !c->enforce_pte_scan_limits);
-	validate_memory(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
+	validate_memory(p, 0, (hpage_pmd_nr - max_ptes_none - fault_nr_pages) * page_size);
 
 	if (c->enforce_pte_scan_limits) {
 		ops->fault(p, 0, (hpage_pmd_nr - max_ptes_none) * page_size);
@@ -1076,7 +1083,7 @@ static void madvise_retracted_page_tables(struct collapse_context *c,
 
 static void usage(void)
 {
-	fprintf(stderr, "\nUsage: ./khugepaged <test type> [dir]\n\n");
+	fprintf(stderr, "\nUsage: ./khugepaged [OPTIONS] <test type> [dir]\n\n");
 	fprintf(stderr, "\t<test type>\t: <context>:<mem_type>\n");
 	fprintf(stderr, "\t<context>\t: [all|khugepaged|madvise]\n");
 	fprintf(stderr, "\t<mem_type>\t: [all|anon|file|shmem]\n");
@@ -1085,15 +1092,34 @@ static void usage(void)
 	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
 	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
 	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
+	fprintf(stderr,	"\n\tSupported Options:\n");
+	fprintf(stderr,	"\t\t-h: This help message.\n");
+	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");
+	fprintf(stderr,	"\t\t    Defaults to 0. Use this size for anon allocations.\n");
 	exit(1);
 }
 
-static void parse_test_type(int argc, const char **argv)
+static void parse_test_type(int argc, char **argv)
 {
+	int opt;
 	char *buf;
 	const char *token;
 
-	if (argc == 1) {
+	while ((opt = getopt(argc, argv, "s:h")) != -1) {
+		switch (opt) {
+		case 's':
+			anon_order = atoi(optarg);
+			break;
+		case 'h':
+		default:
+			usage();
+		}
+	}
+
+	argv += optind;
+	argc -= optind;
+
+	if (argc == 0) {
 		/* Backwards compatibility */
 		khugepaged_context =  &__khugepaged_context;
 		madvise_context =  &__madvise_context;
@@ -1101,7 +1127,7 @@ static void parse_test_type(int argc, const char **argv)
 		return;
 	}
 
-	buf = strdup(argv[1]);
+	buf = strdup(argv[0]);
 	token = strsep(&buf, ":");
 
 	if (!strcmp(token, "all")) {
@@ -1135,11 +1161,13 @@ static void parse_test_type(int argc, const char **argv)
 	if (!file_ops)
 		return;
 
-	if (argc != 3)
+	if (argc != 2)
 		usage();
+
+	get_finfo(argv[1]);
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	int hpage_pmd_order;
 	struct thp_settings default_settings = {
@@ -1164,9 +1192,6 @@ int main(int argc, const char **argv)
 
 	parse_test_type(argc, argv);
 
-	if (file_ops)
-		get_finfo(argv[2]);
-
 	setbuf(stdout, NULL);
 
 	page_size = getpagesize();
@@ -1183,6 +1208,7 @@ int main(int argc, const char **argv)
 	default_settings.khugepaged.max_ptes_shared = hpage_pmd_nr / 2;
 	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
 	default_settings.hugepages[hpage_pmd_order].enabled = THP_INHERIT;
+	default_settings.hugepages[anon_order].enabled = THP_ALWAYS;
 
 	save_settings();
 	thp_push_settings(&default_settings);
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index c0212258b852..87f513f5cf91 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -357,6 +357,8 @@ CATEGORY="cow" run_test ./cow
 
 CATEGORY="thp" run_test ./khugepaged
 
+CATEGORY="thp" run_test ./khugepaged -s 2
+
 CATEGORY="thp" run_test ./transhuge-stress -d 20
 
 CATEGORY="thp" run_test ./split_huge_page_test
-- 
2.25.1

