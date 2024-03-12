Return-Path: <linux-kernel+bounces-100934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CC879FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BFC1F22844
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F05339D;
	Tue, 12 Mar 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAlBYprG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B64C601;
	Tue, 12 Mar 2024 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287378; cv=none; b=f4Rb5CNIgXjq4SSrp7KZkUInDjdb6p4Iou4afTa6R2LfgoRLLJGfnAjgcySYC08uEp7QK08bOZHQM/5daB2WfC3CIcplBUKWWa3u0J31tibIE9yr0mDU5HQSwdBz9pYkX1wmkyVZOpXWfN+l2lcr0cABdQQE8shsppQO8zlOYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287378; c=relaxed/simple;
	bh=oxThtY1gcQW4Q5Ky3+oH9K5IkZkut/xl3+hGLb0FneE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py77GxHoP0VhqHVbxD5TE2BpxqqsBLZlAHdBSpYZwCDW3CiTHSiHRdkYHTCmjrNxxc3u4HrxR5tDnXBKIisGBSPms2+60GHqCz/jrfsG5wNbnltviywA33wc8k3IAh2GmCcAbOObKlUCj8yMW6c/UzBf2l7yIZR+0K7L/aPBb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAlBYprG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710287377; x=1741823377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxThtY1gcQW4Q5Ky3+oH9K5IkZkut/xl3+hGLb0FneE=;
  b=YAlBYprGBKevz/FXgeBiPrLgI+ynPmDjXlov+ogup+A9BRwzJ2mm4e37
   aw7NmCVVu5HoHhaq+l9T1Y+XHoFF2QSuNMSRuLw7RZ8yictrw0xJE+db3
   I5jkA4sEflq/JF1+NmEZPZoKSyDn8Xd0GqC9znX1A5v88YiK1cvYeYq/8
   AW4LFnqO9HiHzIoe+ckRu7UyRWoAlHc6KtL0T+UP7F3rE8RGShAlbC06c
   VJ95HsODEClKRoFLl7+lAQr3PQBR8tRO9LbvVMoYyMWScMdmPLZ57Xu+r
   jV9OtLIcmHv8dWM6OTCjlIHsZPqQygaEmzrYEW6mwiiJQ5oiE7j+niEAo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8847704"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8847704"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 16:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42715685"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2024 16:49:34 -0700
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
Subject: [RFC PATCH v4 4/6] perf stat: Create another thread for sample data processing
Date: Tue, 12 Mar 2024 19:49:19 -0400
Message-ID: <20240312234921.812685-5-weilin.wang@intel.com>
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

Another thread is required to synchronize between perf stat and perf record
when we pass data through pipe.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c | 51 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a479b21874b0..527a25363e42 100644
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
-		new->name = strdup(e->name);
-		new->tpebs_name = strdup(e->tpebs_name);
-		new->count = 0;
-		new->sum = 0;
-		list_add_tail(&new->nd, &stat_config.tpebs_results);
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
+			new->name = strdup(e->name);
+			new->tpebs_name = strdup(e->tpebs_name);
+			new->count = 0;
+			new->sum = 0;
+			list_add_tail(&new->nd, &stat_config.tpebs_results);
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
-- 
2.43.0


