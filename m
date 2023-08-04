Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4C76F784
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjHDCKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjHDCKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:10:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA014495;
        Thu,  3 Aug 2023 19:10:19 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RH8Gk3Lc8ztRQF;
        Fri,  4 Aug 2023 10:06:54 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:10:17 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v5 3/7] perf record: Move setting dummy tracking before record__init_thread_masks()
Date:   Fri, 4 Aug 2023 02:07:37 +0000
Message-ID: <20230804020741.99806-4-yangjihong1@huawei.com>
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

When dummy tracking go system wide, the mmap cpu mask is changed.
Therefore, needs to be placed before record__init_thread_masks().
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
---
 tools/perf/builtin-record.c | 59 +++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ca83599cc50c..3ff9d972225e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -908,6 +908,37 @@ static int record__config_off_cpu(struct record *rec)
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
@@ -1288,28 +1319,6 @@ static int record__open(struct record *rec)
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
@@ -4235,6 +4244,12 @@ int cmd_record(int argc, const char **argv)
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

