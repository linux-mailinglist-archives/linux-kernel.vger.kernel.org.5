Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28B3803006
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjLDKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbjLDKVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:21:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65514CC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:21:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68875FEC;
        Mon,  4 Dec 2023 02:21:57 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3691A3F6C4;
        Mon,  4 Dec 2023 02:21:07 -0800 (PST)
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
Subject: [PATCH v8 06/10] selftests/mm: Factor out thp settings management
Date:   Mon,  4 Dec 2023 10:20:23 +0000
Message-Id: <20231204102027.57185-7-ryan.roberts@arm.com>
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

The khugepaged test has a useful framework for save/restore/pop/push of
all thp settings via the sysfs interface. This will be useful to
explicitly control multi-size THP settings in other tests, so let's
move it out of khugepaged and into its own thp_settings.[c|h] utility.

Tested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/Makefile       |   4 +-
 tools/testing/selftests/mm/khugepaged.c   | 346 ++--------------------
 tools/testing/selftests/mm/thp_settings.c | 296 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.h |  71 +++++
 4 files changed, 391 insertions(+), 326 deletions(-)
 create mode 100644 tools/testing/selftests/mm/thp_settings.c
 create mode 100644 tools/testing/selftests/mm/thp_settings.h

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index dede0bcf97a3..2453add65d12 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -117,8 +117,8 @@ TEST_FILES += va_high_addr_switch.sh
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS): vm_util.c
-$(TEST_GEN_FILES): vm_util.c
+$(TEST_GEN_PROGS): vm_util.c thp_settings.c
+$(TEST_GEN_FILES): vm_util.c thp_settings.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index fc47a1c4944c..b15e7fd70176 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -22,13 +22,13 @@
 #include "linux/magic.h"
 
 #include "vm_util.h"
+#include "thp_settings.h"
 
 #define BASE_ADDR ((void *)(1UL << 30))
 static unsigned long hpage_pmd_size;
 static unsigned long page_size;
 static int hpage_pmd_nr;
 
-#define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
 #define PID_SMAPS "/proc/self/smaps"
 #define TEST_FILE "collapse_test_file"
 
@@ -71,78 +71,7 @@ struct file_info {
 };
 
 static struct file_info finfo;
-
-enum thp_enabled {
-	THP_ALWAYS,
-	THP_MADVISE,
-	THP_NEVER,
-};
-
-static const char *thp_enabled_strings[] = {
-	"always",
-	"madvise",
-	"never",
-	NULL
-};
-
-enum thp_defrag {
-	THP_DEFRAG_ALWAYS,
-	THP_DEFRAG_DEFER,
-	THP_DEFRAG_DEFER_MADVISE,
-	THP_DEFRAG_MADVISE,
-	THP_DEFRAG_NEVER,
-};
-
-static const char *thp_defrag_strings[] = {
-	"always",
-	"defer",
-	"defer+madvise",
-	"madvise",
-	"never",
-	NULL
-};
-
-enum shmem_enabled {
-	SHMEM_ALWAYS,
-	SHMEM_WITHIN_SIZE,
-	SHMEM_ADVISE,
-	SHMEM_NEVER,
-	SHMEM_DENY,
-	SHMEM_FORCE,
-};
-
-static const char *shmem_enabled_strings[] = {
-	"always",
-	"within_size",
-	"advise",
-	"never",
-	"deny",
-	"force",
-	NULL
-};
-
-struct khugepaged_settings {
-	bool defrag;
-	unsigned int alloc_sleep_millisecs;
-	unsigned int scan_sleep_millisecs;
-	unsigned int max_ptes_none;
-	unsigned int max_ptes_swap;
-	unsigned int max_ptes_shared;
-	unsigned long pages_to_scan;
-};
-
-struct settings {
-	enum thp_enabled thp_enabled;
-	enum thp_defrag thp_defrag;
-	enum shmem_enabled shmem_enabled;
-	bool use_zero_page;
-	struct khugepaged_settings khugepaged;
-	unsigned long read_ahead_kb;
-};
-
-static struct settings saved_settings;
 static bool skip_settings_restore;
-
 static int exit_status;
 
 static void success(const char *msg)
@@ -161,226 +90,13 @@ static void skip(const char *msg)
 	printf(" \e[33m%s\e[0m\n", msg);
 }
 
