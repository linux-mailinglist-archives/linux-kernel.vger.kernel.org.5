Return-Path: <linux-kernel+bounces-111793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A0887110
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC49B22063
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932F5FBB3;
	Fri, 22 Mar 2024 16:42:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E25D903;
	Fri, 22 Mar 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125773; cv=none; b=bQVg8LuzHoI63PC9Q5u8WoyfS8tiJTzsZSFnP/HrZ/AOnlC3QunnLbozTnOCma2H0zDz+wO7zkps/EcWeVBZ5ei38/w9zHdNXNIf4nlbuic2yLY5x7f6bb+3oQ91qKoMs4N3DGuZJwUnxuDC2bryd3u9vLJBk9crYk8LtLF+O6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125773; c=relaxed/simple;
	bh=XQSKmN1TVfytkq7r8tlE3KspdUqFU8nJv4BPKNrYrio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciy6A/TvsquqN/XOefkRZXJIQqM4K721zFtyWFtKOY9jQ0G2dMzaqhBUtuOy5VllF14L+9OZTUlB4KD4KMg5FHmQ/smjAeIrkM1+x1iH3kElH0k/5qf9kz+Auazu2d7tjxTjLOSB9H+jhh2af4mOfAZUgR0uKOlIUHgGbbdRiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BA611042;
	Fri, 22 Mar 2024 09:43:25 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC52C3F762;
	Fri, 22 Mar 2024 09:42:49 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v4 2/4] tools/perf: Track where perf_sample_ids need per-thread periods
Date: Fri, 22 Mar 2024 16:42:35 +0000
Message-ID: <20240322164237.203358-3-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322164237.203358-1-ben.gainey@arm.com>
References: <20240322164237.203358-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_sample_ids and related evlist/evsel code are modified to track
which events combine inherit+inherit_stat+PERF_SAMPLE_READ.

Events with this combination of properties must be handled differently
when tracking each streams sample period, as their stream-id is now only
unique per thread, rather than globally unique.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/lib/perf/evlist.c                 | 1 +
 tools/lib/perf/evsel.c                  | 7 +++++++
 tools/lib/perf/include/internal/evsel.h | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 058e3ff10f9b..c585c49491a5 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -255,6 +255,7 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
 
 	sid->id = id;
 	sid->evsel = evsel;
+	sid->period_per_thread = perf_evsel__attr_has_per_thread_sample_period(evsel);
 	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
 	hlist_add_head(&sid->node, &evlist->heads[hash]);
 }
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c07160953224..dd60ee0557d8 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -537,6 +537,13 @@ void perf_evsel__free_id(struct perf_evsel *evsel)
 	evsel->ids = 0;
 }
 
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel)
+{
+	return (evsel->attr.sample_type & PERF_SAMPLE_READ)
+		&& evsel->attr.inherit
+		&& evsel->attr.inherit_stat;
+}
+
 void perf_counts_values__scale(struct perf_counts_values *count,
 			       bool scale, __s8 *pscaled)
 {
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 5cd220a61962..8dd58149986c 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -36,6 +36,13 @@ struct perf_sample_id {
 
 	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
 	u64			 period;
+
+	/*
+	 * When inherit+inherit_stat is combined with PERF_SAMPLE_READ, the
+	 * period value is per (sample_id, thread) tuple, rather than per
+	 * sample_id.
+	 */
+	bool			 period_per_thread;
 };
 
 struct perf_evsel {
@@ -88,4 +95,6 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__free_id(struct perf_evsel *evsel);
 
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
-- 
2.44.0


