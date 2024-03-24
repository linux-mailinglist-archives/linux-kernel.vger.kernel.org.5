Return-Path: <linux-kernel+bounces-115461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C769E8894ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1D2B25BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD21E6F43;
	Mon, 25 Mar 2024 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAFpoYJW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3501DB09B;
	Sun, 24 Mar 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320852; cv=none; b=AnFyyFtnqarw9gZOi2lXpuzqypAZVans62JGa804CXjpHJoNuWhsQZePa+Z7DzQFM+c0PtrgV0VsK3f0LoKdvrqejkdf/+VaP8QP7BXkrdUlSmJ1YErxQ39WnSgkyOELBdZzZLpOjiI0uMDLdNoW/T9ffrKwctTs8K/6SD81/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320852; c=relaxed/simple;
	bh=KKAX63E2UjWlYV/JoCCOLDPiHQImCjytiQ3NA2dE3Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZR7nLKBP19EQIhNCK2PvcLIKXO/80PFaWGnSCC+zL5xja8CsuXjxE4Ssl3NdQ3I97UgY6h9idqznVD3wbVwfeBF/KOXK25aHDJ97mW17wvEGwaahu8n+DC7cOI1DMgdezHusELB3/iTUCTfbeuNQnaShdBSFd2ZoBTPOoMqqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAFpoYJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1FAC433F1;
	Sun, 24 Mar 2024 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320852;
	bh=KKAX63E2UjWlYV/JoCCOLDPiHQImCjytiQ3NA2dE3Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAFpoYJW3p45jF1XhVtPii6dsTJs1SN3+3fRTtOkuvsX+qOgfVSusBxput0gpFzHe
	 ELIvWK9DIlQLZJiricEkXpKTanbAGKgjSaQAh0gKsVGnQ69YrqchK76FWNS5ymPNl1
	 ob7qRFavOin5hMaDe2BbXPdgz+1eQLs0O05Omh3m67s/CUC7h8lsigMfunuQvyD1XM
	 A9OaG0XrtDQ1Mg4iCXMNw4BxEwpbj9Geztq0M/cP/wdyxF0JK+A36GdUkm8h0E4Sh/
	 LKvORTqtfvZpRK8JcuIINTqJhDFL7uWT7nK6PqUMWsy7DIJSMPkxq+CqrJ139nph0o
	 tNmpFZ/xY+syA==
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
Subject: [PATCH 6.7 416/713] perf pmu: Treat the msr pmu as software
Date: Sun, 24 Mar 2024 18:42:22 -0400
Message-ID: <20240324224720.1345309-417-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index d3c9aa4326bee..33e783fc908fe 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1756,6 +1756,12 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
 
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
@@ -1767,7 +1773,11 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
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


