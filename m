Return-Path: <linux-kernel+bounces-1145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67196814B18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8976A1C239E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD237162;
	Fri, 15 Dec 2023 15:01:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD803714C;
	Fri, 15 Dec 2023 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA28CC15;
	Fri, 15 Dec 2023 07:01:52 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB2853F5A1;
	Fri, 15 Dec 2023 07:01:04 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-next@vger.kernel.org,
	will@kernel.org,
	u.kleine-koenig@pengutronix.de
Cc: James Clark <james.clark@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] arm: perf: Fix ARCH=arm build with GCC in armv8pmu_set_event_filter()
Date: Fri, 15 Dec 2023 15:00:39 +0000
Message-Id: <20231215150040.3342183-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215150040.3342183-1-james.clark@arm.com>
References: <20231215150040.3342183-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLVM ignores everything inside the if statement and doesn't generate
errors, but GCC does, resulting in the following:

  drivers/perf/arm_pmuv3.c: In function armv8pmu_set_event_filter:
  include/linux/bits.h:34:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
  34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \

Fix it by changing the if to #if. This results in an unused function
warning for armv8pmu_event_threshold_control(), so suppress that too.

Fixes: 816c26754447 ("arm64: perf: Add support for event counting threshold")
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 3ed2086cefc3..8aa23878019a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -338,7 +338,7 @@ static bool armv8pmu_event_want_user_access(struct perf_event *event)
 	return ATTR_CFG_GET_FLD(&event->attr, rdpmc);
 }
 
-static u8 armv8pmu_event_threshold_control(struct perf_event_attr *attr)
+static __maybe_unused u8 armv8pmu_event_threshold_control(struct perf_event_attr *attr)
 {
 	u8 th_compare = ATTR_CFG_GET_FLD(attr, threshold_compare);
 	u8 th_count = ATTR_CFG_GET_FLD(attr, threshold_count);
@@ -1040,11 +1040,13 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 		return -EINVAL;
 	}
 
-	if (IS_ENABLED(CONFIG_ARM64) && th) {
+#if IS_ENABLED(CONFIG_ARM64)
+	if (th) {
 		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TH, th);
 		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TC,
 					  armv8pmu_event_threshold_control(attr));
 	}
+#endif
 
 	/*
 	 * Install the filter into config_base as this is used to
-- 
2.34.1


