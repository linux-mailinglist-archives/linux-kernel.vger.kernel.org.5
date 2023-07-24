Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC875F8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGXNsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGXNsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:48:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E7133C14;
        Mon, 24 Jul 2023 06:45:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D12F611FB;
        Mon, 24 Jul 2023 06:45:58 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F102A3F67D;
        Mon, 24 Jul 2023 06:45:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        anshuman.khandual@arm.com, will@kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
Date:   Mon, 24 Jul 2023 14:44:56 +0100
Message-Id: <20230724134500.970496-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724134500.970496-1-james.clark@arm.com>
References: <20230724134500.970496-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This capability gives us the ability to open PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
implementation is contained in the Perf core and tool code so no change
to the Arm PMU driver is needed.

The following basic use case now results in Perf opening the event on
all PMUs rather than picking only one in an unpredictable way:

  $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2

   Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':

         963279620      armv8_cortex_a57/cycles/                (99.19%)
         752745657      armv8_cortex_a53/cycles/                (94.80%)

Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")
Suggested-by: Ian Rogers <irogers@google.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index f6ccb2cd4dfc..2e79201daa4a 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -880,8 +880,13 @@ struct arm_pmu *armpmu_alloc(void)
 		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
 		 * and we have taken ctx sharing into account (e.g. with our
 		 * pmu::filter callback and pmu::event_init group validation).
+		 *
+		 * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open
+		 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
+		 * specific PMU.
 		 */
-		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
+		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS |
+				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
 	};
 
 	pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =
-- 
2.34.1

