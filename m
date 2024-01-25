Return-Path: <linux-kernel+bounces-38310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4216D83BDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAA92944F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115F1CA90;
	Thu, 25 Jan 2024 09:42:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F02231E;
	Thu, 25 Jan 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175742; cv=none; b=irfTGIaSuOJmRJ38ULQKyn6YfI7BM/IpDnpZskCfcHDalVwG8X3P6cZb8xLwvO6AbHLG6g3ivLENvSVyBG/Sbcn2qJi7O+8IfT7wykZPv/WcV+UOfSiVBNmgZaqtMuHQAVRgrU3q3Qt/nxY/I8rchmVVitj46cxEHlbNCkiTrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175742; c=relaxed/simple;
	bh=iha9lIT8tWEBCDldgD5w17x1FYFzupge+jOEAX12YzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzg1czI4UDXSLaGKo7MNxMsFe4lYvhjX9NEP/8Kgupq3BNC+d2CPbSTQyH0P4TVP9X2QCw2+PvyCSovtEzipAOYCHpXOw7xN0dgbrFE93gvtsJ8pihI3u1C2kNSCuThVM5SVhu3/akeqAxVuIwLbpicuof8gG24uvePEulGBB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA221595;
	Thu, 25 Jan 2024 01:43:04 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B06053F73F;
	Thu, 25 Jan 2024 01:42:14 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	German Gomez <german.gomez@arm.com>
Subject: [PATCH V16 8/8] perf: test: Extend branch stack sampling test for Arm64 BRBE
Date: Thu, 25 Jan 2024 15:11:19 +0530
Message-Id: <20240125094119.2542332-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125094119.2542332-1-anshuman.khandual@arm.com>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

Add Arm64 BRBE-specific testing to the existing branch stack sampling test.
The test currently passes on the Arm FVP RevC model, but no hardware has
been tested yet.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Co-developed-by: German Gomez <german.gomez@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/perf/tests/builtin-test.c        |  1 +
 tools/perf/tests/shell/test_brstack.sh | 42 ++++++++++++++++++++++++--
 tools/perf/tests/tests.h               |  1 +
 tools/perf/tests/workloads/Build       |  2 ++
 tools/perf/tests/workloads/traploop.c  | 39 ++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/tests/workloads/traploop.c

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4a5973f9bb9b..bd7202ff5cca 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -139,6 +139,7 @@ static struct test_workload *workloads[] = {
 	&workload__sqrtloop,
 	&workload__brstack,
 	&workload__datasym,
+	&workload__traploop
 };
 
 static int num_subtests(const struct test_suite *t)
diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 928790f35747..6a4069c930e8 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -53,12 +53,43 @@ test_user_branches() {
 	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"	$TMPDIR/perf.script
 	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"	$TMPDIR/perf.script
 	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"		$TMPDIR/perf.script
+
+	if is_arm64; then
+		# in arm64 with BRBE, we get IRQ entries that correspond
+		# to any point in the process
+		grep -m1 "/IRQ/"					$TMPDIR/perf.script
+	fi
 	set +x
 
 	# some branch types are still not being tested:
 	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
 }
 
+test_arm64_trap_eret_branches() {
+	echo "Testing trap & eret branches (arm64 brbe)"
+	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- \
+		perf test -w traploop 250
+	perf script -i $TMPDIR/perf.data --fields brstacksym | tr ' ' '\n' > $TMPDIR/perf.script
+	set -x
+	# BRBINF<n>.TYPE == TRAP are mapped to PERF_BR_SYSCALL by the BRBE driver
+	grep -E -m1 "^trap_bench\+[^ ]*/\[unknown\][^ ]*/SYSCALL/" $TMPDIR/perf.script
+	grep -E -m1 "^\[unknown\][^ ]*/trap_bench\+[^ ]*/ERET/"	$TMPDIR/perf.script
+	set +x
+}
+
+test_arm64_kernel_branches() {
+	echo "Testing kernel branches (arm64 brbe)"
+	# skip if perf doesn't have enough privileges
+	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
+		echo "[skipped: not enough privileges]"
+		return 0
+	fi
+	perf record -o $TMPDIR/perf.data --branch-filter any,k -- uname -a
+	perf script -i $TMPDIR/perf.data --fields brstack | tr ' ' '\n' > $TMPDIR/perf.script
+	grep -E -m1 "0xffff[0-9a-f]{12}" $TMPDIR/perf.script
+	! egrep -E -m1 "0x0000[0-9a-f]{12}" $TMPDIR/perf.script
+}
+
 # first argument <arg0> is the argument passed to "--branch-stack <arg0>,save_type,u"
 # second argument are the expected branch types for the given filter
 test_filter() {
@@ -81,11 +112,16 @@ set -e
 
 test_user_branches
 
-test_filter "any_call"	"CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
+if is_arm64; then
+	test_arm64_trap_eret_branches
+	test_arm64_kernel_branches
+fi
+
+test_filter "any_call"	"CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|FAULT_DATA|FAULT_INST"
 test_filter "call"	"CALL|SYSCALL"
 test_filter "cond"	"COND"
 test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
 
 test_filter "call,cond"		"CALL|SYSCALL|COND"
-test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
-test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
+test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND|FAULT_DATA|FAULT_INST"
+test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET|FAULT_DATA|FAULT_INST"
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index dad3d7414142..6d3d575352d5 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
 DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
+DECLARE_WORKLOAD(traploop);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index a1f34d5861e3..a9dc93d8468b 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -6,8 +6,10 @@ perf-y += leafloop.o
 perf-y += sqrtloop.o
 perf-y += brstack.o
 perf-y += datasym.o
+perf-y += traploop.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
 CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/traploop.c b/tools/perf/tests/workloads/traploop.c
new file mode 100644
index 000000000000..7dac94897e49
--- /dev/null
+++ b/tools/perf/tests/workloads/traploop.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include "../tests.h"
+
+#define BENCH_RUNS 999999
+
+static volatile int cnt;
+
+#ifdef __aarch64__
+static void trap_bench(void)
+{
+	unsigned long val;
+
+	asm("mrs %0, ID_AA64ISAR0_EL1" : "=r" (val));   /* TRAP + ERET */
+}
+#else
+static void trap_bench(void)
+{
+
+}
+#endif
+
+static int traploop(int argc, const char **argv)
+{
+	int num_loops = BENCH_RUNS;
+
+	if (argc > 0)
+		num_loops = atoi(argv[0]);
+
+	while (1) {
+		if ((cnt++) > num_loops)
+			break;
+
+		trap_bench();
+	}
+	return 0;
+}
+
+DEFINE_WORKLOAD(traploop);
-- 
2.25.1


