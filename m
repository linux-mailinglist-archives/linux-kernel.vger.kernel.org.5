Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527075623B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGQMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGQMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:00:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452A210DF;
        Mon, 17 Jul 2023 05:00:47 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R4LHQ6qXDzrRmQ;
        Mon, 17 Jul 2023 20:00:02 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 20:00:43 +0800
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
Subject: [PATCH v2 2/2] perf: add new option '--workload-attr' to set workload sched_policy/priority/mask
Date:   Mon, 17 Jul 2023 20:00:03 +0800
Message-ID: <20230717120003.2391329-3-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717120003.2391329-1-changbin.du@huawei.com>
References: <20230717120003.2391329-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
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

To get consistent benchmarking results, sometimes we need to set the
sched_policy/priority/mask of the workload to reduce system noise.

For example, CPU binding is required on big.little system.

  $ perf stat -- taskset -c 0 ls

Nevertheless, the 'taskset' is also counted here.

To get away of the middleman, this adds a new option '--workload-attr' to
do the same jobs for stat and record commands.

  $ sudo perf stat --workload-attr fifo,40,0-3:7 -- ls

Above will make 'ls' run on CPU #0-#3 and #7 with fifo scheduler and
realtime priority is 40.

Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v2: Use cpu list spec instead of cpu mask number.
---
 tools/perf/Documentation/perf-record.txt |   7 ++
 tools/perf/Documentation/perf-stat.txt   |   6 ++
 tools/perf/builtin-record.c              |  26 +++++
 tools/perf/builtin-stat.c                |  18 ++++
 tools/perf/util/evlist.c                 | 115 +++++++++++++++++++++++
 tools/perf/util/evlist.h                 |   3 +
 tools/perf/util/target.h                 |   9 ++
 7 files changed, 184 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 680396c56bd1..b13b21a6becc 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -838,6 +838,13 @@ filtered through the mask provided by -C option.
 	only, as of now.  So the applications built without the frame
 	pointer might see bogus addresses.
 
+--workload-attr <sched_policy[,priority][,cpu-list]>
+	setup target workload (the <command>) attributes:
+
+	  sched_policy: other|fifo|rr|batch|idle
+	  priority: scheduling priority for fifo|rr, nice value for other
+	  cpu-list: CPU affinity. e.g. 1-2:4 is processors #1, #2, and #4
+
 include::intel-hybrid.txt[]
 
 SEE ALSO
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8f789fa1242e..da7b8393773e 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -262,6 +262,12 @@ disable events during measurements:
  wait -n ${perf_pid}
  exit $?
 
+--workload-attr <sched_policy[,priority][,cpu-list]>
+	setup target workload (the <command>) attributes:
+
+	  sched_policy: other|fifo|rr|batch|idle
+	  priority: scheduling priority for fifo|rr, nice value for other
+	  cpu-list: CPU affinity. e.g. 1-2:4 is processors #1, #2, and #4
 
 --pre::
 --post::
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index aec18db7ff23..c16e230afcd5 100644
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
+					   &opts->target.workload.cpu_map);
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
+	HELP_PAD "cpu-list: CPU affinity. e.g. 1-2:4 is processors #1, #2, and #4";
+
 static bool dry_run;
 
 static struct parse_events_option_args parse_events_option_args = {
@@ -3551,6 +3570,9 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_CALLBACK(0, "workload-attr", &record.opts,
+		     "sched_policy[,priority][,cpu-list]", record_workload_attr_help,
+		     &record_parse_workload_attr_opt),
 	OPT_END()
 };
 
@@ -4266,6 +4288,10 @@ int cmd_record(int argc, const char **argv)
 	record__free_thread_masks(rec, rec->nr_threads);
 	rec->nr_threads = 0;
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
+	if (rec->opts.target.workload.cpu_map) {
+		perf_cpu_map__put(rec->opts.target.workload.cpu_map);
+		rec->opts.target.workload.cpu_map = NULL;
+	}
 	return err;
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 07b48f6df48e..bb755cb44103 100644
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
+					   &target.workload.cpu_map);
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -1220,6 +1230,9 @@ static struct option stat_options[] = {
 	OPT_BOOLEAN(0, "append", &append_file, "append to the output file"),
 	OPT_INTEGER(0, "log-fd", &output_fd,
 		    "log output to fd, instead of stderr"),
+	OPT_CALLBACK(0, "workload-attr", &stat_config,
+		     "sched_policy[,priority][,cpu-list]", record_workload_attr_help,
+		     &parse_workload_attr_opt),
 	OPT_STRING(0, "pre", &pre_cmd, "command",
 			"command to run prior to the measured command"),
 	OPT_STRING(0, "post", &post_cmd, "command",
@@ -2893,5 +2906,10 @@ int cmd_stat(int argc, const char **argv)
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
+	if (target.workload.cpu_map) {
+		perf_cpu_map__put(target.workload.cpu_map);
+		target.workload.cpu_map = NULL;
+	}
+
 	return status;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ef43f72098e..d3949e3e0e85 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -46,6 +46,7 @@
 #include <sys/mman.h>
 #include <sys/prctl.h>
 #include <sys/timerfd.h>
+#include <sys/resource.h>
 
 #include <linux/bitops.h>
 #include <linux/hash.h>
@@ -58,6 +59,7 @@
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
 #include <perf/mmap.h>
+#include <perf/cpumap.h>
 
 #include <internal/xyarray.h>
 
@@ -1398,6 +1400,116 @@ int evlist__open(struct evlist *evlist)
 	return err;
 }
 
+int evlist__parse_workload_attr(const char *str, int *sched_policy, int *sched_priority,
+				struct perf_cpu_map **cpu_map)
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
+		/* sched policy */
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
+		/* sched priority */
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
+		/* cpu list */
+		tok = strtok_r(NULL, ",", &saveptr);
+		if (tok) {
+			*cpu_map = __perf_cpu_map__new(tok, ':');
+			if (!*cpu_map) {
+				pr_err("workload_attr: failed to get cpus map from %s\n", tok);
+				break;
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
+			perror("failed to set the sched policy");
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
+	if (target->workload.cpu_map) {
+		size_t cpuset_size = -1;
+		cpu_set_t *cpu_set;
+
+		cpu_set = perf_cpu_map__2_cpuset(target->workload.cpu_map, &cpuset_size);
+		if (!cpu_set)
+			return -1;
+
+		if (sched_setaffinity(0, cpuset_size, cpu_set) != 0) {
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
@@ -1464,6 +1576,9 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 			exit(ret);
 		}
 
+		if (setup_workload_attr(target) != 0)
+			exit(-1);
+
 		execvp(argv[0], (char **)argv);
 
 		if (exec_error) {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 664c6bf7b3e0..761ae102dda6 100644
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
+				struct perf_cpu_map **cpu_set);
 int evlist__prepare_workload(struct evlist *evlist, struct target *target,
 			     const char *argv[], bool pipe_output,
 			     void (*exec_error)(int signo, siginfo_t *info, void *ucontext));
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index d582cae8e105..16fe33dda2ef 100644
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
+		struct perf_cpu_map *cpu_map;
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

