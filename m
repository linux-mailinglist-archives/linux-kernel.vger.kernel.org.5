Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28967AE491
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjIZEac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjIZEaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:30:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CD2F3;
        Mon, 25 Sep 2023 21:30:03 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rvms01H0QzNnp8;
        Tue, 26 Sep 2023 12:26:12 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd200002.china.huawei.com (7.221.188.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 26 Sep 2023 12:30:00 +0800
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
Subject: [PATCH v5 5/5] perf test: add test case for --workload-config option
Date:   Tue, 26 Sep 2023 12:29:38 +0800
Message-ID: <20230926042938.509234-6-changbin.du@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the sched attributes are applied to workload.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/tests/shell/stat.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 3f1e67795490..7b320a25505a 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -16,6 +16,24 @@ test_default_stat() {
   echo "Basic stat command test [Success]"
 }
 
+test_stat_workload_config() {
+  echo "stat with --workload-config test"
+  if ! perf stat --workload-config cpu-list=1 -- bash -c 'taskset -pc $$' 2>&1 | grep -E -q "current affinity list: 1"
+  then
+    echo "stat with --workload-config test [Failed]"
+    err=1
+    return
+  fi
+
+  if ! perf stat --workload-config sched_policy=other,sched_prio=10 -- bash -c 'ps -o pid,cls,ni,cmd -p $$' 2>&1 | grep -E -q "TS\s+10"
+  then
+    echo "stat with --workload-config test [Failed]"
+    err=1
+    return
+  fi
+  echo "stat with --workload-config test [Success]"
+}
+
 test_stat_record_report() {
   echo "stat record and report test"
   if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
@@ -147,6 +165,7 @@ test_cputype() {
 }
 
 test_default_stat
+test_stat_workload_config
 test_stat_record_report
 test_stat_record_script
 test_stat_repeat_weak_groups
-- 
2.25.1