-static int read_file(const char *path, char *buf, size_t buflen)
-{
-	int fd;
-	ssize_t numread;
-
-	fd = open(path, O_RDONLY);
-	if (fd == -1)
-		return 0;
-
-	numread = read(fd, buf, buflen - 1);
-	if (numread < 1) {
-		close(fd);
-		return 0;
-	}
-
-	buf[numread] = '\0';
-	close(fd);
-
-	return (unsigned int) numread;
-}
-
-static int write_file(const char *path, const char *buf, size_t buflen)
-{
-	int fd;
-	ssize_t numwritten;
-
-	fd = open(path, O_WRONLY);
-	if (fd == -1) {
-		printf("open(%s)\n", path);
-		exit(EXIT_FAILURE);
-		return 0;
-	}
-
-	numwritten = write(fd, buf, buflen - 1);
-	close(fd);
-	if (numwritten < 1) {
-		printf("write(%s)\n", buf);
-		exit(EXIT_FAILURE);
-		return 0;
-	}
-
-	return (unsigned int) numwritten;
-}
-
-static int read_string(const char *name, const char *strings[])
-{
-	char path[PATH_MAX];
-	char buf[256];
-	char *c;
-	int ret;
-
-	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-
-	if (!read_file(path, buf, sizeof(buf))) {
-		perror(path);
-		exit(EXIT_FAILURE);
-	}
-
-	c = strchr(buf, '[');
-	if (!c) {
-		printf("%s: Parse failure\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-
-	c++;
-	memmove(buf, c, sizeof(buf) - (c - buf));
-
-	c = strchr(buf, ']');
-	if (!c) {
-		printf("%s: Parse failure\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-	*c = '\0';
-
-	ret = 0;
-	while (strings[ret]) {
-		if (!strcmp(strings[ret], buf))
-			return ret;
-		ret++;
-	}
-
-	printf("Failed to parse %s\n", name);
-	exit(EXIT_FAILURE);
-}
-
-static void write_string(const char *name, const char *val)
-{
-	char path[PATH_MAX];
-	int ret;
-
-	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-
-	if (!write_file(path, val, strlen(val) + 1)) {
-		perror(path);
-		exit(EXIT_FAILURE);
-	}
-}
-
-static const unsigned long _read_num(const char *path)
-{
-	char buf[21];
-
-	if (read_file(path, buf, sizeof(buf)) < 0) {
-		perror("read_file(read_num)");
-		exit(EXIT_FAILURE);
-	}
-
-	return strtoul(buf, NULL, 10);
-}
-
-static const unsigned long read_num(const char *name)
-{
-	char path[PATH_MAX];
-	int ret;
-
-	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-	return _read_num(path);
-}
-
-static void _write_num(const char *path, unsigned long num)
-{
-	char buf[21];
-
-	sprintf(buf, "%ld", num);
-	if (!write_file(path, buf, strlen(buf) + 1)) {
-		perror(path);
-		exit(EXIT_FAILURE);
-	}
-}
-
-static void write_num(const char *name, unsigned long num)
-{
-	char path[PATH_MAX];
-	int ret;
-
-	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-	_write_num(path, num);
-}
-
-static void write_settings(struct settings *settings)
-{
-	struct khugepaged_settings *khugepaged = &settings->khugepaged;
-
-	write_string("enabled", thp_enabled_strings[settings->thp_enabled]);
-	write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
-	write_string("shmem_enabled",
-			shmem_enabled_strings[settings->shmem_enabled]);
-	write_num("use_zero_page", settings->use_zero_page);
-
-	write_num("khugepaged/defrag", khugepaged->defrag);
-	write_num("khugepaged/alloc_sleep_millisecs",
-			khugepaged->alloc_sleep_millisecs);
-	write_num("khugepaged/scan_sleep_millisecs",
-			khugepaged->scan_sleep_millisecs);
-	write_num("khugepaged/max_ptes_none", khugepaged->max_ptes_none);
-	write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap);
-	write_num("khugepaged/max_ptes_shared", khugepaged->max_ptes_shared);
-	write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan);
-
-	if (file_ops && finfo.type == VMA_FILE)
-		_write_num(finfo.dev_queue_read_ahead_path,
-			   settings->read_ahead_kb);
-}
-
-#define MAX_SETTINGS_DEPTH 4
-static struct settings settings_stack[MAX_SETTINGS_DEPTH];
-static int settings_index;
-
-static struct settings *current_settings(void)
-{
-	if (!settings_index) {
-		printf("Fail: No settings set");
-		exit(EXIT_FAILURE);
-	}
-	return settings_stack + settings_index - 1;
-}
-
-static void push_settings(struct settings *settings)
-{
-	if (settings_index >= MAX_SETTINGS_DEPTH) {
-		printf("Fail: Settings stack exceeded");
-		exit(EXIT_FAILURE);
-	}
-	settings_stack[settings_index++] = *settings;
-	write_settings(current_settings());
-}
-
-static void pop_settings(void)
-{
-	if (settings_index <= 0) {
-		printf("Fail: Settings stack empty");
-		exit(EXIT_FAILURE);
-	}
-	--settings_index;
-	write_settings(current_settings());
-}
-
 static void restore_settings_atexit(void)
 {
 	if (skip_settings_restore)
 		return;
 
 	printf("Restore THP and khugepaged settings...");
-	write_settings(&saved_settings);
+	thp_restore_settings();
 	success("OK");
 
 	skip_settings_restore = true;
@@ -395,27 +111,9 @@ static void restore_settings(int sig)
 static void save_settings(void)
 {
 	printf("Save THP and khugepaged settings...");
-	saved_settings = (struct settings) {
-		.thp_enabled = read_string("enabled", thp_enabled_strings),
-		.thp_defrag = read_string("defrag", thp_defrag_strings),
-		.shmem_enabled =
-			read_string("shmem_enabled", shmem_enabled_strings),
-		.use_zero_page = read_num("use_zero_page"),
-	};
-	saved_settings.khugepaged = (struct khugepaged_settings) {
-		.defrag = read_num("khugepaged/defrag"),
-		.alloc_sleep_millisecs =
-			read_num("khugepaged/alloc_sleep_millisecs"),
-		.scan_sleep_millisecs =
-			read_num("khugepaged/scan_sleep_millisecs"),
-		.max_ptes_none = read_num("khugepaged/max_ptes_none"),
-		.max_ptes_swap = read_num("khugepaged/max_ptes_swap"),
-		.max_ptes_shared = read_num("khugepaged/max_ptes_shared"),
-		.pages_to_scan = read_num("khugepaged/pages_to_scan"),
-	};
 	if (file_ops && finfo.type == VMA_FILE)
-		saved_settings.read_ahead_kb =
-				_read_num(finfo.dev_queue_read_ahead_path);
+		thp_set_read_ahead_path(finfo.dev_queue_read_ahead_path);
+	thp_save_settings();
 
 	success("OK");
 
@@ -798,7 +496,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
 			       struct mem_ops *ops, bool expect)
 {
 	int ret;
-	struct settings settings = *current_settings();
+	struct thp_settings settings = *thp_current_settings();
 
 	printf("%s...", msg);
 
@@ -808,7 +506,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
 	 */
 	settings.thp_enabled = THP_NEVER;
 	settings.shmem_enabled = SHMEM_NEVER;
-	push_settings(&settings);
+	thp_push_settings(&settings);
 
 	/* Clear VM_NOHUGEPAGE */
 	madvise(p, nr_hpages * hpage_pmd_size, MADV_HUGEPAGE);
@@ -820,7 +518,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
 	else
 		success("OK");
 
-	pop_settings();
+	thp_pop_settings();
 }
 
 static void madvise_collapse(const char *msg, char *p, int nr_hpages,
@@ -850,13 +548,13 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 	madvise(p, nr_hpages * hpage_pmd_size, MADV_HUGEPAGE);
 
 	/* Wait until the second full_scan completed */
-	full_scans = read_num("khugepaged/full_scans") + 2;
+	full_scans = thp_read_num("khugepaged/full_scans") + 2;
 
 	printf("%s...", msg);
 	while (timeout--) {
 		if (ops->check_huge(p, nr_hpages))
 			break;
-		if (read_num("khugepaged/full_scans") >= full_scans)
+		if (thp_read_num("khugepaged/full_scans") >= full_scans)
 			break;
 		printf(".");
 		usleep(TICK);
@@ -911,11 +609,11 @@ static bool is_tmpfs(struct mem_ops *ops)
 
 static void alloc_at_fault(void)
 {
-	struct settings settings = *current_settings();
+	struct thp_settings settings = *thp_current_settings();
 	char *p;
 
 	settings.thp_enabled = THP_ALWAYS;
-	push_settings(&settings);
+	thp_push_settings(&settings);
 
 	p = alloc_mapping(1);
 	*p = 1;
@@ -925,7 +623,7 @@ static void alloc_at_fault(void)
 	else
 		fail("Fail");
 
-	pop_settings();
+	thp_pop_settings();
 
 	madvise(p, page_size, MADV_DONTNEED);
 	printf("Split huge PMD on MADV_DONTNEED...");
@@ -973,11 +671,11 @@ static void collapse_single_pte_entry(struct collapse_context *c, struct mem_ops
 static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *ops)
 {
 	int max_ptes_none = hpage_pmd_nr / 2;
-	struct settings settings = *current_settings();
+	struct thp_settings settings = *thp_current_settings();
 	void *p;
 
 	settings.khugepaged.max_ptes_none = max_ptes_none;
-	push_settings(&settings);
+	thp_push_settings(&settings);
 
 	p = ops->setup_area(1);
 
@@ -1002,7 +700,7 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
 	}
 skip:
 	ops->cleanup_area(p, hpage_pmd_size);
-	pop_settings();
+	thp_pop_settings();
 }
 
 static void collapse_swapin_single_pte(struct collapse_context *c, struct mem_ops *ops)
@@ -1033,7 +731,7 @@ static void collapse_swapin_single_pte(struct collapse_context *c, struct mem_op
 
 static void collapse_max_ptes_swap(struct collapse_context *c, struct mem_ops *ops)
 {
-	int max_ptes_swap = read_num("khugepaged/max_ptes_swap");
+	int max_ptes_swap = thp_read_num("khugepaged/max_ptes_swap");
 	void *p;
 
 	p = ops->setup_area(1);
@@ -1250,11 +948,11 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 			fail("Fail");
 		ops->fault(p, 0, page_size);
 
-		write_num("khugepaged/max_ptes_shared", hpage_pmd_nr - 1);
+		thp_write_num("khugepaged/max_ptes_shared", hpage_pmd_nr - 1);
 		c->collapse("Collapse PTE table full of compound pages in child",
 			    p, 1, ops, true);
-		write_num("khugepaged/max_ptes_shared",
-			  current_settings()->khugepaged.max_ptes_shared);
+		thp_write_num("khugepaged/max_ptes_shared",
+			  thp_current_settings()->khugepaged.max_ptes_shared);
 
 		validate_memory(p, 0, hpage_pmd_size);
 		ops->cleanup_area(p, hpage_pmd_size);
@@ -1275,7 +973,7 @@ static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *o
 
 static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops *ops)
 {
-	int max_ptes_shared = read_num("khugepaged/max_ptes_shared");
+	int max_ptes_shared = thp_read_num("khugepaged/max_ptes_shared");
 	int wstatus;
 	void *p;
 
@@ -1443,7 +1141,7 @@ static void parse_test_type(int argc, const char **argv)
 
 int main(int argc, const char **argv)
 {
-	struct settings default_settings = {
+	struct thp_settings default_settings = {
 		.thp_enabled = THP_MADVISE,
 		.thp_defrag = THP_DEFRAG_ALWAYS,
 		.shmem_enabled = SHMEM_ADVISE,
@@ -1484,7 +1182,7 @@ int main(int argc, const char **argv)
 	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
 
 	save_settings();
-	push_settings(&default_settings);
+	thp_push_settings(&default_settings);
 
 	alloc_at_fault();
 
diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
new file mode 100644
index 000000000000..5e8ec792cac7
--- /dev/null
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "thp_settings.h"
+
+#define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
+#define MAX_SETTINGS_DEPTH 4
+static struct thp_settings settings_stack[MAX_SETTINGS_DEPTH];
+static int settings_index;
+static struct thp_settings saved_settings;
+static char dev_queue_read_ahead_path[PATH_MAX];
+
+static const char * const thp_enabled_strings[] = {
+	"always",
+	"madvise",
+	"never",
+	NULL
+};
+
+static const char * const thp_defrag_strings[] = {
+	"always",
+	"defer",
+	"defer+madvise",
+	"madvise",
+	"never",
+	NULL
+};
+
+static const char * const shmem_enabled_strings[] = {
+	"always",
+	"within_size",
+	"advise",
+	"never",
+	"deny",
+	"force",
+	NULL
+};
+
+int read_file(const char *path, char *buf, size_t buflen)
+{
+	int fd;
+	ssize_t numread;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return 0;
+
+	numread = read(fd, buf, buflen - 1);
+	if (numread < 1) {
+		close(fd);
+		return 0;
+	}
+
+	buf[numread] = '\0';
+	close(fd);
+
+	return (unsigned int) numread;
+}
+
+int write_file(const char *path, const char *buf, size_t buflen)
+{
+	int fd;
+	ssize_t numwritten;
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1) {
+		printf("open(%s)\n", path);
+		exit(EXIT_FAILURE);
+		return 0;
+	}
+
+	numwritten = write(fd, buf, buflen - 1);
+	close(fd);
+	if (numwritten < 1) {
+		printf("write(%s)\n", buf);
+		exit(EXIT_FAILURE);
+		return 0;
+	}
+
+	return (unsigned int) numwritten;
+}
+
+const unsigned long read_num(const char *path)
+{
+	char buf[21];
+
+	if (read_file(path, buf, sizeof(buf)) < 0) {
+		perror("read_file()");
+		exit(EXIT_FAILURE);
+	}
+
+	return strtoul(buf, NULL, 10);
+}
+
+void write_num(const char *path, unsigned long num)
+{
+	char buf[21];
+
+	sprintf(buf, "%ld", num);
+	if (!write_file(path, buf, strlen(buf) + 1)) {
+		perror(path);
+		exit(EXIT_FAILURE);
+	}
+}
+
+int thp_read_string(const char *name, const char * const strings[])
+{
+	char path[PATH_MAX];
+	char buf[256];
+	char *c;
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!read_file(path, buf, sizeof(buf))) {
+		perror(path);
+		exit(EXIT_FAILURE);
+	}
+
+	c = strchr(buf, '[');
+	if (!c) {
+		printf("%s: Parse failure\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	c++;
+	memmove(buf, c, sizeof(buf) - (c - buf));
+
+	c = strchr(buf, ']');
+	if (!c) {
+		printf("%s: Parse failure\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+	*c = '\0';
+
+	ret = 0;
+	while (strings[ret]) {
+		if (!strcmp(strings[ret], buf))
+			return ret;
+		ret++;
+	}
+
+	printf("Failed to parse %s\n", name);
+	exit(EXIT_FAILURE);
+}
+
+void thp_write_string(const char *name, const char *val)
+{
+	char path[PATH_MAX];
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!write_file(path, val, strlen(val) + 1)) {
+		perror(path);
+		exit(EXIT_FAILURE);
+	}
+}
+
+const unsigned long thp_read_num(const char *name)
+{
+	char path[PATH_MAX];
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+	return read_num(path);
+}
+
+void thp_write_num(const char *name, unsigned long num)
+{
+	char path[PATH_MAX];
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+	write_num(path, num);
+}
+
+void thp_read_settings(struct thp_settings *settings)
+{
+	*settings = (struct thp_settings) {
+		.thp_enabled = thp_read_string("enabled", thp_enabled_strings),
+		.thp_defrag = thp_read_string("defrag", thp_defrag_strings),
+		.shmem_enabled =
+			thp_read_string("shmem_enabled", shmem_enabled_strings),
+		.use_zero_page = thp_read_num("use_zero_page"),
+	};
+	settings->khugepaged = (struct khugepaged_settings) {
+		.defrag = thp_read_num("khugepaged/defrag"),
+		.alloc_sleep_millisecs =
+			thp_read_num("khugepaged/alloc_sleep_millisecs"),
+		.scan_sleep_millisecs =
+			thp_read_num("khugepaged/scan_sleep_millisecs"),
+		.max_ptes_none = thp_read_num("khugepaged/max_ptes_none"),
+		.max_ptes_swap = thp_read_num("khugepaged/max_ptes_swap"),
+		.max_ptes_shared = thp_read_num("khugepaged/max_ptes_shared"),
+		.pages_to_scan = thp_read_num("khugepaged/pages_to_scan"),
+	};
+	if (dev_queue_read_ahead_path[0])
+		settings->read_ahead_kb = read_num(dev_queue_read_ahead_path);
+}
+
+void thp_write_settings(struct thp_settings *settings)
+{
+	struct khugepaged_settings *khugepaged = &settings->khugepaged;
+
+	thp_write_string("enabled", thp_enabled_strings[settings->thp_enabled]);
+	thp_write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
+	thp_write_string("shmem_enabled",
+			shmem_enabled_strings[settings->shmem_enabled]);
+	thp_write_num("use_zero_page", settings->use_zero_page);
+
+	thp_write_num("khugepaged/defrag", khugepaged->defrag);
+	thp_write_num("khugepaged/alloc_sleep_millisecs",
+			khugepaged->alloc_sleep_millisecs);
+	thp_write_num("khugepaged/scan_sleep_millisecs",
+			khugepaged->scan_sleep_millisecs);
+	thp_write_num("khugepaged/max_ptes_none", khugepaged->max_ptes_none);
+	thp_write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap);
+	thp_write_num("khugepaged/max_ptes_shared", khugepaged->max_ptes_shared);
+	thp_write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan);
+
+	if (dev_queue_read_ahead_path[0])
+		write_num(dev_queue_read_ahead_path, settings->read_ahead_kb);
+}
+
+struct thp_settings *thp_current_settings(void)
+{
+	if (!settings_index) {
+		printf("Fail: No settings set");
+		exit(EXIT_FAILURE);
+	}
+	return settings_stack + settings_index - 1;
+}
+
+void thp_push_settings(struct thp_settings *settings)
+{
+	if (settings_index >= MAX_SETTINGS_DEPTH) {
+		printf("Fail: Settings stack exceeded");
+		exit(EXIT_FAILURE);
+	}
+	settings_stack[settings_index++] = *settings;
+	thp_write_settings(thp_current_settings());
+}
+
+void thp_pop_settings(void)
+{
+	if (settings_index <= 0) {
+		printf("Fail: Settings stack empty");
+		exit(EXIT_FAILURE);
+	}
+	--settings_index;
+	thp_write_settings(thp_current_settings());
+}
+
+void thp_restore_settings(void)
+{
+	thp_write_settings(&saved_settings);
+}
+
+void thp_save_settings(void)
+{
+	thp_read_settings(&saved_settings);
+}
+
+void thp_set_read_ahead_path(char *path)
+{
+	if (!path) {
+		dev_queue_read_ahead_path[0] = '\0';
+		return;
+	}
+
+	strncpy(dev_queue_read_ahead_path, path,
+		sizeof(dev_queue_read_ahead_path));
+	dev_queue_read_ahead_path[sizeof(dev_queue_read_ahead_path) - 1] = '\0';
+}
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
new file mode 100644
index 000000000000..ff3d98c30617
--- /dev/null
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __THP_SETTINGS_H__
+#define __THP_SETTINGS_H__
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+enum thp_enabled {
+	THP_ALWAYS,
+	THP_MADVISE,
+	THP_NEVER,
+};
+
+enum thp_defrag {
+	THP_DEFRAG_ALWAYS,
+	THP_DEFRAG_DEFER,
+	THP_DEFRAG_DEFER_MADVISE,
+	THP_DEFRAG_MADVISE,
+	THP_DEFRAG_NEVER,
+};
+
+enum shmem_enabled {
+	SHMEM_ALWAYS,
+	SHMEM_WITHIN_SIZE,
+	SHMEM_ADVISE,
+	SHMEM_NEVER,
+	SHMEM_DENY,
+	SHMEM_FORCE,
+};
+
+struct khugepaged_settings {
+	bool defrag;
+	unsigned int alloc_sleep_millisecs;
+	unsigned int scan_sleep_millisecs;
+	unsigned int max_ptes_none;
+	unsigned int max_ptes_swap;
+	unsigned int max_ptes_shared;
+	unsigned long pages_to_scan;
+};
+
+struct thp_settings {
+	enum thp_enabled thp_enabled;
+	enum thp_defrag thp_defrag;
+	enum shmem_enabled shmem_enabled;
+	bool use_zero_page;
+	struct khugepaged_settings khugepaged;
+	unsigned long read_ahead_kb;
+};
+
+int read_file(const char *path, char *buf, size_t buflen);
+int write_file(const char *path, const char *buf, size_t buflen);
+const unsigned long read_num(const char *path);
+void write_num(const char *path, unsigned long num);
+
+int thp_read_string(const char *name, const char * const strings[]);
+void thp_write_string(const char *name, const char *val);
+const unsigned long thp_read_num(const char *name);
+void thp_write_num(const char *name, unsigned long num);
+
+void thp_write_settings(struct thp_settings *settings);
+void thp_read_settings(struct thp_settings *settings);
+struct thp_settings *thp_current_settings(void);
+void thp_push_settings(struct thp_settings *settings);
+void thp_pop_settings(void);
+void thp_restore_settings(void);
+void thp_save_settings(void);
+
+void thp_set_read_ahead_path(char *path);
+
+#endif /* __THP_SETTINGS_H__ */
-- 
2.25.1

