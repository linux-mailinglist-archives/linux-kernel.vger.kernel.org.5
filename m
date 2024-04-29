Return-Path: <linux-kernel+bounces-162584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF708B5DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21C51F24232
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26160127E01;
	Mon, 29 Apr 2024 15:25:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB724127B5C;
	Mon, 29 Apr 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404346; cv=none; b=Ofs6mhTX5jsT1zNMsTdb7kW477fS3k9oSWudh/ki9Hhmki9EI5/TehXQWoahm+PptyPZM/YCWUFjHrlW9S2OsyDxIpFWKHSoZNqvRC6vJ8/EFPvdO+DKTaGYvAK0DH15w92YH0436/yx864gdPNw8+nvWSlYJgFmXd0ssPQEelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404346; c=relaxed/simple;
	bh=NsvCoPbsqlmPPebItydpSG8dCdPmQJVoXNjPyCpJf5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNIvFOBS86u7vHt7Vgzm6HqKjsY1v5b8BsHiDCluW+oAvxkWqrmyaT/BRIPltJk5l3Wuxhe5rnogeBxi1xA3lsAer0kdlJ4JERQm8PEcSausNysuIgVATQrcW6Y9EBt5iErfidtMduxSqSRmDf8gZDpG5dxhiVpTp25JP9RNQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0D152F4;
	Mon, 29 Apr 2024 08:26:10 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 204D93F793;
	Mon, 29 Apr 2024 08:25:41 -0700 (PDT)
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
Subject: [PATCH 15/17] coresight: Remove pending trace ID release mechanism
Date: Mon, 29 Apr 2024 16:22:01 +0100
Message-Id: <20240429152207.479221-17-james.clark@arm.com>
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

Pending the release of IDs was a way of managing concurrent sysfs and
Perf sessions in a single global ID map. Perf may have finished while
sysfs hadn't, and Perf shouldn't release the IDs in use by sysfs and
vice versa.

Now that Perf uses its own exclusive ID maps, pending release doesn't
result in any different behavior than just releasing all IDs when the
last Perf session finishes. As part of the per-sink trace ID change, we
would have still had to make the pending mechanism work on a per-sink
basis, due to the overlapping ID allocations, so instead of making that
more complicated, just remove it.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 11 ++--
 .../hwtracing/coresight/coresight-trace-id.c  | 62 +++++--------------
 .../hwtracing/coresight/coresight-trace-id.h  | 31 +++++-----
 include/linux/coresight.h                     |  6 +-
 4 files changed, 34 insertions(+), 76 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 86ca1a9d09a7..f07173aa4d66 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -232,15 +232,14 @@ static void free_event_data(struct work_struct *work)
 		if (!(IS_ERR_OR_NULL(*ppath))) {
 			struct coresight_device *sink = coresight_get_sink(*ppath);
 
-			coresight_trace_id_put_cpu_id(cpu, &sink->perf_id_map);
+			/* mark perf event as done for trace id allocator */
+			coresight_trace_id_perf_stop(&sink->perf_id_map);
+
 			coresight_release_path(*ppath);
 		}
 		*ppath = NULL;
 	}
 
-	/* mark perf event as done for trace id allocator */
-	coresight_trace_id_perf_stop();
-
 	free_percpu(event_data->path);
 	kfree(event_data);
 }
@@ -328,9 +327,6 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
 
-	/* tell the trace ID allocator that a perf event is starting up */
-	coresight_trace_id_perf_start();
-
 	/* check if user wants a coresight configuration selected */
 	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
 	if (cfg_hash) {
@@ -404,6 +400,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		}
 
 		/* ensure we can allocate a trace ID for this CPU */
+		coresight_trace_id_perf_start(&sink->perf_id_map);
 		trace_id = coresight_trace_id_get_cpu_id(cpu, &sink->perf_id_map);
 		if (!IS_VALID_CS_TRACE_ID(trace_id)) {
 			cpumask_clear_cpu(cpu, mask);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index b393603dd713..84721706b4a4 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -18,12 +18,6 @@ static struct coresight_trace_id_map id_map_default = {
 	.cpu_map = &id_map_default_cpu_ids
 };
 
-/* maintain a record of the pending releases per cpu */
-static cpumask_t cpu_id_release_pending;
-
-/* perf session active counter */
-static atomic_t perf_cs_etm_session_active = ATOMIC_INIT(0);
-
 /* lock to protect id_map and cpu data  */
 static DEFINE_SPINLOCK(id_map_lock);
 
@@ -116,34 +110,18 @@ static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_ma
 	clear_bit(id, id_map->used_ids);
 }
 
-static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
-{
-	if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
-		return;
-	set_bit(id, id_map->pend_rel_ids);
-}
-
 /*
- * release all pending IDs for all current maps & clear CPU associations
- *
- * This currently operates on the default id map, but may be extended to
- * operate on all registered id maps if per sink id maps are used.
+ * release all IDs and clear CPU associations
  */
-static void coresight_trace_id_release_all_pending(void)
+static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map)
 {
-	struct coresight_trace_id_map *id_map = &id_map_default;
 	unsigned long flags;
-	int cpu, bit;
+	int cpu;
 
 	spin_lock_irqsave(&id_map_lock, flags);
-	for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_ID_RES_TOP) {
-		clear_bit(bit, id_map->used_ids);
-		clear_bit(bit, id_map->pend_rel_ids);
-	}
-	for_each_cpu(cpu, &cpu_id_release_pending) {
-		atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
-		cpumask_clear_cpu(cpu, &cpu_id_release_pending);
-	}
+	bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
+	for_each_possible_cpu(cpu)
+		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 	spin_unlock_irqrestore(&id_map_lock, flags);
 	DUMP_ID_MAP(id_map);
 }
