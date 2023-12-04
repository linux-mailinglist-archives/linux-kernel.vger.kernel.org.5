Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A580300B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbjLDKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbjLDKVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:21:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 716B5F5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:21:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7525D1684;
        Mon,  4 Dec 2023 02:22:00 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3633F6C4;
        Mon,  4 Dec 2023 02:21:10 -0800 (PST)
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
Subject: [PATCH v8 07/10] selftests/mm: Support multi-size THP interface in thp_settings
Date:   Mon,  4 Dec 2023 10:20:24 +0000
Message-Id: <20231204102027.57185-8-ryan.roberts@arm.com>
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

Save and restore the new per-size hugepage enabled setting, if available
on the running kernel.

Since the number of per-size directories is not fixed, solve this as
simply as possible by catering for a maximum number in the thp_settings
struct (20). Each array index is the order. The value of THP_NEVER is
changed to 0 so that all of these new settings default to THP_NEVER and
the user only needs to fill in the ones they want to enable.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/khugepaged.c   |  3 ++
 tools/testing/selftests/mm/thp_settings.c | 55 ++++++++++++++++++++++-
 tools/testing/selftests/mm/thp_settings.h | 11 ++++-
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index b15e7fd70176..7bd3baa9d34b 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1141,6 +1141,7 @@ static void parse_test_type(int argc, const char **argv)
 
 int main(int argc, const char **argv)
 {
+	int hpage_pmd_order;
 	struct thp_settings default_settings = {
 		.thp_enabled = THP_MADVISE,
 		.thp_defrag = THP_DEFRAG_ALWAYS,
@@ -1175,11 +1176,13 @@ int main(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 	hpage_pmd_nr = hpage_pmd_size / page_size;
+	hpage_pmd_order = __builtin_ctz(hpage_pmd_nr);
 
 	default_settings.khugepaged.max_ptes_none = hpage_pmd_nr - 1;
 	default_settings.khugepaged.max_ptes_swap = hpage_pmd_nr / 8;
 	default_settings.khugepaged.max_ptes_shared = hpage_pmd_nr / 2;
 	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
+	default_settings.hugepages[hpage_pmd_order].enabled = THP_INHERIT;
 
 	save_settings();
 	thp_push_settings(&default_settings);
diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
index 5e8ec792cac7..a4163438108e 100644
--- a/tools/testing/selftests/mm/thp_settings.c
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -16,9 +16,10 @@ static struct thp_settings saved_settings;
 static char dev_queue_read_ahead_path[PATH_MAX];
 
 static const char * const thp_enabled_strings[] = {
+	"never",
 	"always",
+	"inherit",
 	"madvise",
-	"never",
 	NULL
 };
 
@@ -198,6 +199,10 @@ void thp_write_num(const char *name, unsigned long num)
 
 void thp_read_settings(struct thp_settings *settings)
 {
+	unsigned long orders = thp_supported_orders();
+	char path[PATH_MAX];
+	int i;
+
 	*settings = (struct thp_settings) {
 		.thp_enabled = thp_read_string("enabled", thp_enabled_strings),
 		.thp_defrag = thp_read_string("defrag", thp_defrag_strings),
@@ -218,11 +223,26 @@ void thp_read_settings(struct thp_settings *settings)
 	};
 	if (dev_queue_read_ahead_path[0])
 		settings->read_ahead_kb = read_num(dev_queue_read_ahead_path);
+
+	for (i = 0; i < NR_ORDERS; i++) {
+		if (!((1 << i) & orders)) {
+			settings->hugepages[i].enabled = THP_NEVER;
+			continue;
+		}
+		snprintf(path, PATH_MAX, "hugepages-%ukB/enabled",
+			(getpagesize() >> 10) << i);
+		settings->hugepages[i].enabled =
+			thp_read_string(path, thp_enabled_strings);
+	}
 }
 
 void thp_write_settings(struct thp_settings *settings)
 {
 	struct khugepaged_settings *khugepaged = &settings->khugepaged;
+	unsigned long orders = thp_supported_orders();
+	char path[PATH_MAX];
+	int enabled;
+	int i;
 
 	thp_write_string("enabled", thp_enabled_strings[settings->thp_enabled]);
 	thp_write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
@@ -242,6 +262,15 @@ void thp_write_settings(struct thp_settings *settings)
 
 	if (dev_queue_read_ahead_path[0])
 		write_num(dev_queue_read_ahead_path, settings->read_ahead_kb);
+
+	for (i = 0; i < NR_ORDERS; i++) {
+		if (!((1 << i) & orders))
+			continue;
+		snprintf(path, PATH_MAX, "hugepages-%ukB/enabled",
+			(getpagesize() >> 10) << i);
+		enabled = settings->hugepages[i].enabled;
+		thp_write_string(path, thp_enabled_strings[enabled]);
+	}
 }
 
 struct thp_settings *thp_current_settings(void)
@@ -294,3 +323,27 @@ void thp_set_read_ahead_path(char *path)
 		sizeof(dev_queue_read_ahead_path));
 	dev_queue_read_ahead_path[sizeof(dev_queue_read_ahead_path) - 1] = '\0';
 }
+
+unsigned long thp_supported_orders(void)
+{
+	unsigned long orders = 0;
+	char path[PATH_MAX];
+	char buf[256];
+	int ret;
+	int i;
+
+	for (i = 0; i < NR_ORDERS; i++) {
+		ret = snprintf(path, PATH_MAX, THP_SYSFS "hugepages-%ukB/enabled",
+			(getpagesize() >> 10) << i);
+		if (ret >= PATH_MAX) {
+			printf("%s: Pathname is too long\n", __func__);
+			exit(EXIT_FAILURE);
+		}
+
+		ret = read_file(path, buf, sizeof(buf));
+		if (ret)
+			orders |= 1UL << i;
+	}
+
+	return orders;
+}
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
index ff3d98c30617..71cbff05f4c7 100644
--- a/tools/testing/selftests/mm/thp_settings.h
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -7,9 +7,10 @@
 #include <stdint.h>
 
 enum thp_enabled {
+	THP_NEVER,
 	THP_ALWAYS,
+	THP_INHERIT,
 	THP_MADVISE,
-	THP_NEVER,
 };
 
 enum thp_defrag {
@@ -29,6 +30,12 @@ enum shmem_enabled {
 	SHMEM_FORCE,
 };
 
+#define NR_ORDERS 20
+
+struct hugepages_settings {
+	enum thp_enabled enabled;
+};
+
 struct khugepaged_settings {
 	bool defrag;
 	unsigned int alloc_sleep_millisecs;
@@ -46,6 +53,7 @@ struct thp_settings {
 	bool use_zero_page;
 	struct khugepaged_settings khugepaged;
 	unsigned long read_ahead_kb;
+	struct hugepages_settings hugepages[NR_ORDERS];
 };
 
 int read_file(const char *path, char *buf, size_t buflen);
@@ -67,5 +75,6 @@ void thp_restore_settings(void);
 void thp_save_settings(void);
 
 void thp_set_read_ahead_path(char *path);
+unsigned long thp_supported_orders(void);
 
 #endif /* __THP_SETTINGS_H__ */
-- 
2.25.1

