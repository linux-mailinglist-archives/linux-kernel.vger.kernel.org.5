Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F475DB65
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGVJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGVJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:34:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38F430EF;
        Sat, 22 Jul 2023 02:34:46 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R7LpW34g8zrRjF;
        Sat, 22 Jul 2023 17:33:55 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 22 Jul 2023 17:34:43 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v3 4/7] perf record: Track sideband events for all CPUs when tracing selected CPUs
Date:   Sat, 22 Jul 2023 09:32:16 +0000
Message-ID: <20230722093219.174898-5-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230722093219.174898-1-yangjihong1@huawei.com>
References: <20230722093219.174898-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space tasks can migrate between CPUs, we need to track side-band
events for all CPUs.

The specific scenarios are as follows:

         CPU0                                 CPU1
  perf record -C 0 start
                              taskA starts to be created and executed
                                -> PERF_RECORD_COMM and PERF_RECORD_MMAP
                                   events only deliver to CPU1
                              ......
                                |
                          migrate to CPU0
                                |
  Running on CPU0    <----------/
  ...

  perf record -C 0 stop

Now perf samples the PC of taskA. However, perf does not record the
PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
Therefore, the comm and symbols of taskA cannot be parsed.

The solution is to record sideband events for all CPUs when tracing
selected CPUs. Because this modifies the default behavior, add related
comments to the perf record man page.

The sys_perf_event_open invoked is as follows:

  # perf --debug verbose=3 record -e cpu-clock -C 1 true
  <SNIP>
  Opening: cpu-clock
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0 (PERF_COUNT_SW_CPU_CLOCK)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
  Opening: dummy:u
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0x9 (PERF_COUNT_SW_DUMMY)
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|IDENTIFIER
    read_format                      ID|LOST
    inherit                          1
    exclude_kernel                   1
    exclude_hv                       1
    mmap                             1
    comm                             1
    task                             1
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
  sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Documentation/perf-record.txt |  3 +++
 tools/perf/builtin-record.c              | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 680396c56bd1..dac53ece51ab 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -388,6 +388,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
 In per-thread mode with inheritance mode on (default), samples are captured only when
 the thread executes on the designated CPUs. Default is to monitor all CPUs.
 
+User space tasks can migrate between CPUs, so when tracing selected CPUs,
+a dummy event is created to track sideband for all CPUs.
+
 -B::
 --no-buildid::
 Do not save the build ids of binaries in the perf.data files. This skips
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3ff9d972225e..4e8e97928f05 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -912,6 +912,7 @@ static int record__config_tracking_events(struct record *rec)
 {
 	struct record_opts *opts = &rec->opts;
 	struct evlist *evlist = rec->evlist;
+	bool system_wide = false;
 	struct evsel *evsel;
 
 	/*
@@ -921,7 +922,18 @@ static int record__config_tracking_events(struct record *rec)
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmus__num_core_pmus() > 1) {
-		evsel = evlist__findnew_tracking_event(evlist, false);
+
+		/*
+		 * User space tasks can migrate between CPUs, so when tracing
+		 * selected CPUs, sideband for all CPUs is still needed.
+		 *
+		 * If all (non-dummy) evsel have exclude_user,
+		 * system_wide is not needed.
+		 */
+		if (!!opts->target.cpu_list && !opts->all_kernel)
+			system_wide = true;
+
+		evsel = evlist__findnew_tracking_event(evlist, system_wide);
 		if (!evsel)
 			return -ENOMEM;
 
-- 
2.30.GIT

