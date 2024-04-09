Return-Path: <linux-kernel+bounces-136501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6A89D4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79701C213E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CB97F46E;
	Tue,  9 Apr 2024 08:48:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74774435;
	Tue,  9 Apr 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652488; cv=none; b=MsE/y/e3YdikkVtZVxI6uSyur9QwDek5J2J6ufGGj0baGgCwZcnRo1QgDbxbdlmDPwF6U53MM8VfMX8BiBEQgjq98DDH8ABKmlSu57uza+3rn+EpzwOKNA7INhH6TzRLexEcFI3sHC1mO9k5p0hcbuIg9n09yerqHmCJSzDa3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652488; c=relaxed/simple;
	bh=KeD4xL0gB/xCATWdOFUs5Nts/UM0E+U+CU8Lg6aBHO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XA4EqhDq4GpncarOErcvPdHjRyMx4kSb349Gg/C4CWSccDrK117GCeVXVqBRPcDNCTut6lGypY0G0wCmyVOceyts31qfeOr8X/Qcm8+EtHV+CEO2RDOO4Dbi8OGqhKboThIRxqFkpZ/pIAi06eUvYiaj2RfecEiJezfoNCyE3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 186B51007;
	Tue,  9 Apr 2024 01:48:37 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 910253F6C4;
	Tue,  9 Apr 2024 01:48:04 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Leo Yan <leo.yan@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf tests: Apply attributes to all events in object code reading test
Date: Tue,  9 Apr 2024 09:47:37 +0100
Message-Id: <20240409084741.405433-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409084741.405433-1-james.clark@arm.com>
References: <20240409084741.405433-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_PMU_CAP_EXTENDED_HW_TYPE results in multiple events being opened on
heterogeneous systems. Currently this test only sets its required
attributes on the first event. Not disabling enable_on_exec on the other
events causes the test to fail because the forked objdump processes are
sampled. No tracking event is opened so Perf only knows about its own
mappings causing the objdump samples to give the following error:

  $ perf test -vvv "object code reading"

  Reading object code for memory address: 0xffff9aaa55ec
  thread__find_map failed
  ---- end(-1) ----
  24: Object code reading              : FAILED!

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/code-reading.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 7a3a7bbbec71..29d2f3ee4e10 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -637,11 +637,11 @@ static int do_test_code_reading(bool try_kcore)
 
 		evlist__config(evlist, &opts, NULL);
 
-		evsel = evlist__first(evlist);
-
-		evsel->core.attr.comm = 1;
-		evsel->core.attr.disabled = 1;
-		evsel->core.attr.enable_on_exec = 0;
+		evlist__for_each_entry(evlist, evsel) {
+			evsel->core.attr.comm = 1;
+			evsel->core.attr.disabled = 1;
+			evsel->core.attr.enable_on_exec = 0;
+		}
 
 		ret = evlist__open(evlist);
 		if (ret < 0) {
-- 
2.34.1


