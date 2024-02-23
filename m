Return-Path: <linux-kernel+bounces-77799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF4860A62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5997D1F232E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21D11CB3;
	Fri, 23 Feb 2024 05:44:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74111C84
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667068; cv=none; b=G+Q9pOsjGYCl0RyYJG0etK4Kp8eaLNL853pp43Z8niA8UtotSLQbmCAJqJNxh9IMSMBEsEH5gulLI3R4E6iR6ATW889Vt73hdrByjD1M9yJRMNrGZ4B5qqn8qhSRzi9p7zZH/cakyfIouoDkAi2F3oLOCQOqQLDXV+aQK+7SoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667068; c=relaxed/simple;
	bh=4LEuQQB1eR8zzmi6MlgQubzexs4s2xBGL1l68LXun8s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=R8qSs8Veq6qYwK31fXuFGpr0KIKfy6PZm+8MVgp95X1ENYZOFVhY6TcQ4YnRusr+VlEnBrF1DGnSZm0fsYmomfhTvZRdiZVADtFrLHLO0DlkVrD3GnMEedVHEylBcVTmEZwbAcoR3BaV349h+uA/Ku7tS31FiUSeO5sX2C3i9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-a5-65d830b2bc15
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	yuzhao@google.com,
	ying.huang@intel.com
Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
Date: Fri, 23 Feb 2024 14:44:07 +0900
Message-Id: <20240223054407.14829-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsXC9ZZnoe4mgxupBl9blSzmrF/DZnF51xw2
	i3tr/rNanJw1mcXi3YQvrA6sHgs2lXos3vOSyWPTp0nsHidm/Gbx+LxJLoA1issmJTUnsyy1
	SN8ugStj3dF9rAUnjCqezvvI3MB4S62LkZNDQsBE4mV3IyuMfWjKL0YQm01AXeLGjZ/MILaI
	gKzE1L/nWUBsZoE6ieX/PoLFhQUCJd7cWQrWyyKgKvHz9lywXl4BU4nO5j4WiJnyEqs3HACq
	5wKyT7JKXJm/kR0iISlxcMUNlgmM3AsYGVYxCmXmleUmZuaY6GVU5mVW6CXn525iBAbCsto/
	0TsYP10IPsQowMGoxMNbkHg9VYg1say4MvcQowQHs5IIL0v5lVQh3pTEyqrUovz4otKc1OJD
	jNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjBvuLt5VE8b2d0/iuU+Tgksa+aQM2xd0
	PNO3ywppCHhgp9v+4KCVervGr5d6lxTy9unlFJ65wOVTudWX69r2z5FWjx4drT8f92xNd4Xi
	MeYv+5gf5qRuXVV8ZkvGkjPXShbva3ZUKlv575D6E7kWjdT2jqeMZSoBJfzJ6d3K86YdMWE5
	NXOljhJLcUaioRZzUXEiAFKlVn0AAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJMWRmVeSWpSXmKPExsXC5WfdrLvJ4EaqQedfLos569ewWRyee5LV
	4vKuOWwW99b8Z7U4OWsyi8W7CV9YHdg8Fmwq9Vi85yWTx6ZPk9g9Tsz4zeKx+MUHJo/Pm+QC
	2KK4bFJSczLLUov07RK4MtYd3cdacMKo4um8j8wNjLfUuhg5OSQETCQOTfnFCGKzCahL3Ljx
	kxnEFhGQlZj69zwLiM0sUCex/N9HsLiwQKDEmztLWUFsFgFViZ+354L18gqYSnQ297FAzJSX
	WL3hAPMERo4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAv26rPbPxB2MXy67H2IU4GBU
	4uEtSLyeKsSaWFZcmXuIUYKDWUmEl6X8SqoQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w1AQh
	gfTEktTs1NSC1CKYLBMHp1QD47lHS198ffNu7cx3l0NljpV2OIZs9v46V9vL0rj7kIPz7S67
	hurvX17mHWYpYHu8TeO80h6+SLP8R0e4Gkq5Dgs5la/ICe2YFD9d05Tbtl4kYbGf6yRXya1L
	dNsZogPvP5grwhd2qbCw/cPc5PKfPXfXljxf1tMVsuBTJ48M7/XV9TdUWzUKlViKMxINtZiL
	ihMBAND6VucBAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v2:
	1. Change the condition to stop cache_trim_mode.

	   From - Stop it if it's at high scan priorities, 0 or 1.
	   To   - Stop it if it's at high scan priorities, 0 or 1, and
	          the mode didn't work in the previous turn.

	   (feedbacked by Huang Ying)

	2. Change the test result in the commit message after testing
	   with the new logic.

