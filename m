Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F97E2847
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjKFPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:11:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 883ECD8;
        Mon,  6 Nov 2023 07:11:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81D2DC15;
        Mon,  6 Nov 2023 07:12:06 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F23C3F6C4;
        Mon,  6 Nov 2023 07:11:19 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 1/2] perf test: Add option to change objdump binary
Date:   Mon,  6 Nov 2023 15:10:48 +0000
Message-Id: <20231106151051.129440-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106151051.129440-1-james.clark@arm.com>
References: <20231106151051.129440-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Ian Rogers <irogers@google.com>
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

