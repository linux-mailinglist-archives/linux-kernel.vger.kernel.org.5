Return-Path: <linux-kernel+bounces-89253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8180286ED41
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52DB1C21901
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8F8C15;
	Sat,  2 Mar 2024 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVCnQ9xp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33251854;
	Sat,  2 Mar 2024 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338312; cv=none; b=gCRoHy7x90YFSYR0xWJKqO2V/NANDu5Me5Hid5sob8Vm90KMigFTIzFrK7QisVWPn/eQnTLidA/x61weJJq21qBP9xmNZijxn+W/+Y1NieGfUmsNoZ2dYC3bW5S+Yx0Uj0CV78i77XXXy5ujAb+e+VIjaHN7T82ORqGJCfddByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338312; c=relaxed/simple;
	bh=WvnrJC58zvSrxJ8X4Aj5CwSK0eSjYIRrEgdXF3P5wG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP4PdnAFL8uBJffXpUhyZlUuah8RhQchltqF0f2CYlViszsoe1IgNWecws4kWmyUT4QsAh/49NKyVwuJz53PgAl3ou1Jk745ZgkWpCqs1fgr2t3Xqia0RkyDNpK4xI4Am2Y1k4/bXhmXuoczYwahpRl/0f0OJsc8Y8Q+bVNKQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVCnQ9xp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338311; x=1740874311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvnrJC58zvSrxJ8X4Aj5CwSK0eSjYIRrEgdXF3P5wG4=;
  b=EVCnQ9xpY0zRuQ38QJ6Nq6/H/ejzkbT6ozO9xTFtEtuQXUnQnJkc6K/j
   JNg6xVb8NeoOsiNQT1QOddq9gZVpV9kaYMBQh215Djx+FcwCwsSOidYCl
   rwZtZlg/V7scq0GQucDL+hNpeR/oLo9S6Q/GIVk5u2wUFBkSKyjObQAVB
   VdLdoFDajmlrd9feFjDGomMu5+kyMSHefXM3rAfE0ZISBihdC3RKQnhvi
   7jWJhdY1JImrPm01Bz6+/woCaYAauvIa+u8y4Rg/vzlxwBeCeYFVc+oGa
   4o6pDi3QNz/sGhznng3qw/ikCom+zohQDKuFumBtvtgl7m4QCLBUFgOJu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4476153"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="4476153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="13054645"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 16:11:46 -0800
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
Subject: [RFC PATCH v3 4/6] perf stat: Create another thread for sample data processing
Date: Fri,  1 Mar 2024 19:11:36 -0500
Message-ID: <20240302001139.604829-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302001139.604829-1-weilin.wang@intel.com>
References: <20240302001139.604829-1-weilin.wang@intel.com>
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


