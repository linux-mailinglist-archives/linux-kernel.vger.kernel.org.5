Return-Path: <linux-kernel+bounces-100612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23734879ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15D8286FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2087313C9E9;
	Tue, 12 Mar 2024 17:34:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6013C9C8;
	Tue, 12 Mar 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264891; cv=none; b=DSvq24/jWSoovBAazH0Kh7ja3yDdYRAN+k1IrOBQ5U886NQ5fct00ypMkFLTWkmwGhW2+iM35NpsYa1TKKvZw53Hos49Vs0RkVM9zlP3CTrbcTk/iS71a3CKfyJoVCdOHVZ2uJIsB2GWEYqYDXAuilxJV09+ZE/uESNZ9vgGyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264891; c=relaxed/simple;
	bh=Pk7t1v7Z0Gk895Rwp6txDZ/tZxG8qIP6U+5tr65qLPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qylRY2WJAh+cowD7Sjvzzhm/kxX1lbzhLYvMrrPth1Rf8XHk+AmKKyAkNKdk5G0JkUXs7qWkCqnMZRTVN6y88nVstHcqO+KlPgXEnoWJkqm80kJtD3iAykIkfOgSrfeuiweanqwoRN4TPg23Tmh2LQVYLsk03mRNzmo0z5tepVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB0D615BF;
	Tue, 12 Mar 2024 10:35:26 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EB4D3F762;
	Tue, 12 Mar 2024 10:34:47 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 10/10] ARM: Use common uncore PMU capabilities
Date: Tue, 12 Mar 2024 17:34:12 +0000
Message-Id: <de2646ca1d333cd9286f22ed3a5e8d57d22833b1.1710257512.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1710257512.git.robin.murphy@arm.com>
References: <cover.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the ARM system PMU drivers over to the new common capabilities,
allowing to remove all the checks that perf core now takes care of.

CC: Russell King <linux@armlinux.org.uk>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mach-imx/mmdc.c     | 16 +---------------
 arch/arm/mm/cache-l2x0-pmu.c | 12 +-----------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 444a7eaa320c..806ab6675b37 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -280,20 +280,6 @@ static int mmdc_pmu_event_init(struct perf_event *event)
 	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
 	int cfg = event->attr.config;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
-	if (event->cpu < 0) {
-		dev_warn(pmu_mmdc->dev, "Can't provide per-task data!\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (event->attr.sample_period)
-		return -EINVAL;
-
 	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
 		return -EINVAL;
 
@@ -445,7 +431,7 @@ static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
 			.start          = mmdc_pmu_event_start,
 			.stop           = mmdc_pmu_event_stop,
 			.read           = mmdc_pmu_event_update,
-			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+			.capabilities	= PERF_PMU_UNCORE_CAPS,
 		},
 		.mmdc_base = mmdc_base,
 		.dev = dev,
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..a2567d953fdb 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -295,16 +295,6 @@ static int l2x0_pmu_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hw = &event->hw;
 
-	if (event->attr.type != l2x0_pmu->type)
-		return -ENOENT;
-
-	if (is_sampling_event(event) ||
-	    event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	if (event->attr.config & ~L2X0_EVENT_CNT_CFG_SRC_MASK)
 		return -EINVAL;
 
@@ -524,7 +514,7 @@ static __init int l2x0_pmu_init(void)
 		.del = l2x0_pmu_event_del,
 		.event_init = l2x0_pmu_event_init,
 		.attr_groups = l2x0_pmu_attr_groups,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities = PERF_PMU_UNCORE_CAPS,
 	};
 
 	l2x0_pmu_reset();
-- 
2.39.2.101.g768bb238c484.dirty


