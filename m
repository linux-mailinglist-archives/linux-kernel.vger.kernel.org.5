Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8714782135
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHUBai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjHUBae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:30:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D1A2;
        Sun, 20 Aug 2023 18:30:31 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTZZl3vw5zNn2X;
        Mon, 21 Aug 2023 09:26:55 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 09:30:28 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v6 3/7] perf record: Move setting dummy tracking before record__init_thread_masks()
Date:   Mon, 21 Aug 2023 01:27:30 +0000
Message-ID: <20230821012734.18241-4-yangjihong1@huawei.com>
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

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 59 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 12edad8392cc..4ee94058028f 100644
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
+	 * For initial_delay, system wide or a hybrid system, we need to add a
+	 * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
+	 * of waiting or event synthesis.
+	 */
+	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
+	    perf_pmus__num_core_pmus() > 1) {
+		evsel = evlist__findnew_tracking_event(evlist, false);
+		if (!evsel)
+			return -ENOMEM;
+
+		/*
+		 * Enable the dummy event when the process is forked for
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
-- 
2.30.GIT

