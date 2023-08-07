Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84527772793
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjHGOXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjHGOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:23:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F068E53;
        Mon,  7 Aug 2023 07:23:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36D21FB;
        Mon,  7 Aug 2023 07:24:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8DDB3F64C;
        Mon,  7 Aug 2023 07:23:39 -0700 (PDT)
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
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH v4 2/6] perf arm64: Allow version comparisons of CPU IDs
Date:   Mon,  7 Aug 2023 15:20:46 +0100
Message-Id: <20230807142138.288713-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807142138.288713-1-james.clark@arm.com>
References: <20230807142138.288713-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently variant and revision fields are masked out of the MIDR so
it's not possible to compare different versions of the same CPU.
In a later commit a workaround will be removed just for N2 r0p3, so
enable comparisons on version.

This has the side effect of changing the MIDR stored in the header of
the perf.data file to no longer have masked version fields. It also
affects the lookups in mapfile.csv, but as that currently only has
zeroed version fields, it has no actual effect. The mapfile.csv
documentation also states to zero the version fields, so unless this
isn't done it will continue to have no effect.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/header.c | 64 ++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 80b9f6287fe2..8f74e801e1ab 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,3 +1,6 @@
+#include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
@@ -10,14 +13,12 @@
 
 #define MIDR "/regs/identification/midr_el1"
 #define MIDR_SIZE 19
-#define MIDR_REVISION_MASK      0xf
-#define MIDR_VARIANT_SHIFT      20
-#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
+#define MIDR_REVISION_MASK      GENMASK(3, 0)
+#define MIDR_VARIANT_MASK	GENMASK(23, 20)
 
 static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 {
 	const char *sysfs = sysfs__mountpoint();
-	u64 midr = 0;
 	int cpu;
 
 	if (!sysfs || sz < MIDR_SIZE)
@@ -44,21 +45,11 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 		}
 		fclose(file);
 
-		/* Ignore/clear Variant[23:20] and
-		 * Revision[3:0] of MIDR
-		 */
-		midr = strtoul(buf, NULL, 16);
-		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
-		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
 		/* got midr break loop */
 		break;
 	}
 
 	perf_cpu_map__put(cpus);
-
-	if (!midr)
-		return EINVAL;
-
 	return 0;
 }
 
@@ -99,3 +90,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 
 	return buf;
 }
+
+/*
+ * Return 0 if idstr is a higher or equal to version of the same part as
+ * mapcpuid.
+ *
+ * Therefore, if mapcpuid has 0 for revision and variant then any version of
+ * idstr will match as long as it's the same CPU type.
+ */
+int strcmp_cpuid_str(const char *mapcpuid, const char *idstr)
+{
+	u64 map_id = strtoull(mapcpuid, NULL, 16);
+	char map_id_variant = FIELD_GET(MIDR_VARIANT_MASK, map_id);
+	char map_id_revision = FIELD_GET(MIDR_REVISION_MASK, map_id);
+	u64 id = strtoull(idstr, NULL, 16);
+	char id_variant = FIELD_GET(MIDR_VARIANT_MASK, id);
+	char id_revision = FIELD_GET(MIDR_REVISION_MASK, id);
+	u64 id_fields = ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
+
+	/* Compare without version first */
+	if ((map_id & id_fields) != (id & id_fields))
+		return 1;
+
+	/*
+	 * ID matches, now compare version.
+	 *
+	 * Arm revisions (like r0p0) are compared here like two digit semver
+	 * values eg. 1.3 < 2.0 < 2.1 < 2.2. The events json file with the
+	 * highest matching version is used.
+	 *
+	 *  r = high value = 'Variant' field in MIDR
+	 *  p = low value  = 'Revision' field in MIDR
+	 *
+	 */
+	if (id_variant > map_id_variant)
+		return 0;
+
+	if (id_variant == map_id_variant && id_revision >= map_id_revision)
+		return 0;
+
+	/*
+	 * variant is less than mapfile variant or variants are the same but
+	 * the revision doesn't match. Return no match.
+	 */
+	return 1;
+}
-- 
2.34.1

