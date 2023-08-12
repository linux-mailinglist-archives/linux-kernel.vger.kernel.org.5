Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0346779E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjHLIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjHLIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF4B2694;
        Sat, 12 Aug 2023 01:52:10 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RNDpW6wdxztRhT;
        Sat, 12 Aug 2023 16:48:35 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:07 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 12/16] perf kwork top: Add statistics on softirq event support
Date:   Sat, 12 Aug 2023 08:49:13 +0000
Message-ID: <20230812084917.169338-13-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230812084917.169338-1-yangjihong1@huawei.com>
References: <20230812084917.169338-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the runtime of the softirq events and subtract it from
the corresponding task runtime to improve the precision.

Example usage:

  # perf kwork -k sched,irq,softirq record -- perf record -e cpu-clock -o perf_record.data -a sleep 10
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.467 MB perf_record.data (7154 samples) ]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.152 MB perf.data (22846 samples) ]
  # perf kwork top

  Total  : 136601.588 ms, 8 cpus
  %Cpu(s):  95.66% id,   0.04% hi,   0.05% si
  %Cpu0   [                                 0.02%]
  %Cpu1   [                                 0.01%]
  %Cpu2   [|                                4.61%]
  %Cpu3   [                                 0.04%]
  %Cpu4   [                                 0.01%]
  %Cpu5   [|||||                           17.31%]
  %Cpu6   [                                 0.51%]
  %Cpu7   [|||                             11.42%]

        PID    %CPU           RUNTIME  COMMMAND
    ----------------------------------------------------
          0   99.98      17073.515 ms  swapper/4
          0   99.98      17072.173 ms  swapper/1
          0   99.93      17064.229 ms  swapper/3
          0   99.62      17011.013 ms  swapper/0
          0   99.47      16985.180 ms  swapper/6
          0   95.17      16250.874 ms  swapper/2
          0   88.51      15111.684 ms  swapper/7
          0   82.62      14108.577 ms  swapper/5
       4342   33.00       5644.045 ms  perf
       4344    0.43         74.351 ms  perf
         16    0.13         22.296 ms  rcu_preempt
       4345    0.05         10.093 ms  perf
       4343    0.05          8.769 ms  perf
       4341    0.02          4.882 ms  perf
       4095    0.02          4.605 ms  kworker/7:1
         75    0.02          4.261 ms  kworker/2:1
        120    0.01          1.909 ms  systemd-journal
         98    0.01          2.540 ms  jbd2/sda-8
         61    0.01          3.404 ms  kcompactd0
        667    0.01          2.542 ms  kworker/u16:2
       4340    0.00          1.052 ms  kworker/7:2
         97    0.00          0.489 ms  kworker/7:1H
         51    0.00          0.209 ms  ksoftirqd/7
         50    0.00          0.646 ms  migration/7
         76    0.00          0.753 ms  kworker/6:1
         45    0.00          0.572 ms  migration/6
         87    0.00          0.145 ms  kworker/5:1H
         73    0.00          0.596 ms  kworker/5:1
         41    0.00          0.041 ms  ksoftirqd/5
         40    0.00          0.718 ms  migration/5
         64    0.00          0.115 ms  kworker/4:1
         35    0.00          0.556 ms  migration/4
        353    0.00          2.600 ms  sshd
         74    0.00          0.205 ms  kworker/3:1
         33    0.00          1.576 ms  kworker/3:0H
         30    0.00          0.996 ms  migration/3
         26    0.00          1.665 ms  ksoftirqd/2
         25    0.00          0.662 ms  migration/2
        397    0.00          0.057 ms  kworker/1:1
         20    0.00          1.005 ms  migration/1
       2909    0.00          1.053 ms  kworker/0:2
         17    0.00          0.720 ms  migration/0
         15    0.00          0.039 ms  ksoftirqd/0

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 30 ++++++++++++++++++++++--------
 tools/perf/util/kwork.h    |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 66ad8c2e8020..c741cc1a543f 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1090,7 +1090,7 @@ static char *evsel__softirq_name(struct evsel *evsel, u64 num)
 	return name;
 }
 
