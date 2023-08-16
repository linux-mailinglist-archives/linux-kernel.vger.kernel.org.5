Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58077E0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbjHPLvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244802AbjHPLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:51:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 378C32121;
        Wed, 16 Aug 2023 04:50:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E6411063;
        Wed, 16 Aug 2023 04:51:38 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.4.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E76C3F64C;
        Wed, 16 Aug 2023 04:50:53 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 2/6] perf test: Add a test for the new Arm CPU ID comparison behavior
Date:   Wed, 16 Aug 2023 12:47:44 +0100
Message-Id: <20230816114841.1679234-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816114841.1679234-1-james.clark@arm.com>
References: <20230816114841.1679234-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that variant and revision fields are taken into account the behavior
is slightly more complicated so add a test to ensure that this behaves
as expected.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/include/arch-tests.h |  3 ++
 tools/perf/arch/arm64/tests/Build          |  1 +
 tools/perf/arch/arm64/tests/arch-tests.c   |  4 +++
 tools/perf/arch/arm64/tests/cpuid-match.c  | 38 ++++++++++++++++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 tools/perf/arch/arm64/tests/cpuid-match.c

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 452b3d904521..474d7cf5afbd 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,6 +2,9 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
+struct test_suite;
+
+int test__cpuid_match(struct test_suite *test, int subtest);
 extern struct test_suite *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index a61c06bdb757..e337c09e7f56 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -2,3 +2,4 @@ perf-y += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
+perf-y += cpuid-match.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index ad16b4f8f63e..74932e72c727 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -3,9 +3,13 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
+
+DEFINE_SUITE("arm64 CPUID matching", cpuid_match);
+
 struct test_suite *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
 #endif
+	&suite__cpuid_match,
 	NULL,
 };
diff --git a/tools/perf/arch/arm64/tests/cpuid-match.c b/tools/perf/arch/arm64/tests/cpuid-match.c
new file mode 100644
index 000000000000..af0871b54ae7
--- /dev/null
+++ b/tools/perf/arch/arm64/tests/cpuid-match.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+
+#include "arch-tests.h"
+#include "tests/tests.h"
+#include "util/header.h"
+
+int test__cpuid_match(struct test_suite *test __maybe_unused,
+			     int subtest __maybe_unused)
+{
+	/* midr with no leading zeros matches */
+	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
+		return -1;
+	/* Upper case matches */
+	if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
+		return -1;
+	/* r0p0 = r0p0 matches */
+	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
+		return -1;
+	/* r0p1 > r0p0 matches */
+	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
+		return -1;
+	/* r1p0 > r0p0 matches*/
+	if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
+		return -1;
+	/* r0p0 < r0p1 doesn't match */
+	if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
+		return -1;
+	/* r0p0 < r1p0 doesn't match */
+	if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
+		return -1;
+	/* Different CPU doesn't match */
+	if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
+		return -1;
+
+	return 0;
+}
+
-- 
2.34.1

