Return-Path: <linux-kernel+bounces-1144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B18E814B16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2775B28354B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6FD36AEC;
	Fri, 15 Dec 2023 15:01:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7CE35F16;
	Fri, 15 Dec 2023 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D1BB1063;
	Fri, 15 Dec 2023 07:01:49 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3393F3F5A1;
	Fri, 15 Dec 2023 07:01:00 -0800 (PST)
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
Subject: [PATCH 1/2] arm: perf: Fix ARCH=arm build with GCC in armv8pmu_write_evtype()
Date: Fri, 15 Dec 2023 15:00:38 +0000
Message-Id: <20231215150040.3342183-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215150040.3342183-1-james.clark@arm.com>
References: <20231215150040.3342183-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LLVM ignores everything inside the if statement and doesn't generate
errors, but GCC doesn't ignore it, resulting in the following error:

  drivers/perf/arm_pmuv3.c: In function ‘armv8pmu_write_evtype’:
  include/linux/bits.h:34:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
  	34 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \

Fix it by changing the if to #if.

Fixes: 3115ee021bfb ("arm64: perf: Include threshold control fields in PMEVTYPER mask")
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/linux-arm-kernel/20231215120817.h2f3akgv72zhrtqo@pengutronix.de/
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c..3ed2086cefc3 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -631,8 +631,9 @@ static void armv8pmu_write_evtype(int idx, unsigned long val)
 			     ARMV8_PMU_EXCLUDE_EL0 |
 			     ARMV8_PMU_EXCLUDE_EL1;
 
-	if (IS_ENABLED(CONFIG_ARM64))
-		mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
+#if IS_ENABLED(CONFIG_ARM64)
+	mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
+#endif
 
 	val &= mask;
 	write_pmevtypern(counter, val);
-- 
2.34.1


