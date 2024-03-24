Return-Path: <linux-kernel+bounces-113270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C995D8882FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075D31C23032
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C78136E00;
	Sun, 24 Mar 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ0a3hUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2E18A709;
	Sun, 24 Mar 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320070; cv=none; b=CWrO0v++ODsNvA/cz+IPWzPm2N1luWrfqy49w6pGHNS46rT8mCXt0GaX7pDeAKcAlvU5bRo7tqDcNErTYk7EO87kM7PNLd53lnJS6iFjczGM8ru3guFqxaMC5qN2hbG0cVmizotQeqHH7IN9f0oSFgC5xLPkDhYJSl1SID4q1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320070; c=relaxed/simple;
	bh=MqLeLz/RiB5JWBEgcZw3fmstetrs49NWUuOfQE+Oe1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GokntsAQ0RUiW07v7RdHelCLdH6Ge4s7HSfW3pzD2bWQkKt9N8HqYPVrzjX9p+h6V2pCuLD0muk4IFss0M+z330kpADpizdf1Yl3LzULc/x+F7ty82v1tT6JXQpqbThFA6eYr8E9vnS2tHonwY3b643EmRuERi4zz3VD9n+QIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ0a3hUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FFAC433F1;
	Sun, 24 Mar 2024 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320070;
	bh=MqLeLz/RiB5JWBEgcZw3fmstetrs49NWUuOfQE+Oe1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ0a3hUy4o4eBUBbjSw6YY2FE+sQh7ZcLTEzlTNPdP5LGqQtCk8NKJo8GG1rBkXup
	 0Eyb3zYT80YTtVVg3ExARVWHUXHCvprn1hJVKo00vj6YH9mfxKrWUq0pnJGzkscTo6
	 UWOgyigyfuvO1jGZQYY1HH5BoWS9AW/Vn5iGHhFbsXH9vj4EYM7ru7bgDphJ5xC92q
	 Xn48nFt9DYYhT1f2Sw7dl17w3qfwDrI+5c2dkbjiv8wbh/o2xlUw9WCmCO/XnSkWrG
	 qPG5qSc3abiLYq8XWS0y7u1nyLXATJpMDYJENje9aZOIp8lZDL7NPrJgJ9HsobCyWB
	 z3HGUlrJUPDKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 379/715] perf pmu: Treat the msr pmu as software
Date: Sun, 24 Mar 2024 18:29:18 -0400
Message-ID: <20240324223455.1342824-380-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit 24852ef2e2d5c555c2da05baff112ea414b6e0f5 ]

The msr PMU is a software one, meaning msr events may be grouped
with events in a hardware context. As the msr PMU isn't marked as a
software PMU by perf_pmu__is_software, groups with the msr PMU in
are broken and the msr events placed in a different group. This
may lead to multiplexing errors where a hardware event isn't
counted while the msr event, such as tsc, is. Fix all of this by
marking the msr PMU as software, which agrees with the driver.

Before:
```
$ perf stat -e '{slots,tsc}' -a true
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'system wide':

         1,750,335      slots
         4,243,557      tsc

       0.001456717 seconds time elapsed
```

After:
```
$ perf stat -e '{slots,tsc}' -a true
 Performance counter stats for 'system wide':

        12,526,380      slots
         3,415,163      tsc

       0.001488360 seconds time elapsed
```

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Caleb Biggers <caleb.biggers@intel.com>
Cc: Edward Baker <edward.baker@intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>
Cc: Samantha Alt <samantha.alt@intel.com>
Cc: Weilin Wang <weilin.wang@intel.com>
Link: https://lore.kernel.org/r/20240124234200.1510417-1-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/pmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3c9609944a2f3..88b9aa7d3a27a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1760,6 +1760,12 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
 
 bool perf_pmu__is_software(const struct perf_pmu *pmu)
 {
+	const char *known_sw_pmus[] = {
+		"kprobe",
+		"msr",
+		"uprobe",
+	};
+
 	if (pmu->is_core || pmu->is_uncore || pmu->auxtrace)
 		return false;
 	switch (pmu->type) {
@@ -1771,7 +1777,11 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	case PERF_TYPE_BREAKPOINT:	return true;
 	default: break;
 	}
-	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
+	for (size_t i = 0; i < ARRAY_SIZE(known_sw_pmus); i++) {
+		if (!strcmp(pmu->name, known_sw_pmus[i]))
+			return true;
+	}
+	return false;
 }
 
 FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
-- 
2.43.0


