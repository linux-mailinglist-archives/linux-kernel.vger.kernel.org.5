Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE60779E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjHLIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHLIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A870268C;
        Sat, 12 Aug 2023 01:52:09 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RNDqG4PBmz2Bd1n;
        Sat, 12 Aug 2023 16:49:14 +0800 (CST)
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
Subject: [RFC v1 11/16] perf kwork top: Add statistics on hardirq event support
Date:   Sat, 12 Aug 2023 08:49:12 +0000
Message-ID: <20230812084917.169338-12-yangjihong1@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the runtime of the hardirq events and subtract it from
the corresponding task runtime to improve the precision.

Example usage:

  # perf kwork -k sched,irq record -- perf record -o perf_record.data -a sleep 10
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 1.054 MB perf_record.data (18019 samples) ]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.798 MB perf.data (16334 samples) ]
  #
  # perf kwork top

  Total  : 139240.869 ms, 8 cpus
  %Cpu(s):  94.91% id,   0.05% hi
  %Cpu0   [                                 0.05%]
  %Cpu1   [|                                5.00%]
  %Cpu2   [                                 0.43%]
  %Cpu3   [                                 0.57%]
  %Cpu4   [                                 1.19%]
  %Cpu5   [||||||                          20.46%]
  %Cpu6   [                                 0.48%]
  %Cpu7   [|||                             12.10%]

        PID    %CPU           RUNTIME  COMMMAND
    ----------------------------------------------------
          0   99.54      17325.622 ms  swapper/2
          0   99.54      17327.527 ms  swapper/0
          0   99.51      17319.909 ms  swapper/6
          0   99.42      17304.934 ms  swapper/3
          0   98.80      17197.385 ms  swapper/4
          0   94.99      16534.991 ms  swapper/1
          0   87.89      15295.264 ms  swapper/7
          0   79.53      13843.182 ms  swapper/5
       4252   36.50       6361.768 ms  perf
       4256    1.17        205.215 ms  bash
        151    0.53         93.298 ms  systemd-resolve
       4254    0.39         69.468 ms  perf
        423    0.34         59.368 ms  bash
        412    0.29         51.204 ms  sshd
        249    0.20         35.288 ms  sd-resolve
         16    0.17         30.287 ms  rcu_preempt
        153    0.09         17.266 ms  systemd-timesyn
          1    0.09         17.078 ms  systemd
       4253    0.07         12.457 ms  perf
       4255    0.06         11.559 ms  perf
       4234    0.03          6.105 ms  kworker/u16:1
         69    0.03          6.259 ms  kworker/1:1H
       4251    0.02          4.615 ms  perf
       4095    0.02          4.890 ms  kworker/7:1
         61    0.02          4.005 ms  kcompactd0
         75    0.02          3.546 ms  kworker/2:1
         97    0.01          3.106 ms  kworker/7:1H
         98    0.01          1.995 ms  jbd2/sda-8
       4088    0.01          1.779 ms  kworker/u16:3
       2909    0.01          1.795 ms  kworker/0:2
       4246    0.00          1.117 ms  kworker/7:2
         51    0.00          0.327 ms  ksoftirqd/7
         50    0.00          0.369 ms  migration/7
        102    0.00          0.160 ms  kworker/6:1H
         76    0.00          0.609 ms  kworker/6:1
         45    0.00          0.779 ms  migration/6
         87    0.00          0.504 ms  kworker/5:1H
         73    0.00          1.130 ms  kworker/5:1
         41    0.00          0.152 ms  ksoftirqd/5
         40    0.00          0.702 ms  migration/5
         64    0.00          0.316 ms  kworker/4:1
         35    0.00          0.791 ms  migration/4
        353    0.00          2.211 ms  sshd
         74    0.00          0.272 ms  kworker/3:1
         30    0.00          0.819 ms  migration/3
         25    0.00          0.784 ms  migration/2
        397    0.00          0.539 ms  kworker/1:1
         21    0.00          1.600 ms  ksoftirqd/1
         20    0.00          0.773 ms  migration/1
         17    0.00          1.682 ms  migration/0
         15    0.00          0.076 ms  ksoftirqd/0

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 93 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/kwork.h    |  1 +
 2 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 1b213af59135..66ad8c2e8020 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -866,6 +866,36 @@ static int top_entry_event(struct perf_kwork *kwork,
 			      machine, NULL, true);
 }
 
