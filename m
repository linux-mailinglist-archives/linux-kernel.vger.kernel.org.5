Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD3751C65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjGMI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjGMI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:59:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC4F127;
        Thu, 13 Jul 2023 01:59:06 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1pRm2bdMz18KGW;
        Thu, 13 Jul 2023 16:58:28 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:59:03 +0800
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
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf: add new option '--workload-attr' to set workload sched_policy/priority/mask
Date:   Thu, 13 Jul 2023 16:58:31 +0800
Message-ID: <20230713085831.395112-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

To get consistent benchmarking results, sometimes we need to set the
sched_policy/priority/mask of the workload to reduce system noise.

For example, CPU binding is required on big.little system.

  $ perf stat -r 10 -- taskset -c 0 ls

Nevertheless, the 'taskset' is also counted here.

To get away of the middleman, this adds a new option '--workload-attr' to
do the same jobs for stat and record commands.

  $ sudo perf stat --workload-attr fifo,40,0x1 -- ls

Above will make 'ls' run on CPU #0 with fifo scheduler and realtime
priority is 40.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-record.c |  22 +++++++
 tools/perf/builtin-stat.c   |  13 ++++
 tools/perf/util/evlist.c    | 117 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |   3 +
 tools/perf/util/target.h    |   9 +++
 5 files changed, 164 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index aec18db7ff23..dc14231f01bb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3289,6 +3289,17 @@ static int parse_record_synth_option(const struct option *opt,
 	return 0;
 }
 
