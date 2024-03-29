Return-Path: <linux-kernel+bounces-125315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E2E8923E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C649B1C22208
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2113A3E5;
	Fri, 29 Mar 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8u29jhU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD48225A8;
	Fri, 29 Mar 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739571; cv=none; b=Ek/Ly/6yQc+lgGjCs4riMYSoOn3b88A83/AQYg52XPMjFA1eRhT7Ug07UW3eWnAgSbtRu7Wx32j7hzsuhSCBwVWNaPlaB22udPW4w2ZdIIdH5uQUrfZHMA/AFwuyxCEWd2ciEDlf7Wt7xYVdp+/CF/LV7ev3SVu8QnagAKKbujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739571; c=relaxed/simple;
	bh=FokolN3UQvKbVpaapMDPaw4D61pLSGDmq/87Sq2rP6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz/8S7iqsUXhdnT4jAWbKpR3dHL6mrumuyWcGkx1IiSwnaqgNmeVZYLnHfemJXoFPA5EmlgVPlMmqA+sLsglYj7OoexAKpxIW579pYvyMnsvRjoUpXc2E9kxtsOrNqJhxNSXAn8x0+TcM4Uv+WVEb8LYV+Wc4Ot8kHvM9rGPL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8u29jhU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711739569; x=1743275569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FokolN3UQvKbVpaapMDPaw4D61pLSGDmq/87Sq2rP6I=;
  b=E8u29jhUqumg/BT+8X14NCE6PRAPyCiOLNj8EzaxJgzWQUceVjT6ZSyj
   39lCy/81Ztsf+2SO7+qNYiCQ/eLItPpBMIALbGogTM3TXpILx04Nv5jVH
   RooKRPujnQtGa2h6Zkm5o5KSYkLWBUoN1s6RJfVkNUgpIQEiCQ1bKzWWF
   nice0Vy+ErPzYc9+UWYWVf3lzE8W8Z29eNmhp9AnoGIANKfAXgh2YMJvi
   x7svMiFakOV8mw3SqNfziffhS2GDkvdlAhZ3jK0ztY07yFQvNTSnfSqSC
   EuWYPvHnMwzu4+lwCDYBb7YSseScc9Xk6MMnoA7A5D5hHHjBVVBkJJwTY
   w==;
X-CSE-ConnectionGUID: hecE4idCT760f+5i9/a8BQ==
X-CSE-MsgGUID: ZGeowDptSWODtnO9LQWs4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7531722"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7531722"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 12:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="54506856"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa001.jf.intel.com with ESMTP; 29 Mar 2024 12:12:46 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Fri, 29 Mar 2024 15:12:21 -0400
Message-ID: <20240329191224.1046866-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329191224.1046866-1-weilin.wang@intel.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When retire_latency value is used in a metric formula, perf stat would fork a
perf record process with "-e" and "-W" options. Perf record will collect
required retire_latency values in parallel while perf stat is collecting
counting values.

At the point of time that perf stat stops counting, it would send sigterm signal
to perf record process and receiving sampling data back from perf record from a
pipe. Perf stat will then process the received data to get retire latency data
and calculate metric result.

Another thread is required to synchronize between perf stat and perf record
when we pass data through pipe.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 190 +++++++++++++++++++++++++++++++++-
 tools/perf/util/data.c        |   6 +-
 tools/perf/util/metricgroup.h |   8 ++
 tools/perf/util/stat.h        |   2 +
 4 files changed, 203 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6291e1e24535..7fbe47b0c44c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -94,8 +94,13 @@
 #include <perf/evlist.h>
 #include <internal/threadmap.h>
 
+#include "util/sample.h"
+#include <sys/param.h>
+#include <subcmd/run-command.h>
+
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
+#define PERF_DATA		"-"
 
 static void print_counters(struct timespec *ts, int argc, const char **argv);
 
