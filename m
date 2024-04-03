Return-Path: <linux-kernel+bounces-130218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0B1897598
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F21C267FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6214C5B3;
	Wed,  3 Apr 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0WluMAVa"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3B14C596
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162803; cv=none; b=gbPcym76uHLnt8RShn3uE0wJaqNrX0uDhyjqym0uADAqGyK/RGbhvW7JGPQQp1iHN7LtiGSHcbFeTzxX+4QClJXbxMWETY1HSSmqApnHetkjuEbKmNHapsPjHh2RH9gqjvHSqY35vW/7hmdm0AWNC+1W7k6Fb7ZeP/VHXDzO4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162803; c=relaxed/simple;
	bh=Lvj8qthx1cwI8FohJsFz5Fd8TgpulGpsMXGwcZOcLTM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MEd+YLPc1R2vGrXPUH6xo6YI8Y6Z9Tj5LcVack66yEHFTZTbA5yNtV34GWEl+P3jJ3FvW+ek5Gh87gFID+diZpAqLXuNgMg1pV0UyPftMXKRGm2qSwdmK55+JC7lzwTVzEneRqFwMB1WOg4phhpet+illqf2IWqvoObBLx6UFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0WluMAVa; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6bab4b84dso7086235b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712162801; x=1712767601; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BRVtdj0oK10e4j2h20xlPt/xFCKFRdEtGHks2UFPYJg=;
        b=0WluMAVa8ahifuvBk7rkpb+Yf+Orv4+o/sBJZJXejKTZV3FtM2w2LSY+zO3a67L2TN
         LB+zzd/vkEknct//Rr7YOOPVYQfzvfHrSgdBFex59qN9+u1KUrNlbZ0CZsfhKFcAvJXJ
         27ky7P0V0GXGnRQmrVRWKlS5Xcv1m2OBKJ5ruCHC7kV0yuvfLd9yNLp8GKH3XQXsO85V
         GVXrFXBR9/uFIgqYhj1r7TjUCL8guUO3M0Z29IcYnyrliMrsxqKFgsjwtlMsjbb/O4pR
         lKz7uP99uES017zWLUNDWa+9hjNTPHeCla+mCBmJa3KqnzVR62G5tNUttt6VxKDSaDLA
         jCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162801; x=1712767601;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRVtdj0oK10e4j2h20xlPt/xFCKFRdEtGHks2UFPYJg=;
        b=EsbZRRFoArm4otXxm6bV0joy9u9APVpPr+lkugoV/2sU4/KGrfSeOMWzWT6NgCv/+w
         LdCnvc7Vj2qbdrtIS45GSuyEpi/VhYFCGO9H80zOjwfiTTwemNxsxAy7K38KUsFsAj4b
         QLI7V5AC5S+UfZXVLnyxLo7Tbj4kP7XFELej5vLyT4DCBaFAG1GOQptTPE6H0Coap9gj
         fdAqxNwiSt6c3Qt+UrhJj9C79c6IHakk/dc0QS1CLR5CzDJyGZ7escCAp0DfXj9onn6b
         H1Zo9Ql6AZq/r8O2h6xjUgRUT2GK6NA94Cea/1ZSRe4AjJOA+eqGi2gUf4oiexQxs8vJ
         Brvg==
X-Forwarded-Encrypted: i=1; AJvYcCXN/UL0hhwcxyLqQ0k45ywtX+lPPMrG7lug54VQv/NU/0SBMcnhr7CVPYXATl9EI53jFiIKdoZA0P2/VAuFk2uGCkSCS/3wfIpdCsOP
X-Gm-Message-State: AOJu0YzL/sZigf1sws+nXLAWVTXgvCTL/agR/VW0/fcZ2lWNunh2pGXS
	3MWhBKAy3vz5SeRDRaLQlciRwX8eQSdVRT57254IlvMI/8J3/XLbEOGiT6exGgZoW8MoIZkr7Y6
	O3ht5Qg==
X-Google-Smtp-Source: AGHT+IGYtD0V2Rk3G0pROazlnGdYtSA1K54+7Vk/W68lWWQ805HcZbk6O4AzOpNO5lCWkXbDSd5k7dp+0AZ6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:12e:26c0:7a24:6d64])
 (user=irogers job=sendgmr) by 2002:a05:6a00:3920:b0:6e7:4a2f:56c0 with SMTP
 id fh32-20020a056a00392000b006e74a2f56c0mr80pfb.4.1712162801440; Wed, 03 Apr
 2024 09:46:41 -0700 (PDT)
Date: Wed,  3 Apr 2024 09:46:36 -0700
Message-Id: <20240403164636.3429091-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1] perf metrics: Remove the "No_group" metric group
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rather than place metrics without a metric group in "No_group" place
them in a a metric group that is their name. Still allow such metrics
to be selected if "No_group" is passed, this change just impacts perf
list.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 79ef6095ab28..6ec083af14a1 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -455,7 +455,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
 	const char *g;
 	char *omg, *mg;
 
-	mg = strdup(pm->metric_group ?: "No_group");
+	mg = strdup(pm->metric_group ?: pm->metric_name);
 	if (!mg)
 		return -ENOMEM;
 	omg = mg;
@@ -466,7 +466,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
 		if (strlen(g))
 			me = mep_lookup(groups, g, pm->metric_name);
 		else
-			me = mep_lookup(groups, "No_group", pm->metric_name);
+			me = mep_lookup(groups, pm->metric_name, pm->metric_name);
 
 		if (me) {
 			me->metric_desc = pm->desc;
-- 
2.44.0.478.gd926399ef9-goog


