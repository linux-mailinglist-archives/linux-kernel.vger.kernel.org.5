Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C898042D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjLDXt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343493AbjLDXtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:49:16 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD1107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:49:21 -0800 (PST)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 41A8F105D3A7B; Mon,  4 Dec 2023 15:49:08 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 1/4] mm/ksm: add ksm advisor
Date:   Mon,  4 Dec 2023 15:49:03 -0800
Message-Id: <20231204234906.1237478-2-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231204234906.1237478-1-shr@devkernel.io>
References: <20231204234906.1237478-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the ksm advisor. The ksm advisor automatically manages the
pages_to_scan setting to achieve a target scan time. The target scan
time defines how many seconds it should take to scan all the candidate
KSM pages. In other words the pages_to_scan rate is changed by the
advisor to achieve the target scan time. The algorithm has a max and min
value to:
- guarantee responsiveness to changes
- limit CPU resource consumption

The respective parameters are:
- ksm_advisor_target_scan_time (how many seconds a scan should take)
- ksm_advisor_max_cpu (maximum value for cpu percent usage)

- ksm_advisor_min_pages (minimum value for pages_to_scan per batch)
- ksm_advisor_max_pages (maximum value for pages_to_scan per batch)

The algorithm calculates the change value based on the target scan time
and the previous scan time. To avoid pertubations an exponentially
weighted moving average is applied.

The advisor is managed by two main parameters: target scan time,
cpu max time for the ksmd background thread. These parameters determine
how aggresive ksmd scans.

In addition there are min and max values for the pages_to_scan parameter
to make sure that its initial and max values are not set too low or too
high. This ensures that it is able to react to changes quickly enough.

The default values are:
- target scan time: 200 secs
- max cpu: 70%
- min pages: 500
- max pages: 30000

By default the advisor is disabled. Currently there are two advisors:
none and scan-time.

Tests with various workloads have shown considerable CPU savings. Most
of the workloads I have investigated have more candidate pages during
startup, once the workload is stable in terms of memory, the number of
candidate pages is reduced. Without the advisor, the pages_to_scan needs
to be sized for the maximum number of candidate pages. So having this
advisor definitely helps in reducing CPU consumption.

For the instagram workload, the advisor achieves a 25% CPU reduction.
Once the memory is stable, the pages_to_scan parameter gets reduced to
about 40% of its max value.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 7efcc68ccc6ea..b27010fa2e946 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
+#include <linux/sched/cputime.h>
 #include <linux/rwsem.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
@@ -248,6 +249,9 @@ static struct kmem_cache *rmap_item_cache;
 static struct kmem_cache *stable_node_cache;
 static struct kmem_cache *mm_slot_cache;
=20
+/* Default number of pages to scan per batch */
+#define DEFAULT_PAGES_TO_SCAN 100
+
 /* The number of pages scanned */
 static unsigned long ksm_pages_scanned;
=20
@@ -276,7 +280,7 @@ static unsigned int ksm_stable_node_chains_prune_mill=
isecs =3D 2000;
 static int ksm_max_page_sharing =3D 256;
=20
 /* Number of pages ksmd should scan in one batch */
-static unsigned int ksm_thread_pages_to_scan =3D 100;
+static unsigned int ksm_thread_pages_to_scan =3D DEFAULT_PAGES_TO_SCAN;
=20
 /* Milliseconds ksmd should sleep between batches */
 static unsigned int ksm_thread_sleep_millisecs =3D 20;
@@ -297,6 +301,168 @@ unsigned long ksm_zero_pages;
 /* The number of pages that have been skipped due to "smart scanning" */
 static unsigned long ksm_pages_skipped;
