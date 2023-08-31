Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1F78F014
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbjHaPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjHaPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:18:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AE2EE55;
        Thu, 31 Aug 2023 08:18:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0CDC15;
        Thu, 31 Aug 2023 08:18:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 77AC53F64C;
        Thu, 31 Aug 2023 08:17:56 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/7] perf test: Add a test for strcmp_cpuid_str() expression
Date:   Thu, 31 Aug 2023 16:16:15 +0100
Message-Id: <20230831151632.124985-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831151632.124985-1-james.clark@arm.com>
References: <20230831151632.124985-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test that the new expression builtin returns a match when the current
escaped CPU ID is given, and that it doesn't match when "0x0" is given.

The CPU ID in test__expr() has to be changed to perf_pmu__getcpuid()
which returns the CPU ID string, rather than the raw CPU ID that
get_cpuid() returns because that can't be used with strcmp_cpuid_str().
It doesn't affect the is_intel test because both versions contain
"Intel".

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/expr.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 39be7f3b3a53..78544092ef0c 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -9,6 +9,7 @@
 #include <math.h>
 #include <stdlib.h>
 #include <string.h>
+#include <string2.h>
 #include <linux/zalloc.h>
 
 static int test_ids_union(void)
@@ -74,10 +75,13 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	int ret;
 	struct expr_parse_ctx *ctx;
 	bool is_intel = false;
-	char buf[128];
+	char strcmp_cpuid_buf[256];
+	struct perf_pmu *pmu = pmu__find_core_pmu();
+	char *cpuid = perf_pmu__getcpuid(pmu);
+	char *escaped_cpuid1, *escaped_cpuid2;
 
-	if (!get_cpuid(buf, sizeof(buf)))
-		is_intel = strstr(buf, "Intel") != NULL;
+	TEST_ASSERT_VAL("get_cpuid", cpuid);
+	is_intel = strstr(cpuid, "Intel") != NULL;
 
 	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
 
@@ -257,9 +261,28 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) == 1);
 	TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
 
+
+	/* Test no cpuid match */
+	ret = test(ctx, "strcmp_cpuid_str(0x0)", 0);
+
+	/*
+	 * Test cpuid match with current cpuid. Special chars have to be
+	 * escaped.
+	 */
+	escaped_cpuid1 = strreplace_chars('-', cpuid, "\\-");
+	free(cpuid);
+	escaped_cpuid2 = strreplace_chars(',', escaped_cpuid1, "\\,");
+	free(escaped_cpuid1);
+	escaped_cpuid1 = strreplace_chars('=', escaped_cpuid2, "\\=");
+	free(escaped_cpuid2);
+	scnprintf(strcmp_cpuid_buf, sizeof(strcmp_cpuid_buf),
+		  "strcmp_cpuid_str(%s)", escaped_cpuid1);
+	free(escaped_cpuid1);
+	ret |= test(ctx, strcmp_cpuid_buf, 1);
+
 	/* has_event returns 1 when an event exists. */
 	expr__add_id_val(ctx, strdup("cycles"), 2);
-	ret = test(ctx, "has_event(cycles)", 1);
+	ret |= test(ctx, "has_event(cycles)", 1);
 
 	expr__ctx_free(ctx);
 
-- 
2.34.1

