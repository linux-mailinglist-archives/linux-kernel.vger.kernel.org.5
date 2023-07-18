Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2375725B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGRDe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGRDeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:34:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D4BB;
        Mon, 17 Jul 2023 20:34:20 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R4l0c1c5Fz18M3f;
        Tue, 18 Jul 2023 11:33:36 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 11:34:17 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v3 1/3] perf cpumap: Add __perf_cpu_map__new and perf_cpu_map__2_cpuset
Date:   Tue, 18 Jul 2023 11:33:53 +0800
Message-ID: <20230718033355.2960912-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718033355.2960912-1-changbin.du@huawei.com>
References: <20230718033355.2960912-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two new api which will be used later.
  - __perf_cpu_map__new: accept a specified separator instead of ','.
  - perf_cpu_map__2_cpuset: convert perf_cpu_map to cpu_set_t.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/lib/perf/cpumap.c              | 45 ++++++++++++++++++++++++++--
 tools/lib/perf/include/perf/cpumap.h |  4 +++
 tools/lib/perf/libperf.map           |  2 ++
 tools/perf/tests/cpumap.c            | 23 ++++++++++++++
 4 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 2a5a29217374..23e907078b28 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
 #include <perf/cpumap.h>
 #include <stdlib.h>
 #include <linux/refcount.h>
@@ -7,6 +8,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <sched.h>
 #include <ctype.h>
 #include <limits.h>
 
@@ -201,7 +203,7 @@ static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
 	return cpus;
 }
 
-struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
+struct perf_cpu_map *__perf_cpu_map__new(const char *cpu_list, char sep)
 {
 	struct perf_cpu_map *cpus = NULL;
 	unsigned long start_cpu, end_cpu = 0;
@@ -225,7 +227,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 		p = NULL;
 		start_cpu = strtoul(cpu_list, &p, 0);
 		if (start_cpu >= INT_MAX
-		    || (*p != '\0' && *p != ',' && *p != '-'))
+		    || (*p != '\0' && *p != sep && *p != '-'))
 			goto invalid;
 
 		if (*p == '-') {
@@ -233,7 +235,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 			p = NULL;
 			end_cpu = strtoul(cpu_list, &p, 0);
 
-			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ','))
+			if (end_cpu >= INT_MAX || (*p != '\0' && *p != sep))
 				goto invalid;
 
 			if (end_cpu < start_cpu)
@@ -278,6 +280,11 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	return cpus;
 }
 
+struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
+{
+	return __perf_cpu_map__new(cpu_list, ',');
+}
+
 static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
 	return RC_CHK_ACCESS(cpus)->nr;
@@ -479,3 +486,35 @@ struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 	free(tmp_cpus);
 	return merged;
 }
+
+/* The caller is responsible for freeing returned cpu_set_t with CPU_FREE(). */
+cpu_set_t *perf_cpu_map__2_cpuset(struct perf_cpu_map *cpus, size_t *cpuset_size)
+{
+	cpu_set_t *cpusetp;
+	int max_cpu;
+	struct perf_cpu cpu;
+	int idx;
+
+	if (perf_cpu_map__has_any_cpu(cpus))
+		return NULL;
+
+	max_cpu = perf_cpu_map__max(cpus).cpu;
+	if (max_cpu < 0)
+		return NULL;
+
+	cpusetp = CPU_ALLOC(max_cpu + 1);
+	if (cpusetp == NULL)
+		return NULL;
+
+	*cpuset_size = CPU_ALLOC_SIZE(max_cpu + 1);
+	CPU_ZERO_S(*cpuset_size, cpusetp);
+
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		if (cpu.cpu == -1)
+			continue;
+
+		CPU_SET_S(cpu.cpu, *cpuset_size, cpusetp);
+	}
+
+	return cpusetp;
+}
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index e38d859a384d..1a0498f92dbe 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_CPUMAP_H
 
 #include <perf/core.h>
+#include <sched.h>
 #include <stdio.h>
 #include <stdbool.h>
 
@@ -23,6 +24,7 @@ struct perf_cpu_map;
  */
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
+LIBPERF_API struct perf_cpu_map *__perf_cpu_map__new(const char *cpu_list, char sep);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
@@ -46,6 +48,8 @@ LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
  */
 LIBPERF_API bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map);
 
+LIBPERF_API cpu_set_t *perf_cpu_map__2_cpuset(struct perf_cpu_map *cpus, size_t *cpuset_size);
+
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
 	     (idx) < perf_cpu_map__nr(cpus);			\
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 190b56ae923a..fe0946e34471 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -5,6 +5,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__default_new;
 		perf_cpu_map__get;
 		perf_cpu_map__put;
+		__perf_cpu_map__new;
 		perf_cpu_map__new;
 		perf_cpu_map__read;
 		perf_cpu_map__nr;
@@ -12,6 +13,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__empty;
 		perf_cpu_map__max;
 		perf_cpu_map__has;
+		perf_cpu_map__2_cpuset;
 		perf_thread_map__new_array;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 7730fc2ab40b..ae5e5337ea4f 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests.h"
+#include <sched.h>
 #include <stdio.h>
 #include "cpumap.h"
 #include "event.h"
@@ -247,12 +248,34 @@ static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subte
 	return TEST_OK;
 }
 
+static int test__cpu_map_convert(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_cpu_map *any = perf_cpu_map__dummy_new();
+	struct perf_cpu_map *cpus = perf_cpu_map__new("1-2");
+	cpu_set_t *cpu_set;
+	size_t setsize;
+
+	cpu_set = perf_cpu_map__2_cpuset(any, &setsize);
+	TEST_ASSERT_VAL("not equal", cpu_set == NULL);
+	CPU_FREE(cpu_set);
+
+	cpu_set = perf_cpu_map__2_cpuset(cpus, &setsize);
+	TEST_ASSERT_VAL("cpus", cpu_set != NULL);
+	TEST_ASSERT_VAL("bad cpuset", !CPU_ISSET_S(0, setsize, cpu_set));
+	TEST_ASSERT_VAL("bad cpuset", CPU_ISSET_S(1, setsize, cpu_set));
+	TEST_ASSERT_VAL("bad cpuset", CPU_ISSET_S(2, setsize, cpu_set));
+	CPU_FREE(cpu_set);
+
+	return TEST_OK;
+}
+
 static struct test_case tests__cpu_map[] = {
 	TEST_CASE("Synthesize cpu map", cpu_map_synthesize),
 	TEST_CASE("Print cpu map", cpu_map_print),
 	TEST_CASE("Merge cpu map", cpu_map_merge),
 	TEST_CASE("Intersect cpu map", cpu_map_intersect),
 	TEST_CASE("Equal cpu map", cpu_map_equal),
+	TEST_CASE("Convert cpu map", cpu_map_convert),
 	{	.name = NULL, }
 };
 
-- 
2.25.1

