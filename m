Return-Path: <linux-kernel+bounces-124958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2955891E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064A61C20F55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC951AA2F7;
	Fri, 29 Mar 2024 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdI5WHf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB11AA2E3;
	Fri, 29 Mar 2024 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716510; cv=none; b=rS3hR+AeXJFEU+yD6sl/uFiQkxX0zU+0EdXU/z/mjJUSd2nBSj/ZB7ttskqkjCY0OcQeQ9ZBABF0ilJPIUWJhiTwLJeekj2mkdPvMSVjocgrvwiIGEkXzZgv9cnJjYW+NnOMb/wIHW+sacQ5bhTWogl7HfvDvs92f4hkDxMbx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716510; c=relaxed/simple;
	bh=VKEh8WoAVQm91ORr+Wi6O1sNZ5hN6y39we68l0cN8sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBjZGVboHrGXMmEtBEKle2swCciFEMtxvreqvRoyWv1gErHd8xnUFD9j4v77fSFW+mDMI1L2EU6V8Hb7P8LkTlq6YS3ke7DnlsIgrO7XlGEpgAefdlq0bx5jaTdiMJkhzKFBTQD1qzXTK63j+r0qBXcusqzdNmjQZ7vWf5pfZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdI5WHf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2657C43390;
	Fri, 29 Mar 2024 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716510;
	bh=VKEh8WoAVQm91ORr+Wi6O1sNZ5hN6y39we68l0cN8sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdI5WHf/tlX7ikbqVSaJ0rRYhdoYJf55Vq+dtS6ldj92S5vDreG6+b4GA+hobRKrf
	 zE15BJSHzfaV6n8oGCwo+vXDe3WE+loZhgnwx/raZY6n8jD/U57LLXVUEl84OdiyAN
	 scBSlts86ElrEaQXFuZqrlfEJJVL2qmON33EOh5mFo9OIru4gmrXYCb+wheE2Kclv7
	 2Ns1hNxnarR4BJcaZlI7e81TMsBiAgo2I3+MHmq83EmwH5XtxXbHjKPSaHTcusMdcz
	 YkF98+ec92jqItfGMFskzSRF+DM/KOn/m41+wJSYdS9YkJvPKyjGBtEwVbcs9icsB2
	 8h/TYm/TOC27A==
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
Subject: [PATCH AUTOSEL 5.15 22/34] libperf evlist: Avoid out-of-bounds access
Date: Fri, 29 Mar 2024 08:47:23 -0400
Message-ID: <20240329124750.3092394-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 5146ff0fa078c..6aa1c35273a18 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -224,10 +224,10 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist)
 
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
@@ -245,21 +245,27 @@ void perf_evlist__reset_id_hash(struct perf_evlist *evlist)
 
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
@@ -288,7 +294,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 	id = read_data[id_idx];
 
 add:
-	perf_evlist__id_add(evlist, evsel, cpu, thread, id);
+	perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
 	return 0;
 }
 
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index f366dbad6a88c..49b17b2b3923f 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -119,11 +119,11 @@ u64 perf_evlist__read_format(struct perf_evlist *evlist);
 
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


