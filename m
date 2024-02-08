Return-Path: <linux-kernel+bounces-58131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917084E1BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3353D285F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E1779926;
	Thu,  8 Feb 2024 13:11:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06876413;
	Thu,  8 Feb 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397879; cv=none; b=TkGv8fvJEawnO6iVrwud/NTWMksUd6z84DxHfA28Yvl3kdqS6aMv6r2/Qy368HYg5Bm/vvOSCmCXkBpkTa1LZhN2/PZo9EdQu/Okj/L/sjk7DF0qQ80hNHR/fXIvEsEVONXmJVqI7i25kHw49nsa1ItaWvDukquKqBTMiFS2lEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397879; c=relaxed/simple;
	bh=Je/B4EVJ1QmkamUOgXw0RNyKBh1iaAjN/ZC5BiEcIWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfhRl5K0waUP8pEO2TEr7nJEVEc6jKXFXgcB59o5NyX6iQP4TydTnNt9wGU7Dkb17sc5p2+t+shIFfry70tjuX5FB/h3sAozcHFhtG68Ltsr/pWP0b8J+WvLwD87iFw+8UPy2d8k1297WTvcsSwSc1zxKsURE92k99XaxagVZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90781152B;
	Thu,  8 Feb 2024 05:11:58 -0800 (PST)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D49A3F5A1;
	Thu,  8 Feb 2024 05:11:14 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@arm.com,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v2 2/4] tools/perf: Track where perf_sample_ids need per-thread periods
Date: Thu,  8 Feb 2024 13:10:48 +0000
Message-ID: <20240208131050.2406183-3-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208131050.2406183-1-ben.gainey@arm.com>
References: <20240208131050.2406183-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When PERF_SAMPLE_READ is used with inherit+inherit_stat the perf_sample_id is no longer
globally unique, but instead is unique per each inherited thread.

Track this fact in perf_sample_ids as it will be needed to correctly calculate the
period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/lib/perf/evlist.c                 | 1 +
 tools/lib/perf/evsel.c                  | 7 +++++++
 tools/lib/perf/include/internal/evsel.h | 7 +++++++
 3 files changed, 15 insertions(+)

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
index 5cd220a61962..97658f1c9ca3 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -36,6 +36,11 @@ struct perf_sample_id {
 
 	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
 	u64			 period;
+
+	/* When inherit+inherit_stat is combined with PERF_SAMPLE_READ, the
+	 * period value is per (sample_id, thread) tuple, rather than per
+	 * sample_id. */
+	bool 			 period_per_thread;
 };
 
 struct perf_evsel {
@@ -88,4 +93,6 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__free_id(struct perf_evsel *evsel);
 
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
-- 
2.43.0


