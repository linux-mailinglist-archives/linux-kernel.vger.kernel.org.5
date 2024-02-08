Return-Path: <linux-kernel+bounces-58133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168184E1C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E83B29DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8612881A;
	Thu,  8 Feb 2024 13:11:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4D3128393;
	Thu,  8 Feb 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397882; cv=none; b=TwNWeYPdgzRiwpOdZLUupZ6gVXOK3m2DIFerDhywVtlRBxL15tQGcTzmdTZdLmow/mm2xUas9KDl8HM+JiIKVJY4R2b3FE8ETVGc8r+ovSGh6qWNlcPFs6SUdn2woXSxiI9hNV5Y23dqGIlvyLI8iTN4ba40WYmG0wffEuf2Fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397882; c=relaxed/simple;
	bh=NXmmRDt9OvFlC34NViJ9HXJ7Z7vXKtF1o7U8eiErB4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAygWMJih4Xq+spF9mKZkDxj4HG0VTWWyLA20M+pnIShjnyDTV32iNMq/USO88jhVn8CfJ5Akq/+eKHfDadGK94V0Epy/ThN5t57DrcgLNDBoOnmTafE5yAY4oqpSg9J4uZCgEofxWLCZhLCwwG5Krtswxar6HXsnqecWX0P/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 673201570;
	Thu,  8 Feb 2024 05:12:02 -0800 (PST)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 741163F5A1;
	Thu,  8 Feb 2024 05:11:18 -0800 (PST)
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
Subject: [PATCH v2 4/4] tools/perf: Allow inherit + inherit_stat + PERF_SAMPLE_READ when opening events
Date: Thu,  8 Feb 2024 13:10:50 +0000
Message-ID: <20240208131050.2406183-5-ben.gainey@arm.com>
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

When PERF_SAMPLE_READ is used will enable inherit_stat when inherit is set.

Provides a fallback path to disable inherit when this feature is not available,
which is inline with the previous behaviour.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/perf/util/evsel.c | 15 +++++++++++++--
 tools/perf/util/evsel.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d7c9c58a9bc..dc74b39a2254 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1156,7 +1156,11 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		 */
 		if (leader->core.nr_members > 1) {
 			attr->read_format |= PERF_FORMAT_GROUP;
-			attr->inherit = 0;
+		}
+
+		/* Inherit + READ requires inherit_stat */
+		if (attr->inherit) {
+			attr->inherit_stat = true;
 		}
 	}
 
@@ -1832,6 +1836,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.inherit_sample_read)
+		evsel->core.attr.inherit = 0;
 	if (perf_missing_features.branch_counters)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
 	if (perf_missing_features.read_lost)
@@ -1887,7 +1893,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_counters &&
+	if (!perf_missing_features.inherit_sample_read &&
+	    evsel->core.attr.inherit && (evsel->core.attr.sample_type & PERF_SAMPLE_READ)) {
+		perf_missing_features.inherit_sample_read = true;
+		pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
+		return true;
+	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
 		pr_debug2("switching off branch counters support\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index efbb6e848287..11cc9b8bee27 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -192,6 +192,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool inherit_sample_read;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.43.0