-static void softirq_work_init(struct perf_kwork *kwork __maybe_unused,
+static void softirq_work_init(struct perf_kwork *kwork,
 			      struct kwork_class *class,
 			      struct kwork_work *work,
 			      enum kwork_trace_type src_type __maybe_unused,
@@ -1098,12 +1098,19 @@ static void softirq_work_init(struct perf_kwork *kwork __maybe_unused,
 			      struct perf_sample *sample,
 			      struct machine *machine __maybe_unused)
 {
-	u64 num = evsel__intval(evsel, sample, "vec");
+	u64 num;
 
-	work->id = num;
 	work->class = class;
 	work->cpu = sample->cpu;
-	work->name = evsel__softirq_name(evsel, num);
+
+	if (kwork->report == KWORK_REPORT_TOP) {
+		work->id = evsel__intval_common(evsel, sample, "common_pid");
+		work->name = NULL;
+	} else {
+		num = evsel__intval(evsel, sample, "vec");
+		work->id = num;
+		work->name = evsel__softirq_name(evsel, num);
+	}
 }
 
 static void softirq_work_name(struct kwork_work *work, char *buf, int len)
@@ -1547,6 +1554,7 @@ static void top_print_cpu_usage(struct perf_kwork *kwork)
 	struct kwork_top_stat *stat = &kwork->top_stat;
 	u64 idle_time = stat->cpus_runtime[MAX_NR_CPUS].idle;
 	u64 hardirq_time = stat->cpus_runtime[MAX_NR_CPUS].irq;
+	u64 softirq_time = stat->cpus_runtime[MAX_NR_CPUS].softirq;
 	int cpus_nr = bitmap_weight(stat->all_cpus_bitmap, MAX_NR_CPUS);
 	u64 cpus_total_time = stat->cpus_runtime[MAX_NR_CPUS].total;
 
@@ -1555,12 +1563,15 @@ static void top_print_cpu_usage(struct perf_kwork *kwork)
 	       (double)cpus_total_time / NSEC_PER_MSEC,
 	       cpus_nr);
 
-	printf("%%Cpu(s): %*.*f%% id, %*.*f%% hi\n",
+	printf("%%Cpu(s): %*.*f%% id, %*.*f%% hi, %*.*f%% si\n",
 	       PRINT_CPU_USAGE_WIDTH, PRINT_CPU_USAGE_DECIMAL_WIDTH,
 	       cpus_total_time ? (double)idle_time * 100 / cpus_total_time : 0,
 
 	       PRINT_CPU_USAGE_WIDTH, PRINT_CPU_USAGE_DECIMAL_WIDTH,
-	       cpus_total_time ? (double)hardirq_time * 100 / cpus_total_time : 0);
+	       cpus_total_time ? (double)hardirq_time * 100 / cpus_total_time : 0,
+
+	       PRINT_CPU_USAGE_WIDTH, PRINT_CPU_USAGE_DECIMAL_WIDTH,
+	       cpus_total_time ? (double)softirq_time * 100 / cpus_total_time : 0);
 
 	top_print_per_cpu_load(kwork);
 }
@@ -1966,6 +1977,9 @@ static void top_calc_irq_runtime(struct perf_kwork *kwork,
 	if (type == KWORK_CLASS_IRQ) {
 		stat->cpus_runtime[work->cpu].irq += work->total_runtime;
 		stat->cpus_runtime[MAX_NR_CPUS].irq += work->total_runtime;
+	} else if (type == KWORK_CLASS_SOFTIRQ) {
+		stat->cpus_runtime[work->cpu].softirq += work->total_runtime;
+		stat->cpus_runtime[MAX_NR_CPUS].softirq += work->total_runtime;
 	}
 }
 
@@ -1975,7 +1989,7 @@ static void top_subtract_irq_runtime(struct perf_kwork *kwork,
 	struct kwork_class *class;
 	struct kwork_work *data;
 	unsigned int i;
-	int irq_class_list[] = {KWORK_CLASS_IRQ};
+	int irq_class_list[] = {KWORK_CLASS_IRQ, KWORK_CLASS_SOFTIRQ};
 
 	for (i = 0; i < ARRAY_SIZE(irq_class_list); i++) {
 		class = get_kwork_class(kwork, irq_class_list[i]);
@@ -2392,7 +2406,7 @@ int cmd_kwork(int argc, const char **argv)
 		}
 		kwork.report = KWORK_REPORT_TOP;
 		if (!kwork.event_list_str)
-			kwork.event_list_str = "sched, irq";
+			kwork.event_list_str = "sched, irq, softirq";
 		setup_event_list(&kwork, kwork_options, kwork_usage);
 		setup_sorting(&kwork, top_options, top_usage);
 		return perf_kwork__top(&kwork);
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index b3e410d02043..723b34385df6 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -184,6 +184,7 @@ struct __top_cpus_runtime {
 	u64 load;
 	u64 idle;
 	u64 irq;
+	u64 softirq;
 	u64 total;
 };
 
-- 
2.30.GIT

