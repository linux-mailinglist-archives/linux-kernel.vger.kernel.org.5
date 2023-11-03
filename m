Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917927E023F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjKCLfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKCLfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:35:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6303E1A8;
        Fri,  3 Nov 2023 04:35:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA1A52F4;
        Fri,  3 Nov 2023 04:36:00 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A26EA3F67D;
        Fri,  3 Nov 2023 04:35:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] perf test: Add option to change objdump binary
Date:   Fri,  3 Nov 2023 11:34:58 +0000
Message-Id: <20231103113501.490012-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
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

All of the other Perf subcommands that use objdump have an option to
specify the binary, so add the same option to perf test.

This is useful if you have built the kernel with a different toolchain
to the system one, where the system objdump may fail to disassemble
vmlinux.

Now this can be fixed with something like this:

  $ perf test --objdump llvm-objdump "object code reading"

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/builtin-test.c | 3 +++
 tools/perf/tests/code-reading.c | 2 +-
 tools/perf/tests/tests.h        | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cb6f1dd00dc4..a8d17dd50588 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -32,6 +32,7 @@
 
 static bool dont_fork;
 const char *dso_to_test;
+const char *test_objdump_path = "objdump";
 
 /*
  * List of architecture specific tests. Not a weak symbol as the array length is
@@ -529,6 +530,8 @@ int cmd_test(int argc, const char **argv)
 		    "Do not fork for testcase"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
+	OPT_STRING(0, "objdump", &test_objdump_path, "path",
+		   "objdump binary to use for disassembly and annotations"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 3af81012014e..b353358acc3a 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -185,7 +185,7 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
 	int ret;
 
 	fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
-	ret = snprintf(cmd, sizeof(cmd), fmt, "objdump", addr, addr + len,
+	ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, addr + len,
 		       filename);
 	if (ret <= 0 || (size_t)ret >= sizeof(cmd))
 		return -1;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b394f3ac2d66..dad3d7414142 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -207,5 +207,6 @@ DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
 
 extern const char *dso_to_test;
+extern const char *test_objdump_path;
 
 #endif /* TESTS_H */
-- 
2.34.1

