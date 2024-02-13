Return-Path: <linux-kernel+bounces-63063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD7852A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024ECB22B72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591C1A27D;
	Tue, 13 Feb 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5Ia39o+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC511182CC;
	Tue, 13 Feb 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810778; cv=none; b=Qmj0JJAM0rGR+b6masr7DUMgKBLPTjbPW2lafdTVbBq1QezV6XDY70r52jcb0/Npa8iBeDtYZAPf4tyYBf99zVlkWjGcf95rcyiL0kHdGtzO1F7IeVH74WX5u2Rss1/eEeXumGhVw49S8mqv8A3TBZwZa5U5kJ0V55YBRsY7HGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810778; c=relaxed/simple;
	bh=jcUZpV1neXzu3Kp6ToaOsDKLDERo3W3oIzclMpmzJ1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6kkniChvGZSdi5VVxgfzE51psLK6mzs3T8EoX7hn0F0Je+nxV8EPnn5mUXWCEPXpHM7Q6NC+B9hfT1On7qg7/sNkEqnBSwcc0gBw4jL6q3VE8TLeV2mAKZkRyAzOUf70k3jQY1azSmkIjVyjvXazvxioQq2BZK8qH0P9flyff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5Ia39o+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA87C43394;
	Tue, 13 Feb 2024 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707810778;
	bh=jcUZpV1neXzu3Kp6ToaOsDKLDERo3W3oIzclMpmzJ1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5Ia39o+UXgoq87UnC132bdO3AXQ/WuaXkeWlK28XRnlkd37wk+R3d77ML+/2HZXO
	 xhyxDBLbmlMFOQ/mAig9LIK643sPl2voIr9p5JWunqnslc6uj4iWmIkvEQPsmPkh/Q
	 RbwNcFT3chwNv8hn17yABArqTYfI8QXSUkBVh6b9vOAG5d+4UTyJRIlw71ub9f5rq2
	 8qhrb5z9kAV/TRiZUQQI68JIk+DH4I3KR8cFIORO7a/dh60UcJ9XJNvciWZaa4J7e5
	 XuM20i5nEhyC9K7JgrZ7OkMZ9kiXS1I2qR9WzgLrM20VvfMfKbp9y5UWk7ycm7Nyrk
	 lF9UQIbCnv3cg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf hist: Simplify hist printing logic for group events
Date: Mon, 12 Feb 2024 23:52:54 -0800
Message-ID: <20240213075256.1983638-3-namhyung@kernel.org>
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

It can uses an array to save the period (or percent) values for member
events and print them together in a loop.  This simplify the logic to
handle missing samples in members with zero values.

No functional change intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c | 55 +++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 2bf959d08354..5f4c110d840f 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -33,6 +33,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	char *buf = hpp->buf;
 	size_t size = hpp->size;
 
+	/* print stand-alone or group leader events separately */
 	if (fmt_percent) {
 		double percent = 0.0;
 		u64 total = hists__total_period(hists);
@@ -45,12 +46,19 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, get_field(he));
 
 	if (evsel__is_group_event(evsel)) {
-		int prev_idx, idx_delta;
+		int idx;
 		struct hist_entry *pair;
 		int nr_members = evsel->core.nr_members;
+		union {
+			u64 period;
+			double percent;
+		} *val;
 
-		prev_idx = evsel__group_idx(evsel);
+		val = calloc(nr_members, sizeof(*val));
+		if (val == NULL)
+			return 0;
 
+		/* collect values in the group members */
 		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
 			u64 period = get_field(pair);
 			u64 total = hists__total_period(pair->hists);
@@ -59,47 +67,26 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 				continue;
 
 			evsel = hists_to_evsel(pair->hists);
-			idx_delta = evsel__group_idx(evsel) - prev_idx - 1;
-
-			while (idx_delta--) {
-				/*
-				 * zero-fill group members in the middle which
-				 * have no sample
-				 */
-				if (fmt_percent) {
-					ret += hpp__call_print_fn(hpp, print_fn,
-								  fmt, len, 0.0);
-				} else {
-					ret += hpp__call_print_fn(hpp, print_fn,
-								  fmt, len, 0ULL);
-				}
-			}
-
-			if (fmt_percent) {
-				ret += hpp__call_print_fn(hpp, print_fn, fmt, len,
-							  100.0 * period / total);
-			} else {
-				ret += hpp__call_print_fn(hpp, print_fn, fmt,
-							  len, period);
-			}
+			idx = evsel__group_idx(evsel);
 
-			prev_idx = evsel__group_idx(evsel);
+			if (fmt_percent)
+				val[idx].percent = 100.0 * period / total;
+			else
+				val[idx].period = period;
 		}
 
-		idx_delta = nr_members - prev_idx - 1;
-
-		while (idx_delta--) {
-			/*
-			 * zero-fill group members at last which have no sample
-			 */
+		/* idx starts from 1 to skip the leader event */
+		for (idx = 1; idx < nr_members; idx++) {
 			if (fmt_percent) {
 				ret += hpp__call_print_fn(hpp, print_fn,
-							  fmt, len, 0.0);
+							  fmt, len, val[idx].percent);
 			} else {
 				ret += hpp__call_print_fn(hpp, print_fn,
-							  fmt, len, 0ULL);
+							  fmt, len, val[idx].period);
 			}
 		}
+
+		free(val);
 	}
 
 	/*
-- 
2.43.0.687.g38aa6559b0-goog


