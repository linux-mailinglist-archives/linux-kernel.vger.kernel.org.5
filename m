Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7737AE48F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjIZEaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjIZEaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:30:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E636E6;
        Mon, 25 Sep 2023 21:29:59 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rvmrt5LXWzNmsQ;
        Tue, 26 Sep 2023 12:26:06 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd200002.china.huawei.com (7.221.188.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 26 Sep 2023 12:29:54 +0800
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
Subject: [PATCH v5 0/5] perf: Add new option '--workload-config' to set workload sched_policy/prio/cpumask
Date:   Tue, 26 Sep 2023 12:29:33 +0800
Message-ID: <20230926042938.509234-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
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

[I still think this is a handy option, so do some improvment and resend it.]

To get consistent benchmarking results, sometimes we need to set the
sched_policy/priority/cpumask of the workload to reduce system noise.

For example, CPU binding is required on big.little system.

  $ perf stat -- taskset -c 0 ls

However, the events of 'taskset' itself are also counted here. To get more
accurate result, this should be avoided.

To get away of the middleman, this adds a new option '--workload-config' to
do the same jobs for stat and record commands.

  --workload-config <[sched_policy=policy][,sched_prio=priority][,cpu-list=list]>
        setup target workload (the <command>) attributes:

                sched_policy: other|fifo|rr|batch|idle
                sched_prio: scheduling priority for fifo|rr, nice value for other
                cpu-list: CPU affinity. e.g. 1-3:5 is processors #1, #2, #3 and #5

For example,

  $ sudo perf stat --workload-config sched_policy=fifo,sched_prio=40,cpu-list=0-3:7 -- ls

Above command will make 'ls' run on CPU #0-#3 and #7 with fifo scheduler and
realtime priority is 40.

v5:
  o rename '--workload-attr' as '--workload-config' (sounds better) .
  o transform to key-value pair style option.

v4:
  - add a test case for perf-stat. (suggeted by Ian Rogers)
  - fix warning found by 0-DAY.
v3:
  - replace taskset with --workload-attr option in documents and tests.
v2:
  - Use cpu list spec instead of cpu mask number.
  - Update documents.

Changbin Du (5):
  perf cpumap: Add __perf_cpu_map__new and perf_cpu_map__2_cpuset
  perf: util: support string type option for perf_parse_sublevel_options
  perf: add new option '--workload-config' to set workload
    sched_policy/prio/cpumask
  perf: replace taskset with --workload-config option
  perf test: add test case for --workload-config option

 tools/lib/perf/cpumap.c                       |  45 +++++++-
 tools/lib/perf/include/perf/cpumap.h          |   4 +
 tools/lib/perf/libperf.map                    |   2 +
 tools/perf/Documentation/intel-hybrid.txt     |   2 +-
 tools/perf/Documentation/perf-record.txt      |   7 ++
 tools/perf/Documentation/perf-stat.txt        |   8 +-
 tools/perf/builtin-record.c                   |  27 +++++
 tools/perf/builtin-stat.c                     |  19 +++
 tools/perf/tests/cpumap.c                     |  23 ++++
 tools/perf/tests/shell/stat.sh                |  19 +++
 .../tests/shell/stat_bpf_counters_cgrp.sh     |   2 +-
 tools/perf/tests/shell/test_arm_coresight.sh  |   2 +-
 tools/perf/tests/shell/test_data_symbol.sh    |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
 tools/perf/util/evlist.c                      | 108 ++++++++++++++++++
 tools/perf/util/evlist.h                      |   3 +
 tools/perf/util/parse-sublevel-options.c      |  12 +-
 tools/perf/util/parse-sublevel-options.h      |   7 ++
 tools/perf/util/target.h                      |   9 ++
 19 files changed, 291 insertions(+), 12 deletions(-)

-- 
2.25.1