@@ -163,6 +168,8 @@ static struct perf_stat_config stat_config = {
 	.ctl_fd_ack		= -1,
 	.iostat_run		= false,
 	.tpebs_events		= LIST_HEAD_INIT(stat_config.tpebs_events),
+	.tpebs_results		= LIST_HEAD_INIT(stat_config.tpebs_results),
+	.tpebs_pid              = -1,
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -684,15 +691,155 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
+	if (stat_config.tpebs_pid != -1)
+		kill(stat_config.tpebs_pid, SIGTERM);
 	return COUNTER_FATAL;
 }
 
-static int __run_perf_record(void)
+static int __run_perf_record(const char **record_argv)
 {
+	int i = 0;
+	struct tpebs_event *e;
+
 	pr_debug("Prepare perf record for retire_latency\n");
+
+	record_argv[i++] = "perf";
+	record_argv[i++] = "record";
+	record_argv[i++] = "-W";
+	record_argv[i++] = "--synth=no";
+
+	if (stat_config.user_requested_cpu_list) {
+		record_argv[i++] = "-C";
+		record_argv[i++] = stat_config.user_requested_cpu_list;
+	}
+
+	if (stat_config.system_wide)
+		record_argv[i++] = "-a";
+
+	if (!stat_config.system_wide && !stat_config.user_requested_cpu_list) {
+		pr_err("Require -a or -C option to run sampling.\n");
+		return -ECANCELED;
+	}
+
+	list_for_each_entry(e, &stat_config.tpebs_events, nd) {
+		record_argv[i++] = "-e";
+		record_argv[i++] = e->name;
+	}
+
+	record_argv[i++] = "-o";
+	record_argv[i++] = PERF_DATA;
+
 	return 0;
 }
 
