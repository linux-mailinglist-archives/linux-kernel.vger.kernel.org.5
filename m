Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A515764E04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjG0Irj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjG0IrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:47:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EAE9A9F;
        Thu, 27 Jul 2023 01:29:44 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBP404xWWztRdS;
        Thu, 27 Jul 2023 16:26:08 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 16:29:22 +0800
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
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v4 4/4] perf test: add test case for --workload-attr option
Date:   Thu, 27 Jul 2023 16:28:52 +0800
Message-ID: <20230727082852.916093-5-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727082852.916093-1-changbin.du@huawei.com>
References: <20230727082852.916093-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 3f1e67795490..b2279f118a97 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -16,6 +16,24 @@ test_default_stat() {
   echo "Basic stat command test [Success]"
 }
 
+test_stat_workload_attr() {
+  echo "stat with --workload-attr test"
+  if ! perf stat --workload-attr other,10,1 -- bash -c 'taskset -pc $$' 2>&1 | grep -E -q "current affinity list: 1"
+  then
+    echo "stat with --workload-attr test [Failed]"
+    err=1
+    return
+  fi
+
+  if ! perf stat --workload-attr other,10,1 -- bash -c 'ps -o pid,cls,ni,cmd -p $$' 2>&1 | grep -E -q "TS\s+10"
+  then
+    echo "stat with --workload-attr test [Failed]"
+    err=1
+    return
+  fi
+  echo "stat with --workload-attr test [Success]"
+}
+
 test_stat_record_report() {
   echo "stat record and report test"
   if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
@@ -147,6 +165,7 @@ test_cputype() {
 }
 
 test_default_stat
+test_stat_workload_attr
 test_stat_record_report
 test_stat_record_script
 test_stat_repeat_weak_groups
-- 
2.25.1

