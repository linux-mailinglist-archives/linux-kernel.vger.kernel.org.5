Return-Path: <linux-kernel+bounces-119920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24288CEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14072340D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61113F43B;
	Tue, 26 Mar 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vh13vB4I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9313E8A9;
	Tue, 26 Mar 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484977; cv=none; b=SCX+fyUiJkVeN4kpkBtQTIY1JvpU4VGfZSuojKnWbLTnABV3zyPp6YqTfq+91ZivwZ94IRzp37pFmXefxPeeT8A4QvUOc1qTyEnn+Y2PWZwY3F3jGT8HAPBAEbKs7C0QO6mVlDmp4SGOx5ijZTj7xkGaN78hPVIkfIGM4uXGWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484977; c=relaxed/simple;
	bh=xc5yF7aEZ82AsxqVeMtBK8AhZ0k+kXs7uT8/9ReSDjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXlEZlXsmR+v+Wfuop1cwqNNtuhG6ORsd7M8t891lU02t69mVyLe1ewDSzc9KUdXBbUQuT1g55MtqBiZxjc+/mcacm9jGBXgzIdbce8+kCgzLDrEs4McLZww5QVyR3r2Sw2wb8v6KW3RO6xjSju38akUEqoVUPot9PuaPVBi/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vh13vB4I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484975; x=1743020975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xc5yF7aEZ82AsxqVeMtBK8AhZ0k+kXs7uT8/9ReSDjA=;
  b=Vh13vB4IPmsbMdqIpBVruJNpL/ZENvKw7ILRH792OeKDTPopM/Jlz37J
   IJ5BIJDAZ1j3tPF5C7wu5sOr15ysbZsCtmLURweUhZFi57qQo4kgW5wNu
   /gUQCGIJp8IIMbdBs0RpXHWpL7XmVb9SgC6GYouRfGRa5Ta5OQikW0pZw
   DZyoFEIzMcYrbnJBLAY/wd26FQ2qmd1G1rczj8x/9UArq4hkOYpAKynsh
   5M84ckgbCw0HPtN9nQPccI/UcP5+iCfIsFfOagYmZxYI3BuWLAaPzQR28
   2/E4axQNubt5q1LPfMOskkdg65tiQDuYKmIENp41HOjlyWtdCVg5D+ZZh
   g==;
X-CSE-ConnectionGUID: ZqcyUTIyQzuHQcFQ0q4SKA==
X-CSE-MsgGUID: saHi1meDRv6o+lMPgNrFQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24049095"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24049095"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16163019"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa008.fm.intel.com with ESMTP; 26 Mar 2024 13:29:33 -0700
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
Subject: [RFC PATCH v5 4/6] perf stat: Create another thread for sample data processing
Date: Tue, 26 Mar 2024 16:28:57 -0400
Message-ID: <20240326202859.960577-5-weilin.wang@intel.com>
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

Another thread is required to synchronize between perf stat and perf record
when we pass data through pipe.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 51 +++++++++++++++++++++--------------
 tools/perf/util/stat-shadow.c |  4 +--
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fc887d9aaa66..14488cb0cfc8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -802,9 +802,9 @@ static int process_feature_event(struct perf_session *session,
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
@@ -819,29 +819,15 @@ static int __cmd_script(struct child_process *cmd __maybe_unused)
 		.attr		 = perf_event__process_attr,
 		},
 	};
-	struct tpebs_event *e;
-
-	list_for_each_entry(e, &stat_config.tpebs_events, nd) {
-		struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
 
-		if (!new)
-			return -1;
-		new->event.name = strdup(e->name);
-		new->event.tpebs_name = strdup(e->tpebs_name);
-		new->count = 0;
-		new->sum = 0;
-		list_add_tail(&new->event.nd, &stat_config.tpebs_results);
-	}
-
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
@@ -861,16 +847,37 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int err;
 	bool second_pass = false;
 	struct child_process cmd;
+	pthread_t thread_script;
 
 	/* Prepare perf record for sampling event retire_latency before fork and
 	 * prepare workload */
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
+		struct tpebs_event *e;
 
 		pr_debug("perf stat pid = %d\n", getpid());
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
 		ret = prepare_perf_record(&cmd);
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
@@ -1081,8 +1088,12 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (stat_config.tpebs_event_size > 0) {
 		int ret;
 
-		ret = __cmd_script(&cmd);
+		kill(cmd.pid, SIGTERM);
+		pthread_join(thread_script, NULL);
 		close(cmd.out);
+		ret = finish_command(&cmd);
+		if (ret != -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+			return ret;
 	}
 
 	if (stat_config.walltime_run_table)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8fc3415de106..bc77e9e02892 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -361,8 +361,8 @@ static int prepare_retire_lat(struct expr_parse_ctx *pctx,
 	int ret = 0;
 	struct tpebs_retire_lat *t;
 
-	list_for_each_entry(t, retire_lats, nd) {
-		ret = expr__add_id_val(pctx, strdup(t->tpebs_name), t->val);
+	list_for_each_entry(t, retire_lats, event.nd) {
+		ret = expr__add_id_val(pctx, strdup(t->event.tpebs_name), t->val);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.43.0


