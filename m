Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5C78213A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjHUBat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjHUBai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:30:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4CAF;
        Sun, 20 Aug 2023 18:30:32 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTZZd1t1yztS6p;
        Mon, 21 Aug 2023 09:26:49 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 09:30:30 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v6 6/7] perf test: Add test case for record sideband events
Date:   Mon, 21 Aug 2023 01:27:33 +0000
Message-ID: <20230821012734.18241-7-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230821012734.18241-1-yangjihong1@huawei.com>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new test case to record sideband events for all CPUs when tracing
selected CPUs

Test result:

  # ./perf test list 2>&1 | grep 'perf record sideband tests'
   95: perf record sideband tests
  # ./perf test 95
   95: perf record sideband tests                                      : Ok

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/record_sideband.sh | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_sideband.sh

diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
new file mode 100755
index 000000000000..2ecf00011cb1
--- /dev/null
+++ b/tools/perf/tests/shell/record_sideband.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# perf record sideband tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+can_cpu_wide()
+{
+    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true 2>&1 >/dev/null
+    then
+        echo "record sideband test [Skipped cannot record cpu$1]"
+        err=2
+    fi
+
+    rm -f ${perfdata}
+    return $err
+}
+
+test_system_wide_tracking()
+{
+    # Need CPU 0 and CPU 1
+    can_cpu_wide 0 || return 0
+    can_cpu_wide 1 || return 0
+
+    # Record on CPU 0 a task running on CPU 1
+    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
+
+    # Should get MMAP events from CPU 1
+    mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
+
+    rm -f ${perfdata}
+
+    if [ ${mmap_cnt} -gt 0 ] ; then
+        return 0
+    fi
+
+    echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
+    return 1
+}
+
+test_system_wide_tracking
-- 
2.30.GIT

