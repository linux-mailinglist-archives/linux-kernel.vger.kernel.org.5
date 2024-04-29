Return-Path: <linux-kernel+bounces-162586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FEF8B5DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E111028A615
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4CC128398;
	Mon, 29 Apr 2024 15:26:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084582883;
	Mon, 29 Apr 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404361; cv=none; b=ndnAJjG07ChKotepfom6S1hoEXpYyCpJGfNJu2uDPbFSPrPDn2OyXRQi9aISmKIPfECEzuarWzPMc3gXeEOn6GOih4T5t9UMSItzfXWIlT/gdF5RXbTaffNsTvHHBQpy0PxdSEuwgm0mpEyPtHXefnfSkfoyEy8aGhoyRfG8pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404361; c=relaxed/simple;
	bh=BY6n9m6hXgH2iWNx+qi5D/i24m+z5pSEDrLXeExY00Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnUrAeL+CC/7mB5qhczeyYkXxwBWpuIhaewTBT9Uu8z/QHjWfCvh5qT9y05PLOAzExChAFseaUvNSGqq5Ii2Tk5wTVjkA9cGzWdv7t+/Uvv/nQME0Lj6ZqOPCvf4AUOAk/s8YuVbsgozCUTn07BTaHtM54U6LkT0KSVfN2NLnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3878D2F4;
	Mon, 29 Apr 2024 08:26:26 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6858C3F793;
	Mon, 29 Apr 2024 08:25:56 -0700 (PDT)
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
Subject: [PATCH 17/17] coresight: Emit HW_IDs for all ETMs that are using the sink
Date: Mon, 29 Apr 2024 16:22:03 +0100
Message-Id: <20240429152207.479221-19-james.clark@arm.com>
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

For Perf to be able to decode when per-sink trace IDs are used, emit all
the mappings for each sink.

Perf currently errors out if it sees a newer packet version so instead
of bumping it, add a new minor version field. This can be used to
signify new versions that have backwards compatible fields. Considering
this change is only for high core count machines, it doesn't make sense
to make a breaking change for everyone.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 47 ++++++++++++++++---
 include/linux/coresight-pmu.h                 | 17 +++++--
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 08f3958f9367..3bb1ae1e5264 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -444,6 +444,46 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	goto out;
 }
 
+static void etm_output_hw_ids(struct perf_event *event,
+			      struct coresight_trace_id_map *id_map,
+			      int this_events_cpu)
+{
+	int cpu;
+	u8 this_events_trace_id = coresight_trace_id_read_cpu_id(this_events_cpu, id_map);
+
+	/*
+	 * This isn't optimal because we likely only have a couple of IDs
+	 * allocated per-sink, but we only currently track the used trace IDs as
+	 * a bitmask, rather than the used CPUs in each ID map. It would also
+	 * require some extra locking to iterate a used CPUs bitmask and then
+	 * output the ID from a different structure. So at the moment just
+	 * iterate all CPUs.
+	 */
+	for_each_possible_cpu(cpu) {
+		u64 hw_id;
+		u8 trace_id = coresight_trace_id_read_cpu_id(cpu, id_map);
+
+		if (!IS_VALID_CS_TRACE_ID(trace_id))
+			continue;
+
+		hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
+				   CS_AUX_HW_ID_MAJOR_VERSION);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
+				    CS_AUX_HW_ID_MINOR_VERSION);
+
+		/* Repeat sending the ID for this event so that it's backwards compatible */
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, this_events_trace_id);
+
+		/*
+		 * Output the V0.1 HW_ID info that shows which other ID mappings
+		 * are valid on this sink.
+		 */
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_V01_CPU_MASK, cpu);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_V01_TRACE_ID_MASK, trace_id);
+		perf_report_aux_output_id(event, hw_id);
+	}
+}
+
 static void etm_event_start(struct perf_event *event, int flags)
 {
 	int cpu = smp_processor_id();
@@ -452,7 +492,6 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = &ctxt->handle;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
-	u64 hw_id;
 
 	if (!csdev)
 		goto fail;
@@ -519,11 +558,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	 */
 	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
 		cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
-		hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
-				   CS_AUX_HW_ID_CURR_VERSION);
-		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
-				    coresight_trace_id_read_cpu_id(cpu, &sink->perf_id_map));
-		perf_report_aux_output_id(event, hw_id);
+		etm_output_hw_ids(event, &sink->perf_id_map, cpu);
 	}
 
 out:
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 51ac441a37c3..4a7fac6f66b9 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -49,12 +49,21 @@
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.
  * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
- * [59:08] - Unused (SBZ)
- * [63:60] - Version
+ * [15:08] - V2 Trace ID - ID for the ETM/CPU referenced by V2 CPU
+ * [31:16] - V2 CPU ID - CPU that corresponds to the trace ID in V2 trace ID
+ * [55:32] - Unused (SBZ)
+ * [59:56] - Minor Version - previously existing fields are compatible with
+ *	      all minor versions.
+ * [63:60] - Major Version - previously existing fields mean different things
+ *	      in new major versions.
  */
 #define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
-#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+#define CS_AUX_HW_ID_V01_TRACE_ID_MASK	GENMASK_ULL(15, 8)
+#define CS_AUX_HW_ID_V01_CPU_MASK	GENMASK_ULL(31, 16)
+#define CS_AUX_HW_ID_MINOR_VERSION_MASK	GENMASK_ULL(59, 56)
+#define CS_AUX_HW_ID_MAJOR_VERSION_MASK	GENMASK_ULL(63, 60)
 
-#define CS_AUX_HW_ID_CURR_VERSION 0
+#define CS_AUX_HW_ID_MAJOR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION 1
 
 #endif
-- 
2.34.1


