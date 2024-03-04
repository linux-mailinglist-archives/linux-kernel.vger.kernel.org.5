Return-Path: <linux-kernel+bounces-89972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4D86F864
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5239E2811C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6215B7;
	Mon,  4 Mar 2024 02:09:32 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3081362
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709518172; cv=none; b=fcHxh2rn/0tlprBVwzsmYjQcQc0lgd1y3RG9FM4pLwG5rl6KtpHywNcIBQXSYzP5zxiOHCudnNvGo4u6HC7zsTOXbahT6oz4S3QUV4A+J1s0Et14RM9kRi5Gr+Y7CpwIJdOu6NSoBIxDk+Why993AI4skZ+vuShcZQaivT6W9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709518172; c=relaxed/simple;
	bh=gyklvR6hOXB+p6+UWmYoLJpEOG57VKnMc6aK/JZ5YCU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LTgKZJVIxvAT37hP7994cfKr3BBvCJe3R3LkqqURpCnD3tDYu9Jkyg3X+aQ1SnJVWMpsGEjzDxPn3fUGj3cqu+lrRruUz/5lLnsJq1ZXE5wC9ZaIbWEwhV/6AdzXkumj73vlobpR5kH6L39LuTb+nooS5r2Fj9MoSrQ2pj3XEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-08-65e52d4db49e
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	yuzhao@google.com,
	ying.huang@intel.com,
	hannes@cmpxchg.org
Subject: [PATCH v4] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
Date: Mon,  4 Mar 2024 11:09:07 +0900
Message-Id: <20240304020907.12514-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJMWRmVeSWpSXmKPExsXC9ZZnka6v7tNUg7ZeVYs569ewWaze5Gtx
	edccNot7a/6zWpycNZnF4t2EL6wObB6H37xn9liwqdRj8Z6XTB6bPk1i9zgx4zeLx+dNcgFs
	UVw2Kak5mWWpRfp2CVwZHWf3MRbs1qtY9vYYUwPjF8UuRk4OCQETif+zf7DD2Of7LzGC2GwC
	6hI3bvxkBrFFBGQlpv49z9LFyMXBLDCFUWLFvXY2kISwQILEhavXwWwWAVWJ6/d2gtm8AqYS
	J55OgBoqL7F6wwFmkGYJgZusEvdOtrJAJCQlDq64wTKBkXsBI8MqRqHMvLLcxMwcE72MyrzM
	Cr3k/NxNjMDgWFb7J3oH46cLwYcYBTgYlXh4MzqfpAqxJpYVV+YeYpTgYFYS4a35BRTiTUms
	rEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAuHpRYMuheVUXU5/0
	7YvdmTOX3fXqi2lc4RYVH5duTY624nQoff3wzwVWR8H0rP5mwxOfXjHu0HB5LheVJlRhflD4
	1Rz2bI3Y39MFbq55tvSOw/cZJT8XLAostMzZc2jDsr93n4muW7+lLMFi68qcAP5svQO3f5vl
	WLN894ib77/gYWG54JcCOyWW4oxEQy3mouJEAIE4UioKAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJMWRmVeSWpSXmKPExsXC5WfdrOur+zTV4EmTpMWc9WvYLFZv8rU4
	PPckq8XlXXPYLO6t+c9qcXLWZBaLdxO+sDqwexx+857ZY8GmUo/Fe14yeWz6NInd48SM3ywe
	i198YPL4vEkugD2KyyYlNSezLLVI3y6BK6Pj7D7Ggt16FcveHmNqYPyi2MXIySEhYCJxvv8S
	I4jNJqAucePGT2YQW0RAVmLq3/MsXYxcHMwCUxglVtxrZwNJCAskSFy4eh3MZhFQlbh+byeY
	zStgKnHi6QR2iKHyEqs3HGCewMixgJFhFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRqCvl9X+
	mbiD8ctl90OMAhyMSjy8E9Y8SRViTSwrrsw9xCjBwawkwlvzCyjEm5JYWZValB9fVJqTWnyI
	UZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAON/G4BXXp2OX3lzhec5WtuCUdcRG6WM6
	X2cus14hETpBjbNPQuDL1PerZt2oeBATYO7usu26jGRE84W/gWmqa7/ppwg7nA+5KpF76o7V
	Hr/3vKLZZ3itnikwS7+rWTXtwNJeThkDC89QvWCDaR3PK72Xbr/99CErx4Fr36al/Nz+Uurw
	e8aGl0osxRmJhlrMRcWJALGGzI/xAQAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v3:
	1. Update the test result in the commit message with v4.
	2. Retry the whole priority loop with cache_trim_mode off again,
	   rather than forcing the mode off at the highest priority,
	   when the mode doesn't work. (feedbacked by Johannes Weiner)

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
From bd275d8d8e9ed91869401f0e1d089c4a2aeeaac6 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Thu, 29 Feb 2024 19:48:01 +0900
Subject: [PATCH v4] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure

