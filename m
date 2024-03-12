Return-Path: <linux-kernel+bounces-100932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD14879FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6156F1F22607
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD551010;
	Tue, 12 Mar 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+Li7eUo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65647796;
	Tue, 12 Mar 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287377; cv=none; b=i/IPzyYm1oHdzBFT5UTKeWzY30vOG3Ot9ClCGLZvly+jRiNhDwkt0WJ/P9CipJcQLu+jHangW1Bf4w/gr4aO6Zc4JX7wij9kVAyTkl8LsQZGuqMv9QKx3k32uZpcYUcUkfv2V/vUNQxYNzx7jfm8QBJtcIoa+Pxj3Ptzor1ToTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287377; c=relaxed/simple;
	bh=6Mj8hdj114yQ7jMfCFUKSlImUfTm0d75fiRzzNPci2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUuVo6FYBxNeaABydehNaY77zwkzDdImaWepJHLWTN4oNy3dDSBg8vo80xefS7WnWGGvI1eh51pADEh5aByeq7OxC+CbzzRroZg1LEiH4jpKwJSU4IcTvLPDFJtlP9NaBZaVTNe/n2q0NBuftKqrOps0O6TmiG3rxqv6AhJsm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+Li7eUo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710287376; x=1741823376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Mj8hdj114yQ7jMfCFUKSlImUfTm0d75fiRzzNPci2M=;
  b=e+Li7eUozKVQZzfDLDCUDv5XEb5dG5HE24MI0jks3YGPNNXbPhMIlb6j
   oHijvd6KJexMZTWs89dfI7nrAS9DOloBHI6DLV05QnC//SKu08n2k2Wft
   HoEQCY3UFGALSVKosUzLx4nzaENZiZUWyWNqcXRqmFdYnnvcrgc2QlKZZ
   7WCaqkresbX1ZChGonbusClTBYZUknKpqYK3r29UrnIOzbezcNvuX3x12
   BtddaN9OmQUkZhsq/Pq3LvjPaTZ4dxlJHBP/HGkxLYd38qESZYYiqy5kY
   cm6tswm0fxPCWOw6gToZdjycT1DSwaBqAVUCl+0agkOBZH0wIOHCK9auK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8847694"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8847694"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 16:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42715675"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2024 16:49:33 -0700
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
Subject: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Tue, 12 Mar 2024 19:49:17 -0400
Message-ID: <20240312234921.812685-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312234921.812685-1-weilin.wang@intel.com>
References: <20240312234921.812685-1-weilin.wang@intel.com>
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
---
 tools/perf/builtin-stat.c     | 165 +++++++++++++++++++++++++++++++++-
 tools/perf/util/data.c        |   4 +
 tools/perf/util/data.h        |   1 +
 tools/perf/util/metricgroup.h |  12 +++
 tools/perf/util/stat.h        |   2 +
 5 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6291e1e24535..4e92e73cbeaf 100644
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
+	list_for_each_entry_safe(r, rtmp, &stat_config.tpebs_results, nd) {
+		list_del_init(&r->nd);
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
+	list_for_each_entry(t, &stat_config.tpebs_results, nd) {
+		if (!strcmp(evname, t->name)) {
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
+		new->name = strdup(e->name);
+		new->tpebs_name = strdup(e->tpebs_name);
+		new->count = 0;
+		new->sum = 0;
+		list_add_tail(&new->nd, &stat_config.tpebs_results);
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
index 08c4bfbd817f..2e2a20fc5c30 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -185,6 +185,10 @@ static bool check_pipe(struct perf_data *data)
 	int fd = perf_data__is_read(data) ?
 		 STDIN_FILENO : STDOUT_FILENO;
 
+	if (data->fd > 0) {
+		fd = data->fd;
+	}
+
 	if (!data->path) {
 		if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
 			is_pipe = true;
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 110f3ebde30f..720638116ca0 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -28,6 +28,7 @@ struct perf_data_file {
 
 struct perf_data {
 	const char		*path;
+	int			 fd;
 	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 is_dir;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 7c24ed768ff3..3c37d80c4d34 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -68,10 +68,22 @@ struct metric_expr {
 
 struct tpebs_event {
 	struct list_head nd;
+	/* Event name */
 	const char *name;
+	/* Event name with TPEBS modifier */
 	const char *tpebs_name;
 };
 
+struct tpebs_retire_lat {
+	struct list_head nd;
+	/* Event name */
+	const char *name;
+	/* Event name with TPEBS modifier */
+	const char *tpebs_name;
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


