Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63E779212
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjHKOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjHKOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:41:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CBA92D7F;
        Fri, 11 Aug 2023 07:41:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EC7B113E;
        Fri, 11 Aug 2023 07:42:20 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79B483F64C;
        Fri, 11 Aug 2023 07:41:34 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH v5 1/6] perf: cs-etm: Don't duplicate FIELD_GET()
Date:   Fri, 11 Aug 2023 15:39:18 +0100
Message-Id: <20230811144017.491628-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811144017.491628-1-james.clark@arm.com>
References: <20230811144017.491628-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/bitfield.h can be included as long as linux/kernel.h is included
first, so change the order of the includes and drop the duplicate macro.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1419b40dfbe8..9729d006550d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -6,10 +6,11 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/kernel.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/coresight-pmu.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
@@ -281,17 +282,6 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 	return 0;
 }
 
-/*
- * FIELD_GET (linux/bitfield.h) not available outside kernel code,
- * and the header contains too many dependencies to just copy over,
- * so roll our own based on the original
- */
-#define __bf_shf(x) (__builtin_ffsll(x) - 1)
-#define FIELD_GET(_mask, _reg)						\
-	({								\
-		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
-	})
-
 /*
  * Get a metadata for a specific cpu from an array.
  *
-- 
2.34.1