+static void prepare_run_command(struct child_process *cmd,
+			       const char **argv)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->argv = argv;
+	cmd->out = -1;
+}
+
+static int prepare_perf_record(struct child_process *cmd)
+{
+	const char **record_argv;
+	int ret;
+
+	record_argv = calloc(10 + 2 * stat_config.tpebs_event_size, sizeof(char *));
+	if (!record_argv)
+		return -1;
+
+	ret = __run_perf_record(record_argv);
+	if (ret)
+		return ret;
+
+	prepare_run_command(cmd, record_argv);
+	return start_command(cmd);
+}
+
+struct perf_script {
+	struct perf_tool	tool;
+	struct perf_session	*session;
+};
+
+static void tpebs_data__delete(void)
+{
+	struct tpebs_retire_lat *r, *rtmp;
+	struct tpebs_event *e, *etmp;
+
+	list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, event.nd) {
+		list_del_init(&r->event.nd);
+		free(r);
+	}
+	list_for_each_entry_safe(e, etmp, &stat_config.tpebs_events, nd) {
+		list_del_init(&e->nd);
+		free(e);
+	}
+}
+
+static int process_sample_event(struct perf_tool *tool __maybe_unused,
+				union perf_event *event __maybe_unused,
+				struct perf_sample *sample,
+				struct evsel *evsel,
+				struct machine *machine __maybe_unused)
+{
+	int ret = 0;
+	const char *evname;
+	struct tpebs_retire_lat *t;
+
+	evname = evsel__name(evsel);
+
+	/*
+	 * Need to handle per core results? We are assuming average retire
+	 * latency value will be used. Save the number of samples and the sum of
+	 * retire latency value for each event.
+	 */
+	list_for_each_entry(t, &stat_config.tpebs_results, event.nd) {
+		if (!strcmp(evname, t->event.name)) {
+			t->count += 1;
+			t->sum += sample->retire_lat;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int process_feature_event(struct perf_session *session,
+				 union perf_event *event)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(session, event);
+	return 0;
+}
+
+static void *__cmd_script(void *arg __maybe_unused)
+{
+	struct child_process *cmd = arg;
+	struct perf_session *session;
+	struct perf_data data = {
+		.mode = PERF_DATA_MODE_READ,
+		.path = PERF_DATA,
+		.file.fd = cmd->out,
+	};
+	struct perf_script script = {
+		.tool = {
+		.sample		 = process_sample_event,
+		.feature	 = process_feature_event,
+		.attr		 = perf_event__process_attr,
+		},
+	};
+
+	session = perf_session__new(&data, &script.tool);
+	if (IS_ERR(session))
+		return NULL;
+	script.session = session;
+	perf_session__process_events(session);
+	perf_session__delete(session);
+
+	return NULL;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -709,15 +856,38 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity saved_affinity, *affinity = NULL;
 	int err;
 	bool second_pass = false;
+	struct child_process cmd;
+	pthread_t thread_script;
 
 	/* Prepare perf record for sampling event retire_latency before fork and
 	 * prepare workload */
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
+		struct tpebs_event *e;
 
-		ret = __run_perf_record();
+		pr_debug("perf stat pid = %d\n", getpid());
+		list_for_each_entry(e, &stat_config.tpebs_events, nd) {
+			struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
+
+			if (!new)
+				return -1;
+			new->event.name = strdup(e->name);
+			new->event.tpebs_name = strdup(e->tpebs_name);
+			new->count = 0;
+			new->sum = 0;
+			list_add_tail(&new->event.nd, &stat_config.tpebs_results);
+		}
+		ret = prepare_perf_record(&cmd);
 		if (ret)
 			return ret;
+		if (pthread_create(&thread_script, NULL, __cmd_script, &cmd)) {
+			kill(cmd.pid, SIGTERM);
+			close(cmd.out);
+			pr_err("Could not create thread to process sample data.\n");
+			return -1;
+		}
+		/* Wait for perf record initialization a little bit.*/
+		sleep(2);
 	}
 
 	if (forks) {
@@ -925,6 +1095,17 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	t1 = rdclock();
 
+	if (stat_config.tpebs_event_size > 0) {
+		int ret;
+
+		kill(cmd.pid, SIGTERM);
+		pthread_join(thread_script, NULL);
+		close(cmd.out);
+		ret = finish_command(&cmd);
+		if (ret != -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+			return ret;
+	}
+
 	if (stat_config.walltime_run_table)
 		stat_config.walltime_run[run_idx] = t1 - t0;
 
@@ -1032,6 +1213,9 @@ static void sig_atexit(void)
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
 
+	if (stat_config.tpebs_pid != -1)
+		kill(stat_config.tpebs_pid, SIGTERM);
+
 	sigprocmask(SIG_SETMASK, &oset, NULL);
 
 	if (signr == -1)
@@ -2972,5 +3156,7 @@ int cmd_stat(int argc, const char **argv)
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
+	tpebs_data__delete();
+
 	return status;
 }
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 08c4bfbd817f..98e3014c0aef 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -204,7 +204,11 @@ static bool check_pipe(struct perf_data *data)
 				data->file.fd = fd;
 				data->use_stdio = false;
 			}
-		} else {
+		/*
+		 * When is_pipe and data->file.fd is given, use given fd
+		 * instead of STDIN_FILENO or STDOUT_FILENO
+		 */
+		} else if (data->file.fd <= 0) {
 			data->file.fd = fd;
 		}
 	}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 7c24ed768ff3..ae788edef30f 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -68,10 +68,18 @@ struct metric_expr {
 
 struct tpebs_event {
 	struct list_head nd;
+	/* Event name */
 	const char *name;
+	/* Event name with the TPEBS modifier R */
 	const char *tpebs_name;
 };
 
+struct tpebs_retire_lat {
+	struct tpebs_event event;
+	size_t count;
+	int sum;
+};
+
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
 					 bool create);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b987960df3c5..0726bdc06681 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -111,6 +111,8 @@ struct perf_stat_config {
 	struct rblist		 metric_events;
 	struct list_head	 tpebs_events;
 	size_t			 tpebs_event_size;
+	struct list_head	 tpebs_results;
+	pid_t			 tpebs_pid;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
-- 
2.43.0


