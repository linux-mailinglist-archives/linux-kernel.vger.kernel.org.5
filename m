Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22D77E0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbjHPLue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244779AbjHPLuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:50:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5F96AB;
        Wed, 16 Aug 2023 04:50:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91CD01063;
        Wed, 16 Aug 2023 04:50:41 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.4.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C85F43F64C;
        Wed, 16 Aug 2023 04:49:56 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/6] perf arm64: Allow version comparisons of CPU IDs
Date:   Wed, 16 Aug 2023 12:47:43 +0100
Message-Id: <20230816114841.1679234-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816114841.1679234-1-james.clark@arm.com>
References: <20230816114841.1679234-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

There is an existing weak default strcmp_cpuid_str() function, and an
x86 version. This adds another version for arm64.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/header.c | 67 ++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 80b9f6287fe2..a2eef9ec5491 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,3 +1,6 @@
+#include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <perf/cpumap.h>
@@ -10,15 +13,14 @@
 
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
+	int ret = EINVAL;
 
 	if (!sysfs || sz < MIDR_SIZE)
 		return EINVAL;
@@ -44,22 +46,13 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 		}
 		fclose(file);
 
-		/* Ignore/clear Variant[23:20] and
-		 * Revision[3:0] of MIDR
-		 */
-		midr = strtoul(buf, NULL, 16);
-		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
-		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
 		/* got midr break loop */
+		ret = 0;
 		break;
 	}
 
 	perf_cpu_map__put(cpus);
-
-	if (!midr)
-		return EINVAL;
-
-	return 0;
+	return ret;
 }
 
 int get_cpuid(char *buf, size_t sz)
@@ -99,3 +92,47 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 
 	return buf;
 }
+
+/*
+ * Return 0 if idstr is a higher or equal to version of the same part as
+ * mapcpuid. Therefore, if mapcpuid has 0 for revision and variant then any
+ * version of idstr will match as long as it's the same CPU type.
+ *
+ * Return 1 if the CPU type is different or the version of idstr is lower.
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
+	 * values eg. 1.3 < 2.0 < 2.1 < 2.2.
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

