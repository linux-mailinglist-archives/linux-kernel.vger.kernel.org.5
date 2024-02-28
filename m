Return-Path: <linux-kernel+bounces-85335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6C686B462
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF1D1C21680
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BAD16086C;
	Wed, 28 Feb 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SblOj6y+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E715E5A4;
	Wed, 28 Feb 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136762; cv=none; b=n3ezYLyqFOH/HPNXLcueGBoOxhHufc5+XUd+O75HrHbho9sgyUA/GLe5iEgyyi2tbDnDTCXs5vES60rkOvsO6MCAOSFJpegqHrmtlGl86c0wx5skVyv57zpNtNy/u31URfsyBBCpA7gKV/pXFeFGVqRLKisY6MDEmNe22CBo1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136762; c=relaxed/simple;
	bh=Ta9gztUJwuF64cKdtkKgtJr74LNn5xAuP0vQaHyvkD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBDvyWI7VXDxWKEll5H4qzfaZU8wYg6zf/QbeHMLV3GWIfRdLas++IAEYaXTKmXHtpwOTx2JPaxt/CUxMQXsnkkzQeWIf+uV9Z73AFBQJihwZelgkltUdtR71VATPioWdV+G2aU0TsDO+ZrLAneLk5fKFXgBpvxvsI7ZIym4e6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SblOj6y+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136760; x=1740672760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ta9gztUJwuF64cKdtkKgtJr74LNn5xAuP0vQaHyvkD0=;
  b=SblOj6y+0090JfCShbIISJrFpHFUfQOzbXuh1/9deUQhWrfpj5s79pe1
   xyDDRCJiLXqsf07E4K9qAeq4VCafrtFPBiZ0CSHz0WDlwefRH0kEiJZvn
   ig0QHDrK/ucXwiJvvLvJEaSIH3PQzdg7zatZmw+Jt0Q+eFiwU+w2nmyW3
   +lqMdKY/UJBVMpi1RP4SqZ+1o+hVyvrzddI1eDHUNky0Qc/UP6JW4KuUs
   GowCfiJUdKQIuNfGgINtqP4/UEav9QDzVsS5Ch8/vVrkrVA+ClFKqUUqz
   aN1xlNCSEHIPkSzvMGKxq5/ImptW5m04QuKp7rYOPriuSL8EtXJVRZHdL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14185450"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14185450"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7418091"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa010.jf.intel.com with ESMTP; 28 Feb 2024 08:12:37 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v2 2/6] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Wed, 28 Feb 2024 11:12:23 -0500
Message-ID: <20240228161227.484886-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228161227.484886-1-weilin.wang@intel.com>
References: <20240228161227.484886-1-weilin.wang@intel.com>
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
 tools/perf/builtin-stat.c     | 179 +++++++++++++++++++++++++++++++++-
 tools/perf/util/data.c        |   4 +
 tools/perf/util/data.h        |   1 +
 tools/perf/util/metricgroup.h |   7 ++
 tools/perf/util/stat.h        |   3 +
 5 files changed, 191 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5a3093541cff..3890a579349e 100644
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
 
@@ -162,7 +167,8 @@ static struct perf_stat_config stat_config = {
 	.ctl_fd			= -1,
 	.ctl_fd_ack		= -1,
 	.iostat_run		= false,
-	.tpebs_event_size = 0,
+	.tpebs_event_size       = 0,
+	.tpebs_pid              = -1,
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -687,12 +693,163 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	return COUNTER_FATAL;
 }
 
-static int __run_perf_record(void)
+static int __run_perf_record(const char **record_argv)
 {
+	int i = 0;
+	struct tpebs_event *e;
 	pr_debug("Prepare perf record for retire_latency\n");
+
+
+	record_argv[i++] = "perf";
+	record_argv[i++] = "record";
+	record_argv[i++] = "-W";
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
+	struct evswitch		evswitch;
+	struct perf_cpu_map	*cpus;
+	struct perf_thread_map *threads;
+	int			name_width;
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
+static int process_sample_event(struct perf_tool *tool,
+				union perf_event *event __maybe_unused,
+				struct perf_sample *sample,
+				struct evsel *evsel,
+				struct machine *machine __maybe_unused)
+{
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	int ret = 0;
+	const char *evname;
+	struct tpebs_retire_lat *t;
+
+	pr_debug("entering function %s\n ", __func__);
+	evname = evsel__name(evsel);
+
+	pr_debug("[%03d] ", sample->cpu);
+	pr_debug("%*s: ", script->name_width, evname ?: "[unknown]");
+	pr_debug("%16" PRIu16, sample->retire_lat);
+	pr_debug("\n");
+
+	// Need to handle per core results?
+	// We are assuming average retire latency value will be used. Save the number of
+	// samples and the sum of retire latency value for each event.
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
+		.ordered_events	 = true,
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
@@ -709,12 +866,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity saved_affinity, *affinity = NULL;
 	int err;
 	bool second_pass = false;
+	struct child_process cmd;
 
 	//Prepare perf record for sampling event retire_latency before fork and prepare workload
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
 
-		ret = __run_perf_record();
+		pr_debug("perf stat pid = %d\n", getpid());
+		ret = prepare_perf_record(&cmd);
 		if (ret)
 			return ret;
 	}
@@ -924,6 +1083,17 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	t1 = rdclock();
 
+	if (stat_config.tpebs_event_size > 0) {
+		int ret;
+
+		pr_debug("pid = %d\n", getpid());
+		pr_debug("cmd.pid = %d\n", cmd.pid);
+
+		ret = __cmd_script(&cmd);
+		close(cmd.out);
+		pr_debug("%d\n", ret);
+	}
+
 	if (stat_config.walltime_run_table)
 		stat_config.walltime_run[run_idx] = t1 - t0;
 
@@ -2761,6 +2931,7 @@ int cmd_stat(int argc, const char **argv)
 	}
 
 	INIT_LIST_HEAD(&stat_config.tpebs_events);
+	INIT_LIST_HEAD(&stat_config.tpebs_results);
 
 	/*
 	 * Metric parsing needs to be delayed as metrics may optimize events
@@ -2972,5 +3143,7 @@ int cmd_stat(int argc, const char **argv)
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
index 7c24ed768ff3..1fa12cc3294e 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -71,6 +71,13 @@ struct tpebs_event {
 	const char *name;
 	const char *tpebs_name;
 };
+struct tpebs_retire_lat {
+	struct list_head nd;
+	const char *name;
+	const char *tpebs_name;
+	size_t count;
+	int sum;
+};
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b987960df3c5..2387c6289f93 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -111,6 +111,9 @@ struct perf_stat_config {
 	struct rblist		 metric_events;
 	struct list_head	 tpebs_events;
 	size_t			 tpebs_event_size;
+	struct list_head	 tpebs_results;
+	pid_t			 tpebs_pid;
+	int			 tpebs_pipe;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
-- 
2.43.0


