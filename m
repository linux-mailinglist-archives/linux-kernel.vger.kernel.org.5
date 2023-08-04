Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702AF76F786
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjHDCKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHDCKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:10:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78E448F;
        Thu,  3 Aug 2023 19:10:20 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RH8Jc0kMczVjn8;
        Fri,  4 Aug 2023 10:08:32 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:10:18 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v5 5/7] perf test: Update base-record & system-wide-dummy attr expected values for test-record-C0
Date:   Fri, 4 Aug 2023 02:07:39 +0000
Message-ID: <20230804020741.99806-6-yangjihong1@huawei.com>
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

1. Because a dummy sideband event is added to the sampling of specified
   CPUs. When evlist contains evsel of different sample_type,
   evlist__config() will change the default PERF_SAMPLE_ID bit to
   PERF_SAMPLE_IDENTIFICATION bit.
   The attr sample_type expected value of base-record and system-wide-dummy
   in test-record-C0 needs to be updated.

2. The perf record uses evlist__add_aux_dummy() instead of
   evlist__add_dummy() to add a dummy event.
   The expected value of system-wide-dummy attr needs to be updated.

The perf test result is as follows:

  # ./perf test list  2>&1 | grep 'Setup struct perf_event_attr'
   17: Setup struct perf_event_attr
  # ./perf test 17
   17: Setup struct perf_event_attr                                    : Ok

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/tests/attr/system-wide-dummy | 14 ++++++++------
 tools/perf/tests/attr/test-record-C0    |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index 2f3e3eb728eb..a1e1d6a263bf 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -9,8 +9,10 @@ flags=8
 type=1
 size=136
 config=9
-sample_period=4000
-sample_type=455
+sample_period=1
+# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
+# PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER
+sample_type=65671
 read_format=4|20
 # Event will be enabled right away.
 disabled=0
@@ -18,12 +20,12 @@ inherit=1
 pinned=0
 exclusive=0
 exclude_user=0
-exclude_kernel=0
-exclude_hv=0
+exclude_kernel=1
+exclude_hv=1
 exclude_idle=0
 mmap=1
 comm=1
-freq=1
+freq=0
 inherit_stat=0
 enable_on_exec=0
 task=1
@@ -32,7 +34,7 @@ precise_ip=0
 mmap_data=0
 sample_id_all=1
 exclude_host=0
-exclude_guest=0
+exclude_guest=1
 exclude_callchain_kernel=0
 exclude_callchain_user=0
 mmap2=1
diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
index 317730b906dd..198e8429a1bf 100644
--- a/tools/perf/tests/attr/test-record-C0
+++ b/tools/perf/tests/attr/test-record-C0
@@ -10,9 +10,9 @@ cpu=0
 enable_on_exec=0
 
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
-# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
+# PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER
 # + PERF_SAMPLE_CPU added by -C 0
-sample_type=455
+sample_type=65927
 
 # Dummy event handles mmaps, comm and task.
 mmap=0
-- 
2.30.GIT