With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
pages.  However, it should be more careful to use the mode because it's
going to prevent anon pages from being reclaimed even if there are a
huge number of anon pages that are cold and should be reclaimed.  Even
worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
stopping kswapd from functioning until direct reclaim eventually works
to resume kswapd.

So kswapd needs to retry its scan priority loop with cache_trim_mode
off again if the mode doesn't work for reclaim.

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
   | interesting vmstat    | before        | after         |
   +-----------------------+-------------------------------+
   | nr_inactive_anon      | 321935        | 1646193       |
   | nr_active_anon        | 1780700       | 456388        |
   | nr_inactive_file      | 30425         | 27836         |
   | nr_active_file        | 14961         | 1217          |
   | pgpromote_success     | 356           | 1310120       |
   | pgpromote_candidate   | 21953245      | 1736872       |
   | pgactivate            | 1844523       | 3292443       |
   | pgdeactivate          | 50634         | 1526701       |
   | pgfault               | 31100294      | 6715375       |
   | pgdemote_kswapd       | 30856         | 1954199       |
   | pgscan_kswapd         | 1861981       | 7100099       |
   | pgscan_anon           | 1822930       | 7061135       |
   | pgscan_file           | 39051         | 38964         |
   | pgsteal_anon          | 386           | 1925214       |
   | pgsteal_file          | 30470         | 28985         |
   | pageoutrun            | 30            | 500           |
   | numa_hint_faults      | 27418279      | 3090773       |
   | numa_pages_migrated   | 356           | 1310120       |
   +-----------------------+-------------------------------+

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/vmscan.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..7ec1fbcba7d4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -108,6 +108,9 @@ struct scan_control {
 	/* Can folios be swapped as part of reclaim? */
 	unsigned int may_swap:1;
 
+	/* Can cache_trim_mode be turned on as part of reclaim? */
+	unsigned int may_cache_trim_mode:1;
+
 	/* Proactive reclaim invoked by userspace through memory.reclaim */
 	unsigned int proactive:1;
 
@@ -2268,7 +2271,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * anonymous pages.
 	 */
 	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
+	    sc->may_cache_trim_mode)
 		sc->cache_trim_mode = 1;
 	else
 		sc->cache_trim_mode = 0;
@@ -6744,6 +6748,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
 		.may_unmap = 1,
+		.may_cache_trim_mode = 1,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
@@ -6898,8 +6903,14 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 			sc.priority--;
 	} while (sc.priority >= 1);
 
-	if (!sc.nr_reclaimed)
+	if (!sc.nr_reclaimed) {
+		if (sc.may_cache_trim_mode) {
+			sc.may_cache_trim_mode = 0;
+			goto restart;
+		}
+
 		pgdat->kswapd_failures++;
+	}
 
 out:
 	clear_reclaim_active(pgdat, highest_zoneidx);
-- 
2.17.1