+static int top_exit_event(struct perf_kwork *kwork,
+			  struct kwork_class *class,
+			  struct evsel *evsel,
+			  struct perf_sample *sample,
+			  struct machine *machine)
+{
+	struct kwork_work *work, *sched_work;
+	struct kwork_class *sched_class;
+	struct kwork_atom *atom;
+
+	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
+			     KWORK_TRACE_ENTRY, evsel, sample,
+			     machine, &work);
+	if (!work)
+		return -1;
+
+	if (atom) {
+		sched_class = get_kwork_class(kwork, KWORK_CLASS_SCHED);
+		if (sched_class) {
+			sched_work = find_work_by_id(&sched_class->work_root,
+						     work->id, work->cpu);
+			if (sched_work)
+				top_update_runtime(work, atom, sample);
+		}
+		atom_del(atom);
+	}
+
+	return 0;
+}
+
 static int top_sched_switch_event(struct perf_kwork *kwork,
 				  struct kwork_class *class,
 				  struct evsel *evsel,
@@ -933,7 +963,7 @@ static int irq_class_init(struct kwork_class *class,
 	return 0;
 }
 
-static void irq_work_init(struct perf_kwork *kwork __maybe_unused,
+static void irq_work_init(struct perf_kwork *kwork,
 			  struct kwork_class *class,
 			  struct kwork_work *work,
 			  enum kwork_trace_type src_type __maybe_unused,
@@ -943,8 +973,14 @@ static void irq_work_init(struct perf_kwork *kwork __maybe_unused,
 {
 	work->class = class;
 	work->cpu = sample->cpu;
-	work->id = evsel__intval(evsel, sample, "irq");
-	work->name = evsel__strval(evsel, sample, "name");
+
+	if (kwork->report == KWORK_REPORT_TOP) {
+		work->id = evsel__intval_common(evsel, sample, "common_pid");
+		work->name = NULL;
+	} else {
+		work->id = evsel__intval(evsel, sample, "irq");
+		work->name = evsel__strval(evsel, sample, "name");
+	}
 }
 
 static void irq_work_name(struct kwork_work *work, char *buf, int len)
@@ -1510,6 +1546,7 @@ static void top_print_cpu_usage(struct perf_kwork *kwork)
 {
 	struct kwork_top_stat *stat = &kwork->top_stat;
 	u64 idle_time = stat->cpus_runtime[MAX_NR_CPUS].idle;
+	u64 hardirq_time = stat->cpus_runtime[MAX_NR_CPUS].irq;
 	int cpus_nr = bitmap_weight(stat->all_cpus_bitmap, MAX_NR_CPUS);
 	u64 cpus_total_time = stat->cpus_runtime[MAX_NR_CPUS].total;
 
@@ -1518,9 +1555,12 @@ static void top_print_cpu_usage(struct perf_kwork *kwork)
 	       (double)cpus_total_time / NSEC_PER_MSEC,
 	       cpus_nr);
 
-	printf("%%Cpu(s): %*.*f%% id\n",
+	printf("%%Cpu(s): %*.*f%% id, %*.*f%% hi\n",
+	       PRINT_CPU_USAGE_WIDTH, PRINT_CPU_USAGE_DECIMAL_WIDTH,
+	       cpus_total_time ? (double)idle_time * 100 / cpus_total_time : 0,
+
 	       PRINT_CPU_USAGE_WIDTH, PRINT_CPU_USAGE_DECIMAL_WIDTH,
-	       cpus_total_time ? (double)idle_time * 100 / cpus_total_time : 0);
+	       cpus_total_time ? (double)hardirq_time * 100 / cpus_total_time : 0);
 
 	top_print_per_cpu_load(kwork);
 }
@@ -1621,6 +1661,8 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 		.exit_event  = timehist_exit_event,
 	};
 	static struct trace_kwork_handler top_ops = {
+		.entry_event        = timehist_entry_event,
+		.exit_event         = top_exit_event,
 		.sched_switch_event = top_sched_switch_event,
 	};
 
@@ -1915,6 +1957,43 @@ static void top_calc_idle_time(struct perf_kwork *kwork,
 	}
 }
 
+static void top_calc_irq_runtime(struct perf_kwork *kwork,
+				 enum kwork_class_type type,
+				 struct kwork_work *work)
+{
+	struct kwork_top_stat *stat = &kwork->top_stat;
+
+	if (type == KWORK_CLASS_IRQ) {
+		stat->cpus_runtime[work->cpu].irq += work->total_runtime;
+		stat->cpus_runtime[MAX_NR_CPUS].irq += work->total_runtime;
+	}
+}
+
+static void top_subtract_irq_runtime(struct perf_kwork *kwork,
+				     struct kwork_work *work)
+{
+	struct kwork_class *class;
+	struct kwork_work *data;
+	unsigned int i;
+	int irq_class_list[] = {KWORK_CLASS_IRQ};
+
+	for (i = 0; i < ARRAY_SIZE(irq_class_list); i++) {
+		class = get_kwork_class(kwork, irq_class_list[i]);
+		if (!class)
+			continue;
+
+		data = find_work_by_id(&class->work_root,
+				       work->id, work->cpu);
+		if (!data)
+			continue;
+
+		if (work->total_runtime > data->total_runtime) {
+			work->total_runtime -= data->total_runtime;
+			top_calc_irq_runtime(kwork, irq_class_list[i], data);
+		}
+	}
+}
+
 static void top_calc_cpu_usage(struct perf_kwork *kwork)
 {
 	struct kwork_class *class;
@@ -1935,6 +2014,8 @@ static void top_calc_cpu_usage(struct perf_kwork *kwork)
 
 		__set_bit(work->cpu, stat->all_cpus_bitmap);
 
+		top_subtract_irq_runtime(kwork, work);
+
 		work->cpu_usage = work->total_runtime * 10000 /
 			stat->cpus_runtime[work->cpu].total;
 
@@ -2311,7 +2392,7 @@ int cmd_kwork(int argc, const char **argv)
 		}
 		kwork.report = KWORK_REPORT_TOP;
 		if (!kwork.event_list_str)
-			kwork.event_list_str = "sched";
+			kwork.event_list_str = "sched, irq";
 		setup_event_list(&kwork, kwork_options, kwork_usage);
 		setup_sorting(&kwork, top_options, top_usage);
 		return perf_kwork__top(&kwork);
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 41ed193d5d8b..b3e410d02043 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -183,6 +183,7 @@ struct trace_kwork_handler {
 struct __top_cpus_runtime {
 	u64 load;
 	u64 idle;
+	u64 irq;
 	u64 total;
 };
 
-- 
2.30.GIT

