Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF380D0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbjLKQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344844AbjLKQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:15:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09F991BCE;
        Mon, 11 Dec 2023 08:15:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5844316F2;
        Mon, 11 Dec 2023 08:16:06 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8BD53F738;
        Mon, 11 Dec 2023 08:15:15 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com, anshuman.khandual@arm.com
Cc:     namhyung@gmail.com, James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 07/11] perf/arm_dmc620: Remove duplicate format attribute #defines
Date:   Mon, 11 Dec 2023 16:13:19 +0000
Message-Id: <20231211161331.1277825-8-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211161331.1277825-1-james.clark@arm.com>
References: <20231211161331.1277825-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were copied from the SPE driver, but now they're in the arm_pmu.h
header so delete them and use the header instead.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_dmc620_pmu.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 30cea6859574..9de9dc8db8db 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/perf_event.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
@@ -189,27 +190,6 @@ static const struct attribute_group dmc620_pmu_events_attr_group = {
 #define ATTR_CFG_FLD_clkdiv2_LO		9
 #define ATTR_CFG_FLD_clkdiv2_HI		9
 
-#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
-	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
-
-#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
-	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
-
-#define GEN_PMU_FORMAT_ATTR(name)				\
-	PMU_FORMAT_ATTR(name,					\
-	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,		\
-			     ATTR_CFG_FLD_##name##_LO,		\
-			     ATTR_CFG_FLD_##name##_HI))
-
-#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
-	((((attr)->cfg) >> lo) & GENMASK_ULL(hi - lo, 0))
-
-#define ATTR_CFG_GET_FLD(attr, name)				\
-	_ATTR_CFG_GET_FLD(attr,					\
-			  ATTR_CFG_FLD_##name##_CFG,		\
-			  ATTR_CFG_FLD_##name##_LO,		\
-			  ATTR_CFG_FLD_##name##_HI)
-
 GEN_PMU_FORMAT_ATTR(mask);
 GEN_PMU_FORMAT_ATTR(match);
 GEN_PMU_FORMAT_ATTR(invert);
-- 
2.34.1

