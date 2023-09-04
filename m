Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE6791020
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350994AbjIDCg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350934AbjIDCg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:36:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77610E;
        Sun,  3 Sep 2023 19:36:52 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RfCNk1Xb5zNmqx;
        Mon,  4 Sep 2023 10:33:10 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 10:36:48 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v8 3/6] perf record: Move setting tracking events before record__init_thread_masks()
Date:   Mon, 4 Sep 2023 02:33:37 +0000
Message-ID: <20230904023340.12707-4-yangjihong1@huawei.com>
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

User space tasks can migrate between CPUs, so when tracing selected CPUs,
sideband for all CPUs is needed. In this case set the cpu map of the evsel
to all online CPUs. This may modify the original cpu map of the evlist.
Therefore, need to check whether the preceding scenario exists before
record__init_thread_masks().
Dummy tracking has been set in record__open(), move it before
record__init_thread_masks() and add a helper for unified processing.

The sys_perf_event_open invoked is as follows:

  # perf --debug verbose=3 record -e cpu-clock -D 100 true
  <SNIP>
  Opening: cpu-clock
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0 (PERF_COUNT_SW_CPU_CLOCK)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 = 13
  Opening: dummy:u
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0x9 (PERF_COUNT_SW_DUMMY)
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|IDENTIFIER
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    exclude_kernel                   1
    exclude_hv                       1
    mmap                             1
    comm                             1
    enable_on_exec                   1
    task                             1
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 = 14
  sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 = 15
  sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 = 16
  sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 = 17
  sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 = 18
  sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 = 19
  sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 = 20
  sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 = 21
  <SNIP>

perf test need to update base-record & system-wide-dummy attr expected values
for test-record-C0:

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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c             | 59 ++++++++++++++++---------
 tools/perf/tests/attr/system-wide-dummy | 14 +++---
 tools/perf/tests/attr/test-record-C0    |  4 +-
 3 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 12edad8392cc..83bd1f117191 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -906,6 +906,37 @@ static int record__config_off_cpu(struct record *rec)
 	return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
 }
 
+static int record__config_tracking_events(struct record *rec)
+{
+	struct record_opts *opts = &rec->opts;
+	struct evlist *evlist = rec->evlist;
+	struct evsel *evsel;
+
+	/*
+	 * For initial_delay, system wide or a hybrid system, we need to add
+	 * tracking event so that we can track PERF_RECORD_MMAP to cover the
+	 * delay of waiting or event synthesis.
+	 */
+	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
+	    perf_pmus__num_core_pmus() > 1) {
+		evsel = evlist__findnew_tracking_event(evlist, false);
+		if (!evsel)
+			return -ENOMEM;
+
+		/*
+		 * Enable the tracking event when the process is forked for
+		 * initial_delay, immediately for system wide.
+		 */
+		if (opts->target.initial_delay && !evsel->immediate &&
+		    !target__has_cpu(&opts->target))
+			evsel->core.attr.enable_on_exec = 1;
+		else
+			evsel->immediate = 1;
+	}
+
+	return 0;
+}
+
 static bool record__kcore_readable(struct machine *machine)
 {
 	char kcore[PATH_MAX];
@@ -1286,28 +1317,6 @@ static int record__open(struct record *rec)
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
 
-	/*
-	 * For initial_delay, system wide or a hybrid system, we need to add a
-	 * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
-	 * of waiting or event synthesis.
-	 */
-	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
-	    perf_pmus__num_core_pmus() > 1) {
-		pos = evlist__findnew_tracking_event(evlist, false);
-		if (!pos)
-			return -ENOMEM;
-
-		/*
-		 * Enable the dummy event when the process is forked for
-		 * initial_delay, immediately for system wide.
-		 */
-		if (opts->target.initial_delay && !pos->immediate &&
-		    !target__has_cpu(&opts->target))
-			pos->core.attr.enable_on_exec = 1;
-		else
-			pos->immediate = 1;
-	}
-
 	evlist__config(evlist, opts, &callchain_param);
 
 	evlist__for_each_entry(evlist, pos) {
@@ -4190,6 +4199,12 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	err = record__config_tracking_events(rec);
+	if (err) {
+		pr_err("record__config_tracking_events failed, error %d\n", err);
+		goto out;
+	}
+
 	err = record__init_thread_masks(rec);
 	if (err) {
 		pr_err("Failed to initialize parallel data streaming masks\n");
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

