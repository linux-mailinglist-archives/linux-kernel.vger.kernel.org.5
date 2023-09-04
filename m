Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B51791024
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351040AbjIDChB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350938AbjIDCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:36:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0BB10A;
        Sun,  3 Sep 2023 19:36:53 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RfCNQ5RbTztS56;
        Mon,  4 Sep 2023 10:32:54 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 10:36:50 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v8 6/6] perf test: Add perf_event_attr test for record dummy event
Date:   Mon, 4 Sep 2023 02:33:40 +0000
Message-ID: <20230904023340.12707-7-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230904023340.12707-1-yangjihong1@huawei.com>
References: <20230904023340.12707-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If only dummy event is recorded, tracking event is not needed.
Add this test scenario.

Test result:

  # ./perf test list 2>&1 | grep 'Setup struct perf_event_attr'
   17: Setup struct perf_event_attr
  # ./perf test 17 -v
   17: Setup struct perf_event_attr                                    :
  --- start ---
  test child forked, pid 720198
  <SNIP>
  running './tests/attr/test-record-dummy-C0'
  <SNIP>
  test child finished with 0
  ---- end ----
  Setup struct perf_event_attr: Ok

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/tests/attr/test-record-dummy-C0 | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tools/perf/tests/attr/test-record-dummy-C0

diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
new file mode 100644
index 000000000000..83ca4e373acd
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -0,0 +1,55 @@
+[config]
+command = record
+args    = --no-bpf-event -e dummy -C 0 kill >/dev/null 2>&1
+ret     = 1
+
+[event]
+fd=1
+group_fd=-1
+cpu=0
+pid=-1
+flags=8
+type=1
+size=136
+config=9
+sample_period=4000
+# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
+# PERF_SAMPLE_PERIOD
+# + PERF_SAMPLE_CPU added by -C 0
+sample_type=391
+read_format=4
+disabled=0
+inherit=1
+pinned=0
+exclusive=0
+exclude_user=0
+exclude_kernel=0
+exclude_hv=0
+exclude_idle=0
+mmap=1
+comm=1
+freq=1
+inherit_stat=0
+enable_on_exec=0
+task=1
+watermark=0
+precise_ip=0
+mmap_data=0
+sample_id_all=1
+exclude_host=0
+exclude_guest=1
+exclude_callchain_kernel=0
+exclude_callchain_user=0
+mmap2=1
+comm_exec=1
+context_switch=0
+write_backward=0
+namespaces=0
+use_clockid=0
+wakeup_events=0
+bp_type=0
+config1=0
+config2=0
+branch_sample_type=0
+sample_regs_user=0
+sample_stack_user=0
-- 
2.30.GIT