+static int record_parse_workload_attr_opt(const struct option *opt,
+					  const char *arg,
+					  int unset __maybe_unused)
+{
+	struct record_opts *opts = opt->value;
+
+	return evlist__parse_workload_attr(arg, &opts->target.workload.sched_policy,
+					   &opts->target.workload.sched_priority,
+					   &opts->target.workload.cpu_mask);
+}
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -3309,6 +3320,8 @@ static struct record record = {
 		.target		     = {
 			.uses_mmap   = true,
 			.default_per_cpu = true,
+			.workload.sched_policy = -1,
+			.workload.sched_priority = 0,
 		},
 		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 		.nr_threads_synthesize = 1,
@@ -3333,6 +3346,12 @@ static struct record record = {
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
 	"\n\t\t\t\tDefault: fp";
 
+const char record_workload_attr_help[] =
+	"setup target workload (the <command>) attributes:\n\n"
+	HELP_PAD "sched_policy: other|fifo|rr|batch|idle\n"
+	HELP_PAD "priority: scheduling priority for fifo|rr, nice value for other\n"
+	HELP_PAD "cpu-mask: CPU affinity mask. e.g. 0x03 is processors #0 and #1";
+
 static bool dry_run;
 
 static struct parse_events_option_args parse_events_option_args = {
@@ -3551,6 +3570,9 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_CALLBACK(0, "workload-attr", &record.opts,
+		     "sched_policy[,priority][,cpu-mask]", record_workload_attr_help,
+		     &record_parse_workload_attr_opt),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 07b48f6df48e..1a83ea9c4b7f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -108,6 +108,8 @@ static bool all_counters_use_bpf = true;
 
 static struct target target = {
 	.uid	= UINT_MAX,
+	.workload.sched_policy = -1,
+	.workload.sched_priority = 0,
 };
 
 #define METRIC_ONLY_LEN 20
@@ -1160,6 +1162,14 @@ static int parse_cache_level(const struct option *opt,
 	return 0;
 }
 
+static int parse_workload_attr_opt(const struct option *opt __maybe_unused, const char *arg,
+				   int unset __maybe_unused)
+{
+	return evlist__parse_workload_attr(arg, &target.workload.sched_policy,
+					   &target.workload.sched_priority,
+					   &target.workload.cpu_mask);
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1298,6 +1308,9 @@ static struct option stat_options[] = {
 	OPT_CALLBACK_OPTARG(0, "iostat", &evsel_list, &stat_config, "default",
 			    "measure I/O performance metrics provided by arch/platform",
 			    iostat_parse),
+	OPT_CALLBACK(0, "workload-attr", &stat_config,
+		     "sched_policy[,priority][,cpu-mask]", record_workload_attr_help,
+		     &parse_workload_attr_opt),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ef43f72098e..5b040f489f1a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -46,6 +46,7 @@
 #include <sys/mman.h>
 #include <sys/prctl.h>
 #include <sys/timerfd.h>
+#include <sys/resource.h>
 
 #include <linux/bitops.h>
 #include <linux/hash.h>
@@ -1398,6 +1399,119 @@ int evlist__open(struct evlist *evlist)
 	return err;
 }
 
+int evlist__parse_workload_attr(const char *str, int *sched_policy, int *sched_priority,
+				cpu_set_t *cpu_mask)
+{
+	char *tok, *saveptr = NULL;
+	char *buf;
+	int ret = -1;
+
+	/* We need buffer that we know we can write to. */
+	buf = strdup(str);
+	if (!buf)
+		return -ENOMEM;
+
+	tok = strtok_r((char *)buf, ",", &saveptr);
+	do {
+		/* sched_policy */
+		if (!strncmp(tok, "other", sizeof("other")))
+			*sched_policy = SCHED_OTHER;
+		else if (!strncmp(tok, "fifo", sizeof("fifo"))) {
+			*sched_policy = SCHED_FIFO;
+			/* default to lowest priority */
+			*sched_priority = 99;
+		} else if (!strncmp(tok, "rr", sizeof("rr"))) {
+			*sched_policy = SCHED_RR;
+			*sched_priority = 99;
+		} else if (!strncmp(tok, "batch", sizeof("batch")))
+			*sched_policy = SCHED_BATCH;
+		else if (!strncmp(tok, "idle", sizeof("idle")))
+			*sched_policy = SCHED_IDLE;
+		else {
+			pr_err("workload_attr: unknown sched policy %s\n", tok);
+			break;
+		}
+
+		/* sched_priority */
+		tok = strtok_r(NULL, ",", &saveptr);
+		if (tok) {
+			int priority;
+			char *endptr;
+
+			priority = strtol(tok, &endptr, 0);
+			if (*endptr) {
+				pr_err("workload_attr: invalid sched priority %s\n", tok);
+				break;
+			}
+
+			if (*sched_policy == SCHED_FIFO || *sched_policy == SCHED_RR) {
+				if (priority < 1 || priority > 99) {
+					pr_err("workload_attr: invalid priority %d for fifo and rr, allowed [1,99]\n",
+					       priority);
+					break;
+				}
+			}
+			*sched_priority = priority;
+		}
+
+		/* cpu_mask */
+		tok = strtok_r(NULL, ",", &saveptr);
+		if (tok) {
+			char *endptr;
+			unsigned long mask = 0;
+
+			/* TODO: parse more than 64 cpus. */
+			mask = strtoul(tok, &endptr, 0);
+			if (*endptr) {
+				pr_err("workload_attr: invalid cpu mask %s\n", tok);
+				break;
+			}
+
+			for (unsigned int i = 0; i < 8 * sizeof(unsigned long); i++) {
+				if ((mask >> i) & 0x1)
+					CPU_SET(i, cpu_mask);
+			}
+		}
+		ret = 0;
+	} while (0);
+
+	free(buf);
+	return ret;
+}
+
+static int setup_workload_attr(struct target *target)
+{
+	struct sched_param param;
+	int policy = target->workload.sched_policy;
+	int priority = target->workload.sched_priority;
+
+	if (policy >= 0) {
+		param.sched_priority = (policy == SCHED_FIFO || policy == SCHED_RR) ?
+					priority : 0;
+		if (sched_setscheduler(0, policy, &param) != 0) {
+			perror("failed to set the scheduler");
+			return -1;
+		}
+
+		if (policy == SCHED_OTHER) {
+			if (setpriority(PRIO_PROCESS, 0, priority) != 0) {
+				perror("failed to set the nice value");
+				return -1;
+			}
+		}
+	}
+
+	if (CPU_COUNT(&target->workload.cpu_mask) > 0) {
+		if (sched_setaffinity(0, sizeof(target->workload.cpu_mask),
+				      &target->workload.cpu_mask) != 0) {
+			perror("failed to set the sched affinity");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 int evlist__prepare_workload(struct evlist *evlist, struct target *target, const char *argv[],
 			     bool pipe_output, void (*exec_error)(int signo, siginfo_t *info, void *ucontext))
 {
@@ -1464,6 +1578,9 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 			exit(ret);
 		}
 
+		if (setup_workload_attr(target) != 0)
+			exit(-1);
+
 		execvp(argv[0], (char **)argv);
 
 		if (exec_error) {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 664c6bf7b3e0..9502e9a8d5eb 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -15,6 +15,7 @@
 #include <pthread.h>
 #include <signal.h>
 #include <unistd.h>
+#include <sched.h>
 
 struct pollfd;
 struct thread_map;
@@ -180,6 +181,8 @@ void evlist__set_id_pos(struct evlist *evlist);
 void evlist__config(struct evlist *evlist, struct record_opts *opts, struct callchain_param *callchain);
 int record_opts__config(struct record_opts *opts);
 
+int evlist__parse_workload_attr(const char *str, int *sched_policy, int *sched_priority,
+				cpu_set_t *cpu_mask);
 int evlist__prepare_workload(struct evlist *evlist, struct target *target,
 			     const char *argv[], bool pipe_output,
 			     void (*exec_error)(int signo, siginfo_t *info, void *ucontext));
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index d582cae8e105..75cc2070687f 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <sys/types.h>
+#include <sched.h>
 
 struct target {
 	const char   *pid;
@@ -19,6 +20,12 @@ struct target {
 	bool	     use_bpf;
 	int	     initial_delay;
 	const char   *attr_map;
+
+	struct {
+		int	 sched_policy;
+		int	 sched_priority;
+		cpu_set_t cpu_mask;
+	} workload;
 };
 
 enum target_errno {
@@ -103,4 +110,6 @@ static inline bool target__uses_dummy_map(struct target *target)
 	return use_dummy;
 }
 
+extern const char record_workload_attr_help[];
+
 #endif /* _PERF_TARGET_H */
-- 
2.25.1

