Return-Path: <linux-kernel+bounces-63064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7C852A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2535F1F22861
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C721B7F1;
	Tue, 13 Feb 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnufl34i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427618C1A;
	Tue, 13 Feb 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810779; cv=none; b=KD5FNiac0OF0mScWSFCXr8pU8yLyGmsoD1vDJaOwUz/4LaDv0EGviS+O5vJpMbnngvQOULG7d9kha9YfzL6/oVjDnt48nlDbz/+UKuQbXK8SHetnK9sBRVl6sWaWUly3uT+Ymc3nYaxumvqAPW2lgt0pdDzanx4dqlKzkhifaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810779; c=relaxed/simple;
	bh=/cAFvtSoMi2WFvvFOaWCdmF3lcgANJyG3cErhVuBZ3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8ul/i2vhAcX4hpxsQuAnRBTsa8VipPNyHguDrC3noTZB5ppejSJ+0Sm/jVOvtCUL4ZY4Xyx9aRwg55vhGU1P+R0LjHtlZonhz+3LBNZOkZz+1lJRuwSYg9xFhubBahXL+RbYfP2m0cfxTGIOjnj4MM+CjbuIh5qtyMU0QCgO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnufl34i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A32C433C7;
	Tue, 13 Feb 2024 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707810778;
	bh=/cAFvtSoMi2WFvvFOaWCdmF3lcgANJyG3cErhVuBZ3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnufl34iNC3PJN5Ds6rRUdfaW5U9p2ah3WGrMWoIOVvx6meTPJyvRYbKJ2VaWyEpW
	 JwENBqr0ykiQo0dWSIrefm/0Q3hCBelXViKWu6WnXs1/D+eQxTjCDrspxoXrf5EhhM
	 hkT0uEhvSSnwieywqmxuphXVUYOrios9WcUb1q/hxbZx5KmVcJf1FVVuBL7NihNQp6
	 fYsmE51MaZ5UWNh3X63jbf74uJzpBmpXClyoZPS6grNXRnBwGCjhjqkr5zPfys4DoT
	 ns/e68RUr2CY0OTxJ/F0Ospavzi4qyYapfM7i+OnslVuD/yU1rBP9yPRbnI3Oreubc
	 snyzjTj+UcECQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf hist: Do not use event index in hpp__fmt()
Date: Mon, 12 Feb 2024 23:52:55 -0800
Message-ID: <20240213075256.1983638-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240213075256.1983638-1-namhyung@kernel.org>
References: <20240213075256.1983638-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __hpp__fmt() is to print period values in a hist entry.  It handles
event groups using linked pair entries.  Until now, it used event index
to print values of group members.  But we want to make it more robust
and support groups even if some members in the group were removed.

Let's use an index table from evsel to value array so that we can skip
dummy events in the output later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 5f4c110d840f..9c4c738edde1 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -48,15 +48,30 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	if (evsel__is_group_event(evsel)) {
 		int idx;
 		struct hist_entry *pair;
-		int nr_members = evsel->core.nr_members;
+		int nr_members = evsel->core.nr_members - 1;
 		union {
 			u64 period;
 			double percent;
 		} *val;
+		struct evsel *member;
+		struct evsel **idx_table;
 
 		val = calloc(nr_members, sizeof(*val));
 		if (val == NULL)
-			return 0;
+			goto out;
+
+		idx_table = calloc(nr_members, sizeof(*idx_table));
+		if (idx_table == NULL)
+			goto out;
+
+		/*
+		 * Build an index table for each evsel to the val array.
+		 * It cannot use evsel->core.idx because removed events might
+		 * create a hole so the index is not consecutive anymore.
+		 */
+		idx = 0;
+		for_each_group_member(member, evsel)
+			idx_table[idx++] = member;
 
 		/* collect values in the group members */
 		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
@@ -66,8 +81,15 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 			if (!total)
 				continue;
 
-			evsel = hists_to_evsel(pair->hists);
-			idx = evsel__group_idx(evsel);
+			member = hists_to_evsel(pair->hists);
+			for (idx = 0; idx < nr_members; idx++) {
+				if (idx_table[idx] == member)
+					break;
+			}
+
+			/* this should not happen */
+			if (idx == nr_members)
+				continue;
 
 			if (fmt_percent)
 				val[idx].percent = 100.0 * period / total;
@@ -75,8 +97,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 				val[idx].period = period;
 		}
 
-		/* idx starts from 1 to skip the leader event */
-		for (idx = 1; idx < nr_members; idx++) {
+		for (idx = 0; idx < nr_members; idx++) {
 			if (fmt_percent) {
 				ret += hpp__call_print_fn(hpp, print_fn,
 							  fmt, len, val[idx].percent);
@@ -89,6 +110,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 		free(val);
 	}
 
+out:
 	/*
 	 * Restore original buf and size as it's where caller expects
 	 * the result will be saved.
-- 
2.43.0.687.g38aa6559b0-goog


