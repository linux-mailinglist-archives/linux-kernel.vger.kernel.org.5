Return-Path: <linux-kernel+bounces-141464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE088A1E95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356552929BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A47205E27;
	Thu, 11 Apr 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwjgXOhN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E55205E15;
	Thu, 11 Apr 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859440; cv=none; b=RD960ni0dJYzgm7QKbBsNx9nMBoLERZNyjxzwGahx0ix9y7gYsSD/+nQtxmhHY2ZzRkflKlrxEqu0Sef4T4jlVzNTx/QCBLh5mDpbpenimPIYGRU8YEjoO0xVMhUsi2VmHUkL6gWSUhkhuXFfUDcG20AHP140gC/wlvhH04fRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859440; c=relaxed/simple;
	bh=b6PPJY9P9PsJamKQ3wTtANrrHHGiwci1Vnn5BEBKsy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irey9946sGdf2AqjtLmq73b21HYFk/FA9vwVOp0JwbqiJ+EwK42FUC34RRGl3zUU2+/5T0HscnS+lJrQqADVlnZZFy0t2fGozHYzWI3/D1Wvi1nR6U91B3WkdZfr6xPd0uFbHbo5TuIxNX/31WQyICrUP8ZAq72qYh2DObYYQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwjgXOhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF25C113CD;
	Thu, 11 Apr 2024 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712859440;
	bh=b6PPJY9P9PsJamKQ3wTtANrrHHGiwci1Vnn5BEBKsy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwjgXOhNBXHQfDdQq3S2xKYRXuAAeXn+Py2fBF3NCGyyBROyrdH9kkfbQM8GHPB9/
	 KAlMNHAZTNG06mztOVeXZ60KcAlBWKtM7TB9PzDEeAes1PC1RaUktTA3ebQuPIc266
	 8v5vdRf1mMZWS6sJGHpXkxV409GI6HHUUZ/RMdXv8vG/dz7mcVjHZDsNg+4R6vwAhX
	 EWAQsx528Q62x9zCOxAHwL2b7xOJxxG7ICNPCPhn/NxnxAYEBI36dlH/sjGvwPdlHN
	 F4W6WzIfL/ie/sW/DrfsQLQGDhCh8nXlgw3q3+GT9mSvqIDh7upIGIpKbSk4aKW2hY
	 iScsF0XtoSn0Q==
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
Subject: [PATCH v2 2/3] perf hist: Add weight fields to hist entry stats
Date: Thu, 11 Apr 2024 11:17:17 -0700
Message-ID: <20240411181718.2367948-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240411181718.2367948-1-namhyung@kernel.org>
References: <20240411181718.2367948-1-namhyung@kernel.org>
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
2.44.0.683.g7961c838ac-goog


