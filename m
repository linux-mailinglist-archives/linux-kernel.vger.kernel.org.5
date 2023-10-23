Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB067D2920
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjJWDdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjJWDdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:33:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01119E9;
        Sun, 22 Oct 2023 20:33:43 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SDLKH69mLzNp1s;
        Mon, 23 Oct 2023 11:29:39 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 11:33:41 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf evsel: Rename evsel__increase_rlimit to rlimit__increase_nofile
Date:   Mon, 23 Oct 2023 03:31:44 +0000
Message-ID: <20231023033144.1011896-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evsel__increase_rlimit() helper does nothing with evsel, and description
of the functionality is inaccurate, rename it and move to util/rlimit.c.

By the way, fix a checkppatch warning about misplaced license tag:

  WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
  #160: FILE: tools/perf/util/rlimit.h:3:
  /* SPDX-License-Identifier: LGPL-2.1 */

No functional change.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/data.c   |  4 ++--
 tools/perf/util/evsel.c  | 30 ++----------------------------
 tools/perf/util/evsel.h  |  3 ---
 tools/perf/util/rlimit.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/rlimit.h | 11 ++++++++++-
 5 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 098f9e3bb2e7..c29d8a382b19 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -17,7 +17,7 @@
 #include "util.h" // rm_rf_perf_data()
 #include "debug.h"
 #include "header.h"
-#include "evsel.h"
+#include "rlimit.h"
 #include <internal/lib.h>
 
 static void close_dir(struct perf_data_file *files, int nr)
@@ -64,7 +64,7 @@ int perf_data__create_dir(struct perf_data *data, int nr)
 			 * perf record needs at least 6 fds per CPU.
 			 * When we run out of them try to increase the limits.
 			 */
-			if (errno == EMFILE && evsel__increase_rlimit(&set_rlimit))
+			if (errno == EMFILE && rlimit__increase_nofile(&set_rlimit))
 				goto retry_open;
 
 			ret = -errno;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d5363d23f5d3..72a5dfc38d38 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -49,6 +49,7 @@
 #include "off_cpu.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "rlimit.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include "util/bpf-filter.h"
@@ -1989,33 +1990,6 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	}
 }
 
-bool evsel__increase_rlimit(enum rlimit_action *set_rlimit)
-{
-	int old_errno;
-	struct rlimit l;
-
-	if (*set_rlimit < INCREASED_MAX) {
-		old_errno = errno;
-
-		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
-			if (*set_rlimit == NO_CHANGE) {
-				l.rlim_cur = l.rlim_max;
-			} else {
-				l.rlim_cur = l.rlim_max + 1000;
-				l.rlim_max = l.rlim_cur;
-			}
-			if (setrlimit(RLIMIT_NOFILE, &l) == 0) {
-				(*set_rlimit) += 1;
-				errno = old_errno;
-				return true;
-			}
-		}
-		errno = old_errno;
-	}
-
-	return false;
-}
-
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu_map_idx, int end_cpu_map_idx)
@@ -2143,7 +2117,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * perf stat needs between 5 and 22 fds per CPU. When we run out
 	 * of them try to increase the limits.
 	 */
-	if (err == -EMFILE && evsel__increase_rlimit(&set_rlimit))
+	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
 	if (err != -EINVAL || idx > 0 || thread > 0)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 815be2491938..d791316a1792 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -330,9 +330,6 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
 bool evsel__detect_missing_features(struct evsel *evsel);
 
-enum rlimit_action { NO_CHANGE, SET_TO_MAX, INCREASED_MAX };
-bool evsel__increase_rlimit(enum rlimit_action *set_rlimit);
-
 bool evsel__precise_ip_fallback(struct evsel *evsel);
 
 struct perf_sample;
diff --git a/tools/perf/util/rlimit.c b/tools/perf/util/rlimit.c
index 13521d392a22..f857405fe1aa 100644
--- a/tools/perf/util/rlimit.c
+++ b/tools/perf/util/rlimit.c
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: LGPL-2.1 */
 
+#include <errno.h>
 #include "util/debug.h"
 #include "util/rlimit.h"
 #include <sys/time.h>
@@ -27,3 +28,30 @@ void rlimit__bump_memlock(void)
 		}
 	}
 }
+
+bool rlimit__increase_nofile(enum rlimit_action *set_rlimit)
+{
+	int old_errno;
+	struct rlimit l;
+
+	if (*set_rlimit < INCREASED_MAX) {
+		old_errno = errno;
+
+		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
+			if (*set_rlimit == NO_CHANGE) {
+				l.rlim_cur = l.rlim_max;
+			} else {
+				l.rlim_cur = l.rlim_max + 1000;
+				l.rlim_max = l.rlim_cur;
+			}
+			if (setrlimit(RLIMIT_NOFILE, &l) == 0) {
+				(*set_rlimit) += 1;
+				errno = old_errno;
+				return true;
+			}
+		}
+		errno = old_errno;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/rlimit.h b/tools/perf/util/rlimit.h
index 9f59d8e710a3..19050d7fb9d7 100644
--- a/tools/perf/util/rlimit.h
+++ b/tools/perf/util/rlimit.h
@@ -1,6 +1,15 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
 #ifndef __PERF_RLIMIT_H_
 #define __PERF_RLIMIT_H_
-/* SPDX-License-Identifier: LGPL-2.1 */
+
+enum rlimit_action {
+	NO_CHANGE,
+	SET_TO_MAX,
+	INCREASED_MAX
+};
 
 void rlimit__bump_memlock(void);
+
+bool rlimit__increase_nofile(enum rlimit_action *set_rlimit);
+
 #endif // __PERF_RLIMIT_H_
-- 
2.34.1

