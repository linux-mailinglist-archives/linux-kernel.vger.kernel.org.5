Return-Path: <linux-kernel+bounces-144745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0478A4A23
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA2A1C22C40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED33FBB8;
	Mon, 15 Apr 2024 08:15:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421383D969;
	Mon, 15 Apr 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168903; cv=none; b=Ay8QL0ywEOt2f3k6Sr3cefVSMlNpOS9PPq8P6bdW8uxBuBCSmMAzdP3MoyjRCmI75/ilYlR+kZGjo8bU7Pz1jjzLOrYLqJJCWyiaO6erjCPntz7dPdvwQiK947/xBbiI4FbooKz4zfvkSgs9+nXKWg4vj72lj1FvKABy1CObDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168903; c=relaxed/simple;
	bh=wvmEMvCUzSgouK7RL1vaW0SFREP1d3S87z3s6JyC/4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovkEvN7hlL7Gg3WO24UpVLDjTEt+VXPTAdZY8ceKf7Tgw8oANMyTKyHpVAxnpO85s5N0BmeskFoFCvP5DqALqgYVxdMKyDEhGsTjJLRSux1IqA5UmMVW7kAuI+y3AzT/qYP9ZYOOD6kTiyWSEgVGXhF7OFaVs5J+u/IrfokGPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02C261515;
	Mon, 15 Apr 2024 01:15:30 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3F353F64C;
	Mon, 15 Apr 2024 01:14:59 -0700 (PDT)
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
Subject: [PATCH v5 2/4] tools/perf: Track where perf_sample_ids need per-thread periods
Date: Mon, 15 Apr 2024 09:14:46 +0100
Message-ID: <20240415081448.123789-3-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415081448.123789-1-ben.gainey@arm.com>
References: <20240415081448.123789-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_sample_ids and related evlist/evsel code are modified to track
which events combine inherit+PERF_SAMPLE_READ+PERF_SAMPLE_TID.

Events with this combination of properties must be handled differently
when calculating each sample period. They must use the combination
of (ID + TID) to uniquely identify each distinct sequence of values.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/lib/perf/evlist.c                 | 1 +
 tools/lib/perf/evsel.c                  | 7 +++++++
 tools/lib/perf/include/internal/evsel.h | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..d17288eeaee4 100644
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
index c07160953224..f7abb879f416 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -537,6 +537,13 @@ void perf_evsel__free_id(struct perf_evsel *evsel)
 	evsel->ids = 0;
 }
 
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel)
+{
+	return (evsel->attr.sample_type & PERF_SAMPLE_READ)
+		&& (evsel->attr.sample_type & PERF_SAMPLE_TID)
+		&& evsel->attr.inherit;
+}
+
 void perf_counts_values__scale(struct perf_counts_values *count,
 			       bool scale, __s8 *pscaled)
 {
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 5cd220a61962..f8de2bf89c76 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -36,6 +36,13 @@ struct perf_sample_id {
 
 	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
 	u64			 period;
+
+	/*
+	 * When inherit is combined with PERF_SAMPLE_READ, the period value is
+	 * per (id, thread) tuple, rather than per id, so use the stream_id to
+	 * uniquely identify the period, rather than the id.
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


