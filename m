Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E078F012
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjHaPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345302AbjHaPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:17:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4379E50;
        Thu, 31 Aug 2023 08:17:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFB33C15;
        Thu, 31 Aug 2023 08:18:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09F5C3F64C;
        Thu, 31 Aug 2023 08:17:38 -0700 (PDT)
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
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/7] perf util: Add a function for replacing characters in a string
Date:   Thu, 31 Aug 2023 16:16:14 +0100
Message-Id: <20230831151632.124985-4-james.clark@arm.com>
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

It finds all occurrences of a single character and replaces them with
a multi character string. This will be used in a test in a following
commit.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  1 +
 tools/perf/tests/tests.h        |  1 +
 tools/perf/tests/util.c         | 30 +++++++++++++++++++++
 tools/perf/util/string.c        | 48 +++++++++++++++++++++++++++++++++
 tools/perf/util/string2.h       |  1 +
 6 files changed, 82 insertions(+)
 create mode 100644 tools/perf/tests/util.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 63d5e6d5f165..2b45ffa462a6 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -66,6 +66,7 @@ perf-y += dlfilter-test.o
 perf-y += sigtrap.o
 perf-y += event_groups.o
 perf-y += symbols.o
+perf-y += util.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0ad18cf6dd22..cb6f1dd00dc4 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -123,6 +123,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__sigtrap,
 	&suite__event_groups,
 	&suite__symbols,
+	&suite__util,
 	NULL,
 };
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f33cfc3c19a4..b394f3ac2d66 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -145,6 +145,7 @@ DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
+DECLARE_SUITE(util);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
diff --git a/tools/perf/tests/util.c b/tools/perf/tests/util.c
new file mode 100644
index 000000000000..43e66a620b83
--- /dev/null
+++ b/tools/perf/tests/util.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include "util/debug.h"
+
+#include <linux/compiler.h>
+#include <stdlib.h>
+#include <string2.h>
+
+static int test_strreplace(char find, const char *s, const char *replace, const char *expected)
+{
+	char *new = strreplace_chars(find, s, replace);
+	int ret = strcmp(new, expected);
+
+	free(new);
+	return ret == 0;
+}
+
+static int test__util(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("empty string", test_strreplace(' ', "", "123", ""));
+	TEST_ASSERT_VAL("no match", test_strreplace('5', "123", "4", "123"));
+	TEST_ASSERT_VAL("replace 1", test_strreplace('3', "123", "4", "124"));
+	TEST_ASSERT_VAL("replace 2", test_strreplace('a', "abcabc", "ef", "efbcefbc"));
+	TEST_ASSERT_VAL("replace long", test_strreplace('a', "abcabc", "longlong",
+							"longlongbclonglongbc"));
+
+	return 0;
+}
+
+DEFINE_SUITE("util", util);
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index cf05b0b56c57..6410a683183e 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -301,3 +301,51 @@ unsigned int hex(char c)
 		return c - 'a' + 10;
 	return c - 'A' + 10;
 }
+
+
+/*
+ * Replace all occurrences of character 'find' in string s with string 'replace'
+ *
+ * The new string could be longer so a new string is returned which must
+ * be freed.
+ */
+char *strreplace_chars(char find, const char *s, const char *replace)
+{
+	int replace_len = strlen(replace);
+	char *new_s, *to;
+	const char *loc = strchr(s, find);
+	const char *from = s;
+	int num = 0;
+
+	/* Count occurrences */
+	while (loc) {
+		loc = strchr(loc + 1, find);
+		num++;
+	}
+
+	/* Allocate enough space for replacements and reset first location */
+	new_s = malloc(strlen(s) + (num * (replace_len - 1) + 1));
+	if (!new_s)
+		return NULL;
+	loc = strchr(s, find);
+	to = new_s;
+
+	while (loc) {
+		/* Copy original string up to found char and update positions */
+		memcpy(to, from, 1 + loc - from);
+		to += loc - from;
+		from = loc + 1;
+
+		/* Copy replacement string and update positions */
+		memcpy(to, replace, replace_len);
+		to += replace_len;
+
+		/* Find next occurrence or end of string */
+		loc = strchr(from, find);
+	}
+
+	/* Copy any remaining chars + null */
+	strcpy(to, from);
+
+	return new_s;
+}
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 56c30fef9682..920488099214 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -39,5 +39,6 @@ char *strpbrk_esc(char *str, const char *stopset);
 char *strdup_esc(const char *str);
 
 unsigned int hex(char c);
+char *strreplace_chars(char find, const char *s, const char *replace);
 
 #endif /* PERF_STRING_H */
-- 
2.34.1

