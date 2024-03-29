Return-Path: <linux-kernel+bounces-124860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E451891E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE84B3119C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463214A4F1;
	Fri, 29 Mar 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdqXOVKe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4B14A4F0;
	Fri, 29 Mar 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716307; cv=none; b=B6dc5BFu9TAih5LYSSk3MwLoz7i/+yN4ttSPaBCb0ShfGXEXg2lIARQA2R/w2QCA2u1P2i9rdPAVB+TF8Z8dA6rDZpSQcqCAbHDnY3oTa0Aj231u2sNW65gvoAzpvCTJZyXGbPzTG1zB1rvz+jTl/cB1X33/wCR9BhNQJINLCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716307; c=relaxed/simple;
	bh=+bhG+bNQiJU5XzPc/yaJFh604oaa4JuKFY/3ur8O+SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aylq4y4Fe3D7XbxZFLf3PGQyBvLH3OmX4nZn0TjpUEJx1tQsIu5MvOMimluXLOpNlUPTkTd51RY3iTfDoicCdKWshRN7pjVXDQZVfAfviLWfvndN/iPqq8wR86rV3YzxwfwBDnIVwL8sljvfYMpnZoyfZLAQzJZB/RERfkdb18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdqXOVKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032E0C43390;
	Fri, 29 Mar 2024 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716307;
	bh=+bhG+bNQiJU5XzPc/yaJFh604oaa4JuKFY/3ur8O+SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdqXOVKeX5d3dOtT+J/Z3lvYg8LWrRz11gceu1hcE7AMw7eHgVQ9HqBrRw6AbnJA/
	 7ibnOMB5UvFna3FRC8YG87nqUXXubGIjrxMFX/LJhrBB5eXS6vImYNocqBxqLv58c1
	 UNT+lJoZJcdknna+RE5j0rytE7ki5Ho/cTK2Hb+8XLtwIrl+793C72AhIKBug72Ine
	 kCu85XkCX01nrSJTNfgIOmMMBijVIa6t6J+nHb8fZ5m2CBULDTTjydd7q28WPI/rVt
	 N+t174KVWELyJDfMZ/GAyu4SK7lYmxxTstP9jqU40iJ1Xd1CaHscAIH/1GaPtHvz+3
	 wNi454miUlxsw==
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
Subject: [PATCH AUTOSEL 6.6 51/75] libperf evlist: Avoid out-of-bounds access
Date: Fri, 29 Mar 2024 08:42:32 -0400
Message-ID: <20240329124330.3089520-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index b8b066d0dc5e4..ceb34123f38ed 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -248,10 +248,10 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist)
 
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
@@ -269,21 +269,27 @@ void perf_evlist__reset_id_hash(struct perf_evlist *evlist)
 
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
@@ -312,7 +318,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	id = read_data[id_idx];
 
 add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
 	return 0;
 }
 
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 3339bc2f17655..79e11d71072a0 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -126,11 +126,11 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist);
 
 void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
-			 int cpu, int thread, u64 id);
+			 int cpu_map_idx, int thread, u64 id);
 
 int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 			   struct perf_evsel *evsel,
-			   int cpu, int thread, int fd);
+			   int cpu_map_idx, int thread, int fd);
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
-- 
2.43.0


