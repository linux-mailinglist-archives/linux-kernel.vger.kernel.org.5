Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E67E2848
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjKFPLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKFPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:11:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 385161B2;
        Mon,  6 Nov 2023 07:11:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C6C0DA7;
        Mon,  6 Nov 2023 07:12:12 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 393BD3F6C4;
        Mon,  6 Nov 2023 07:11:25 -0800 (PST)
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
        Tom Rix <trix@redhat.com>, Yonghong Song <yhs@fb.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 2/2] perf test: Add support for setting objdump binary via perf config
Date:   Mon,  6 Nov 2023 15:10:49 +0000
Message-Id: <20231106151051.129440-3-james.clark@arm.com>
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

Add a perf config variable that does the same thing as "perf test
--objdump <x>".

Also update the man page.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/tests/builtin-test.c          | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 0b4e79dbd3f6..16398babd1ef 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -722,6 +722,10 @@ session-<NAME>.*::
 		Defines new record session for daemon. The value is record's
 		command line without the 'record' keyword.
 
+test.*::
+
+	test.objdump::
+		objdump binary to use for disassembly and annotations.
 
 SEE ALSO
 --------
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a8d17dd50588..113e92119e1d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -14,6 +14,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include "builtin.h"
+#include "config.h"
 #include "hist.h"
 #include "intlist.h"
 #include "tests.h"
@@ -514,6 +515,15 @@ static int run_workload(const char *work, int argc, const char **argv)
 	return -1;
 }
 
+static int perf_test__config(const char *var, const char *value,
+			     void *data __maybe_unused)
+{
+	if (!strcmp(var, "test.objdump"))
+		test_objdump_path = value;
+
+	return 0;
+}
+
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
@@ -541,6 +551,8 @@ int cmd_test(int argc, const char **argv)
         if (ret < 0)
                 return ret;
 
+	perf_config(perf_test__config, NULL);
+
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
 
-- 
2.34.1

