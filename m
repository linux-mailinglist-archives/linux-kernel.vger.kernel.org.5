Return-Path: <linux-kernel+bounces-85337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36C86B464
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE941F260AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322D161B7B;
	Wed, 28 Feb 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTzuCS1v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409D15D5CF;
	Wed, 28 Feb 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136764; cv=none; b=NwxmKzYSh7TC7BChMNKW/q7BDjhBTyifLWWVf/1Fd4qARbmEsVjUCRad/DX8HXOsmYl1THVOFlgwDtW8jfFkn8NSfBRZ9EHGujVn+w1jSLMtn7iYYe3C/nWnUTUnAUyE/gArKuQtgzCWVAwy6Y9kwgk4y1d2wnrlbG1tUQq4Y5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136764; c=relaxed/simple;
	bh=WvnrJC58zvSrxJ8X4Aj5CwSK0eSjYIRrEgdXF3P5wG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBuOy2WSZnzN/ba2xGx1te7XLZnkSd/oNMblxSTlMq0vJ57steFmF1EVUlXRBqexohZdJEwEFDm61HxIlwcCw5aoQJl1am7KOYGPDOqF0rUEfkKH+u70F5mqxEMRA2A/bZJx66LT2F9uRzKBCsiWsZBb6YABIB5R8Xwc2jQa0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTzuCS1v; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136762; x=1740672762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvnrJC58zvSrxJ8X4Aj5CwSK0eSjYIRrEgdXF3P5wG4=;
  b=OTzuCS1vASo1Ri5cT4PvjoHYWnday7PhiJCE+QdKM/yV0kUXxeH5xorf
   BCLXZKVtQh3IqQsVRP/hJgqJUvuduKfkJvOi8q/4rgbNUXr3fJTy+BWbP
   AHj2ViOaN5OdJ158iAAhS5xpEUSZpp0aEeI3s3/XqAryCe9xNZM7egkvB
   R0GBTOVjGW6P8OB3fKpNZ6WTpIq9swBKE9VY7tAn6ScJ9CQlV/xMvmA+Q
   tYdF0DYu9zg9fpxy5Rn/Q+bOtayWioU0KE3DuAef5U1oipiX4UuZgXDbW
   Tus665eOQTEQsTidQezdRiRPg28qwoRVbmnZfZVE6Hr6sxQtyMyIgYxRu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14185460"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14185460"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7418101"
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
Subject: [RFC PATCH v2 4/6] perf stat: Create another thread for sample data processing
Date: Wed, 28 Feb 2024 11:12:25 -0500
Message-ID: <20240228161227.484886-5-weilin.wang@intel.com>
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

Another thread is required to synchronize between perf stat and perf record
when we pass data through pipe.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c | 58 +++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3e5865572266..2372175d3408 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -777,7 +777,6 @@ static int process_sample_event(struct perf_tool *tool,
 	const char *evname;
 	struct tpebs_retire_lat *t;
 
-	pr_debug("entering function %s\n ", __func__);
 	evname = evsel__name(evsel);
 
 	pr_debug("[%03d] ", sample->cpu);
@@ -808,9 +807,9 @@ static int process_feature_event(struct perf_session *session,
 	return 0;
 }
 
-static int __cmd_script(struct child_process *cmd __maybe_unused)
+static void *__cmd_script(void *arg __maybe_unused)
 {
-	int err = 0;
+	struct child_process *cmd = arg;
 	struct perf_session *session;
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
@@ -826,29 +825,15 @@ static int __cmd_script(struct child_process *cmd __maybe_unused)
 		.attr		 = perf_event__process_attr,
 		},
 	};
-	struct tpebs_event *e;
-
-	list_for_each_entry(e, &stat_config.tpebs_events, nd) {
-		struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
-
-		if (!new)
-			return -1;
-		new->name = strdup(e->name);
-		new->tpebs_name = strdup(e->tpebs_name);
-		new->count = 0;
-		new->sum = 0;
-		list_add_tail(&new->nd, &stat_config.tpebs_results);
-	}
 
-	kill(cmd->pid, SIGTERM);
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return NULL;
 	script.session = session;
-	err = perf_session__process_events(session);
+	perf_session__process_events(session);
 	perf_session__delete(session);
 
-	return err;
+	return NULL;
 }
 
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
@@ -868,15 +853,37 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int err;
 	bool second_pass = false;
 	struct child_process cmd;
+	pthread_t thread_script;
 
 	//Prepare perf record for sampling event retire_latency before fork and prepare workload
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
 
+		struct tpebs_event *e;
 		pr_debug("perf stat pid = %d\n", getpid());
 		ret = prepare_perf_record(&cmd);
 		if (ret)
 			return ret;
+
+		list_for_each_entry(e, &stat_config.tpebs_events, nd) {
+			struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
+
+			if (!new)
+				return -1;
+			new->name = strdup(e->name);
+			new->tpebs_name = strdup(e->tpebs_name);
+			new->count = 0;
+			new->sum = 0;
+			list_add_tail(&new->nd, &stat_config.tpebs_results);
+		}
+
+		if (pthread_create(&thread_script, NULL, __cmd_script, &cmd)) {
+			kill(cmd.pid, SIGTERM);
+			close(cmd.out);
+			pr_err("Could not create thread to process sample data.\n");
+			return -1;
+		}
+		sleep(2);
 	}
 
 	if (forks) {
@@ -1087,12 +1094,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
 
-		pr_debug("pid = %d\n", getpid());
-		pr_debug("cmd.pid = %d\n", cmd.pid);
+		pr_debug("Workload finished, finishing record\n");
+		pr_debug("Perf stat pid = %d, Perf record pid = %d\n", getpid(), cmd.pid);
 
-		ret = __cmd_script(&cmd);
+		kill(cmd.pid, SIGTERM);
+		pthread_join(thread_script, NULL);
 		close(cmd.out);
-		pr_debug("%d\n", ret);
+		ret = finish_command(&cmd);
+		if (ret != -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+			return ret;
 	}
 
 	if (stat_config.walltime_run_table)
-- 
2.43.0


