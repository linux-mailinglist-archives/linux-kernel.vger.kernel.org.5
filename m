Return-Path: <linux-kernel+bounces-115460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC7889BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404DC29E72D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B3A21C97A;
	Mon, 25 Mar 2024 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkVfJvi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE21DB07B;
	Sun, 24 Mar 2024 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320848; cv=none; b=TypAa94zVwiN4BBXrFZkVUm2tihA10frIk2w6oG1aOBczB32osH/kfBt8w7Jc5XGtJNwnbctbbN5YNhHlqBl6JrBrccseFQAhx0ZWbLFtX/D0D6/UtfbwTGNjCMBhI5191M9jYNPSKlbGa8NQnw8lg6PVO7fgPQ9eJEtHp6emmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320848; c=relaxed/simple;
	bh=YC+hLjCMjaUaMXvnrxNFhbGXRLikqY4VpstIXEgX6pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZQrGTx33FcVm3QvKdKeDWNXuRVck0VOLUWJVU/IE1i24yMIuGxYDIa7qxdRP2qVuv0+e1EG6UIGYgGWhAHi1Dh6Prn/XO09P6tAdZYp/d//2uDrW16fLQHIShkgeG1JfnkI6kJmUIC4LErngrnn/TJgF9qfaVfzg8hrhd8n/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkVfJvi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156C6C433C7;
	Sun, 24 Mar 2024 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320847;
	bh=YC+hLjCMjaUaMXvnrxNFhbGXRLikqY4VpstIXEgX6pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkVfJvi0twvu80YiRlQxb+8hQibBiBP5QqiP3c+juy4gZM7/QaKPJaGcdoVVqNoOt
	 FfdPH3jNZfmPWZRrxTgu0eUciuwxFkATvo+4J0QtHjWkwWlf5OGGbFW9g8SdsA2aLa
	 x9JWb20Z+d2d2o3cS7PzdoJyUHarjvOaM+GqEY5yL2lIlTudIzYndYJdVDKnxq2j6T
	 qaAh0T6JeKi1/F+/fvyoaxnmcjx0JMf2mvERj9J1tBwh+QQCDkNYP8ksUh5PuSQrTy
	 UjZrnbUvUrkKzr5HOd2EYwxdfCa4/gLK4xYtAHeVj4cmq66WYSFzvlqccEzTJSpyuo
	 5iwT/l5e274tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 412/713] perf top: Uniform the event name for the hybrid machine
Date: Sun, 24 Mar 2024 18:42:18 -0400
Message-ID: <20240324224720.1345309-413-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit a61f89bf76ef6f87ec48dd90dbc73a6cf9952edc ]

It's hard to distinguish the default cycles events among hybrid PMUs.
For example,

  $ perf top
  Available samples
  385 cycles:P
  903 cycles:P

The other tool, e.g., perf record, uniforms the event name and adds the
hybrid PMU name before opening the event. So the events can be easily
distinguished. Apply the same methodology for the perf top as well.

The evlist__uniquify_name() will be invoked by both record and top.
Move it to util/evlist.c

With the patch:

  $ perf top
  Available samples
  148 cpu_atom/cycles:P/
  1K cpu_core/cycles:P/

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20231214144612.1092028-2-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 02f9b50e0481 ("perf record: Check conflict between '--timestamp-filename' option and pipe mode before recording")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-record.c | 28 +---------------------------
 tools/perf/builtin-top.c    |  1 +
 tools/perf/util/evlist.c    | 25 +++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fa13479ed73d6..b7f8c94d052d0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2216,32 +2216,6 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
 	}
 }
 
-static void record__uniquify_name(struct record *rec)
-{
-	struct evsel *pos;
-	struct evlist *evlist = rec->evlist;
-	char *new_name;
-	int ret;
-
-	if (perf_pmus__num_core_pmus() == 1)
-		return;
-
-	evlist__for_each_entry(evlist, pos) {
-		if (!evsel__is_hybrid(pos))
-			continue;
-
-		if (strchr(pos->name, '/'))
-			continue;
-
-		ret = asprintf(&new_name, "%s/%s/",
-			       pos->pmu_name, pos->name);
-		if (ret) {
-			free(pos->name);
-			pos->name = new_name;
-		}
-	}
-}
-
 static int record__terminate_thread(struct record_thread *thread_data)
 {
 	int err;
@@ -2475,7 +2449,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe && rec->evlist->core.nr_entries == 1)
 		rec->opts.sample_id = true;
 
-	record__uniquify_name(rec);
+	evlist__uniquify_name(rec->evlist);
 
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eeed..8d7c31bd2ebfc 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1299,6 +1299,7 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	evlist__uniquify_name(top->evlist);
 	ret = perf_top__start_counters(top);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b0ed14a6da9d4..eb1dd29c538d5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2525,3 +2525,28 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 	}
 	perf_cpu_map__put(user_requested_cpus);
 }
+
+void evlist__uniquify_name(struct evlist *evlist)
+{
+	struct evsel *pos;
+	char *new_name;
+	int ret;
+
+	if (perf_pmus__num_core_pmus() == 1)
+		return;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (!evsel__is_hybrid(pos))
+			continue;
+
+		if (strchr(pos->name, '/'))
+			continue;
+
+		ret = asprintf(&new_name, "%s/%s/",
+			       pos->pmu_name, pos->name);
+		if (ret) {
+			free(pos->name);
+			pos->name = new_name;
+		}
+	}
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 98e7ddb2bd305..cb91dc9117a27 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -442,5 +442,6 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
+void evlist__uniquify_name(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
-- 
2.43.0