Changes from v1:
	1. Add a comment describing why this change is necessary in code
	   and rewrite the commit message with how to reproduce and what
	   the result is using vmstat. (feedbacked by Andrew Morton and
	   Yu Zhao)
	2. Change the condition to avoid cache_trim_mode from
	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
	   where the priority goes to zero all the way. (feedbacked by
	   Yu Zhao)

--->8---
From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Fri, 23 Feb 2024 13:47:16 +0900
Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work

With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
pages.  However, it should be more careful to turn on the mode because
it's going to prevent anon pages from being reclaimed even if there are
a huge number of anon pages that are cold and should be reclaimed.  Even
worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
stopping kswapd from functioning until direct reclaim eventually works
to resume kswapd.

So do not turn on cache_trim_mode if the mode doesn't work, especially
while the sytem is struggling against reclaim.

The problematic behavior can be reproduced by:

   CONFIG_NUMA_BALANCING enabled
   sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
   numa node0 (8GB local memory, 16 CPUs)
   numa node1 (8GB slow tier memory, no CPUs)

   Sequence:

   1) echo 3 > /proc/sys/vm/drop_caches
   2) To emulate the system with full of cold memory in local DRAM, run
      the following dummy program and never touch the region:

         mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);

   3) Run any memory intensive work e.g. XSBench.
   4) Check if numa balancing is working e.i. promotion/demotion.
   5) Iterate 1) ~ 4) until numa balancing stops.

With this, you could see that promotion/demotion are not working because
kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.

Interesting vmstat delta's differences between before and after are like:

   +-----------------------+-------------------------------+
   | interesting vmstat	   | before	   | after	   |
   +-----------------------+-------------------------------+
   | nr_inactive_anon	   | 321935	   | 1636737	   |
   | nr_active_anon	   | 1780700	   | 465913	   |
   | nr_inactive_file	   | 30425	   | 35711	   |
   | nr_active_file	   | 14961	   | 8698	   |
   | pgpromote_success	   | 356	   | 1267785	   |
   | pgpromote_candidate   | 21953245	   | 1745631	   |
   | pgactivate		   | 1844523	   | 3309867	   |
   | pgdeactivate	   | 50634	   | 1545041	   |
   | pgfault		   | 31100294	   | 6411036	   |
   | pgdemote_kswapd	   | 30856	   | 2267467	   |
   | pgscan_kswapd	   | 1861981	   | 7729231	   |
   | pgscan_anon	   | 1822930	   | 7667544	   |
   | pgscan_file	   | 39051	   | 61687	   |
   | pgsteal_anon	   | 386	   | 2227217	   |
   | pgsteal_file	   | 30470	   | 40250	   |
   | pageoutrun		   | 30		   | 457	   |
   | numa_hint_faults	   | 27418279	   | 2752289	   |
   | numa_pages_migrated   | 356	   | 1267785 	   |
   +-----------------------+-------------------------------+

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/vmscan.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..f7312d831fed 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -127,6 +127,9 @@ struct scan_control {
 	/* One of the zones is ready for compaction */
 	unsigned int compaction_ready:1;
 
+	/* If the last try was reclaimable */
+	unsigned int reclaimable:1;
+
 	/* There is easily reclaimable cold cache in the current node */
 	unsigned int cache_trim_mode:1;
 
@@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * If we have plenty of inactive file pages that aren't
 	 * thrashing, try to reclaim those first before touching
 	 * anonymous pages.
+	 *
+	 * It doesn't make sense to keep cache_trim_mode on if the mode
+	 * is not working while struggling against reclaim. So do not
+	 * turn it on if so. Note the highest priority of kswapd is 1.
 	 */
 	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
+	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
 		sc->cache_trim_mode = 1;
 	else
 		sc->cache_trim_mode = 0;
@@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
 	struct lruvec *target_lruvec;
-	bool reclaimable = false;
 
 	if (lru_gen_enabled() && root_reclaim(sc)) {
 		lru_gen_shrink_node(pgdat, sc);
@@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	nr_reclaimed = sc->nr_reclaimed;
 	nr_scanned = sc->nr_scanned;
 
+	/*
+	 * Reset to the default values at the start.
+	 */
+	if (sc->priority == DEF_PRIORITY) {
+		sc->reclaimable = 1;
+		sc->cache_trim_mode = 0;
+	}
+
 	prepare_scan_control(pgdat, sc);
 
 	shrink_node_memcgs(pgdat, sc);
@@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
 			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
 
-	if (nr_node_reclaimed)
-		reclaimable = true;
+	sc->reclaimable = !!nr_node_reclaimed;
 
 	if (current_is_kswapd()) {
 		/*
@@ -5965,7 +5979,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * sleep. On reclaim progress, reset the failure counter. A
 	 * successful direct reclaim run will revive a dormant kswapd.
 	 */
-	if (reclaimable)
+	if (sc->reclaimable)
 		pgdat->kswapd_failures = 0;
 }
 
-- 
2.17.1


