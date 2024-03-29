Return-Path: <linux-kernel+bounces-124991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D2891E91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B428728859F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D81B11CF;
	Fri, 29 Mar 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJNaUY9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BF152175;
	Fri, 29 Mar 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716579; cv=none; b=QNWnq1vzVrb6SiHTEnFnHmEF2lBGNqXZBEk9aLmPKCgc5BHwwntGOIIBp/0CuVI8qXNpUt20omtlRCkP4Od3sfZvSh5wosoQ+1nrX0d3Lcb7JWTd0tzrJYvaUtbJyAlCoqc04/Qjr0Y1fjASwehOCkGK9ljWjCvnMxGyGkLPFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716579; c=relaxed/simple;
	bh=1cRpH9u9GcPhAi9FPDgiOS4TNI9gX5GlB4HZJQCMBhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMVqDMVCHl1+sYCmbMmBQPBNQkzRrVFZ005FITdNAKK3riZU4WtjH7s5N52m8bsAvi32k9yPYJgYOCxthg2t8Upw3m2qf4Bkf4RDqINdezY5fUAYYSKoqM1r4bSvTrUU191uCET5D2YXU8NnUB0l8zdXLRs6BHYpsdzQ40F6Nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJNaUY9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E00FC433C7;
	Fri, 29 Mar 2024 12:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716579;
	bh=1cRpH9u9GcPhAi9FPDgiOS4TNI9gX5GlB4HZJQCMBhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJNaUY9xAruBPer8ErYbcvEjRMu0bcXQfBoyTwyRI7EWhPY7KxQHFbw/DLOUVcYHy
	 azQGTM3XceOkQiKYwb4UrGO5TliTxgVH0Ij9UGTBfil6YhTJDTZjcyDkFUiKwfYd2R
	 opU0czl7QRYhyducmOPFfoTp1g0rjnvQGHKByjIx+1ouuEtUaFnt5klIWmjlAMXDor
	 8Mg1WZGq0zcgHTT9qXy9YGOs70M/Hse+fhH0K0j8NEPRNernieuOXncykEnaM+Msid
	 o9/U0O8mwl0c5UViH1X8OZQ7NW6Ua1k7hTXkmcoSPhvt2KFDmUQErnbTUAl9LWHf23
	 2pCU6BDQPuFsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/31] libperf evlist: Avoid out-of-bounds access
Date: Fri, 29 Mar 2024 08:48:37 -0400
Message-ID: <20240329124903.3093161-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit 1947b92464c3268381604bbe2ac977a3fd78192f ]

Parallel testing appears to show a race between allocating and setting
evsel ids. As there is a bounds check on the xyarray it yields a segv
like:

```
AddressSanitizer:DEADLYSIGNAL

=================================================================

==484408==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000010

==484408==The signal is caused by a WRITE memory access.

==484408==Hint: address points to the zero page.

    #0 0x55cef5d4eff4 in perf_evlist__id_hash tools/lib/perf/evlist.c:256
    #1 0x55cef5d4f132 in perf_evlist__id_add tools/lib/perf/evlist.c:274
    #2 0x55cef5d4f545 in perf_evlist__id_add_fd tools/lib/perf/evlist.c:315
    #3 0x55cef5a1923f in store_evsel_ids util/evsel.c:3130
    #4 0x55cef5a19400 in evsel__store_ids util/evsel.c:3147
    #5 0x55cef5888204 in __run_perf_stat tools/perf/builtin-stat.c:832
    #6 0x55cef5888c06 in run_perf_stat tools/perf/builtin-stat.c:960
    #7 0x55cef58932db in cmd_stat tools/perf/builtin-stat.c:2878
..
```

Avoid this crash by early exiting the perf_evlist__id_add_fd and
perf_evlist__id_add is the access is out-of-bounds.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240229070757.796244-1-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/perf/evlist.c                  | 18 ++++++++++++------
 tools/lib/perf/include/internal/evlist.h |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index f76b1a9d5a6e1..53cff32b2cb80 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -226,10 +226,10 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist)
 
 static void perf_evlist__id_hash(struct perf_evlist *evlist,
 				 struct perf_evsel *evsel,
-				 int cpu, int thread, u64 id)
+				 int cpu_map_idx, int thread, u64 id)
 {
 	int hash;
-	struct perf_sample_id *sid = SID(evsel, cpu, thread);
+	struct perf_sample_id *sid = SID(evsel, cpu_map_idx, thread);
 
 	sid->id = id;
 	sid->evsel = evsel;
@@ -239,21 +239,27 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
 
 void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id)
+			 int cpu_map_idx, int thread, u64 id)
 {
-	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
+	if (!SID(evsel, cpu_map_idx, thread))
+		return;
+
+	perf_evlist__id_hash(evlist, evsel, cpu_map_idx, thread, id);
 	evsel->id[evsel->ids++] = id;
 }
 
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd)
+			   int cpu_map_idx, int thread, int fd)
 {
 	u64 read_data[4] = { 0, };
 	int id_idx = 1; /* The first entry is the counter value */
 	u64 id;
 	int ret;
 
+	if (!SID(evsel, cpu_map_idx, thread))
+		return -1;
+
 	ret = ioctl(fd, PERF_EVENT_IOC_ID, &id);
 	if (!ret)
 		goto add;
@@ -282,7 +288,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	id = read_data[id_idx];
 
 add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
 	return 0;
 }
 
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 2d0fa02b036f6..8999f2cc8ee44 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -118,10 +118,10 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist);
 
 void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id);
+			 int cpu_map_idx, int thread, u64 id);
 
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd);
+			   int cpu_map_idx, int thread, int fd);
 
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
-- 
2.43.0


