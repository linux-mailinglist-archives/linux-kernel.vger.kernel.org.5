Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950DA7B8D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbjJDTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjJDTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:24 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183B173F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:03:15 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 70FD2D08BFFB; Wed,  4 Oct 2023 12:03:02 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 1/4] mm/ksm: add ksm advisor
Date:   Wed,  4 Oct 2023 12:02:46 -0700
Message-Id: <20231004190249.829015-2-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231004190249.829015-1-shr@devkernel.io>
References: <20231004190249.829015-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
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
- to avoid to spend too much CPU

The respective parameters are:
- ksm_advisor_target_scan_time (how many seconds a scan should take)
- ksm_advisor_min_pages (minimum value for pages_to_scan per batch)
- ksm_advisor_max_pages (maximum valoe for pages_to_scan per batch)

The algorithm calculates the change value based on the target scan time
and the previous scan time. To avoid pertubations an exponentially
weighted moving average is applied.

By default the advisor is disabled. Currently there are two advisors:
none and scan_time.

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
 mm/ksm.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 7efcc68ccc6e..c9edfb293024 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -248,6 +248,9 @@ static struct kmem_cache *rmap_item_cache;
 static struct kmem_cache *stable_node_cache;
 static struct kmem_cache *mm_slot_cache;
=20
+/* Default number of pages to scan per batch */
+#define DEFAULT_PAGES_TO_SCAN 100
+
 /* The number of pages scanned */
 static unsigned long ksm_pages_scanned;
=20
@@ -276,7 +279,7 @@ static unsigned int ksm_stable_node_chains_prune_mill=
isecs =3D 2000;
 static int ksm_max_page_sharing =3D 256;
=20
 /* Number of pages ksmd should scan in one batch */
-static unsigned int ksm_thread_pages_to_scan =3D 100;
+static unsigned int ksm_thread_pages_to_scan =3D DEFAULT_PAGES_TO_SCAN;
=20
 /* Milliseconds ksmd should sleep between batches */
 static unsigned int ksm_thread_sleep_millisecs =3D 20;
@@ -297,6 +300,129 @@ unsigned long ksm_zero_pages;
 /* The number of pages that have been skipped due to "smart scanning" */
 static unsigned long ksm_pages_skipped;
=20
+/* At least scan this many pages per batch. */
+static unsigned long ksm_advisor_min_pages =3D 500;
+
+/* Don't scan more than max pages per batch. */
+static unsigned long ksm_advisor_max_pages =3D 5000;
+
+/* Target scan time in seconds to analyze all KSM candidate pages. */
+static unsigned long ksm_advisor_target_scan_time =3D 200;
+
+/* Exponentially weighted moving average. */
+#define EWMA_WEIGHT 50
+
+/**
+ * struct advisor_ctx - metadata for KSM advisor
+ * @start_scan: start time of the current scan
+ * @scan_time: scan time of previous scan
+ * @change: change in percent to pages_to_scan parameter
+ */
+struct advisor_ctx {
+	ktime_t start_scan;
+	s64 scan_time;
+	unsigned long change;
+};
+static struct advisor_ctx advisor_ctx;
+
+/* Define different advisor's */
+enum ksm_advisor_type {
+	KSM_ADVISOR_NONE,
+	KSM_ADVISOR_FIRST =3D KSM_ADVISOR_NONE,
+	KSM_ADVISOR_SCAN_TIME,
+	KSM_ADVISOR_LAST =3D KSM_ADVISOR_SCAN_TIME
+};
+static enum ksm_advisor_type ksm_advisor;
+
+static void init_advisor(void)
+{
+	advisor_ctx.start_scan =3D 0;
+	advisor_ctx.scan_time =3D 0;
+	advisor_ctx.change =3D 0;
+}
+
+/*
+ * Use previous scan time if available, otherwise use current scan time =
as an
+ * approximation for the previous scan time.
+ */
+static inline s64 prev_scan_time(struct advisor_ctx *ctx, s64 new_scan_t=
ime)
+{
+	return ctx->scan_time ? ctx->scan_time : new_scan_time;
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
+static void scan_time_advisor(s64 scan_time)
+{
+	unsigned long pages;
+	unsigned long factor;
+	unsigned long change;
+	unsigned long last_scan_time;
+
+	pages		=3D ksm_thread_pages_to_scan;
+	last_scan_time	=3D prev_scan_time(&advisor_ctx, scan_time);
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
+	pages =3D pages * 100 / factor;
+	/* Update pages_to_scan by weighted change percentage. */
+	pages =3D pages * change / 100;
+
+	/* Cap new pages_to_scan value */
+	pages =3D max(pages, ksm_advisor_min_pages);
+	pages =3D min(pages, ksm_advisor_max_pages);
+
+	/* Update advisor context */
+	advisor_ctx.change =3D change;
+	advisor_ctx.scan_time =3D scan_time;
+	ksm_thread_pages_to_scan =3D pages;
+}
+
+static void run_advisor(void)
+{
+	if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME) {
+		s64 scan_time;
+
+		/* Convert scan time to seconds */
+		scan_time =3D ktime_ms_delta(ktime_get(), advisor_ctx.start_scan);
+		scan_time /=3D MSEC_PER_SEC;
+		scan_time =3D scan_time ? scan_time : 1;
+
+		scan_time_advisor(scan_time);
+	}
+}
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes =3D 1;
@@ -2401,6 +2527,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
=20
 	mm_slot =3D ksm_scan.mm_slot;
 	if (mm_slot =3D=3D &ksm_mm_head) {
+		advisor_ctx.start_scan =3D ktime_get();
 		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
=20
 		/*
@@ -2558,6 +2685,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
 	if (mm_slot !=3D &ksm_mm_head)
 		goto next_mm;
=20
+	run_advisor();
+
 	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
 	ksm_scan.seqnr++;
 	return NULL;
@@ -3603,6 +3732,7 @@ static int __init ksm_init(void)
 	zero_checksum =3D calc_checksum(ZERO_PAGE(0));
 	/* Default to false for backwards compatibility */
 	ksm_use_zero_pages =3D false;
+	init_advisor();
=20
 	err =3D ksm_slab_init();
 	if (err)
--=20
2.39.3

