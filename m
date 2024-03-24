Return-Path: <linux-kernel+bounces-114262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AC888F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7EC28FB75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301615B97E;
	Sun, 24 Mar 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWUr7bFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21642139596;
	Sun, 24 Mar 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321641; cv=none; b=MhmLVs9TKYtje3sUN6Mi++4JojJvFzPP1mGjEpv4eTgv01aKNK7Tm2sJ6jc0vwIooi9ohQwEENPFMQHrvRQcqHpAyFf1opB3eiDWDGnVnNdvmq7xv9h0FAv5DRjb/ja80jplnjqiFjjTzrjTKXJRLw6cBa8PHENMVMovSs/J6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321641; c=relaxed/simple;
	bh=TAPok/GZ8CPs3caYyO3HjWxXbNJrfJ4WKJUr7fIIVrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0pdEvTnEYae8FmMaR8v/xRyNCS+jmBhHnmSrG/mWv1dwoy6hj299K0S9rHpxXciy6PYblcPhuvP+y5Tptnf1/Gv5z9B2kZaKk6IimeVlFP95Yg7T6R3oHsqArNGKzGLrd3mIOtyt+3MRjU2JfH5sRATWZQlMIniAVm9FPCNydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWUr7bFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B61C433C7;
	Sun, 24 Mar 2024 23:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321640;
	bh=TAPok/GZ8CPs3caYyO3HjWxXbNJrfJ4WKJUr7fIIVrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWUr7bFYGMIy5trNO3PxBPhDMMlB63LMCUR5lTKX3XV/ATqKiGhXdGtC/u85dPauD
	 4OQtSItjMNVDNId1ySIJmGd42eaC+cS145BFrus482jvcqhcmoEAVjUTgsMuidEa+b
	 ke3aQuXq7nCBYXEE0U08vB9PWnNHv6Q/cCTyVjYmN9PA82T0jtpkyQb6gpTXRzPpDS
	 kkZlIpN+BaZKpX/opPysCS5F/9T7pFHeDo4JKec6Ngdw0B8a6TAS4UL95rMrWkfxaR
	 zgJLGP1xI50G9EadyC67CNt9UqvkqsBDOPQxQgBXSy9JssHW/fg15joSGQPwhaear0
	 lMVv3Z2cKJDVQ==
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
Subject: [PATCH 6.6 370/638] perf pmu: Treat the msr pmu as software
Date: Sun, 24 Mar 2024 18:56:47 -0400
Message-ID: <20240324230116.1348576-371-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index d515ba8a0e160..a3c7814116c7c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1735,6 +1735,12 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name)
 
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
@@ -1746,7 +1752,11 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
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
 
 FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
-- 
2.43.0


