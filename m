Return-Path: <linux-kernel+bounces-63062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E194852A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E621F2257C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD918B15;
	Tue, 13 Feb 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3dpFVKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7418036;
	Tue, 13 Feb 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810778; cv=none; b=DhHZhx+UVj2EAZ8xun6RN3/9ThdYbA8ai8zpr7fnfdPEZR3/9/PKCxVN5NFMXrWp6T6t2wrpjXpv0uebeUKwEq4eVHUAGQulhraa9IaE32jrOpBLwZ3qwnJyqWu9JFCqrVoL/aXw/w/Gc+9G4X3NkgFI5xC1fyaYdZWkhEAoE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810778; c=relaxed/simple;
	bh=sOy6KlficwKF5vE8HVBwVLDj0OcsjYyU8khFYs9JUiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqquY+QP88Dy9pqzJKwtNYyF7GGfI8hvQ0N/djndXBbxVvFDmmXdSTkHbM8FeaUd7vbgDDPR7xVJ2GAu132C1XNy8NXaCtiSfnJhejIPzGNIjEk4dNjeZ/mrfWLDNR39gVl1Th4oJRbPCS8hBjFe6ob25bkH3H+qMx3ERhoT4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3dpFVKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3CDC43390;
	Tue, 13 Feb 2024 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707810777;
	bh=sOy6KlficwKF5vE8HVBwVLDj0OcsjYyU8khFYs9JUiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3dpFVKvINO5IweleyEFN/hEmQOIAzXGvkh7OnKH2x8GDDheWS9D/+vK4Tz0PXgt+
	 fAFAxgwkzfqpIf2tuIcZLaSD2ahUrfcv8rIBEcwASBzkD2Q6Rrx/BUT9iYtyJ4HMw1
	 9L/J2j4PzZ3x+w5K7oaKu8seXAVWfd9v64bwWuPOFB5h1nWiaMC5AJ80kqDUypo1Mi
	 AS7YUtMaNMgvVxo7jjWMftJIsAKr+XntKtiddO+Bhk2ON66cpePHJ+GXAxTBPaRCno
	 KZoz3IuA8qs5Xfk8SAhVQznCVRmoDlUg5TJ8BoSMLHQBmzLOLoWOrruiL36CABrxnQ
	 +XgJBIW8OIFLw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] libperf evlist: Update group info in perf_evlist__remove()
Date: Mon, 12 Feb 2024 23:52:53 -0800
Message-ID: <20240213075256.1983638-2-namhyung@kernel.org>
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

When an event in a group is removed, it should update the group status
including the pointer to leader and number of member events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 058e3ff10f9b..befdb062fa1d 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -102,8 +102,29 @@ void perf_evlist__add(struct perf_evlist *evlist,
 void perf_evlist__remove(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel)
 {
+	struct perf_evsel *leader = evsel->leader;
+
 	list_del_init(&evsel->node);
 	evlist->nr_entries -= 1;
+
+	/* return stand-alone event */
+	if (leader == evsel && leader->nr_members < 2)
+		return;
+
+	if (leader == evsel) {
+		struct perf_evsel *member;
+
+		/* select the next event as a new leader */
+		leader = member = perf_evlist__next(evlist, evsel);
+
+		/* update members to see the new leader */
+		while (member && member->leader == evsel) {
+			member->leader = leader;
+			member = perf_evlist__next(evlist, member);
+		}
+	}
+
+	leader->nr_members = evsel->leader->nr_members - 1;
 }
 
 struct perf_evlist *perf_evlist__new(void)
-- 
2.43.0.687.g38aa6559b0-goog


