Return-Path: <linux-kernel+bounces-119918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43E88CEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F909340AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B134713F423;
	Tue, 26 Mar 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZV+rZ7N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65813E6C5;
	Tue, 26 Mar 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484976; cv=none; b=TPZlJiPEGk5QDmwawDpKFYFARx1Izuqb2OjJ3jraeetHA5ifVXj1kHrivFtqQSPwkPw7KA83RXWsCqCNsXXofjD4vsEuWgMWAy4HMvqDWyNLIeRXFrvCmrCxTdwCMNIgE21JEAEh7DBtCtDtJ95oW9H0J5VdlpxUMU/An9BaNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484976; c=relaxed/simple;
	bh=8QSlXwXE82GjnjLYjblNlU8b7WFrgBAOd0ZAaHGIkGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2IoDdHHuqIe/Uv3uPGIYRA30TW9X4RmsPsyy8zDDPJrJnWTOUarBuVgdmRYX9eARhVXI2j2l7004FkjQCiScICRe5y+yj7Q1hP0Jzmn/rcrMKVTCDpgOLGV2nL6e27tQAnIWAi1EyI/Ha5D/G0Is67tr+3w78+CF4wv7xnGUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZV+rZ7N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484974; x=1743020974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8QSlXwXE82GjnjLYjblNlU8b7WFrgBAOd0ZAaHGIkGc=;
  b=fZV+rZ7N0/rADpkeDR5T609l9p4SZkAhjgWdWpoMj+Qainu8Jbl0Mthn
   F7zGW98ZjMzG2AEBqP6DhmIakECxvYcfSfkopYAQsxqNPcuWRgAlcvZrS
   pE6TTFKcOv0Z9twz4zQlErQQibX5x3U5HfHY6a7F9B27eW3ls+YoE1mm/
   xDEZ9ebXr6Chu+CN/ECm2MtL+L82xxjbQvmqscF4yxZIyHhq9XsCJuo53
   T61mwloKltRspk3LJUqJN2C8ZmYYvTUEV0egx1TXGUTLH1d/kamOg94lW
   quIgxehkIvSgQsox9fuwWxhLKvv2YD0xFS4Uh9KTuQMAbBW2ITP4MXb+F
   w==;
X-CSE-ConnectionGUID: a8gEr9FOTFyhVhcXM2ZGXQ==
X-CSE-MsgGUID: Pb2mI8I8Shu1Y2aKc2pUKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24049082"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24049082"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16163004"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa008.fm.intel.com with ESMTP; 26 Mar 2024 13:29:32 -0700
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
Subject: [RFC PATCH v5 2/6] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Tue, 26 Mar 2024 16:28:55 -0400
Message-ID: <20240326202859.960577-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326202859.960577-1-weilin.wang@intel.com>
References: <20240326202859.960577-1-weilin.wang@intel.com>
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

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 165 +++++++++++++++++++++++++++++++++-
 tools/perf/util/data.c        |   3 +
 tools/perf/util/data.h        |   5 ++
 tools/perf/util/metricgroup.h |   8 ++
 tools/perf/util/stat.h        |   2 +
 5 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6291e1e24535..fb08cef42d95 100644
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
@@ -687,12 +694,155 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
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
+
+	record_argv = calloc(10 + 2 * stat_config.tpebs_event_size, sizeof(char *));
+	if (!record_argv)
+		return -1;
+	__run_perf_record(record_argv);
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
+static int __cmd_script(struct child_process *cmd __maybe_unused)
+{
+	int err = 0;
+	struct perf_session *session;
+	struct perf_data data = {
+		.mode = PERF_DATA_MODE_READ,
+		.path = PERF_DATA,
+		.fd   = cmd->out,
+	};
+	struct perf_script script = {
+		.tool = {
+		.sample		 = process_sample_event,
+		.ordering_requires_timestamps = true,
+		.feature	 = process_feature_event,
+		.attr		 = perf_event__process_attr,
+		},
+	};
+	struct tpebs_event *e;
+
+	list_for_each_entry(e, &stat_config.tpebs_events, nd) {
+		struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
+
+		if (!new)
+			return -1;
+		new->event.name = strdup(e->name);
+		new->event.tpebs_name = strdup(e->tpebs_name);
+		new->count = 0;
+		new->sum = 0;
+		list_add_tail(&new->event.nd, &stat_config.tpebs_results);
+	}
+
+	kill(cmd->pid, SIGTERM);
+	session = perf_session__new(&data, &script.tool);
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+	script.session = session;
+	err = perf_session__process_events(session);
+	perf_session__delete(session);
+
+	return err;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -709,13 +859,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity saved_affinity, *affinity = NULL;
 	int err;
 	bool second_pass = false;
+	struct child_process cmd;
 
 	/* Prepare perf record for sampling event retire_latency before fork and
 	 * prepare workload */
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
 
-		ret = __run_perf_record();
+		pr_debug("perf stat pid = %d\n", getpid());
+		ret = prepare_perf_record(&cmd);
 		if (ret)
 			return ret;
 	}
@@ -925,6 +1077,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	t1 = rdclock();
 
+	if (stat_config.tpebs_event_size > 0) {
+		int ret;
+
+		ret = __cmd_script(&cmd);
+		close(cmd.out);
+	}
+
 	if (stat_config.walltime_run_table)
 		stat_config.walltime_run[run_idx] = t1 - t0;
 
@@ -2972,5 +3131,7 @@ int cmd_stat(int argc, const char **argv)
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
+	tpebs_data__delete();
+
 	return status;
 }
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 08c4bfbd817f..f6cc0ccdec5e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -185,6 +185,9 @@ static bool check_pipe(struct perf_data *data)
 	int fd = perf_data__is_read(data) ?
 		 STDIN_FILENO : STDOUT_FILENO;
 
+	if (data->fd > 0)
+		fd = data->fd;
+
 	if (!data->path) {
 		if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
 			is_pipe = true;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 110f3ebde30f..f5e7479f1892 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -28,6 +28,11 @@ struct perf_data_file {
 
 struct perf_data {
 	const char		*path;
+	/*
+	 * When fd is given, use PIPE instead of file, use given fd instead of
+	 * STDIN_FILENO or STDOUT_FILENO
+	 */
+	int			 fd;
 	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 is_dir;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 7c24ed768ff3..e5bafb45d4d9 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -68,10 +68,18 @@ struct metric_expr {
 
 struct tpebs_event {
 	struct list_head nd;
+	/* Event name */
 	const char *name;
+	/* Event name with TPEBS modifier */
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


