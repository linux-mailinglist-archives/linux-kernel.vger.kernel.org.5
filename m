Return-Path: <linux-kernel+bounces-162579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE38B5D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930DF28918F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62A82D69;
	Mon, 29 Apr 2024 15:25:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DD7D401;
	Mon, 29 Apr 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404308; cv=none; b=KTu1VUTOTEdTMeIh0XaOChXvSbzhkpHayWH8Gp0xUsc+sFURc9SeeKGlpZz0IF2G5Rn/Li/CzhLOL+kJ3tZIcRVGcidCVQ3HTHEcVWx7ZhzfyObbSJMc7v+Z/mWNnvVoc+ftKOoxgckRq6Y5M0GkOSmuepMXeFd1mwNyobE8CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404308; c=relaxed/simple;
	bh=Sxd33KiG9+gJUUvksdzaB/jwCr/v4z1JBmUQqr5Egxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtHFLY5EbZLFfJa1ZUzlhuEH+YM/5KX0fB79zixpYKgFI3UVHoX1mTpSsgkwhfy/13YtRii22DsqNGq/sgFd834ceilGfBEULDf87aRY1MOiYgoBUv1ea6bDNydggyKw9uaLQHuN2SEe9PPQKOZCRRidG9C7oMrNxYDEd6r7H0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4EC339;
	Mon, 29 Apr 2024 08:25:32 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F18F73F793;
	Mon, 29 Apr 2024 08:25:02 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@linaro.org
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 11/17] coresight: Expose map argument in trace ID API
Date: Mon, 29 Apr 2024 16:21:56 +0100
Message-Id: <20240429152207.479221-12-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429152207.479221-1-james.clark@arm.com>
References: <20240429152207.479221-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trace ID API is currently hard coded to always use the global map.
The functions that take the map as an argument aren't currently public.
Make them public so that Perf mode can pass in its own maps. At the
moment all usages are still hard coded to use the global map, but now
on the caller side.

System ID functions are unchanged because they will always use the
default map.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  |  5 +++--
 .../coresight/coresight-etm3x-core.c          |  5 +++--
 .../coresight/coresight-etm4x-core.c          |  5 +++--
 .../hwtracing/coresight/coresight-trace-id.c  | 22 +++++++------------
 .../hwtracing/coresight/coresight-trace-id.h  |  9 +++++---
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index c0c60e6a1703..4afb9d29f355 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -232,7 +232,7 @@ static void free_event_data(struct work_struct *work)
 		if (!(IS_ERR_OR_NULL(*ppath)))
 			coresight_release_path(*ppath);
 		*ppath = NULL;
-		coresight_trace_id_put_cpu_id(cpu);
+		coresight_trace_id_put_cpu_id(cpu, coresight_trace_id_map_default());
 	}
 
 	/* mark perf event as done for trace id allocator */
@@ -401,7 +401,8 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		}
 
 		/* ensure we can allocate a trace ID for this CPU */
-		trace_id = coresight_trace_id_get_cpu_id(cpu);
+		trace_id = coresight_trace_id_get_cpu_id(cpu,
+							 coresight_trace_id_map_default());
 		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
 			cpumask_clear_cpu(cpu, mask);
 			coresight_release_path(path);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 9d5c1391ffb1..4149e7675ceb 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -465,7 +465,8 @@ int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
 	 *
 	 * trace id function has its own lock
 	 */
-	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu,
+						 coresight_trace_id_map_default());
 	if (IS_VALID_CS_TRACE_ID(trace_id))
 		drvdata->traceid = (u8)trace_id;
 	else
@@ -477,7 +478,7 @@ int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
 
 void etm_release_trace_id(struct etm_drvdata *drvdata)
 {
-	coresight_trace_id_put_cpu_id(drvdata->cpu);
+	coresight_trace_id_put_cpu_id(drvdata->cpu, coresight_trace_id_map_default());
 }
 
 static int etm_enable_perf(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index a0bdfabddbc6..f32c8cd7742d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -241,7 +241,8 @@ int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
 	 * or return the one currently allocated.
 	 * The trace id function has its own lock
 	 */
-	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu,
+						 coresight_trace_id_map_default());
 	if (IS_VALID_CS_TRACE_ID(trace_id))
 		drvdata->trcid = (u8)trace_id;
 	else
@@ -253,7 +254,7 @@ int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
 
 void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
 {
-	coresight_trace_id_put_cpu_id(drvdata->cpu);
+	coresight_trace_id_put_cpu_id(drvdata->cpu, coresight_trace_id_map_default());
 }
 
 struct etm4_enable_arg {
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 19005b5b4dc4..45ddd50d09a6 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -12,7 +12,7 @@
 
 #include "coresight-trace-id.h"
 
-/* Default trace ID map. Used on systems that don't require per sink mappings */
+/* Default trace ID map. Used in sysfs mode and for system sources */
 static struct coresight_trace_id_map id_map_default;
 
 /* maintain a record of the mapping of IDs and pending releases per cpu */
@@ -152,7 +152,7 @@ static void coresight_trace_id_release_all_pending(void)
 	DUMP_ID_MAP(id_map);
 }
 
-static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	unsigned long flags;
 	int id;
@@ -195,8 +195,9 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 	DUMP_ID_MAP(id_map);
 	return id;
 }
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
 
-static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	unsigned long flags;
 	int id;
@@ -222,6 +223,7 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
 }
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
 
 static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
 {
@@ -250,19 +252,11 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 	DUMP_ID_MAP(id_map);
 }
 
-/* API functions */
-
-int coresight_trace_id_get_cpu_id(int cpu)
-{
-	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
-}
-EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
-
-void coresight_trace_id_put_cpu_id(int cpu)
+struct coresight_trace_id_map *coresight_trace_id_map_default(void)
 {
-	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
+	return &id_map_default;
 }
-EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
+EXPORT_SYMBOL_GPL(coresight_trace_id_map_default);
 
 int coresight_trace_id_read_cpu_id(int cpu)
 {
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
index 49438a96fcc6..54b9d8ed903b 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.h
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -42,7 +42,10 @@
 #define IS_VALID_CS_TRACE_ID(id)	\
 	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
 
-/* Allocate and release IDs for a single default trace ID map */
+/**
+ * Get the global map that's used by sysfs
+ */
+struct coresight_trace_id_map *coresight_trace_id_map_default(void);
 
 /**
  * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
@@ -57,7 +60,7 @@
  *
  * return: CoreSight trace ID or -EINVAL if allocation impossible.
  */
-int coresight_trace_id_get_cpu_id(int cpu);
+int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
 
 /**
  * Release an allocated trace ID associated with the CPU.
@@ -70,7 +73,7 @@ int coresight_trace_id_get_cpu_id(int cpu);
  *
  * @cpu: The CPU index to release the associated trace ID.
  */
-void coresight_trace_id_put_cpu_id(int cpu);
+void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
 
 /**
  * Read the current allocated CoreSight Trace ID value for the CPU.
-- 
2.34.1


