Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2875EAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGXFHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:07:04 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5CBE40;
        Sun, 23 Jul 2023 22:07:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yuhaixin.yhx@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vo0jtO7_1690175215;
Received: from B-Q60VQ05P-2326.local(mailfrom:yuhaixin.yhx@linux.alibaba.com fp:SMTPD_---0Vo0jtO7_1690175215)
          by smtp.aliyun-inc.com;
          Mon, 24 Jul 2023 13:06:58 +0800
Date:   Mon, 24 Jul 2023 13:06:54 +0800
From:   Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf arm64: Fix read PMU cpu slots
Message-ID: <ZL4G7rWXkfv-Ectq@B-Q60VQ05P-2326.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f8ad6018ce3c ("perf pmu: Remove duplication around
 EVENT_SOURCE_DEVICE_PATH") uses sysfs__read_ull to read a full
sysfs path, which will never success. Fix it by read file directly.

Signed-off-by: Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
---
 tools/perf/arch/arm64/util/pmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 561de0cb6b95..512a8f13c4de 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -54,10 +54,11 @@ double perf_pmu__cpu_slots_per_cycle(void)
 		perf_pmu__pathname_scnprintf(path, sizeof(path),
 					     pmu->name, "caps/slots");
 		/*
-		 * The value of slots is not greater than 32 bits, but sysfs__read_int
-		 * can't read value with 0x prefix, so use sysfs__read_ull instead.
+		 * The value of slots is not greater than 32 bits, but
+		 * filename__read_int can't read value with 0x prefix,
+		 * so use filename__read_ull instead.
 		 */
-		sysfs__read_ull(path, &slots);
+		filename__read_ull(path, &slots);
 	}
 
 	return slots ? (double)slots : NAN;
-- 
2.34.1

