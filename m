Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A597AE493
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjIZEaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjIZEaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:30:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E144F0;
        Mon, 25 Sep 2023 21:30:02 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RvmrM4cH4ztSwf;
        Tue, 26 Sep 2023 12:25:39 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd200002.china.huawei.com (7.221.188.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 26 Sep 2023 12:29:59 +0800
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
        <changbin.du@gmail.com>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v5 4/5] perf: replace taskset with --workload-config option
Date:   Tue, 26 Sep 2023 12:29:37 +0800
Message-ID: <20230926042938.509234-5-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926042938.509234-1-changbin.du@huawei.com>
References: <20230926042938.509234-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the taskset with our new option --workload-config.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/intel-hybrid.txt        | 2 +-
 tools/perf/Documentation/perf-stat.txt           | 2 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 2 +-
 tools/perf/tests/shell/test_arm_coresight.sh     | 2 +-
 tools/perf/tests/shell/test_data_symbol.sh       | 2 +-
 tools/perf/tests/shell/test_intel_pt.sh          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
index e7a776ad25d7..f2b9d623a656 100644
--- a/tools/perf/Documentation/intel-hybrid.txt
+++ b/tools/perf/Documentation/intel-hybrid.txt
@@ -132,7 +132,7 @@ displayed. The percentage is the event's running time/enabling time.
 One example, 'triad_loop' runs on cpu16 (atom core), while we can see the
 scaled value for core cycles is 160,444,092 and the percentage is 0.47%.
 
-perf stat -e cycles \-- taskset -c 16 ./triad_loop
+perf stat -e cycles --workload-config cpu-list=16 \-- ./triad_loop
 
 As previous, two events are created.
 
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b2038f7e236a..fc22d72560e1 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -464,7 +464,7 @@ on workload with changing phases.
 
 To interpret the results it is usually needed to know on which
 CPUs the workload runs on. If needed the CPUs can be forced using
-taskset.
+--workload-config option.
 
 --td-level::
 Print the top-down statistics that equal the input level. It allows
diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index e75d0780dc78..c8737cb32a63 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -60,7 +60,7 @@ check_system_wide_counted()
 
 check_cpu_list_counted()
 {
-	check_cpu_list_counted_output=$(perf stat -C 0,1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
+	check_cpu_list_counted_output=$(perf stat -C 0,1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, --workload-config cpu-list=1 -- sleep 1  2>&1)
 	if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
 		echo "Some CPU events are not counted"
 		if [ "${verbose}" = "1" ]; then
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index f1bf5621160f..e5be16fa7171 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -38,7 +38,7 @@ record_touch_file() {
 	echo "Recording trace (only user mode) with path: CPU$2 => $1"
 	rm -f $file
 	perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
-		-- taskset -c $2 touch $file > /dev/null 2>&1
+		--workload-attr cpu-list=$2 -- touch $file > /dev/null 2>&1
 }
 
 perf_script_branch_samples() {
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index 69bb6fe86c50..d2b58c78a18b 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -50,7 +50,7 @@ echo "Recording workload..."
 # specific CPU and test in per-CPU mode.
 is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
 if (($is_amd >= 1)); then
-	perf mem record -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM &
+	perf mem record -o ${PERF_DATA} -C 0 --workload-config cpu-list=0 -- $TEST_PROGRAM &
 else
 	perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
 fi
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 3a8b9bffa022..46f53aece135 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -110,7 +110,7 @@ test_system_wide_side_band()
 	can_cpu_wide 1 || return $?
 
 	# Record on CPU 0 a task running on CPU 1
-	perf_record_no_decode -o "${perfdatafile}" -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt//u -C 0 --workload-config cpu-list=1 -- uname
 
 	# Should get MMAP events from CPU 1 because they can be needed to decode
 	mmap_cnt=$(perf script -i "${perfdatafile}" --no-itrace --show-mmap-events -C 1 2>/dev/null | grep -c MMAP)
-- 
2.25.1

