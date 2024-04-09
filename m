Return-Path: <linux-kernel+bounces-136033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AC89CF2D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34869282E54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58650EC3;
	Tue,  9 Apr 2024 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2dyQa/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4C19B;
	Tue,  9 Apr 2024 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621221; cv=none; b=JP3vlgnlEQj1GA77rIApXesV6/QN9Ov8+KU832K/XC2UFxEQQDQIi77f4YypJDS3iYl7sOOWOctRnBfxSNIOlFsBf9nz2Nm7bNGs3L/txHaC7U3xtwtSaxBb8MZ2UvEdvB6NmlC9PcP80SbFtHCyyUF5l4BFTLkdy9YKo5oZINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621221; c=relaxed/simple;
	bh=1Je+KDKrrgG2RiL1DsJQO7r/yZ910Uu/gCpX0BrhBQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyR91BS18sDelbBuksZCOJ94xD3BL1cy6gXGnvQF4HhAtqS/Rf6kfrf+72rayVOFX2fg8R7Y21IHC5Hs3HpKFzHMN8GZ+wsDLecht61ScRiGYVGbPiAxotQZMOTHjTvnHJJBoD/Aob+E3xrbgZFWYkKrl/CLVpCcZ7qV1jiIVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2dyQa/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE5BC43390;
	Tue,  9 Apr 2024 00:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712621221;
	bh=1Je+KDKrrgG2RiL1DsJQO7r/yZ910Uu/gCpX0BrhBQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2dyQa/5V+n0eKk8ovdczV5xdCpQxxXMRHy3jsBxpc4OpJNNGZSH7FyA7HmUYEHjX
	 tvseeoHFd4ZSez0emtn/Gw+1nq6MIz2gh4NVX0uLAz7w7Ggj9QayUh9pkbgMw9WT/U
	 eCcyv1JM12FrmerO6PJT3A99bq4oQeiQajBPQoXnMADxaGD6HsECBMuxx6pZOr5VWd
	 9qFCykJHJDFIwGNGPX33Fkos5Sy7p4i7xYBqrmD4bhAzChmLZ5M/IHGLsBSzV3nn6K
	 2t8EEkdWP1bfjoPuYQhCLhbETKktDVVrRwNhOuvzuY1/Dw5ra0T0gHz3pWx1gAZrl6
	 vBhClGcluhHrA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 2/3] perf hist: Add weight fields to hist entry stats
Date: Mon,  8 Apr 2024 17:06:58 -0700
Message-ID: <20240409000659.1727785-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240409000659.1727785-1-namhyung@kernel.org>
References: <20240409000659.1727785-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like period and sample numbers, it'd be better to track weight values
and display them in the output rather than having them as sort keys.

This patch just adds a few more fields to save the weights in a hist
entry.  It'll be displayed as new output fields in the later patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 12 ++++++++++--
 tools/perf/util/hist.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fa359180ebf8..9d43f8ae412d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -308,6 +308,9 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
 	dest->period_us		+= src->period_us;
 	dest->period_guest_sys	+= src->period_guest_sys;
 	dest->period_guest_us	+= src->period_guest_us;
+	dest->weight1		+= src->weight1;
+	dest->weight2		+= src->weight2;
+	dest->weight3		+= src->weight3;
 	dest->nr_events		+= src->nr_events;
 }
 
@@ -315,7 +318,9 @@ static void he_stat__decay(struct he_stat *he_stat)
 {
 	he_stat->period = (he_stat->period * 7) / 8;
 	he_stat->nr_events = (he_stat->nr_events * 7) / 8;
-	/* XXX need decay for weight too? */
+	he_stat->weight1 = (he_stat->weight1 * 7) / 8;
+	he_stat->weight2 = (he_stat->weight2 * 7) / 8;
+	he_stat->weight3 = (he_stat->weight3 * 7) / 8;
 }
 
 static void hists__delete_entry(struct hists *hists, struct hist_entry *he);
@@ -614,7 +619,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		cmp = hist_entry__cmp(he, entry);
 		if (!cmp) {
 			if (sample_self) {
-				he_stat__add_period(&he->stat, period);
+				he_stat__add_stat(&he->stat, &entry->stat);
 				hist_entry__add_callchain_period(he, period);
 			}
 			if (symbol_conf.cumulate_callchain)
@@ -731,6 +736,9 @@ __hists__add_entry(struct hists *hists,
 		.stat = {
 			.nr_events = 1,
 			.period	= sample->period,
+			.weight1 = sample->weight,
+			.weight2 = sample->ins_lat,
+			.weight3 = sample->p_stage_cyc,
 		},
 		.parent = sym_parent,
 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 8f072f3749eb..f34f101c36c2 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -163,6 +163,9 @@ struct he_stat {
 	u64			period_us;
 	u64			period_guest_sys;
 	u64			period_guest_us;
+	u64			weight1;
+	u64			weight2;
+	u64			weight3;
 	u32			nr_events;
 };
 
-- 
2.44.0.478.gd926399ef9-goog


