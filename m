Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39B4764E02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjG0Irb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjG0IrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:47:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1747449C3;
        Thu, 27 Jul 2023 01:29:42 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBP6c4NHLzrS0H;
        Thu, 27 Jul 2023 16:28:24 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 16:29:18 +0800
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
Subject: [PATCH v4 0/4] perf: add new option '--workload-attr' to set workload sched_policy/priority/cpumask
Date:   Thu, 27 Jul 2023 16:28:48 +0800
Message-ID: <20230727082852.916093-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
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

This adds a new option '--workload-attr' to set the sched_policy/priority/cpumask
of the workload to reduce system noise.

$ sudo perf stat --workload-attr fifo,40,0-3:7 -- ls

Please see patch 2/4 for more details.

v4:
  - add a test case for perf-stat. (suggeted by Ian Rogers)
  - fix warning found by 0-DAY.
v3:
  - replace taskset with --workload-attr option in documents and tests.
v2:
  - Use cpu list spec instead of cpu mask number.
  - Update documents.

Changbin Du (4):
  perf cpumap: Add __perf_cpu_map__new and perf_cpu_map__2_cpuset
  perf: add new option '--workload-attr' to set workload
    sched_policy/priority/cpumask
  perf: replace taskset with --workload-attr option
  perf test: add test case for --workload-attr option

 tools/lib/perf/cpumap.c                       |  45 ++++++-
 tools/lib/perf/include/perf/cpumap.h          |   4 +
 tools/lib/perf/libperf.map                    |   2 +
 tools/perf/Documentation/intel-hybrid.txt     |   2 +-
 tools/perf/Documentation/perf-record.txt      |   7 ++
 tools/perf/Documentation/perf-stat.txt        |   8 +-
 tools/perf/builtin-record.c                   |  26 ++++
 tools/perf/builtin-stat.c                     |  18 +++
 tools/perf/tests/cpumap.c                     |  23 ++++
 tools/perf/tests/shell/stat.sh                |  19 +++
 .../tests/shell/stat_bpf_counters_cgrp.sh     |   2 +-
 tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
 tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
 tools/perf/util/evlist.c                      | 116 ++++++++++++++++++
 tools/perf/util/evlist.h                      |   3 +
 tools/perf/util/target.h                      |   9 ++
 17 files changed, 281 insertions(+), 9 deletions(-)

-- 
2.25.1