@@ -158,7 +136,7 @@ int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map
 	/* check for existing allocation for this CPU */
 	id = coresight_trace_id_read_cpu_id(cpu, id_map);
 	if (id)
-		goto get_cpu_id_clr_pend;
+		goto get_cpu_id_out_unlock;
 
 	/*
 	 * Find a new ID.
@@ -179,11 +157,6 @@ int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map
 	/* allocate the new id to the cpu */
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
-get_cpu_id_clr_pend:
-	/* we are (re)using this ID - so ensure it is not marked for release */
-	cpumask_clear_cpu(cpu, &cpu_id_release_pending);
-	clear_bit(id, id_map->pend_rel_ids);
-
 get_cpu_id_out_unlock:
 	spin_unlock_irqrestore(&id_map_lock, flags);
 
@@ -205,15 +178,8 @@ void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_ma
 
 	spin_lock_irqsave(&id_map_lock, flags);
 
-	if (atomic_read(&perf_cs_etm_session_active)) {
-		/* set release at pending if perf still active */
-		coresight_trace_id_set_pend_rel(id, id_map);
-		cpumask_set_cpu(cpu, &cpu_id_release_pending);
-	} else {
-		/* otherwise clear id */
-		coresight_trace_id_free(id, id_map);
-		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
-	}
+	coresight_trace_id_free(id, id_map);
+	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 
 	spin_unlock_irqrestore(&id_map_lock, flags);
 	DUMP_ID_CPU(cpu, id);
@@ -272,17 +238,17 @@ void coresight_trace_id_put_system_id(int id)
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
 
-void coresight_trace_id_perf_start(void)
+void coresight_trace_id_perf_start(struct coresight_trace_id_map *id_map)
 {
-	atomic_inc(&perf_cs_etm_session_active);
+	atomic_inc(&id_map->perf_cs_etm_session_active);
 	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
 
-void coresight_trace_id_perf_stop(void)
+void coresight_trace_id_perf_stop(struct coresight_trace_id_map *id_map)
 {
-	if (!atomic_dec_return(&perf_cs_etm_session_active))
-		coresight_trace_id_release_all_pending();
+	if (!atomic_dec_return(&id_map->perf_cs_etm_session_active))
+		coresight_trace_id_release_all(id_map);
 	PERF_SESSION(atomic_read(&perf_cs_etm_session_active));
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
index ed2bc4b3ad2a..409713901f21 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.h
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -17,9 +17,10 @@
  * released when done.
  *
  * In order to ensure that a consistent cpu / ID matching is maintained
- * throughout a perf cs_etm event session - a session in progress flag will
- * be maintained, and released IDs not cleared until the perf session is
- * complete. This allows the same CPU to be re-allocated its prior ID.
+ * throughout a perf cs_etm event session - a session in progress flag will be
+ * maintained for each sink, and IDs are cleared when all the perf sessions
+ * complete. This allows the same CPU to be re-allocated its prior ID when
+ * events are scheduled in and out.
  *
  *
  * Trace ID maps will be created and initialised to prevent architecturally
@@ -65,11 +66,7 @@ int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map
 /**
  * Release an allocated trace ID associated with the CPU.
  *
- * This will release the CoreSight trace ID associated with the CPU,
- * unless a perf session is in operation.
- *
- * If a perf session is in operation then the ID will be marked as pending
- * release.
+ * This will release the CoreSight trace ID associated with the CPU.
  *
  * @cpu: The CPU index to release the associated trace ID.
  */
@@ -120,21 +117,21 @@ void coresight_trace_id_put_system_id(int id);
 /**
  * Notify the Trace ID allocator that a perf session is starting.
  *
- * Increase the perf session reference count - called by perf when setting up
- * a trace event.
+ * Increase the perf session reference count - called by perf when setting up a
+ * trace event.
  *
- * This reference count is used by the ID allocator to ensure that trace IDs
- * associated with a CPU cannot change or be released during a perf session.
+ * Perf sessions never free trace IDs to ensure that the ID associated with a
+ * CPU cannot change during their and other's concurrent sessions. Instead,
+ * this refcount is used so that the last event to finish always frees all IDs.
  */
-void coresight_trace_id_perf_start(void);
+void coresight_trace_id_perf_start(struct coresight_trace_id_map *id_map);
 
 /**
  * Notify the ID allocator that a perf session is stopping.
  *
- * Decrease the perf session reference count.
- * if this causes the count to go to zero, then all Trace IDs marked as pending
- * release, will be released.
+ * Decrease the perf session reference count. If this causes the count to go to
+ * zero, then all Trace IDs will be released.
  */
-void coresight_trace_id_perf_stop(void);
+void coresight_trace_id_perf_stop(struct coresight_trace_id_map *id_map);
 
 #endif /* _CORESIGHT_TRACE_ID_H */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 8c4c1860c76b..4b7719b061f9 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -227,14 +227,12 @@ struct coresight_sysfs_link {
  * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
  *		Initialised so that the reserved IDs are permanently marked as
  *		in use.
- * @pend_rel_ids: CPU IDs that have been released by the trace source but not
- *		  yet marked as available, to allow re-allocation to the same
- *		  CPU during a perf session.
+ * @perf_cs_etm_session_active: Number of Perf sessions using this ID map.
  */
 struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
-	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
 	atomic_t __percpu *cpu_map;
+	atomic_t perf_cs_etm_session_active;
 };
 
 /**
-- 
2.34.1