=20
+/* Don't scan more than max pages per batch. */
+static unsigned long ksm_advisor_max_pages =3D 30000;
+
+/* At least scan this many pages per batch. */
+static unsigned long ksm_advisor_min_pages =3D 500;
+
+/* Min CPU for scanning pages per scan */
+static unsigned int ksm_advisor_min_cpu =3D  10;
+
+/* Max CPU for scanning pages per scan */
+static unsigned int ksm_advisor_max_cpu =3D  70;
+
+/* Target scan time in seconds to analyze all KSM candidate pages. */
+static unsigned long ksm_advisor_target_scan_time =3D 200;
+
+/* Exponentially weighted moving average. */
+#define EWMA_WEIGHT 30
+
+/**
+ * struct advisor_ctx - metadata for KSM advisor
+ * @start_scan: start time of the current scan
+ * @scan_time: scan time of previous scan
+ * @change: change in percent to pages_to_scan parameter
+ * @cpu_time: cpu time consumed by the ksmd thread in the previous scan
+ */
+struct advisor_ctx {
+	ktime_t start_scan;
+	unsigned long scan_time;
+	unsigned long change;
+	unsigned long long cpu_time;
+};
+static struct advisor_ctx advisor_ctx;
+
+/* Define different advisor's */
+enum ksm_advisor_type {
+	KSM_ADVISOR_NONE,
+	KSM_ADVISOR_SCAN_TIME,
+};
+static enum ksm_advisor_type ksm_advisor;
+
+static void init_advisor(void)
+{
+	advisor_ctx =3D (const struct advisor_ctx){ 0 };
+}
+
+static void set_advisor_defaults(void)
+{
+	if (ksm_advisor =3D=3D KSM_ADVISOR_NONE)
+		ksm_thread_pages_to_scan =3D DEFAULT_PAGES_TO_SCAN;
+	else if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
+		ksm_thread_pages_to_scan =3D ksm_advisor_min_pages;
+}
+
+static inline void advisor_start_scan(void)
+{
+	if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
+		advisor_ctx.start_scan =3D ktime_get();
+}
+
+static inline s64 advisor_stop_scan(void)
+{
+	return ktime_ms_delta(ktime_get(), advisor_ctx.start_scan);
+}
+
+/*
+ * Use previous scan time if available, otherwise use current scan time =
as an
+ * approximation for the previous scan time.
+ */
+static inline unsigned long prev_scan_time(struct advisor_ctx *ctx,
+					   unsigned long scan_time)
+{
+	return ctx->scan_time ? ctx->scan_time : scan_time;
+}
+
+/* Calculate exponential weighted moving average */
+static unsigned long ewma(unsigned long prev, unsigned long curr)
+{
+	return ((100 - EWMA_WEIGHT) * prev + EWMA_WEIGHT * curr) / 100;
+}
+
+/*
+ * The scan time advisor is based on the current scan rate and the targe=
t
+ * scan rate.
+ *
+ *      new_pages_to_scan =3D pages_to_scan * (scan_time / target_scan_t=
ime)
+ *
+ * To avoid pertubations it calculates a change factor of previous chang=
es.
+ * A new change factor is calculated for each iteration and it uses an
+ * exponentially weighted moving average. The new pages_to_scan value is
+ * multiplied with that change factor:
+ *
+ *      new_pages_to_scan *=3D change facor
+ *
+ * In addition the new pages_to_scan value is capped by the max and min
+ * limits.
+ */
+static void scan_time_advisor(void)
+{
+	unsigned int cpu_percent;
+	unsigned long cpu_time;
+	unsigned long cpu_time_diff;
+	unsigned long cpu_time_diff_ms;
+	unsigned long pages;
+	unsigned long per_page_cost;
+	unsigned long factor;
+	unsigned long change;
+	unsigned long last_scan_time;
+	s64 scan_time;
+
+	/* Convert scan time to seconds */
+	scan_time =3D advisor_stop_scan();
+	scan_time =3D div_s64(scan_time, MSEC_PER_SEC);
+	scan_time =3D scan_time ? scan_time : 1;
+
+	/* Calculate CPU consumption of ksmd background thread */
+	cpu_time =3D task_sched_runtime(current);
+	cpu_time_diff =3D cpu_time - advisor_ctx.cpu_time;
+	cpu_time_diff_ms =3D cpu_time_diff / 1000 / 1000;
+
+	cpu_percent =3D (cpu_time_diff_ms * 100) / (scan_time * 1000);
+	cpu_percent =3D cpu_percent ? cpu_percent : 1;
+	last_scan_time =3D prev_scan_time(&advisor_ctx, scan_time);
+
+	/* Calculate scan time as percentage of target scan time */
+	factor =3D ksm_advisor_target_scan_time * 100 / scan_time;
+	factor =3D factor ? factor : 1;
+
+	/*
+	 * Calculate scan time as percentage of last scan time and use
+	 * exponentially weighted average to smooth it
+	 */
+	change =3D scan_time * 100 / last_scan_time;
+	change =3D change ? change : 1;
+	change =3D ewma(advisor_ctx.change, change);
+
+	/* Calculate new scan rate based on target scan rate. */
+	pages =3D ksm_thread_pages_to_scan * 100 / factor;
+	/* Update pages_to_scan by weighted change percentage. */
+	pages =3D pages * change / 100;
+
+	/* Cap new pages_to_scan value */
+	per_page_cost =3D ksm_thread_pages_to_scan / cpu_percent;
+	per_page_cost =3D per_page_cost ? per_page_cost : 1;
+
+	pages =3D min(pages, per_page_cost * ksm_advisor_max_cpu);
+	pages =3D max(pages, per_page_cost * ksm_advisor_min_cpu);
+	pages =3D min(pages, ksm_advisor_max_pages);
+
+	/* Update advisor context */
+	advisor_ctx.change =3D change;
+	advisor_ctx.scan_time =3D scan_time;
+	advisor_ctx.cpu_time =3D cpu_time;
+
+	ksm_thread_pages_to_scan =3D pages;
+}
+
+static void run_advisor(void)
+{
+	if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
+		scan_time_advisor();
+}
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes =3D 1;
@@ -2401,6 +2567,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
=20
 	mm_slot =3D ksm_scan.mm_slot;
 	if (mm_slot =3D=3D &ksm_mm_head) {
+		advisor_start_scan();
 		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
=20
 		/*
@@ -2558,6 +2725,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
 	if (mm_slot !=3D &ksm_mm_head)
 		goto next_mm;
=20
+	run_advisor();
+
 	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
 	ksm_scan.seqnr++;
 	return NULL;
@@ -3244,6 +3413,9 @@ static ssize_t pages_to_scan_store(struct kobject *=
kobj,
 	unsigned int nr_pages;
 	int err;
=20
+	if (ksm_advisor !=3D KSM_ADVISOR_NONE)
+		return -EINVAL;
+
 	err =3D kstrtouint(buf, 10, &nr_pages);
 	if (err)
 		return -EINVAL;
@@ -3603,6 +3775,7 @@ static int __init ksm_init(void)
 	zero_checksum =3D calc_checksum(ZERO_PAGE(0));
 	/* Default to false for backwards compatibility */
 	ksm_use_zero_pages =3D false;
+	init_advisor();
=20
 	err =3D ksm_slab_init();
 	if (err)
--=20
2.39.3

