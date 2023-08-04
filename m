Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5AE76F788
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjHDCKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjHDCKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:10:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B34488;
        Thu,  3 Aug 2023 19:10:22 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RH8KR271wzrS4w;
        Fri,  4 Aug 2023 10:09:15 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:10:19 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v5 7/7] perf test: Add perf_event_attr test for record selected CPUs exclude_user
Date:   Fri, 4 Aug 2023 02:07:41 +0000
Message-ID: <20230804020741.99806-8-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230804020741.99806-1-yangjihong1@huawei.com>
References: <20230804020741.99806-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all (non-dummy) evsel have exclude_user, system_wide sideband is not
needed. Add this test scenario.

Test result:

  # ./perf test list 2>&1 | grep 'Setup struct perf_event_attr'
   17: Setup struct perf_event_attr
  # ./perf test 17 -v
   17: Setup struct perf_event_attr                                    :
  --- start ---
  test child forked, pid 720198
  <SNIP>
  running './tests/attr/test-record-C0-all-kernel'
  <SNIP>
  test child finished with 0
  ---- end ----
  Setup struct perf_event_attr: Ok

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 .../perf/tests/attr/test-record-C0-all-kernel | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/perf/tests/attr/test-record-C0-all-kernel

diff --git a/tools/perf/tests/attr/test-record-C0-all-kernel b/tools/perf/tests/attr/test-record-C0-all-kernel
new file mode 100644
index 000000000000..2d7549277c1e
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-C0-all-kernel
@@ -0,0 +1,32 @@
+[config]
+command = record
+args    = --no-bpf-event --all-kernel -C 0 kill >/dev/null 2>&1
+ret     = 1
+
+[event:base-record]
+cpu=0
+
+# no enable on exec for CPU attached
+enable_on_exec=0
+
+# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
+# PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER
+# + PERF_SAMPLE_CPU added by -C 0
+sample_type=65927
+
+# Dummy event handles mmaps, comm and task.
+mmap=0
+comm=0
+task=0
+
+# exclude_user for all-kernel option
+exclude_user=1
+
+[event:system-wide-dummy]
+
+# system_wide is not need for all (non-dummy) events have exclude_user
+cpu=0
+
+# exclude_user for all-kernel option
+exclude_user=1
+exclude_kernel=0
-- 
2.30.GIT

